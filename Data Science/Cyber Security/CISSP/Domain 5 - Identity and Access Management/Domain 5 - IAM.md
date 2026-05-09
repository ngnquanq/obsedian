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
| **5.1** Control physical and logical access | Access control models, physical access, least privilege | [[IAM-Overview]], [[CyberArk-IIQ-Integration]] |
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

## Related

- [[CISSP - Index]] — all 8 CISSP domains
- [[Cyber Security]] — top-level cybersecurity note
