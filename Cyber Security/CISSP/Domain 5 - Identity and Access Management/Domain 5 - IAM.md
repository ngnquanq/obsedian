---
tags: [cissp, domain-5-iam, moc, identity, access-management]
aliases: [CISSP Domain 5, IAM Domain, Identity and Access Management]
---

# CISSP Domain 5 — Identity and Access Management

Identity and Access Management (IAM) ensures the right people have the right access to the right resources at the right time. Domain 5 covers the full lifecycle: from proving identity, to granting access, to reviewing and revoking it.

---

## CISSP Domain 5 Subtopics

| Subtopic | What It Covers | Notes in This Vault |
|---|---|---|
| **5.1** Control physical and logical access | Access control models, physical access, least privilege | [[Physical-vs-Logical-Access]], [[IAM-Overview]], [[what-is-pam]], [[CyberArk-IIQ-Integration]] |
| **5.2** Identification & Authentication | Passwords, MFA, Kerberos, LDAP bind, biometrics | [[AD-LDAP-Fundamentals]], [[AD-Application-Integration]] |
| **5.3** Federated Identity | SAML, OAuth, OIDC, domain trusts, cross-forest | [[AD-Domain-Forest-Trusts]], [[AD-Application-Integration]] |
| **5.4** Authorization mechanisms | RBAC, ABAC, ACLs, group-based access | [[AD-Application-Integration]], [[AD-File-Shares-NAS-DFS]], [[AD-Groups-in-IIQ-Governance]] |
| **5.5** Provisioning lifecycle | JML (Joiner-Mover-Leaver), access requests, certifications | [[IIQ-Concepts]], [[IIQ-Data-Flows]], [[IIQ-AD-LDAP-Connector]] |
| **5.6** Authentication systems | SSO, Kerberos, RADIUS, TACACS+ | [[AD-Application-Integration]] |

---

## Reading Path

Start here if you're new to IAM:

```
1. IAM-Overview              — understand the technology stack and where each tool fits
2. AD-LDAP-Fundamentals      — understand directories, groups, and AD itself
3. AD-Domain-Forest-Trusts   — understand cross-domain topology (key for 5.3)
4. AD-Application-Integration    — understand how apps consume AD (key for 5.2, 5.4, 5.6)
5. AD-File-Shares-NAS-DFS    — file share access model: NAS, DFS, UNC, NTFS ACLs (builds on step 4)
6. IIQ-Concepts              — understand governance tooling (key for 5.5)
7. IIQ-Data-Flows            — understand the provisioning and certification flows
8. AD-Groups-in-IIQ-Governance   — tie everything together
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

Standalone reference for CyberArk Self-Hosted PAM, focused on data model, architecture, and dashboarding via Power BI. Primarily maps to CISSP 5.1 (control of privileged access) and 5.4 (authorization for shared/admin accounts). Onboarded from the dedicated CyberArk-Document repo.

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
