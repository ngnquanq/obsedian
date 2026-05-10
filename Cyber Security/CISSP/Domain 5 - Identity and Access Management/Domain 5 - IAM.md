---
tags: [cissp, domain-5-iam, moc, identity, access-management]
aliases: [CISSP Domain 5, IAM Domain, Identity and Access Management]
---

# CISSP Domain 5 — Identity and Access Management

Identity and Access Management (IAM) ensures the right people have the right access to the right resources at the right time. Domain 5 covers the full lifecycle: from proving identity, to granting access, to reviewing and revoking it.

---

## CISSP Domain 5 Subtopics

| Subtopic                                    | What It Covers                                                                                                   | Notes in This Vault                                                                                                                                                                       |
| ------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **5.1** Control physical and logical access | Access control models, physical access, least privilege                                                          | [[Physical-vs-Logical-Access]], [[IAM-Overview]], [[what-is-pam]], [[CyberArk-IIQ-Integration]]                                                                                           |
| **5.2** Identification & Authentication     | Groups and roles, AAA, MFA, passwordless, session management, identity proofing, credential management, SSO, JIT | [[AD-LDAP-Fundamentals]], [[AD-Application-Integration]], [[Authentication-Factors-MFA]], [[Kerberos-Protocol]], [[Privilege-Escalation-Service-Accounts]], [[AI-Agent-Identity-and-IAM]] |
| **5.3** Federated Identity                  | SAML, OAuth, OIDC, domain trusts, cross-forest                                                                   | [[AD-Domain-Forest-Trusts]], [[AD-Application-Integration]], [[SAML-Federation]], [[OAuth2-OIDC]]                                                                                         |
| **5.4** Authorization mechanisms            | RBAC, ABAC, ACLs, group-based access                                                                             | [[Access-Control-Models]], [[AD-Application-Integration]], [[AD-File-Shares-NAS-DFS]], [[AD-Groups-in-IIQ-Governance]], [[AI-Agent-Identity-and-IAM]]                                     |
| **5.5** Provisioning lifecycle              | JML (Joiner-Mover-Leaver), access requests, certifications                                                       | [[IIQ-Concepts]], [[IIQ-Data-Flows]], [[IIQ-AD-LDAP-Connector]], [[Privilege-Escalation-Service-Accounts]], [[AI-Agent-Identity-and-IAM]]                                                 |
| **5.6** Authentication systems              | SSO, Kerberos, RADIUS, TACACS+                                                                                   | [[Kerberos-Protocol]], [[SAML-Federation]], [[OAuth2-OIDC]], [[RADIUS-TACACS-Diameter]], [[AD-Application-Integration]]                                                                   |

---

## Reading Path

Start here if you're new to IAM:

```
1.  IAM-Overview                        — understand the technology stack and where each tool fits
2.  AD-LDAP-Fundamentals                — understand directories, groups, and AD itself
3.  AD-Domain-Forest-Trusts             — understand cross-domain topology (key for 5.3)
4.  AD-Application-Integration          — understand how apps consume AD (key for 5.2, 5.4, 5.6)
5.  AD-File-Shares-NAS-DFS             — file share access model: NAS, DFS, UNC, NTFS ACLs
6.  Access-Control-Models               — MAC, DAC, RBAC, ABAC, Rule-Based, Risk-Based, PDP/PEP (key for 5.4)
7.  Authentication-Factors-MFA          — identity proofing, factor types, biometrics, AAL, credential management, SSO, JIT, session management (key for 5.2)
8.  Kerberos-Protocol                   — KDC, TGT, service tickets, AES, NTP (key for 5.6)
9.  SAML-Federation                     — SAML 2.0, IDaaS, on-prem/cloud/hybrid federation (key for 5.3, 5.6)
10. OAuth2-OIDC                         — OAuth 2.0 delegation, OIDC authentication, JWT (key for 5.3, 5.6)
11. RADIUS-TACACS-Diameter              — AAA protocols, network access authentication (key for 5.6)
12. Privilege-Escalation-Service-Accounts — escalation types, service accounts, credential vaults, privilege creep (key for 5.2, 5.5)
13. IIQ-Concepts                        — understand governance tooling (key for 5.5)
14. IIQ-Data-Flows                      — understand the provisioning and certification flows
15. AD-Groups-in-IIQ-Governance         — tie everything together
16. AI-Agent-Identity-and-IAM           — emerging addendum: agents as governable IAM subjects (future-system context)
```

---

## IAM Fundamentals

Notes covering the underlying technology — no tooling yet, just the protocols and concepts.

