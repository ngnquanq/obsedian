# PTA (Privileged Threat Analytics)

## What It Is

PTA is CyberArk's **behavioral analytics and threat detection** engine. While other components focus on managing credentials and sessions, PTA focuses on detecting suspicious privileged activity.

PTA answers the question: **"Is something abnormal happening with privileged access?"**

## How PTA Works

PTA collects data from multiple sources and applies analytics to detect threats:

```
Data Sources                    PTA Engine               Output
─────────────────              ─────────────            ──────────────
Vault audit logs ──────►  ┌──────────────────┐  ──►  Security Events
Network traffic  ──────►  │  PTA Analytics   │  ──►  Risk Scores
PSM sessions     ──────►  │  (Behavioral     │  ──►  Alerts
Windows events   ──────►  │   analysis,      │  ──►  SIEM Integration
UNIX syslogs     ──────►  │   ML models)     │       (Syslog/CEF)
                          └──────────────────┘
```

PTA doesn't require agents on target systems — it passively analyzes network traffic and log data.

## What PTA Detects

### Security Event Types

| Event Type | Description | Severity |
|------------|-------------|----------|
| **SuspectedCredentialTheft** | A privileged credential may have been stolen and used outside CyberArk | Critical |
| **UnmanagedPrivilegedAccount** | A privileged account was detected that is not managed by CyberArk | High |
| **CredentialWasStolen** | Confirmed use of a CyberArk-managed credential outside of CyberArk | Critical |
| **AnomalousActivity** | A privileged session shows unusual behavior (unusual commands, unusual time, unusual source) | Medium-High |
| **InactiveAccount** | A privileged account has not been used for an extended period | Low |
| **HighRiskCommand** | A dangerous command was executed during a privileged session | High |
| **UnusualAccess** | Access from an unusual location, time, or pattern | Medium |

### Risk Scores

PTA assigns **risk scores (0-100)** to sessions and events:

| Score Range | Risk Level | Interpretation |
|-------------|------------|----------------|
| 0-25 | Low | Normal behavior |
| 26-50 | Medium | Slightly unusual, worth reviewing |
| 51-75 | High | Suspicious activity, investigate |
| 76-100 | Critical | Likely threat, immediate action needed |

Risk scores are based on multiple factors:
- Time of access (unusual hours)
- Source IP (new or unusual location)
- Target system sensitivity
- Commands executed
- Session duration patterns
- Deviation from the user's historical baseline

## PTA Architecture

- PTA runs as a dedicated server (or virtual appliance)
- Connects to the Vault on port 1858 for audit data
- Monitors network traffic (passive network sensor)
- Optionally receives Windows Event logs and UNIX syslogs

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Vault     │────►│    PTA      │────►│    SIEM     │
│ (audit logs)│     │ (analytics) │     │ (Splunk,    │
└─────────────┘     └──────┬──────┘     │  QRadar,    │
                           │            │  Sentinel)  │
┌─────────────┐            │            └─────────────┘
│  Network    │────────────┘                   │
│  Traffic    │            │                   ▼
└─────────────┘            │            ┌─────────────┐
                           │            │  Dashboard  │
                           └───────────►│ (Power BI)  │
                                        └─────────────┘
```

## SIEM Integration

PTA's primary output mechanism is **Syslog** in **CEF (Common Event Format)**:

- PTA sends security events to a SIEM (Splunk, QRadar, Azure Sentinel, ELK) via Syslog
- The SIEM stores, indexes, and correlates these events
- Dashboards can then query the SIEM for PTA data

This is important because **PTA has limited direct API access**. For dashboard data:
- **Basic PTA events** may appear in PVWA's security events
- **Full PTA data** typically flows through SIEM → Dashboard

## Dashboard Relevance

PTA provides the data for **security dashboards**:

- **Unmanaged privileged accounts detected** — accounts that should be onboarded to CyberArk
- **Suspected credential theft events** — critical security alerts
- **Risk score distribution** — across all sessions in a time period
- **High-risk sessions** — sessions with risk score > threshold
- **Security event timeline** — events over time, identifying spikes
- **Top risky users** — users with the most high-risk sessions
- **Anomalous access patterns** — access outside normal hours/locations

### Data Access for Dashboards

| Data | How to Get It |
|------|---------------|
| Session risk scores | `GET /api/LiveSessions` or `GET /api/Recordings` (RiskScore field) |
| PTA security events | SIEM (Syslog/CEF from PTA) → Power BI SIEM connector |
| Unmanaged accounts | PVWA security events or PTA → SIEM |

If PTA is not licensed or deployed, risk scores and security events will not be available, and the security dashboard will have limited data.
