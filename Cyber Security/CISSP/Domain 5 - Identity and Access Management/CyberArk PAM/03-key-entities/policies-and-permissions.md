# Policies and Permissions

## How Access Control Works in CyberArk

CyberArk uses a **Safe-level permission model**. Permissions are not assigned to individual accounts — they are assigned to **Safes**. If you have access to a Safe, you have access to all accounts in it (subject to your specific permission set).

```
User/Group ────► Safe Member ────► Permission Set
                                      │
                                      ├── ListAccounts
                                      ├── RetrieveAccounts
                                      ├── UseAccounts
                                      └── ...
```

## Safe Member Permissions

Each Safe Member (user or group) has a set of granular permissions. These are the key ones:

### Account Access Permissions

| Permission | What It Allows |
|-----------|----------------|
| `ListAccounts` | See that accounts exist in the Safe (view the list) |
| `RetrieveAccounts` | Copy the password to clipboard or view it |
| `UseAccounts` | Use the account to connect via PSM (without seeing the password) |
| `ViewAuditLog` | View the activity log for accounts in the Safe |
| `ViewSafeMembers` | See who else has access to the Safe |

### Account Management Permissions

| Permission | What It Allows |
|-----------|----------------|
| `AddAccounts` | Add new accounts to the Safe |
| `UpdateAccountContent` | Change the stored password manually |
| `UpdateAccountProperties` | Modify account properties (address, platform, etc.) |
| `DeleteAccounts` | Remove accounts from the Safe |
| `RenameAccounts` | Change account names |
| `MoveAccountsAndFolders` | Move accounts between folders within the Safe |

### CPM Permissions

| Permission | What It Allows |
|-----------|----------------|
| `InitiateCPMAccountManagementOperations` | Trigger password change, verify, or reconcile |
| `SpecifyNextAccountContent` | Set what the next password will be (instead of auto-generated) |

### Workflow Permissions

| Permission | What It Allows |
|-----------|----------------|
| `RequestsAuthorizationLevel1` | Approve or reject access requests (Level 1 approver) |
| `RequestsAuthorizationLevel2` | Approve or reject access requests (Level 2 approver) |
| `AccessWithoutConfirmation` | Bypass dual control — access accounts without approval |

### Safe Management Permissions

| Permission | What It Allows |
|-----------|----------------|
| `ManageSafe` | Modify Safe properties |
| `ManageSafeMembers` | Add/remove members and change their permissions |
| `BackupSafe` | Create backup of the Safe |

## Common Permission Profiles (Roles)

Organizations typically create standard permission profiles that map to job roles:

### End User (Account Consumer)
- `ListAccounts` ✓
- `UseAccounts` ✓ (connect via PSM)
- `RetrieveAccounts` ✗ (cannot see the password)
- Everything else ✗

### Power User
- `ListAccounts` ✓
- `UseAccounts` ✓
- `RetrieveAccounts` ✓ (can see/copy the password)
- `InitiateCPMAccountManagementOperations` ✓
- Everything else ✗

### Safe Administrator
- All account access and management permissions ✓
- `ManageSafe` ✓
- `ManageSafeMembers` ✓

### Auditor
- `ListAccounts` ✓
- `ViewAuditLog` ✓
- `ViewSafeMembers` ✓
- Everything else ✗

### CPM Service Account
- `ListAccounts` ✓
- `RetrieveAccounts` ✓
- `UpdateAccountContent` ✓
- `InitiateCPMAccountManagementOperations` ✓

## Master Policy

The **Master Policy** is a global set of rules that apply to all platforms and accounts **by default**. Individual platforms can override these settings.

### Master Policy Sections

#### Privileged Access
| Setting | Description | Default |
|---------|-------------|---------|
| `RequireDualControlPasswordAccessApproval` | Require approval before accessing passwords | No |
| `EnforceCheckInCheckOut` | Require check-out/check-in workflow | No |
| `EnforceOnetimePasswordAccess` | Change password after every use | No |
| `ExclusiveAccess` | Only one user can access an account at a time | No |

#### Password Management
| Setting | Description | Default |
|---------|-------------|---------|
| `RequirePasswordChangeEveryXDays` | Auto-rotate password on schedule | 90 days |
| `RequirePasswordVerificationEveryXDays` | Auto-verify password on schedule | 7 days |
| `AutoVerifyOnAdd` | Verify password when account is first added | Yes |
| `AutoChangeOnAdd` | Change password when account is first added | No |
| `HeadStartInterval` | Hours before expiry to start rotation | 5 hours |

#### Session Management
| Setting | Description | Default |
|---------|-------------|---------|
| `RequirePrivilegedSessionMonitoringAndIsolation` | Require PSM for all connections | No |
| `RecordAndSaveSessionActivity` | Record all sessions | Yes |
| `PSMServerID` | Default PSM server | (configured) |

#### Audit
| Setting | Description | Default |
|---------|-------------|---------|
| `NotifyOnPasswordUsed` | Send notification when password is retrieved | No |
| `NotifyOnOpenRequest` | Send notification on access requests | No |

## Dual Control (Approval Workflow)

When dual control is enabled for a Safe:

```
1. User requests access to an account
2. Request sent to approver(s)
3. Approver reviews and approves/rejects
4. If approved → user can access the account for a limited time
5. Time expires → access revoked automatically
```

Dashboard metrics:
- Pending requests count
- Average approval time
- Requests approved vs rejected
- Accounts requiring dual control

## Dashboard Relevance

### Key Metrics
- **Permission distribution** — how many users/groups have each permission type
- **Overprivileged users** — users with `RetrieveAccounts` who should only have `UseAccounts`
- **Safe members per safe** — identifies safes with too many or too few members
- **Dual control adoption** — % of safes/accounts with dual control enabled
- **Master Policy compliance** — accounts/platforms that override Master Policy settings
- **Access patterns** — which users access which safes most frequently

### API Access
- `GET /api/Safes/{safeName}/Members` — list members and permissions for a safe
- Master Policy settings are available via PVWA configuration APIs

### Power BI Use
Permission data creates a many-to-many relationship (users ↔ safes). In Power BI, this is modeled as a bridge table: `UserSafePermissions` linking the Users dimension to the Safes dimension.
