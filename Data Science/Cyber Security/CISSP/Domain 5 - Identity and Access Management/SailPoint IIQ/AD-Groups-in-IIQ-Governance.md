---
tags: [iiq, active-directory, governance, roles, entitlements, certification, provisioning, sql, cissp, domain-5-iam, cissp/5.4-authorization, cissp/5.5-provisioning-lifecycle]
aliases: [AD Groups Governance, IIQ Entitlements AD, Group-based Access Governance]
---

# AD Groups in IIQ Governance

After [[IIQ-AD-LDAP-Connector|IIQ aggregates from Active Directory]], the raw account and group data is transformed into IIQ's governance model: entitlements, roles, certifications, and provisioning. This note explains that transformation end-to-end.

---

## From AD Group to Managed Entitlement

An AD security group becomes a **managed entitlement** in IIQ — a governed, catalogued access right that can be requested, reviewed, and revoked through IIQ's processes.

The journey:

```
AD Security Group (e.g. "SG-Finance-Read")
    │
    │  Aggregation reads group object
    ▼
spt_managed_attribute
    ├── attribute   = 'memberOf'
    ├── value       = 'CN=SG-Finance-Read,OU=Groups,DC=corp,...'
    ├── display_name = 'SG-Finance-Read'
    ├── type        = 'Entitlement'
    └── application → spt_application (Active Directory - Corp)
```

Not every AD group is automatically a managed entitlement. IIQ only manages groups that:
1. Match the group filter configured in the Application
2. Have been explicitly included in the entitlement catalogue (or all groups are included by default, depending on configuration)

> [!tip] Entitlement descriptions
> The `spt_managed_attribute.descriptions` column (XML blob) can store a human-readable description of what the group grants. Keeping these populated is an IAM hygiene practice — it makes certifications meaningful because reviewers know what they're approving.

---

## spt_identity_entitlement — The Entitlement Assignment Record

When IIQ determines that an identity holds an entitlement, it writes a row to `spt_identity_entitlement`. This is the central table for "who has what."

| Column | Meaning |
|---|---|
| `identity_id` | FK to `spt_identity` |
| `application` | FK to `spt_application` (which AD domain this came from) |
| `name` | Attribute name — always `'memberOf'` for AD groups |
| `value` | Group DN or name (matches `spt_managed_attribute.value`) |
| `display_name` | Human-readable group name |
| `aggregation_state` | `'Connected'` = currently a member; `'Disconnected'` = removed in AD |
| `assigned` | `1` = IIQ explicitly assigned this; `0` = detected from aggregation |
| `granted_by_role` | `1` = entitlement is held because of a role assignment |
| `source` | `'Application'` (aggregated) or `'Role'` (role-provisioned) |
| `start_date` / `end_date` | Optional validity window |

### aggregation_state Values

| Value | Meaning |
|---|---|
| `Connected` | User is currently a member of this group in AD |
| `Disconnected` | User was a member, but the group was not found in the last aggregation |

> [!warning] Disconnected ≠ deleted
> A `Disconnected` entitlement means IIQ has detected that access was removed in AD, possibly outside of IIQ's control. This is an important audit signal — it may mean someone manually removed a user from a group, bypassing the IIQ approval workflow.

---

## Role Modelling with AD Groups

IIQ's role model provides a business-friendly layer over raw AD group membership. Instead of governing hundreds of individual groups, you govern roles composed of those groups.

### The Two-Layer Role Model

```
Business Role: "Finance Analyst"         (spt_bundle, type='business')
    │  composed of
    ▼
IT Role: "SAP Finance Read Access"       (spt_bundle, type='it')
    │  requires entitlement
    ▼
AD Group: "SG-SAP-FI-READ"              (spt_managed_attribute)
    │
    ▼
Permission on SAP system
```

**IT Roles** wrap one or more entitlements (AD groups). They represent technical access.
**Business Roles** wrap one or more IT roles. They represent a job function.

This separation means:
- Business users can request "Finance Analyst" without knowing which AD groups are involved
- When an AD group changes, only the IT Role needs updating — all Business Roles that include it automatically reflect the change

