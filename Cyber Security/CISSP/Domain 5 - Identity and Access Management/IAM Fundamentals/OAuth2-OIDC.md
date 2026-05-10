---
tags: [oauth2, oidc, jwt, federation, authorization, authentication, delegated-access, tokens, cissp, domain-5-iam, cissp/5.3-federated-identity, cissp/5.6-authentication-systems]
aliases: [OAuth 2.0 OIDC, OpenID Connect, JWT Tokens, Delegated Authorization, OAuth vs SAML]
---

# OAuth 2.0 and OpenID Connect (OIDC)

[[AD-Application-Integration|Pattern 3 in the application integration note]] mentions SAML and OAuth/OIDC in the same sentence, which creates a common confusion: people treat them as interchangeable. They are not. OAuth 2.0 is an **authorization** framework; OIDC adds an **authentication** layer on top of it. This note explains both, how they relate, and how they differ from [[SAML-Federation|SAML]].

---

## The Problem OAuth Solves

Imagine you want a calendar app to read your contacts from Google. Before OAuth, the only option was to give the calendar app your Google password. The app then had full access to your entire Google account — and stored your password, which became a breach target.

**OAuth solves this with delegated access:** the calendar app gets a scoped, time-limited token that permits only contact reads. You never give your password to the app. You can revoke the token at any time without changing your password.

> [!tip] The hotel key card analogy
> Your hotel room key (token) opens your room (scoped resource) for three days (time-limited). It doesn't give the cleaner your home address or bank account. When you check out, the key stops working — without changing any lock.

---

## OAuth 2.0 — Authorization Framework

**OAuth 2.0 is about authorisation (access delegation), not authentication.** The standard is defined in RFC 6749 and maintained by the IETF.

### The Four Roles

| Role | What It Is | Example |
|---|---|---|
| **Resource Owner** | The entity that owns the data | You (the user) |
| **Client** | The application requesting access | Calendar app, mobile game |
| **Resource Server** | The API holding the protected data | Google Contacts API |
| **Authorization Server** | Issues tokens; verifies Resource Owner's consent | Google's auth service, Azure AD, Okta |

### Access Tokens vs. Refresh Tokens

| Token | Purpose | Lifetime |
|---|---|---|
| **Access Token** | Presented to the Resource Server to access data | Short (minutes to hours) |
| **Refresh Token** | Presented to the Authorization Server to get a new Access Token | Long (days to months) |

Short access token lifetimes limit the window of exposure if a token is stolen.

### The Four Grant Types

Different scenarios call for different ways to obtain an access token:

**1. Authorization Code (most secure — use by default)**
```
User clicks "Connect with Google" in calendar app
    │
    ▼
Calendar app redirects to Google's Authorization Server
    │  (includes: client_id, redirect_uri, scope=contacts.read, state=random)
    ▼
User authenticates at Google; sees consent screen
    │  "Allow Calendar App to read your contacts? YES / NO"
    ▼
Google redirects back to calendar app with Authorization Code
    │  (short-lived, single-use code)
    ▼
Calendar app exchanges Authorization Code for Access Token + Refresh Token
    │  (server-to-server; code never travels in URLs)
    ▼
Calendar app uses Access Token to call Google Contacts API
```
- Most secure: the access token never appears in a URL or browser history
- **PKCE** (Proof Key for Code Exchange): extension that prevents interception for mobile apps and SPAs (single-page apps) where a client secret cannot be kept

**2. Client Credentials (machine-to-machine)**
```
Service A (no user involved)
    │  client_id + client_secret
    ▼
Authorization Server issues Access Token directly
    │
    ▼
Service A calls Service B's API
```
- Used for microservices, background jobs, server-to-server API calls
- No user in the flow

**3. Device Code (devices with limited input)**
```
Smart TV wants to access streaming service
    ▼
TV displays: "Go to example.com/activate and enter code: BCDF-GHKM"
    ▼
User goes to URL on phone/browser, logs in, enters code
    ▼
TV polls the Authorization Server; receives Access Token once user approves
```
- Used for smart TVs, game consoles, CLI tools, IoT devices

**4. Implicit (deprecated)**
- Access token returned directly in the URL fragment (never in a POST body)
- Replaced by Authorization Code + PKCE
- Do not use for new systems; vulnerable to token leakage in browser history and Referer headers

---

## OpenID Connect (OIDC) — Authentication Layer

OAuth 2.0 issues access tokens that prove the holder is *authorised* to access a resource, but the resource server does not know *who the user is*. OpenID Connect adds identity.

