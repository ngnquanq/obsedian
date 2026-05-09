# Privileged "A" Account Data Extraction Queries (MySQL)

This document provides SQL queries to extract Roles, Entitlements, and Permissions for personal privileged accounts (naming pattern `PRIV_EMPNO_A`, called "A" accounts). These accounts are Active Directory accounts aggregated into SailPoint IIQ. All queries target MySQL. For table structures, see [IIQ.md](IIQ.md). For field value meanings, see [IIQ-Field-Values.md](IIQ-Field-Values.md).

---

## Scope: What "A" Account Data Means

Before querying, understand what lives at which level:

```
┌─────────────────────────────────────────────────────────┐
│  spt_identity (Identity Cube)                           │
│  "Jane Smith" — Employee #12345                         │
│                                                         │
│  ROLES live at identity level, but we scope them:       │
│    - Only roles whose entitlement profile targets AD    │
│    - = roles that are relevant to the "A" account       │
│                                                         │
│  ACCOUNTS:                                              │
│  ├─ spt_link: jsmith (standard AD account)              │
│  │   └─ entitlements: Finance_Users, VPN_Users          │
│  │                                                      │
│  ├─ spt_link: PRIV_12345_A  ← THIS IS WHAT WE WANT    │
│  │   └─ entitlements: Domain Admins, Server_Root_Access │
│  │   └─ permissions: ResetPassword, ManageOU            │
│  │   └─ roles (scoped): AD_Server_Admin (IT role)       │
│  │                       Server_Team (business role)    │
│  │                                                      │
│  └─ spt_link: JSMITH (SAP account)                      │
│      └─ entitlements: FI01, FI02                        │
│      └─ roles (scoped): SAP_Finance (NOT shown here)    │
└─────────────────────────────────────────────────────────┘
```

**Key principle — everything scoped to the "A" account:**
- **Entitlements & Permissions** → filter by `native_identity` on `spt_identity_entitlement`
- **Roles** → IIQ assigns roles at the identity level, but roles contain entitlement profiles (`spt_profile`) that target a specific application. By filtering to roles whose profiles target AD, we get only roles relevant to the "A" account — not SAP roles, not Unix roles, etc.

---

## Query 1: Base — Find All "A" Accounts

This is the foundation. Every subsequent query builds on this.

```sql
SELECT
    i.name                        AS identity_name,
    i.display_name                AS full_name,
    i.firstname,
    i.lastname,
    i.email,
    i.extended1                   AS employee_number,    -- verify mapping in your environment
    mgr.display_name              AS manager_name,
    l.native_identity             AS priv_account_name,
    l.display_name                AS account_display_name,
    app.name                      AS application_name,
    i.inactive                    AS identity_inactive,
    FROM_UNIXTIME(l.last_refresh / 1000) AS last_aggregated
FROM spt_link l
JOIN spt_identity i   ON l.identity_id = i.id
JOIN spt_application app ON l.application = app.id
LEFT JOIN spt_identity mgr ON i.manager = mgr.id
WHERE l.native_identity LIKE 'PRIV\\_%\\_A'    -- escaped underscores for LIKE pattern
  AND app.name = 'Active Directory'             -- adjust to your AD application name
  AND i.correlated = 1
  AND i.is_workgroup = 0
ORDER BY i.display_name;
```

**Notes:**
- `LIKE 'PRIV\\_%\\_A'` — In MySQL, `_` is a single-character wildcard in LIKE. The `\\_` escapes it to match a literal underscore. The middle `%` matches the EMPNO portion.
- `extended1` as employee number — verify which extended attribute slot maps to employee number in your environment (check `IdentityExtended.hbm.xml` or ask your IIQ admin).
- `app.name = 'Active Directory'` — adjust this to match the exact application name configured in your IIQ (e.g., `'AD'`, `'Corporate AD'`, etc.).

---

## Query 2: Entitlements on "A" Accounts

Returns every entitlement (typically AD group memberships) that the "A" account holds.

