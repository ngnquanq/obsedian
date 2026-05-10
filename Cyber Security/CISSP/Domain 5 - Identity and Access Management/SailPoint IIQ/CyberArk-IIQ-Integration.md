# CyberArk and SailPoint IIQ Integration

This document explains how CyberArk Privileged Access Management (PAM) and SailPoint IdentityIQ (IIQ) work together, the integration patterns available, and the end-to-end data flows between the two systems. For IIQ table structures, see [IIQ.md](IIQ.md). For IIQ data flow fundamentals, see [IIQ-Data-Flows.md](IIQ-Data-Flows.md).

> [!tip] CyberArk-side reference material
> For the CyberArk product itself — architecture, data model, dashboarding via Power BI — see the dedicated [[CyberArk PAM/README|CyberArk PAM Index]]. Quick entry points: [[what-is-cyberark]], [[CyberArk PAM/02-architecture/overview|CyberArk Architecture Overview]], [[safes]], [[accounts]], [[CyberArk PAM/04-glossary/glossary|CyberArk Glossary]].

---

## Why Integrate CyberArk with SailPoint IIQ?

CyberArk and SailPoint IIQ solve **different but complementary** problems:

| Concern | CyberArk (PAM) | SailPoint IIQ (IGA) |
|---|---|---|
| **Primary focus** | Secure, vault, and rotate privileged credentials | Govern who has access to what across all systems |
| **Scope** | Privileged accounts (admin, service, root, DBA) | All identities — standard and privileged |
| **Key capability** | Session isolation, credential rotation, recording | Certification, provisioning, policy enforcement |
| **Answers the question** | *How is this privileged account being used right now?* | *Who has access to this privileged account, and should they?* |

Without integration, you get two blind spots:

1. **CyberArk knows the vault contents but not the business owner** — it stores and rotates the `svc_oracle_prod` password, but doesn't know that Jane Smith in Finance is the person approved to use it, or that she changed departments last week and should no longer have access.

2. **IIQ knows the identity lifecycle but not the privileged credential details** — it can tell you Jane Smith has 14 entitlements across 6 applications, but without CyberArk visibility, the privileged accounts in the vault are a governance blind spot.

**The integration closes both gaps**: IIQ gains visibility into privileged accounts so they can be governed (certified, requested, revoked) like any other entitlement. CyberArk gains identity context so privileged access decisions are tied to an authoritative identity lifecycle.

---

## What CyberArk Looks Like as a Concept

Before diving into integration, here is a quick CyberArk mental model:

```
┌─────────────────────────────────────────────────────────┐
│                   CyberArk Vault                        │
│                                                         │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Safe:     │  │   Safe:     │  │   Safe:     │     │
│  │ Unix-Prod   │  │ DB-Prod     │  │ Windows-Prod│     │
│  │             │  │             │  │             │     │
│  │ Accounts:   │  │ Accounts:   │  │ Accounts:   │     │
│  │ root@srv01  │  │ dba@oraprod │  │ admin@dc01  │     │
│  │ root@srv02  │  │ sa@sqlprod  │  │ svc_backup  │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
│                                                         │
│  Key Concepts:                                          │
│  - Safe       = A container (folder) holding accounts   │
│  - Account    = A privileged credential (user + target) │
│  - Platform   = Policy template (rotation schedule,     │
│                 allowed protocols, etc.)                 │
│  - Safe Member= A user/group authorized to access a Safe│
└─────────────────────────────────────────────────────────┘
```

**Safe membership** is the critical entitlement — if you are a member of a Safe, you can retrieve/use the privileged credentials stored in that Safe. This is what IIQ governs.

---

## Integration Patterns

There are **three primary ways** CyberArk and IIQ integrate. Most enterprises use a combination:

### Pattern 1: CyberArk as an Aggregation Source (Visibility + Governance)

IIQ connects to CyberArk via a **connector** (typically the CyberArk REST API / PVWA connector) and treats CyberArk as just another application — like Active Directory or SAP.

