# SailPoint IdentityIQ database tables: a complete reference

**Every table in SailPoint IdentityIQ's relational schema uses the `spt_` prefix** (short for SailPoint Technologies), and understanding these tables is essential for writing SQL reports, debugging access issues, and building IAM analytics. This guide covers all major `spt_*` tables organized by functional area, their columns and relationships, entity-relationship patterns, practical SQL examples, and performance guidance tailored for regulated banking environments.

IIQ uses **Hibernate ORM** to map Java objects to database tables. This means each `spt_` table corresponds to a Java class (e.g., `spt_identity` → `sailpoint.object.Identity`), Java camelCase properties become `lower_case_with_underscores` column names, and — critically — **most tables store a significant portion of their data in serialized XML within CLOB columns** rather than in flat relational columns. All primary keys are **VARCHAR(128) GUIDs**, not auto-increment integers. All timestamps are stored as **BIGINT epoch milliseconds** (not native DATE types). The schema supports MySQL, Oracle, MS SQL Server, and DB2.

---

## How the spt_* schema is organized

The IIQ database contains roughly 80–100 `spt_*` tables plus Quartz scheduler tables (`QRTZ221_*`). These fall into ten logical groups that mirror IIQ's functional architecture:

| Functional area | Core tables | What they store |
|---|---|---|
| **Identity & accounts** | `spt_identity`, `spt_link`, `spt_identity_entitlement`, `spt_identity_external_attr` | People, application accounts, entitlement assignments |
| **Applications** | `spt_application`, `spt_schema` | Source/target system definitions and schemas |
| **Roles** | `spt_bundle`, `spt_profile`, `spt_bundle_requirements`, `spt_bundle_permits`, `spt_identity_bundles` | Role definitions, hierarchy, assignments |
| **Entitlement catalog** | `spt_managed_attribute`, `spt_entitlement_group` | Entitlement definitions and metadata |
| **Certifications** | `spt_certification`, `spt_certification_entity`, `spt_certification_item`, `spt_certification_action` | Access review campaigns and decisions |
| **Requests & work items** | `spt_identity_request`, `spt_identity_request_item`, `spt_work_item` | Access requests, approvals, manual tasks |
| **Provisioning & workflow** | `spt_provisioning_transaction`, `spt_workflow_case`, `spt_workflow`, `spt_process_log` | Provisioning history, workflow execution |
| **Audit & logging** | `spt_audit_event`, `spt_syslog_event` | Audit trail and system logs |
| **Policy & SOD** | `spt_policy`, `spt_policy_violation`, `spt_sodconstraint` | Policies, violation records |
| **Configuration & system** | `spt_configuration`, `spt_task_definition`, `spt_task_result`, `spt_rule`, `spt_object_config` | System config, tasks, rules |

Every object inheriting from `SailPointObject` shares a common set of base columns: `id` (VARCHAR(128) PK), `name` (VARCHAR(128), usually unique), `created` and `modified` (BIGINT epoch ms), `owner` (FK → `spt_identity.id`), `description` (CLOB), `assigned_scope` (FK → `spt_scope.id`), and `disabled` (BIT/TINYINT).

---

## Identity and account tables

### spt_identity — the central identity table

This is the **most important table in the entire schema**. Every person, contractor, service account, and workgroup is a row here.

| Column | Type | Description |
|---|---|---|
| `id` | VARCHAR(128) PK | Unique identifier (GUID) |
| `name` | VARCHAR(128) UNIQUE | Identity username (login name) |
| `display_name` | VARCHAR(128) | Full display name |
| `firstname`, `lastname` | VARCHAR(128) | Name components |
| `email` | VARCHAR(128) | Email address |
| `manager` | VARCHAR(128) FK → `spt_identity.id` | Self-referencing FK to manager's identity |
| `type` | VARCHAR(128) | Identity type: Employee, Contractor, Service, etc. |
| `inactive` | TINYINT | Whether identity is inactive (leaver flag) |
| `correlated` | TINYINT | **Critical flag**: 1 = authoritative identity, 0 = orphan account holder |
| `is_workgroup` | TINYINT | 1 = workgroup, not a person |
| `needs_refresh` | TINYINT | Flagged for identity refresh |
| `last_refresh` | BIGINT | Last refresh timestamp |
| `risk_score_weight` | INT | Composite risk score |
| `attributes` | CLOB | **XML blob** containing all non-searchable attributes, role assignments, trigger snapshots |
| `extended1`–`extended10` | VARCHAR(450) | Searchable extended attribute slots (mapped via `IdentityExtended.hbm.xml`) |
| `extended_identity1`–`extended_identity5` | VARCHAR(128) FK | Extended attributes of type Identity |
| `scorecard` | VARCHAR(128) FK → `spt_scorecard.id` | Identity risk scorecard |
| `password` | VARCHAR(450) | Hashed IIQ password |

