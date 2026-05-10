---
tags: [iam, access-control, cissp, domain-5-iam, cissp/5.1-access-control, fundamentals]
aliases: [Logical Access, Physical Access, Access Control Foundations]
---

# Physical vs Logical Access

CISSP Domain 5.1 ("Control physical and logical access to assets") splits access control into two complementary disciplines. Both must be enforced; neither is sufficient alone.

> [!tip] One-line definitions
> - **Physical access** — *Can the person reach the asset?* Controlled by walls, locks, badges, guards, cameras.
> - **Logical access** — *Once they reach a system, what can they do on it?* Controlled by accounts, credentials, group memberships, ACLs, encryption.

A locked server room with no logical controls means anyone with the door code becomes root. A hardened login screen on an unlocked workstation means an attacker just walks up and reads the screen. Defense-in-depth requires both.

---

## The Distinction in One Picture

```
                    ┌───────────────────────────────────────────┐
                    │              THE ASSET                     │
                    │   (Server, application, database,          │
                    │    file, cardholder data, IP)               │
                    └───────────────────────────────────────────┘
                                    ▲
                ┌───────────────────┴───────────────────┐
                │                                        │
        LOGICAL ACCESS                          PHYSICAL ACCESS
        (electronic gate)                       (architectural gate)
                │                                        │
    ┌───────────┴────────────┐              ┌───────────┴────────────┐
    │ Authentication          │              │ Perimeter (fences,     │
    │   passwords, MFA,       │              │   gates, mantraps)     │
    │   biometrics-as-input,  │              │ Building (locks,       │
    │   certificates          │              │   guards, badges)      │
    │ Authorization           │              │ Room (cipher locks,    │
    │   group membership,     │              │   cages, smartcards)   │
    │   RBAC, ABAC, ACLs      │              │ Rack (locked cabinets) │
    │ Accounting              │              │ Surveillance (CCTV,    │
    │   audit logs, SIEM      │              │   motion sensors)      │
    │ Network controls        │              │ Environmental (HVAC,   │
    │   firewalls, VPN,       │              │   fire suppression,    │
    │   network ACLs          │              │   power)               │
    │ Encryption              │              │ Destruction (shredders,│
    │   keys, tokens, TLS     │              │   degaussers)          │
    └────────────────────────┘              └────────────────────────┘
```

---

## Logical Access — The Anatomy

Logical access is what IAM tooling governs. It decomposes into three mechanisms (often called the **AAA model**, sometimes IAAA when identification is split out):

| Mechanism | Question Answered | Examples |
|---|---|---|
| **Identification** | *Who do you claim to be?* | Username, employee ID, account name |
| **Authentication** | *Prove it.* | Password, MFA token, smart card, biometric, certificate |
| **Authorization** | *What are you allowed to do?* | Group membership, RBAC role, ABAC policy, ACL entry, file permission |
| **Accounting / Audit** | *What did you actually do?* | SIEM logs, IIQ audit trail, application access logs |

> [!note] Biometrics are logical, not physical
> A fingerprint reader on a server-room door is **physical** access (it controls room entry). The same fingerprint reader on a laptop login screen is **logical** access (it controls software session entry). The mechanism is the same; the boundary it guards determines the category.

### Common logical access controls

- **Account-level**: account creation, account disable, password reset, lockout policy, session timeout
- **Authentication strength**: MFA enforcement, password complexity, certificate-based auth, FIDO2 keys
- **Authorization model**: see [[Access-Control-Models]] for DAC vs MAC vs RBAC vs ABAC (planned)
- **Network logical**: firewall rules, VPN gates, 802.1X port authentication, microsegmentation
- **Data logical**: file ACLs, database GRANTs, encryption keys, DRM, DLP rules
- **Cloud logical**: IAM policies (AWS IAM, Azure RBAC, GCP IAM), service principals, conditional access

---

## Physical Access — The Anatomy

Physical access controls are layered concentrically (defense-in-depth in the literal sense — depth in *physical space*):