**What IIQ aggregates from CyberArk:**

| CyberArk Object | Maps to IIQ Concept | IIQ Table |
|---|---|---|
| Safe Member (user account in CyberArk) | Account (`spt_link`) | `spt_link` |
| Safe | Entitlement / Managed Attribute | `spt_managed_attribute` |
| Safe permissions (UseAccounts, RetrieveAccounts, ListAccounts, etc.) | Entitlement attributes | `spt_identity_entitlement` |
| Privileged account (the vaulted credential) | Managed account metadata | `spt_managed_attribute` or extended attributes |

**What this enables:**
- Safe memberships appear in identity cubes like any other entitlement
- Certifiers can review and revoke CyberArk access during access reviews
- SOD policies can flag toxic combinations (e.g., Safe access + approval authority)
- Privileged access shows up in risk scoring

```
┌──────────────┐         ┌─────────────────────────┐
│  CyberArk    │  REST   │  IIQ CyberArk Connector │
│  PVWA API    │────────→│  (Account Aggregation)   │
│              │         └────────────┬──────────────┘
└──────────────┘                      │
                                      ↓
                         ┌────────────────────────┐
                         │ spt_link               │
                         │ (CyberArk user account)│
                         │ native_identity =      │
                         │   "jsmith@cyberark"     │
                         └───────────┬────────────┘
                                     │
                    ┌────────────────┘
                    ↓
          ┌──────────────────────────────────┐
          │ spt_identity_entitlement         │
          │                                  │
          │ name = "Unix-Prod" (Safe)        │
          │ value = "UseAccounts,            │
          │          RetrieveAccounts"        │
          │ source = "CyberArk"              │
          │ aggregation_state = "Connected"  │
          └──────────────────────────────────┘
                    │
                    ↓
          ┌──────────────────────────────────┐
          │ spt_identity (Identity Cube)     │
          │                                  │
          │ "Jane Smith" now shows:          │
          │  - AD account: jsmith            │
          │  - SAP account: JSMITH           │
          │  - CyberArk: member of           │
          │    Unix-Prod, DB-Prod Safes      │
          └──────────────────────────────────┘
```

### Pattern 2: IIQ as a Provisioning Engine (Lifecycle Automation)

IIQ doesn't just read from CyberArk — it can **write back** to automate privileged access lifecycle:

| IIQ Action | CyberArk Result |
|---|---|
| Access request approved for a Safe | IIQ calls CyberArk API to add user as Safe Member |
| Certification reviewer revokes Safe access | IIQ calls CyberArk API to remove Safe Member |
| Identity lifecycle event (termination) | IIQ triggers removal of all Safe memberships |
| Role assignment includes CyberArk entitlement | IIQ provisions Safe membership automatically |

**This is powerful because it means:**
- Users request CyberArk Safe access through the same IIQ portal they use for any other access
- Approval workflows, risk checks, and SOD policies apply before CyberArk access is granted
- When someone leaves the company or changes roles, their privileged access is revoked automatically — no manual CyberArk admin intervention needed

```
┌───────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│ User requests     │     │ IIQ Workflow      │     │ CyberArk PVWA    │
│ "Unix-Prod" Safe  │────→│ Engine            │────→│ API               │
│ in IIQ portal     │     │                   │     │                   │
└───────────────────┘     │ 1. SOD check      │     │ Result:           │
                          │ 2. Risk scoring   │     │ jsmith added as   │
                          │ 3. Manager approval│    │ Safe Member of    │
                          │ 4. Provision      │     │ "Unix-Prod"       │
                          └──────────────────┘     └──────────────────┘
```

### Pattern 3: CyberArk Credential Provider for IIQ Connectors (Operational Security)

IIQ itself needs **service accounts** to connect to target applications (AD, SAP, databases, etc.). Instead of storing those credentials in IIQ's configuration, you can vault them in CyberArk:

