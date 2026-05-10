# Users and Groups

## What Are Vault Users?

CyberArk has its own user directory inside the Vault. Every person or system that interacts with CyberArk needs a Vault user identity. These are separate from Active Directory accounts (though they can be linked via LDAP integration).

## User Types

### Human Users
People who log into PVWA to access privileged accounts and sessions.

| Source | Description |
|--------|-------------|
| **CyberArk (local)** | User created directly in the Vault |
| **LDAP / Active Directory** | User authenticated against AD; most common in enterprise |
| **RADIUS** | User authenticated via RADIUS (often for MFA) |
| **SAML** | User authenticated via SSO identity provider |
| **PKI** | User authenticated via client certificate |

Most organizations use **LDAP integration** so users log into PVWA with their Active Directory credentials.

### Built-In System Users

These are created during installation and used internally by CyberArk components:

| User | Purpose |
|------|---------|
| `Administrator` | Vault admin — initial setup and emergency access |
| `Master` | Master user — can access all safes (break-glass only) |
| `Batch` | Used for batch operations |
| `Auditor` | Built-in auditor role |
| `NotificationEngine` | Sends email notifications |
| `PVWAAppUser` | PVWA's own Vault connection |
| `PasswordManager` | CPM's Vault connection (may have numbered variants: `PasswordManager1`, `PasswordManager2`) |
| `PSMApp_<server>` | PSM's Vault connection (one per PSM server) |
| `PVWAGWUser` | PVWA gateway user |
| `DR` | Disaster Recovery replication user |

**Dashboard tip**: Exclude built-in system users when counting "active users" or showing user activity metrics.

### Application Users (AppIDs)

Used by AAM/CCP to authenticate applications. Not human users — they represent applications that retrieve credentials.

## Groups

### LDAP Groups
When LDAP is configured, Active Directory groups can be mapped into CyberArk:
- AD group → Safe Member with specific permissions
- Users in the AD group automatically get those permissions
- Group membership changes in AD are reflected in CyberArk

### Vault Groups
Groups can also be created directly in the Vault (without LDAP), but this is less common.

### Common Group Patterns

```
AD Group                          CyberArk Role
──────────                        ──────────────
CyberArk-IT-Admins              → Safe members of IT-* safes (full access)
CyberArk-IT-ReadOnly            → Safe members of IT-* safes (list + view only)
CyberArk-DBA-Admins             → Safe members of DBA-* safes (full access)
CyberArk-Security-Auditors      → Safe members of all safes (audit only)
CyberArk-Vault-Admins           → Vault administrators
CyberArk-Approvers              → Dual control approvers for high-security safes
```

## User Properties

| Property | Description | Example |
|----------|-------------|---------|
| `id` | Internal user ID | `42` |
| `username` | Login name | `john.doe` |
| `source` | Authentication source | `CyberArk`, `LDAP` |
| `userType` | User type | `EPVUser`, `AppProvider`, `AIMAccount` |
| `componentUser` | Is this a system component user? | `true`, `false` |
| `suspended` | Is the account suspended? | `true`, `false` |
| `lastSuccessfulLoginDate` | Last login timestamp | `1706745600` |
| `loginCount` | Total number of logins | `347` |

## Dashboard Relevance

### Key Metrics
- **Total active users** (excluding system/component users)
- **Users by authentication source** (CyberArk vs LDAP vs SAML)
- **Dormant users** — users who haven't logged in for X days
- **Suspended users** — accounts that have been disabled
- **Top users by activity** — most active users (by login count or session count)
- **User-to-safe mapping** — which users/groups have access to which safes (entitlement report)
- **Users with broad access** — users who are members of many safes (potential risk)

### API Access
- `GET /api/Users` — lists all vault users
- `GET /api/Users/{id}` — user details

### Power BI Dimension
Users are a **dimension table** that joins to sessions (who initiated the session) and audit logs (who performed the action).
