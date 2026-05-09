---
tags: [active-directory, domain, forest, trust, cross-domain, agdlp, global-catalog, cissp, domain-5-iam, cissp/5.3-federated-identity]
aliases: [AD Domains, Forest Trust, Cross-Domain Groups, Domain Trusts]
---

# AD Domains, Forests, and Trusts

A key question in enterprise IAM is: **can an AD group be used across domains?** The answer is: *it depends on the group's scope and whether a trust exists*. This note explains domain topology and gives concrete rules.

---

## What is an AD Domain?

An AD **domain** is the fundamental unit of Active Directory. It is:
- A **security boundary** — authentication and authorisation policies are defined per domain
- A **namespace** — the domain has a DNS name like `corp.example.com`
- Managed by one or more **Domain Controllers (DCs)** that hold the authoritative copy of domain data

Every object in AD (user, group, computer) belongs to exactly one domain.

> [!note] Domain ≠ OU
> An Organisational Unit (OU) is just a container within a domain for organising objects. A domain is a full security boundary with its own policies and administrators. They are not interchangeable.

---

## What is an AD Forest?

A **forest** is a collection of one or more domains that share:
- A common **schema** (the definition of all object classes and attributes)
- A common **global catalog** (a partial replica of all objects across all domains)
- An automatic two-way transitive trust between all domains in the forest

The first domain created in a forest is the **forest root domain**. Additional domains added later are **child domains** (e.g., `emea.corp.example.com` under `corp.example.com`).

```
Forest: example.com
    ├── corp.example.com          (forest root)
    │       ├── emea.corp.example.com
    │       └── apac.corp.example.com
    └── subsidiary.example.com   (tree root)
```

> [!tip] Forest boundary is the real security boundary
> Domains within the same forest automatically trust each other. A **forest** is the true security boundary — objects from one forest cannot access resources in another forest without an explicit trust.

---

## Domain Trusts

A trust allows users in one domain to authenticate in another domain. Trusts come in several types:

### Trust Direction

| Direction | Meaning |
|---|---|
| **One-way trust** | Domain A trusts Domain B: users in B can access resources in A |
| **Two-way trust** | Both directions: users in either domain can access resources in the other |

> [!warning] Trust direction is often confused
> "Domain A trusts Domain B" means A *accepts* authentication from B. Users in B can access A's resources — not the other way around. The trusting domain is the one granting access.

### Trust Types

| Type | Transitivity | Scope | Auto-created? |
|---|---|---|---|
| **Parent-child** | Transitive | Within a forest tree | Yes (when child domain is created) |
| **Tree-root** | Transitive | Between forest trees | Yes (when new tree is added) |
| **Forest trust** | Transitive | Between two forests | No — must be created manually |
| **External trust** | Non-transitive | Between specific domains (cross-forest or legacy) | No |
| **Shortcut trust** | Transitive | Within forest (speeds up auth between distant domains) | No |

**Transitive** means the trust extends through intermediaries: if A trusts B and B trusts C, then A transitively trusts C (within the same forest).

---

## Cross-Domain Group Membership — The Rules

This is the most practically important section. Whether an AD group can span domain boundaries depends entirely on its **scope**.

### The Definitive Table

| Group Scope | Who Can Be a Member | Where Can It Grant Permissions |
|---|---|---|
| **Domain Local** | Users/groups from **any trusted domain or forest** | **Own domain only** |
| **Global** | Users/groups from the **same domain only** | **Any trusted domain** |
| **Universal** | Users/groups from **any domain in the forest** | **Any domain in the forest** |

> [!warning] Common mistake
> People assume "Domain Local" means the group is local to the domain and therefore restricted. In fact, **Domain Local groups can have members from anywhere** — the restriction is on where they can *assign permissions* (own domain only).

### Scenario-Based Examples

**Scenario A: User in `corp.example.com` needs access to a file share in `emea.corp.example.com` (same forest)**

Best practice using AGDLP (see below):
1. Create a **Global group** in `corp.example.com` containing the user → `GG-FinanceUsers`
2. Create a **Domain Local group** in `emea.corp.example.com` → `DL-FileShare-Finance-Read`
3. Add `GG-FinanceUsers` as a member of `DL-FileShare-Finance-Read`
4. Grant `DL-FileShare-Finance-Read` permission on the file share

The user in `corp` gets access to the share in `emea` through the nested group structure.

**Scenario B: Need a group whose members span multiple domains in the same forest**

Use a **Universal group**. Universal groups can contain members from any domain in the forest and can grant permissions in any domain in the forest. They replicate to the Global Catalog.

**Scenario C: Cross-forest access (two separate forests with a forest trust)**

