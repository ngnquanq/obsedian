# IIQ Data Flows: Process-Level Data Movement

This document describes what happens in the database when key SailPoint IIQ business processes execute. Each section follows a consistent format: business context, trigger, step-by-step data flow through tables, state transitions, an ASCII flow diagram, and indicators for analysts. For table structures, see [IIQ.md](IIQ.md). For field value meanings, see [IIQ-Field-Values.md](IIQ-Field-Values.md). For business concepts, see [IIQ-Concepts.md](IIQ-Concepts.md).

---

## 1. Aggregation Flow

### Business Context

Aggregation is IIQ's **data import** process — it pulls accounts and entitlements from connected applications into the IIQ database. This is the foundation of everything else: IIQ cannot govern access it doesn't know about.

There are two types:
- **Account aggregation** — Imports accounts and their attributes into `spt_link`
- **Entitlement/Group aggregation** — Imports the entitlement catalog (group definitions) into `spt_managed_attribute`

### Trigger

Scheduled task (`spt_task_definition` with type `AccountAggregation` or `GroupAggregation`), or manual execution from the UI.

### Step-by-Step Data Flow

```
Step 1: Task starts
   └─→ spt_task_result: new row created (completion_status = null)

Step 2: Connector pulls accounts from target application
   └─→ For each account returned:

Step 3: Account matching
   └─→ Looks for existing spt_link row matching (application + native_identity)
       ├─→ Found: UPDATE spt_link (attributes CLOB, last_refresh, extended columns)
       └─→ Not found: INSERT new spt_link row

Step 4: Identity correlation (if new account)
   └─→ Runs correlation rules to find matching spt_identity
       ├─→ Match found: Set spt_link.identity_id = matched identity
       └─→ No match: Create new spt_identity (correlated = 0)

Step 5: Entitlement processing (for each account)
   └─→ Reads entitlement attributes (e.g., memberOf, groups)
       └─→ For each entitlement value:
           ├─→ spt_managed_attribute: Create if not exists (catalog entry)
           └─→ spt_identity_entitlement:
               ├─→ EXISTS and still on account: SET aggregation_state = 'Connected'
               ├─→ EXISTS but not on account: SET aggregation_state = 'Disconnected'
               └─→ Not exists: INSERT (aggregation_state = 'Connected')

Step 6: Delta processing
   └─→ Entitlements in spt_identity_entitlement for this identity/application
       that were NOT seen during this aggregation:
       └─→ SET aggregation_state = 'Disconnected'

Step 7: Identity refresh flags
   └─→ spt_identity.needs_refresh = 1 (for affected identities)

Step 8: Task completion
   └─→ spt_task_result: UPDATE completion_status, progress stats, timestamps
```

### State Transitions

**`spt_identity_entitlement.aggregation_state`:**
```
null → Connected      (first aggregation finds this entitlement)
Connected → Connected (subsequent aggregation confirms it)
Connected → Disconnected (aggregation no longer finds it)
Disconnected → Connected (entitlement reappears in next aggregation)
```

### Flow Diagram

```
┌──────────────┐     ┌──────────────────────┐
│ Target       │────→│ IIQ Connector        │
│ Application  │     └──────────┬───────────┘
│ (AD, SAP...) │                │
└──────────────┘                ↓
                    ┌───────────────────────┐
                    │ Account Data          │
                    │ (accounts + groups)   │
                    └───────┬───────┬───────┘
                            │       │
              ┌─────────────┘       └─────────────┐
              ↓                                   ↓
    ┌──────────────────┐              ┌────────────────────────┐
    │ spt_link         │              │ spt_managed_attribute  │
    │ (account records)│              │ (entitlement catalog)  │
    └────────┬─────────┘              └────────────────────────┘
             │                                    │
             ↓                                    ↓
    ┌──────────────────────────────────────────────────────┐
    │ spt_identity_entitlement                             │
    │ (per-identity entitlement assignments)               │
    └──────────────────────────┬───────────────────────────┘
                               │
                               ↓
                    ┌──────────────────────┐
                    │ spt_identity          │
                    │ (needs_refresh = 1)   │
                    └──────────────────────┘
```

### Analyst Indicators