| Layer | Examples |
|---|---|
| **Perimeter** | Fences, bollards, vehicle barriers, lighting, dogs |
| **Site / building** | Gates, mantraps, turnstiles, security guards, badge readers |
| **Floor / zone** | Cipher locks, badge readers with anti-passback, escort policies |
| **Room** | Server room cipher locks, biometric door, two-person rule |
| **Rack / cabinet** | Locking cages, locking rack doors |
| **Asset** | Locked drawers, cable locks, tamper-evident seals |
| **Surveillance** | CCTV, motion sensors, recording retention |
| **Environmental** | HVAC, fire suppression, water detection, UPS, generators |
| **Disposal** | Shredders, degaussers, certified destruction services |

Physical access is **out of scope for IAM tools** like IIQ, but IIQ may still record physical access events (badge swipes) if a physical access system (PACS) is connected as a target application — primarily for correlation in SIEMs and for certifications that include "physical access to data centre" as a reviewable entitlement.

---

## Shared Principles (Apply to Both)

These foundational principles govern *all* access decisions, physical or logical:

| Principle | Meaning | Logical Example | Physical Example |
|---|---|---|---|
| **Least privilege** | Grant the minimum access required | Read-only DB account for a reporting tool | Janitor's badge opens hallways, not server rooms |
| **Need-to-know** | Grant access only to information required for the job | Finance can read GL, not HR salaries | Only DC engineers can enter the data centre |
| **Separation of duties** | No single person can complete a high-risk action alone | Vendor creator ≠ payment approver | Two-person rule for vault entry |
| **Defense in depth** | Layered controls, no single point of failure | Network ACL + app login + file ACL + encryption | Perimeter + building + room + rack + asset |
| **Fail secure** | When a control fails, deny by default | Database denies query if auth service down | Maglocks lock on power loss (life-safety nuance applies) |
| **Accountability** | Every action is attributable to an individual | Shared accounts banned; audit logs immutable | Badge logs, CCTV, signed visitor logs |

> [!warning] Fail-secure has a life-safety exception
> Doors guarding *people* (offices, exit routes) generally **fail safe** (unlock on power loss) so people can escape fires. Doors guarding *assets* (vaults, server rooms with no people inside) **fail secure** (lock on power loss). CISSP exam reliably tests this distinction.

---

## How Logical Access Manifests in SailPoint IIQ

This is the part most relevant to the work happening in this vault. IIQ governs **logical** access only — it has nothing to say about who can enter the building. Within logical access, IIQ models a strict hierarchy:

```
Identity (spt_identity)
  │   "Who is the person?"
  │
  ├── Account (spt_link)                      "What login do they have on each system?"
  │     │
  │     ├── Entitlement (spt_identity_entitlement)
  │     │     "What raw access does that account hold?"
  │     │     e.g. AD group, SAP role, Unix group, DB privilege
  │     │
  │     └── (entitlements can be granted directly, no role required)
  │
  └── Role / Bundle (spt_bundle)              "Optional governance bundle of entitlements"
        │
        ├── Business Role (type='business')   "Accounts Payable Clerk"
        │     │
        │     └── requires → IT Role          "SAP AP Access"
        │           │
        │           └── contains → Entitlement Profile (spt_profile)
        │                 │
        │                 └── matches → Entitlements on Application
        │
        └── Detected vs Assigned              "Did someone grant the role, or did
                                               IIQ infer it from existing entitlements?"
```

### Mapping CISSP Domain 5 to IIQ objects

| CISSP 5.x Concept | IIQ Object | Database Table |
|---|---|---|
| Identity | Identity Cube | `spt_identity` |
| Account on a system | Link | `spt_link` |
| Authentication credential | (mostly external — IIQ governs *whether* an account exists, not the password) | n/a |
| Authorization (granular) | Entitlement | `spt_identity_entitlement` (assignment) + `spt_managed_attribute` (catalog) |
| Authorization (RBAC bundle) | Role / Bundle | `spt_bundle` |
| The system being accessed | Application | `spt_application` |
| Periodic review | Certification | `spt_certification_*` chain |
| Conflicting access | SOD policy violation | `spt_policy_violation` |
| Provisioning audit | Provisioning transaction | `spt_provisioning_transaction` |

