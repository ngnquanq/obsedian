# Sessions

## What Is a Session?

A **Session** (PSM Session) represents a privileged connection made through CyberArk's Privileged Session Manager. Every time a user connects to a target system through CyberArk, a session object is created.

Sessions provide the audit trail that proves: **who** connected to **what**, **when**, for **how long**, and with **what level of risk**.

## Session Properties

| Property | Description | Example |
|----------|-------------|---------|
| `SessionID` | Unique identifier | `5a3f7b2c-1234-5678-abcd-ef0123456789` |
| `User` | CyberArk user who initiated the session | `john.doe` |
| `FromIP` | Source IP address of the user | `10.1.2.50` |
| `RemoteMachine` | Target system connected to | `server01.corp.com` |
| `Protocol` | Connection protocol | `RDP`, `SSH` |
| `Client` | Connection component used | `PSM-RDP`, `PSM-SSH` |
| `Start` | Session start time | `2024-01-15T09:30:00Z` |
| `End` | Session end time (null if active) | `2024-01-15T10:15:00Z` |
| `Duration` | Duration in seconds | `2700` |
| `RiskScore` | PTA-assigned risk score (0-100) | `35` |
| `AccountUsername` | The privileged account used | `admin01` |
| `AccountAddress` | Target address of the account | `server01.corp.com` |
| `AccountPlatformID` | Platform of the account used | `WinDomain` |
| `AccountSafeName` | Safe containing the account | `IT-Windows-Prod` |
| `ConnectionComponentID` | PSM connection component | `PSM-RDP` |
| `SessionStatus` | Current status | `Active`, `Completed`, `Terminated` |
| `PSMServerID` | Which PSM server handled the session | `PSM-Server01` |

## Session Types

### By Protocol
| Type | Description |
|------|-------------|
| **RDP Session** | Remote Desktop to Windows targets via PSM |
| **SSH Session** | SSH terminal to Linux/Unix targets via PSMP |
| **SFTP Session** | File transfer via PSMP |
| **Web Session** | Browser-based session to web consoles via PSM |
| **SQL Session** | Database management sessions (SSMS, SQL*Plus) via PSM |

### By Status
| Status | Meaning |
|--------|---------|
| **Active** | Session is currently in progress (user is connected) |
| **Completed** | User disconnected normally |
| **Terminated** | An admin forcibly ended the session |

## Live Sessions vs Recordings

CyberArk distinguishes between two views of sessions:

### Live Sessions (`/api/LiveSessions`)
- Currently active sessions
- Real-time data
- Supports monitoring actions: view live, suspend, terminate
- Use for: real-time session count dashboard widget

### Recordings (`/api/Recordings`)
- Historical completed sessions
- Includes session metadata and activity summaries
- Recording playback is through PVWA UI (not API)
- Use for: historical analytics, trends, compliance reports

## Session Activities

Within each session, CyberArk tracks **activities** — specific actions performed during the session:

| Activity Type | Description |
|--------------|-------------|
| `Window activated` | User switched to a specific window |
| `Command executed` | A command was typed in a terminal |
| `File transferred` | A file was uploaded or downloaded |
| `Keystroke` | Keystrokes captured (for text search) |

These activities make session recordings **searchable** — an auditor can search for "DROP TABLE" across all recordings to find dangerous commands.

## Risk Scores

PTA assigns risk scores to sessions based on behavioral analysis:

| Factor | How It Affects Risk Score |
|--------|--------------------------|
| **Time of access** | Unusual hours (midnight, weekends) increase risk |
| **Source location** | New or unusual IP/location increases risk |
| **Target sensitivity** | Access to highly sensitive systems increases risk |
| **Session duration** | Unusually long or short sessions |
| **Commands executed** | Dangerous commands (rm -rf, DROP, FORMAT) increase risk |
| **Behavioral deviation** | Actions that deviate from user's historical pattern |

If PTA is not deployed, risk scores will be 0 or absent.

## Dashboard Relevance

### Real-Time Metrics (from LiveSessions)
- **Active session count** — current number of open sessions
- **Active sessions by protocol** — RDP vs SSH vs other
- **Active sessions by user** — who is currently connected
- **Active sessions by target** — which systems have active sessions
- **High-risk active sessions** — sessions with risk score above threshold

### Historical Metrics (from Recordings)
- **Total sessions per day/week/month** — trend over time
- **Sessions by user** — top N most active users
- **Sessions by target** — top N most accessed targets
- **Sessions by protocol** — RDP vs SSH distribution
- **Average session duration** — overall and by user/target/protocol
- **Session duration distribution** — histogram
- **Risk score distribution** — histogram across all sessions
- **High-risk session count** — sessions with score > 50 (configurable threshold)
- **Terminated sessions** — sessions forcibly ended by admins
- **Sessions by time of day** — heatmap showing peak usage hours
- **Sessions by day of week** — usage patterns

### Compliance Metrics
- **Session recording coverage** — % of accounts where sessions are recorded
- **Unrecorded sessions** — sessions that bypassed PSM (if any)
- **Session audit completeness** — all privileged access was through CyberArk

### API Access
- `GET /api/LiveSessions` — currently active sessions
- `GET /api/Recordings` — historical session recordings (filterable by date, user, target)

### Power BI Fact Table
Sessions are a **fact table** in your Power BI data model. Each session record can be enriched by joining to:
- **Users** dimension (via `User`)
- **Accounts** dimension (via account properties)
- **Safes** dimension (via `AccountSafeName`)
- **Platforms** dimension (via `AccountPlatformID`)
- **Date/Time** dimension (via `Start` timestamp)
