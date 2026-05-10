# PVWA (Password Vault Web Access)

## What It Is

PVWA is the **web interface and REST API gateway** for CyberArk. It is the primary touchpoint for both human users and integrations (like your Power BI dashboards).

- **For humans**: a web application for managing accounts, launching sessions, viewing audit logs, and running reports
- **For integrations**: a REST API that exposes account data, session data, system health, and more

**PVWA is your single point of integration for dashboards.**

## Access URLs

| Environment | URL Pattern |
|-------------|-------------|
| Self-Hosted | `https://<pvwa-server>/PasswordVault/` |
| REST API base | `https://<pvwa-server>/PasswordVault/api/` |
| Swagger docs | `https://<pvwa-server>/PasswordVault/swagger/` |
| Legacy v1 API | `https://<pvwa-server>/PasswordVault/WebServices/PIMServices.svc/` (avoid) |

## Architecture

- Runs on **IIS (Internet Information Services)** on Windows Server
- Connects to the Vault on port **1858**
- Serves HTTPS on port **443**
- Has its own database (SQL Server or built-in) for configuration, audit cache, and reports

### Multiple PVWA Instances
For high availability and load balancing, organizations deploy **multiple PVWA servers** behind a load balancer:

```
                    ┌──────────────┐
                    │ Load Balancer│
                    │  (F5 / NLB)  │
                    └──────┬───────┘
                           │
              ┌────────────┼────────────┐
              ▼            ▼            ▼
         ┌────────┐   ┌────────┐   ┌────────┐
         │ PVWA 1 │   │ PVWA 2 │   │ PVWA 3 │
         └────┬───┘   └────┬───┘   └────┬───┘
              │            │            │
              └────────────┼────────────┘
                           ▼
                    ┌──────────────┐
                    │    Vault     │
                    └──────────────┘
```

For dashboards, always point to the **load balancer URL**, not an individual PVWA server.

## PVWA Web Interface Sections

| Section | What It Shows |
|---------|---------------|
| **Accounts** | Search, view, and manage privileged accounts |
| **Monitoring** | View active sessions, PSM recordings, and session activities |
| **Policies** | Platform management, Master Policy configuration |
| **Administration** | User management, safe management, system configuration |
| **Reports** | Built-in reports: account inventory, activity, entitlements |
| **System Health** | Component status dashboard (Vault, CPM, PSM, PTA) |

## REST API Overview

The PVWA REST API is how your Power BI dashboards get data. Key endpoints:

| Endpoint | Data |
|----------|------|
| `GET /api/Accounts` | Privileged account inventory, CPM status |
| `GET /api/Safes` | Safe inventory and metadata |
| `GET /api/Users` | Vault user information |
| `GET /api/LiveSessions` | Currently active privileged sessions |
| `GET /api/Recordings` | Historical session recordings metadata |
| `GET /api/Platforms` | Platform configuration |
| `GET /api/ComponentMonitoring/Details` | System health for all components |
| `POST /api/auth/CyberArk/Logon` | Authentication (get session token) |

### Authentication Flow
```
1. POST /api/auth/CyberArk/Logon   →  Returns session token
2. Use token in Authorization header for all subsequent calls
3. Token expires after ~20 minutes (configurable)
4. POST /api/auth/Logoff when done
```

## Dashboard Relevance

PVWA is the **only component you need to connect to** for dashboards:

- All account, safe, session, and system health data flows through PVWA's REST API
- Use a dedicated **service account with Auditor permissions** for API access
- Point Power BI at the PVWA load balancer URL
- PVWA uptime directly affects dashboard data freshness

Key monitoring metrics for PVWA itself:
- PVWA up/down status (per instance)
- PVWA response time
- Number of concurrent sessions
- Connected users count

## Built-in Reports

PVWA includes several built-in reports (accessible via the Reports section in the UI):

- **Privileged Accounts Inventory** — all managed accounts
- **Activity Log** — audit trail of all actions
- **Entitlements Report** — who has access to what
- **Applications Inventory** — applications using AAM/CCP

These can serve as a reference when designing your Power BI dashboards, but the REST API gives you more flexibility.