- **Aggregation freshness**: `SELECT app.name, MAX(l.last_refresh) FROM spt_link l JOIN spt_application app ON l.application = app.id GROUP BY app.name` — shows last aggregation per app
- **Disconnected entitlements spike**: A sudden increase in `aggregation_state = 'Disconnected'` for one app may indicate an aggregation problem, not actual access removal
- **Task result check**: Query `spt_task_result` for the aggregation task to see counts processed, errors, and warnings

---

## 2. Correlation and Identity Refresh

### Business Context

After aggregation populates `spt_link` and `spt_identity_entitlement`, **Identity Refresh** recalculates derived data for each identity: role detection, risk scores, policy violation checks, and manager mapping. This is the process that makes the Identity Cube current.

### Trigger

Identity Refresh task (`spt_task_definition`), or automatically after aggregation if configured. Also triggered when `spt_identity.needs_refresh = 1`.

### Step-by-Step Data Flow

```
Step 1: Task starts
   └─→ spt_task_result: new row

Step 2: For each identity with needs_refresh = 1 (or all if full refresh):

Step 3: Attribute promotion
   └─→ Reads spt_link rows for this identity
   └─→ Promotes authoritative source attributes to spt_identity columns
       (display_name, firstname, lastname, email, manager, type, extended*)
   └─→ spt_identity: UPDATE promoted attributes

Step 4: Manager resolution
   └─→ Resolves manager reference (looks up manager identity)
   └─→ spt_identity.manager = resolved manager's identity ID

Step 5: Role detection
   └─→ Compares identity's entitlements against all role profiles
       (spt_profile + spt_profile_constraints)
   └─→ spt_identity_bundles:
       ├─→ Entitlements match profile: INSERT or keep row (role detected)
       └─→ Entitlements no longer match: DELETE row (role no longer detected)

Step 6: Risk score calculation
   └─→ Calculates composite risk from entitlements, roles, policy violations
   └─→ spt_identity.risk_score_weight = new score
   └─→ spt_scorecard: UPDATE risk metrics

Step 7: Policy violation check
   └─→ Evaluates SOD and other policies against current access
   └─→ spt_policy_violation:
       ├─→ New violation: INSERT (status = 'Open', active = 1)
       ├─→ Existing violation still valid: No change
       └─→ Previous violation no longer applies: SET active = 0

Step 8: Identity attributes XML
   └─→ spt_identity.attributes: UPDATE XML CLOB with current state
       (role assignments, trigger snapshots, calculated attributes)

Step 9: Cleanup
   └─→ spt_identity.needs_refresh = 0
   └─→ spt_identity.last_refresh = current epoch ms

Step 10: Task completion
   └─→ spt_task_result: UPDATE completion_status
```

### State Transitions

**`spt_identity.correlated`:**
```
0 → 1  (correlation rule matches this identity to an authoritative record)
1 → 1  (subsequent refreshes confirm correlation)
```
Once correlated, an identity typically stays correlated.

**`spt_policy_violation.active`:**
```
null → 1 (new violation detected)
1 → 0    (violation no longer applies — access changed or policy changed)
0 → 1    (rare — violation reappears after remediation reversed)
```

### Flow Diagram

```
┌──────────────────┐     ┌──────────────────┐
│ spt_link          │────→│                  │
│ (account data)    │     │   Identity       │
└──────────────────┘     │   Refresh        │
                          │   Engine         │
┌───────────────────────┐ │                  │
│ spt_identity_         │→│                  │
│ entitlement           │ └────┬────┬────┬───┘
│ (current access)      │      │    │    │
└───────────────────────┘      │    │    │
                               ↓    ↓    ↓
                ┌──────────┐ ┌────┐ ┌────────────────┐
                │spt_      │ │spt_│ │spt_policy_     │
                │identity_ │ │iden│ │violation       │
                │bundles   │ │tity│ │(new violations)│
                │(detected │ │(up-│ └────────────────┘
                │ roles)   │ │date│
                └──────────┘ │d)  │
                             └────┘
```

### Analyst Indicators

- **Stale identities**: `WHERE needs_refresh = 1 AND last_refresh < (threshold)` — identities stuck waiting for refresh
- **Role detection changes**: Compare `spt_identity_bundles` counts before/after refresh to spot mass role changes
- **New policy violations**: `WHERE active = 1 AND status = 'Open' AND created > (last_refresh_time)` — violations from this cycle

---

## 3. Joiner-Mover-Leaver Lifecycle

