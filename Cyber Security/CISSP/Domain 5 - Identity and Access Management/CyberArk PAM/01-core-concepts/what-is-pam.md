# What is Privileged Access Management (PAM)?

## The Problem

Every organization has **privileged accounts** — accounts with elevated permissions that can access critical systems, modify configurations, read sensitive data, or control other accounts. Examples include:

- **Root / Administrator accounts** on servers
- **Domain Admin accounts** in Active Directory
- **Database admin accounts** (sa, sys, DBA roles)
- **Network device accounts** (enable/admin on routers, switches, firewalls)
- **Cloud admin accounts** (AWS root, Azure Global Admin)
- **Service accounts** used by applications to connect to databases, APIs, and other systems
- **SSH keys** used for automated server access

These accounts are the #1 target for attackers. If an attacker compromises a privileged account, they effectively own that system — and can move laterally to own more systems.

## What PAM Does

**Privileged Access Management (PAM)** is the set of practices and tools that:

1. **Discover** — Find all privileged accounts across the environment (many organizations don't even know how many they have)
2. **Vault** — Store privileged credentials in an encrypted, centralized vault instead of in scripts, spreadsheets, or people's heads
3. **Manage** — Automatically rotate (change) passwords on a schedule or after each use
4. **Control** — Enforce who can access which privileged accounts, when, and with what approval
5. **Monitor** — Record and audit all privileged sessions (who did what, when, on which system)
6. **Detect** — Identify suspicious privileged activity and potential threats

## Key Principles

### Least Privilege
Users and applications should only have the minimum permissions needed to do their job — nothing more. PAM enforces this by mediating access to powerful accounts rather than giving everyone the password.

### Zero Standing Privileges
Ideally, no one has permanent privileged access. Instead, access is granted just-in-time, for a limited duration, with approval — and revoked automatically after.

### Credential Isolation
Privileged credentials are never exposed directly to the end user. The user connects through a proxy (the session manager) which injects the credential on their behalf. The user never sees or knows the actual password.

### Accountability
Every privileged action is tied to an individual person, even when using shared accounts like "root" or "Administrator". PAM achieves this by requiring personal authentication before granting access to shared credentials.

## PAM vs Related Concepts

| Concept | Scope | Examples |
|---------|-------|---------|
| **IAM** (Identity and Access Management) | All identities and their regular access | Azure AD, Okta, Ping — who can log in and what apps they can reach |
| **PAM** (Privileged Access Management) | Specifically privileged/admin accounts | CyberArk, BeyondTrust, Delinea — securing root, admin, service accounts |
| **PIM** (Privileged Identity Management) | Subset of PAM focused on identity governance for privileged users | Azure AD PIM — time-limited admin role activation |
| **IAG** (Identity Access Governance) | Auditing and certifying who has access to what | SailPoint, Saviynt — access reviews and recertification |

**PAM is a specialized subset of IAM** that focuses exclusively on the most powerful and most dangerous accounts in your environment.

## The Privileged Access Lifecycle

```
 Discover ──► Onboard ──► Manage ──► Monitor ──► Respond
    │            │           │           │           │
 Find all    Bring into   Rotate     Record      Alert on
 privileged  the vault    passwords  sessions    suspicious
 accounts    & assign     on         & audit     activity
             policies     schedule   all access
```

Each stage of this lifecycle maps to specific CyberArk components and produces data that can be surfaced in dashboards.