```sql
SELECT
    i.name                        AS identity_name,
    i.display_name                AS full_name,
    l.native_identity             AS priv_account_name,
    app.name                      AS application_name,
    ie.name                       AS entitlement_attribute,   -- e.g., 'memberOf', 'groups'
    ie.value                      AS entitlement_value,       -- e.g., 'CN=Domain Admins,...'
    COALESCE(ma.display_name,
             ie.display_name,
             ie.value)            AS entitlement_display_name,
    ie.source                     AS how_assigned,            -- Task, LCM, Rule, etc.
    ie.aggregation_state,                                     -- Connected / Disconnected
    CASE ie.assigned
        WHEN 1 THEN 'Yes'
        ELSE 'No'
    END                           AS directly_assigned,
    CASE ie.granted_by_role
        WHEN 1 THEN 'Yes'
        ELSE 'No'
    END                           AS from_role,
    FROM_UNIXTIME(ie.start_date / 1000) AS access_start,
    FROM_UNIXTIME(ie.end_date / 1000)   AS access_end
FROM spt_link l
JOIN spt_identity i              ON l.identity_id = i.id
JOIN spt_application app         ON l.application = app.id
JOIN spt_identity_entitlement ie ON ie.identity_id = i.id
                                 AND ie.application = l.application
                                 AND ie.native_identity = l.native_identity
LEFT JOIN spt_managed_attribute ma ON ma.application = ie.application
                                   AND ma.attribute = ie.name
                                   AND ma.value = ie.value
WHERE l.native_identity LIKE 'PRIV\\_%\\_A'
  AND app.name = 'Active Directory'
  AND i.correlated = 1
  AND i.is_workgroup = 0
  AND ie.type = 'Entitlement'              -- exclude Permissions (covered in Query 3)
ORDER BY i.display_name, ie.name, ie.value;
```

**Key join explained:**
```
spt_identity_entitlement is scoped to the "A" account via THREE conditions:
  ie.identity_id      = i.id                  (same identity)
  ie.application       = l.application         (same application — AD)
  ie.native_identity   = l.native_identity     (same account — PRIV_EMPNO_A)

Without the native_identity join, you'd get entitlements from ALL of the
identity's AD accounts (standard + privileged), which is not what we want.
```

**Understanding the result columns:**

| Column | What it tells you |
|---|---|
| `entitlement_attribute` | The AD attribute type — usually `memberOf` for group memberships |
| `entitlement_value` | The actual AD group DN (e.g., `CN=Server_Admins,OU=Groups,DC=corp`) |
| `entitlement_display_name` | Human-readable name from the entitlement catalog, falling back to raw value |
| `how_assigned` | `Task` = from aggregation, `LCM` = user requested, `Rule` = auto-assigned |
| `aggregation_state` | `Connected` = confirmed on AD, `Disconnected` = no longer found |
| `directly_assigned` | Was this explicitly requested/assigned in IIQ? |
| `from_role` | Was this provisioned as part of a SailPoint role? |

---

## Query 3: Permissions on "A" Accounts

Permissions are fine-grained access rights (e.g., NTFS ACLs, specific AD delegated permissions). Same structure as entitlements but filtered by `type = 'Permission'`.

```sql
SELECT
    i.name                        AS identity_name,
    i.display_name                AS full_name,
    l.native_identity             AS priv_account_name,
    app.name                      AS application_name,
    ie.name                       AS permission_attribute,
    ie.value                      AS permission_value,
    COALESCE(ma.display_name,
             ie.display_name,
             ie.value)            AS permission_display_name,
    ie.source                     AS how_assigned,
    ie.aggregation_state,
    CASE ie.assigned
        WHEN 1 THEN 'Yes'
        ELSE 'No'
    END                           AS directly_assigned,
    CASE ie.granted_by_role
        WHEN 1 THEN 'Yes'
        ELSE 'No'
    END                           AS from_role
FROM spt_link l
JOIN spt_identity i              ON l.identity_id = i.id
JOIN spt_application app         ON l.application = app.id
JOIN spt_identity_entitlement ie ON ie.identity_id = i.id
                                 AND ie.application = l.application
                                 AND ie.native_identity = l.native_identity
LEFT JOIN spt_managed_attribute ma ON ma.application = ie.application
                                   AND ma.attribute = ie.name
                                   AND ma.value = ie.value
WHERE l.native_identity LIKE 'PRIV\\_%\\_A'
  AND app.name = 'Active Directory'
  AND i.correlated = 1
  AND i.is_workgroup = 0
  AND ie.type = 'Permission'               -- Permissions only
ORDER BY i.display_name, ie.name, ie.value;
```

