# Power BI Integration

## Overview

This guide covers how to connect Power BI to CyberArk data. There are several approaches, each with trade-offs. Choose based on your environment, data volume, and refresh requirements.

## Integration Architecture Options

### Option A: Direct API via Power Query (Simplest)

```
CyberArk PVWA REST API  ──►  Power Query (M)  ──►  Power BI Dataset
```

Power BI calls the CyberArk API directly using custom Power Query (M language) functions.

**Pros**:
- Simplest architecture — no intermediate systems
- No additional infrastructure needed
- Data is always fresh when refreshed

**Cons**:
- Power Query has limited HTTP capabilities (no persistent sessions, tricky auth)
- Refresh time increases with data volume (API pagination is slow for large environments)
- PVWA must be network-accessible from Power BI (Desktop or Service)
- API rate limits may be a concern with frequent refreshes

**Best for**: Small-medium environments (< 5,000 accounts), proof-of-concept dashboards.

#### How It Works in Power Query

```
1. Call POST /api/auth/CyberArk/Logon → get session token
2. Call GET /api/Accounts (paginated) with token → get all accounts
3. Call GET /api/Safes → get all safes
4. Call GET /api/ComponentMonitoring/Details → get health data
5. Call POST /api/auth/Logoff → release session
6. Transform JSON into tables
7. Load into Power BI data model
```

Power Query (M) example for authentication:
```
// M Language pseudocode
let
    url = "https://<pvwa>/PasswordVault/api/auth/CyberArk/Logon",
    body = "{""username"":""dashboard_svc"",""password"":""<password>""}",
    response = Web.Contents(url, [
        Content = Text.ToBinary(body),
        Headers = [#"Content-Type"="application/json"]
    ]),
    token = Text.FromBinary(response)
in
    token
```

### Option B: Staging Database (Recommended for Production)

```
Scheduled Script  ──►  CyberArk API  ──►  SQL Server  ──►  Power BI
(Python/PowerShell)                       (staging DB)     (DirectQuery
                                                           or Import)
```

A scheduled script pulls data from the CyberArk API and loads it into a SQL Server database. Power BI connects to SQL Server.

**Pros**:
- Decouples data collection from visualization
- SQL Server handles complex queries efficiently
- Power BI refreshes are fast (reading from SQL, not API)
- Historical data can be accumulated (API only shows current state)
- Script can handle pagination, retries, and error handling robustly
- Multiple dashboards/reports can share the same data

**Cons**:
- Requires SQL Server (or another database)
- Requires a scheduled task (Windows Task Scheduler, SQL Agent, or cron)
- More moving parts to maintain

**Best for**: Production environments, large deployments (5,000+ accounts), multiple dashboard consumers.

#### Staging Database Schema

```sql
-- Core fact tables
CREATE TABLE dbo.Accounts (
    AccountID       NVARCHAR(100) PRIMARY KEY,
    AccountName     NVARCHAR(500),
    UserName        NVARCHAR(200),
    Address         NVARCHAR(500),
    PlatformID      NVARCHAR(200),
    SafeName        NVARCHAR(200),
    SecretType      NVARCHAR(50),
    CPMStatus       NVARCHAR(50),
    LastModifiedTime DATETIME2,
    LastVerifiedTime DATETIME2,
    LastReconciledTime DATETIME2,
    FailReason      NVARCHAR(1000),
    CreatedTime     DATETIME2,
    PasswordAge_Days AS DATEDIFF(DAY, LastModifiedTime, GETUTCDATE()),
    LastSyncTime    DATETIME2  -- when this row was last updated
);

CREATE TABLE dbo.Sessions (
    SessionID       NVARCHAR(200) PRIMARY KEY,
    [User]          NVARCHAR(200),
    FromIP          NVARCHAR(50),
    RemoteMachine   NVARCHAR(500),
    Protocol        NVARCHAR(50),
    Client          NVARCHAR(200),
    StartTime       DATETIME2,
    EndTime         DATETIME2,
    Duration_Seconds INT,
    RiskScore       INT,
    AccountUsername  NVARCHAR(200),
    AccountSafeName NVARCHAR(200),
    SessionStatus   NVARCHAR(50),
    LastSyncTime    DATETIME2
);

-- Dimension tables
CREATE TABLE dbo.Safes (
    SafeName        NVARCHAR(200) PRIMARY KEY,
    Description     NVARCHAR(1000),
    ManagingCPM     NVARCHAR(200),
    CreationTime    DATETIME2,
    LastSyncTime    DATETIME2
);

CREATE TABLE dbo.Platforms (
    PlatformID      NVARCHAR(200) PRIMARY KEY,
    PlatformName    NVARCHAR(500),
    Active          BIT,
    SystemType      NVARCHAR(100),
    LastSyncTime    DATETIME2
);

CREATE TABLE dbo.ComponentHealth (
    ComponentID     NVARCHAR(200),
    ComponentName   NVARCHAR(500),
    IsConnected     BIT,
    LastLogonDate   DATETIME2,
    ComponentVersion NVARCHAR(50),
    CheckTime       DATETIME2,
    PRIMARY KEY (ComponentID, CheckTime)
);

-- Snapshot table for historical tracking
CREATE TABLE dbo.DailySnapshot (
    SnapshotDate    DATE PRIMARY KEY,
    TotalAccounts   INT,
    RotationSuccessRate DECIMAL(5,2),
    FailedRotations INT,
    CPMDisabledCount INT,
    AvgPasswordAge_Days DECIMAL(10,2),
    TotalSessions   INT,
    HighRiskSessions INT,
    AllComponentsHealthy BIT
);
```

