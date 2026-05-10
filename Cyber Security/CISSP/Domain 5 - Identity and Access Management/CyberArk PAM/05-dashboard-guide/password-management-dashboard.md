# Password Management Dashboard

## Purpose

This dashboard monitors the health of CyberArk's automatic password rotation. It answers:
- Are passwords being rotated successfully?
- Which accounts are failing and why?
- How old are our passwords?
- Where are the gaps in password management?

## Recommended Layout

```
┌─────────────────────────────────────────────────────────────┐
│  PASSWORD MANAGEMENT DASHBOARD                              │
├─────────────┬──────────────┬──────────────┬────────────────┤
│ Rotation    │ Failed       │ CPM Disabled │ Avg Password   │
│ Success     │ Rotations    │ Accounts     │ Age            │
│   Rate      │              │              │                │
│   96.2%     │     47       │     23       │   28 days      │
│  ▲ 1.1%     │  ▼ 5 less    │  ── same     │  ▼ improved    │
├─────────────┴──────────────┴──────────────┴────────────────┤
│                                                             │
│  PASSWORD AGE DISTRIBUTION          ROTATION STATUS         │
│  ┌─────────────────────────┐       ┌──────────────────┐    │
│  │ █████████████ 0-30d     │       │ ████████ Success  │    │
│  │ ████████     30-60d     │       │ ██      Failure   │    │
│  │ ████         60-90d     │       │ █       Disabled  │    │
│  │ ██           90-180d    │       │ ░       InProcess │    │
│  │ █            180d+      │       └──────────────────┘    │
│  └─────────────────────────┘                                │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  TOP FAILURE REASONS                                        │
│  ┌──────────────────────────────────────────┐              │
│  │ CACPM001 - Cannot connect to target  ███████  22       │
│  │ CACPM004 - Auth failure on target    █████    15       │
│  │ CACPM009 - Account locked            ███       8       │
│  │ CACPM012 - Connection timeout        █         2       │
│  └──────────────────────────────────────────┘              │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ROTATION TREND (LAST 30 DAYS)                              │
│  ┌──────────────────────────────────────────┐              │
│  │  Success ──── Failure ----               │              │
│  │  ───────────────────────────── 98%       │              │
│  │  ──────────────────────── 95%            │              │
│  │  ─── ──────────────── 93%                │              │
│  │  ---- ---- ---- ---- ---- 5%            │              │
│  └──────────────────────────────────────────┘              │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  FAILED ACCOUNTS TABLE (Drilldown)                          │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ Account         │ Safe       │ Platform │ Error      │  │
│  │─────────────────│────────────│──────────│────────────│  │
│  │ admin@server05  │ IT-Win-Prod│ WinDomain│ CACPM001   │  │
│  │ root@linux12    │ IT-Lin-Prod│ UnixSSH  │ CACPM004   │  │
│  │ sa@sqldb03      │ DBA-SQL    │ MSSQL    │ CACPM009   │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Widgets Explained

### 1. KPI Cards (Top Row)

#### Rotation Success Rate
- **Calculation**: `(accounts with status=success) / (total managed accounts) × 100`
- **Target**: > 95%
- **Color**: Green > 95%, Yellow 85-95%, Red < 85%
- **Trend**: Compare to previous period

#### Failed Rotations
- **Calculation**: Count of accounts where `status = failure`
- **Drill-down**: Click to see the failed accounts table
- **Trend**: Fewer failures = improving

#### CPM Disabled Accounts
- **Calculation**: Count where `status = CPMDisabled`
- **Note**: Some may be intentionally disabled; track the reasons

#### Average Password Age
- **Calculation**: Average of `(now - lastModifiedTime)` across all accounts
- **Target**: Should be less than half the rotation policy period

### 2. Password Age Distribution (Histogram)
Buckets all accounts by their password age:
- **0-30 days**: Recently rotated (good)
- **30-60 days**: Within typical policy window
- **60-90 days**: Approaching common policy limits
- **90-180 days**: Likely overdue (yellow/orange)
- **180+ days**: Critical — password has not been changed in 6+ months (red)

### 3. Rotation Status (Pie/Donut Chart)
Shows the breakdown of all accounts by CPM status:
- **Success** (green): Healthy
- **Failure** (red): Needs attention
- **CPMDisabled** (yellow): Intentional or needs review
- **InProcess** (blue): Currently being rotated

### 4. Top Failure Reasons (Bar Chart)
Aggregates `failReason` across all failed accounts. Common reasons:
- `CACPM001` — Cannot connect to target (network issue)
- `CACPM004` — Authentication failure (password out of sync)
- `CACPM007` — Password doesn't meet complexity
- `CACPM009` — Account locked on target
- `CACPM012` — Connection timeout

This helps identify **systemic issues** (e.g., if 20 accounts fail with CACPM001, there may be a network or firewall problem).

### 5. Rotation Trend (Line Chart)
Shows rotation success rate over time (daily or weekly). Helps identify:
- Degradation trends (success rate declining)
- Impact of changes (new accounts onboarded, infrastructure changes)
- Seasonal patterns

### 6. Failed Accounts Table
Detailed drilldown table of all currently failing accounts:
- Account name, safe, platform, error code, error description
- Last attempt time
- Sortable and filterable

## Filters

This dashboard should support filtering by:
- **Safe** (or safe group/department)
- **Platform** (WinDomain, UnixSSH, etc.)
- **CPM Instance** (if multiple CPMs)
- **Date Range** (for trend charts)
- **Status** (Success, Failure, Disabled)

## Data Source

All data comes from `GET /api/Accounts`:
- Fetch all accounts (paginated)
- Extract `secretManagement` fields: `status`, `lastModifiedTime`, `lastVerifiedTime`, `failReason`
- Calculate password age and apply policy thresholds

## Refresh Interval

Recommended: **every 15-30 minutes**

Password rotation happens on a schedule (typically daily), so data doesn't change every second. 15-30 minute refresh provides near-real-time visibility without overloading the PVWA API.
