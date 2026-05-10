# System Health Dashboard

## Purpose

This dashboard monitors the operational status of all CyberArk components. It answers:
- Are all CyberArk components running?
- When did a component last connect?
- What versions are deployed?
- Are there capacity concerns?

This is the **operations team's primary monitoring view** — the first place to look when something seems wrong.

## Recommended Layout

```
┌─────────────────────────────────────────────────────────────┐
│  SYSTEM HEALTH DASHBOARD                                    │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  COMPONENT STATUS                                           │
│  ┌───────────────────────────────────────────────────────┐ │
│  │  ● Vault (Primary)    Connected    v14.0    ✓        │ │
│  │  ● Vault (DR)         Connected    v14.0    ✓        │ │
│  │  ● PVWA-01            Connected    v14.0    ✓        │ │
│  │  ● PVWA-02            Connected    v14.0    ✓        │ │
│  │  ● CPM-01             Connected    v14.0    ✓        │ │
│  │  ● CPM-02             Connected    v14.0    ✓        │ │
│  │  ● PSM-01             Connected    v14.0    ✓        │ │
│  │  ● PSM-02             Connected    v14.0    ✓        │ │
│  │  ● PSMP-01            Connected    v14.0    ✓        │ │
│  │  ● PTA                Connected    v14.0    ✓        │ │
│  │  ○ CCP-01             Disconnected v13.2    ✗        │ │ ⚠️
│  └───────────────────────────────────────────────────────┘ │
│                                                             │
├────────────────────────────┬────────────────────────────────┤
│                            │                                │
│  COMPONENT SUMMARY         │  CPM STATISTICS                │
│  ┌────────────────────┐    │  ┌────────────────────────┐   │
│  │ Total Components:12│    │  │ Tasks in Queue:    47  │   │
│  │ Connected:      11 │    │  │ Tasks Completed    │   │
│  │ Disconnected:    1 │    │  │   (24h):        1,205  │   │
│  │ Version Match:  11 │    │  │ Tasks Failed       │   │
│  │ Version Mismatch: 1│    │  │   (24h):           23  │   │
│  └────────────────────┘    │  │ Avg Task Time:  4.2s   │   │
│                            │  └────────────────────────┘   │
├────────────────────────────┤                                │
│                            │  PSM STATISTICS                │
│  DR REPLICATION            │  ┌────────────────────────┐   │
│  ┌────────────────────┐    │  │ Active Sessions:   12  │   │
│  │ Status: Syncing ✓  │    │  │ Max Capacity:     100  │   │
│  │ Last Sync:         │    │  │ Utilization:      12%  │   │
│  │   2 minutes ago    │    │  │ Sessions Today:    87  │   │
│  │ Lag: < 1 minute    │    │  └────────────────────────┘   │
│  └────────────────────┘    │                                │
│                            │                                │
├────────────────────────────┴────────────────────────────────┤
│                                                             │
│  HEALTH TIMELINE (LAST 7 DAYS)                              │
│  ┌──────────────────────────────────────────┐              │
│  │ Vault    ████████████████████████████████ │ 100% uptime │
│  │ PVWA-01  ████████████████████████████████ │ 100%        │
│  │ PVWA-02  ████████████████████████████████ │ 100%        │
│  │ CPM-01   ████████████████████████████████ │ 100%        │
│  │ PSM-01   █████████████████████░░█████████ │ 98.5%       │
│  │ CCP-01   ████████████████░░░░░░░░░░░░░░░ │ 55.2%       │
│  └──────────────────────────────────────────┘              │
│  █ = Connected   ░ = Disconnected                          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Data Source

The primary API endpoint for system health:

```
GET /api/ComponentMonitoring/Details
```

Returns an array of all components with:

| Field | Description |
|-------|-------------|
| `ComponentID` | Unique component identifier |
| `ComponentName` | Human-readable name |
| `Description` | Component description |
| `ConnectedComponentCount` | Number of connected instances |
| `ComponentTotalCount` | Total expected instances |
| `ComponentSpecificStatistics` | Component-type-specific data |
| `IsLoggedOn` | Whether the component is connected to the Vault |
| `LastLogonDate` | Last successful connection time |
| `ComponentVersion` | Installed version |

There is also a summary endpoint:
```
GET /api/ComponentMonitoring/Summary
```

## Widgets Explained

### 1. Component Status Table
The core of the health dashboard. Each row shows:
- **Status indicator**: Green circle = connected, Red circle = disconnected
- **Component name**: Vault, PVWA-01, CPM-01, PSM-01, etc.
- **Connection status**: Connected / Disconnected
- **Version**: Installed CyberArk version
- **Health check**: ✓ / ✗

This should be the first thing the operations team sees.

### 2. Component Summary
Roll-up counts:
- Total components
- Connected vs disconnected
- Version consistency (all same version = good, mixed versions = potential issue during upgrades)

### 3. CPM Statistics
CPM-specific metrics from `ComponentSpecificStatistics`:
- **Tasks in queue**: How many rotation/verification tasks are pending
- **Tasks completed (24h)**: Volume of CPM activity
- **Tasks failed (24h)**: Failed operations count
- **Average task time**: Performance indicator

High queue depth may indicate CPM is overloaded or stuck.

### 4. PSM Statistics
PSM-specific metrics:
- **Active sessions**: Current concurrent sessions
- **Max capacity**: Based on server resources (typically 50-100 per PSM)
- **Utilization %**: Active / Max capacity
- **Sessions today**: Volume indicator

High utilization may require adding PSM servers.

### 5. DR Replication Status
Critical disaster recovery metric:
- **Status**: Syncing / Not syncing
- **Last sync**: Timestamp of last successful replication
- **Lag**: Time between primary and DR Vault

Alert if replication lag exceeds 5 minutes or if sync has stopped.

### 6. Health Timeline
Visual representation of component uptime over the past 7 days:
- Each row = one component
- Colored blocks show connected (green) vs disconnected (red/gray) periods
- Shows uptime percentage
- Helps identify intermittent issues

## Alert Thresholds

| Condition | Severity | Action |
|-----------|----------|--------|
| Any component disconnected | Critical | Investigate immediately |
| DR replication lag > 5 min | High | Check network/Vault status |
| CPM queue > 500 tasks | Medium | Check CPM performance |
| PSM utilization > 80% | Medium | Plan capacity expansion |
| Version mismatch between components | Low | Plan upgrade alignment |
| Component disconnected > 30 min | Critical | Escalate to CyberArk support |

## Refresh Interval

Recommended: **every 2-5 minutes**

System health is the most time-sensitive dashboard. Components can go down at any time, and early detection minimizes impact.
