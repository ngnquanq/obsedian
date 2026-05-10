---
tags: [access-control, mac, dac, rbac, abac, rule-based, risk-based, authorization, lattice, acl, cissp, domain-5-iam, cissp/5.1-access-control, cissp/5.4-authorization]
aliases: [Access Control Models, MAC DAC RBAC ABAC, Authorization Models, Mandatory Discretionary Access Control]
---

# Access Control Models — Who Decides Who Gets In?

Before you can govern access — via [[AD-LDAP-Fundamentals|AD groups]], [[AD-Application-Integration|application integration patterns]], or [[AD-Groups-in-IIQ-Governance|IIQ certifications]] — you need a mental model for *how* access control decisions are made. Every system that restricts access implements one of these models, often without the engineer realising it.

---

![[Access-Control-Models.excalidraw.md]]

---

## Why Access Control Models Exist

A file on a server needs a rule for who can read it. A network device needs a rule for who can log in. A database needs a rule for who can run `DELETE`. The question every access control system must answer is:

> **Who can access what — and who gets to decide?**

The answer differs dramatically depending on the model. Choosing the wrong one for a system's threat profile is a design flaw, not just a configuration error.

---

## The Six Main Models

### 1. Discretionary Access Control (DAC)

**Who decides:** The resource *owner*.

In DAC, every object (file, folder, record) has an owner. The owner decides who else can access it and at what level. This is implemented via **Access Control Lists (ACLs)** — a list attached to the object mapping subjects to permissions.

**Example:** Windows NTFS. When you create a file, you own it. You can grant Read access to your colleague directly. You can grant Write access to a group. You can revoke access whenever you choose.

**Strengths:**
- Flexible — owner can adapt permissions to business needs
- No central administrator needed for every change

**Weaknesses:**
- Hard to audit at scale — permissions are scattered across thousands of owners
- The **confused deputy problem**: if a subject with high privileges runs a process that a low-privilege user controls, the process runs with high privileges
- **Trojan horse risk**: a malicious program run by the owner inherits the owner's permissions

> [!note] DAC in practice
> Most enterprise file systems (NTFS, ext4 with POSIX ACLs) use DAC. The owner model makes DAC the most common model in the real world — but also the hardest to govern at enterprise scale, which is why tools like IIQ exist.

---

### 2. Mandatory Access Control (MAC)

**Who decides:** The *system*, based on policy — not the owner.

In MAC, every subject (user, process) and every object (file, record) is assigned a **security label**. The system compares labels and enforces access automatically. Owners cannot override the system's decision.

**Label components:**
- **Classification level** (hierarchical): Unclassified → Confidential → Secret → Top Secret
- **Compartments / Categories** (non-hierarchical): e.g., NATO, EYES ONLY, SIGINT

