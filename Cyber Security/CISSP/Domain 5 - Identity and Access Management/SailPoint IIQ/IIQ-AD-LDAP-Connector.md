---
tags: [iiq, active-directory, ldap, aggregation, connector, correlation, provisioning, cissp, domain-5-iam, cissp/5.5-provisioning-lifecycle]
aliases: [IIQ AD Connector, SailPoint AD Integration, LDAP Aggregation]
---

# IIQ AD/LDAP Connector

[[IIQ-Concepts|SailPoint IIQ]] does not store identities in a vacuum — it reads them from source systems. For most enterprises, [[AD-LDAP-Fundamentals|Active Directory]] is the most important source. This note explains how IIQ connects to AD/LDAP, what it reads, and how that data lands in IIQ's database.

---

## What an IIQ Application Is

In IIQ, an **Application** represents a connection to a single external system — a source of accounts and entitlements. For Active Directory, one Application typically corresponds to one [[AD-Domain-Forest-Trusts|domain]] (or the Global Catalog if reading across domains).

In the database, Applications live in `spt_application`. Key columns:

| Column | What it Stores |
|---|---|
| `name` | Human-readable name, e.g. `"Active Directory - Corp"` |
| `type` | Connector type, e.g. `"Active Directory"` or `"LDAP"` |
| `authoritative` | `1` = this app is a source of truth for identity attributes |
| `features_string` | Comma-separated capabilities: `AUTHENTICATE,PROVISIONING,SYNC` |
| `attributes` | XML blob containing all connector configuration |

> [!note] Authoritative applications
> An authoritative application (usually HR or the primary AD domain) drives identity creation in IIQ. When a new account appears in an authoritative app that has no matching identity, IIQ creates a new identity record. Non-authoritative apps add accounts to existing identities but don't create new ones.


---

## Connector Configuration

The AD connector configuration is stored in `spt_application.attributes` as XML, but conceptually it includes:

| Parameter | What It Controls | Example |
|---|---|---|
| **Host** | Domain controller hostname or IP | `dc01.corp.example.com` |
| **Port** | LDAP port | `389` (plain) or `636` (LDAPS) or `3268` (GC) |
| **Bind DN** | Service account used to query AD | `CN=svc-iiq,OU=ServiceAccounts,DC=corp,...` |
| **Bind Password** | Password for the service account | (encrypted in IIQ) |
| **Base DN** | Where in the DIT to start searching | `DC=corp,DC=example,DC=com` |
| **Object Filter** | LDAP filter to select accounts | `(&(objectClass=user)(!(objectClass=computer)))` |
| **Group Object Filter** | LDAP filter to select groups | `(objectClass=group)` |

> [!tip] Global Catalog port
> Using port **3268** (or 3269 for LDAPS) points IIQ at the Global Catalog, which returns objects from all domains in the forest in a single query. Useful for multi-domain forests where you want one IIQ Application to see everyone. Trade-off: the GC only returns a subset of attributes.

### Multi-Domain Environments

For multi-domain environments, see [[AD-Domain-Forest-Trusts]] for topology rules. In IIQ:

| Topology | Recommended Configuration |
|---|---|
| Single domain | One Application, point at a domain controller |
| Multi-domain, same forest | One Application per domain **or** one Application at GC port 3268 |
| Multi-forest | One Application per forest (or per domain) |

---

## What Gets Aggregated

Aggregation runs as **two separate scans** that answer two different questions:

| Scan | Question it answers | Data perspective | Target table |
|---|---|---|---|
| **Account aggregation** | Who exists and what are they a member of? | User's perspective | `spt_link`, `spt_identity_entitlement` |
| **Group aggregation** | What groups exist and what are their properties? | Group's perspective | `spt_managed_attribute` |

You need both. Account aggregation alone gives you memberships but no metadata about the groups themselves. Group aggregation alone gives you a catalog but no idea who holds what.

> [!warning] Run order dependency
> Group aggregation should run first (or be kept current). When account aggregation processes a user's `memberOf` and tries to write an `spt_identity_entitlement` row, it looks up the corresponding `spt_managed_attribute` record. If the group hasn't been aggregated yet — no catalog row exists — the entitlement may be created as unmanaged or skipped entirely. If you see AD memberships that aren't appearing in `spt_identity_entitlement`, check whether the group exists in `spt_managed_attribute` first.

### 1. Account Aggregation (`spt_link`)

Each user account in AD becomes one row in `spt_link`. Data flows from the **user's perspective** — "here is jsmith, and here are all the groups jsmith belongs to":

