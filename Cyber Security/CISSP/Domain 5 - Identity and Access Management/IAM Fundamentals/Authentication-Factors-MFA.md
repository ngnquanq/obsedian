---
tags: [authentication, mfa, biometrics, sso, jit, session-management, otp, fido2, passwordless, aal, identity-proofing, credential-management, cissp, domain-5-iam, cissp/5.2-identification-authentication]
aliases: [Authentication Factors, MFA Multi-Factor Authentication, Biometrics FAR FRR CER, AAL Authenticator Assurance, Single Sign-On SSO, Identity Proofing, Credential Management]
---

# Authentication Factors and MFA

Authentication answers one question: **are you who you claim to be?** It is the gate before authorisation. The tools for answering that question — from identity proofing to passwords, hardware keys, fingerprints, SSO, and password vaults — differ enormously in strength and how they fail. This note covers the CISSP 5.2 authentication landscape: registration and proofing, factor types, MFA mechanics, biometric accuracy, assurance levels, credential management, SSO, JIT provisioning, and session management.

---

## Why Passwords Alone Fail — The Problem

A password is a single shared secret between the user and the system. It fails on multiple fronts:

- **Phishable**: users hand it to fake sites without realising
- **Reused**: breached in one system, works in fifty others
- **Guessable**: most users pick predictable patterns
- **Stolen from storage**: databases are breached; hashed passwords cracked offline
- **No liveness check**: a stolen password is identical to a legitimate one

**MFA solves this by requiring at least two independent pieces of evidence from different categories.** An attacker who steals your password still cannot log in without your physical device or your fingerprint.

---

## The Five Authentication Factor Types

Authentication factors are divided by *what they prove*, not by the technology used.

### Type 1 — Something You Know (Knowledge Factors)

| Example | Notes |
|---|---|
| Password / passphrase | Most common; weakest if used alone |
| PIN | Short numeric; weak against brute force without lockout |
| Security questions | Cognitive passwords; answers often guessable from social media |
| Knowledge-Based Authentication (KBA) | Questions from credit bureau or government records; used for identity proofing |

**Weakness:** Can be guessed, phished, reused, or stolen. Provides no proof of physical possession.

---

### Type 2 — Something You Have (Possession Factors)

| Example | Notes |
|---|---|
| Hardware security key (YubiKey, FIDO2) | Phishing-resistant; physical presence required |
| Smart card / PIV card | Certificate-based; requires card reader |
| Software OTP app (Google Authenticator, Authy) | TOTP or HOTP; tied to device |
| Push notification (Duo, Okta Verify) | App approval on registered device |
| SMS OTP | Convenient; NIST deprecated for federal systems (SIM swap risk) |
| Email OTP | Weaker (email account may itself be compromised) |
| Cryptographic certificate | Browser certificate; used in mutual TLS |

**Key distinction:** Possession factors prove you have a *physical or cryptographic object*, not just knowledge.

---

### Type 3 — Something You Are (Inherence / Biometric Factors)

| Type | Physiological Examples | Behavioural Examples |
|---|---|---|
| **Physiological** | Fingerprint, iris scan, retina scan, facial geometry, hand geometry, vein pattern | — |
| **Behavioural** | — | Keystroke dynamics, gait analysis, voice pattern, signature dynamics |

Biometrics are covered in detail below.

---

### Type 4 — Somewhere You Are (Location Factors)

Supplementary factor based on physical or network location:
- IP address geolocation
- GPS coordinates (mobile device)
- Network (corporate LAN vs. public internet)
- Geofencing (access only when within a defined physical area)

**Not a replacement for primary factors** — easily spoofed by VPN or proxy. Used in risk-based access control as a *signal*, not a standalone factor.

---

### Type 5 — Something You Do (Behaviour Factors)

Pattern-of-life analysis:
- Typing rhythm and speed
- Mouse movement patterns
- Typical login times and locations
- Typical data access patterns

**Used in:** Continuous authentication and fraud detection systems. Not a standalone factor for initial authentication.

---

## MFA vs 2FA — The Precise Distinction

| Term | Meaning |
|---|---|
| **2FA** (Two-Factor Authentication) | Exactly two factors — but they *must come from different types* (e.g., password + OTP) |
| **MFA** (Multi-Factor Authentication) | Two or more factors from different types — 2FA is a subset of MFA |
| **Two-step verification** | Two authentication steps that may be from the *same* type — NOT true MFA (e.g., password + security question = both Type 1) |

> [!warning] Two steps ≠ MFA
> A password plus a security question is two-step verification, not MFA. Both are Type 1 (something you know). True MFA requires at least two *different* factor types.

