# Platforms

## What Is a Platform?

A **Platform** (historically called a "Policy") is a configuration template that defines **how CyberArk manages a specific type of account**. It specifies:

- How to rotate the password (rotation method)
- How to verify the password (verification method)
- How to connect for a session (connection component)
- Password complexity rules
- Rotation frequency and timing

Every account is associated with exactly one platform. The platform determines the account's behavior.

## Platform = Account Type Blueprint

Think of it this way:
- An **Account** is a specific credential (e.g., `root` on `linux01.corp.com`)
- A **Platform** is the blueprint that says "this is how we manage all Unix root accounts"

```
Platform: UnixSSH
├── Rotation method: SSH + sudo passwd
├── Verification method: SSH login test
├── Connection component: PSM-SSH
├── Password complexity: 20 chars, upper+lower+digits+special
├── Rotation every: 30 days
├── Verify every: 7 days
│
├── Account: root@linux01.corp.com
├── Account: root@linux02.corp.com
├── Account: root@linux03.corp.com
└── Account: admin@linux04.corp.com
```

## Built-In Platforms

CyberArk ships with many pre-built platforms. Common ones:

### Operating Systems
| Platform ID | Target System |
|-------------|---------------|
| `WinDomain` | Windows Active Directory domain accounts |
| `WinServerLocal` | Windows local administrator accounts |
| `UnixSSH` | Unix/Linux accounts (password-based SSH) |
| `UnixSSHKeys` | Unix/Linux SSH key management |

### Databases
| Platform ID | Target System |
|-------------|---------------|
| `Oracle` | Oracle database accounts |
| `MSSQLServer` | Microsoft SQL Server accounts |
| `MySQL` | MySQL database accounts |
| `PostgreSQL` | PostgreSQL database accounts |

### Network Devices
| Platform ID | Target System |
|-------------|---------------|
| `CiscoIOS` | Cisco IOS routers and switches |
| `CiscoIOS-Enable` | Cisco IOS enable password |
| `JuniperJunOS` | Juniper network devices |
| `PaloAlto` | Palo Alto firewalls |

### Cloud
| Platform ID | Target System |
|-------------|---------------|
| `AWSAccessKeys` | AWS IAM access keys |
| `AzurePassword` | Azure AD service principal passwords |

### Other
| Platform ID | Target System |
|-------------|---------------|
| `WinDomainServiceAccount` | Windows domain service accounts |
| `INFRAGroupPassword` | Infrastructure group passwords |

## Custom Platforms

Organizations can **duplicate and customize** built-in platforms to match their environment:

1. Duplicate a built-in platform (e.g., copy `UnixSSH` to `UnixSSH-Custom`)
2. Modify settings: rotation frequency, password complexity, connection component
3. Assign the custom platform to accounts

Common customizations:
- Different password complexity for different environments
- Custom rotation scripts for non-standard systems
- Modified connection components for specific applications

## Platform Properties

| Property | Description |
|----------|-------------|
| `PlatformID` | Unique identifier |
| `Name` | Display name |
| `Active` | Whether the platform is enabled (true/false) |
| `SystemType` | Category: `Windows`, `Unix`, `Database`, `Network`, etc. |
| `AllowedSafes` | Pattern restricting which safes can use this platform |
| `PrivilegedAccessWorkflows` | Dual control, exclusive access settings |
| `CredentialsManagementPolicy` | Rotation frequency, verification frequency |
| `SessionManagement` | Session recording, PSM server assignment |

## Platform Settings That Affect Dashboards

### Credentials Management Policy
| Setting | Dashboard Impact |
|---------|-----------------|
| `RequirePasswordChangeEveryXDays` | Defines the "overdue" threshold for rotation dashboards |
| `RequireVerifyEveryXDays` | Defines the verification schedule |
| `HeadStartInterval` | How early before expiry CPM starts rotation |
| `AutoVerifyOnAdd` | Whether new accounts are verified immediately |
| `AllowManualChange` | Whether users can trigger manual rotation |

### Session Management
| Setting | Dashboard Impact |
|---------|-----------------|
| `RequirePrivilegedSessionMonitoring` | Affects session compliance % |
| `RecordSession` | Whether sessions are recorded |
| `PSMServerID` | Which PSM server handles sessions |

## Dashboard Relevance

### Key Metrics
- **Accounts by platform** — pie/bar chart showing distribution across platforms
- **Platform health** — rotation success rate per platform (identifies problematic platform configurations)
- **Active vs inactive platforms** — how many platforms are in use vs disabled
- **Platform-specific failure rates** — some platforms may have higher failure rates (e.g., network devices more likely to timeout)

### API Access
- `GET /api/Platforms` — lists all platforms and their configurations

### Power BI Dimension
Platforms are a **dimension table** in your data model, joined to the accounts fact table via `platformId`. This lets you slice all account metrics by platform type.
