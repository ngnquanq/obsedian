# CyberArk Architecture Overview

## High-Level Architecture

CyberArk Self-Hosted consists of several components that work together. The **Vault** is at the center — every other component connects to it.

```
┌──────────────────────────────────────────────────────────┐
│                     USER LAYER                           │
│                                                          │
│   End Users          Auditors          Applications      │
│      │                  │                   │            │
└──────┼──────────────────┼───────────────────┼────────────┘
       │                  │                   │
       ▼                  ▼                   ▼
┌──────────────────────────────────────────────────────────┐
│                   ACCESS LAYER                           │
│                                                          │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐           │
│  │   PVWA   │    │   PSM    │    │ AAM/CCP  │           │
│  │ Web UI + │    │ Session  │    │ App Cred  │           │
│  │ REST API │    │  Proxy   │    │ Provider  │           │
│  └────┬─────┘    └────┬─────┘    └────┬─────┘           │
│       │               │               │                  │
└───────┼───────────────┼───────────────┼──────────────────┘
        │               │               │
        ▼               ▼               ▼
┌──────────────────────────────────────────────────────────┐
│                   VAULT LAYER                            │
│                                                          │
│              ┌─────────────────┐                         │
│              │  DIGITAL VAULT  │                         │
│              │ (PrivateArk     │──────► DR Vault         │
│              │  Server)        │       (Replication)     │
│              └─────────────────┘                         │
│                                                          │
└──────────────────────────────────────────────────────────┘
        ▲               ▲
        │               │
┌───────┼───────────────┼──────────────────────────────────┐
│       │   MANAGEMENT & ANALYTICS LAYER                   │
│       │               │                                  │
│  ┌────┴─────┐    ┌────┴─────┐                            │
│  │   CPM    │    │   PTA    │                            │
│  │ Password │    │ Threat   │                            │
│  │ Rotation │    │ Analytics│                            │
│  └────┬─────┘    └──────────┘                            │
│       │                                                  │
│       ▼                                                  │
│  Target Systems                                          │
│  (Servers, DBs, Network Devices, Cloud)                  │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

## Component Summary

| Component | What It Does | Port | Dashboard Relevance |
|-----------|-------------|------|---------------------|
| **Vault** | Stores all credentials encrypted | 1858 | Core data source (via PVWA API) |
| **PVWA** | Web UI, REST API gateway | 443 | **Primary API endpoint for dashboards** |
| **CPM** | Rotates, verifies, reconciles passwords | N/A (connects to Vault on 1858) | Password management metrics |
| **PSM** | Proxies and records privileged sessions | 3389 (RDP) | Session metrics, recordings |
| **PSMP** | Proxies SSH sessions | 22 | SSH session metrics |
| **PTA** | Detects threats and anomalies | N/A (monitors traffic) | Security events, risk scores |
| **AAM/CCP** | Serves credentials to applications | 443 | Application access metrics |
| **DR Vault** | Vault disaster recovery replica | 1858 | Replication health metrics |

## Data Flow: Password Rotation

```
1. CPM checks its queue for accounts due for rotation
2. CPM retrieves the current password from the Vault
3. CPM connects to the target system
4. CPM verifies the current password works
5. CPM generates a new password per platform policy
6. CPM changes the password on the target system
7. CPM stores the new password in the Vault
8. CPM updates the account status (Success/Failure)
```

Dashboard impact: Steps 4-8 produce status data visible via the API.

## Data Flow: Privileged Session

```
1. User authenticates to PVWA
2. User selects an account and clicks "Connect"
3. PVWA instructs PSM to establish a session
4. PSM retrieves the credential from the Vault
5. PSM connects to the target on behalf of the user
6. User works through the PSM proxy (never touches the target directly)
7. PSM records everything (video + keystroke metadata)
8. User disconnects; recording is stored in the Vault
9. PTA analyzes session behavior and assigns a risk score
```

Dashboard impact: Steps 6-9 produce session and risk data.

## Data Flow: Dashboard Data Retrieval

```
Power BI  ──►  PVWA REST API  ──►  Vault
(your      (https://<pvwa>/      (encrypted
dashboard)  PasswordVault/api/)   storage)
```

**Important**: You never query the Vault directly. All dashboard data comes through the PVWA REST API. PVWA is your single point of integration.

## Network Architecture (Simplified)

```
┌─────────────┐         ┌─────────────┐         ┌─────────────┐
│  User Zone  │  HTTPS  │  PAM Zone   │  1858   │  Vault Zone │
│             │────────►│   PVWA      │────────►│   Vault     │
│  Browsers   │   443   │   PSM       │         │   DR Vault  │
│  Power BI   │         │   CPM       │         │             │
│  Apps       │         │   PTA       │         │             │
└─────────────┘         │   AAM/CCP   │         └─────────────┘
                        └──────┬──────┘
                               │
                               ▼
                        ┌─────────────┐
                        │ Target Zone │
                        │  Servers    │
                        │  Databases  │
                        │  Network    │
                        └─────────────┘
```

The Vault sits in the most restricted network zone. PVWA, CPM, and PSM are in a middle zone. Users and dashboard tools connect to PVWA in the PAM zone.

## Key Architectural Principles

1. **Vault is the single source of truth** — all credentials are stored in one place
2. **PVWA is the API gateway** — all external integrations (including dashboards) go through PVWA
3. **Session isolation** — users never connect directly to targets; PSM mediates all connections
4. **Defense in depth** — multiple layers of encryption, authentication, and network segmentation
5. **Horizontal scaling** — you can deploy multiple PVWA, CPM, and PSM instances for load and availability
