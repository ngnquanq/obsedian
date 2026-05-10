---
tags: [active-directory, ldap, authorization, kerberos, saml, application-integration, access-control, cissp, domain-5-iam, cissp/5.2-identification-authentication, cissp/5.4-authorization]
aliases: [How Apps Use AD, AD Authorization Mechanisms, AD Group Application Access]
---

# How Applications Use AD Groups for Access Control

A common point of confusion: you add a user to an AD group, and suddenly they can access an application. But **how** does the application know? Does it talk to AD? Does AD push something? Who initiates the check?

The answer depends on the type of application and the integration pattern it uses. There are four main patterns.

---

## Pattern 1: Windows Native — The Kerberos Security Token

This is the most seamless pattern, used by Windows-native resources: file shares, SQL Server, IIS web apps with Windows Authentication, RDP, printers.

**The key insight: the application never queries AD at access time.** Group membership is embedded into the user's session at *login time*.

### How it works

```
1. User logs in to Windows workstation with AD credentials
        │
        ▼
2. AD (Kerberos KDC) issues a Ticket Granting Ticket (TGT)
   The TGT contains a PAC (Privilege Attribute Certificate)
   The PAC lists ALL the user's group SIDs
        │
        ▼
3. User opens a file share \\fileserver\finance
        │
        ▼
4. Windows requests a Service Ticket for the file server
   The Service Ticket also contains the user's group SIDs
        │
        ▼
5. File server receives the ticket
   It reads the SIDs from the PAC
   It compares them against the ACL on the \finance share
   ACL says: "SID of SG-Finance-Read → allow Read"
   User's token contains that SID → Access granted
        │
        ▼
6. No AD query needed at step 5 — the answer was in the ticket
```

**The ACL (Access Control List)** is a list stored on the resource (file, folder, printer, registry key). Each entry in the ACL maps a **SID** (Security Identifier — the permanent ID of a user or group) to a permission level.

```
Finance Share ACL:
  SID of "SG-Finance-Read"  → Read
  SID of "SG-Finance-Write" → Read, Write
  SID of "Domain Admins"    → Full Control
```

> [!tip] Why SIDs not names?
> ACLs store SIDs, not group names. If you rename a group from `SG-Finance-Read` to `GRP-FIN-READ`, the ACL still works because the SID never changes. This is why `objectSID` is so important in AD.

> [!note] Token size limit — the 1015 group problem
> A Kerberos ticket has a size limit. If a user is in more than ~1015 groups (including nested ones), the token exceeds the limit and the user gets access denied errors. This is a real enterprise problem in large organisations with heavy group nesting.

> [!note] File share architecture in depth
> For NAS devices, DFS namespaces, NTFS vs. share permissions, and how AD groups are structured on file share ACLs, see [[AD-File-Shares-NAS-DFS]].

---

## Pattern 2: LDAP Bind — The App Queries AD Directly

Used by: web applications, Linux services, custom-built apps, many enterprise software products (SAP, Oracle, older Java EE apps).

The application itself acts as an LDAP client. It connects to AD, verifies the user's credentials, and reads their group memberships.

### How it works

```
1. User opens the application (e.g. internal web app) and enters
   their AD username (jsmith) and password
        │
        ▼
2. App connects to AD on port 389 (or 636 for LDAPS)
   using a service account (bind DN): CN=svc-webapp,DC=corp,...
        │
        ▼
3. App does an LDAP bind attempt as the user:
   "Try to authenticate CN=jsmith with this password"
   If the bind succeeds → password is correct
   If bind fails → wrong password or account locked
        │
        ▼
4. App queries AD for the user's group memberships:
   Filter: (&(objectClass=user)(sAMAccountName=jsmith))
   Returns: memberOf attribute with list of group DNs
        │
        ▼
5. App checks its internal config:
   "If user is in CN=SG-Finance-Read,... → grant Finance role"
   "If user is in CN=SG-Admin,... → grant Admin role"
        │
        ▼
6. User is logged in with the mapped roles
```

> [!warning] App config must match AD group names
> The mapping from AD group → application role is configured **inside the application**, not in AD. If someone renames the AD group, the application breaks until the config is updated. This is a common source of incidents.

### What the mapping looks like (conceptually)

In the application's config file or database:

```yaml
# Example: web app role mapping
ldap_group_role_mapping:
  "CN=SG-Finance-Read,OU=Groups,DC=corp,DC=example,DC=com": "finance_viewer"
  "CN=SG-Finance-Write,OU=Groups,DC=corp,DC=example,DC=com": "finance_editor"
  "CN=SG-AppAdmin,OU=Groups,DC=corp,DC=example,DC=com": "administrator"
```

