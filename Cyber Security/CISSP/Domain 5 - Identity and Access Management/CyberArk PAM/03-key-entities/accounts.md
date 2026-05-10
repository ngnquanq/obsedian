# Accounts

## What Is an Account?

An **Account** is the central entity in CyberArk. It represents a single privileged credential managed by the system. Every password, SSH key, or other secret that CyberArk manages is stored as an account.

When people say "CyberArk manages 5,000 accounts," they mean 5,000 privileged credentials are stored, rotated, and monitored through CyberArk.

## Account Properties

### Core Properties

| Property | Description | Example |
|----------|-------------|---------|
| `id` | Unique account ID (internal) | `123_45` |
| `name` | Display name (auto-generated or manual) | `Operating System-WinDomain-admin01-server01.corp.com` |
| `userName` | The actual username on the target system | `admin01` |
| `address` | Target system hostname/IP | `server01.corp.com` |
| `platformId` | Platform that governs this account | `WinDomain` |
| `safeName` | Safe where this account is stored | `IT-Windows-Prod` |
| `secretType` | Type of credential | `password`, `key`, `file` |
| `createdTime` | When the account was onboarded | `1704067200` |

### Secret Management Properties (CPM Status)

These fields are **critical for dashboards** — they reflect the health of password management:

| Property | Description | Example |
|----------|-------------|---------|
| `status` | CPM management status | `success`, `failure`, `CPMDisabled` |
| `lastModifiedTime` | When the password was last rotated | `1706745600` |
| `lastVerifiedTime` | When the password was last verified | `1706832000` |
| `lastReconciledTime` | When the password was last reconciled | `1706400000` |
| `lastTask` | Last CPM operation | `ChangeTask`, `VerifyTask`, `ReconcileTask` |
| `failReason` | Why the last CPM operation failed | `CACPM001 - Cannot connect to target` |

### Platform-Specific Properties

Each platform can define additional properties. Common examples:

| Property | Description | Platforms |
|----------|-------------|-----------|
| `Port` | Connection port | SSH (22), Oracle (1521), MSSQL (1433) |
| `Database` | Database name or SID | Oracle, MSSQL |
| `LogonDomain` | Domain for authentication | Windows domain accounts |
| `SID` | Oracle System Identifier | Oracle |
| `DSN` | Data Source Name | ODBC-based platforms |

## Account Lifecycle

```
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ Discover │───►│ Onboard  │───►│ Manage   │───►│ Monitor  │
│          │    │          │    │          │    │          │
│ Scan for │    │ Add to   │    │ CPM auto │    │ Track    │
│ priv.    │    │ Safe,    │    │ rotates, │    │ status,  │
│ accounts │    │ assign   │    │ verifies,│    │ sessions │
│ on       │    │ platform │    │ reconciles│   │ & audits │
│ targets  │    │          │    │          │    │          │
└──────────┘    └──────────┘    └──────────┘    └──────────┘
```

### Account States

| State | Meaning | Dashboard Color |
|-------|---------|-----------------|
| **Managed + Healthy** | CPM active, last rotation succeeded | Green |
| **Managed + Failing** | CPM active, last rotation failed | Red |
| **Managed + CPM Disabled** | Account in CyberArk but CPM turned off | Yellow |
| **Pending** | Discovered but not yet onboarded | Gray |
| **Unmanaged** | Detected by PTA but not in CyberArk at all | Red (security risk) |

## Account Categories

| Category | Description |
|----------|-------------|
| **Privileged Account** | Regular admin/root/DBA account managed by CyberArk |
| **Service Account** | Account used by applications/services (not humans) |
| **Reconciliation Account** | Higher-privilege account used by CPM to force-reset passwords |
| **Logon Account** | Account CPM uses to authenticate to a target before changing another account's password |
| **Discovery Account** | Account used to scan systems for undiscovered privileged accounts |

## Account Name Convention

CyberArk auto-generates account names using this pattern:
```
{SystemType}-{PlatformID}-{UserName}-{Address}
```

Examples:
- `Operating System-WinDomain-admin01-server01.corp.com`
- `Operating System-UnixSSH-root-linux01.corp.com`
- `Database-Oracle-sys-oradb01.corp.com`

## Dashboard Relevance

Accounts are the most important entity for dashboards. Key metrics:

### Inventory Metrics
- **Total managed accounts**
- **Accounts by platform** (WinDomain, UnixSSH, Oracle, etc.)
- **Accounts by safe** (and by department/environment from safe naming)
- **Accounts by secret type** (password vs SSH key vs file)
- **New accounts onboarded** (trend over time)

### Password Health Metrics
- **Password age distribution** = `now - lastModifiedTime` for each account
- **Accounts overdue for rotation** = password age > policy threshold (e.g., 90 days)
- **Rotation success rate** = accounts with `status = success` / total managed
- **Failed rotations** = accounts with `status = failure` (list + count)
- **CPM disabled accounts** = accounts with `status = CPMDisabled` (count + reasons)
- **Accounts never rotated** = `lastModifiedTime` is null or very old
- **Verification failures** = accounts where last verify failed

### Compliance Metrics
- **Managed vs discovered accounts** (coverage %)
- **Accounts with dual control** enabled
- **Accounts with session recording** required
- **Accounts with exclusive access** enabled

### API Access
- `GET /api/Accounts` — list/search all accounts (supports filtering, pagination)
- `GET /api/Accounts/{id}` — single account details
- `GET /api/Accounts/{id}/Activities` — audit trail for an account

### Power BI Dimension
Accounts are the **fact table** in your Power BI data model. Safes, platforms, and users are dimension tables that join to accounts.