**Note:** Many AD connectors do not aggregate permissions separately from entitlements. If this query returns no rows, it likely means your AD connector configuration aggregates everything as `type = 'Entitlement'`. Check with your IIQ admin whether permission-level data is being collected.

---

## Query 4: SailPoint Roles Relevant to the "A" Account

**Important:** Roles in IIQ are assigned at the identity level, not the account level. An identity that owns a `PRIV_12345_A` account may also have a standard `jsmith` account — and the identity may hold roles that have nothing to do with the privileged account.

To scope roles to the "A" account specifically, we use two approaches:

### Approach A: Entitlements that came from roles (bottom-up)

The `granted_by_role` flag on `spt_identity_entitlement` tells us which entitlements on the "A" account were provisioned as part of a role. This is the most direct way to see which roles drive the "A" account's access.

```sql
SELECT
    i.name                        AS identity_name,
    i.display_name                AS full_name,
    l.native_identity             AS priv_account_name,
    ie.name                       AS entitlement_attribute,
    ie.value                      AS entitlement_value,
    COALESCE(ma.display_name,
             ie.display_name,
             ie.value)            AS entitlement_display_name,
    ie.source                     AS how_assigned,
    ie.aggregation_state
FROM spt_link l
JOIN spt_identity i              ON l.identity_id = i.id
JOIN spt_application app         ON l.application = app.id
JOIN spt_identity_entitlement ie ON ie.identity_id = i.id
                                 AND ie.application = l.application
                                 AND ie.native_identity = l.native_identity
LEFT JOIN spt_managed_attribute ma ON ma.application = ie.application
                                   AND ma.attribute = ie.name
                                   AND ma.value = ie.value
WHERE l.native_identity LIKE 'PRIV\\_%\\_A'
  AND app.name = 'Active Directory'
  AND i.correlated = 1
  AND i.is_workgroup = 0
  AND ie.granted_by_role = 1             -- only entitlements that came from a role
ORDER BY i.display_name, ie.name, ie.value;
```

### Approach B: IT Roles whose profiles target the AD application (top-down)

IT roles contain entitlement profiles (`spt_profile`) that specify which application and entitlements constitute the role. By filtering to roles with profiles on AD, we get only roles relevant to AD accounts — including the "A" account.

### 4a: Detected IT Roles scoped to AD

```sql
SELECT
    i.name                        AS identity_name,
    i.display_name                AS full_name,
    l.native_identity             AS priv_account_name,
    b.name                        AS role_name,
    b.display_name                AS role_display_name,
    b.type                        AS role_type,
    b.disabled                    AS role_disabled,
    b.requestable                 AS role_requestable,
    role_owner.display_name       AS role_owner_name,
    'Detected'                    AS assignment_type
FROM spt_link l
JOIN spt_identity i              ON l.identity_id = i.id
JOIN spt_application app         ON l.application = app.id
JOIN spt_identity_bundles ib     ON ib.identity_id = i.id
JOIN spt_bundle b                ON ib.bundle = b.id
-- Scope to roles that have an entitlement profile on the AD application
JOIN spt_profile p               ON p.bundle_id = b.id
                                 AND p.application = app.id
LEFT JOIN spt_identity role_owner ON b.owner = role_owner.id
WHERE l.native_identity LIKE 'PRIV\\_%\\_A'
  AND app.name = 'Active Directory'
  AND i.correlated = 1
  AND i.is_workgroup = 0
ORDER BY i.display_name, b.type, b.name;
```

### 4b: Business Roles that require AD-scoped IT Roles

Business roles don't have profiles directly — they *require* IT roles that do. This traces the hierarchy.