This is exactly the layer that [[IIQ-AD-LDAP-Connector|IIQ's AD connector]] mimics — it does an LDAP bind with a service account and reads `memberOf` to build [[AD-Groups-in-IIQ-Governance|the entitlement picture]].

---

## Pattern 3: Federation / SSO — The Identity Provider (IdP) Layer

Used by: modern web apps (SaaS and internal), cloud applications, apps that support SAML 2.0 or OAuth2/OIDC.

The application does **not** talk to AD directly. Instead, a dedicated **Identity Provider (IdP)** sits in the middle. The IdP authenticates against AD and then issues a token (SAML assertion or JWT) that the application trusts.

```
Common IdPs that federate with AD:
  ADFS (Active Directory Federation Services) — Microsoft's own
  Azure AD / Entra ID — Microsoft's cloud IdP
  Okta — popular third-party IdP
  Ping Identity — enterprise IdP
```

### How it works (SAML example)

```
1. User clicks "Login" on the app (e.g. Workday, ServiceNow, a custom portal)
        │
        ▼
2. App redirects user to the IdP (e.g. ADFS login page)
        │
        ▼
3. IdP authenticates user against AD (LDAP bind or Kerberos)
        │
        ▼
4. IdP reads user's AD group memberships
   IdP maps AD groups to "claims" (key-value pairs):
     AD group "SG-Workday-HR" → claim "role=HRManager"
        │
        ▼
5. IdP issues a SAML Assertion (a signed XML document):
   <saml:Attribute Name="role">
     <saml:AttributeValue>HRManager</saml:AttributeValue>
   </saml:Attribute>
        │
        ▼
6. User's browser POSTs the SAML assertion to the app
        │
        ▼
7. App validates the signature (trusts the IdP's certificate)
   App reads the "role" claim: HRManager
   App grants HR Manager access
   App never spoke to AD at all
```

> [!tip] Why federation is preferred for modern apps
> - The app never handles AD credentials — it only sees the signed token
> - Group-to-claim mapping is centralised in the IdP, not scattered across dozens of apps
> - MFA, conditional access, and risk-based policies can be enforced at the IdP layer
> - SaaS apps hosted externally can use AD credentials without exposing AD to the internet

### AD Groups in SAML Claims

The IdP is configured with a **claim rule** like:

```
IF user is member of "SG-Workday-HR"
THEN issue claim Role = "HRManager"
```

This claim rule is the configuration layer that connects AD group membership to application roles. It lives in the IdP (ADFS, Azure AD, Okta) — not in AD itself, and not in the application.

---

## Pattern 4: SSH / PAM — Linux System Access via AD

For Linux servers (covered briefly in [[AD-LDAP-Fundamentals#What About macOS and Linux?|AD-LDAP-Fundamentals]]), access control works through **PAM (Pluggable Authentication Modules)** and SSSD.

```
1. Admin configures: realm join corp.example.com (via realmd + SSSD)
2. Admin configures which AD groups can SSH in:
   realm permit -g SG-Linux-Admins@corp.example.com
        │
        ▼
3. User SSH's to the server: ssh jsmith@corp.example.com@linuxserver
        │
        ▼
4. PAM calls SSSD, which queries AD via LDAP
   Checks: is jsmith in SG-Linux-Admins?
   Yes → authentication proceeds
   No → access denied
        │
        ▼
5. sudo access can also be mapped to AD groups via /etc/sudoers
   or sssd sudo rules
```

---

## Summary: Which Pattern Does Each Application Use?

| Application Type | Pattern | Who Queries AD |
|---|---|---|
| Windows file shares, printers | Kerberos ACL | OS at login — app just checks the token |
| SQL Server (Windows Auth) | Kerberos ACL | OS at login |
| IIS / Windows web apps | Kerberos ACL | OS at login |
| Custom web apps (internal) | LDAP bind | The app itself, at each login |
| SAP, Oracle E-Business Suite | LDAP bind | The app itself |
| Workday, ServiceNow, Salesforce | SAML / OIDC | The IdP (ADFS, Azure AD, Okta) |
| Linux SSH | PAM + SSSD | SSSD daemon, at login |
| SailPoint IIQ (connector) | LDAP bind | IIQ's AD connector, during aggregation |

---

## How This Connects Back to IIQ

IIQ fits into this picture in two ways:

**1. IIQ as an LDAP client (aggregation)**
IIQ's AD connector uses Pattern 2 (LDAP bind) to read accounts and group memberships. It doesn't grant access — it *reads* what access already exists and brings it into IIQ's governance model.

**2. IIQ as a provisioning engine**
When IIQ grants or revokes an entitlement (after an access request or certification), it writes back to AD via LDAP — adding or removing a user from a group's `member` attribute. The actual access change in the application then happens automatically through whichever pattern (1–4) that application uses.

```
IIQ approves access request for "SG-Finance-Read"
    │
    ▼
IIQ LDAP writes: adds user DN to SG-Finance-Read.member
    │
    ▼
If Pattern 1 (Kerberos): user's next login gets updated token with new SID
If Pattern 2 (LDAP bind): next app login → LDAP query returns new group
If Pattern 3 (SAML): next SSO → IdP sees new group → issues updated claim
If Pattern 4 (PAM/SSH): SSSD cache refreshes → user can now SSH in
```

> [!note] Access is not always instant
> Adding a user to an AD group in IIQ takes effect the next time the application checks group membership — which depends on the pattern:
> - Pattern 1 (Kerberos): requires the user to log out and back in (new Kerberos ticket)
> - Pattern 2 (LDAP bind): effective on next application login
> - Pattern 3 (SAML): effective on next SSO session
> - Pattern 4 (PAM): effective within the SSSD cache TTL (usually 5–20 minutes)

---

## Related

- [[IAM-Overview]] — the authorization layer in the IAM stack
- [[AD-LDAP-Fundamentals]] — what AD groups are and how membership is stored
- [[AD-Domain-Forest-Trusts]] — how groups work across domains
- [[AD-File-Shares-NAS-DFS]] — NAS devices, DFS namespaces, NTFS vs. share permissions, AGDLP on file share ACLs
- [[Kerberos-Protocol]] — Pattern 1 deep dive: KDC, TGT, Service Ticket, PAC, AES, NTP dependency
- [[SAML-Federation]] — Pattern 3 deep dive: SAML 2.0 assertion types, IDaaS, SP/IdP-initiated flows, WS-Federation
- [[OAuth2-OIDC]] — Pattern 3 continuation: OAuth 2.0 grant types, OIDC authentication layer, JWT
- [[RADIUS-TACACS-Diameter]] — network device authentication (AAA) — the pattern behind VPN and 802.1X
- [[IIQ-AD-LDAP-Connector]] — how IIQ uses LDAP to read from AD
- [[AD-Groups-in-IIQ-Governance]] — how IIQ governs and provisions AD group membership