**OIDC = OAuth 2.0 + identity.**

OIDC is maintained by the OpenID Foundation (not IETF). It defines:
- Standard OAuth 2.0 scopes for identity: `openid`, `profile`, `email`, `address`, `phone`
- The **ID Token** (a JWT) containing user identity claims
- The **UserInfo endpoint** to fetch additional user attributes

### The ID Token (JWT)

When a user authenticates with OIDC, in addition to the Access Token, the Authorization Server issues an **ID Token** — a **JSON Web Token (JWT)** containing who the user is.

**JWT structure:** three base64url-encoded parts separated by dots: `header.payload.signature`

```json
Header:
{
  "alg": "RS256",
  "typ": "JWT"
}

Payload (claims):
{
  "iss": "https://accounts.google.com",    ← Issuer (who created this token)
  "sub": "110169484474386276334",          ← Subject (unique user ID)
  "aud": "client_id_of_calendar_app",     ← Audience (which app this is for)
  "exp": 1716239022,                       ← Expiry (Unix timestamp)
  "iat": 1716235422,                       ← Issued At
  "email": "alice@example.com",
  "name": "Alice Smith"
}

Signature: RS256(base64(header) + "." + base64(payload), private_key)
```

The receiving application verifies the signature using the issuer's public key (fetched from a well-known endpoint). If the signature is valid and `exp` is in the future, the user identity is trusted.

### OIDC Flow (Authorization Code + OIDC)

```
1. User clicks "Sign in with Google" on an app
2. App redirects to Google with scope=openid profile email
3. User authenticates at Google
4. Google returns Authorization Code to app
5. App exchanges code for:
   - Access Token (to call Google APIs)
   - ID Token (JWT: who the user is)
6. App validates ID Token signature; reads sub, email, name
7. App knows who the user is — authentication complete
8. App may call UserInfo endpoint for additional claims
```

---

## OAuth vs SAML vs OIDC — Comparison

| Dimension | SAML 2.0 | OAuth 2.0 | OpenID Connect |
|---|---|---|---|
| **Primary purpose** | Authentication + authorisation | Authorisation (delegated access) | Authentication (identity layer on OAuth) |
| **Token format** | XML assertion | Opaque Bearer token | JWT (ID Token) |
| **Transport** | HTTP Redirect / POST | REST / JSON | REST / JSON |
| **Maintained by** | OASIS | IETF | OpenID Foundation |
| **Primary use case** | Enterprise SSO, SaaS federation | API access delegation, mobile apps | Modern web app login |
| **MFA support** | Via IdP (before assertion) | Via Authorization Server | Via Authorization Server |
| **JIT provisioning** | Yes (via attributes in assertion) | Not native | Yes (via ID Token claims) |
| **Best for** | Enterprise B2B federation | "Login with Google/GitHub" flows | Modern SaaS app authentication |

> [!note] When to use which
> **SAML**: existing enterprise SSO, ADFS, legacy SaaS that only speaks SAML. **OIDC**: new apps, mobile apps, APIs. **OAuth 2.0**: API delegation (your app calling another app's API on behalf of a user). In practice, modern IdPs (Azure AD, Okta) support all three.

---

## Security Considerations

| Risk | Mitigation |
|---|---|
| **Token theft** (bearer tokens are like cash — whoever holds them can use them) | Short access token lifetime; HTTPS; token binding |
| **Authorization Code interception** (code stolen in redirect) | PKCE (Proof Key for Code Exchange) required for public clients |
| **Open redirect** | Strict redirect_uri validation — only pre-registered URIs accepted |
| **Scope creep** | Apply principle of least privilege to OAuth scopes; request only what's needed |
| **Refresh token compromise** | Rotate refresh tokens on use; absolute expiry |
| **JWT algorithm confusion** | Validate `alg` claim; reject `none`; use asymmetric signing (RS256) not symmetric (HS256) for public consumption |

---

## Related

- [[SAML-Federation]] — SAML for enterprise SSO; comparison of SAML vs OIDC; when to use which
- [[Authentication-Factors-MFA]] — MFA at the Authorization Server; SSO via OIDC; JIT provisioning
- [[Kerberos-Protocol]] — Kerberos as the equivalent of OIDC for Windows-native environments
- [[AD-Application-Integration]] — Pattern 3: how SAML and OIDC integrate with AD via an IdP
- [[IAM-Overview]] — federated identity as part of the broader IAM stack
- [[AI-Agent-Identity-and-IAM]] — how delegated scopes and token-based access change when an autonomous agent acts for a user or task
