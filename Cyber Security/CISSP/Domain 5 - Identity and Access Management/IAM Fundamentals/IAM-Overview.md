---
tags: [iam, overview, governance, provisioning, authentication, authorization, cissp, domain-5-iam, cissp/5.1-access-control, cissp/5.4-authorization]
aliases: [Identity and Access Management, IAM Introduction, IAM Stack]
---

# IAM Overview

Identity and Access Management (IAM) is the discipline of ensuring the **right people have the right access to the right resources at the right time** — and that all of this is governed, auditable, and revoked when no longer needed.

In a large organisation, thousands of users interact with hundreds of systems. Without IAM, access is granted informally, never reviewed, and rarely removed. IAM enforces structure around the full lifecycle: from a new hire's first day to a leaver's last.

> [!tip] Two questions IAM answers
> 1. **Who are you?** (Authentication — proving identity)
> 2. **What are you allowed to do?** (Authorization — controlling access)

---

## The IAM Stack

IAM is not a single tool. It is a layered set of technologies, each responsible for a different concern. Understanding the layers prevents confusion about which tool does what.

```
┌─────────────────────────────────────────────────────┐
│              GOVERNANCE LAYER                        │
│   SailPoint IIQ, Saviynt — policy, reviews, risk    │
├─────────────────────────────────────────────────────┤
│           PRIVILEGED ACCESS LAYER                    │
│   CyberArk, BeyondTrust — admin/shared accounts     │
├─────────────────────────────────────────────────────┤
│           AUTHENTICATION LAYER                       │
│   Kerberos, SAML, OAuth2/OIDC, MFA, SSO             │
├─────────────────────────────────────────────────────┤
│           AUTHORIZATION LAYER                        │
│   Group membership, RBAC, ABAC, ACLs                │
├─────────────────────────────────────────────────────┤
│             DIRECTORY LAYER                          │
│   Active Directory, LDAP, Azure AD — where          │
│   identities and groups live                        │
└─────────────────────────────────────────────────────┘
```

![[IAM-Stack.excalidraw.md]]

### Directory Layer — Where Identities Live

The directory is the foundation. It stores user accounts, groups, and the relationships between them. Every other layer reads from or writes back to the directory.

- **[[AD-LDAP-Fundamentals|LDAP]]** — the protocol used to query and update directories
- **[[AD-LDAP-Fundamentals|Active Directory (AD)]]** — Microsoft's directory: LDAP + Kerberos + DNS, the most common enterprise directory
- **Azure AD / Entra ID** — Microsoft's cloud directory; often synchronised with on-prem AD
- **OpenLDAP** — open-source LDAP directory common in Linux environments

> [!note] Key insight
> Active Directory *is* an LDAP directory. Any tool that speaks LDAP can query AD. The terms are not opposites — AD is one implementation of the LDAP standard.

### Authentication Layer — Proving Who You Are

Authentication verifies that a user is who they claim to be. It reads the directory to validate credentials.

| Protocol | Used For |
|---|---|
| **Kerberos** | On-premises Windows login (AD-native) |
| **SAML 2.0** | Enterprise SSO between web applications |
| **OAuth2 / OIDC** | Modern app and API authentication |
| **LDAP bind** | Application login validated against directory |
| **MFA** | Second factor (OTP, push, hardware key) |

### Authorization Layer — What You Can Do

Once authenticated, authorization decides what actions a user can perform. In practice, this usually means **group membership**: a user is in a group, the group is granted a permission, therefore the user has that permission.

- **RBAC (Role-Based Access Control)** — permissions assigned to roles, roles assigned to users (what [[AD-Groups-in-IIQ-Governance|IIQ governs]])
- **ABAC (Attribute-Based Access Control)** — permissions based on attributes (department, location, clearance level)
- **ACLs (Access Control Lists)** — direct permission grants on a resource (e.g., file share permissions)

### Governance Layer — Enforcing Policy Over Time

Governance tools sit above all other layers and ask: *Is the access people have appropriate? Is it still needed? Was it properly approved?*

- **[[IIQ-Concepts|SailPoint IdentityIQ (IIQ)]]** — aggregates accounts and entitlements from all systems, runs access reviews (certifications), enforces lifecycle policy, and provisions/deprovisions access
- **Saviynt, Omada, One Identity** — alternatives to IIQ in the same category
- **Microsoft Identity Manager (MIM)** — Microsoft's on-prem IGA tool

> [!tip] Where IIQ sits
> IIQ does not replace AD or LDAP. It reads from them (via [[IIQ-AD-LDAP-Connector|aggregation]]), makes governance decisions, and writes back to them (via provisioning). AD is the authoritative store of accounts and groups; IIQ is the governing authority over what should exist there.

### Privileged Access Layer — Controlling Admin Accounts

Privileged accounts (domain admins, service accounts, root) are managed separately because their compromise is catastrophic. Privileged Access Management (PAM) tools vault credentials, enforce check-out/check-in, and record sessions.

- See [[CyberArk-IIQ-Integration]] for how CyberArk integrates with IIQ

---

## How the Layers Interact

The flow of information is:

```
HR System (authoritative source)
    │  new hire event
    ▼
SailPoint IIQ (governance layer)
    │  calculates required access
    │  runs approval workflows
    ▼
Active Directory (directory layer)
    │  account created, added to groups
    ▼
Applications (use AD groups for authorization)
    │  user can now log in
    ▼
SailPoint IIQ (governance loop)
    │  aggregates back from AD
    │  certifications prompt managers to review access
    ▼
Active Directory (directory layer)
    │  group membership removed when access revoked
```

The loop is continuous: provisioning creates access, aggregation records what exists, certifications review it, and deprovisioning removes it.

---

