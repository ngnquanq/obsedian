# CyberArk PAM Documentation

Internal knowledge base for understanding CyberArk Privileged Access Management (Self-Hosted). Designed for team members building dashboards, integrations, and reports against CyberArk data using Power BI.

## How to Use This Documentation

| You want to...                        | Start here                          |
|---------------------------------------|-------------------------------------|
| Understand PAM from scratch           | [01 - Core Concepts](01-core-concepts/) |
| Learn CyberArk's components           | [02 - Architecture](02-architecture/)   |
| Understand the data model             | [03 - Key Entities](03-key-entities/)   |
| Look up a term                        | [04 - Glossary](04-glossary/glossary.md)|
| Build a dashboard                     | [05 - Dashboard Guide](05-dashboard-guide/) |
| Find error codes or external links    | [06 - Reference](06-reference/)         |

## Table of Contents

### 01 - Core Concepts
- [What is PAM?](01-core-concepts/what-is-pam.md) - Privileged Access Management fundamentals
- [What is CyberArk?](01-core-concepts/what-is-cyberark.md) - Product suite overview (Self-Hosted)
- [Why PAM Matters](01-core-concepts/why-pam-matters.md) - Compliance and security drivers

### 02 - Architecture
- [Overview](02-architecture/overview.md) - High-level architecture and data flow
- [Digital Vault](02-architecture/digital-vault.md) - Encrypted credential storage
- [PVWA](02-architecture/pvwa.md) - Web interface and API gateway
- [CPM](02-architecture/cpm.md) - Password rotation engine
- [PSM](02-architecture/psm.md) - Session isolation and recording
- [PTA](02-architecture/pta.md) - Threat analytics
- [AAM / CCP](02-architecture/aam-ccp.md) - Application credential retrieval

### 03 - Key Entities
- [Safes](03-key-entities/safes.md) - Logical containers for accounts
- [Accounts](03-key-entities/accounts.md) - Privileged credentials (central entity)
- [Platforms](03-key-entities/platforms.md) - Management behavior definitions
- [Users and Groups](03-key-entities/users-and-groups.md) - Vault users and LDAP
- [Policies and Permissions](03-key-entities/policies-and-permissions.md) - Access control
- [Sessions](03-key-entities/sessions.md) - Privileged session objects

### 04 - Glossary
- [Glossary](04-glossary/glossary.md) - A-Z reference of all CyberArk terms

### 05 - Dashboard Guide
- [Key Metrics and KPIs](05-dashboard-guide/key-metrics-and-kpis.md) - Master metrics list
- [Password Management Dashboard](05-dashboard-guide/password-management-dashboard.md)
- [Session Monitoring Dashboard](05-dashboard-guide/session-monitoring-dashboard.md)
- [Compliance Dashboard](05-dashboard-guide/compliance-dashboard.md)
- [System Health Dashboard](05-dashboard-guide/system-health-dashboard.md)
- [Power BI Integration](05-dashboard-guide/power-bi-integration.md)

### 06 - Reference
- [Common Error Codes](06-reference/common-error-codes.md)
- [Further Reading](06-reference/further-reading.md)

## Environment

- **Deployment**: CyberArk Self-Hosted
- **Dashboard Tool**: Microsoft Power BI
- **PVWA Base URL**: `https://<your-pvwa-server>/PasswordVault/`