### How Roles Are Stored

IT Role entitlement requirements are stored in `spt_profile` and `spt_profile_constraints`:

```sql
-- Find which AD groups are required by an IT Role
SELECT
    b.name          AS role_name,
    b.type          AS role_type,
    p.application   AS application,
    pc.elt          AS required_group_value
FROM spt_bundle b
JOIN spt_profile p            ON p.bundle_id = b.id
JOIN spt_profile_constraints pc ON pc.profile_id = p.id
WHERE b.type = 'it'
  AND b.name = 'SAP Finance Read Access';
```

### Role Detection vs. Role Assignment

| Mode | How it Works |
|---|---|
| **Role Detection** | IIQ scans entitlements and *infers* which role a person qualifies for. No explicit assignment — the role is detected from what they have. |
| **Role Assignment** | IIQ explicitly assigns a role (via access request or lifecycle rule). The role then provisions the required AD groups. |

The `spt_identity_role` table records explicit role assignments; the `granted_by_role` flag on `spt_identity_entitlement` indicates that an entitlement was provisioned as part of a role assignment.

---

## Cross-Domain Entitlements

When a user in `corp.example.com` is a member of a group owned by `emea.corp.example.com` (see [[AD-Domain-Forest-Trusts]]), IIQ records this as an entitlement on the **`emea` Application** — because the group belongs to the `emea` domain's Application.

In `spt_identity_entitlement`:
- `identity_id` → the user's identity (from any domain)
- `application` → FK to the `emea` Application in `spt_application`
- `value` → the cross-domain group's DN

> [!note] Cross-domain entitlements in certifications
> When certifying access, a manager reviewing a user from `corp` may see entitlements from the `emea` Application. This is expected and correct — it reflects that the user has access to resources in the other domain. Reviewers sometimes find this confusing without context; entitlement descriptions help here.

---

## Access Request Flow (Requesting an AD Group)

When a user requests an AD group through IIQ's Lifecycle Manager (LCM):

```
User requests "SG-Finance-Read" via IIQ portal
    │
    ▼
IIQ creates spt_identity_request (state = 'ApprovalPhase')
    │
    ▼
Approval workflow: manager or group owner approves
    │
    ▼
spt_identity_request state → 'Provision'
    │
    ▼
IIQ AD connector: modify group's 'member' attribute
    (adds user's DN to SG-Finance-Read's member list)
    │
    ▼
spt_identity_request state → 'Finished'
spt_identity_entitlement row created (assigned=1, granted_by_role=0)
    │
    ▼
Next aggregation: confirms membership, sets aggregation_state='Connected'
```

---

## Certification (Access Review)

Certifications ask: *should this person still have this access?*

For AD groups, a certification campaign (e.g., Manager Certification) shows each manager a list of their team's entitlements and asks them to **Approve** or **Revoke** each one.

| Decision | Result |
|---|---|
| **Approve** | `spt_certification_action.status = 'Approved'`; access retained |
| **Revoke** | `spt_certification_action.status = 'Remediated'`; IIQ removes user from AD group |
| **Delegate** | Forwarded to another reviewer |
| **Mitigate** | Acknowledged as exceptional; access retained with a note |

After a Revoke decision, IIQ's provisioning removes the user from the AD group's `member` attribute. The `spt_identity_entitlement` row will have `aggregation_state = 'Disconnected'` on the next aggregation cycle.

---

## Provisioning: How IIQ Modifies AD Group Membership

When IIQ needs to add or remove a user from an AD group (whether from access request, certification revocation, or lifecycle event), it:

1. Connects to AD using the Application's bind account
2. Issues an LDAP **modify** operation on the group object:
   - **Add**: `member: CN=John Smith,OU=Finance,...` (adds the DN to the `member` attribute)
   - **Remove**: deletes the user's DN from the `member` attribute
3. Records the operation in `spt_provisioning_transaction`