```
┌──────────────┐                    ┌──────────────┐
│ IIQ needs to │   1. Request       │  CyberArk    │
│ aggregate AD │─────credential────→│  Vault       │
│              │                    │              │
│              │   2. Return        │  Safe:       │
│              │←────password───────│  IIQ-SvcAccts│
│              │                    │              │
│ 3. Use cred  │                    └──────────────┘
│ to connect   │
│ to AD        │──────────────────→ Active Directory
└──────────────┘
```

**What this solves:**
- IIQ connector passwords are never stored in flat config files or the IIQ database
- CyberArk rotates them automatically; IIQ retrieves the current password each time
- Audit trail shows when IIQ retrieved each credential

This pattern is **orthogonal** to Patterns 1 and 2 — it secures IIQ's own operations rather than governing CyberArk access.

---

## End-to-End Flow: CyberArk to SailPoint IIQ

Here is the complete flow, step by step, from CyberArk data into IIQ governance:

### Phase 1: Configuration (One-Time Setup)

```
Step 1: Application definition in IIQ
   └─→ Admin creates an Application object (spt_application) of type "CyberArk"
       └─→ Configures PVWA base URL, API credentials, and connector settings
       └─→ Defines attribute mappings:
           ├─→ CyberArk username → spt_link.native_identity
           ├─→ Safe name → spt_managed_attribute.value
           └─→ Safe permissions → spt_identity_entitlement attributes

Step 2: Correlation rule
   └─→ Maps CyberArk user accounts to IIQ identities
       └─→ Typically: CyberArk username correlates to AD sAMAccountName
           which IIQ already uses as the primary identity key

Step 3: Aggregation schedule
   └─→ spt_task_definition: Scheduled task for CyberArk account aggregation
       └─→ Runs on a cadence (e.g., every 4-6 hours)
```

### Phase 2: Aggregation (Recurring)

```
Step 1: Aggregation task triggers
   └─→ spt_task_result: New row (completion_status = null)

Step 2: IIQ CyberArk connector calls PVWA REST API
   └─→ GET /PasswordVault/api/Users          → CyberArk user list
   └─→ GET /PasswordVault/api/Safes          → Safe definitions
   └─→ GET /PasswordVault/api/Safes/{id}/Members → Safe membership

Step 3: Account processing (for each CyberArk user)
   └─→ spt_link:
       ├─→ Existing: UPDATE attributes, last_refresh
       └─→ New: INSERT, then correlate to spt_identity

Step 4: Entitlement processing (for each Safe membership)
   └─→ spt_managed_attribute:
       │   ├─→ type = "Entitlement"
       │   ├─→ attribute = "Safe"
       │   ├─→ value = "Unix-Prod"
       │   └─→ displayName = "Unix Production Servers Safe"
       │
   └─→ spt_identity_entitlement:
       ├─→ name = "Safe"
       ├─→ value = "Unix-Prod"
       ├─→ aggregation_state = "Connected"
       └─→ Additional attributes: UseAccounts, RetrieveAccounts, etc.

Step 5: Identity refresh
   └─→ spt_identity.needs_refresh = 1 (for affected identities)
   └─→ Subsequent identity refresh recalculates:
       ├─→ Risk score (privileged Safe access increases score)
       ├─→ Role assignments
       └─→ Policy violations (SOD checks)

Step 6: Task completion
   └─→ spt_task_result: UPDATE completion_status, stats
```

### Phase 3: Governance (Ongoing)

Once CyberArk data is in IIQ, it participates in all standard governance processes:

