# Safes

## What Is a Safe?

A **Safe** is a logical container within the CyberArk Vault that holds privileged accounts and other objects. Think of it as a secure folder with its own access control list.

Safes are the **primary unit of access control** in CyberArk — permissions are granted at the Safe level, not at the individual account level.

## Safe Properties

| Property | Description | Example |
|----------|-------------|---------|
| `SafeName` | Unique name of the Safe | `IT-Windows-Servers-Prod` |
| `Description` | Human-readable description | `Production Windows server admin accounts` |
| `ManagingCPM` | Which CPM instance manages accounts in this Safe | `PasswordManager` |
| `NumberOfVersionsRetention` | How many previous password versions to keep | `5` |
| `NumberOfDaysRetention` | How many days to retain old versions | `30` |
| `CreationTime` | When the Safe was created | `1704067200` (Unix timestamp) |
| `LastModificationTime` | When the Safe was last modified | `1704672000` |

## Safe Naming Conventions

Organizations typically follow a naming convention that encodes metadata into the Safe name. Common patterns:

```
{Department}-{SystemType}-{Environment}

Examples:
  IT-Windows-Prod
  IT-Linux-Dev
  DBA-Oracle-Prod
  Network-Cisco-All
  Cloud-AWS-Prod
  HR-SAP-Prod
```

This is important for dashboards because you can **parse Safe names** to create groupings and filters (by department, system type, environment) without needing a separate mapping table.

## System Safes vs User Safes

CyberArk creates several built-in **System Safes** during installation. These should be **excluded from dashboard account counts**:

| System Safe | Purpose |
|-------------|---------|
| `System` | Internal Vault system objects |
| `VaultInternal` | Vault internal configuration |
| `PasswordManager` | CPM configuration |
| `PasswordManager_Pending` | CPM pending account changes |
| `PasswordManager_workspace` | CPM working area |
| `PVWAConfig` | PVWA configuration |
| `PVWAReports` | PVWA report templates |
| `PVWATicketingSystem` | Ticketing integration config |
| `PSM` | PSM configuration |
| `PSMLiveSessions` | Active session metadata |
| `PSMRecordings` | Session recordings storage |
| `PSMUniversalConnectors` | PSM connector configuration |
| `PVWAPublicData` | Public PVWA resources |
| `PVWATaskDefinitions` | PVWA task definitions |
| `Notification Engine` | Notification configuration |
| `AccountsFeedADAccounts` | Account discovery results |
| `AccountsFeedDiscoveryLogs` | Discovery log storage |

**Dashboard tip**: When counting accounts or safes, filter out safes where `SafeName` starts with common system prefixes or matches known system safe names.

## Safe Members and Permissions

Each Safe has **Safe Members** — users or groups with specific permissions:

```
Safe: IT-Windows-Prod
├── Member: IT-Windows-Admins (AD Group)
│   ├── ListAccounts ✓
│   ├── RetrieveAccounts ✓
│   ├── UseAccounts ✓
│   └── ...
├── Member: Security-Auditors (AD Group)
│   ├── ListAccounts ✓
│   ├── ViewAuditLog ✓
│   └── ...
├── Member: PasswordManager (CPM user)
│   ├── RetrieveAccounts ✓
│   ├── UpdateAccountContent ✓
│   └── InitiateCPMManagement ✓
└── Member: PSMApp_<server> (PSM user)
    ├── RetrieveAccounts ✓
    └── UseAccounts ✓
```

See [Policies and Permissions](policies-and-permissions.md) for the full list of Safe permissions.

## Dashboard Relevance

### Key Metrics
- **Total Safes** (excluding system safes)
- **Accounts per Safe** — identifies over-stuffed or empty safes
- **Safes by department/environment** — parsed from naming convention
- **Safes without a Managing CPM** — accounts in these safes won't have automatic rotation
- **Safe creation trend** — safes created over time (indicates onboarding velocity)

### API Access
- `GET /api/Safes` — lists all safes with metadata
- `GET /api/Safes/{safeName}/Members` — lists members and their permissions for a safe

### Dashboard Filter Dimension
Safes are a natural **filter dimension** in Power BI. Users should be able to filter all dashboard metrics by Safe (or by groups of safes parsed from the naming convention).