**Practical notes**: The `correlated` flag is crucial for filtering — **always use `correlated = 1`** to get real identities (not orphan account holders). Workgroups share this table (`is_workgroup = 1`). The `manager` column is a self-referencing FK, enabling manager hierarchy queries. Extended attributes beyond the default 10 slots require Hibernate config changes and schema regeneration via `iiq extendedSchema`.

**Related join tables**: `spt_identity_bundles` (detected roles), `spt_identity_capabilities` (IIQ permissions), `spt_identity_workgroups` (workgroup membership), `spt_identity_controlled_scopes`.

### spt_link — application account records

Each row represents **one account on one application** linked to an identity. An identity with access to 5 applications has 5 rows in `spt_link`.

| Column | Type | Description |
|---|---|---|
| `id` | VARCHAR(128) PK | Unique identifier |
| `identity_id` | VARCHAR(128) FK → `spt_identity.id` | Owning identity |
| `application` | VARCHAR(128) FK → `spt_application.id` | Source application |
| `native_identity` | VARCHAR(322) | Raw account ID on the application (e.g., AD sAMAccountName, LDAP DN) |
| `display_name` | VARCHAR(128) | Friendly account display name |
| `instance` | VARCHAR(128) | Application instance (for multi-instance apps) |
| `attributes` | CLOB | **XML blob** of all account attributes (including `IIQDisabled`, `IIQLocked`) |
| `manually_correlated` | TINYINT | If true, aggregation won't re-correlate this link |
| `entitlements` | TINYINT | Whether this account has entitlement attributes |
| `last_refresh` | BIGINT | Last aggregation date |
| `extended1`–`extended5` | VARCHAR(450) | Searchable extended account attributes |

**Practical notes**: Account-level attributes like disabled status and last login are stored **inside the XML CLOB**, not in flat columns. To extract them in Oracle: `EXTRACT(xmltype(attributes), '/Attributes/Map/entry[@key=''IIQDisabled'']/value')`. This table can grow very large in environments with many applications. The related `spt_link_external_attr` table stores multi-valued extended link attributes (columns: `object_id` FK → `spt_link.id`, `attr_name`, `attr_value`).

### spt_application — source/target system definitions

| Column | Type | Description |
|---|---|---|
| `id` | VARCHAR(128) PK | Unique identifier |
| `name` | VARCHAR(128) UNIQUE | Application name |
| `type` | VARCHAR(255) | Connector type (Active Directory, JDBC, LDAP, Delimited File, etc.) |
| `connector` | VARCHAR(255) | Fully qualified connector class name |
| `features_string` | VARCHAR(512) | Comma-separated supported features (PROVISIONING, ENABLE, DISABLE) |
| `authoritative` | TINYINT | Whether this is an authoritative data source |
| `owner` | VARCHAR(128) FK → `spt_identity.id` | Application owner |
| `attributes` | CLOB | **XML blob** containing connection config, schemas, provisioning policies |
| `correlation_config` | VARCHAR(128) FK | Correlation configuration reference |

**Practical notes**: This is a small reference table. Referenced by `spt_link.application` and `spt_identity_entitlement.application`. The `attributes` CLOB contains sensitive connection parameters (URLs, credentials) — restrict access in reporting databases.

### spt_identity_entitlement — entitlement-to-identity associations

This table records **every entitlement held by every identity** and is typically one of the largest tables in the database.

| Column | Type | Description |
|---|---|---|
| `id` | VARCHAR(128) PK | Unique identifier |
| `identity_id` | VARCHAR(128) FK → `spt_identity.id` | Identity holding the entitlement |
| `application` | VARCHAR(128) FK → `spt_application.id` | Application (null for role-only entries) |
| `name` | VARCHAR(255) | Entitlement attribute name (e.g., `memberOf`, `groups`) |
| `value` | VARCHAR(450) | Entitlement value (e.g., `CN=Finance_Users,OU=Groups,DC=corp`) |
| `display_name` | VARCHAR(128) | Display name |
| `native_identity` | VARCHAR(322) | Account native identity this entitlement belongs to |
| `type` | VARCHAR(128) | `Entitlement` or `Permission` |
| `source` | VARCHAR(128) | How assigned: `Task`, `LCM`, `Rule`, etc. |
| `aggregation_state` | VARCHAR(128) | `Connected` (found on last aggregation) or `Disconnected` |
| `assigned` | TINYINT | Directly assigned (via request) |
| `granted_by_role` | TINYINT | Indirectly granted through a role |
| `certification_item` | VARCHAR(128) FK → `spt_certification_item.id` | Current certification item |
| `request_item` | VARCHAR(128) FK → `spt_identity_request_item.id` | Originating request item |
| `start_date`, `end_date` | BIGINT | Sunrise/sunset dates |