### Business Context

The **Joiner-Mover-Leaver (JML)** lifecycle handles the three major identity transitions: new hire, internal transfer, and departure. This is typically driven by changes in the authoritative source (HR system).

### Trigger

Aggregation from the authoritative application detects a new record, attribute change, or termination flag. Lifecycle events may also be triggered by scheduled tasks or manual actions.

### Joiner Flow

```
Step 1: Authoritative aggregation detects new employee record
   └─→ No matching spt_identity found

Step 2: Identity creation
   └─→ spt_identity: INSERT new row
       (correlated = 1, inactive = 0, attributes from HR feed)

Step 3: spt_link creation
   └─→ spt_link: INSERT row for authoritative application
       (identity_id = new identity, application = authoritative app)

Step 4: Birthright role assignment (if configured)
   └─→ Lifecycle rule evaluates identity attributes (department, type, location)
   └─→ spt_identity.attributes XML: Role assignments added
   └─→ spt_identity_request: INSERT (type = 'AccessRequest', source = joiner rule)

Step 5: Provisioning
   └─→ spt_identity_request.state: Init → Approve → Provision → Complete
   └─→ spt_provisioning_transaction: INSERT per provisioned item
       (operation = 'Create' for accounts, 'Modify' for entitlements)

Step 6: Account creation on target systems
   └─→ spt_link: INSERT new rows for each provisioned application
   └─→ spt_identity_entitlement: INSERT rows for provisioned entitlements
       (assigned = 1, granted_by_role = 1, source = 'Rule' or 'Workflow')
```

### Mover Flow

```
Step 1: Authoritative aggregation detects attribute change
   └─→ spt_identity: UPDATE changed attributes
       (e.g., department, title, manager, location)

Step 2: Identity Refresh triggered
   └─→ spt_identity.needs_refresh = 1

Step 3: Role reassignment evaluation
   └─→ Lifecycle rules check new attributes against role assignment criteria
   └─→ Roles to add:
       └─→ spt_identity_request: INSERT (type = 'AccessRequest')
       └─→ Provisioning for new access
   └─→ Roles to remove:
       └─→ spt_identity_request: INSERT (type = 'AccessRequest', operation = 'Remove')
       └─→ Deprovisioning of old access

Step 4: Role detection recalculation
   └─→ spt_identity_bundles: Updated based on current entitlements
   └─→ May change as new entitlements are provisioned and old are removed

Step 5: Policy re-evaluation
   └─→ spt_policy_violation: New violations checked against new access combination
```

### Leaver Flow

```
Step 1: Authoritative source marks employee as terminated
   └─→ Aggregation detects status change

Step 2: Identity deactivation
   └─→ spt_identity: UPDATE inactive = 1

Step 3: Leaver workflow triggered
   └─→ spt_workflow_case: INSERT (leaver workflow instance)

Step 4: Account disable/delete requests
   └─→ spt_identity_request: INSERT (type = 'AccountRequest')
   └─→ spt_identity_request_item: INSERT per account
       (operation = 'Disable' or 'Delete')

Step 5: Provisioning account disablement
   └─→ spt_provisioning_transaction: INSERT per target
       (operation = 'Disable', source = 'Workflow')
   └─→ spt_link.attributes CLOB: IIQDisabled set to true

Step 6: Entitlement removal (if configured)
   └─→ spt_identity_entitlement: Rows may remain until next aggregation
       confirms entitlements are gone (aggregation_state → 'Disconnected')

Step 7: Work items for manual cleanup
   └─→ spt_work_item: INSERT for apps requiring manual deprovisioning
       (type = 'Remediation')

Step 8: Role cleanup
   └─→ spt_identity.attributes XML: Role assignments marked for removal
   └─→ spt_identity_bundles: Detected roles removed on next refresh
       (after entitlements are deprovisioned)
```

### Flow Diagram

