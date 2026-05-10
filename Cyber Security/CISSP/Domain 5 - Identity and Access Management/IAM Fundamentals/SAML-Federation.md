---
tags: [saml, federation, sso, adfs, idaas, idp, sp, ws-federation, idp-initiated, sp-initiated, jit, cissp, domain-5-iam, cissp/5.3-federated-identity, cissp/5.6-authentication-systems]
aliases: [SAML 2.0 Deep Dive, Federated Identity, IDaaS, Identity Federation, SAML Assertions, ADFS Federation]
---

# SAML and Federated Identity

[[AD-Application-Integration|Pattern 3 in the application integration note]] introduces SAML at the use-case level: an IdP authenticates against AD and issues a signed assertion that the service provider trusts. This note goes deeper — covering the three assertion types, both flow directions, SAML metadata, deployment models, and the broader federated identity landscape including IDaaS and WS-Federation.

---

![[SAML-Flow.excalidraw.md]]

---

## The Federation Problem

A company using 40 SaaS applications faces a problem without federation:
- Each app has its own username/password database
- Users manage 40 separate passwords (or use the same weak one everywhere)
- When someone leaves, IT must disable 40 accounts — and misses some
- No central audit log of who accessed what

**Federation solves this by establishing trust between the organisation's identity system and the applications**, so users authenticate once and applications accept the result.

> [!tip] Mental model
> Federation is like an international passport. Your government (IdP) vouches for who you are. The other country (Service Provider) accepts that voucher without needing its own proof — because they trust the issuing government.

---

## The Three Federation Participants

| Participant | Role | Example |
|---|---|---|
| **Principal / User** | The human or service requesting access | Employee Alice |
| **Identity Provider (IdP)** | Authenticates the principal; issues the assertion/token | ADFS, Azure AD/Entra ID, Okta, Ping Identity |
| **Service Provider (SP) / Relying Party** | Provides the service; trusts the IdP's assertion | Workday, ServiceNow, Salesforce, custom app |

The SP never receives Alice's password. It only receives a signed statement from the IdP: "Alice authenticated successfully at 09:15 using MFA, and she has these attributes."

---

## SAML 2.0 — The Enterprise Federation Standard

**Security Assertion Markup Language (SAML) 2.0** is an XML-based open standard for exchanging authentication and authorisation information between federated parties. It is maintained by **OASIS** (Organization for the Advancement of Structured Information Standards) and is the dominant protocol for enterprise SSO.

### The Three Assertion Types

Every SAML response contains one or more assertions — cryptographically signed XML statements:

**1. Authentication Assertion**
Proves the principal authenticated, when, and how:
```xml
<saml:AuthnStatement AuthnInstant="2024-05-10T09:15:00Z"
                     SessionIndex="_abc123">
  <saml:AuthnContext>
    <saml:AuthnContextClassRef>
      urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport
    </saml:AuthnContextClassRef>
  </saml:AuthnContext>
</saml:AuthnStatement>
```

**2. Attribute Assertion**
Carries user properties the SP needs:
```xml
<saml:AttributeStatement>
  <saml:Attribute Name="email">
    <saml:AttributeValue>alice@corp.example.com</saml:AttributeValue>
  </saml:Attribute>
  <saml:Attribute Name="role">
    <saml:AttributeValue>HRManager</saml:AttributeValue>
  </saml:Attribute>
  <saml:Attribute Name="department">
    <saml:AttributeValue>Human Resources</saml:AttributeValue>
  </saml:Attribute>
</saml:AttributeStatement>
```

**3. Authorisation Decision Assertion**
States whether the principal is permitted to access a specific resource:
```xml
<saml:AuthzDecisionStatement Resource="https://hrapp.corp.com/payroll"
                               Decision="Permit"/>
```
Less commonly used — most SPs handle authorisation internally after receiving the Authentication and Attribute assertions.

---

## SP-Initiated Flow (Most Common)

The user tries to access the SP first; the SP redirects to the IdP.

