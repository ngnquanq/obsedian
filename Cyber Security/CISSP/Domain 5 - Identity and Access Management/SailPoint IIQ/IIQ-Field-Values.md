# IIQ Field Values: Status Codes, Types, and Flags Explained

This document enumerates and explains possible values for status codes, types, and flags across all major IIQ tables. When you encounter a value in a query result and need to know what it means operationally, look it up here. For table structures and join paths, see [IIQ.md](IIQ.md). For what these concepts mean in business terms, see [IIQ-Concepts.md](IIQ-Concepts.md).

---

## spt_identity

### correlated

| Value | Meaning |
|---|---|
| `1` | **Authoritative identity** — This identity was created or confirmed by an authoritative source (typically HR). This is a real person, contractor, or service account that has been matched to at least one account. |
| `0` | **Uncorrelated / Orphan** — This identity was auto-created because IIQ found an account it couldn't match to any existing identity. It's a placeholder, not a real person from HR. |

**Practical notes**: Always filter on `correlated = 1` in reports unless you're specifically looking for orphan accounts. Uncorrelated identities inflate headcount and distort analytics.

### inactive

| Value | Meaning |
|---|---|
| `0` | **Active** — Currently active identity with valid access. |
| `1` | **Inactive / Leaver** — Marked as terminated or departed. Set during leaver processing, either by the authoritative source feed or manual action. Access should be in the process of being removed. |

**Practical notes**: `inactive = 1` does not mean all access has been removed — it means removal has been initiated. To check if access is fully removed, query `spt_link` and `spt_identity_entitlement` for the identity.

### is_workgroup

| Value | Meaning |
|---|---|
| `0` | **Person** — A regular identity (employee, contractor, service account). |
| `1` | **Workgroup** — A group of identities that can collectively own objects, receive work items, and act as approvers. Not a real person. |

**Practical notes**: Workgroups share the `spt_identity` table. Always add `is_workgroup = 0` to filters when counting people.

### type

Common values (configurable per deployment):

| Value | Meaning |
|---|---|
| `null` / empty | Default type, usually implies Employee |
| `Employee` | Regular full-time or part-time employee |
| `Contractor` | External contractor or consultant |
| `Service` | Service account identity (non-human) |
| `Admin` | Administrative identity |
| Custom values | Organizations can define their own types |

**Practical notes**: The `type` field is customer-configurable. Values vary across deployments. Check your specific environment's ObjectConfig for the full list.

### needs_refresh

| Value | Meaning |
|---|---|
| `0` | No refresh pending — identity data is current per last refresh cycle. |
| `1` | **Refresh needed** — Identity is queued for the next Identity Refresh task. This is set when attribute changes, role changes, or other events require recalculation. |

---

## spt_identity_entitlement

### aggregation_state

| Value | Meaning |
|---|---|
| `Connected` | **Found on last aggregation** — This entitlement was confirmed to exist on the target application during the most recent aggregation. It is current. |
| `Disconnected` | **Not found on last aggregation** — The entitlement was previously seen but was not found during the most recent aggregation. This can mean the entitlement was removed on the target system, the aggregation scope changed, or there was an aggregation error. |
| `null` | Entitlement was directly assigned (not from aggregation) and has not yet been confirmed by an aggregation run. |

**Practical notes**: Disconnected entitlements are a key indicator for analysts. A high count of disconnected entitlements may signal an aggregation problem, a target system change, or successful revocation that hasn't been cleaned up. See [IIQ-Data-Flows.md — Aggregation Flow](IIQ-Data-Flows.md#1-aggregation-flow).

### assigned

| Value | Meaning |
|---|---|
| `0` | **Not directly assigned** — This entitlement was found during aggregation, not through an explicit request or assignment. |
| `1` | **Directly assigned** — This entitlement was explicitly assigned to the identity via an access request (LCM), manual assignment, or lifecycle rule. |

### granted_by_role

| Value | Meaning |
|---|---|
| `0` | **Not from a role** — This entitlement exists independently of any role assignment. |
| `1` | **Granted through a role** — This entitlement was provisioned as part of a role assignment. If the role is removed, this entitlement should be deprovisioned. |

### Common flag combinations

| `assigned` | `granted_by_role` | `aggregation_state` | Interpretation |
|---|---|---|---|
| `0` | `0` | `Connected` | Found on the target system, not explicitly managed by IIQ. Most common for pre-existing access. |
| `1` | `0` | `Connected` | Explicitly requested and confirmed present on target. |
| `1` | `1` | `Connected` | Granted through a role, requested, and confirmed present. |
| `0` | `1` | `Connected` | Part of a detected role (role was detected, not assigned). |
| `1` | `0` | `Disconnected` | Was requested but no longer found on the target system — may indicate revocation or aggregation issue. |
| `0` | `0` | `Disconnected` | Previously existed on target but no longer found — likely removed externally. |