**Practical notes**: This table links to `spt_managed_attribute` not via a direct FK, but through a **logical join on `application` + `value` + `name`** (attribute). The `aggregation_state` column helps identify stale entitlements. Expect **millions of rows** in large environments — always filter early on `identity_id` or `application`.

### spt_identity_external_attr and spt_identity_snapshot

**`spt_identity_external_attr`** stores multi-valued extended identity attributes as separate rows (columns: `object_id` FK → `spt_identity.id`, `attr_name`, `attr_value`). It does not inherit from `SailPointObject`.

**`spt_identity_snapshot`** stores historical point-in-time snapshots of identity state as serialized XML. Contains `identity_id`, `identity_name`, `created`, and an `attributes` CLOB with the complete identity XML at snapshot time. **This table can grow extremely large** and must be pruned regularly — set snapshot expiration to match your shortest certification cycle.

---

## Roles and the bundle model

In IIQ, roles are called **Bundles** throughout the database and codebase. The role model uses a hierarchy: Business Roles → (require/permit) → IT Roles → (contain) → Entitlement Profiles.

### spt_bundle — role definitions

| Column | Type | Description |
|---|---|---|
| `id` | VARCHAR(128) PK | Unique identifier |
| `name` | VARCHAR(128) UNIQUE | Role name |
| `display_name` | VARCHAR(128) | Display name |
| `type` | VARCHAR(128) | Role type: `business`, `it`, `organizational`, or custom |
| `disabled` | TINYINT | Whether role is disabled |
| `requestable` | TINYINT | Whether requestable via LCM self-service |
| `risk_score_weight` | INT | Risk weight for scoring |
| `activation_date`, `deactivation_date` | BIGINT | Sunrise/sunset dates |
| `owner` | VARCHAR(128) FK → `spt_identity.id` | Role owner |
| `selector` | CLOB | XML IdentitySelector for auto-assignment (business roles) |
| `attributes` | CLOB | Extended attributes XML |

### Role hierarchy join tables

| Table | Columns | Purpose |
|---|---|---|
| `spt_bundle_requirements` | `bundle` FK → parent, `child` FK → required role | IT roles **required** by a business role |
| `spt_bundle_permits` | `bundle` FK → parent, `child` FK → permitted role | IT roles **permitted** (optional) by a business role |
| `spt_bundle_children` | `bundle` FK → parent, `child` FK → inheriting role | Role inheritance hierarchy |

### spt_profile and spt_profile_constraints — entitlement profiles

`spt_profile` defines what entitlements on an application constitute an IT role. Columns: `id`, `bundle_id` (FK → `spt_bundle`), `application` (FK → `spt_application`). The child table `spt_profile_constraints` contains `profile` (FK) and `elt` (CLOB with serialized Filter XML defining entitlement matching criteria).

### spt_identity_bundles — detected role assignments

This join table maps identities to their **detected** roles: `identity_id` (FK → `spt_identity.id`) and `bundle` (FK → `spt_bundle.id`). Detected roles are calculated during Identity Refresh based on entitlement matching against role profiles.

**Assigned roles** (explicitly granted via request or manual assignment) are stored differently — they live in the Identity's `attributes` XML as `RoleAssignment` objects with properties including assigner, date, source, and sunrise/sunset dates. Some IIQ versions also use an `spt_identity_assigned_roles` table.

### spt_role_index — role statistics

Populated by the Refresh Role Scorecard task. Contains `bundle` (FK), `assigned_count`, `detected_count`, `entitlement_count`, `last_certified_membership`, `last_assigned`, and other metrics useful for role analytics and governance dashboards.

---

## Entitlement catalog: spt_managed_attribute

This is the **entitlement catalog** — each row represents a unique entitlement definition aggregated from applications.

| Column | Type | Description |
|---|---|---|
| `id` | VARCHAR(128) PK | Unique identifier |
| `application` | VARCHAR(128) FK → `spt_application.id` | Source application |
| `attribute` | VARCHAR(128) | Schema attribute name (`memberOf`, `groups`, etc.) |
| `value` | VARCHAR(450) | Entitlement value |
| `display_name` | VARCHAR(128) | Friendly name |
| `type` | VARCHAR(128) | `Entitlement` or `Permission` |
| `requestable` | TINYINT | Available for self-service request |
| `owner` | VARCHAR(128) FK → `spt_identity.id` | Entitlement owner (used in approvals) |
| `description` | CLOB | Description |
| `extended1`–`extendedN` | VARCHAR(450) | Searchable extended attributes |