```
┌──────────────────────────────────────────────────────────────────────┐
│                    Governance Lifecycle                              │
│                                                                      │
│  ┌──────────┐   ┌──────────────┐   ┌──────────────┐                │
│  │ Access    │   │ Certification│   │ Policy       │                │
│  │ Request   │   │ (Review)     │   │ Enforcement  │                │
│  │           │   │              │   │              │                │
│  │ User asks │   │ Manager sees │   │ SOD rule:    │                │
│  │ for Safe  │   │ CyberArk     │   │ Cannot hold  │                │
│  │ "DB-Prod" │   │ Safe access  │   │ "DB-Prod" +  │                │
│  │ via IIQ   │   │ in cert      │   │ "DB-Approve" │                │
│  │ portal    │   │ campaign     │   │ Safes        │                │
│  └─────┬─────┘   └──────┬──────┘   └──────┬───────┘                │
│        │                │                  │                         │
│        ↓                ↓                  ↓                         │
│  ┌─────────────────────────────────────────────────────┐            │
│  │              IIQ Provisioning Engine                  │            │
│  │                                                      │            │
│  │  Approved request    → Add Safe Member via API       │            │
│  │  Revoked in cert     → Remove Safe Member via API    │            │
│  │  SOD violation       → Block request or alert        │            │
│  │  Termination event   → Remove all Safe memberships   │            │
│  └──────────────────────────────┬───────────────────────┘            │
│                                 │                                     │
│                                 ↓                                     │
│                    ┌────────────────────────┐                        │
│                    │  CyberArk PVWA API     │                        │
│                    │  (Provisioning target)  │                        │
│                    └────────────────────────┘                        │
└──────────────────────────────────────────────────────────────────────┘
```

---

## Data Mapping Reference

### CyberArk Objects → IIQ Tables

| CyberArk Object | IIQ Table | IIQ Column/Field | Notes |
|---|---|---|---|
| CyberArk Application | `spt_application` | `name = "CyberArk"` | One row; the application definition |
| CyberArk User | `spt_link` | `native_identity`, `identity_id` | One row per CyberArk user, correlated to an identity |
| Safe | `spt_managed_attribute` | `value = "<SafeName>"`, `attribute = "Safe"` | One row per Safe; the entitlement catalog entry |
| Safe Membership | `spt_identity_entitlement` | `name = "Safe"`, `value = "<SafeName>"` | One row per user-Safe assignment |
| Safe Permission | `spt_identity_entitlement` (attributes) | Stored in extended attributes or CLOB | UseAccounts, RetrieveAccounts, ListAccounts, etc. |
| Privileged Account (vaulted) | `spt_managed_attribute` or extended | Varies by connector config | Optional — some orgs aggregate vaulted account metadata |

### Key Safe Permissions (CyberArk)

These permissions appear as entitlement attributes once aggregated into IIQ.

> [!note] Permission naming conventions
> CyberArk's REST API uses **camelCase** property names (e.g., `useAccounts`, `retrieveAccounts`). The CyberArk Classic UI displays them with spaces ("Use accounts", "Retrieve accounts"). This table uses PascalCase as a readable middle ground — map to camelCase when writing queries against API-sourced data.
> Source: [CyberArk PAM Self-Hosted — Add Safe Member (REST API)](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/add%20safe%20member.htm)

**Account access permissions:**

| Permission (PascalCase) | API property (camelCase) | What It Allows | Governance Relevance |
|---|---|---|---|
| `UseAccounts` | `useAccounts` | Connect through PSM using vaulted credentials | **High** — grants actual privileged session access |
| `RetrieveAccounts` | `retrieveAccounts` | Copy/view the actual password | **Critical** — password can be used outside CyberArk |
| `ListAccounts` | `listAccounts` | See which accounts exist in the Safe | Low — informational only |
| `AddAccounts` | `addAccounts` | Add new privileged accounts to the Safe (requires `UpdateAccountProperties`) | Medium — administrative |
| `UpdateAccountContent` | `updateAccountContent` | Change the stored password | Medium — administrative |
| `UpdateAccountProperties` | `updateAccountProperties` | Modify account metadata/properties | Low — required to enable `AddAccounts` |
| `RenameAccounts` | `renameAccounts` | Rename a vaulted account | Low — administrative |
| `DeleteAccounts` | `deleteAccounts` | Delete a vaulted account from the Safe | **High** — destructive |
| `UnlockAccounts` | `unlockAccounts` | Unlock a locked account | Low — operational |
| `InitiateCPMAccountManagementOperations` | `initiateCPMAccountManagementOperations` | Trigger CPM password rotation | Medium — can force credential rotation |
| `SpecifyNextAccountContent` | `specifyNextAccountContent` | Set the next password value before rotation (requires `InitiateCPM...`) | Medium — sensitive |
| `AccessWithoutConfirmation` | `accessWithoutConfirmation` | Bypass dual-control approval workflow | **High** — circumvents controls |