| `spt_link` Column | Source in AD |
|---|---|
| `native_identity` | Usually `sAMAccountName` or `distinguishedName` |
| `display_name` | `displayName` |
| `application` | FK to `spt_application.id` |
| `identity_id` | FK to `spt_identity.id` (set after correlation) |
| `attributes` | XML blob containing all aggregated AD attributes |
| `last_refresh` | Timestamp of most recent aggregation |

The `attributes` XML blob on `spt_link` stores every AD attribute IIQ was configured to collect: `sAMAccountName`, `userPrincipalName`, `department`, `memberOf`, `userAccountControl`, etc.

> [!note] Reading spt_link attributes
> Because `attributes` is an XML blob, querying specific AD attributes requires either IIQ's built-in attribute extraction or staging tables. See `staging_tables_generic.sql` in this repo for a pattern that normalises these into queryable columns.

### 2. Group Aggregation (`spt_managed_attribute`)

Each AD security group that IIQ is configured to manage becomes a row in `spt_managed_attribute`. Data flows from the **group's perspective** — "here is Finance_VPN_Group, and here is its description and owner":

| `spt_managed_attribute` Column | Source in AD |
|---|---|
| `attribute` | Always `"memberOf"` for AD groups |
| `value` | The group DN or `sAMAccountName` (connector-dependent) |
| `display_name` | Group's `displayName` or `cn` |
| `type` | `"Entitlement"` |
| `application` | FK to `spt_application.id` |
| `descriptions` | XML blob of group descriptions |
| `requestable` | Whether users can request this group via IIQ LCM |

This table is the **entitlement catalog** — the menu of all possible access IIQ knows about. It answers questions account aggregation cannot: what does this group actually grant? who owns it? can it be requested through IIQ?

---

## Attribute Mapping: AD → IIQ

When IIQ aggregates, it maps AD attributes to IIQ's schema. This mapping is configured in the Application's **schema**:

```
AD Attribute          →  IIQ Account Attribute
─────────────────────────────────────────────────
sAMAccountName        →  name (used as native identity)
displayName           →  displayName
mail                  →  email
department            →  department
userAccountControl    →  IIQ computes "inactive" from this
memberOf              →  drives entitlement population
objectGUID            →  objectGUID (stable correlation key)
```

IIQ uses `objectGUID` as the most reliable correlation key for AD accounts because it never changes, even when accounts are renamed or moved between OUs.

---

## How Group Membership Becomes an Entitlement

This is the bridge between AD groups and IIQ's governance model:

1. IIQ aggregates a user account from AD and reads the `memberOf` attribute
2. For each group DN in `memberOf`, IIQ looks up the corresponding `spt_managed_attribute` record
3. If found, IIQ writes a row to `spt_identity_entitlement` linking the identity to that entitlement
4. The row has `aggregation_state = 'Connected'` and `source = 'Application'`

If a user is removed from a group in AD and IIQ runs aggregation again, the corresponding `spt_identity_entitlement` row gets `aggregation_state = 'Disconnected'` — it is not immediately deleted, which allows IIQ to detect and report on access that was removed outside of IIQ's governance.

See [[AD-Groups-in-IIQ-Governance]] for the full picture of how these entitlements flow into roles, certifications, and provisioning.

---

## Correlation Rules

**Correlation** is the process of matching an aggregated AD account to the correct `spt_identity` record. Without correlation, IIQ cannot associate the AD account "jsmith" with the identity "John Smith" from HR.

Correlation rules are written in BeanShell (Java-like scripting) or configured declaratively. A typical correlation rule for AD:

```java
// Match on employeeNumber: AD's employeeID = HR's employee number
String empId = account.getAttribute("employeeID");
if (empId != null) {
    return "employeeNumber == '" + empId + "'";
}
// Fallback: match on email
String email = account.getAttribute("mail");
if (email != null) {
    return "email == '" + email + "'";
}
return null; // No match found — account becomes uncorrelated
```

| Correlation Outcome | Result |
|---|---|
| Match found | `spt_link.identity_id` is set; `spt_identity.correlated = 1` |
| No match found | Account stays uncorrelated; identity cube shows it as orphan |
| Multiple matches | Ambiguous — IIQ logs an error; manual resolution needed |

> [!warning] Uncorrelated accounts
> Uncorrelated accounts are a risk: IIQ cannot govern access it cannot attribute to a person. Regular orphan account cleanup is a key IAM hygiene task. See [[AD-Groups-in-IIQ-Governance]] for the SQL to find them.

---

## Full vs. Delta Aggregation

IIQ supports two aggregation modes for AD:

### Full Aggregation
- Reads every object matching the configured filter
- Compares against what IIQ already has
- Detects additions, removals, and changes
- Slow for large directories (tens of thousands of accounts)
- Typically scheduled weekly or monthly