**The unique key is logically `(application, attribute, value)`.** This table connects to `spt_identity_entitlement` through a logical join — not a foreign key — on `application` + `value` + attribute name. Populated during group/entitlement aggregation tasks.

---

## Certification and access review tables

Certification data flows through a well-defined hierarchy of six tables, from campaign definition down to individual decisions.

### The certification table chain

```
spt_certification_definition  (campaign template)
        ↓
spt_certification_group  (campaign instance)
        ↓  via spt_certification_groups (join table)
spt_certification  (individual access review per reviewer)
        ↓
spt_certification_entity  (each identity being reviewed)
        ↓
spt_certification_item  (each entitlement/role under review)
        ↓
spt_certification_action  (reviewer's decision)
```

### spt_certification — individual access reviews

| Column | Type | Description |
|---|---|---|
| `id` | VARCHAR(128) PK | Unique identifier |
| `name`, `short_name` | VARCHAR(256) | Certification name |
| `type` | VARCHAR(128) | Manager, ApplicationOwner, Entitlement, RoleMembership, Targeted, etc. |
| `manager` | VARCHAR(128) | **Reviewer's identity name** (not an FK — join on `spt_identity.name`) |
| `certification_definition_id` | VARCHAR(128) FK | Campaign definition reference |
| `phase` | VARCHAR(128) | Active, Challenge, Remediation, End, Signed |
| `activated`, `expiration`, `signed`, `finished` | BIGINT | Key date milestones |
| `total_entities`, `completed_entities`, `percent_complete` | INT | Entity-level completion metrics |
| `total_items`, `completed_items`, `item_percent_complete` | INT | Item-level completion metrics |
| `remediations_kicked_off`, `remediations_completed` | INT | Remediation tracking |

**Important**: The `manager` column stores the identity **name string**, not an ID. Join with `spt_identity.name = spt_certification.manager`.

### spt_certification_entity — identities under review

Contains `certification_id` (FK → `spt_certification`), `target_id`, `target_name`, `target_display_name`, `firstname`, `lastname`, `summary_status`, and `completed` timestamp. One row per identity per certification.

### spt_certification_item — individual access items

Contains `certification_entity_id` (FK → `spt_certification_entity`), `type` (Exception, Bundle, PolicyViolation, Account), `exception_application`, `exception_attribute_name`, `exception_attribute_value`, `summary_status`, and `action` (FK → `spt_certification_action`). Supports extended attributes (`extended1`–`extendedN`). **This table grows very large** with each certification campaign.

### spt_certification_action — reviewer decisions

Contains `status` (Approved, Remediated, Mitigated, Delegated, RevokeAccount), `decision_date`, `actor_name`, `comments`, `remediation_action`, and `remediation_details`.

### Supporting certification tables

**`spt_certification_definition`**: Campaign template with schedule and scope configuration in the `attributes` CLOB. **`spt_certification_group`**: Campaign instance linking to the definition and individual certifications via the `spt_certification_groups` join table. **`spt_certification_challenge`**: Records challenges raised against revocation decisions. **`spt_certification_delegation`**: Records when reviewers delegate items to others. **`spt_certification_archive`**: Stores archived certification data as compressed XML CLOBs for long-term retention.

---

## Requests, work items, and provisioning

### spt_identity_request — access request records

| Column | Type | Description |
|---|---|---|
| `id` | VARCHAR(128) PK | Unique identifier |
| `name` | VARCHAR(128) | Request ID (e.g., "0000002168") — uses `spt_identity_request_sequence` |
| `state` | VARCHAR(128) | Init, Approve, Provision, Notify, Complete |
| `type` | VARCHAR(128) | AccessRequest, EntitlementRequest, AccountRequest, RolesRequest, IdentityCreateRequest, IdentityEditRequest |
| `requester_display_name`, `requester_id` | VARCHAR | Requester info |
| `target_id`, `target_display_name` | VARCHAR | Target identity |
| `completion_status` | VARCHAR(128) | Success, Failure, Incomplete |
| `execution_status` | VARCHAR(128) | Executing, Verifying, Terminated, Complete |
| `external_ticket_id` | VARCHAR | External ticketing system reference |
| `end_date` | BIGINT | Completion date |
| `attributes` | CLOB | XML containing approval summaries, final provisioning project, errors |

### spt_identity_request_item — individual request line items

Contains `identity_request_id` (FK → `spt_identity_request`), `application`, `native_identity`, `name` (attribute name), `value`, `operation` (Add, Remove, Set, Create, Delete), `approval_state`, `provisioning_state` (Pending, Finished, Failed), `approver_name`, `owner_name`, `start_date`, `end_date`.