### What "logical access" looks like for one user in IIQ

Take Jane Smith, an Accounts Payable clerk. Her **logical access** in IIQ is:

```
spt_identity        : 1 row   (Jane Smith)
spt_link            : 4 rows  (AD account, SAP account, Oracle DB account, Unix account)
spt_identity_entitlement
                    : 18 rows (4 AD groups + 6 SAP roles + 5 Oracle grants + 3 Unix groups)
spt_bundle (via bundles XML / spt_identity_bundles)
                    : 2 rows  (1 business role "AP Clerk" + 1 IT role "SAP AP Access")
```

Her *complete* logical access footprint is the union of those rows. The role assignments are a **summary** of her entitlements — useful for governance — but the entitlements are the *actual* access. If you revoke the role and the underlying entitlements remain, she still has the access. If you revoke the entitlements directly, the role becomes "assigned but not detected" until provisioning catches up.

> [!tip] Common analyst confusion clarified
> **"What logical access does Jane have?"** is best answered by `spt_identity_entitlement` joined to `spt_managed_attribute` and `spt_application`. Roles are a useful *grouping* for reports and certifications, but `spt_identity_bundles` alone will miss any entitlement granted directly without a role wrapper — a very common pattern. See [[IIQ-Concepts]] § *Role Detection vs Assignment* for the full nuance.

### Roles ↔ Applications: the relationship is indirect

A common mental shortcut is "roles belong to applications." In IIQ that's not quite right:

```
Role (spt_bundle, type='it')
  │
  └── has entitlement profile (spt_profile)
        │
        └── filter matches entitlements on Application X (spt_application)
```

A single IT role can match entitlements on multiple applications. A business role typically requires several IT roles, each potentially spanning multiple applications. So the question "which application does this role grant access to?" is really "which applications does this role's entitlement profile filter against?" — a one-to-many relationship, mediated by `spt_profile`.

### What IIQ does *not* govern

- **Physical access** (badge, door, vault) — unless a PACS is connected as an application, and even then IIQ only records and reviews; it doesn't open doors.
- **The authentication mechanism itself** — IIQ governs *whether you have an account*, but the password, MFA factor, and Kerberos ticket are managed by the directory and SSO/MFA tools.
- **In-application authorization decisions** — IIQ records that you have AD group `SAP_AP_Approver`, but the runtime decision "is this transaction approvable?" happens inside SAP using that group claim. IIQ governs the *grant*, not the *enforcement*.

---

## Quick Reference for the Exam

> [!example] CISSP test framing
> - Logical access ≈ AAA / IAAA model.
> - Physical access ≈ defense-in-depth in literal physical space.
> - Both share the same governing principles: least privilege, need-to-know, separation of duties.
> - Biometrics, smartcards, and tokens can serve either category — the *boundary they guard* determines which.
> - "Fail safe" (life-safety) ≠ "fail secure" (asset protection). Know the difference.

---

## Related

- [[IAM-Overview]] — the IAM stack (directory → auth → authz → governance → PAM)
- [[AD-LDAP-Fundamentals]] — directory layer foundations
- [[AD-Application-Integration]] — how apps consume logical access from AD (Kerberos, LDAP bind, SAML, PAM)
- [[AD-File-Shares-NAS-DFS]] — logical access on file shares (NTFS ACLs, share permissions)
- [[IIQ-Concepts]] — Identity Cube, accounts, entitlements, roles, certifications
- [[IIQ-Data-Flows]] — how logical access flows through IIQ (aggregation → correlation → provisioning)
- [[AD-Groups-in-IIQ-Governance]] — how AD group entitlements become governed logical access
- [[IIQ-Analyst-Playbook]] § *Point-in-time access reconstruction* — recipe for recovering historical logical access from snapshots, certification archives, or provisioning deltas
- [[Domain 5 - IAM]] — Domain 5 MOC
