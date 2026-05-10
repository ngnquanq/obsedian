---
tags: [privilege-escalation, service-accounts, least-privilege, privilege-creep, pam, gmsa, lateral-movement, cissp, domain-5-iam, cissp/5.5-provisioning-lifecycle, cissp/5.1-access-control]
aliases: [Privilege Escalation, Service Account Management, Privilege Creep, Least Privilege, gMSA Group Managed Service Accounts]
---

# Privilege Escalation and Service Account Management

The [[IIQ-Concepts|JML lifecycle]] governs how human user accounts are provisioned and deprovisioned. But two related problems live largely outside the identity governance workflow: what happens when attackers gain a foothold and escalate their privileges, and how service accounts — the non-human accounts that run applications and scheduled tasks — accumulate excessive access over time. This note covers both, which together form the CISSP 5.5 gaps not addressed by the IIQ notes.

---

## Why Privilege Escalation Matters — The Problem

An attacker rarely lands in a system with the access they want. They land with whatever access the compromised account had — often a standard user account, a misconfigured service account, or an entry-level application credential.

**Privilege escalation is the process of gaining more access than you started with.** For attackers, it is almost always the second step after initial compromise. For defenders, understanding its mechanics determines what controls actually stop it.

> [!tip] Mental model
> An attacker gaining initial access is like a thief getting into a building's lobby. Privilege escalation is them finding the master key cabinet. The real damage happens after escalation, not at entry.

---

## Types of Privilege Escalation

### Horizontal Privilege Escalation

Gaining access to **other accounts at the same privilege level**, without gaining more permissions than those accounts already have.

**Mechanism:** Steal or reuse credentials, cookies, or tokens from peer accounts.

**Examples:**
- Compromise one standard user account → use its saved credentials to access another user's files
- Steal a session cookie → impersonate another user in a web application
- Pass-the-hash: capture an NTLM hash → use it to authenticate as that user elsewhere on the network

**Impact:** Access to *different* data, not *more privileged* data. Still dangerous if the lateral account holds sensitive data or can reach higher-privilege systems.

---

### Vertical Privilege Escalation

Gaining **significantly higher privileges** from a lower-privilege starting point — typically user → administrator or local → domain admin.

**Mechanisms:**

| Technique | Description |
|---|---|
| **Exploiting sudo misconfiguration** | `sudoers` allows `user ALL=(ALL) NOPASSWD: /bin/bash` → user runs a shell as root |
| **SUID/SGID binaries** | Executable set with SUID runs as the file owner (often root), not the caller |
| **Unquoted service path** | Windows service with unquoted path containing spaces; attacker places a binary in an earlier path segment |
| **DLL hijacking** | Application loads a DLL from a writable directory; attacker plants a malicious DLL |
| **Token impersonation** | Steal an access token from a higher-privileged process (Windows); `SeImpersonatePrivilege` exploits |
| **Kerberoasting** | Request a Service Ticket for an AD service account; crack the ticket offline to get the account's password |
| **DCSync attack** | Replicate AD credentials from a Domain Controller using `DS-Replication-Get-Changes` rights |

**Impact:** Attacker moves from user-level to administrative control — often game over for the environment.

---

### Lateral Movement

Lateral movement is the technique of using existing credentials and access to pivot to **other systems** across the network — often as a precursor to vertical escalation on a more valuable target.

```
Initial compromise: phished user jsmith on WORKSTATION01
    │
    ▼  Horizontal: steal jsmith's cached credentials
    │
    ▼  Lateral: use credentials to access FILESERVER01
    │            (jsmith has a mapped drive to \\fileserver01\projects)
    │
    ▼  Discover: fileserver01 is administered by svc-backup account
    │             svc-backup has Domain Admin rights (over-privileged!)
    │
    ▼  Lateral: connect to DOMAIN-CONTROLLER01 using svc-backup credentials
    │
    ▼  Vertical: svc-backup is Domain Admin → dump NTDS.dit → own entire domain
```

This is why over-privileged service accounts are catastrophic — a single credential compromise can pivot all the way to domain takeover.

---

## Privilege Creep — The Slow Accumulation

**Privilege creep** (also called **creeping privileges**) is the gradual accumulation of access rights that builds up as an employee changes roles over time.

```
Year 1: Alice joins as a Finance Analyst
         → AD groups: Finance-Read, Finance-Write, Expenses-Submit

Year 2: Alice moves to IT Finance Business Partner
         → AD groups added: IT-Finance-Reports, ERP-Admin-Lite
         → (old Finance groups never removed)

Year 3: Alice moves to Finance Director
         → AD groups added: FinDir-Approvals, Board-Reports
         → (previous groups still not removed)

Year 4: Alice has access appropriate for all three roles simultaneously
         — can approve payments AND submit expenses AND admin ERP AND read board reports
```

**Why it happens:** Provisioning (adding access for a new role) is driven by an explicit request. Deprovisioning (removing access from the old role) requires a separate process that is often not triggered.

### Controls for Privilege Creep

| Control | How It Works |
|---|---|
| **Mover workflow** | JML Mover event removes role-based entitlements for old role before assigning new ones |
| **Access reviews / certifications** | Periodic manager review of all access; items not re-approved are revoked |
| **Role model enforcement** | User is assigned a role (not individual groups); changing the role replaces the entitlement set |
| **Separation of Duties policies** | SOD rules flag accounts that hold incompatible role combinations |