### spt_work_item — approvals and manual tasks

| Column | Type | Description |
|---|---|---|
| `id` | VARCHAR(128) PK | Unique identifier |
| `name` | VARCHAR(128) | Work item title |
| `type` | VARCHAR(128) | Approval, Certification, Remediation, Challenge, PolicyViolation, Delegation, Form, Event |
| `state` | VARCHAR(128) | Null while open; Finished, Rejected, Expired when complete |
| `owner` | VARCHAR(128) FK → `spt_identity.id` | Assigned identity or workgroup |
| `assignee` | VARCHAR(128) FK → `spt_identity.id` | Actual assignee (when owner is a workgroup) |
| `requester` | VARCHAR(128) FK → `spt_identity.id` | Who created the work item |
| `workflow` | VARCHAR(128) FK → `spt_workflow_case.id` | Associated workflow instance |
| `description` | CLOB | Task description |
| `expiration` | BIGINT | Expiration date |
| `identity_request_id` | VARCHAR(128) | Related identity request |
| `certification` | VARCHAR(128) FK | Related certification |
| `attributes` | CLOB | XML containing ApprovalSet and other data |

**Practical notes**: Open work items have `state IS NULL`. Completed items move to `spt_work_item_archive`, which mirrors the same structure but uses string names instead of FKs (so data persists even after identity deletion).

### spt_provisioning_transaction — provisioning audit trail

Tracks all provisioning operations. Key columns: `operation`, `source` (LCM, Certification, Workflow, UI), `application_name`, `identity_name`, `native_identity`, `status` (Success, Pending, Failed), `type` (Manual or Auto), `certification_id`. Controlled by system configuration for what gets logged. **Pruned by the "days before provisioning transaction event deletion" setting.**

### spt_workflow_case — running workflow instances

Represents an active or completed workflow execution. Contains `name`, `launcher` (who started it), `target_class`/`target_id`/`target_name` (associated object), `complete` flag, and crucially a `workflow` CLOB that embeds the **entire workflow definition XML**. Completed cases can be cleaned by the Perform Maintenance task.

### spt_workflow and spt_task_definition

`spt_workflow` stores workflow definitions (type, steps, variables as XML). `spt_task_definition` stores task configurations: `name`, `type` (AccountAggregation, Identity, Report, System), `executor` (Java class), and `arguments` (XML config). `spt_task_result` records execution results with `completion_status` (Success, Warning, Error, Terminated), `launched`/`completed` timestamps, and result data in `attributes` CLOB.

---

## Audit and logging tables

### spt_audit_event — the governance audit trail

| Column | Type | Description |
|---|---|---|
| `id` | VARCHAR(128) PK | Unique identifier |
| `created` | BIGINT | Event timestamp |
| `source` | VARCHAR(128) | Actor/system that generated the event |
| `action` | VARCHAR(128) | Action type: Login, IdentityEdit, RoleCreate, CertificationSignoff, etc. |
| `target` | VARCHAR(128) | Target entity of the action |
| `application` | VARCHAR(128) | Application name involved |
| `account_name` | VARCHAR(128) | Account name involved |
| `attribute_name`, `attribute_value` | VARCHAR | Modified attribute details |
| `tracking_id` | VARCHAR(128) | Tracking identifier for correlated events |
| `interface` | VARCHAR(128) | Interface used (UI, API, etc.) |
| `string1`–`string4` | VARCHAR | Custom data fields for custom audit events |

**Critical warning**: This table has **no out-of-the-box pruning mechanism**. It grows indefinitely. You must implement custom cleanup SQL or archive to a data warehouse. For banking environments, export to SIEM before purging. Audit events are only recorded for actions enabled in the AuditConfig object (Setup → Global Settings → Audit Configuration).

### spt_syslog_event — system error and warning log

Contains `message`, `quick_key` (for fast searching), `server`, `classname`, `line_number`, `stack_trace` (CLOB), `event_level` (FATAL, ERROR, WARN), and `username`. **Pruned automatically** by the System Maintenance task based on the "days before syslog event deletion" setting. Can grow very fast in busy environments.

---

## Policy and SOD tables

**`spt_policy`** stores policy definitions with `type` (SOD, Activity, Risk, Advanced), `executor` class, and XML configuration. References `spt_rule` for violation formatting and `spt_workflow` for violation handling.

**`spt_policy_violation`** records detected violations: `identity` (FK → `spt_identity`), `policy_id`, `policy_name`, `constraint_name`, `status` (Open, Mitigated, Remediated), `active` flag, `left_bundles`/`right_bundles` (for SOD conflicts), and `mitigator` name.

