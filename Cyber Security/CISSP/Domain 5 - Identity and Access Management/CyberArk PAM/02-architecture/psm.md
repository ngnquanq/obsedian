# PSM (Privileged Session Manager)

## What It Is

The PSM is CyberArk's **session proxy and recording engine**. Instead of giving users the privileged password and letting them connect directly to target systems, PSM acts as a middleman:

1. The user connects to **PSM**
2. PSM retrieves the credential from the Vault
3. PSM connects to the target on behalf of the user
4. The user sees and interacts with the target session, but **never knows the actual password**
5. PSM records everything — video, keystrokes, commands

This provides **session isolation** (the user's workstation never directly touches the target) and **full audit recording**.

## Two PSM Variants

| Variant | Protocol | Runs On | Port |
|---------|----------|---------|------|
| **PSM** (PSM for Windows) | RDP (Remote Desktop) | Windows Server | 3389 |
| **PSMP** (PSM for SSH) | SSH, SFTP | Linux | 22 |

### PSM for Windows (RDP)
- User launches a connection from PVWA or native RDP client
- PSM server runs a Windows Server with the RemoteApp/RDP host role
- PSM logs in to the target as **PSMConnect** (a local account) and injects the privileged credential
- Session appears as a standard RDP session to the user

### PSMP (PSM for SSH Proxy)
- User connects via SSH to the PSMP server
- PSMP authenticates the user, then proxies the SSH connection to the target
- Supports SSH, SFTP, and SCP
- Connection string format: `ssh user@target@psmp-server`

## Connection Components

A **Connection Component** defines how PSM connects to a target. Each platform can have multiple connection components:

| Component | Description |
|-----------|-------------|
| PSM-RDP | Standard Remote Desktop session |
| PSM-SSH | SSH terminal session |
| PSM-WinSCP | File transfer via WinSCP |
| PSM-SQLPlus | Oracle SQL*Plus session |
| PSM-SSMS | SQL Server Management Studio |
| PSM-Chrome | Web browser session (for web consoles) |
| PSM-PuTTY | PuTTY SSH session |
| Custom | Organizations can create custom connection components |

## Session Lifecycle

```
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│  Start   │───►│  Active  │───►│   End    │───►│ Stored   │
│          │    │          │    │          │    │          │
│ User     │    │ Session  │    │ User     │    │ Recording│
│ connects │    │ recorded │    │ disconns │    │ in Vault │
│ via PVWA │    │ by PSM   │    │ or admin │    │          │
│          │    │          │    │ terminates│   │          │
└──────────┘    └──────────┘    └──────────┘    └──────────┘
                     │
                     ▼
                ┌──────────┐
                │   PTA    │
                │ Analyzes │
                │ behavior │
                │ Assigns  │
                │ risk score│
                └──────────┘
```

## Session Properties

These are the fields available for each session — relevant for dashboard design:

| Property | Description | Example |
|----------|-------------|---------|
| `SessionID` | Unique session identifier | `5a3f7b2c...` |
| `User` | The CyberArk user who initiated the session | `john.doe` |
| `FromIP` | IP address the user connected from | `10.1.2.50` |
| `RemoteMachine` | Target system | `server01.corp.com` |
| `Protocol` | Connection protocol | `RDP`, `SSH` |
| `Client` | Connection component used | `PSM-RDP` |
| `Start` | Session start timestamp | `2024-01-15T09:30:00Z` |
| `End` | Session end timestamp (null if active) | `2024-01-15T10:15:00Z` |
| `Duration` | Session duration in seconds | `2700` |
| `RiskScore` | PTA-assigned risk score (0-100) | `35` |
| `AccountUsername` | The privileged account used | `admin` |
| `ConnectionComponentID` | Connection component | `PSM-RDP` |

## Session Statuses

| Status | Meaning |
|--------|---------|
| **Active** | Session is currently in progress |
| **Completed** | User disconnected normally |
| **Terminated** | An admin terminated the session |

## Session Monitoring (Live)

Auditors and admins can:
- **View active sessions in real-time** through PVWA
- **Monitor** (watch live) — see what the user is doing in real time
- **Suspend** — temporarily pause a session
- **Terminate** — forcibly disconnect a session

These actions are available in the PVWA monitoring page and via the API.

## Session Recordings

- Recordings are stored as files in the Vault (in the `PSMRecordings` safe)
- Playback is through the PVWA web interface — not accessible via API download
- Recordings include video playback and searchable activity metadata (commands typed, windows opened)
- Retention is configurable per safe

## Dashboard Relevance

PSM data is essential for session monitoring and compliance dashboards:

- **Active session count** (real-time) — `GET /api/LiveSessions`
- **Sessions by user** — top users by session count
- **Sessions by target** — most accessed target systems
- **Sessions by protocol** — RDP vs SSH distribution
- **Session duration** — average, median, longest sessions
- **Risk score distribution** — histogram of PTA risk scores across sessions
- **Terminated sessions** — sessions forcibly ended by admins (security metric)
- **Session compliance** — % of accounts where sessions are recorded (required by policy)
- **Historical trends** — sessions over time, busiest hours/days

## Scaling

- Multiple PSM servers can be deployed behind a load balancer for scalability
- Each PSM server has a limit on concurrent sessions (depends on hardware)
- PSM server resource utilization (CPU, memory, disk) is a system health metric