```
                    JOINER                      MOVER                       LEAVER
                    ──────                      ─────                       ──────
HR System           New record                  Attribute change            Termination flag
    │                   │                           │                           │
    ↓                   ↓                           ↓                           ↓
Auth Agg        ┌───────────────┐           ┌───────────────┐           ┌───────────────┐
                │ spt_identity  │           │ spt_identity  │           │ spt_identity  │
                │ INSERT new    │           │ UPDATE attrs  │           │ inactive = 1  │
                └───────┬───────┘           └───────┬───────┘           └───────┬───────┘
                        │                           │                           │
                        ↓                           ↓                           ↓
Lifecycle       ┌───────────────┐           ┌───────────────┐           ┌───────────────┐
Rules           │ Birthright    │           │ Role          │           │ Disable       │
                │ role assign   │           │ reassignment  │           │ workflow      │
                └───────┬───────┘           └───────┬───────┘           └───────┬───────┘
                        │                           │                           │
                        ↓                           ↓                           ↓
Provisioning    ┌───────────────┐           ┌───────────────┐           ┌───────────────┐
                │ Create accts  │           │ Add/remove    │           │ Disable accts │
                │ Add entl's    │           │ entitlements  │           │ Remove entl's │
                └───────────────┘           └───────────────┘           └───────────────┘
```

### Analyst Indicators

- **Recent joiners**: `WHERE correlated = 1 AND inactive = 0 AND created > (date)` in `spt_identity`
- **Pending leaver cleanup**: `WHERE inactive = 1` in `spt_identity` cross-checked against `spt_link` (should have all accounts disabled) and `spt_identity_entitlement` (should all be Disconnected or removed)
- **Movers without role changes**: Identities whose department/title changed but `spt_identity_bundles` didn't change — may indicate lifecycle rules not firing
- **Stuck leaver workflows**: `spt_workflow_case` with leaver workflows where `complete = 0` for an extended period

---

## 4. Access Request Flow

### Business Context

When a user or manager requests access through IIQ's Lifecycle Manager (LCM), the request moves through approval, provisioning, and completion stages. This is the **governed access request** path — it creates an auditable trail from request through approval to provisioning.

### Trigger

User submits a request via the LCM UI or API. Can also be triggered programmatically by workflows or lifecycle rules.

### Step-by-Step Data Flow

```
Step 1: Request submission
   └─→ spt_identity_request: INSERT
       (state = 'Init', type = request type,
        requester_id, target_id, execution_status = 'Executing')
   └─→ spt_identity_request_item: INSERT per requested item
       (operation = 'Add'/'Remove', approval_state = null,
        provisioning_state = null)

Step 2: Approval workflow
   └─→ spt_identity_request: UPDATE state = 'Approve'
   └─→ spt_workflow_case: INSERT (approval workflow instance)
   └─→ spt_work_item: INSERT per approver
       (type = 'Approval', state = null [open],
        owner = approver identity, identity_request_id = request ID)

Step 3: Approval decisions
   └─→ spt_work_item: UPDATE state = 'Finished' (or 'Rejected')
   └─→ spt_identity_request_item: UPDATE approval_state
       ├─→ 'Approved' (if approved)
       └─→ 'Rejected' (if rejected — skips provisioning for this item)
   └─→ spt_work_item → spt_work_item_archive (after completion)

Step 4: Provisioning
   └─→ spt_identity_request: UPDATE state = 'Provision'
   └─→ For each approved item:
       └─→ spt_provisioning_transaction: INSERT
           (operation = item operation, source = 'LCM',
            status = 'Pending' → 'Success'/'Failed')
       └─→ spt_identity_request_item: UPDATE provisioning_state
           ├─→ 'Finished' (success)
           └─→ 'Failed' (connector error)

Step 5: Entitlement creation (for Add operations)
   └─→ spt_identity_entitlement: INSERT
       (assigned = 1, source = 'LCM',
        request_item = FK to spt_identity_request_item,
        aggregation_state = null until next aggregation)

Step 6: Completion
   └─→ spt_identity_request: UPDATE
       state = 'Complete',
       completion_status = 'Success'/'Failure'/'Incomplete',
       execution_status = 'Complete',
       end_date = current epoch ms

Step 7: Notification
   └─→ spt_identity_request: state may briefly be 'Notify'
   └─→ Email notifications sent (not stored in DB)

Step 8: Audit
   └─→ spt_audit_event: INSERT
       (action = 'Provision' or 'ApprovalComplete')
```

### State Transitions

**`spt_identity_request.state`:**
```
Init → Approve → Provision → Notify → Complete
                                 ↑
                          (may skip Notify)
```

**`spt_identity_request.completion_status`:**
```
null → Success    (all items provisioned)
null → Failure    (all items failed)
null → Incomplete (mix of success and failure)
```

