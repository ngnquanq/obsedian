# IIQ Concepts: Business Context for Data Analysts

This document gives a data analyst with zero IAM background enough conceptual understanding to interpret SailPoint IdentityIQ data. It answers the **why** — why these tables exist, why the data looks the way it does, and what business processes drive it. For the **what** — column names, types, join paths, and SQL — see [IIQ.md](IIQ.md).

---

## What is Identity Governance?

Every organization faces the same problem: **people join, move between roles, and leave — and each transition requires changes to their system access.** A new hire in Finance needs SAP, a shared drive, and an expense approval group. When she moves to Marketing, she needs different access. When she leaves, everything must be revoked.

Without governance, this creates three risks:

1. **Excessive access** — People accumulate permissions they no longer need ("entitlement creep")
2. **Orphan accounts** — Former employees retain active accounts on target systems
3. **Segregation of Duties (SOD) violations** — One person holds conflicting permissions (e.g., creating vendors AND approving payments)

**Regulatory frameworks** (SOX, SOD, GDPR, banking regulations) require organizations to demonstrate that access is appropriate, reviewed periodically, and revocable. Identity Governance and Administration (IGA) tools like SailPoint IdentityIQ exist to automate and audit this entire lifecycle.

**The core question IGA answers**: *Who has access to what, how did they get it, and is it still appropriate?*

As a data analyst, your job is to answer this question from the database. Everything in the IIQ schema exists to support some part of this answer.

---

## The Identity Cube

IIQ's central concept is the **Identity Cube** — a unified profile that aggregates a person's data from every connected system into a single view.

```
                          ┌──────────────────────┐
                          │    IDENTITY CUBE      │
                          │   "Jane Smith"        │
                          │   Dept: Finance       │
                          │   Manager: Bob Lee    │
                          │   Risk Score: 450     │
                          │   Status: Active      │
                          ├──────────────────────┤
                          │       ACCOUNTS        │
                ┌─────────┼─────────┬─────────────┤
                ↓         ↓         ↓             ↓
          ┌──────────┐ ┌────────┐ ┌─────────┐ ┌────────┐
          │ Active   │ │  SAP   │ │ Oracle  │ │ Unix   │
          │ Directory│ │  ERP   │ │  DB     │ │ Server │
          │          │ │        │ │         │ │        │
          │ jsmith   │ │ JSMITH │ │ jane.s  │ │ janes  │
          │          │ │        │ │         │ │        │
          │ Groups:  │ │ Roles: │ │ Grants: │ │ Groups:│
          │ Finance  │ │ FI01   │ │ SELECT  │ │ sudo   │
          │ VPN_Users│ │ FI02   │ │ INSERT  │ │ admin  │
          └──────────┘ └────────┘ └─────────┘ └────────┘
```

**How this maps to the database:**

| Concept | Table(s) | What it stores |
|---|---|---|
| The person (cube) | `spt_identity` | Core attributes: name, department, manager, status |
| Each account | `spt_link` | One row per account per application |
| Each entitlement | `spt_identity_entitlement` | One row per entitlement held by the identity |
| Roles assigned | `spt_identity_bundles` + `spt_identity.attributes` XML | Detected and assigned role memberships |

One person with accounts on 5 applications and 20 entitlements across those accounts produces: 1 row in `spt_identity`, 5 rows in `spt_link`, and 20 rows in `spt_identity_entitlement`. This is why `spt_identity_entitlement` is typically the largest table.

---

## Key Concepts in Plain Language

### Application (authoritative vs. regular)

An **application** in IIQ represents any system that IIQ connects to — Active Directory, SAP, a database, a flat file from HR. Stored in `spt_application`.

The critical distinction is **authoritative vs. regular**:

- **Authoritative application** (`authoritative = 1`) — The source of truth for identity data, usually the HR system. When IIQ pulls data from this source, it **creates new identities** in `spt_identity` and updates core attributes (name, department, manager, status). There is typically one authoritative source.
- **Regular application** (`authoritative = 0`) — A target system where people have accounts. IIQ pulls account and entitlement data from these but does **not** create identities from them. Instead, it tries to match (correlate) accounts to existing identities.

**What this means for your data**: If `spt_application.authoritative = 1`, that application's aggregation drives identity lifecycle. Changes in the HR feed create, modify, and deactivate identities.

### Aggregation

**Aggregation** is the process of IIQ pulling data from a connected application into its database. Think of it as a scheduled import — IIQ reaches out to the target system, reads its current state, and synchronizes its local copy.

There are two types of aggregation:
- **Account aggregation** — Imports user accounts and their attributes. Creates/updates rows in `spt_link`.
- **Group/Entitlement aggregation** — Imports entitlement definitions (group names, role names). Creates/updates rows in `spt_managed_attribute` (the entitlement catalog).