```sql
SELECT DISTINCT
    i.name                        AS identity_name,
    i.display_name                AS full_name,
    l.native_identity             AS priv_account_name,
    biz.name                      AS business_role_name,
    biz.display_name              AS business_role_display,
    it.name                       AS it_role_name,
    it.display_name               AS it_role_display,
    'Detected'                    AS assignment_type
FROM spt_link l
JOIN spt_identity i              ON l.identity_id = i.id
JOIN spt_application app         ON l.application = app.id
-- Identity has detected business role
JOIN spt_identity_bundles ib     ON ib.identity_id = i.id
JOIN spt_bundle biz              ON ib.bundle = biz.id AND biz.type = 'business'
-- Business role requires IT roles
JOIN spt_bundle_requirements br  ON biz.id = br.bundle
JOIN spt_bundle it               ON br.child = it.id
-- IT role has profile on AD application
JOIN spt_profile p               ON it.id = p.bundle_id
                                 AND p.application = app.id
WHERE l.native_identity LIKE 'PRIV\\_%\\_A'
  AND app.name = 'Active Directory'
  AND i.correlated = 1
  AND i.is_workgroup = 0
ORDER BY i.display_name, biz.name, it.name;
```

### 4c: Assigned Roles scoped to AD

If your IIQ version has `spt_identity_assigned_roles`:

```sql
SELECT
    i.name                        AS identity_name,
    i.display_name                AS full_name,
    l.native_identity             AS priv_account_name,
    b.name                        AS role_name,
    b.display_name                AS role_display_name,
    b.type                        AS role_type,
    'Assigned'                    AS assignment_type
FROM spt_link l
JOIN spt_identity i              ON l.identity_id = i.id
JOIN spt_application app         ON l.application = app.id
JOIN spt_identity_assigned_roles iar ON iar.identity_id = i.id
JOIN spt_bundle b                ON iar.bundle = b.id
-- Scope: only roles whose IT role profiles target AD
WHERE l.native_identity LIKE 'PRIV\\_%\\_A'
  AND app.name = 'Active Directory'
  AND i.correlated = 1
  AND i.is_workgroup = 0
  AND (
      -- IT role with direct AD profile
      EXISTS (
          SELECT 1 FROM spt_profile p
          WHERE p.bundle_id = b.id AND p.application = app.id
      )
      OR
      -- Business role that requires an IT role with AD profile
      EXISTS (
          SELECT 1 FROM spt_bundle_requirements br
          JOIN spt_profile p ON p.bundle_id = br.child AND p.application = app.id
          WHERE br.bundle = b.id
      )
  )
ORDER BY i.display_name, b.type, b.name;
```

> **If `spt_identity_assigned_roles` does not exist**, assigned roles are in `spt_identity.attributes` XML. Check with: `SHOW TABLES LIKE 'spt_identity_assigned_roles';`. If it doesn't exist, use the XML approach and parse in your reporting tool.

### 4d: Combined — All Roles Relevant to the "A" Account

```sql
-- Detected IT roles with AD profiles
SELECT
    i.name                        AS identity_name,
    i.display_name                AS full_name,
    l.native_identity             AS priv_account_name,
    b.name                        AS role_name,
    b.display_name                AS role_display_name,
    b.type                        AS role_type,
    b.disabled                    AS role_disabled,
    'Detected'                    AS assignment_type
FROM spt_link l
JOIN spt_identity i              ON l.identity_id = i.id
JOIN spt_application app         ON l.application = app.id
JOIN spt_identity_bundles ib     ON ib.identity_id = i.id
JOIN spt_bundle b                ON ib.bundle = b.id
JOIN spt_profile p               ON p.bundle_id = b.id
                                 AND p.application = app.id
WHERE l.native_identity LIKE 'PRIV\\_%\\_A'
  AND app.name = 'Active Directory'
  AND i.correlated = 1
  AND i.is_workgroup = 0

UNION

-- Detected business roles that require AD-scoped IT roles
SELECT
    i.name                        AS identity_name,
    i.display_name                AS full_name,
    l.native_identity             AS priv_account_name,
    biz.name                      AS role_name,
    biz.display_name              AS role_display_name,
    biz.type                      AS role_type,
    biz.disabled                  AS role_disabled,
    'Detected'                    AS assignment_type
FROM spt_link l
JOIN spt_identity i              ON l.identity_id = i.id
JOIN spt_application app         ON l.application = app.id
JOIN spt_identity_bundles ib     ON ib.identity_id = i.id
JOIN spt_bundle biz              ON ib.bundle = biz.id AND biz.type = 'business'
JOIN spt_bundle_requirements br  ON biz.id = br.bundle
JOIN spt_profile p               ON p.bundle_id = br.child
                                 AND p.application = app.id
WHERE l.native_identity LIKE 'PRIV\\_%\\_A'
  AND app.name = 'Active Directory'
  AND i.correlated = 1
  AND i.is_workgroup = 0

UNION

-- Assigned roles with AD profiles (requires spt_identity_assigned_roles)
SELECT
    i.name                        AS identity_name,
    i.display_name                AS full_name,
    l.native_identity             AS priv_account_name,
    b.name                        AS role_name,
    b.display_name                AS role_display_name,
    b.type                        AS role_type,
    b.disabled                    AS role_disabled,
    'Assigned'                    AS assignment_type
FROM spt_link l
JOIN spt_identity i              ON l.identity_id = i.id
JOIN spt_application app         ON l.application = app.id
JOIN spt_identity_assigned_roles iar ON iar.identity_id = i.id
JOIN spt_bundle b                ON iar.bundle = b.id
WHERE l.native_identity LIKE 'PRIV\\_%\\_A'
  AND app.name = 'Active Directory'
  AND i.correlated = 1
  AND i.is_workgroup = 0
  AND (
      EXISTS (SELECT 1 FROM spt_profile p WHERE p.bundle_id = b.id AND p.application = app.id)
      OR EXISTS (
          SELECT 1 FROM spt_bundle_requirements br
          JOIN spt_profile p ON p.bundle_id = br.child AND p.application = app.id
          WHERE br.bundle = b.id
      )
  )

ORDER BY identity_name, role_type, role_name;
```