**`spt_work_item.state`:**
```
null (open) → Finished  (approved)
null (open) → Rejected  (rejected)
null (open) → Expired   (past expiration without action)
```

### Flow Diagram

```
┌──────────┐      ┌─────────────────────┐      ┌──────────────────┐
│ Requester│─────→│ spt_identity_request│─────→│ spt_work_item    │
│ (LCM UI) │      │ state: Init         │      │ type: Approval   │
└──────────┘      │ ↓                   │      │ state: null      │
                  │ state: Approve      │←─────│ → Finished       │
                  │ ↓                   │      └──────────────────┘
                  │ state: Provision    │
                  │ ↓                   │      ┌─────────────────────────┐
                  │ state: Complete     │─────→│ spt_provisioning_       │
                  │ completion: Success │      │ transaction             │
                  └─────────────────────┘      │ status: Success         │
                          │                    └─────────────────────────┘
                          ↓                              │
                  ┌─────────────────────┐                ↓
                  │ spt_identity_       │      ┌─────────────────────────┐
                  │ request_item        │      │ spt_identity_           │
                  │ approval: Approved  │      │ entitlement             │
                  │ prov: Finished      │      │ (new row, assigned = 1) │
                  └─────────────────────┘      └─────────────────────────┘
```

### Analyst Indicators

- **Request bottleneck**: Requests stuck in `state = 'Approve'` for extended periods — check `spt_work_item` for corresponding open approval items
- **Provisioning failures**: `spt_identity_request_item WHERE provisioning_state = 'Failed'` — items that were approved but failed to provision
- **Request-to-completion time**: `end_date - created` on `spt_identity_request` gives turnaround time in milliseconds
- **Approval turnaround**: Compare `spt_work_item.created` to `spt_work_item.modified` (when state changed from null to Finished)

---

## 5. Certification Flow

### Business Context

Certifications (access reviews) are periodic campaigns where reviewers verify that access is still appropriate. This is a core compliance control — auditors expect regular certifications with documented decisions.

### Trigger

Scheduled certification campaign executes based on `spt_certification_definition` configuration, or manual launch from UI.

### Step-by-Step Data Flow

```
Step 1: Campaign launch
   └─→ spt_certification_group: INSERT
       (links to spt_certification_definition)

Step 2: Certification generation (per reviewer)
   └─→ spt_certification: INSERT per reviewer
       (type = campaign type, manager = reviewer name,
        phase = 'Active', percent_complete = 0)
   └─→ spt_certification_groups: INSERT (join table linking group to cert)

Step 3: Entity population (per identity being reviewed)
   └─→ spt_certification_entity: INSERT per identity
       (certification_id = cert, target_id = identity being reviewed,
        summary_status = 'Open')

Step 4: Item population (per access item)
   └─→ spt_certification_item: INSERT per entitlement/role
       (certification_entity_id = entity, type = 'Exception'/'Bundle',
        exception_application, exception_attribute_value,
        summary_status = 'Open')

Step 5: Work item for reviewer
   └─→ spt_work_item: INSERT
       (type = 'Certification', owner = reviewer identity,
        certification = cert ID, state = null [open])

Step 6: Reviewer makes decisions
   └─→ spt_certification_action: INSERT per decision
       (status = 'Approved'/'Remediated'/'Mitigated'/'Delegated',
        actor_name, decision_date, comments)
   └─→ spt_certification_item: UPDATE
       action = FK to new action, summary_status = 'Complete'
   └─→ spt_certification_entity: UPDATE summary_status, completed date
   └─→ spt_certification: UPDATE completed_entities, percent_complete

Step 7: Phase transitions
   └─→ spt_certification.phase transitions:
       Active → Challenge (if challenge period configured)
       └─→ spt_certification_challenge: INSERT for challenged items
       Challenge → Remediation (challenge period ends)
       └─→ Revocation decisions trigger provisioning:
           └─→ spt_identity_request: INSERT for each remediation
           └─→ spt_provisioning_transaction: INSERT
       Remediation → End (all remediations processed)
       End → Signed (reviewer signs off)
       └─→ spt_certification: UPDATE signed date

Step 8: Remediation provisioning (for Remediated items)
   └─→ spt_identity_request: INSERT (source = certification)
   └─→ spt_provisioning_transaction: INSERT
       (source = 'Certification', operation = 'Modify' or 'Delete')
   └─→ spt_identity_entitlement: Updated on next aggregation
       (aggregation_state → 'Disconnected' after access removed)

Step 9: Completion
   └─→ spt_certification: UPDATE finished date
   └─→ spt_work_item: UPDATE state = 'Finished'
   └─→ spt_audit_event: INSERT (action = 'CertificationSignoff')

Step 10: Archival (optional, based on configuration)
   └─→ spt_certification_archive: INSERT (compressed XML of cert data)
   └─→ Active cert tables: rows may be purged after archival
```

