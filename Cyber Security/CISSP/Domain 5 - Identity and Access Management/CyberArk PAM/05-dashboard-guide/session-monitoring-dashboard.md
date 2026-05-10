# Session Monitoring Dashboard

## Purpose

This dashboard monitors privileged session activity. It answers:
- Who is connected to what right now?
- How many privileged sessions happen daily?
- Are there any high-risk sessions?
- What are the usage patterns?

## Recommended Layout

```
┌─────────────────────────────────────────────────────────────┐
│  SESSION MONITORING DASHBOARD                               │
├─────────────┬──────────────┬──────────────┬────────────────┤
│ Active      │ Sessions     │ High-Risk    │ Avg Session    │
│ Sessions    │ Today        │ Sessions     │ Duration       │
│   (Live)    │              │ (24h)        │                │
│     12      │    87        │      2       │   23 min       │
├─────────────┴──────────────┴──────────────┴────────────────┤
│                                                             │
│  ACTIVE SESSIONS (REAL-TIME TABLE)                          │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ User       │ Target       │ Protocol│ Duration│ Risk │  │
│  │────────────│──────────────│─────────│─────────│──────│  │
│  │ john.doe   │ server01     │ RDP     │ 0:45:12 │  15  │  │
│  │ jane.smith │ linux05      │ SSH     │ 0:12:33 │  5   │  │
│  │ bob.admin  │ oradb01      │ SSH     │ 1:22:05 │  72  │  │ ⚠️
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
├────────────────────────────┬────────────────────────────────┤
│                            │                                │
│  SESSIONS BY PROTOCOL      │  TOP USERS (LAST 7 DAYS)      │
│  ┌────────────────────┐    │  ┌────────────────────────┐   │
│  │  ████████ RDP  65% │    │  │ john.doe    ██████  42 │   │
│  │  ██████   SSH  30% │    │  │ jane.smith  █████   38 │   │
│  │  █        Web   5% │    │  │ bob.admin   ████    31 │   │
│  └────────────────────┘    │  │ alice.ops   ███     22 │   │
│                            │  └────────────────────────┘   │
├────────────────────────────┴────────────────────────────────┤
│                                                             │
│  SESSION TREND (LAST 30 DAYS)                               │
│  ┌──────────────────────────────────────────┐              │
│  │ 100 ┤                   █                │              │
│  │  80 ┤    █    █   █  █  █  █  █         │              │
│  │  60 ┤ █  █  █ █ █ █  █  █  █  █  █  █  │              │
│  │  40 ┤ █  █  █ █ █ █  █  █  █  █  █  █  │              │
│  │  20 ┤                                    │              │
│  │   0 ┤────────────────────────────────    │              │
│  │      Mon      Mon      Mon      Mon      │              │
│  └──────────────────────────────────────────┘              │
│                                                             │
├────────────────────────────┬────────────────────────────────┤
│                            │                                │
│  USAGE HEATMAP             │  TOP TARGETS (LAST 7 DAYS)     │
│  (Sessions by hour/day)    │  ┌────────────────────────┐   │
│  ┌────────────────────┐    │  │ server01    ██████  55 │   │
│  │    M T W T F S S   │    │  │ oradb01     █████   42 │   │
│  │ 00 ░ ░ ░ ░ ░ ░ ░   │    │  │ linux05     ████    38 │   │
│  │ 06 ░ ░ ░ ░ ░ ░ ░   │    │  │ dc01.corp   ███     27 │   │
│  │ 09 █ █ █ █ █ ░ ░   │    │  │ switch-core ██      15 │   │
│  │ 12 █ █ █ █ █ ░ ░   │    │  └────────────────────────┘   │
│  │ 15 █ █ █ █ █ ░ ░   │    │                                │
│  │ 18 ░ █ ░ █ ░ ░ ░   │    │  RISK SCORE DISTRIBUTION      │
│  │ 21 ░ ░ ░ ░ ░ ░ ░   │    │  ┌────────────────────────┐   │
│  └────────────────────┘    │  │ ████████████  0-25  78% │   │
│  ░=low █=high              │  │ ████          26-50 15% │   │
│                            │  │ █             51-75  5% │   │
│                            │  │ ░             76-100 2% │   │
│                            │  └────────────────────────┘   │
└────────────────────────────┴────────────────────────────────┘
```

## Widgets Explained

### 1. KPI Cards (Top Row)

| Card | Source | Notes |
|------|--------|-------|
| **Active Sessions** | `GET /api/LiveSessions` count | Real-time; auto-refresh |
| **Sessions Today** | `GET /api/Recordings` filtered by today | Completed sessions |
| **High-Risk Sessions (24h)** | Recordings where `RiskScore > 50` in last 24h | Alert indicator |
| **Avg Session Duration** | Average of `Duration` field | For the selected time period |

### 2. Active Sessions Table
Real-time table of all currently active sessions.

Key columns:
- **User** — who is connected
- **Target** — what they're connected to
- **Protocol** — RDP, SSH, etc.
- **Duration** — how long they've been connected (live counter)
- **Risk Score** — PTA risk score (highlight if > 50)

Color coding:
- Risk ≤ 25: Normal
- Risk 26-50: Yellow
- Risk > 50: Red with warning icon

### 3. Sessions by Protocol
Pie or donut chart showing the mix of connection types. Helps understand the environment:
- Heavy RDP = Windows-centric environment
- Heavy SSH = Linux/Unix-centric
- Web sessions = cloud console or application access

### 4. Top Users
Bar chart of users with the most sessions in the selected period. Useful for:
- Identifying power users
- Spotting unusual activity (new user suddenly very active)
- Capacity planning

### 5. Session Trend
Bar or line chart of daily session counts over time. Shows:
- Normal vs abnormal days
- Growth trends
- Impact of changes (new team onboarded, new systems added)

### 6. Usage Heatmap
Matrix showing session density by hour of day and day of week. Reveals:
- Peak usage hours (for capacity planning)
- Off-hours activity (potential security concern)
- Weekend usage patterns

### 7. Top Targets
Most frequently accessed target systems. Helps identify:
- Critical systems (most accessed)
- Potential single points of failure
- Systems that may need additional protection

### 8. Risk Score Distribution
Histogram of PTA risk scores across all sessions. Healthy distribution:
- Majority in 0-25 (normal)
- Some in 26-50 (worth occasional review)
- Very few in 51+ (should be investigated)

If risk scores are uniformly 0, PTA may not be deployed.

## Filters

- **Date Range** — for historical views
- **User** — filter to specific users
- **Target System** — filter to specific targets
- **Protocol** — RDP, SSH, Web, etc.
- **Risk Score Range** — focus on high-risk sessions
- **Safe** — filter by account safe (department/environment)

## Data Sources

| Widget | API Endpoint | Refresh |
|--------|-------------|---------|
| Active sessions | `GET /api/LiveSessions` | Every 1-2 minutes |
| Historical metrics | `GET /api/Recordings` | Every 15-60 minutes |
| Risk scores | Embedded in session data | Same as above |

## Refresh Interval

- **Active sessions table**: Every 1-2 minutes (near real-time)
- **Historical charts**: Every 15-60 minutes
- **KPI cards**: Match their fastest data source