**`spt_sodconstraint`** defines the left/right role lists within an SOD policy: `policy` (FK → `spt_policy`), `left_bundles`, `right_bundles`, and `compensation_rule` (FK → `spt_rule`).

---

## Entity-relationship overview: how core tables connect

The heart of the IIQ data model is a hub-and-spoke pattern centered on `spt_identity`:

```
                        spt_identity_snapshot
                              ↑ (identity_id)
                              |
spt_bundle ←── spt_identity_bundles ──→ spt_identity ←── spt_policy_violation
    ↑                                    |    |    |
    |                                    |    |    └──→ spt_work_item (owner)
spt_profile                              |    |
    ↑                                    |    └──→ spt_identity_request (target_id)
spt_profile_constraints                  |              ↓
                                         |    spt_identity_request_item
                                         |
            ┌────────────────────────────┤
            ↓                            ↓
      spt_link                   spt_identity_entitlement
      (identity_id)              (identity_id)
            |                            |
            ↓                            ↓ (logical join on application + value)
      spt_application ←─────── spt_managed_attribute
            
spt_certification_definition → spt_certification_group
        → spt_certification → spt_certification_entity
        → spt_certification_item → spt_certification_action
```

**Key join paths for common queries**:

- **Identity → Accounts**: `spt_identity.id = spt_link.identity_id`, then `spt_link.application = spt_application.id`
- **Identity → Entitlements**: `spt_identity.id = spt_identity_entitlement.identity_id`, then `spt_identity_entitlement.application = spt_application.id`
- **Entitlement details**: `spt_identity_entitlement.application = spt_managed_attribute.application AND spt_identity_entitlement.value = spt_managed_attribute.value AND spt_identity_entitlement.name = spt_managed_attribute.attribute`
- **Identity → Detected roles**: `spt_identity.id = spt_identity_bundles.identity_id`, then `spt_identity_bundles.bundle = spt_bundle.id`
- **Role → Required entitlements**: `spt_bundle.id = spt_bundle_requirements.bundle → spt_bundle (IT role) → spt_profile.bundle_id → spt_profile_constraints`
- **Certification items**: Chain through `spt_certification → spt_certification_entity → spt_certification_item → spt_certification_action`
- **Request tracking**: `spt_identity_request.id = spt_identity_request_item.identity_request_id`

---

## Common SQL query patterns

### Identities with their manager

```sql
SELECT 
    i.name AS identity_name,
    i.display_name,
    i.firstname,
    i.lastname,
    i.email,
    i.inactive,
    i.extended1 AS employee_id,
    i.extended2 AS department,
    mgr.name AS manager_name,
    mgr.display_name AS manager_display_name
FROM spt_identity i
LEFT JOIN spt_identity mgr ON i.manager = mgr.id
WHERE i.correlated = 1
  AND i.is_workgroup = 0;
```

### All accounts per identity

```sql
SELECT 
    i.name AS identity_name,
    app.name AS application_name,
    l.native_identity AS account_id,
    l.display_name AS account_display_name
FROM spt_identity i
JOIN spt_link l ON i.id = l.identity_id
JOIN spt_application app ON l.application = app.id
WHERE i.correlated = 1
ORDER BY i.name, app.name;
```

### Identities with multiple accounts on the same application

```sql
SELECT 
    i.name AS identity_name,
    app.name AS application_name,
    COUNT(*) AS account_count
FROM spt_link l
JOIN spt_identity i ON i.id = l.identity_id
JOIN spt_application app ON app.id = l.application
WHERE i.correlated = 1
GROUP BY i.name, app.name
HAVING COUNT(*) > 1;
```

### Complete entitlement report per identity

```sql
SELECT 
    i.name AS user_id,
    app.name AS application_name,
    ie.native_identity AS account_id,
    ie.name AS entitlement_attribute,
    ie.value AS entitlement_value,
    ma.display_name AS entitlement_display_name,
    ie.source,
    ie.assigned,
    ie.granted_by_role
FROM spt_identity_entitlement ie
JOIN spt_identity i ON ie.identity_id = i.id
JOIN spt_application app ON ie.application = app.id
LEFT JOIN spt_managed_attribute ma 
    ON ma.application = ie.application 
    AND ma.value = ie.value
    AND ma.attribute = ie.name
WHERE i.correlated = 1
ORDER BY i.name, app.name;
```

### Role assignments (detected roles)

```sql
SELECT 
    i.name AS username,
    mgr.name AS manager,
    b.name AS role_name,
    b.display_name AS role_display_name,
    b.type AS role_type,
    b.disabled AS role_disabled
FROM spt_identity i
JOIN spt_identity_bundles ib ON i.id = ib.identity_id
JOIN spt_bundle b ON b.id = ib.bundle
LEFT JOIN spt_identity mgr ON i.manager = mgr.id
WHERE i.correlated = 1
ORDER BY i.name;
```