**Safe administration permissions:**

| Permission (PascalCase) | API property (camelCase) | What It Allows | Governance Relevance |
|---|---|---|---|
| `ManageSafe` | `manageSafe` | Full control over Safe configuration | **Critical** — can grant others access |
| `ManageSafeMembers` | `manageSafeMembers` | Add/remove Safe members | **Critical** — can escalate privileges |
| `ViewSafeMembers` | `viewSafeMembers` | See the Safe member list | Low — informational |
| `ViewAuditLog` | `viewAuditLog` | View Safe audit history | Low — informational |
| `BackupSafe` | `backupSafe` | Export Safe contents | **High** — can exfiltrate credentials |
| `CreateFolders` | `createFolders` | Create folders within the Safe | Low — organizational |
| `DeleteFolders` | `deleteFolders` | Delete folders within the Safe | Low — organizational |
| `MoveAccountsAndFolders` | `moveAccountsAndFolders` | Reorganize accounts between folders | Low — organizational |
| `RequestsAuthorizationLevel1` | `requestsAuthorizationLevel1` | First-level approver for dual-control requests | Medium — approval authority |
| `RequestsAuthorizationLevel2` | `requestsAuthorizationLevel2` | Second-level approver for dual-control requests | Medium — approval authority |

---

## Joiner / Mover / Leaver Scenarios

### Joiner (New Hire who needs privileged access)

```
HR system → IIQ creates identity
                    │
                    ↓
         Role assignment triggers
         CyberArk Safe entitlement
         (e.g., "DBA" role includes "DB-Prod" Safe)
                    │
                    ↓
         IIQ provisioning engine calls
         CyberArk API to add Safe Member
                    │
                    ↓
         New DBA can now access
         vaulted DB credentials via CyberArk
```

### Mover (Role change — e.g., DBA moves to Application Support)

```
HR system updates department/title
                    │
                    ↓
         IIQ detects lifecycle event
         Triggers identity refresh
                    │
                    ↓
         Old role "DBA" removed → removes "DB-Prod" Safe entitlement
         New role "App-Support" assigned → adds "App-Prod" Safe entitlement
                    │
                    ↓
         IIQ calls CyberArk API:
           - Remove from "DB-Prod" Safe
           - Add to "App-Prod" Safe
                    │
                    ↓
         User can no longer access DB passwords
         User can now access App server passwords
```

### Leaver (Termination)

