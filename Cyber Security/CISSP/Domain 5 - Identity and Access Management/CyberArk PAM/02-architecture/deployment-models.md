# Deployment Models

## Overview

CyberArk PAM is available in two primary deployment models. **We use Self-Hosted**, but understanding both helps when reading CyberArk documentation (which often covers both).

## Self-Hosted (Our Deployment)

All CyberArk components run on **infrastructure you own and manage** — either on-premises data centers or customer-managed cloud VMs (AWS EC2, Azure VMs, etc.).

### Characteristics

| Aspect | Detail |
|--------|--------|
| **Infrastructure** | Your servers (physical or virtual) |
| **Maintenance** | Your team handles upgrades, patching, backups |
| **Network** | Components on your internal network, behind your firewalls |
| **PVWA URL** | `https://<your-pvwa-server>/PasswordVault/` |
| **API Base** | `https://<your-pvwa-server>/PasswordVault/api/` |
| **Version Control** | You choose when to upgrade (can lag behind latest) |
| **Customization** | Full control over Vault configuration, platform customization, network rules |

### Typical Server Layout

| Server | Component(s) | OS |
|--------|-------------|-----|
| Server 1 | Digital Vault (Primary) | Windows Server (hardened) |
| Server 2 | DR Vault | Windows Server (hardened) |
| Server 3-4 | PVWA (load balanced) | Windows Server + IIS |
| Server 5-6 | CPM | Windows Server |
| Server 7-8 | PSM (load balanced) | Windows Server |
| Server 9 | PSMP | Linux (RHEL/CentOS) |
| Server 10 | PTA | Linux (CentOS/RHEL) |
| Server 11 | CCP (if licensed) | Windows Server + IIS |

Smaller deployments may combine components on fewer servers.

### Dashboard Implications for Self-Hosted

- **Full API access** — all REST API endpoints are available
- **Direct network access** — Power BI can reach PVWA directly (if network rules allow)
- **Version-dependent** — API features depend on your installed CyberArk version
- **Custom certificates** — you may need to handle self-signed or internal CA certificates when connecting from Power BI

## Privilege Cloud (SaaS) — For Reference Only

CyberArk manages the infrastructure. The Vault and PVWA run in CyberArk's cloud.

| Aspect | Detail |
|--------|--------|
| **Infrastructure** | CyberArk-managed cloud |
| **PVWA URL** | `https://<tenant>.privilegecloud.cyberark.cloud/` |
| **Maintenance** | CyberArk handles upgrades automatically |
| **Connector** | A "Privilege Cloud Connector" is installed on-prem to reach target systems |

This is **not our deployment**, but you may encounter Privilege Cloud references in CyberArk documentation.

## Hybrid Deployments

Some organizations run a hybrid model:
- Vault and PVWA in Privilege Cloud (SaaS)
- PSM and CPM on-premises (as "connectors") to reach internal targets
- PTA on-premises for network monitoring

This is not relevant to our setup but is increasingly common.
