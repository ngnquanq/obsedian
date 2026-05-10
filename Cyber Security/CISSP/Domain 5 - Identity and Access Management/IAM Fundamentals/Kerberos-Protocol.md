---
tags: [kerberos, authentication, sso, tickets, symmetric-cryptography, kdc, tgt, aes, cissp, domain-5-iam, cissp/5.6-authentication-systems, cissp/5.2-identification-authentication]
aliases: [Kerberos Deep Dive, Kerberos Protocol, KDC TGT Service Ticket, Ticket-Based Authentication]
---

# Kerberos — Ticket-Based Authentication Protocol

[[AD-Application-Integration|Pattern 1 in the application integration note]] shows Kerberos working at a high level — a user logs in, gets a ticket, and the file server reads the ticket to grant access. This note explains *how that ticket is created*, what's inside it, and why the mechanism is secure. This is the depth required for CISSP Domain 5.6.

---

![[Kerberos-Flow.excalidraw.md]]

---

## Why Kerberos Exists — The Problem It Solves

Before Kerberos, a user connecting to a network service would send their password to that service for verification. This creates two catastrophic problems:

1. **Passwords travel over the network** — any eavesdropper on the path captures them
2. **Every service stores passwords** — 200 services means 200 copies of the password database to protect

**Kerberos solves this by ensuring the user's password never travels over the network — not even once.**

Instead, Kerberos issues **tickets** — cryptographically signed tokens that prove the holder authenticated at a certain time. Services trust the ticket without ever seeing the password.

> [!tip] Mental model
> Kerberos is like a concert wristband system. You prove your identity at the gate (KDC), receive a wristband (TGT). At each stage (bar, VIP area), you show the wristband — staff don't re-check your ID. The wristband expires at midnight.

---

## Key Components

| Component | What It Is | Role |
|---|---|---|
| **KDC** (Key Distribution Center) | Trusted server — usually a Domain Controller in AD | The central authority; runs both the AS and TGS |
| **AS** (Authentication Service) | Service running on the KDC | Verifies initial credentials; issues TGT |
| **TGS** (Ticket-Granting Service) | Service running on the KDC | Exchanges TGT for Service Tickets |
| **TGT** (Ticket-Granting Ticket) | Encrypted token issued by AS | Proves the user authenticated; used to request Service Tickets |
| **Service Ticket (ST)** | Encrypted token issued by TGS | Authorises access to one specific service |
| **PAC** (Privilege Attribute Certificate) | Data structure embedded in tickets | Contains the user's group SIDs — how authorisation happens |
| **Kerberos Principal** | Any entity that can request tickets | Users, services, computers |
| **Kerberos Realm** | Logical administrative domain | Corresponds to an AD domain (`CORP.EXAMPLE.COM`) |

**Port:** `88` (UDP by default; TCP used when tickets exceed UDP packet size)

---

## Cryptographic Foundation

Kerberos uses **symmetric-key cryptography**. Every principal shares a long-term secret key with the KDC:

- **User's key**: derived from the user's password hash (AES by default in modern Kerberos)
- **Service's key**: a shared secret between the service and the KDC (stored as a keytab file on the service host)
- **KDC's own key**: used to encrypt TGTs (the `krbtgt` account password in AD)

**Encryption standard**: AES (Advanced Encryption Standard) — specifically AES-128 or AES-256. Older deployments may still use RC4-HMAC (deprecated, weak).

**NTP dependency**: Every Kerberos ticket contains a timestamp. The KDC rejects tickets if the clock skew between client and KDC exceeds **5 minutes** (default). This prevents replay attacks — a captured ticket cannot be replayed hours later.

> [!warning] NTP failure = Kerberos failure
> If an AD Domain Controller's NTP sync fails and clocks drift past 5 minutes, users start getting "clock skew too great" authentication errors. This is a real operational incident cause.

---

## The Full Authentication Flow

### Phase 1 — Initial Authentication (AS Exchange)

```
Client (user's workstation)                   KDC (Authentication Service)

1. User types username + password
   Client does NOT send the password
   Client sends: username in plaintext
                                               │
                                               ▼
                                    KDC looks up user's key
                                    (derives same key from stored hash)

2. KDC generates:
   - Session Key (random, used between client and TGS)
   - TGT (Ticket-Granting Ticket)

   KDC sends:
   ┌─────────────────────────────┐
   │ Session Key                 │ ← encrypted with user's key (only client can open)
   └─────────────────────────────┘
   ┌─────────────────────────────┐
   │ TGT:                        │ ← encrypted with KDC's krbtgt key
   │  - Client identity          │   (client CANNOT open this)
   │  - Session Key              │
   │  - Expiry timestamp         │
   │  - PAC (group SIDs)         │
   └─────────────────────────────┘

3. Client decrypts Session Key using password hash
   Client stores TGT (cannot read it — it's sealed for KDC)
   Password is discarded from memory; never sent anywhere
```

> [!important] The password is never sent over the network
> The client proves it knows the password by successfully decrypting the Session Key. If decryption produces garbage, the client knows the password is wrong — before any network communication with the service.

### Phase 2 — Getting a Service Ticket (TGS Exchange)

When the user tries to access a service (e.g., `\\fileserver01\Finance`):