---

## Registration, Proofing, and Establishment of Identity

Before a system can authenticate a user, it has to decide whether the account should exist and who the account represents. This is **identity proofing**: establishing a relationship between a digital subject and a real person to an appropriate level of confidence.

NIST SP 800-63A-4 describes identity proofing and enrollment as a sequence:

```
Applicant claims identity
    │
    ▼
Resolution: collect enough evidence and attributes to identify one person
    │
    ▼
Validation: check that the evidence and attributes are genuine and accurate
    │
    ▼
Verification: confirm the applicant owns the evidence and attributes
    │
    ▼
Enrollment: create the subscriber account and bind authenticators
```

| Step | CISSP meaning | Enterprise example |
|---|---|---|
| **Registration** | The person or service requests an identity in the system | New employee record arrives from HR; contractor onboarding form submitted |
| **Proofing** | The organisation validates that the claimed identity is real and belongs to the applicant | HR verifies employment documents; bank performs customer identification checks |
| **Establishment** | The system creates the identity record and binds credentials or authenticators to it | AD account created; MFA device enrolled; smart card issued |
| **Maintenance** | The identity and authenticators are renewed, recovered, revoked, or disabled over time | Password reset, authenticator replacement, account recovery, leaver disablement |

NIST separates **Identity Assurance Levels (IAL)** from **Authenticator Assurance Levels (AAL)**:

| Assurance | Question | Example |
|---|---|---|
| **IAL** | How strongly was the person's real-world identity proofed? | Self-asserted attributes vs. validated government evidence |
| **AAL** | How strong is the authentication event? | Password-only vs. MFA vs. hardware-backed phishing-resistant MFA |

> [!note] Proofing vs authentication
> Proofing happens before or during enrollment: "Should this account represent this person?" Authentication happens later at login: "Is this the same subscriber returning?" Strong MFA cannot fix weak initial proofing if the account was issued to the wrong person.