---

## Excessive Privilege — Having More Than Needed

**Excessive privilege** is a point-in-time condition: the account currently holds more access than the user's job function requires.

Causes:
- Over-broad role definitions ("give them Full Control — easier than figuring out what they need")
- Group memberships granted for a one-time task and never removed
- Service accounts granted Domain Admin because it was easier than scoping permissions correctly

### Principle of Least Privilege

Every subject (user, process, service account) should have the **minimum access required to perform its function** — no more.

Practical application:
- File shares: Read + Execute instead of Full Control, unless the role requires writing
- Database accounts: SELECT only, not db_owner
- Service accounts: specific permissions on specific objects, not a domain-wide role
- Admin accounts: separate from daily-use accounts; used only for administrative tasks

---

## Service Accounts — The Overlooked Attack Surface

A **service account** is an identity used by an application, service, or scheduled task to interact with other resources — without a human logging in.

**Why service accounts are high-risk:**

| Problem | Detail |
|---|---|
| **Over-privileged** | Granted Domain Admin because "it was easier"; rarely re-evaluated |
| **Password never expires** | Long-lived credentials; if breached, remain valid indefinitely |
| **Interactive login allowed** | Attacker can use stolen credentials to log in as that account |
| **No MFA** | Most service accounts cannot enrol in MFA; password is the only factor |
| **Rarely reviewed** | Not human users; often excluded from access certifications |
| **Shared across environments** | Same credential used in dev, staging, and production |

---

## Service Account Management Best Practices

### For Standard Service Accounts

| Control | Implementation |
|---|---|
| Least privilege | Grant only the specific permissions the service needs on specific objects |
| Dedicated account per service | One service = one account; no sharing across applications |
| No interactive login | Set "Deny log on locally" and "Deny log on through Remote Desktop Services" |
| Strong, rotated passwords | Long random passwords stored in a vault (CyberArk, HashiCorp Vault); rotated regularly |
| Regular review | Include service accounts in access certifications, even though they have no human owner |
| Naming convention | `svc-<appname>-<environment>` (e.g., `svc-iiq-prod`) makes scope clear |

### Group Managed Service Accounts (gMSA) — The AD Solution

Windows offers **Group Managed Service Accounts (gMSA)** — a special AD account type that eliminates password management for service accounts entirely.

**How gMSA works:**
- AD automatically manages the password (128-character random)
- Password is rotated automatically on a schedule (default 30 days)
- The password is never visible to administrators — even the account's password hash is inaccessible
- Only pre-authorised computer accounts (specified at creation) can retrieve the gMSA password
- The service runs under the gMSA identity; AD provides the current password to the service host automatically

```powershell
# Create a gMSA in AD
New-ADServiceAccount -Name svc-iiq-prod `
    -DNSHostName iiq-prod.corp.example.com `
    -PrincipalsAllowedToRetrieveManagedPassword "IIQ-Servers-Group"

# Install on the server that will use it
Install-ADServiceAccount svc-iiq-prod

# Service configured to run as svc-iiq-prod$ — no password field
```

**Benefits:** No credential to rotate manually; no credential to steal from config files; audit trail of which hosts retrieved it.

---

## Mitigation Controls Summary

| Attack Type | Primary Controls |
|---|---|
| **Horizontal escalation** | Least privilege; session isolation; token binding; EDR |
| **Vertical escalation** | Least privilege on service accounts; patch management; disable unnecessary privileges |
| **Lateral movement** | Network segmentation; host-based firewall; credential guard; Kerberos armoring |
| **Kerberoasting** | Service account passwords long and complex; AES-only Kerberos; detect unusual SPN queries |
| **Privilege creep** | Mover workflow; access certifications; SOD policies |
| **Excessive service account privilege** | gMSA; PAM vaulting (CyberArk); account reviews |
| **Token theft** | Credential Guard on Windows; EDR; restrict SeImpersonatePrivilege |

### Privileged Access Workstations (PAW)

For human administrators, a **Privileged Access Workstation (PAW)** is a dedicated, hardened device used *only* for administrative tasks:
- No email, no web browsing, no general applications
- Strict network controls (only admin traffic allowed)
- Administrative tasks are performed from the PAW; regular work from a separate standard device

This ensures that even if the admin's daily-use laptop is compromised by malware, the attacker cannot use it to pivot to administrative systems.

---

## Related

- [[IAM-Overview]] — where privilege management fits in the IAM and PAM layers
- [[Access-Control-Models]] — least privilege and need-to-know as access control principles; MAC as the strictest enforcement
- [[Kerberos-Protocol]] — Kerberoasting exploits Kerberos service ticket encryption; understanding the protocol is prerequisite for the attack
- [[CyberArk-IIQ-Integration]] — CyberArk as the enterprise solution for privileged account vaulting, session recording, and credential rotation
- [[IIQ-Concepts]] — JML lifecycle and access certifications as the governance controls for privilege creep
- [[AD-LDAP-Fundamentals]] — gMSA as an AD object type; service account naming and OU placement conventions