#### Script Schedule

| Data | Script Frequency | Rationale |
|------|-----------------|-----------|
| Component Health | Every 5 minutes | Detect outages quickly |
| Live Sessions | Every 5 minutes | Near real-time monitoring |
| Accounts | Every 30 minutes | Rotation happens on schedule, not real-time |
| Safes & Platforms | Every 4 hours | Rarely change |
| Session Recordings | Every 1 hour | Historical data |
| Daily Snapshot | Once per day | Historical trend tracking |

### Option C: SIEM Pipeline (For PTA/Security Data)

```
CyberArk PTA  ──►  Syslog (CEF)  ──►  SIEM  ──►  Power BI
                                      (Splunk,    Connector
                                       Sentinel,
                                       ELK)
```

PTA security events flow through Syslog to a SIEM. Power BI connects to the SIEM.

**Pros**:
- PTA data is natively designed to flow to SIEM
- SIEM provides correlation, alerting, and retention
- Power BI connectors exist for major SIEMs (Splunk, Azure Sentinel)

**Cons**:
- Requires SIEM infrastructure
- Only covers PTA security data, not accounts/rotation/health

**Best for**: Security dashboards, environments that already have a SIEM.

## Power BI Data Model (Star Schema)

```
                    ┌──────────────┐
                    │   Platforms   │
                    │ (Dimension)  │
                    └──────┬───────┘
                           │ PlatformID
                           │
┌──────────────┐    ┌──────┴───────┐    ┌──────────────┐
│    Safes     │────│   Accounts   │────│    Users     │
│ (Dimension)  │    │   (Fact)     │    │ (Dimension)  │
└──────────────┘    └──────┬───────┘    └──────┬───────┘
    SafeName               │                    │
                           │                    │
                    ┌──────┴───────┐    ┌──────┴───────┐
                    │  Sessions    │    │  Date/Time   │
                    │   (Fact)     │    │ (Dimension)  │
                    └──────────────┘    └──────────────┘
```

### Relationships

| From | To | Key | Type |
|------|----|-----|------|
| Accounts | Safes | SafeName | Many-to-One |
| Accounts | Platforms | PlatformID | Many-to-One |
| Sessions | Users | User → username | Many-to-One |
| Sessions | Accounts | AccountUsername + AccountAddress | Many-to-One |
| Sessions | Date/Time | StartTime | Many-to-One |

### Date/Time Dimension

Create a standard Power BI date table for time intelligence:
- Date, Month, Quarter, Year
- Day of Week, Hour of Day
- Is Weekend, Is Business Hours
- Fiscal periods (if applicable)

This enables time-intelligence DAX functions (YTD, MoM, etc.).

## Power BI Measures (DAX)

Key DAX measures for CyberArk dashboards:

```dax
// Rotation Success Rate
Rotation Success Rate =
DIVIDE(
    COUNTROWS(FILTER(Accounts, Accounts[CPMStatus] = "success")),
    COUNTROWS(Accounts),
    0
)

// Average Password Age
Avg Password Age =
AVERAGE(Accounts[PasswordAge_Days])

// Accounts Overdue (assuming 90-day policy)
Overdue Accounts =
COUNTROWS(FILTER(Accounts, Accounts[PasswordAge_Days] > 90))

// Active Session Count
Active Sessions =
COUNTROWS(FILTER(Sessions, Sessions[SessionStatus] = "Active"))

// High Risk Sessions (last 24h)
High Risk Sessions 24h =
COUNTROWS(
    FILTER(Sessions,
        Sessions[RiskScore] > 50 &&
        Sessions[StartTime] >= NOW() - 1
    )
)
```

## Service Account Setup

Create a dedicated CyberArk user for dashboard API access:

1. **Create a Vault user** named something like `svc_powerbi_dashboard`
2. **Assign Auditor-level permissions** on all relevant safes:
   - `ListAccounts` ✓
   - `ViewAuditLog` ✓
   - `ViewSafeMembers` ✓
   - Everything else ✗
3. **Use CyberArk or LDAP authentication** (not SAML — SAML requires browser interaction)
4. **Exclude from lockout policies** if possible (API users can accidentally lock themselves out)
5. **Document the service account** and include it in your operational runbook

## Network Requirements

Power BI (or the staging script) must be able to reach:
- PVWA on **port 443 (HTTPS)**
- If using staging DB: SQL Server on **port 1433**
- If using SIEM: SIEM API endpoint

Ensure firewall rules allow this traffic. If Power BI Service (cloud) is used, it may need an **On-premises Data Gateway** to reach the internal PVWA.

## Power BI Deployment Options

| Option | How It Works | Refresh |
|--------|-------------|---------|
| **Power BI Desktop** | Local .pbix file, manual refresh | Manual |
| **Power BI Service (Import)** | Published to Power BI Service, scheduled refresh | Scheduled (8x/day free, 48x/day Pro) |
| **Power BI Service (DirectQuery)** | Live queries to SQL staging DB | Real-time |
| **Power BI Embedded** | Embedded in internal web portal | Depends on configuration |

For production CyberArk dashboards, **Option B (Staging DB) + Power BI Service (Import with scheduled refresh)** is the recommended approach.

## Security Considerations

- **Never hardcode credentials** in Power Query or scripts — use credential managers or CyberArk itself (CyberArk managing its own dashboard service account credentials)
- **Use HTTPS** for all API calls
- **Limit the service account** to read-only (Auditor) permissions
- **Log API access** to monitor dashboard query patterns
- **Handle self-signed certificates** — your PVWA may use an internal CA certificate that Power BI doesn't trust by default