## Key IAM Terms

| Term | Definition |
|---|---|
| **Identity** | A digital representation of a person (or service). In IIQ: `spt_identity`. |
| **Agent identity** | A digital identity for an AI agent or autonomous software actor; see [[AI-Agent-Identity-and-IAM]]. |
| **Account** | A user's login on a specific system. In IIQ: `spt_link`. |
| **Entitlement** | A discrete access right — usually group membership. In IIQ: `spt_managed_attribute`. |
| **Provisioning** | Creating, modifying, or removing an account or entitlement. |
| **Aggregation** | IIQ reading account/group data from a source system into its database. |
| **Correlation** | Matching an account on a source system to the correct identity in IIQ. |
| **Certification** | A scheduled access review where managers confirm or revoke entitlements. |
| **SOD** | Separation of Duties — a policy preventing one person from holding two conflicting roles. |
| **JML** | Joiner-Mover-Leaver — the lifecycle of an identity from hire to departure. |
| **Role** | A collection of entitlements grouped by job function. In IIQ: `spt_bundle`. |

---

## IAM in Regulated Industries

Banks, healthcare organisations, and government agencies have strict IAM requirements driven by regulation:

| Regulation | IAM Requirement |
|---|---|
| **SOX** (Sarbanes-Oxley) | Quarterly access certifications for financial systems; segregation of duties |
| **GDPR** | Right to erasure; data access limited to legitimate purpose |
| **PCI-DSS** | Least privilege; MFA for cardholder data environments |
| **Basel III / banking regs** | Privileged access controls; audit trails for sensitive operations |
| **APRA CPS 230** | Operational resilience, critical operations, business continuity, and service provider risk management |
| **APRA CPS 234** | Information security capability, security controls, testing, incident response, and APRA notification for material information security incidents |

A governance tool like IIQ exists in these environments precisely to produce the audit evidence these regulations demand: who approved this access, when was it last reviewed, and who removed it.

### APRA CPS 230 and CPS 234

APRA is the Australian Prudential Regulation Authority. Its cross-industry prudential standards apply to APRA-regulated entities such as authorised deposit-taking institutions, insurers, private health insurers, and registrable superannuation entity licensees.

| Standard | Focus | Why IAM matters |
|---|---|---|
| **[CPS 230 - Operational Risk Management](https://handbook.apra.gov.au/standard/cps-230)** | Requires APRA-regulated entities to manage operational risk, maintain critical operations within tolerance levels during severe disruptions, and manage risks from service providers. APRA lists CPS 230 as current from **1 July 2025**. | IAM supports operational resilience by controlling who can access critical systems, enforcing privileged access controls, preserving access review evidence, and reducing dependency risk when service providers administer important platforms. |
| **[CPS 234 - Information Security](https://handbook.apra.gov.au/standard/cps-234)** | Requires APRA-regulated entities to maintain an information security capability proportionate to threats and information assets; implement controls based on asset criticality and sensitivity; test control effectiveness; and notify APRA of material information security incidents. APRA lists CPS 234 as current from **1 July 2019**. | IAM is one of the control families that protects confidentiality, integrity, and availability: authentication, authorization, least privilege, access revocation, privileged session control, and periodic certification all provide evidence that access to information assets is governed. |

```
APRA obligation
    │
    ▼
Critical system or information asset identified
    │
    ▼
IAM control applied: MFA, role, group, privilege vault, or access review
    │
    ▼
Evidence retained: approval, certification, log, or removal record
```

> [!note] CPS 230 vs CPS 234
> CPS 230 is broader operational resilience and service provider risk management. CPS 234 is specifically information security. They overlap when an identity, cyber, third-party, or privileged access failure could disrupt a critical operation or compromise an information asset.

---

## IAM Tool Landscape

| Category | Tools |
|---|---|
| **Directory** | Active Directory, OpenLDAP, Azure AD (Entra ID), FreeIPA |
| **SSO / Authentication** | Okta, Ping Identity, Azure AD B2C, Keycloak |
| **IGA (Governance)** | SailPoint IIQ, SailPoint Identity Security Cloud, Saviynt, Omada, One Identity |
| **PAM (Privileged)** | CyberArk, BeyondTrust, HashiCorp Vault, Thycotic |
| **SIEM (Monitoring)** | Splunk, Microsoft Sentinel (consumes IAM audit logs) |

---

## Related

- [[AD-LDAP-Fundamentals]] — how the directory layer works in detail
- [[AD-Domain-Forest-Trusts]] — domain and forest topology
- [[Access-Control-Models]] — MAC, DAC, RBAC, ABAC, Risk-Based; PDP/PEP; how the authorization layer is implemented
- [[Authentication-Factors-MFA]] — factor types, biometrics, AAL levels, SSO, JIT; the authentication layer in depth
- [[Kerberos-Protocol]] — Kerberos deep dive: KDC, TGT, AES, NTP
- [[SAML-Federation]] — SAML 2.0, IDaaS, on-prem/cloud/hybrid federation
- [[OAuth2-OIDC]] — OAuth 2.0 and OIDC; JWT; delegated access
- [[RADIUS-TACACS-Diameter]] — AAA protocols for network access
- [[Privilege-Escalation-Service-Accounts]] — privilege creep, service accounts, escalation types
- [[AI-Agent-Identity-and-IAM]] — emerging IAM model for autonomous AI agents, tool access, delegated action, and auditability
- [[IIQ-Concepts]] — SailPoint IIQ mental models
- [[IIQ-AD-LDAP-Connector]] — how IIQ connects to AD/LDAP
- [[AD-Groups-in-IIQ-Governance]] — how AD groups flow into IIQ governance
- [[CyberArk-IIQ-Integration]] — privileged access integration