When account aggregation runs:
1. IIQ connects to the application via its connector
2. Pulls all accounts → creates/updates rows in `spt_link`
3. For each account, reads entitlement attributes (e.g., AD group memberships) → updates `spt_identity_entitlement` per identity
4. Entitlements confirmed present are marked `aggregation_state = 'Connected'`
5. Entitlements previously seen but now absent are marked `aggregation_state = 'Disconnected'`
6. Results are logged in `spt_task_result`

**What this means for your data**: IIQ data is only as fresh as the last aggregation. The `spt_link.last_refresh` and `spt_identity.last_refresh` timestamps tell you when data was last pulled. If an aggregation hasn't run in a week, the entitlement data is a week old. IIQ is a **snapshot**, not a real-time mirror. See [IIQ-Data-Flows.md — Aggregation Flow](IIQ-Data-Flows.md#1-aggregation-flow) for the complete step-by-step process.

### Correlation

**Correlation** is matching an account on a target application to a known identity. When IIQ aggregates an Active Directory account `jsmith`, it needs to figure out which `spt_identity` row that account belongs to.

Correlation uses rules (often matching on employee ID, email, or naming convention). When a match is found, `spt_link.identity_id` points to the correct `spt_identity` row, and the identity's `correlated` flag is set to `1`.

When **no match is found**, IIQ creates a new `spt_identity` row with `correlated = 0`. This is an **orphan account holder** — a placeholder identity that exists only because an uncorrelated account was found.