### Phase Transitions

```
Active ──→ Challenge ──→ Remediation ──→ End ──→ Signed
  │            │                                    ↑
  │            └─── (no challenge period) ──────────┤
  └─── (no challenge, no remediation) ──────────────┘
```

Not all phases are used in every campaign. If no challenge period is configured, certification skips from Active to Remediation (or End). If there are no revocations, it may go directly to End.

### Flow Diagram

```
┌─────────────────────────┐
│ spt_certification_      │
│ definition              │
│ (campaign template)     │
└───────────┬─────────────┘
            ↓
┌─────────────────────────┐
│ spt_certification_group │
│ (campaign instance)     │
└───────────┬─────────────┘
            ↓
┌─────────────────────────┐     ┌──────────────────┐
│ spt_certification       │────→│ spt_work_item    │
│ (per reviewer)          │     │ type:Certification│
│ phase: Active→...→Signed│     └──────────────────┘
└───────────┬─────────────┘
            ↓
┌─────────────────────────┐
│ spt_certification_entity│
│ (per identity reviewed) │
└───────────┬─────────────┘
            ↓
┌─────────────────────────┐     ┌─────────────────────────┐
│ spt_certification_item  │────→│ spt_certification_action│
│ (per access item)       │     │ Approved / Remediated / │
│ type: Exception/Bundle  │     │ Mitigated / Delegated   │
└─────────────────────────┘     └───────────┬─────────────┘
                                            │ (if Remediated)
                                            ↓
                                ┌─────────────────────────┐
                                │ spt_identity_request    │
                                │ (remediation request)   │
                                └───────────┬─────────────┘
                                            ↓
                                ┌─────────────────────────┐
                                │ spt_provisioning_       │
                                │ transaction             │
                                │ (access removal)        │
                                └─────────────────────────┘
```

### Analyst Indicators

- **Campaign completion rate**: `percent_complete` and `item_percent_complete` on `spt_certification` — compare against deadline (`expiration`)
- **Overdue certifications**: `WHERE phase = 'Active' AND expiration < current_epoch_ms` — reviews past their deadline
- **Rubber-stamping detection**: Reviewers with 100% `Approved` status in `spt_certification_action` — auditors flag this
- **Remediation success**: Compare `remediations_kicked_off` vs. `remediations_completed` on `spt_certification`
- **Decision breakdown**: Aggregate `spt_certification_action.status` by certification and reviewer

---

## 6. Role Assignment and Detection

### Business Context

Roles can arrive in an identity's profile through two distinct paths: **assignment** (explicit grant) and **detection** (pattern matching). Understanding which path was used is critical for analysts because it affects how the role appears in the data and what happens when changes occur.

### Assignment Path

Assignment means someone explicitly granted the role — through an access request, manual assignment in the UI, or a lifecycle rule.

```
Step 1: Role requested or assigned
   └─→ spt_identity_request: INSERT (type = 'RolesRequest' or 'AccessRequest')
   └─→ spt_identity_request_item: INSERT
       (name = role name, operation = 'Add')

Step 2: Approval
   └─→ spt_work_item: INSERT (type = 'Approval')
   └─→ Approval completed → spt_work_item.state = 'Finished'

Step 3: Role recorded in identity
   └─→ spt_identity.attributes XML: RoleAssignment object inserted
       (contains: role name, assigner, assignment date, source,
        sunrise/sunset dates if applicable)
   └─→ spt_identity_assigned_roles: INSERT (if this table exists in version)

Step 4: Entitlement provisioning
   └─→ For each entitlement in the role's profile:
       └─→ spt_provisioning_transaction: INSERT (operation = 'Modify')
       └─→ spt_identity_entitlement: INSERT
           (assigned = 1, granted_by_role = 1, source = 'LCM' or 'Rule')

Step 5: Role detection (next Identity Refresh)
   └─→ Entitlements now match the role profile
   └─→ spt_identity_bundles: INSERT (role is now also detected)
   └─→ Role is both assigned AND detected
```