---

## Query 5: Role Hierarchy — What Entitlements Do the Roles Grant?

Once you know which roles an "A" account owner has, you may want to see what those roles are designed to provide (Business Role → IT Role → Entitlement Profile).

```sql
SELECT
    biz.name                      AS business_role,
    biz.display_name              AS business_role_display,
    it.name                       AS it_role,
    it.display_name               AS it_role_display,
    prof_app.name                 AS target_application,
    pc.elt                        AS entitlement_filter_xml
FROM spt_bundle biz
JOIN spt_bundle_requirements br  ON biz.id = br.bundle
JOIN spt_bundle it               ON br.child = it.id
JOIN spt_profile p               ON it.id = p.bundle_id
JOIN spt_application prof_app    ON p.application = prof_app.id
LEFT JOIN spt_profile_constraints pc ON p.id = pc.profile
WHERE biz.type = 'business'
  AND biz.id IN (
      -- Roles detected or assigned to "A" account owners
      SELECT ib.bundle
      FROM spt_identity_bundles ib
      JOIN spt_link l ON ib.identity_id = l.identity_id
      JOIN spt_application app ON l.application = app.id
      WHERE l.native_identity LIKE 'PRIV\\_%\\_A'
        AND app.name = 'Active Directory'
  )
ORDER BY biz.name, it.name;
```

---

## Query 6: Combined Dashboard View

A single query that produces one row per "A" account + entitlement/permission combination, with role context. This is the dashboard-ready dataset.

```sql
SELECT
    -- Identity info
    i.name                        AS identity_name,
    i.display_name                AS full_name,
    i.email,
    i.extended1                   AS employee_number,
    mgr.display_name              AS manager_name,
    i.inactive                    AS identity_inactive,

    -- "A" account info
    l.native_identity             AS priv_account_name,
    FROM_UNIXTIME(l.last_refresh / 1000) AS last_aggregated,

    -- Entitlement / Permission detail
    ie.type                       AS access_type,            -- 'Entitlement' or 'Permission'
    ie.name                       AS attribute_name,
    ie.value                      AS attribute_value,
    COALESCE(ma.display_name,
             ie.display_name,
             ie.value)            AS access_display_name,
    ie.source                     AS how_assigned,
    ie.aggregation_state,
    ie.assigned                   AS directly_assigned,
    ie.granted_by_role            AS from_role

FROM spt_link l
JOIN spt_identity i              ON l.identity_id = i.id
JOIN spt_application app         ON l.application = app.id
LEFT JOIN spt_identity mgr       ON i.manager = mgr.id
LEFT JOIN spt_identity_entitlement ie ON ie.identity_id = i.id
                                      AND ie.application = l.application
                                      AND ie.native_identity = l.native_identity
LEFT JOIN spt_managed_attribute ma ON ma.application = ie.application
                                   AND ma.attribute = ie.name
                                   AND ma.value = ie.value
WHERE l.native_identity LIKE 'PRIV\\_%\\_A'
  AND app.name = 'Active Directory'
  AND i.correlated = 1
  AND i.is_workgroup = 0
ORDER BY i.display_name, ie.type, ie.name, ie.value;
```