**What this means for your data**: The `correlated` flag on `spt_identity` is your most important filter. Always use `correlated = 1` to count real people. Uncorrelated identities (`correlated = 0`) inflate counts and produce misleading reports. See [IIQ.md — The correlated flag](IIQ.md#the-correlated-flag-is-your-most-important-filter).

### Entitlement

An **entitlement** is a single unit of access on an application. It could be an AD group membership, an SAP role, a database privilege, or a Unix group. It is the most granular building block of access.

Two tables work together:

- **`spt_managed_attribute`** — The entitlement **catalog**. One row per unique entitlement definition across all applications. Think of it as the "menu" of all possible access.
- **`spt_identity_entitlement`** — The entitlement **assignments**. One row per person per entitlement they hold. Think of it as "who ordered what from the menu."

These two tables connect through a **logical join** on `(application, attribute, value)`, not a foreign key. See [IIQ.md — Entitlement catalog](IIQ.md#entitlement-catalog-spt_managed_attribute).

### Role / Bundle

In IIQ, a **role** is called a **Bundle** in the database (`spt_bundle`). The name comes from the Java class `sailpoint.object.Bundle`. In the UI and documentation, you see "Role" — in the database, you see "Bundle."

Roles follow a hierarchy:

```
Business Role (type = 'business')
    └── requires → IT Role (type = 'it')
                       └── contains → Entitlement Profile (spt_profile)
                                          └── matches → Entitlements on Application
```

- **Business Role** — A logical grouping meaningful to the business (e.g., "Accounts Payable Clerk")
- **IT Role** — A technical grouping that maps to specific entitlements on specific applications (e.g., "SAP AP Access")
- **Entitlement Profile** — A filter definition that says "these entitlements on this application constitute this IT role"

The join tables `spt_bundle_requirements` (required IT roles) and `spt_bundle_permits` (optional IT roles) connect business roles to IT roles. See [IIQ.md — Roles and the bundle model](IIQ.md#roles-and-the-bundle-model).

### Role Detection vs. Role Assignment

This is one of the most confusing aspects of IIQ data. A person can have a role in two fundamentally different ways:

**Detected roles** — During Identity Refresh, IIQ looks at a person's current entitlements and checks if they match any role's entitlement profile. If they do, the role is **detected** — the person effectively *already has* the access that constitutes the role, even if nobody explicitly granted it. Detected roles are stored in `spt_identity_bundles`.

**Assigned roles** — A role explicitly granted to a person through a request, manual assignment, or lifecycle rule. Assigned roles are stored in the Identity's `attributes` XML as `RoleAssignment` objects (some versions also use `spt_identity_assigned_roles`).

A role can be **both assigned and detected** simultaneously. A role can be **assigned but not detected** (the provisioning hasn't completed yet, or entitlements changed). A role can be **detected but not assigned** (the person accumulated the right entitlements without a formal role grant).

**What this means for your data**: If you only query `spt_identity_bundles`, you see detected roles. For assigned roles, you must parse the `attributes` XML in `spt_identity` or query `spt_identity_assigned_roles` if available. See [IIQ.md — Assigned vs. detected roles](IIQ.md#assigned-roles-versus-detected-roles).

### Provisioning

**Provisioning** is the act of making changes on target systems — creating an account, adding a group membership, disabling an account. It is the "write" operation, as opposed to aggregation which is "read."

Provisioning can be:
- **Automatic** — IIQ directly changes the target system via its connector
- **Manual** — IIQ creates a work item for someone to make the change manually (when no connector supports the operation)

Provisioning history is recorded in `spt_provisioning_transaction`. Each row captures the operation, target system, identity, status (Success/Pending/Failed), and whether it was automatic or manual. See [IIQ.md — spt_provisioning_transaction](IIQ.md#spt_provisioning_transaction--provisioning-audit-trail).

### Certification / Access Review

A **certification** (also called an **access review**) is a periodic process where reviewers verify that people's access is still appropriate. Regulations like SOX require these reviews.

The process follows a strict hierarchy in the database:

1. **Definition** (`spt_certification_definition`) — The campaign template: who reviews, what scope, what schedule
2. **Group** (`spt_certification_group`) — A campaign instance (one execution of the definition)
3. **Certification** (`spt_certification`) — An individual review assignment per reviewer
4. **Entity** (`spt_certification_entity`) — Each identity being reviewed
5. **Item** (`spt_certification_item`) — Each entitlement/role under review
6. **Action** (`spt_certification_action`) — The reviewer's decision: Approved, Remediated, Mitigated, Delegated

**What this means for your data**: Certification data is deeply nested. To answer "what was decided about Jane's SAP access," you must join through the entire chain. See [IIQ.md — Certification and access review tables](IIQ.md#certification-and-access-review-tables).

### SOD and Policy Violations

**Separation of Duties (SOD)** policies define combinations of access that no single person should hold simultaneously. For example, "no one should have both Create Vendor and Approve Payment roles."

When IIQ detects a violation (usually during Identity Refresh or role assignment), it creates a row in `spt_policy_violation` with:
- The conflicting roles/entitlements (`left_bundles`, `right_bundles`)
- A `status`: **Open** (unaddressed), **Mitigated** (accepted with justification), or **Remediated** (access removed)

**Mitigation** means "we know this is a violation, but we accept it with a compensating control" — the access stays. **Remediation** means "remove the conflicting access." See [IIQ.md — Policy and SOD tables](IIQ.md#policy-and-sod-tables).

### Work Items

A **work item** is a task assigned to a person or workgroup in IIQ. The most common type is an **Approval** — when someone requests access, the approver gets a work item.

Work items are stored in `spt_work_item`. Key behaviors:
- **Open** work items have `state IS NULL` (not "Open" — null)
- **Completed** items have `state = 'Finished'`, `'Rejected'`, or `'Expired'`
- Completed items eventually move to `spt_work_item_archive`

Other work item types include Certification (review assignment), Remediation (fix a revocation), Challenge (dispute a revocation decision), and PolicyViolation (address a violation). See [IIQ.md — spt_work_item](IIQ.md#spt_work_item--approvals-and-manual-tasks).

### Lifecycle Events (Joiner / Mover / Leaver)

The **Joiner-Mover-Leaver** (JML) lifecycle is the backbone of identity management:

- **Joiner** — New identity arrives from the authoritative source. IIQ creates the `spt_identity` row, may auto-assign "birthright" roles (baseline access everyone gets), and triggers provisioning.
- **Mover** — Identity attributes change (department, title, manager). IIQ detects the change, may reassign roles based on new attributes, and provisions/deprovisions accordingly.
- **Leaver** — Identity is marked inactive in the authoritative source. IIQ sets `inactive = 1`, triggers disable/removal workflows, and may create work items for manual cleanup.

**What this means for your data**: The `inactive` flag on `spt_identity` is IIQ's leaver marker. An identity with `inactive = 1` is (or should be) in some stage of access removal. The `spt_identity` row persists — IIQ does not hard-delete leavers immediately.

---

## IIQ in the Enterprise Architecture

IIQ sits as **middleware between HR systems and target applications**:

```
┌────────────────┐        ┌──────────────────┐        ┌────────────────────┐
│  HR System     │───────→│  SailPoint IIQ   │───────→│  Target Systems    │
│  (Workday,     │  Auth  │                  │  Prov  │  (AD, SAP, DB,     │
│   SAP HCM,     │  Agg   │  Identity Cube   │  Agg   │   Unix, Cloud)     │
│   PeopleSoft)  │        │  Policy Engine   │        │                    │
└────────────────┘        │  Cert Engine     │        └────────────────────┘
                          │  Workflow Engine  │
                          └──────────────────┘
                                   ↑
                          ┌────────────────────┐
                          │  Reviewers/Admins  │
                          │  (UI, API, LCM)    │
                          └────────────────────┘
```

Key implications for analysts:

1. **IIQ is a secondary data source.** It reflects the state of other systems as of the last aggregation, not the current state. Always check `last_refresh` timestamps.
2. **IIQ does not own the data.** If an account exists in AD but IIQ hasn't aggregated it yet, it won't appear in `spt_link`. Conversely, if an account was deleted in AD but IIQ hasn't aggregated since, the `spt_link` row still exists.
3. **The authoritative source drives the identity lifecycle.** Changes in HR (new hire, termination) flow into IIQ and trigger downstream processes. IIQ doesn't decide who joins or leaves — it reacts to the HR feed.
4. **Data quality depends on connector configuration.** What IIQ sees is limited by what the connector is configured to pull. If the AD connector doesn't read the `memberOf` attribute, no AD group memberships appear in `spt_identity_entitlement`. Always check `spt_application` and `spt_schema` to understand what each connector imports.
5. **Timing matters.** Aggregation, identity refresh, role detection, and policy checks often run as separate scheduled tasks. Between these steps, data can be in a transitional state (e.g., new entitlements aggregated but roles not yet detected). See [IIQ-Data-Flows.md — Cross-Process Interactions](IIQ-Data-Flows.md#cross-process-interactions) for timing dependencies.

---

## Mental Models for Analysts

These mental models will help you avoid common pitfalls when working with IIQ data:

### "Everything is an identity"

People, service accounts, and workgroups all share the same `spt_identity` table. Always filter with:
- `correlated = 1` — Real identities (not orphan account holders)
- `is_workgroup = 0` — Actual people (not workgroups)
- Consider `inactive = 0` — Currently active (unless you want leavers)

### "The CLOB is the truth"

The relational columns in IIQ tables are a **subset** of the object's data. The `attributes` CLOB contains the complete serialized XML of the object. When you can't find a value in a flat column, it's probably in the CLOB. Role assignments, extended attributes, workflow variables, provisioning details — all live in CLOBs. See [IIQ.md — Handling XML/CLOB columns](IIQ.md#handling-xmlclob-columns).

### "Time is epoch milliseconds"

Every timestamp in IIQ is a `BIGINT` storing **milliseconds since January 1, 1970 UTC**. Not seconds — milliseconds. You must divide by 1000 for most standard conversion functions. A `NULL` timestamp usually means "hasn't happened yet" (e.g., null `end_date` = no sunset). See [IIQ.md — Timestamp conversion](IIQ.md#timestamp-conversion-is-mandatory-for-every-date-column).

### "GUIDs, not integers"

All primary keys are `VARCHAR(128)` containing GUIDs like `2c9084ee8234ab01018234b5c6700012`. They are not sequential, not sortable by creation order, and not predictable. Use `created` timestamps to determine chronological order, not ID values.

### "Snapshots, not real-time"

IIQ data reflects the state of connected systems **at the time of the last aggregation**. Between aggregations, reality and the IIQ database can diverge. A common mistake is treating IIQ data as current — always ask "when was this last aggregated?" before drawing conclusions.

### "Absence of evidence is not evidence of absence"

If an entitlement doesn't appear in `spt_identity_entitlement`, it could mean: (a) the person truly doesn't have it, (b) the entitlement hasn't been aggregated yet, (c) the application isn't connected to IIQ, or (d) the entitlement schema doesn't include that attribute. Always verify application coverage before reporting "no one has X."

### "Join tables don't always use foreign keys"

Some of IIQ's most important relationships use **logical joins** rather than foreign key constraints. The most notable example: `spt_identity_entitlement` connects to `spt_managed_attribute` via a logical match on `(application, value, name/attribute)`, not an FK. Similarly, `spt_certification.manager` stores a name string that must be joined to `spt_identity.name`, not an ID. This means referential integrity is not enforced at the database level — orphan references can and do exist.

### "Deleted means gone"

IIQ uses hard deletes for most objects. When an identity is fully removed from IIQ, the `spt_identity` row disappears — there is no `deleted` flag or recycle bin. However, `inactive = 1` is the common path for leavers: the row persists but is marked inactive. Child records (links, entitlements, work items) may linger after their parent identity is deleted, creating orphan rows. Archived certification data moves to `spt_certification_archive` as compressed XML before the active tables are purged.

---

## Where to Go Next

- **What do field values mean?** → [IIQ-Field-Values.md](IIQ-Field-Values.md)
- **How does data flow through processes?** → [IIQ-Data-Flows.md](IIQ-Data-Flows.md)
- **How do I answer specific business questions?** → [IIQ-Analyst-Playbook.md](IIQ-Analyst-Playbook.md)
- **What are the tables, columns, and joins?** → [IIQ.md](IIQ.md)
