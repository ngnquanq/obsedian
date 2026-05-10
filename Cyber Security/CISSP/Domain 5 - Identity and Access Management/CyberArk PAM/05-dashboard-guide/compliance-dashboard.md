# Compliance Dashboard

## Purpose

This dashboard provides evidence for auditors and compliance teams. It answers:
- Are we meeting our password rotation policies?
- Are all privileged sessions recorded?
- Who has access to what? (Entitlements)
- Are there gaps in our PAM coverage?

This is the dashboard that gets shown during **SOX audits, PCI-DSS assessments, and ISO 27001 reviews**.

## Recommended Layout

```
┌─────────────────────────────────────────────────────────────┐
│  COMPLIANCE DASHBOARD                                       │
├─────────────┬──────────────┬──────────────┬────────────────┤
│ Rotation    │ Session      │ Dual Control │ PAM            │
│ Policy      │ Recording    │ Adoption     │ Coverage       │
│ Compliance  │ Compliance   │              │                │
│   92.4%     │   98.1%      │   45.0%      │   83.5%       │
│ ● Yellow    │ ● Green      │ ● Yellow     │ ● Green       │
├─────────────┴──────────────┴──────────────┴────────────────┤
│                                                             │
│  ROTATION POLICY COMPLIANCE BY PLATFORM                     │
│  ┌──────────────────────────────────────────┐              │
│  │ WinDomain      ████████████████  95%     │              │
│  │ UnixSSH        ███████████████   93%     │              │
│  │ Oracle         ████████████      88%     │              │
│  │ MSSQL          ██████████████    91%     │              │
│  │ CiscoIOS       █████████         78%  ⚠ │              │
│  │ AWS Keys       ████████████████  96%     │              │
│  └──────────────────────────────────────────┘              │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  COMPLIANCE TREND (LAST 12 MONTHS)                          │
│  ┌──────────────────────────────────────────┐              │
│  │ 100%──── Session Recording                │              │
│  │  95%   ── Rotation Compliance             │              │
│  │  90% ──── ──── ──── ──── ────             │              │
│  │  85%                                      │              │
│  │  80%──── PAM Coverage                     │              │
│  │  75%                                      │              │
│  │      J  F  M  A  M  J  J  A  S  O  N  D │              │
│  └──────────────────────────────────────────┘              │
│                                                             │
├────────────────────────────┬────────────────────────────────┤
│                            │                                │
│  NON-COMPLIANT ACCOUNTS    │  ENTITLEMENT SUMMARY           │
│  (Overdue Rotation)        │                                │
│  ┌────────────────────┐    │  Total Users:          142     │
│  │ Account  │Age│Plat. │    │  Users w/ Retrieve:     38    │
│  │──────────│───│──────│    │  Users w/ Connect Only: 89    │
│  │ admin@x  │120│WinDom│    │  Dormant Users (90d):   12    │
│  │ root@y   │105│Unix  │    │  Safes w/ >10 members:  15    │
│  │ sys@z    │ 98│Oracle│    │  Safes w/ 0 members:     3    │
│  └────────────────────┘    │                                │
│                            │                                │
└────────────────────────────┴────────────────────────────────┘
```

## KPI Definitions

### Rotation Policy Compliance
**"What % of accounts have passwords rotated within the policy window?"**

```
Compliant accounts = accounts where (now - lastModifiedTime) ≤ RequirePasswordChangeEveryXDays
Compliance % = compliant accounts / total managed accounts × 100
```

Notes:
- The policy threshold varies by platform (e.g., 30 days for servers, 90 days for databases)
- If platform-specific thresholds aren't available via API, use a default (e.g., 90 days)
- Exclude CPM-disabled accounts from the denominator (or show them separately)

### Session Recording Compliance
**"What % of accounts require session recording?"**

```
Recording-enabled accounts = accounts on platforms where RecordSession = true
Compliance % = recording-enabled / total managed × 100
```

Alternative: measure actual sessions that were recorded vs total sessions.

### Dual Control Adoption
**"What % of safes/accounts require approval before access?"**

```
Dual-control safes = safes where RequireDualControlPasswordAccessApproval = true
Adoption % = dual-control safes / total safes × 100
```

### PAM Coverage
**"What % of known privileged accounts are managed by CyberArk?"**

```
Coverage % = managed accounts / (managed + discovered unmanaged) × 100
```

This requires account discovery data. If discovery is not configured, this metric may not be available.

## Compliance by Platform

Break down rotation compliance by platform to identify which types of accounts are least compliant. Common findings:
- Network devices (Cisco, Juniper) often have lower compliance due to connectivity issues
- Database accounts may lag if DBAs resist rotation
- Cloud accounts may have different rotation challenges

## Compliance Trend

Track compliance metrics over time (monthly snapshots):
- Shows improvement trajectory
- Proves to auditors that compliance is trending up
- Identifies if changes (new onboarding, infrastructure changes) impacted compliance

## Non-Compliant Accounts Table

Detailed list of accounts that violate policy:
- Account name, safe, platform
- Password age (how overdue)
- Reason (CPM failure, CPM disabled, never rotated)
- Sortable by severity (most overdue first)

This table is the **action list** for the operations team.

## Entitlement Summary

Answers auditor questions about **who has access to what**:

| Metric | What It Shows |
|--------|---------------|
| Total vault users | How many people can access CyberArk |
| Users with Retrieve permission | Who can see/copy passwords (higher risk) |
| Users with Connect-only | Who can use accounts only through PSM (lower risk) |
| Dormant users | Users who haven't logged in recently (should be reviewed) |
| Safes with many members | Potential over-sharing |
| Safes with no members | Possibly orphaned safes |

Data sources:
- `GET /api/Users` for user counts
- `GET /api/Safes/{name}/Members` for safe entitlements

## Audit Evidence Exports

For formal audits, you may need to export dashboard data as evidence:
- Power BI supports exporting to PDF, PowerPoint, or Excel
- Schedule automated report delivery via Power BI Service subscriptions
- Consider creating a dedicated "Audit Report" page that exports cleanly

## Regulatory Mapping

| Dashboard Element | SOX | PCI-DSS | HIPAA | ISO 27001 |
|------------------|-----|---------|-------|-----------|
| Rotation compliance | ✓ | Req 2, 8 | ✓ | A.9 |
| Session recording | ✓ | Req 10 | ✓ | A.12 |
| Access entitlements | ✓ | Req 7 | ✓ | A.9 |
| Dual control | ✓ | Req 7 | ✓ | A.9 |
| PAM coverage | ✓ | Req 2 | ✓ | A.9 |
| Dormant user review | ✓ | Req 8 | ✓ | A.9 |

## Refresh Interval

Recommended: **every 4-24 hours**

Compliance data doesn't change frequently. Daily refresh is sufficient for most compliance reporting needs. For audit preparation periods, increase to every 4 hours.