**Note:** This uses `LEFT JOIN` on `spt_identity_entitlement` so that "A" accounts with no entitlements still appear in the results (the entitlement columns will be NULL). This helps identify accounts that exist but have no access — which could indicate provisioning issues or freshly created accounts.

---

## Query 7 (Optional): Broader View — All Entitlements Across All Applications

If stakeholders want to see everything the "A" account owner has across **all** applications (not just what the "A" account itself holds), remove the `native_identity` filter:

```sql
SELECT
    i.name                        AS identity_name,
    i.display_name                AS full_name,
    l.native_identity             AS priv_account_name,

    -- This entitlement may be on a different application/account
    ent_app.name                  AS entitlement_application,
    ie.native_identity            AS entitlement_account,
    ie.type                       AS access_type,
    ie.name                       AS attribute_name,
    ie.value                      AS attribute_value,
    COALESCE(ma.display_name,
             ie.display_name,
             ie.value)            AS access_display_name,
    ie.source                     AS how_assigned,
    ie.aggregation_state

FROM spt_link l
JOIN spt_identity i              ON l.identity_id = i.id
JOIN spt_application app         ON l.application = app.id
-- Join entitlements at identity level (all apps, all accounts)
LEFT JOIN spt_identity_entitlement ie ON ie.identity_id = i.id
LEFT JOIN spt_application ent_app    ON ie.application = ent_app.id
LEFT JOIN spt_managed_attribute ma   ON ma.application = ie.application
                                      AND ma.attribute = ie.name
                                      AND ma.value = ie.value
WHERE l.native_identity LIKE 'PRIV\\_%\\_A'
  AND app.name = 'Active Directory'
  AND i.correlated = 1
  AND i.is_workgroup = 0
ORDER BY i.display_name, ent_app.name, ie.native_identity, ie.name, ie.value;
```

**Use case:** "Show me everything Jane Smith has across all systems, given that she owns a privileged 'A' account." This gives the full picture of the identity's access footprint, not just the privileged account's access.

---

## Summary: Which Query to Use

| Need | Query | Scope |
|---|---|---|
| List all "A" accounts and their owners | Query 1 | Account + Identity |
| AD group memberships of "A" accounts | Query 2 | Entitlements on the "A" account only |
| Fine-grained permissions of "A" accounts | Query 3 | Permissions on the "A" account only |
| Which entitlements on "A" came from roles? | Query 4 Approach A | Entitlements on "A" with `granted_by_role = 1` |
| IT roles with AD entitlement profiles | Query 4a | Detected IT roles scoped to AD |
| Business roles requiring AD IT roles | Query 4b | Business roles scoped to AD |
| Assigned roles scoped to AD | Query 4c | Assigned roles scoped to AD |
| All roles relevant to "A" (combined) | Query 4d | Detected + Assigned, AD-scoped |
| What do those roles grant? | Query 5 | Role hierarchy breakdown |
| Dashboard-ready combined dataset | Query 6 | Account + Entitlements + Permissions |
| Full access footprint across all apps | Query 7 (optional) | All entitlements for the identity |

---

## Before You Run: Checklist

- [ ] **Verify your AD application name** — Run `SELECT name FROM spt_application WHERE type LIKE '%Active%' OR name LIKE '%AD%';` to find the exact name
- [ ] **Verify extended attribute mapping** — Confirm which `extended` column maps to employee number: `SELECT extended1, extended2, extended3 FROM spt_identity LIMIT 5;`
- [ ] **Check if `spt_identity_assigned_roles` exists** — Run `SHOW TABLES LIKE 'spt_identity_assigned_roles';` — if it doesn't exist, use Query 4b Option B (XML parsing)
- [ ] **Test the LIKE pattern** — Run `SELECT native_identity FROM spt_link WHERE native_identity LIKE 'PRIV\\_%\\_A' LIMIT 10;` to confirm matches
- [ ] **Check Permission type usage** — Run `SELECT DISTINCT type FROM spt_identity_entitlement;` — if only `Entitlement` appears, Query 3 will return no rows (that's expected)