### Detection Path

Detection means the identity's current entitlements happen to match a role's profile — nobody explicitly granted the role.

```
Step 1: Identity has entitlements from various sources
   └─→ spt_identity_entitlement: existing rows (from aggregation,
       other requests, manual additions)

Step 2: Identity Refresh runs role detection
   └─→ Compares entitlements against spt_profile + spt_profile_constraints
   └─→ Match found for a role

Step 3: Role detected
   └─→ spt_identity_bundles: INSERT
       (identity_id = identity, bundle = matched role)
   └─→ Note: NO entry in spt_identity.attributes XML as RoleAssignment
   └─→ Note: NO spt_identity_request created

Step 4: If entitlements later change (removed externally)
   └─→ Next Identity Refresh: entitlements no longer match profile
   └─→ spt_identity_bundles: DELETE (role no longer detected)
```

### Where to Find Each Type

| Role type | Where stored | How to query |
|---|---|---|
| **Detected** | `spt_identity_bundles` | `JOIN spt_identity_bundles ib ON i.id = ib.identity_id JOIN spt_bundle b ON ib.bundle = b.id` |
| **Assigned** | `spt_identity.attributes` XML | Parse XML for `RoleAssignment` elements; or query `spt_identity_assigned_roles` if available |
| **Both** | Both locations | An assigned role whose entitlements have been provisioned will also appear as detected |
| **Assigned but not detected** | XML only, not in bundles | Role was assigned but entitlements haven't been provisioned yet, or entitlements changed |
| **Detected but not assigned** | Bundles only, not in XML | Identity accumulated the right entitlements without formal assignment |

### Analyst Indicators

- **Role coverage**: Compare `spt_role_index.assigned_count` vs. `detected_count` — large discrepancies indicate governance gaps
- **Assigned-not-detected**: Roles in `spt_identity.attributes` XML but NOT in `spt_identity_bundles` — provisioning may have failed
- **Detected-not-assigned**: Roles in `spt_identity_bundles` but NOT in attributes XML — access accumulated outside the governance process
- **Role statistics**: `spt_role_index` contains pre-calculated counts (populated by the Refresh Role Scorecard task)

---

## 7. Policy Violation Detection

### Business Context

Policy violations represent situations where an identity's current access conflicts with defined governance policies — most commonly SOD (Separation of Duties) conflicts. Detection typically happens during Identity Refresh but can also be triggered by role assignment or certification.

### Trigger

Identity Refresh task, role assignment approval workflow, or certification campaign pre-processing.

### Step-by-Step Data Flow

```
Step 1: Policy engine evaluates identity's access
   └─→ Reads identity's current roles from spt_identity_bundles
       and spt_identity.attributes XML
   └─→ Reads identity's entitlements from spt_identity_entitlement
   └─→ Compares against spt_policy definitions

Step 2: SOD check
   └─→ For each spt_sodconstraint under the policy:
       └─→ Checks if identity holds roles from BOTH left_bundles AND right_bundles
       └─→ If yes: violation detected

Step 3: Violation creation (if new)
   └─→ spt_policy_violation: INSERT
       (identity = identity FK,
        policy_id, policy_name, constraint_name,
        status = 'Open', active = 1,
        left_bundles = conflicting left roles,
        right_bundles = conflicting right roles)

Step 4: Notification
   └─→ spt_work_item: INSERT (type = 'PolicyViolation')
       (owner = violation handler — policy owner or identity's manager)

Step 5: Response options (via work item or UI)
   ├─→ Option A: Mitigate
   │   └─→ spt_policy_violation: UPDATE status = 'Mitigated'
   │       mitigator = person who accepted the risk
   │       (access remains, compensating control documented)
   │
   ├─→ Option B: Remediate
   │   └─→ spt_policy_violation: UPDATE status = 'Remediated'
   │   └─→ spt_identity_request: INSERT (remove conflicting access)
   │   └─→ spt_provisioning_transaction: INSERT
   │   └─→ On next refresh: spt_policy_violation.active = 0
   │       (violation resolved because access removed)
   │
   └─→ Option C: Allow (with exception)
       └─→ spt_policy_violation remains status = 'Open'
           (documented as accepted risk in certification or audit)

Step 6: Lifecycle of the violation
   └─→ Each Identity Refresh re-evaluates:
       ├─→ Violation still applies: No change
       ├─→ Access changed, violation no longer applies:
       │   └─→ spt_policy_violation: UPDATE active = 0
       └─→ New combination creates new violation:
           └─→ spt_policy_violation: INSERT new row
```