### Business role → IT role → entitlement hierarchy

```sql
SELECT 
    biz.name AS business_role,
    it.name AS it_role,
    app.name AS application,
    pc.elt AS entitlement_filter
FROM spt_bundle biz
JOIN spt_bundle_requirements br ON biz.id = br.bundle
JOIN spt_bundle it ON br.child = it.id
JOIN spt_profile p ON it.id = p.bundle_id
JOIN spt_application app ON p.application = app.id
JOIN spt_profile_constraints pc ON p.id = pc.profile
WHERE biz.type = 'business';
```

### Certification campaign progress

```sql
SELECT 
    cd.name AS campaign_name,
    c.short_name AS cert_name,
    c.manager AS reviewer,
    c.phase,
    c.total_entities,
    c.percent_complete,
    c.total_items,
    c.item_percent_complete,
    c.remediations_kicked_off,
    c.remediations_completed
FROM spt_certification c
JOIN spt_certification_definition cd ON c.certification_definition_id = cd.id
ORDER BY c.activated DESC;
```

### Certification decisions with full detail

```sql
SELECT 
    c.short_name AS cert_name,
    ce.target_name AS user_reviewed,
    ci.exception_application AS application,
    ci.exception_attribute_value AS entitlement,
    ci.summary_status AS item_status,
    ca.status AS decision,
    ca.actor_name AS decided_by,
    ca.comments AS decision_comments
FROM spt_certification c
JOIN spt_certification_entity ce ON ce.certification_id = c.id
JOIN spt_certification_item ci ON ci.certification_entity_id = ce.id
LEFT JOIN spt_certification_action ca ON ca.id = ci.action
WHERE ca.status IS NOT NULL;
```

### Access request history with line items

```sql
SELECT 
    ir.name AS request_id,
    ir.type,
    ir.requester_display_name,
    ir.target_display_name,
    ir.state,
    ir.completion_status,
    iri.application,
    iri.name AS attribute_name,
    iri.value AS attribute_value,
    iri.operation,
    iri.provisioning_state
FROM spt_identity_request ir
JOIN spt_identity_request_item iri ON ir.id = iri.identity_request_id
ORDER BY ir.created DESC;
```

### Open work items (pending approvals)

```sql
SELECT 
    wi.name AS work_item,
    wi.type,
    owner.name AS assigned_to,
    requester.name AS requested_by,
    wi.description,
    wi.identity_request_id
FROM spt_work_item wi
LEFT JOIN spt_identity owner ON wi.owner = owner.id
LEFT JOIN spt_identity requester ON wi.requester = requester.id
WHERE wi.state IS NULL
ORDER BY wi.created DESC;
```

### Active policy violations

```sql
SELECT 
    i.name AS identity_name,
    i.display_name,
    pv.policy_name,
    pv.constraint_name,
    pv.status,
    pv.left_bundles,
    pv.right_bundles,
    pv.mitigator
FROM spt_policy_violation pv
JOIN spt_identity i ON pv.identity = i.id
WHERE pv.active = 1
ORDER BY pv.created DESC;
```

### Orphan (uncorrelated) accounts

```sql
SELECT 
    l.native_identity AS account_name,
    app.name AS application_name,
    i.name AS identity_cube_name,
    i.display_name
FROM spt_link l
JOIN spt_application app ON l.application = app.id
JOIN spt_identity i ON l.identity_id = i.id
WHERE i.correlated = 0
ORDER BY app.name;
```

### Audit trail query

```sql
SELECT 
    ae.action,
    ae.source,
    ae.target,
    ae.application,
    ae.account_name,
    ae.attribute_name,
    ae.attribute_value,
    ae.string1,
    ae.string2,
    ae.tracking_id
FROM spt_audit_event ae
ORDER BY ae.created DESC;
```

---

## Tips for querying the IIQ database in a banking environment

### Timestamp conversion is mandatory for every date column

All dates are **BIGINT epoch milliseconds**. Use these conversions in every query:

| Database | Conversion expression |
|---|---|
| **Oracle** | `TO_DATE('1970-01-01','YYYY-MM-DD') + (column_name / 1000 / 86400)` |
| **SQL Server** | `DATEADD(SECOND, column_name / 1000, '1970-01-01')` |
| **MySQL** | `FROM_UNIXTIME(column_name / 1000)` |

**Performance tip**: When filtering by date range, compute the epoch millisecond boundaries in your WHERE clause rather than converting every row's timestamp.

### Handling XML/CLOB columns