> [!warning] Provisioning failures
> If IIQ cannot connect to AD (network issue, bind account locked), provisioning fails. The `spt_provisioning_transaction` table records the failure. IIQ will retry based on task configuration. Monitor for stuck provisioning transactions regularly.

---

## SQL Recipes

### All identities with a specific AD group

```sql
SELECT
    i.display_name              AS identity_name,
    i.email,
    ie.value                    AS group_value,
    ie.aggregation_state,
    ie.assigned,
    ie.granted_by_role,
    ie.start_date
FROM spt_identity_entitlement ie
JOIN spt_identity i    ON i.id = ie.identity_id
JOIN spt_application a ON a.id = ie.application
WHERE a.type = 'Active Directory'
  AND ie.name = 'memberOf'
  AND ie.value LIKE '%SG-Finance-Read%'
  AND ie.aggregation_state = 'Connected'
ORDER BY i.display_name;
```

### Ungoverned AD groups (in AD but not catalogued in IIQ)

```sql
-- Groups aggregated into spt_link.attributes but not in spt_managed_attribute
-- Note: this requires staging tables to extract memberOf from the XML blob.
-- Assumes staging_link_attributes table normalises spt_link.attributes.
-- See staging_tables_generic.sql for the staging approach.

SELECT DISTINCT
    sla.attribute_value         AS group_dn,
    a.name                      AS application
FROM staging_link_attributes sla
JOIN spt_link l    ON l.id = sla.link_id
JOIN spt_application a ON a.id = l.application
WHERE sla.attribute_name = 'memberOf'
  AND NOT EXISTS (
      SELECT 1
      FROM spt_managed_attribute ma
      WHERE ma.application = l.application
        AND ma.value = sla.attribute_value
  )
ORDER BY a.name, group_dn;
```

### Cross-domain entitlement breakdown

```sql
-- Identities who have entitlements from a different domain's application
SELECT
    i.display_name              AS identity_name,
    corr_app.name               AS primary_ad_app,   -- where account lives
    ent_app.name                AS entitlement_app,  -- where the group lives
    ie.value                    AS group_value,
    ie.aggregation_state
FROM spt_identity_entitlement ie
JOIN spt_identity i     ON i.id = ie.identity_id
JOIN spt_application ent_app ON ent_app.id = ie.application
-- Find the identity's primary AD account application
JOIN spt_link l         ON l.identity_id = i.id
JOIN spt_application corr_app ON corr_app.id = l.application
WHERE ent_app.type = 'Active Directory'
  AND corr_app.type = 'Active Directory'
  AND ent_app.id != corr_app.id    -- entitlement is from a DIFFERENT domain
  AND ie.aggregation_state = 'Connected'
ORDER BY i.display_name;
```

### Entitlements disconnected outside IIQ (removed in AD without IIQ approval)

```sql
SELECT
    i.display_name      AS identity_name,
    ie.value            AS group_value,
    a.name              AS application,
    ie.assigned,
    ie.granted_by_role
FROM spt_identity_entitlement ie
JOIN spt_identity i    ON i.id = ie.identity_id
JOIN spt_application a ON a.id = ie.application
WHERE ie.aggregation_state = 'Disconnected'
  AND a.type = 'Active Directory'
  AND ie.assigned = 1    -- IIQ had granted this, but it was removed outside IIQ
ORDER BY i.display_name;
```

---

## Related

- [[IAM-Overview]] — how governance fits into the IAM stack
- [[AD-LDAP-Fundamentals]] — what AD groups are and how membership is stored
- [[AD-Domain-Forest-Trusts]] — cross-domain group scope and entitlement implications
- [[IIQ-AD-LDAP-Connector]] — how groups are aggregated from AD into IIQ
- [[IIQ-Concepts]] — IIQ mental models for roles, entitlements, and certifications
- [[IIQ-Data-Flows]] — step-by-step data flows for access requests and certifications
- [[IIQ]] — full schema reference for `spt_identity_entitlement`, `spt_managed_attribute`
- [[IIQ-Field-Values]] — `aggregation_state`, `assigned`, `granted_by_role` value meanings