```
HR system sets employee status = terminated
                    │
                    ↓
         IIQ lifecycle event triggers
         "Terminate Identity" process
                    │
                    ↓
         For each CyberArk entitlement:
           └─→ IIQ calls CyberArk API
               to remove Safe membership
                    │
                    ↓
         CyberArk automatically rotates
         any passwords the user may have seen
         (based on CyberArk platform policy)
                    │
                    ↓
         spt_link: marked disabled/deleted
         spt_identity_entitlement: removed or Disconnected
         spt_identity: set inactive
```

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         Enterprise Environment                          │
│                                                                         │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐               │
│  │    HR    │  │   Active  │  │   SAP    │  │  Oracle  │  (Standard   │
│  │  System  │  │ Directory │  │   ERP    │  │   DB     │   Systems)   │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘               │
│       │              │              │              │                     │
│       │    ┌─────────┴──────────────┴──────────────┘                    │
│       │    │         Standard Connectors                                │
│       ↓    ↓                                                            │
│  ┌─────────────────────────────────────────────────────┐               │
│  │                 SailPoint IIQ                        │               │
│  │                                                      │               │
│  │  ┌────────────┐  ┌─────────────┐  ┌──────────────┐ │               │
│  │  │ Identity   │  │ Provisioning│  │ Certification│ │               │
│  │  │ Warehouse  │  │ Engine      │  │ Engine       │ │               │
│  │  └─────┬──────┘  └──────┬──────┘  └──────────────┘ │               │
│  │        │                │                            │               │
│  │        │    CyberArk    │    CyberArk                │               │
│  │        │    Connector   │    Connector                │               │
│  │        │   (Read/Agg)   │   (Write/Prov)             │               │
│  └────────┼────────────────┼────────────────────────────┘               │
│           │                │                                            │
│           ↓                ↓                                            │
│  ┌──────────────────────────────────────────────┐                      │
│  │              CyberArk PAM                     │                      │
│  │                                               │                      │
│  │  ┌──────────┐  ┌──────────┐  ┌────────────┐ │                      │
│  │  │  PVWA    │  │  Vault   │  │  PSM       │ │                      │
│  │  │ (Web     │  │ (Cred    │  │ (Session   │ │                      │
│  │  │  Access  │  │  Storage)│  │  Manager)  │ │                      │
│  │  │  + API)  │  │          │  │            │ │                      │
│  │  └──────────┘  └──────────┘  └────────────┘ │                      │
│  │                                               │     ┌──────────────┐│
│  │  Pattern 3: IIQ retrieves its own service    │     │ Target       ││
│  │  account passwords from CyberArk Vault       │────→│ Servers &    ││
│  │  before connecting to target systems          │     │ Databases    ││
│  └──────────────────────────────────────────────┘     └──────────────┘│
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Common Integration Challenges

| Challenge | Description | Typical Resolution |
|---|---|---|
| **Correlation mismatch** | CyberArk usernames don't match IIQ identity keys | Custom correlation rule mapping CyberArk username to AD sAMAccountName or employee ID |
| **Safe permission granularity** | IIQ aggregates Safe membership but loses per-permission detail | Configure connector to pull permission-level attributes; model as multi-valued entitlement |
| **Orphan Safe members** | CyberArk has local users not in IIQ's authoritative source | These appear as uncorrelated accounts in IIQ — include them in certification campaigns |
| **API rate limits** | Large CyberArk environments hit PVWA API throttling during aggregation | Use delta/incremental aggregation; schedule during off-peak; tune page sizes |
| **Credential rotation timing** | IIQ connector credentials stored in CyberArk get rotated mid-aggregation | Use CyberArk Credential Provider (CP/CCP) for just-in-time retrieval rather than static credentials |
| **Bidirectional sync conflicts** | Admin adds Safe member directly in CyberArk; IIQ aggregation picks it up as "unmanaged" | Enforce policy that all Safe membership changes go through IIQ; flag direct CyberArk changes for review |

---

## Summary: Which Pattern to Use When

| Goal | Pattern | Key Outcome |
|---|---|---|
| "We need **visibility** into who has privileged access" | Pattern 1 (Aggregation) | CyberArk Safes appear in identity cubes and certifications |
| "We need to **automate** privileged access lifecycle" | Pattern 2 (Provisioning) | Joiner/mover/leaver events automatically update CyberArk |
| "We need to **secure IIQ's own** service accounts" | Pattern 3 (Credential Provider) | IIQ connector passwords are vaulted and rotated by CyberArk |
| "We want **full governance** over privileged access" | All three combined | Complete visibility, automation, and operational security |

Most mature organizations implement all three patterns. A typical rollout order is:
1. **Pattern 1 first** — get visibility (lowest risk, highest immediate value)
2. **Pattern 3 next** — secure IIQ's own operations (operational hygiene)
3. **Pattern 2 last** — automate provisioning (highest value, requires most testing)