### State Transitions

**`spt_policy_violation.status`:**
```
Open → Mitigated  (risk accepted with compensating control)
Open → Remediated (conflicting access removed)
Mitigated → Open  (mitigation expired, violation reopens)
```

**`spt_policy_violation.active`:**
```
1 → 0 (violation no longer applies — access changed or identity deactivated)
0 → 1 (rare — access changes reinstate the violation)
```

### Flow Diagram

```
┌───────────────────────┐
│ Identity Refresh      │
│ or Role Assignment    │
└───────────┬───────────┘
            ↓
┌───────────────────────┐     ┌──────────────────────┐
│ Policy Engine         │────→│ spt_sodconstraint    │
│ (evaluates access     │     │ (left/right role     │
│  against policies)    │     │  combinations)       │
└───────────┬───────────┘     └──────────────────────┘
            │ Violation detected
            ↓
┌───────────────────────┐     ┌──────────────────────┐
│ spt_policy_violation  │────→│ spt_work_item        │
│ status: Open          │     │ type: PolicyViolation │
│ active: 1             │     └──────────────────────┘
└───────────┬───────────┘
            │
     ┌──────┼──────┐
     ↓      ↓      ↓
 Mitigate  Remed  Allow
     │      │      │
     ↓      ↓      ↓
 status:  status: status:
 Mitigated Remed  Open
           iated  (accepted)
            │
            ↓
    ┌───────────────┐
    │ Provisioning  │
    │ (remove access)│
    └───────────────┘
```

### Analyst Indicators

- **Unaddressed violations**: `WHERE active = 1 AND status = 'Open'` — the most urgent compliance finding
- **Mitigation expiration**: Mitigated violations may have expiration dates in the attributes CLOB — check for expired mitigations that should be re-evaluated
- **Violation trend**: Count of `spt_policy_violation` created per month — increasing trend may indicate role model problems
- **Top violators**: Identities with the most active violations — may need role restructuring
- **Policy effectiveness**: Ratio of `Remediated` to `Mitigated` — a high mitigation rate may indicate the policy is too broad

---

## Cross-Process Interactions

Several processes interact in important ways:

### Aggregation → Refresh → Detection

```
Aggregation updates spt_link and spt_identity_entitlement
    → sets spt_identity.needs_refresh = 1
    → Identity Refresh recalculates roles in spt_identity_bundles
    → and checks policies in spt_policy_violation
```

This chain means a **single aggregation** can cascade through role changes and policy violations. Allow sufficient time between aggregation and reporting to ensure refresh has completed.

### Certification → Provisioning → Aggregation

```
Certification decision (Remediated) in spt_certification_action
    → creates spt_identity_request for remediation
    → triggers spt_provisioning_transaction
    → actual access removed on target system
    → next aggregation confirms removal (aggregation_state → 'Disconnected')
```

The full loop from certification decision to confirmed removal can span **days or weeks** depending on aggregation schedules. Don't report a remediation as "complete" until the next aggregation confirms it.

### Request → Provisioning → Aggregation → Detection

```
Access request approved → spt_provisioning_transaction
    → entitlements provisioned on target
    → next aggregation: spt_identity_entitlement.aggregation_state = 'Connected'
    → next refresh: role detection updates spt_identity_bundles
```

A requested role may not appear in `spt_identity_bundles` until **two cycles** after approval: one aggregation and one refresh.

---

## Where to Go Next

- **What do the field values in these flows mean?** → [IIQ-Field-Values.md](IIQ-Field-Values.md)
- **How do I query for specific scenarios?** → [IIQ-Analyst-Playbook.md](IIQ-Analyst-Playbook.md)
- **What are the underlying concepts?** → [IIQ-Concepts.md](IIQ-Concepts.md)
- **What are the tables and columns?** → [IIQ.md](IIQ.md)