Source anchor: [NIST SP 800-63A-4](https://pages.nist.gov/800-63-4/sp800-63a.html) covers identity proofing and enrollment; [ISC2 CISSP Domain 5.2](https://www.isc2.org/certifications/cissp/cissp-certification-exam-outline) explicitly lists registration, proofing, and establishment of identity.

---

## OTP Methods

One-Time Passwords are the most common second factor for consumer and enterprise use.

### TOTP (Time-Based OTP) — RFC 6238
- Generates a 6-8 digit code that changes every 30 seconds
- Derived from: `TOTP = HOTP(secret, floor(current_time / 30))`
- Secret key shared between app and server at setup (QR code scan)
- Client and server must have synchronised clocks (usually tolerate ±1 interval)
- **Examples:** Google Authenticator, Authy, Microsoft Authenticator

### HOTP (HMAC-Based OTP) — RFC 4226
- Counter-based (increments on each use, not on time)
- `HOTP = HMAC-SHA1(secret, counter)`
- Counter drift is a usability issue; TOTP is more common in practice

### SMS OTP
- One-time code delivered via text message
- **NIST SP 800-63B explicitly restricts SMS OTP** for federal systems due to SIM swap attacks and SS7 protocol vulnerabilities
- Still widely used in commercial applications where NIST restrictions don't apply

### Push Notification
- App on registered device receives approval request; user taps Approve/Deny
- Resistant to real-time phishing (user sees context on the device screen)
- Vulnerable to **MFA fatigue** (push bombing — spamming approval requests until user accidentally approves)

### Hardware OTP Tokens
- Dedicated physical device generating TOTP codes (RSA SecurID)
- No phone needed; more resistant to mobile malware

---

## Biometrics — Accuracy Metrics

Biometric systems make errors in both directions. Understanding these metrics is essential for CISSP.

### False Acceptance Rate (FAR) — Type 2 Error
The rate at which the system **incorrectly accepts an invalid user** as legitimate.
- FAR = (number of false acceptances) / (total impostor attempts)
- High FAR = security failure — impostors get in
- **FAR is the more dangerous error** from a security perspective

### False Rejection Rate (FRR) — Type 1 Error
The rate at which the system **incorrectly rejects a valid user**.
- FRR = (number of false rejections) / (total legitimate attempts)
- High FRR = usability failure — legitimate users cannot get in

### Crossover Error Rate (CER) — Equal Error Rate
The point at which FAR = FRR. Used to compare biometric systems:
- **Lower CER = better accuracy** (the two error curves cross at a lower rate)
- A system with CER of 1% is more accurate than one with CER of 5%

```
Error
Rate
  │
  │  FRR \              /  FAR
  │       \            /
  │        \          /
  │         \        /
  │          \      /
  │           \ __ /    ← CER (Crossover Error Rate)
  │            \/
  │
  └──────────────────── Sensitivity
        (less strict)  (more strict)
```

> [!tip] CER and sensitivity
> Adjusting sensitivity trades FAR for FRR. Making the system *more strict* (higher sensitivity) decreases FAR but increases FRR. The CER is the optimal operating point where both are minimised equally.

### Biometric Templates
Biometric systems never store the raw biometric (fingerprint image, iris photo). Instead:
- At enrolment, a **one-way mathematical function** converts the raw biometric into a **template** (a digital representation)
- The raw biometric is discarded
- Authentication matches a new scan against the stored template
- If the template database is breached, you cannot reconstruct the original fingerprint — but you cannot change your fingerprint either (unlike a password)

---

## Authenticator Assurance Levels (AAL)

NIST SP 800-63B defines three AAL levels that describe the strength of the authentication process:

| Level | Name | Requirements | Typical Use |
|---|---|---|---|
| **AAL1** | Some confidence | Single-factor permitted; memorised secret (password) acceptable; secure protocol | Low-risk consumer applications |
| **AAL2** | High confidence | MFA **required** (any combination); approved cryptographic techniques; authenticated protected channel | Most enterprise applications |
| **AAL3** | Very high confidence | Hardware-based MFA **required** (phishing-resistant); proof of key possession; verifier impersonation resistance | High-security government/financial systems |

> [!note] AAL3 = hardware key required
> AAL3 mandates that the second factor be a hardware cryptographic authenticator (e.g., FIDO2 hardware security key, PIV smart card). A software TOTP app does not meet AAL3.

---

## Passwordless Authentication

Passwordless removes the knowledge factor entirely, relying on possession + inherence:

### FIDO2 / WebAuthn
- **FIDO Alliance** standard, implemented in all major browsers and OSes
- Device generates a public/private key pair at registration
- Private key never leaves the device (stored in secure hardware enclave)
- Authentication: server sends a challenge; device signs with private key; server verifies with stored public key
- **Phishing-resistant**: the key is bound to the specific domain; a fake site gets a different challenge/key pair

### Passkeys
- FIDO2 credentials synced across devices via cloud (iCloud Keychain, Google Password Manager)
- Convenient: private key on phone, unlock with biometric (Face ID, fingerprint)
- Provides AAL2 (possession of device + biometric = two factors)

### Other Passwordless Methods
- Certificate-based authentication (smart card)
- Magic link (one-time email link — not truly passwordless, relies on email account security)
- Biometric-only on enrolled device

---

## Credential Management Systems

CISSP uses **credential management system** broadly: the process and tooling for issuing, storing, rotating, recovering, revoking, and auditing credentials. A password vault is one example, not the whole category.

| Credential type | Management concern | Typical control |
|---|---|---|
| User password | Reset, lockout, compromise, reuse | Password policy, breached-password checking, MFA, self-service reset |
| MFA authenticator | Enrollment, replacement, lost device | Authenticator binding, recovery codes, helpdesk verification |
| Smart card / certificate | Issuance, expiration, revocation | PKI, certificate lifecycle, CRL/OCSP |
| API key / token | Secret leakage, over-permission, stale token | Secret vault, short lifetime, scoped permissions |
| Privileged password | Shared admin use, credential exposure | Password vault, checkout approval, rotation, session recording |
| Service account secret | Long-lived non-human credential | gMSA, managed identity, vault rotation, no interactive login |

```
Credential issued
    │
    ▼
Stored or bound securely
    │
    ▼
Used for authentication
    │
    ▼
Renewed, rotated, recovered, or revoked
    │
    ▼
Audit trail proves who controlled it and when
```

For privileged and service-account credentials, see [[Privilege-Escalation-Service-Accounts]]. For CyberArk as a concrete password-vault implementation, see [[CyberArk-IIQ-Integration]].

> [!warning] Credential management is broader than passwords
> A password vault helps with privileged passwords, but CISSP expects the full lifecycle: issuance, binding, storage, rotation, recovery, revocation, and auditability across human and non-human credentials.

Source anchor: [NIST SP 800-63B](https://pages.nist.gov/800-63-4/sp800-63b.html) covers authenticator lifecycle topics such as binding, renewal, and account recovery; ISC2 Domain 5.2 lists credential management systems, including password vaults.

---

## Single Sign-On (SSO)

SSO allows a user to authenticate once and access multiple applications without re-entering credentials.

**The mechanism:** After successful authentication, an SSO token/session is established. When the user accesses another application, that application checks the SSO session rather than prompting for new credentials.

### Advantages

| Benefit | Why It Matters |
|---|---|
| Fewer passwords to remember | Users choose stronger passwords when they have fewer to manage |
| Fewer password resets | Reduces helpdesk load and shadow IT password management |
| Central revocation | Disable the SSO session → access to all linked apps revoked immediately |
| Consistent MFA enforcement | Apply MFA once at the SSO layer; not per-app |

### Disadvantages

| Risk | Mitigation |
|---|---|
| Single point of compromise | MFA on the SSO credential is essential |
| If SSO is breached, all linked apps are exposed | Short session lifetimes; anomaly detection |
| Application availability tied to IdP | High-availability IdP infrastructure required |

### SSO Implementations

| Technology | Protocol | Typical Environment |
|---|---|---|
| Kerberos | Ticket-based (port 88) | Windows/AD domain-joined resources |
| SAML 2.0 | XML assertions | Web apps, SaaS, enterprise federation |
| OIDC | JWT, REST | Modern web apps, mobile apps |
| CAS (Central Authentication Service) | Web-based | University / open-source environments |

For Kerberos details, see [[Kerberos-Protocol]]. For SAML, see [[SAML-Federation]]. For OIDC, see [[OAuth2-OIDC]].

---

## Just-In-Time (JIT) Provisioning

JIT provisioning automatically creates user accounts in target systems **at the moment of first login**, rather than pre-provisioning them in advance.

**How it works (SAML-based):**
```
User logs in to ServiceNow for the first time
    │
    ▼
ServiceNow redirects to IdP (Azure AD / Okta)
    │
    ▼
IdP authenticates user; issues SAML assertion
Assertion includes: email, name, department, role attributes
    │
    ▼
ServiceNow receives assertion
Checks: does this user have a local account? No.
JIT: creates local account using assertion attributes
    │
    ▼
User is logged in; account exists for future sessions
```

**Benefits:**
- No pre-provisioning step required — new employees can access SaaS apps on day one
- Account attributes stay current (assertion always reflects current IdP data)
- Reduces orphan accounts — no account exists until a real login occurs

**Risks:**
- Requires accurate, trusted attribute mapping in the IdP
- De-provisioning is **not automatic** — accounts created via JIT must be explicitly deprovisioned

---

## Session Management

Authentication creates a session. Session management governs how long that session lasts and how it ends.

### Session Termination Methods

| Method | How It Works | Typical Setting |
|---|---|---|
| **Inactivity timeout** | Session expires after a period of no user activity | 15–30 minutes for sensitive apps; 4–8 hours for general use |
| **Absolute timeout** | Session expires after a fixed time regardless of activity | 8–12 hours for enterprise SSO tokens |
| **Screensaver + lock** | Workstation locks after inactivity; re-authentication required | 5–15 minutes (OS setting, enforced via Group Policy) |
| **Concurrent session limit** | Prevents the same account from being logged in from multiple locations simultaneously | 1 active session per user in high-security systems |
| **Manual logout** | User explicitly ends session | Always available; enforced in shared workstation environments |

### Session Hijacking Threats

| Attack | Description | Defence |
|---|---|---|
| **Cookie theft** | Attacker steals session cookie (XSS, network sniffing) | HTTPS everywhere; HttpOnly and Secure cookie flags; short expiry |
| **Session fixation** | Attacker sets a known session ID before login; user authenticates with that ID | Regenerate session ID on login |
| **MitM replay** | Attacker captures and replays session token | TLS; token binding; short lifetimes |
| **Pass-the-ticket** (Kerberos) | Attacker steals a Kerberos ticket from memory and presents it | Kerberos armoring; credential guard; EDR tools |

---

## Related

- [[IAM-Overview]] — authentication as the second layer of the IAM stack
- [[Access-Control-Models]] — authentication (who you are) vs. authorisation (what you can do); the two are always distinct
- [[Kerberos-Protocol]] — Kerberos deep dive: KDC, TGT, Service Tickets, NTP dependency
- [[SAML-Federation]] — SAML-based SSO and JIT provisioning for web apps and SaaS
- [[OAuth2-OIDC]] — OIDC as the modern authentication protocol; JWTs; passwordless with PKCE
- [[RADIUS-TACACS-Diameter]] — AAA protocols for network device authentication
- [[Privilege-Escalation-Service-Accounts]] — service-account secrets, privileged credential vaulting, and credential rotation