### source

| Value | Meaning |
|---|---|
| `Task` | Created during an aggregation task or identity refresh |
| `LCM` | Created via Lifecycle Manager (self-service access request) |
| `Rule` | Created by a business rule or lifecycle event |
| `Workflow` | Created by a workflow process |
| `UI` | Created through direct UI manipulation |
| `Certification` | Created or modified as a result of a certification action |
| `null` | Source not recorded (common for older or migrated data) |

### type

| Value | Meaning |
|---|---|
| `Entitlement` | A standard entitlement (group membership, role, privilege) |
| `Permission` | A fine-grained permission (e.g., specific file share permissions, NTFS ACLs) |

---

## spt_identity_request

### state

Requests move through these states sequentially:

| Value | Position | Meaning |
|---|---|---|
| `Init` | 1 | Request has been created but not yet submitted for approval |
| `Approve` | 2 | Request is awaiting one or more approvals |
| `Provision` | 3 | Approved and currently being provisioned to target systems |
| `Notify` | 4 | Provisioning complete, notifications being sent |
| `Complete` | 5 | Request fully processed — check `completion_status` for outcome |

See [IIQ-Data-Flows.md — Access Request Flow](IIQ-Data-Flows.md#4-access-request-flow) for the full lifecycle.

### type

| Value | Meaning |
|---|---|
| `AccessRequest` | General access request (most common — entitlements and/or roles) |
| `EntitlementRequest` | Request specifically for entitlements |
| `AccountRequest` | Request to create, disable, or delete an account |
| `RolesRequest` | Request specifically for role assignment |
| `IdentityCreateRequest` | Request to create a new identity |
| `IdentityEditRequest` | Request to modify identity attributes |

### completion_status

| Value | Meaning |
|---|---|
| `Success` | All items in the request were successfully provisioned |
| `Failure` | One or more items failed to provision |
| `Incomplete` | Request partially completed — some items succeeded, others failed or are still pending |
| `null` | Request is still in progress (state has not reached Complete) |

### execution_status

| Value | Meaning |
|---|---|
| `Executing` | Request workflow is currently running |
| `Verifying` | Provisioning is being verified against target systems |
| `Terminated` | Request was manually terminated before completion |
| `Complete` | All execution steps are finished |

---

## spt_identity_request_item

### operation

| Value | Meaning |
|---|---|
| `Add` | Add an entitlement or role to the identity |
| `Remove` | Remove an entitlement or role from the identity |
| `Set` | Set an attribute to a specific value |
| `Create` | Create a new account on a target application |
| `Delete` | Delete an account from a target application |

### approval_state

| Value | Meaning |
|---|---|
| `Pending` | Awaiting approval decision |
| `Approved` | Approved by the required approver(s) |
| `Rejected` | Rejected by an approver |
| `Cancelled` | Cancelled before approval decision |
| `null` | No approval required for this item |

### provisioning_state

| Value | Meaning |
|---|---|
| `Pending` | Awaiting provisioning — approved but not yet executed |
| `Finished` | Successfully provisioned to the target system |
| `Failed` | Provisioning attempt failed |
| `Retry` | Failed provisioning queued for retry |
| `null` | Not yet reached provisioning stage |

---

## spt_work_item

### type

| Value | Meaning |
|---|---|
| `Approval` | Access request approval task — the most common type |
| `Certification` | Certification review assignment |
| `Remediation` | Task to remediate a revoked entitlement (e.g., remove from target system) |
| `Challenge` | Challenge to a certification revocation decision |
| `PolicyViolation` | Task to address a policy violation |
| `Delegation` | Delegated review or approval task |
| `Form` | Form-based task requiring user input |
| `Event` | System event notification |

### state

| Value | Meaning |
|---|---|
| `null` | **Open / Active** — The work item is currently pending. This is how IIQ represents "open" — with a null state, not a string value. |
| `Finished` | Completed successfully (approved, reviewed, or resolved) |
| `Rejected` | Explicitly rejected by the assignee |
| `Expired` | Passed its expiration date without action |

**Practical notes**: To find open work items, use `WHERE state IS NULL`, not `WHERE state = 'Open'`. This catches many first-time analysts off guard. Completed work items eventually move to `spt_work_item_archive`.

---

## spt_certification

### type

| Value | Meaning |
|---|---|
| `Manager` | Manager certification — managers review their direct reports' access |
| `ApplicationOwner` | Application owner reviews all access on their application |
| `Entitlement` | Entitlement owner reviews who holds specific entitlements |
| `RoleMembership` | Role owner reviews who holds specific roles |
| `Targeted` | Targeted review of specific identities or access |
| `AccountGroupMembership` | Review of account group membership |
| `DataOwner` | Data owner reviews access to their data resources |
| `BusinessRoleComposition` | Review of what IT roles and entitlements compose a business role |
| `IdentityAssignedRoles` | Review of assigned role memberships |

### phase

Certifications progress through these phases:

| Value | Position | Meaning |
|---|---|---|
| `Active` | 1 | Certification is open and the reviewer can make decisions |
| `Challenge` | 2 | Challenge period — users can challenge revocation decisions before they're final |
| `Remediation` | 3 | Revocations are being executed (provisioning removal of access) |
| `End` | 4 | All processing is complete |
| `Signed` | 5 | Reviewer has signed off, certifying the decisions are final |

See [IIQ-Data-Flows.md — Certification Flow](IIQ-Data-Flows.md#5-certification-flow) for phase transitions.

---

## spt_certification_action

### status

| Value | Meaning | Operational effect |
|---|---|---|
| `Approved` | Reviewer approved — access is appropriate and should continue | No change to access |
| `Remediated` | Reviewer revoked — access should be removed | Triggers provisioning to remove the entitlement/role from the target system |
| `Mitigated` | Reviewer accepted a violation with justification | Access stays, but a mitigation record is created (time-limited acceptance) |
| `Delegated` | Reviewer delegated the decision to another person | A new work item is created for the delegate |
| `RevokeAccount` | Reviewer decided to revoke the entire account, not just individual entitlements | Account disable/delete provisioning triggered |
| `Acknowledged` | Reviewer acknowledged an item without making an approve/revoke decision | Varies by configuration |

**Practical notes**: For certification analytics, `Approved` and `Remediated` are the primary statuses to track. The approve/revoke ratio is a key metric for audit — a 100% approval rate raises red flags with auditors.

---

## spt_certification_item

### type

| Value | Meaning |
|---|---|
| `Exception` | An entitlement under review — the most common type |
| `Bundle` | A role (bundle) under review |
| `PolicyViolation` | A policy violation included in the certification for review |
| `Account` | An entire account under review |
| `DataItem` | A data-related access item |

### summary_status

| Value | Meaning |
|---|---|
| `Open` | No decision has been made yet |
| `Complete` | A decision has been recorded for this item |
| `Challenged` | Item was revoked, then challenged by the user |
| `Delegated` | Item has been delegated to another reviewer |
| `Returned` | Item was delegated and returned to the original reviewer |
| `WaitingReview` | Awaiting additional review or sign-off |

---

## spt_policy_violation

### status

| Value | Meaning |
|---|---|
| `Open` | Violation detected, not yet addressed. Requires action. |
| `Mitigated` | Violation accepted with a compensating control. The conflicting access remains, but a justification and typically an expiration date have been recorded. |
| `Remediated` | Conflicting access has been removed, resolving the violation. |

### active

| Value | Meaning |
|---|---|
| `1` | Violation is currently active and relevant |
| `0` | Violation has been resolved or is no longer applicable (identity changed, policy changed, etc.) |

**Practical notes**: For compliance reporting, focus on `active = 1`. Violations with `active = 1 AND status = 'Open'` are the most urgent — they represent unaddressed conflicts.

---

## spt_provisioning_transaction

### operation

| Value | Meaning |
|---|---|
| `Create` | Creating a new account on a target system |
| `Modify` | Modifying attributes or entitlements on an existing account |
| `Delete` | Deleting an account from a target system |
| `Enable` | Enabling a disabled account |
| `Disable` | Disabling an active account |
| `Unlock` | Unlocking a locked account |
| `SetPassword` | Setting or resetting an account password |

### source

| Value | Meaning |
|---|---|
| `LCM` | Lifecycle Manager — triggered by an access request |
| `Certification` | Triggered by a certification revocation decision |
| `Workflow` | Triggered by a workflow (often lifecycle events like JML) |
| `UI` | Triggered through the admin UI |
| `Rule` | Triggered by a business rule |
| `Batch` | Triggered by a batch operation |
| `Task` | Triggered by a scheduled task |

### status

| Value | Meaning |
|---|---|
| `Success` | Provisioning operation completed successfully on the target system |
| `Pending` | Operation is queued but not yet executed |
| `Failed` | Operation failed — check `spt_syslog_event` and workflow case for error details |
| `Retry` | Failed operation queued for automatic retry |

### type

| Value | Meaning |
|---|---|
| `Auto` | Automatic provisioning — IIQ executed the change on the target system via its connector |
| `Manual` | Manual provisioning — IIQ created a work item for a human to execute the change (because no connector supports the operation or manual provisioning is configured) |

---

## spt_bundle

### type

| Value | Meaning |
|---|---|
| `business` | Business role — high-level grouping meaningful to the organization (e.g., "Accounts Payable Clerk") |
| `it` | IT role — technical grouping mapping to specific entitlements on specific applications |
| `organizational` | Organizational role — tied to org structure (department, location). Often used for birthright access. |
| Custom values | Organizations can define custom role types |

### requestable

| Value | Meaning |
|---|---|
| `0` | Not requestable — this role cannot be requested through self-service LCM |
| `1` | Requestable — users can request this role for themselves or others through the LCM UI |

### disabled

| Value | Meaning |
|---|---|
| `0` | Active — role is enabled and operational |
| `1` | Disabled — role exists but is not active. Disabled roles are not detected during refresh and cannot be assigned. |

---

## spt_application

### authoritative

| Value | Meaning |
|---|---|
| `0` | Regular application — a target system where accounts and entitlements are aggregated, but new identities are not created from its data |
| `1` | Authoritative source — the source of truth for identity data. Aggregation from this application creates and updates `spt_identity` records. |

### Common type values

| Value | Meaning |
|---|---|
| `Active Directory - Direct` | Microsoft Active Directory via direct LDAP connector |
| `LDAP` | Generic LDAP directory |
| `JDBC` | Database-backed application via JDBC connector |
| `Delimited File` | Flat file (CSV/TSV) connector |
| `SAP HR/HCM` | SAP Human Capital Management |
| `SAP` | SAP ERP (non-HR) |
| `Workday` | Workday HCM |
| `ServiceNow` | ServiceNow connector |
| `Web Services` | Generic web services / REST API connector |
| `RSA` | RSA Authentication Manager |
| `SCIM` | SCIM-based cloud applications |
| `SCIM 2.0` | SCIM 2.0 connector |
| `Azure Active Directory` | Microsoft Entra ID (Azure AD) |
| `Okta` | Okta identity platform |

### features_string

Comma-separated list of supported operations. Common values:

| Feature | Meaning |
|---|---|
| `PROVISIONING` | Application supports automated provisioning (creating/modifying accounts) |
| `ENABLE` | Application supports enabling accounts |
| `DISABLE` | Application supports disabling accounts |
| `UNLOCK` | Application supports unlocking locked accounts |
| `PASSWORD` | Application supports password management |
| `SYNC_PROVISIONING` | Provisioning operations are synchronous (IIQ waits for completion) |
| `AUTHENTICATE` | Application supports authentication pass-through |
| `SEARCH` | Connector supports search/filter operations |
| `ACCOUNT_ONLY_REQUEST` | Supports creating accounts without specifying entitlements |
| `CURRENT_PASSWORD` | Password changes require the current password |

---

## spt_audit_event

### Common action values

| Value | Meaning |
|---|---|
| `Login` | User logged into IIQ |
| `Logout` | User logged out of IIQ |
| `IdentityCreate` | New identity created |
| `IdentityEdit` | Identity attributes modified |
| `IdentityDelete` | Identity removed |
| `RoleCreate` | New role (bundle) created |
| `RoleEdit` | Role definition modified |
| `RoleDelete` | Role removed |
| `CertificationCreate` | New certification campaign launched |
| `CertificationSignoff` | Reviewer signed off on a certification |
| `CertificationRemediation` | Certification remediation action recorded |
| `PolicyViolation` | Policy violation detected |
| `ApplicationCreate` | New application defined |
| `ApplicationEdit` | Application configuration modified |
| `Provision` | Provisioning action executed |
| `ApprovalComplete` | Approval work item completed |
| `WorkflowStart` | Workflow execution started |
| `TaskStart` | Scheduled task started |
| `TaskComplete` | Scheduled task completed |
| `ConfigChange` | System configuration changed |

### interface

| Value | Meaning |
|---|---|
| `UI` | Action performed through the IIQ web UI |
| `API` | Action performed via the IIQ REST API |
| `Console` | Action performed through the IIQ Console (command-line) |
| `Scheduler` | Action triggered by the Quartz scheduler (automated tasks) |
| `System` | System-initiated action (internal processes) |
| `SSO` | Action through Single Sign-On |

---

## spt_task_result

### completion_status

| Value | Meaning |
|---|---|
| `Success` | Task completed without errors |
| `Warning` | Task completed but with warnings (check `attributes` CLOB for details) |
| `Error` | Task failed with errors |
| `Terminated` | Task was manually terminated before completion |
| `null` | Task is still running |

**Practical notes**: For aggregation monitoring, always check task results. A `Warning` completion on an aggregation task often means some accounts failed to process — check the task result details for counts of errors.

---

## Where to Go Next

- **What business concepts do these values represent?** → [IIQ-Concepts.md](IIQ-Concepts.md)
- **How do values change as processes execute?** → [IIQ-Data-Flows.md](IIQ-Data-Flows.md)
- **How do I query for specific value combinations?** → [IIQ-Analyst-Playbook.md](IIQ-Analyst-Playbook.md)
- **What are the tables and columns?** → [IIQ.md](IIQ.md)