Many critical attributes exist only inside XML CLOBs. **Avoid scanning CLOBs across large tables** — a CLOB parse on `spt_link.attributes` across millions of rows will be extremely slow. Instead:

- **Make critical attributes searchable**: Configure them as extended attributes so they get dedicated indexed columns via `IdentityExtended.hbm.xml` and `iiq extendedSchema`
- **Oracle XML extraction**: `EXTRACT(xmltype(attributes), '/Attributes/Map/entry[@key=''IIQDisabled'']/value')`
- **SQL Server**: Cast to XML then use `.value()` and `.query()` methods
- **ETL approach**: For regular reporting, build ETL jobs that extract needed CLOB values into flat reporting tables nightly

### Tables that grow largest and require monitoring

- **`spt_identity_entitlement`** — one row per entitlement per identity; easily millions of rows
- **`spt_audit_event`** — grows indefinitely with no built-in pruning
- **`spt_syslog_event`** — every error/warning; configure minimum level and pruning days
- **`spt_certification_item`** — grows with each certification campaign
- **`spt_identity_snapshot`** — full XML snapshots; prune aggressively
- **`spt_task_result`** — especially report results with large CLOB payloads
- **`spt_provisioning_transaction`** — all provisioning history

### Assigned roles versus detected roles

This distinction catches many analysts off guard. **Detected roles** (`spt_identity_bundles`) are calculated during Identity Refresh when an identity's entitlements match a role profile — the identity didn't necessarily request the role. **Assigned roles** are explicitly granted and stored in the Identity's `attributes` XML as `RoleAssignment` objects (some versions also use `spt_identity_assigned_roles`). A role can be both assigned and detected simultaneously.

### The correlated flag is your most important filter

`spt_identity.correlated = 1` identifies real, authoritative identities. When IIQ aggregates an account it cannot correlate, it creates a **new uncorrelated identity** (`correlated = 0`) as a placeholder. Failing to filter on this flag inflates identity counts and produces misleading reports. Always include `WHERE i.correlated = 1 AND i.is_workgroup = 0` unless you specifically need workgroups or orphan accounts.

### IIQ does not use soft deletes in the traditional sense

There is no `deleted` flag on most tables. When an identity is removed, its `spt_identity` row is hard-deleted, but orphan records in child tables may linger. `spt_identity.inactive = 1` marks a leaver but the record persists — this is the closest equivalent to a soft delete. Certification data can be archived (serialized to `spt_certification_archive`) before removal from active tables.

### Data retention and compliance recommendations

| Data type | Recommended practice |
|---|---|
| Identity snapshots | Set expiration to match shortest cert cycle; prune weekly |
| Certifications | Archive after 2 complete cycles; separate archive and delete steps |
| Syslog events | 30–90 day retention based on operational needs |
| Audit events | Archive to SIEM/data warehouse before custom deletion |
| Provisioning transactions | Retain per regulatory requirements (often 7 years for banking) |
| Identity requests | Configure max age via "Perform Identity Request Maintenance" task |
| Task results | Delete after longest scheduled task interval |

### Best practices for read-only reporting access

**Never run heavy analytical queries against the production IIQ database.** Use a read replica or nightly ETL to a reporting warehouse. Create a dedicated read-only database user with SELECT-only privileges on `spt_*` tables. Restrict access to `spt_application` (contains connection credentials in XML) and `spt_identity` (contains PII and password hashes). Log all reporting database query activity for audit purposes. Use connection pooling limits to prevent reporting queries from starving the IIQ application.

### Useful diagnostic tools

The **IIQ Console** (`iiq console`) supports both HQL and SQL queries for rapid debugging. IIQ's **Debug Pages** allow viewing raw XML of any object, invaluable for understanding what lives in CLOBs versus flat columns. The **Instrumental Identity Query Plugin** (open-source) provides an in-browser SQL/HQL query tool within the IIQ UI. The `spt_database_version` table tracks the current IIQ schema version — always verify this matches your documentation.

---

## Conclusion

The SailPoint IIQ database schema is fundamentally a **hybrid relational-XML store**: flat indexed columns exist for searchability and joins, while the bulk of object data lives in serialized XML CLOBs managed by Hibernate. The most productive approach for an IAM analytics team is to master the core join paths (`spt_identity` → `spt_link` → `spt_application`, `spt_identity` → `spt_identity_entitlement` → `spt_managed_attribute`, and the certification chain), build reusable reporting views around these joins, and establish an ETL pipeline to a dedicated reporting database that extracts critical CLOB-stored attributes into queryable columns. In a banking context, the `spt_audit_event` and `spt_provisioning_transaction` tables deserve special architectural attention — they are your primary evidence for regulatory audits but have no self-managing retention, requiring deliberate archival strategy from day one.