A subject needs both the correct **clearance level** (≥ the object's classification) and membership in the required **compartment** to gain access.

**Models that implement MAC:**

**Bell-LaPadula (confidentiality focus — government/military):**
- **No Read Up** (Simple Security Property): You cannot read data classified above your clearance
- **No Write Down** (Star Property): You cannot write data to a level below yours (prevents leaking classified info to lower-classified locations)
- Mental model: classified information can only flow *up* the hierarchy

**Biba (integrity focus — financial, medical):**
- **No Write Up**: You cannot write to a higher-integrity level than you possess (prevents contamination)
- **No Read Down**: You cannot read from a lower-integrity source (prevents your decisions being influenced by untrusted data)
- Mental model: trusted data can only flow *down* the hierarchy

**Real-world implementations:**
- **SELinux** (Security-Enhanced Linux): process-level labels enforced by the kernel; used in RHEL, Android
- **AppArmor**: simpler profile-based MAC on Ubuntu/Debian
- **Windows Integrity Levels**: process isolation (Low, Medium, High, System) — a simplified MAC layer

**Strengths:**
- System cannot be bypassed by owners or users
- Formally provable security properties

**Weaknesses:**
- Administratively complex (labelling every object)
- Not suitable for dynamic commercial environments
- Primarily used in government/military

> [!tip] MAC mental model
> MAC is like a locked building with badge readers controlled by security. Even the CEO cannot let someone in by propping open a door — the system decides.

> [!warning] Classification labels are not MAC by themselves
> Marking a document as `Public`, `Internal`, `Confidential`, or `Restricted` is **data classification**. It becomes MAC only when the system enforces access by comparing object labels against centrally controlled subject clearances or compartments, and the resource owner cannot override the rule.

| Situation | Correct classification |
|---|---|
| User labels a SharePoint file `Confidential`, but access is still controlled by groups or ACLs | Data classification plus RBAC/DAC-style enforcement |
| File owner manually grants another user access to a confidential file | DAC |
| Manager adds a user to an AD group that can read a confidential folder | RBAC |
| System denies access unless subject clearance and compartments dominate the file label | MAC |

---

### 3. Role-Based Access Control (RBAC)

**Who decides:** A central administrator defines roles; membership in a role grants permissions.

In RBAC, permissions are assigned to **roles** (job functions), not to individual users. Users are assigned to roles. Users gain permissions by being in a role; they lose permissions when removed from it.

```
Role: "Finance Analyst"
    Permissions: Read finance reports, Submit expense claims, View budgets

User jsmith → assigned Finance Analyst role → inherits all role permissions
```

**Key properties:**
- Non-discretionary: users cannot assign themselves or others to roles
- Least privilege: assign only the roles needed for the job
- Separation of duties: configure roles so no single role can complete a sensitive transaction

**AD groups are RBAC in practice.** A security group in AD is a role; membership grants the permissions associated with that group in every integrated system.

**Strengths:**
- Central administration — permissions change when roles change, not per-user
- Audit-friendly — "who has the Finance Analyst role?" is a single query
- Maps naturally to organisational structure

**Weaknesses:**
- Role explosion in large organisations (hundreds of micro-roles)
- Coarse-grained — cannot easily say "Finance Analyst can see Q1 data but not Q4"

---

### 4. Rule-Based Access Control

**Who decides:** A set of *global rules* that apply to all subjects equally.

Rule-Based applies a fixed rule to *every* access request, regardless of who the subject is. The rule is a condition: if the condition is met, access is granted.

**Canonical example — firewall ACL:**
```
Rule 1: PERMIT TCP any → 10.0.1.0/24 port 443
Rule 2: DENY TCP any → 10.0.1.0/24 port 23
Rule 3: DENY IP any → any   (implicit deny)
```

These rules apply to every packet, regardless of who sent it. There are no users in this model — only conditions.

> [!warning] Rule-Based ≠ RBAC
> The names sound similar but the models are distinct. RBAC assigns permissions to roles that users belong to. Rule-Based applies conditions to all subjects equally. A firewall uses Rule-Based; an AD group is RBAC.

---

### 5. Attribute-Based Access Control (ABAC)

**Who decides:** A policy engine evaluating combinations of *attributes* from the subject, the object, the environment, and the action.

ABAC is the most flexible model. An access decision is made by evaluating a policy rule that can reference any attribute:

```
PERMIT IF:
    subject.role = "Manager"
    AND subject.department = "Finance"
    AND resource.classification = "Internal"
    AND action = "Read"
    AND environment.time >= 08:00 AND <= 18:00
    AND environment.network = "Corporate"
```

**Attribute types:**
- **Subject attributes**: role, department, clearance level, location, device type
- **Object attributes**: classification, owner, data category, sensitivity
- **Action attributes**: read, write, delete, approve
- **Environment attributes**: time of day, network location, IP address, device posture

**Standard:** XACML (eXtensible Access Control Markup Language) defines the policy language and enforcement architecture for ABAC.

**Real-world use:** Software-Defined Networking (SDN), cloud IAM policies (AWS IAM conditions, Azure Conditional Access), zero-trust architectures.

**Strengths:**
- Extremely fine-grained — can express "Finance Manager can approve payments only from corporate network during business hours"
- Context-aware — environment attributes enable dynamic decisions

**Weaknesses:**
- Complex to design and audit
- Policy can become difficult to reason about when many attributes interact

---

### 6. Risk-Based Access Control

**Who decides:** A real-time risk engine that evaluates the current security posture of the request.

Risk-Based Access Control extends ABAC by adding risk scoring and adaptive decisions. Rather than a binary permit/deny, the system can:
- Grant access (risk is low)
- Step up authentication (require MFA because risk is elevated)
- Deny access (risk is too high)
- Flag for review

**Risk factors evaluated:**
- User location (known corporate IP vs. unexpected country)
- Device health (compliant managed device vs. unknown device)
- Login behaviour (normal hours vs. 3am, normal volume vs. bulk download)
- MFA usage (already passed MFA this session vs. password-only)
- Threat intelligence (IP in known bad-actor range)

**Real-world implementation:** Azure Conditional Access, Okta Adaptive MFA, Google BeyondCorp.

> [!tip] Risk-Based is not a replacement for other models
> Risk-Based operates as a layer on top of another model (typically RBAC or ABAC). The baseline entitlement is still managed via roles or attributes; risk evaluation decides *how* that entitlement is enforced in a given session.

---

## The PDP / PEP Architecture

Every access control model separates the *decision* from the *enforcement* into two roles. This is formalised in the **Policy Decision Point / Policy Enforcement Point** architecture.

```
User requests access to resource
            │
            ▼
┌─────────────────────────┐
│  Policy Enforcement     │  ← PEP: the gatekeeper
│  Point (PEP)            │     (firewall, API gateway, OS kernel,
│                         │      file system, application)
└────────────┬────────────┘
             │  Access request
             ▼
┌─────────────────────────┐
│  Policy Decision        │  ← PDP: the brain
│  Point (PDP)            │     (RADIUS server, AD KDC,
│                         │      cloud IAM engine, XACML engine)
└────────────┬────────────┘
             │  Permit / Deny
             ▼
┌─────────────────────────┐
│  PEP enforces decision  │
│  Access granted or      │
│  denied                 │
└─────────────────────────┘
```

| Role | Responsibility | Examples |
|---|---|---|
| **PDP** | Evaluates the request against policy; decides permit or deny | RADIUS server, Kerberos KDC, Azure AD Conditional Access engine, XACML PDP |
| **PEP** | Intercepts access requests; enforces PDP decisions | Firewall, VPN gateway, OS access control, API gateway, web proxy |

---

## Common Access Control Mechanisms

These mechanisms implement the models above at a technical level:

| Mechanism | What It Is | Example |
|---|---|---|
| **Implicit deny** | Anything not explicitly permitted is denied | Firewall with no default permit rule |
| **Access Control List (ACL)** | A list on a resource mapping subjects to permissions | NTFS security tab, firewall ruleset |
| **Access Control Matrix** | A table with subjects as rows, objects as columns, permissions in cells | Conceptual model; impractical at scale |
| **Capability table** | Subjects carry a token/ticket listing what they can access | Kerberos service tickets |
| **Constrained interface** | UI hides or disables options the user cannot access | Web app that hides the "Delete" button for read-only users |
| **Content-dependent control** | Access depends on the *content* of the data | Database view that filters rows by user's department |
| **Context-dependent control** | Access depends on *when/where/how* the request comes in | Time-of-day rules, location-based access |

---

## Comparison Table

| Model | Who Decides | Label-Based | Supports Need-to-Know | Typical Use |
|---|---|---|---|---|
| **DAC** | Resource owner | No | Partial | Enterprise file systems, general IT |
| **MAC** | System (via labels) | Yes | Yes (strictly) | Government, military, high-assurance |
| **RBAC** | Central admin (via roles) | No | Partial | Enterprise applications, AD groups |
| **Rule-Based** | Global rule set | No | No | Firewalls, network ACLs |
| **ABAC** | Policy engine (attributes) | Optional | Yes | Cloud IAM, SDN, zero trust |
| **Risk-Based** | Risk engine (real-time) | No | Context-aware | Adaptive MFA, conditional access |

---

## Related

- [[IAM-Overview]] — where access control models fit in the IAM stack
- [[AD-LDAP-Fundamentals]] — AD groups as the practical RBAC implementation
- [[AD-Application-Integration]] — how different applications enforce their access control model
- [[AD-File-Shares-NAS-DFS]] — NTFS ACLs as DAC in practice
- [[Authentication-Factors-MFA]] — authentication (who you are) vs. authorisation (what you can do)
- [[Privilege-Escalation-Service-Accounts]] — what happens when access control models are bypassed
- [[AI-Agent-Identity-and-IAM]] — applying ABAC, risk-based access, and PDP/PEP controls to AI agent tool use