- [[Physical-vs-Logical-Access]] — CISSP 5.1 foundations: AAA model, defense-in-depth principles, and how logical access materializes in IIQ
- [[IAM-Overview]] — the IAM stack: directory, authentication, authorization, governance, PAM layers
- [[AD-LDAP-Fundamentals]] — LDAP protocol, Active Directory, group types, key attributes, macOS/Linux integration
- [[AD-Domain-Forest-Trusts]] — domains, forests, trust types, cross-domain group scope rules, AGDLP
- [[AD-Application-Integration]] — Kerberos tokens, LDAP bind, SAML/federation, PAM/SSSD; how apps actually consume AD groups
- [[AD-File-Shares-NAS-DFS]] — NAS devices, UNC paths, DFS namespaces, NTFS vs. share permissions, AGDLP on file share ACLs
- [[Access-Control-Models]] — MAC, DAC, RBAC, Rule-Based, ABAC, Risk-Based; PDP/PEP architecture; implicit deny and constrained interfaces
- [[Authentication-Factors-MFA]] — identity registration/proofing, five factor types, MFA vs 2FA, biometrics (FAR/FRR/CER), AAL1/2/3, credential management systems, TOTP/FIDO2, SSO, JIT provisioning, session management
- [[Kerberos-Protocol]] — KDC, AS, TGS, TGT, Service Ticket, PAC; full ticket exchange flow; AES, NTP dependency, port 88
- [[SAML-Federation]] — SAML 2.0 assertion types, SP/IdP-initiated flows, metadata, IDaaS, WS-Federation, on-prem/cloud/hybrid federation
- [[OAuth2-OIDC]] — OAuth 2.0 grant types, OIDC authentication layer, JWT/ID tokens, delegated access, OAuth vs SAML
- [[RADIUS-TACACS-Diameter]] — AAA model, RADIUS (UDP 1812/1813), TACACS+ (TCP 49, full encryption), Diameter
- [[Privilege-Escalation-Service-Accounts]] — horizontal/vertical escalation, lateral movement, privilege creep, credential vaults, service account management, gMSA
- [[AI-Agent-Identity-and-IAM]] — emerging addendum: AI agents as non-human IAM subjects with delegated access, tool permissions, memory, ownership, and audit requirements

---

## SailPoint IIQ — Enterprise IAM Governance

Notes covering SailPoint IdentityIQ as a concrete implementation of IAM governance (CISSP 5.5).

### Concepts & Architecture
- [[IIQ-Concepts]] — Identity Cube, authoritative sources, roles, entitlements, JML lifecycle
- [[IIQ-Data-Flows]] — aggregation, correlation, access request, certification, and provisioning flows
- [[IIQ-Field-Values]] — enumerated values for all key status fields

### Active Directory Integration
- [[IIQ-AD-LDAP-Connector]] — connector config, aggregation mechanics, correlation rules, delta sync
- [[AD-Groups-in-IIQ-Governance]] — managed entitlements, role modelling, certifications, SQL recipes

### Schema Reference
- [[IIQ]] — complete database schema for all ~80 `spt_*` tables

### Analytics & Reporting
- [[IIQ-Analyst-Playbook]] — SQL recipes for common business questions

### Privileged Access
- [[CyberArk-IIQ-Integration]] — CyberArk PAM + SailPoint IIQ integration patterns
- [[PrivilegedA-Account-Data-Queries]] — SQL queries for privileged "A" accounts in AD

---

## CyberArk PAM — Privileged Access Management

Standalone reference for CyberArk Self-Hosted PAM, focused on data model, architecture, and dashboarding via Power BI. Treat this section as **supporting implementation context**, not the exam-core reading path. It reinforces CISSP 5.1 (control of privileged access), 5.2 (credential management systems / password vault), 5.4 (authorization for shared/admin accounts), and 5.5 (privileged account lifecycle), but many dashboard/API/reference notes are vendor-specific rather than CISSP objectives.

### Index
- [[CyberArk PAM/README|CyberArk PAM Index]] — entry point with full table of contents

### Core Concepts
- [[what-is-pam]] — Privileged Access Management fundamentals
- [[what-is-cyberark]] — CyberArk product suite overview (Self-Hosted)
- [[why-pam-matters]] — compliance and security drivers (SOX, PCI-DSS, SOC 2)

### Architecture
- [[CyberArk PAM/02-architecture/overview|CyberArk Architecture Overview]] — high-level architecture and data flows
- [[digital-vault]] — encrypted credential storage at the centre
- [[pvwa]] — web interface and REST API gateway (the dashboard integration point)
- [[cpm]] — password rotation engine
- [[psm]] — session isolation and recording
- [[pta]] — threat analytics
- [[aam-ccp]] — application credential retrieval
- [[deployment-models]] — Self-Hosted vs Privilege Cloud deployment options

### Data Model (Key Entities)
- [[safes]] — logical containers for accounts (the primary access boundary)
- [[accounts]] — privileged credentials (the central entity)
- [[platforms]] — management behaviour definitions per target type
- [[CyberArk PAM/03-key-entities/users-and-groups|CyberArk Users and Groups]] — vault users and LDAP integration
- [[policies-and-permissions]] — access control on safes
- [[CyberArk PAM/03-key-entities/sessions|CyberArk Sessions]] — privileged session objects

### Glossary & Reference
- [[CyberArk PAM/04-glossary/glossary|CyberArk Glossary]] — A–Z reference of CyberArk-specific terms
- [[common-error-codes]] — error code lookup
- [[further-reading]] — external docs and resources

### Dashboarding (Power BI)
- [[key-metrics-and-kpis]] — master metrics list
- [[password-management-dashboard]]
- [[session-monitoring-dashboard]]
- [[compliance-dashboard]]
- [[system-health-dashboard]]
- [[power-bi-integration]] — REST API authentication and query patterns

---

## Related

- [[CISSP - Index]] — all 8 CISSP domains
- [[Cyber Security]] — top-level cybersecurity note