A **Domain Local group** in Forest A can contain a **Global group** from Forest B (if a forest trust exists). Universal groups from another forest cannot be added directly to a Domain Local group across a forest trust boundary — you must use Global groups as intermediaries.

---

## The AGDLP Pattern

AGDLP is the Microsoft-recommended best practice for managing group-based permissions. It stands for:

**A**ccounts → **G**lobal groups → **D**omain **L**ocal groups → **P**ermissions

```
User Account (A)
    │
    ▼
Global Group (G)  ← contains users from same domain, grouped by role
    │
    ▼
Domain Local Group (DL)  ← assigned to a resource in the target domain
    │
    ▼
Permission (P)  ← Read, Write, Full Control on a resource
```

For universal groups in multi-domain forests, it extends to **AGUDLP**:
A → G → Universal → DL → P

> [!tip] Why AGDLP?
> Global groups are easy to manage (same-domain members). Domain Local groups are where permissions are assigned. Nesting Global into Domain Local separates "who" from "what they can access," making changes easier — you only touch one place when someone changes roles.

---

## Global Catalog

The **Global Catalog (GC)** is a partial replica of every object in the forest, held on designated Domain Controllers (Global Catalog servers).

Why it matters for groups:
- When a user logs in, Windows queries the GC to find all **Universal group** memberships (because Universal groups can span domains, they must replicate to the GC)
- **Global group** memberships are NOT stored in the GC — only the domain's own DC knows about them
- **Domain Local group** memberships are never in the GC

This has a performance implication: if the GC is unavailable, users may not get their Universal group memberships applied at login.

> [!note] IIQ and the Global Catalog
> When IIQ's AD connector is configured to query the Global Catalog (port 3268 or 3269 for LDAPS), it can search across all domains in the forest in a single query. This is useful for organisations with many child domains — one IIQ Application pointed at the GC can see all users across the forest.

---

## SID History and SID Filtering

When a user account is **migrated** from one domain to another (e.g., during an M&A integration), the old domain's SID can be preserved in the new account's **`sIDHistory`** attribute. This allows the user to retain access to resources that were granted to the old SID.

**SID filtering** is a security control that prevents SIDs from a trusted domain from being honoured in the trusting domain. It is enabled by default on external trusts to prevent privilege escalation attacks.

> [!warning] M&A and SID history
> During mergers and acquisitions, SID history is often used as a temporary bridge while access is formally migrated. IIQ will see the new account but must be configured to handle the SID history period — otherwise entitlements linked to old SIDs may not correlate correctly.

---

## Practical Scenarios in an Enterprise

### Same-Forest Multi-Domain Organisation

A large bank might have:
- `corp.bank.com` — corporate users
- `trading.bank.com` — trading floor users
- `ops.bank.com` — operations users

All three are in the forest `bank.com` and automatically trust each other. A Universal group `UG-Bloomberg-Access` can contain users from all three domains and grant access to Bloomberg terminals.

IIQ would typically have **one AD Application per domain** to aggregate accounts. The entitlement `UG-Bloomberg-Access` would appear in whichever domain's Application owns that group.

### Cross-Forest (Post-Acquisition)

After acquiring another company, their AD forest `acquired.com` is separate. A forest trust is established. Users in `acquired.com` need access to internal systems.

Until the accounts are migrated to `bank.com`, they authenticate via the trust. IIQ can be configured with an Application for each forest, but correlating identities across forests requires careful correlation rule design.

### No Trust (Completely Isolated)

Regulatory requirements sometimes mandate that certain systems have no trust relationship with corporate AD. Users in the isolated domain must have separate accounts, managed as a separate Application in IIQ.

---

## How This Affects IIQ

| Topology | IIQ Configuration |
|---|---|
| Single domain | One AD Application in IIQ |
| Multi-domain, same forest | One Application per domain, or one Application pointed at Global Catalog |
| Multi-forest with trust | One Application per forest (or per domain) |
| No trust (isolated) | Separate Application; no cross-Application identity correlation |

Cross-domain entitlements appear in IIQ as entitlements on the Application that owns the group. A user in `corp.example.com` who is a member of a group in `emea.corp.example.com` will have that entitlement recorded against the `emea` Application.

See [[IIQ-AD-LDAP-Connector]] for how IIQ is configured to connect to each domain.

---

## Related

- [[IAM-Overview]] — how domains fit into the broader IAM stack
- [[AD-LDAP-Fundamentals]] — group types and LDAP fundamentals
- [[IIQ-AD-LDAP-Connector]] — IIQ configuration for multi-domain environments
- [[AD-Groups-in-IIQ-Governance]] — cross-domain entitlements in IIQ's data model
