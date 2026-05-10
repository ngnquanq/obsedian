---
tags: [radius, tacacs, diameter, aaa, authentication, authorization, accounting, network-access, vpn, cissp, domain-5-iam, cissp/5.6-authentication-systems]
aliases: [RADIUS TACACS+ Diameter, AAA Protocols, Network Access Authentication, Remote Authentication Dial-In]
---

# RADIUS, TACACS+, and Diameter — Network AAA Protocols

[[AD-Application-Integration|Application integration patterns]] cover how servers and web apps authenticate users against AD. But network devices — VPN concentrators, wireless access points, routers, switches — have a different problem: they cannot each maintain their own user database. This note covers the three protocols designed to centralise authentication for network access: RADIUS, TACACS+, and Diameter.

---

## The AAA Model — Why It Exists

**AAA** stands for **Authentication, Authorization, and Accounting** — the three mandatory components of any secure network access system.

| Component | Question It Answers | Example |
|---|---|---|
| **Authentication** | Who are you? | Verify username + password against AD |
| **Authorization** | What are you allowed to do? | User X may only access VLAN 10; admin Y may issue all commands |
| **Accounting** | What did you do? | User X logged in at 09:14, accessed file share Y, session ended 10:32 |

**The problem without centralised AAA:**
- A company with 500 network devices (switches, APs, VPN gateways) needs every device to have its own user database
- When an employee leaves, IT must log into 500 devices to disable the account
- When passwords are compromised, 500 updates are needed
- No unified audit log

**Centralised AAA solves this:** every device defers to a central AAA server. One database, one audit log, one place to make changes.

---

## RADIUS — Remote Authentication Dial-In User Service

RADIUS was developed in 1991 for dial-up internet access and has since become the dominant protocol for network access AAA.

### Architecture

```
User (supplicant)
    │
    │ credentials
    ▼
Network Access Server (NAS)    ← VPN gateway, wireless controller, switch
    │                            = the RADIUS *client*
    │  RADIUS Access-Request
    ▼
RADIUS Server                  ← the authentication server
    │                            (FreeRADIUS, Cisco ISE, Microsoft NPS)
    │  RADIUS Access-Accept / Access-Reject / Access-Challenge
    ▼
NAS enforces decision
```

The NAS is the **RADIUS client** — it forwards credentials to the RADIUS server. The RADIUS server is the **AAA authority**.

### Protocol Details

| Property | Value |
|---|---|
| **Transport** | UDP (default) |
| **Port (authentication + authorisation)** | **1812** |
| **Port (accounting)** | **1813** |
| **Encryption** | Password field only (hashed with MD5 and a shared secret); all other attributes are cleartext |
| **AAA integration** | Authentication and authorisation **combined** in a single exchange |
| **RADIUS/TLS** | Full session encryption over TCP port 2083 (RFC 6614) |

### How RADIUS Authenticates

```
1. User connects to VPN, provides username + password
2. VPN gateway (NAS) sends RADIUS Access-Request to RADIUS server:
   - Username: plaintext
   - Password: encrypted with MD5(shared_secret + request_ID)
   - NAS-IP-Address, NAS-Port, Framed-Protocol, etc.

3. RADIUS server checks credentials against AD or local database

4. RADIUS server responds:
   - Access-Accept:  username + password correct; optional attributes
                     (VLAN assignment, time limits, IP address)
   - Access-Reject:  authentication failed
   - Access-Challenge: additional data needed (MFA code prompt)

5. NAS grants or denies access based on response
```

> [!warning] RADIUS only encrypts the password field
> Everything else in a RADIUS packet — username, IP address, NAS identifier, accounting records — travels in cleartext (unless RADIUS/TLS is used). On untrusted networks, RADIUS should only be used over TLS or within a protected management VLAN.

### Typical RADIUS Use Cases

- **VPN authentication**: user connects to VPN → VPN gateway asks RADIUS server → RADIUS validates against AD
- **802.1X wired/wireless**: device plugs into a switch or connects to Wi-Fi → 802.1X sends EAP credentials to RADIUS → RADIUS authorises device onto the correct VLAN
- **Network device management**: admin SSH's to a router → router asks RADIUS for permission → RADIUS responds with permitted commands

---

## TACACS+ — Terminal Access Controller Access Control System Plus

TACACS+ was developed by Cisco as an improvement over the original TACACS protocol. Despite the "+" suffix, it is architecturally distinct from its predecessors and is now an open standard.

### Architecture

Like RADIUS, TACACS+ uses a client-server model. The network device is the client; the TACACS+ server is the authority.

### Protocol Details

| Property | Value |
|---|---|
| **Transport** | TCP |
| **Port** | **49** |
| **Encryption** | **Entire payload encrypted** (not just the password) |
| **AAA integration** | Authentication, authorisation, and accounting are **separate processes** — can run on different servers |
| **Developed by** | Cisco; released as an open standard |

### How TACACS+ Differs from RADIUS