```
1. Alice goes to https://workday.corp.example.com
        │
        ▼
2. Workday (SP) detects no session; redirects to IdP:
   GET https://adfs.corp.example.com/adfs/ls/
       ?SAMLRequest=<base64-encoded AuthnRequest>
       &RelayState=https://workday.corp.example.com/dashboard
        │
        ▼
3. IdP (ADFS/Azure AD) presents login page
   Alice enters credentials + MFA
        │
        ▼
4. IdP authenticates Alice against AD
   IdP reads Alice's group memberships
   IdP applies claim rules: SG-Workday-HR → role=HRManager
        │
        ▼
5. IdP generates SAML Response (signed XML containing assertions)
   IdP POSTs response to Workday's Assertion Consumer Service (ACS) URL:
   POST https://workday.corp.example.com/saml/acs
   Body: SAMLResponse=<base64-encoded signed XML>
         RelayState=https://workday.corp.example.com/dashboard
        │
        ▼
6. Workday (SP) validates:
   a. Signature using IdP's public certificate (from metadata)
   b. Assertion is within validity window (NotBefore / NotOnOrAfter)
   c. Audience matches Workday's entity ID
        │
        ▼
7. Workday creates local session; Alice lands on /dashboard
```

---

## IdP-Initiated Flow

The user authenticates at the IdP first, then launches the SP from the IdP portal.

```
1. Alice logs into the IdP portal (e.g., myapps.microsoft.com)
        │
        ▼
2. Alice clicks "Workday" tile in the portal
        │
        ▼
3. IdP generates a SAML Response (unsolicited — no AuthnRequest)
   POSTs directly to Workday's ACS URL
        │
        ▼
4. Workday validates the response and creates a session
```

> [!note] SP-initiated is preferred for security
> IdP-initiated flows bypass the SP's opportunity to set state (RelayState) and prevent CSRF attacks. SP-initiated with RelayState validation is the more secure pattern for new integrations.

---

## SAML Bindings — How Assertions Travel

A binding defines the transport mechanism for SAML messages.

| Binding | How It Works | When Used |
|---|---|---|
| **HTTP Redirect** | SAML message base64-encoded and placed in URL query string (deflate-compressed) | AuthnRequest (SP → IdP): message is small |
| **HTTP POST** | SAML message base64-encoded in a hidden HTML form field; browser auto-POSTs | SAML Response (IdP → SP): assertions are large and must be signed |
| **Artifact** | Only a reference (artifact) sent via redirect; SP retrieves full message from IdP via backchannel SOAP | Environments where POST cannot be used |

---

## SAML Metadata — How Trust Is Established

Before any user can log in, the IdP and SP must exchange metadata — XML documents that describe each party:

**IdP metadata includes:**
- Entity ID (unique identifier for the IdP)
- SingleSignOnService endpoint URLs (where the SP should send AuthnRequests)
- Signing certificate (public key) — SP uses this to verify assertion signatures
- Supported name ID formats

**SP metadata includes:**
- Entity ID (unique identifier for the SP)
- AssertionConsumerService URL (where the IdP should POST the SAML Response)
- SP certificate (if SP signs AuthnRequests)
- Requested attribute list

> [!important] Metadata = the trust relationship
> Without metadata exchange, the SP cannot verify the IdP's signature and the IdP does not know where to send the response. Metadata is usually exchanged as a file import or via a well-known URL during integration setup.

---

## Signature Validation

The SAML Response and its assertions are signed by the IdP using its private key. The SP must:
1. Retrieve the IdP's public certificate (from metadata)
2. Verify the XML signature over the assertion
3. Reject the assertion if the signature is invalid or the certificate is expired

This prevents any third party from forging assertions — only the genuine IdP possesses the private key.

---

## Claim Rules — Mapping AD Groups to SAML Attributes

The IdP is configured with **claim rules** (or attribute mappings) that translate AD group membership into SAML attribute values:

```
IF user is member of SG-Workday-HR
THEN issue claim: role = "HRManager"

IF user is member of SG-Workday-Payroll
THEN issue claim: role = "PayrollAdmin"

ALWAYS issue: email = user.mail
ALWAYS issue: displayName = user.displayName
```

These rules live in the IdP configuration (ADFS claim rules, Azure AD attribute mappings, Okta attribute statements) — not in AD itself, and not in the SP. They are the critical layer connecting directory groups to application roles.

---

## Deployment Models

### On-Premises Federation
- IdP: **Active Directory Federation Services (ADFS)** running on Windows Server
- Authentication source: on-premises Active Directory
- Users authenticate to ADFS with their AD credentials (Kerberos or form-based)
- SPs: mostly SaaS apps (Workday, ServiceNow) configured to trust the ADFS IdP
- Organisation retains full control; requires internal infrastructure

