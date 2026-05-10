# Digital Vault

## What It Is

The Digital Vault (also called "the Vault," "EPV Server," or "PrivateArk Server") is the heart of CyberArk. It is a purpose-built, hardened server that stores all privileged credentials in encrypted form.

Think of it as an ultra-secure database that only speaks its own proprietary protocol on port **1858**. No standard database tools can access it — only authorized CyberArk components.

## Key Characteristics

### Hardened OS
- Runs on a stripped-down Windows Server with most services disabled
- No internet access, no web browser, minimal attack surface
- Custom CyberArk firewall allows only port 1858 (Vault protocol) and required replication ports
- Physical or virtual — but always isolated in the most restricted network zone

### Encryption
- All data is encrypted at rest using CyberArk's proprietary encryption
- Server key + master key architecture — even CyberArk cannot access your data without your keys
- **Master Key (master.key)** — top-level encryption key, stored on the Vault server or HSM
- **Server Key** — generated during installation, protects the Vault's internal keys

### What the Vault Stores
- Passwords (the most common)
- SSH keys
- Certificates
- Files (any file can be stored as a Vault object)
- API keys, tokens, and other secrets
- Session recordings (from PSM)

### Storage Structure
```
Vault
├── System Safes (internal, do not modify)
│   ├── System
│   ├── VaultInternal
│   ├── PasswordManager
│   ├── PasswordManager_Pending
│   ├── PVWAConfig
│   ├── PVWAReports
│   ├── PVWATicketingSystem
│   ├── PSM
│   ├── PSMLiveSessions
│   ├── PSMRecordings
│   └── ...
├── User-Created Safes
│   ├── IT-Windows-Servers-Prod
│   │   ├── Operating System-WinDomain-admin01-server01.corp.com
│   │   ├── Operating System-WinDomain-admin02-server02.corp.com
│   │   └── ...
│   ├── IT-Linux-Servers-Prod
│   │   ├── Operating System-UnixSSH-root-linux01.corp.com
│   │   └── ...
│   ├── DBA-Oracle-Prod
│   │   ├── Database-Oracle-sys-oradb01.corp.com
│   │   └── ...
│   └── ...
```

## Disaster Recovery (DR) Vault

A secondary Vault server that receives continuous replication from the primary:

- **Replication**: All data changes are replicated in near-real-time
- **Failover**: If the primary Vault fails, the DR Vault can be promoted
- **Manual failover**: Requires administrative action (not automatic)
- **Dashboard metric**: Time since last successful replication is a key health indicator

## Dashboard Relevance

You **do not** query the Vault directly for dashboard data. Instead:
- Account data comes from **PVWA REST API** (which reads from the Vault)
- System health data (Vault status) comes from **PVWA's Component Monitoring API**
- Audit logs are stored in the Vault but accessed through **PVWA**

Key metrics related to the Vault:
- Vault up/down status
- DR replication lag
- Total objects stored
- Vault version

## Vault Administration

The Vault is administered through:
1. **PrivateArk Client** — thick Windows client for direct Vault management
2. **PVWA** — web interface for most day-to-day operations
3. **PACLI** — command-line interface for scripting and automation
4. **CAVaultManager** — utility for Vault service management (start, stop, backup)

For dashboard purposes, you'll interact exclusively through PVWA's REST API.
