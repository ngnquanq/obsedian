# Key Metrics and KPIs

This is the master reference of all metrics you might include in CyberArk dashboards. Organized by category, each metric includes what it measures, how to calculate it, and where the data comes from.

---

## Account Inventory Metrics

| Metric | Calculation | Data Source |
|--------|------------|-------------|
| **Total Managed Accounts** | Count of all accounts (excluding system safes) | `GET /api/Accounts` |
| **Accounts by Platform** | Group by `platformId` | `GET /api/Accounts` |
| **Accounts by Safe** | Group by `safeName` | `GET /api/Accounts` |
| **Accounts by Secret Type** | Group by `secretType` (password, key, file) | `GET /api/Accounts` |
| **Accounts by System Type** | Group by platform's `SystemType` (Windows, Unix, Database, Network) | Accounts joined with Platforms |
| **New Accounts Onboarded** | Count where `createdTime` within period | `GET /api/Accounts` |
| **Accounts Pending Onboarding** | Discovered but not yet managed | Discovery results / Pending safe |
| **Total Safes** | Count of safes (excluding system safes) | `GET /api/Safes` |
| **Accounts per Safe (avg)** | Total accounts / Total safes | Calculated |

---

## Password Management Metrics

| Metric | Calculation | Data Source |
|--------|------------|-------------|
| **Rotation Success Rate** | Accounts with `status=success` / Total managed | `GET /api/Accounts` |
| **Failed Rotations** | Count where `status=failure` | `GET /api/Accounts` |
| **CPM Disabled Accounts** | Count where `status=CPMDisabled` | `GET /api/Accounts` |
| **Password Age (per account)** | `now - lastModifiedTime` | `GET /api/Accounts` |
| **Average Password Age** | Avg of all password ages | Calculated |
| **Accounts Overdue for Rotation** | Count where password age > policy threshold | Calculated (compare with platform policy) |
| **Password Age Distribution** | Histogram: 0-30d, 30-60d, 60-90d, 90-180d, 180d+ | Calculated |
| **Verification Success Rate** | Accounts where last verify succeeded / Total | `GET /api/Accounts` |
| **Reconciliation Count** | Accounts reconciled in period | `GET /api/Accounts` (filter `lastReconciledTime`) |
| **Top Failure Reasons** | Group by `failReason` | `GET /api/Accounts` |
| **Accounts Never Rotated** | `lastModifiedTime` is null or equals `createdTime` | `GET /api/Accounts` |

---

## Session Metrics

| Metric | Calculation | Data Source |
|--------|------------|-------------|
| **Active Sessions (real-time)** | Count of live sessions | `GET /api/LiveSessions` |
| **Total Sessions (period)** | Count of completed sessions in date range | `GET /api/Recordings` |
| **Sessions per Day/Week** | Group by date | `GET /api/Recordings` |
| **Sessions by User** | Group by `User` (top N) | `GET /api/Recordings` |
| **Sessions by Target** | Group by `RemoteMachine` (top N) | `GET /api/Recordings` |
| **Sessions by Protocol** | Group by `Protocol` (RDP vs SSH vs other) | `GET /api/Recordings` |
| **Average Session Duration** | Avg of `Duration` | `GET /api/Recordings` |
| **Longest Sessions** | Top N by `Duration` | `GET /api/Recordings` |
| **Session Duration Distribution** | Histogram: <5m, 5-15m, 15-30m, 30-60m, 1-2h, 2h+ | Calculated |
| **Sessions by Time of Day** | Group by hour of `Start` | `GET /api/Recordings` |
| **Terminated Sessions** | Count where status = `Terminated` | `GET /api/Recordings` |

---

## Security Metrics (PTA)

| Metric | Calculation | Data Source |
|--------|------------|-------------|
| **Risk Score Distribution** | Histogram of session risk scores | `GET /api/Recordings` (RiskScore field) |
| **High-Risk Sessions** | Sessions with `RiskScore > 50` | `GET /api/Recordings` |
| **Average Risk Score** | Avg of all session risk scores | Calculated |
| **Suspected Credential Theft Events** | Count of PTA events of this type | PTA → SIEM → Power BI |
| **Unmanaged Privileged Accounts Detected** | Count of PTA detections | PTA → SIEM → Power BI |
| **Security Events by Severity** | Group PTA events by severity | PTA → SIEM → Power BI |
| **Security Event Trend** | Events over time | PTA → SIEM → Power BI |

---

## System Health Metrics

| Metric | Calculation | Data Source |
|--------|------------|-------------|
| **Component Status** | Up/Down for each component | `GET /api/ComponentMonitoring/Details` |
| **Vault Status** | Connected / Disconnected | Component Monitoring |
| **PVWA Status (per instance)** | Connected / Disconnected | Component Monitoring |
| **CPM Status** | Connected / Disconnected, tasks in queue | Component Monitoring |
| **PSM Status** | Connected / Disconnected, active sessions | Component Monitoring |
| **PTA Status** | Connected / Disconnected | Component Monitoring |
| **DR Replication Status** | Last successful replication time | Component Monitoring |
| **Component Versions** | Installed version per component | Component Monitoring |
| **CPM Queue Depth** | Number of pending CPM tasks | Component Monitoring |

---

## Compliance Metrics

| Metric | Calculation | Data Source |
|--------|------------|-------------|
| **Rotation Policy Compliance** | % of accounts where password age ≤ policy threshold | Calculated |
| **Session Recording Compliance** | % of accounts with session recording enabled | Platforms + Master Policy |
| **Dual Control Adoption** | % of safes with dual control enabled | Safe/Platform config |
| **Exclusive Access Adoption** | % of safes with exclusive access enabled | Safe/Platform config |
| **PAM Coverage** | Managed accounts / (Managed + Discovered unmanaged) | Accounts + Discovery data |
| **Dormant Users** | Users not logged in for X days | `GET /api/Users` |
| **Orphaned Accounts** | Accounts for targets that no longer exist | Manual identification |

---

## Recommended KPIs for Executive Dashboard

These are the top-level numbers an executive summary dashboard should show:

| KPI | Target | Status Logic |
|-----|--------|-------------|
| **Total Managed Accounts** | Growing (indicates onboarding progress) | Green |
| **Rotation Success Rate** | > 95% | Green > 95%, Yellow 85-95%, Red < 85% |
| **Password Age Compliance** | > 90% within policy | Green > 90%, Yellow 75-90%, Red < 75% |
| **Active Sessions** | Informational | — |
| **High-Risk Sessions (24h)** | < 5 | Green 0, Yellow 1-5, Red > 5 |
| **System Health** | All components up | Green = all up, Red = any down |
| **PAM Coverage** | > 80% | Green > 80%, Yellow 60-80%, Red < 60% |

---

## Refresh Recommendations

| Metric Category | Recommended Refresh Interval |
|----------------|------------------------------|
| Active sessions | Every 1-5 minutes |
| System health | Every 5 minutes |
| Account inventory | Every 15-60 minutes |
| Password management | Every 15-60 minutes |
| Session history | Every 1-4 hours |
| Compliance metrics | Every 4-24 hours |
| Security events (PTA) | Depends on SIEM pipeline (typically near real-time) |