```
Client                                        KDC (Ticket-Granting Service)

1. Client sends to KDC:
   - TGT (still sealed — client passes it unopened)
   - Authenticator (timestamp encrypted with Session Key, proving client holds Session Key)
   - Name of the target service (SPN: HOST/fileserver01.corp.example.com)
                                               │
                                               ▼
                                    KDC opens TGT using krbtgt key
                                    Extracts Session Key from TGT
                                    Decrypts Authenticator using Session Key
                                    Verifies timestamp (≤ 5 min skew)
                                    Checks if client is authorised for this service

2. KDC generates a Service Ticket:
   ┌─────────────────────────────┐
   │ Service Session Key         │ ← encrypted with original Session Key
   └─────────────────────────────┘
   ┌─────────────────────────────┐
   │ Service Ticket:             │ ← encrypted with service's long-term key
   │  - Client identity          │   (client CANNOT open this)
   │  - Service Session Key      │
   │  - Expiry timestamp         │
   │  - PAC (group SIDs)         │
   └─────────────────────────────┘

3. Client stores Service Ticket for fileserver01
```

### Phase 3 — Accessing the Service

```
Client                                        fileserver01

1. Client presents Service Ticket + new Authenticator
   (Authenticator encrypted with Service Session Key)
                                               │
                                               ▼
                                    Server opens Service Ticket
                                    using its own long-term key
                                    Extracts Service Session Key
                                    Decrypts Authenticator — verifies timestamp
                                    Reads PAC: user's group SIDs
                                    Checks share ACL against SIDs
                                    Access granted (or denied)

2. Server optionally sends back its own Authenticator
   (mutual authentication — client verifies server is genuine)
```

---

## What the PAC Contains

The **Privilege Attribute Certificate (PAC)** is a Microsoft extension to Kerberos embedded in tickets. It contains:

- User's Security Identifier (SID)
- List of all group SIDs the user belongs to (including nested groups)
- Account flags (enabled/disabled, password expired, etc.)

When the file server checks the share ACL, it reads the PAC — not the AD database. This is why group membership changes require a **new Kerberos ticket** (log out and log in) before they take effect: the old ticket still has the old group list.

---

## Key Security Properties

| Property | How Kerberos Achieves It |
|---|---|
| **Password never over the wire** | Client proves password knowledge by decrypting — never sends it |
| **Replay attack prevention** | Timestamps in Authenticators expire in ~5 minutes; captured tickets cannot be reused |
| **Mutual authentication** | Server can prove its identity back to the client (optional) |
| **Least privilege on the wire** | Service Ticket authorises access to one specific service only |
| **Single sign-on** | TGT is reused for multiple Service Ticket requests during its lifetime (typically 10 hours) |

---

## Cross-Realm Authentication (Cross-Domain Kerberos)

When a user in `CORP.EXAMPLE.COM` accesses a service in `EMEA.EXAMPLE.COM`:

1. User's KDC issues a **referral ticket** instead of a direct Service Ticket
2. Referral ticket is encrypted with an **inter-realm trust key** (shared between the two KDCs)
3. User presents referral ticket to EMEA's KDC (TGS)
4. EMEA's KDC issues a Service Ticket for the resource in its domain
5. User accesses the service normally

This trust key is what makes AD cross-domain authentication work under the hood. The AGDLP pattern in [[AD-Domain-Forest-Trusts]] sits on top of this Kerberos cross-realm mechanism.

---

## Kerberos vs. LDAP Bind

| Dimension | Kerberos | LDAP Bind |
|---|---|---|
| **Password transmission** | Never — proven by decryption | Sent to the app, which forwards to AD |
| **SSO capable** | Yes — TGT reused for multiple services | No — each app authenticates independently |
| **Who initiates auth check** | OS at login; ticket cached for the session | The application, at each login |
| **Group membership delivery** | PAC embedded in ticket | App queries `memberOf` attribute separately |
| **Typical use** | Windows-native resources, domain-joined services | Web apps, enterprise software, IIQ connector |

---

## CISSP Exam Focus Points

These are the specific details the CISSP exam tests on Kerberos:

| Fact | Detail |
|---|---|
| Port | **88** (UDP primary; TCP for large tickets) |
| Encryption | **Symmetric-key** (AES); NOT asymmetric |
| Clock dependency | **NTP required**; default 5-minute skew tolerance |
| Password over wire | **Never** — the defining property |
| TGT vs Service Ticket | TGT = proof of authentication (used with KDC); ST = access token for one specific service |
| KDC components | **AS** (issues TGT) + **TGS** (issues Service Tickets) |
| PAC | Contains group **SIDs** — how authorization happens |
| SSO mechanism | TGT cached and reused — authenticate once, access many services |
| Replay protection | **Timestamps** in Authenticators |
| Cross-domain | **Inter-realm trust keys** between KDCs |

---

## Related

- [[AD-LDAP-Fundamentals]] — AD as the Kerberos infrastructure (KDC = Domain Controller, `krbtgt` account)
- [[AD-Application-Integration]] — Pattern 1: how Kerberos enables Windows-native file share and app access
- [[Authentication-Factors-MFA]] — where Kerberos fits in the broader authentication landscape; SSO concepts
- [[SAML-Federation]] — SAML as the non-Windows equivalent of Kerberos-based SSO for web apps
- [[RADIUS-TACACS-Diameter]] — other authentication protocols used in network access control
