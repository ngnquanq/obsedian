# What is CyberArk?

## Overview

CyberArk is the market-leading Privileged Access Management (PAM) vendor. It has consistently been placed in the Leaders quadrant of the Gartner Magic Quadrant for PAM. CyberArk provides a suite of products that vault credentials, rotate passwords, proxy and record privileged sessions, and detect threats.

## Deployment Models

CyberArk comes in two main editions:

| Edition | Description | Our Environment |
|---------|-------------|-----------------|
| **Self-Hosted** | Installed on your own servers (on-prem or in your cloud VMs). Full control over infrastructure, configuration, and upgrades. | **This is what we use.** |
| **Privilege Cloud** | SaaS offering hosted by CyberArk. Managed infrastructure, automatic updates. Accessed via `*.privilegecloud.cyberark.cloud`. | Not our deployment. |

Since we use **Self-Hosted**, all components run on our infrastructure, and we access PVWA at `https://<our-pvwa-server>/PasswordVault/`.

## Core Product: CyberArk PAM (Self-Hosted)

The Self-Hosted PAM solution consists of several components that work together:

| Component | Abbreviation | Role |
|-----------|-------------|------|
| Digital Vault | Vault / EPV | Encrypted storage for all credentials |
| Password Vault Web Access | PVWA | Web UI + REST API gateway |
| Central Policy Manager | CPM | Automatic password rotation |
| Privileged Session Manager | PSM | Session proxy and recording |
| PSM for SSH | PSMP | SSH session proxy (Linux/Unix) |
| Privileged Threat Analytics | PTA | Behavioral analytics and threat detection |
| Application Access Manager | AAM/CCP | Credential retrieval for applications |

Each component is detailed in the [02 - Architecture](../02-architecture/) section.

## How the Components Work Together

```
                    ┌─────────────┐
                    │   End User  │
                    └──────┬──────┘
                           │ authenticates via
                           ▼
                    ┌─────────────┐        ┌─────────────┐
                    │    PVWA     │◄──────►│    PTA      │
                    │  (Web UI +  │        │  (Threat    │
                    │   REST API) │        │  Analytics) │
                    └──────┬──────┘        └─────────────┘
                           │
              ┌────────────┼────────────┐
              ▼            ▼            ▼
       ┌─────────┐  ┌──────────┐  ┌──────────┐
       │  Vault  │  │   CPM    │  │   PSM    │
       │(Storage)│  │(Rotation)│  │(Sessions)│
       └─────────┘  └──────────┘  └──────────┘
              ▲            │            │
              │            ▼            ▼
              │     Target Servers   Target Servers
              │     (change pwd)    (proxy session)
              │
       ┌──────────┐
       │ AAM/CCP  │◄── Applications retrieve
       │          │    credentials from Vault
       └──────────┘
```

## Other CyberArk Products (Not Core PAM)

These exist in the broader CyberArk portfolio but are separate products:

- **CyberArk Identity** — Workforce identity management (SSO, MFA). May be used as an authentication source for PVWA.
- **Conjur** — Secrets management for DevOps, containers, and CI/CD pipelines. Open-source and Enterprise editions.
- **Endpoint Privilege Manager (EPM)** — Least privilege enforcement on workstations and servers (application control, privilege elevation).
- **Secrets Hub** — Syncs secrets from CyberArk Vault to cloud-native secret stores (AWS Secrets Manager, Azure Key Vault).
- **Secure Web Sessions** — Session isolation for web applications.

## Licensing

CyberArk licensing is typically based on:
- Number of **managed accounts** (privileged credentials stored in the Vault)
- **Modules** licensed (PSM, PTA, AAM are often separate add-ons)
- **User count** for PVWA access

Licensing matters for dashboards because it determines which components are deployed and therefore which data sources are available. For example, if PTA is not licensed, threat analytics data won't exist.

## Version History (Key Milestones)

| Version | Notable Additions |
|---------|-------------------|
| v9.x | Legacy — SOAP-based web services |
| v10.x | REST API introduced alongside PVWA redesign |
| v11.x | Enhanced REST API, improved session management |
| v12.x | Expanded REST API coverage, Privilege Cloud parity improvements |
| v13.x | Additional API endpoints, improved PTA integration |
| v14.x | Modern UI updates, enhanced API filtering and pagination |

The REST API evolves with each version — newer versions expose more data for dashboard consumption. Check your installed version via PVWA > System Configuration > General.