The key difference is **granular command authorisation**. With RADIUS, once you're authorised to access a network device, you get whatever privilege level that device assigns you locally. With TACACS+, every individual command can be sent to the TACACS+ server for approval:

```
Admin types: "no shutdown interface GigabitEthernet0/1"

TACACS+ authorization check:
  → send command to TACACS+ server
  ← TACACS+ server: PERMIT (admin is in Tier2-Engineers group)

Admin types: "reload"
  → send command to TACACS+ server
  ← TACACS+ server: DENY (only NOC-Managers group may reload)
```

This makes TACACS+ the preferred protocol for **network device administration** — where granular audit trails of every command issued matter for compliance.

### TACACS+ Flow

```
1. Admin SSH's to a router
2. Router sends auth request to TACACS+ server (TCP 49)
   - Username sent in first packet
   - TACACS+ server responds with password prompt
   - Admin's password sent in second packet (encrypted)
3. TACACS+ server validates credentials → Authentication PASS
4. For every command the admin issues:
   - Router sends authorization request: "may this user run THIS command?"
   - TACACS+ server checks policy → PERMIT or DENY
5. All activity logged to TACACS+ Accounting server
```

---

## RADIUS vs TACACS+ — Comparison

| Dimension | RADIUS | TACACS+ |
|---|---|---|
| **Transport** | UDP | TCP |
| **Port** | 1812 (auth), 1813 (acct) | 49 |
| **Encryption** | Password field only | Entire payload |
| **AAA separation** | Combined (auth + authz in one) | Separate (can use different servers) |
| **Command authorisation** | No — coarse-grained only | Yes — per-command authorisation |
| **Primary use case** | User network access (VPN, Wi-Fi, 802.1X) | Network device administration |
| **Vendor** | Open standard (RFC 2865) | Open standard (Cisco origin) |
| **Preferred for** | RADIUS: network access | TACACS+: device admin audit trails |

> [!tip] CISSP exam key facts
> - RADIUS uses **UDP**; TACACS+ uses **TCP**
> - RADIUS encrypts **only the password**; TACACS+ encrypts **everything**
> - TACACS+ separates AAA; RADIUS combines authentication and authorisation
> - Use RADIUS for user access; use TACACS+ for admin command authorisation

---

## Diameter — The RADIUS Successor

Diameter is a AAA protocol designed to address RADIUS limitations in large, complex, modern networks. The name is a pun: a diameter is twice a radius.

### Why Diameter Exists

| RADIUS Limitation | Diameter Solution |
|---|---|
| Uses UDP (unreliable) | Uses TCP or SCTP (reliable delivery) |
| MD5-based security (weak) | TLS or IPsec required |
| Client-server only | Peer-to-peer (devices can relay and proxy requests) |
| Limited attribute support | Extensible attribute-value pairs (AVPs) |
| No built-in failover | Native failover and roaming support |
| Not suited to mobile networks | Designed for 4G/LTE EPC (Evolved Packet Core) |

### Protocol Details

| Property | Value |
|---|---|
| **Transport** | TCP or SCTP (Stream Control Transmission Protocol) |
| **Security** | TLS (mandatory) or IPsec |
| **Topology** | Peer-to-peer with relay/proxy support |
| **Standard** | RFC 6733 (Diameter Base Protocol) |
| **Compatibility** | **NOT backwards-compatible with RADIUS** |

### Where Diameter Is Used

- **Mobile telecom networks** (4G LTE and 5G core): Diameter carries authentication and policy decisions for subscribers roaming between carriers
- **Large ISP infrastructure**: policy decisions for broadband subscribers (speeds, quotas, QoS)
- **Carrier-grade NAT and IMS** (IP Multimedia Subsystem)

Diameter is rarely seen in typical enterprise IT — it lives in the telecom and carrier space. For CISSP, know that it exists, that it improves on RADIUS, and that it is **not RADIUS-compatible**.

---

## How These Protocols Interact with AD

RADIUS and TACACS+ servers typically authenticate *against* Active Directory, not against a local database:

```
User → VPN gateway (RADIUS client) → RADIUS server (NPS/FreeRADIUS)
                                            │
                                            │ LDAP bind / Kerberos
                                            ▼
                                    Active Directory
                                    (validates credentials, reads group memberships)
                                            │
                                            ▼
                                    RADIUS server sends
                                    Access-Accept + VLAN/role attributes
```

This means RADIUS/TACACS+ are not replacements for AD — they are intermediaries that expose AD authentication to network devices that cannot speak LDAP or Kerberos directly.

---

## Related

- [[Authentication-Factors-MFA]] — the authentication factors (passwords, MFA, OTP) that RADIUS/TACACS+ validate
- [[AD-Application-Integration]] — how other applications authenticate against AD; RADIUS/TACACS+ as Pattern 2 (LDAP bind) via the AAA server
- [[Kerberos-Protocol]] — Kerberos as the alternative authentication protocol for Windows-native resources
- [[Access-Control-Models]] — AAA's authorization component implements access control models (RBAC, Rule-Based)
- [[IAM-Overview]] — where network AAA fits in the broader IAM stack