### Cloud Federation (IDaaS)
**IDaaS (Identity as a Service)** delivers federation entirely from the cloud.

Common IDaaS providers: Azure Active Directory / Entra ID, Okta, Ping Identity, OneLogin, JumpCloud

**IDaaS capabilities:**
- Provisioning and deprovisioning
- SSO (SAML, OIDC, WS-Federation)
- MFA (push, TOTP, hardware keys)
- Directory services (cloud directory or sync from on-prem)
- Adaptive access / conditional access policies

**IDaaS risks:**
| Risk | Detail |
|---|---|
| **Third-party availability** | If the IDaaS is down, users cannot log into anything |
| **Data sovereignty** | Identity data stored in the cloud provider's infrastructure |
| **Information leakage** | Authentication logs, user attributes, and access patterns held by a third party |
| **Trust dependency** | The organisation trusts the IDaaS vendor's security posture completely |

### Hybrid Federation
- Identity originates on-premises (AD)
- Synchronised to a cloud IdP via **Azure AD Connect** (or similar)
- The cloud IdP acts as the federation authority for SaaS apps
- Most common enterprise pattern: AD → Azure AD Connect sync → Azure AD/Entra ID → SaaS apps
- Most complex: requires managing both on-prem AD and cloud directory consistency

---

## WS-Federation

**WS-Federation** is Microsoft's older federation protocol, built on the WS-Trust and WS-Security SOAP-based web service standards. It predates SAML 2.0 as a web SSO standard.

| Dimension | WS-Federation | SAML 2.0 |
|---|---|---|
| **Format** | SOAP/XML | XML (simpler than WS-*) |
| **Maintained by** | OASIS | OASIS |
| **Primary user** | Microsoft ADFS, Microsoft-centric stacks | Broad industry |
| **Token types** | SAML tokens (ironically), JWT, X.509 | SAML assertions |
| **Status** | Legacy; superseded by SAML 2.0 + OIDC | Current enterprise standard |

WS-Federation is still found in older ADFS-based SSO integrations and legacy Microsoft applications. New integrations should use SAML 2.0 or OIDC.

---

## Just-In-Time (JIT) Provisioning via SAML

SAML enables JIT provisioning: the SP creates a user account on first successful authentication, using attributes from the assertion.

```
Alice logs into Salesforce for the first time (SP-initiated)
    │
    ▼
IdP authenticates Alice; issues assertion with:
  email=alice@corp.example.com, name=Alice Smith, role=SalesRep
    │
    ▼
Salesforce receives assertion; checks local database
"No account for alice@corp.example.com"
    │
    ▼
JIT: Salesforce creates Alice's account:
  Username: alice@corp.example.com
  Profile: SalesRep (mapped from role attribute)
    │
    ▼
Alice is logged in; account persists for future sessions
```

JIT eliminates the need to pre-provision accounts in every SaaS tool. However, **de-provisioning is not automatic** — the account is only created on login, not deleted on logout. Explicit deprovisioning (SCIM or manual process) is required when Alice leaves.

---

## SAML vs OIDC Summary

| Question | SAML | OIDC |
|---|---|---|
| Format | XML assertions | JWT tokens |
| Transport | HTTP Redirect / POST | REST / JSON |
| SSO for web apps | Yes | Yes |
| Mobile / SPA support | Poor (XML in URLs/forms) | Good (JSON, REST) |
| JIT provisioning | Yes | Yes |
| Preferred for new apps | Legacy enterprise | Modern apps |

For OAuth 2.0 and OIDC details, see [[OAuth2-OIDC]].

---

## Related

- [[AD-Application-Integration]] — Pattern 3: how ADFS and Azure AD broker SAML assertions from AD group memberships
- [[OAuth2-OIDC]] — OIDC as the modern alternative to SAML for authentication; OAuth 2.0 for authorisation
- [[Kerberos-Protocol]] — Kerberos as the on-premises equivalent; cross-realm trusts vs. federation
- [[Authentication-Factors-MFA]] — MFA enforcement at the IdP layer; SSO concepts; JIT provisioning
- [[IAM-Overview]] — federated identity in the IAM stack; ADFS, Azure AD, Okta as IdP tools