### Delta Aggregation (Recommended for AD)
- Uses Microsoft's **DirSync** protocol by default to detect only objects modified since the last sync
- IIQ stores a DirSync cookie per domain after each run; the next delta reads only changes since that cookie
- Fast — only processes genuinely changed objects
- Typically scheduled hourly or more frequently

> [!note] DirSync vs. uSNChanged
> The AD connector uses **DirSync** as the default delta mechanism (introduced in IIQ 6.3). DirSync requires the bind account to have **Replicating Directory Changes** permission on the domain.
>
> An older method, **uSNChanged**, tracks the highest `uSNChanged` value seen and queries for anything higher on the next run. It requires only List and Read permissions but is unreliable in multi-DC or load-balanced environments — `uSNChanged` is not replicated across domain controllers, so IIQ must always query the same DC to avoid missing changes. DirSync does not have this limitation.
>
> Source: [SailPoint — Active Directory delta aggregation: DirSync vs. uSNChanged](https://community.sailpoint.com/t5/IdentityIQ-Wiki/Active-Directory-delta-aggregation-DirSync-vs-uSNChanged/ta-p/72397)

### What Triggers Aggregation
- Scheduled tasks configured in IIQ's task scheduler
- Manual run by an IIQ administrator
- Event-based triggers (e.g., an HR event fires a lifecycle workflow, which triggers a targeted aggregation)

---

## The Connector Gap

The connector is a **scheduled reader, not a real-time listener**. It polls AD on a cadence. Everything IIQ knows about AD is only as fresh as the last aggregation timestamp on `spt_link.last_refresh`.

```
IIQ scheduler fires
        │
        ▼
Connector opens LDAP connection to AD
        │
        ▼
Reads all accounts + their memberOf attributes
        │
        ▼
Compares what it found against what IIQ already has
        │
        ▼
Updates spt_link, spt_identity_entitlement, flags needs_refresh
```

**The gap is the window between polls.** If a sysadmin manually adds Jane to `Domain Admins` in AD at 9am, and the next aggregation runs at midnight, IIQ has no visibility for 15 hours. During that window:

- Jane has the access in reality
- `spt_identity_entitlement` shows nothing
- No certification item exists for it
- No SOD check has fired
- Risk score has not updated

When aggregation finally runs, IIQ finds the new membership and writes a row with `aggregation_state = 'Connected'` and `assigned = 0` — meaning the entitlement was found on the system but was never requested through IIQ. This is the signal that access was granted outside the governed process.

### The `Disconnected` signal works in reverse

If Jane is removed from `Domain Admins` directly in AD — bypassing IIQ's provisioning — the next aggregation finds the group missing from her `memberOf`. IIQ does **not** delete the `spt_identity_entitlement` row. It sets `aggregation_state = 'Disconnected'`.

This distinction matters for auditors: the record proves that access existed and was removed, but the `Disconnected` state specifically flags that removal happened outside IIQ's workflow rather than through a governed request or certification decision.

> [!warning] Gap size is a governance risk
> A 24-hour delta aggregation schedule means changes made directly in AD are invisible to IIQ for up to a day. For high-risk groups (privileged admin groups, finance application roles), shorter aggregation intervals or event-based triggers reduce this exposure window.

---

## Useful SQL: Accounts from AD

Find all accounts aggregated from a specific AD application:

```sql
-- All accounts from "Active Directory - Corp"
SELECT
    i.display_name          AS identity_name,
    l.native_identity       AS ad_account,
    l.display_name          AS account_display_name,
    l.last_refresh          AS last_aggregated
FROM spt_link l
JOIN spt_identity i    ON i.id = l.identity_id
JOIN spt_application a ON a.id = l.application
WHERE a.name = 'Active Directory - Corp'
ORDER BY i.display_name;
```

Find uncorrelated (orphan) AD accounts:

```sql
-- Accounts with no matched identity
SELECT
    l.native_identity   AS ad_account,
    l.display_name      AS display_name,
    l.last_refresh      AS last_seen,
    a.name              AS application
FROM spt_link l
JOIN spt_application a ON a.id = l.application
WHERE l.identity_id IS NULL
  AND a.type = 'Active Directory'
ORDER BY l.last_refresh DESC;
```

---

## Related

- [[IAM-Overview]] — how IIQ fits into the broader IAM stack
- [[AD-LDAP-Fundamentals]] — the AD attributes IIQ reads
- [[AD-Domain-Forest-Trusts]] — multi-domain and forest topology
- [[IIQ-Concepts]] — IIQ's mental models for aggregation and correlation
- [[IIQ-Data-Flows]] — step-by-step aggregation and correlation flow
- [[AD-Groups-in-IIQ-Governance]] — what IIQ does with groups after aggregation
- [[IIQ]] — full schema reference for `spt_link`, `spt_application`
