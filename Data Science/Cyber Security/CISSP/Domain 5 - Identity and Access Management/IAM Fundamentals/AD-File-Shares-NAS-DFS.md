---
tags: [active-directory, file-shares, nas, dfs, unc, acl, ntfs, storage, authorization, access-control, cissp, domain-5-iam, cissp/5.1-access-control, cissp/5.4-authorization]
aliases: [File Share Permissions, NAS and AD, DFS vs UNC, AD File Share Authorization]
---

# File Shares, NAS, and DFS — How Storage Integrates with AD

File shares are the largest authorization surface in most enterprises — almost every employee accesses `\\somewhere\something` every day. Yet the machinery behind it (NAS devices, DFS namespaces, NTFS ACLs, and how AD groups wire into all of them) is frequently misunderstood or treated as a black box. This note fills that gap, building directly on the Kerberos ACL pattern introduced in [[AD-Application-Integration]].

---

## UNC Paths — What They Are

**UNC** stands for **Universal Naming Convention**. It is the standard syntax for addressing a network resource:

```
\\host\share\folder\subfolder\filename.ext
  ──── ───── ─────────────────────────────
   │     │         │
   │     │         └─ path within the share (optional)
   │     └─ share name (mandatory)
   └─ host (server name, FQDN, IP, or DFS namespace)
```

### What can go in the `host` segment

| Host type | Example | When used |
|---|---|---|
| NetBIOS / machine name | `\\fileserver01` | Small environments; not recommended for production |
| FQDN | `\\fileserver01.corp.example.com` | Preferred for direct-server paths |
| IP address | `\\10.0.1.5` | Break-glass / troubleshooting only |
| DFS namespace | `\\corp.example.com\shares` | Enterprise standard — see [DFS section below](#dfs--distributed-file-system) |

> [!tip] UNC is the format; DFS is a service
> A UNC path can point directly to a server OR to a DFS namespace. The path looks identical to the user — only what's in the `host` segment tells you which it is.

---

## NAS Drives — What They Are and How They Join AD

### What a NAS Is

A **NAS (Network-Attached Storage)** is a dedicated storage appliance that serves files over the network. Unlike a general-purpose Windows Server, it is purpose-built hardware (or a VM) running specialised firmware.

Common vendors:
- **Enterprise**: NetApp (ONTAP), Dell EMC (Isilon/PowerScale), Pure Storage
- **SMB/prosumer**: Synology, QNAP
- **Cloud-managed**: Azure NetApp Files, AWS FSx for Windows

What they have in common: they expose SMB/CIFS shares (for Windows/macOS) and/or NFS exports (for Linux), and most enterprise-grade NAS devices can join an Active Directory domain.

### How a NAS Joins AD

The process mirrors a Windows machine joining a domain:

1. An administrator enters the AD domain name and domain admin credentials in the NAS admin UI (e.g., Synology's **File Services → SMB → Advanced Settings → Domain**; NetApp uses `vserver cifs create`)
2. The NAS creates a **computer account** in AD (visible in ADUC under the default `Computers` OU or a custom OU)
3. The NAS registers a Service Principal Name (SPN) so Kerberos can issue service tickets for it

Once joined, the authentication flow is **identical to a Windows file server**:

```
User opens \\nas01\Finance
    │
    ▼
Windows requests a Kerberos Service Ticket for nas01
    │
    ▼
NAS receives the ticket, reads the PAC (user's group SIDs)
    │
    ▼
NAS checks the NTFS ACL on \Finance
"SID of DL-Finance-Read → Read & Execute" matches → Access granted
```

### What NAS Devices Cannot Do

| Capability | Windows File Server | NAS |
|---|---|---|
| Group Policy (GPO) | Yes — applied like any domain member | No — GPO does not apply to non-Windows OS |
| ADUC management | Full | Computer account visible, but share/permission management is in NAS admin UI |
| Kerberos authentication | Native | Yes, once domain-joined |
| NTFS ACLs | Native | Yes — NAS OS maps ACLs to its internal permission model |
| NFS with Kerberos | Via separate config | Vendor-dependent |

> [!note] Management is split
> The NAS admin UI manages share creation and SMB settings. ADUC manages the computer account and the AD groups that appear in the ACLs. Permissions themselves live on the NAS file system but reference AD SIDs.

---

## Share Permissions vs. NTFS Permissions

When you access a file share over the network, two separate permission layers are evaluated. Both must allow the access for it to succeed.

### Share Permissions

- Applied at the **share root** (`\\server\sharename`) in the share's Properties → Sharing tab
- Only enforced for **network access** — irrelevant if someone logs in locally to the server/NAS
- Three coarse-grained options: **Full Control**, **Change**, **Read**
- Applies to the entire share — no per-folder granularity

### NTFS Permissions

- Stored in the **file system** itself (in the file/folder's ACL on disk)
- Enforced for **both local and network access**
- Fine-grained: Read, Write, Execute, Modify, Full Control, and special permissions
- **Inherited** down the folder tree by default — a permission set on `\Finance` flows to `\Finance\Q1`, `\Finance\Q1\Reports`, etc., unless inheritance is explicitly broken

### How They Combine

**Effective permission = the more restrictive of (Share permission) AND (NTFS permission)**

| Share permission | NTFS permission | Effective access |
|---|---|---|
| Full Control | Read | Read only |
| Read | Full Control | Read only |
| Change | Modify | Modify |
| Full Control | Full Control | Full Control |

### Best Practice: Let NTFS Do the Work

```
Share permission:  Everyone → Full Control   (never restrict here)
NTFS permissions:  set granular access per group per folder
```

By setting the share permission wide open and controlling everything via NTFS, you have a **single permission model to audit** — no need to cross-reference two layers. All effective access is visible in the Security tab of each folder.

> [!warning] Common mistake
> Setting share permissions to `Read` on a share you want to be "read-only" while also having NTFS `Modify` on the folder. The share permission wins (Read), making the share read-only for everyone regardless of their NTFS rights. Use NTFS for all granular control.

---

## AD Groups and File Share ACLs — The AGDLP Pattern

Placing individual user accounts directly on NTFS ACLs is an anti-pattern — it makes auditing and management unscalable. The correct pattern is **AGDLP**: **A**ccount → **G**lobal group → **D**omain **L**ocal group → **P**ermission.

> For the full explanation of group scope rules, see [[AD-Domain-Forest-Trusts]].

### How AGDLP Applies to File Shares

```
NTFS ACL on \\nas01\Finance
│
├── DL-Finance-Read   → Read & Execute          (Domain Local group — on the ACL)
│       └── G-Finance-Analysts                  (Global group — users from same domain)
│               ├── jsmith
│               ├── abrown
│               └── cwong
│
├── DL-Finance-Write  → Modify                  (Domain Local group — on the ACL)
│       ├── G-Finance-Senior                    (Global group — same domain)
│       └── G-Contractors-Finance               (Global group — from a trusted domain)
│
└── DL-Finance-Admin  → Full Control            (Domain Local group — on the ACL)
        └── G-IT-FileAdmins
```

### Why This Structure

| Rule | Reason |
|---|---|
| **Domain Local groups** go on the ACL | They can contain members from any trusted domain, but can only be applied as permissions within their own domain — matching where the file server lives |
| **Global groups** collect users | Global groups are replicated efficiently and can be assigned into Domain Local groups across domains |
| **No user accounts directly on the ACL** | Impossible to audit at scale; removing access requires hunting every ACL |
| **No Universal groups directly on the ACL** | Universal groups replicate to every Global Catalog; using them on ACLs adds unnecessary replication load |

### Cross-Domain Access

If the NAS is in `corp.example.com` and you need contractors from `partner.example.com` to access the share:

1. A trust exists between the two domains (see [[AD-Domain-Forest-Trusts]])
2. Create a **Global group** in `partner.example.com`: `G-PartnerContractors-Finance`
3. Add it as a member of `DL-Finance-Read` in `corp.example.com`
4. The Domain Local group on the ACL spans the trust transparently

---

## DFS — Distributed File System

"DFS" is two separate Microsoft technologies that share a name and are often deployed together but are architecturally independent.

### DFS Namespace (DFS-N)

DFS Namespace creates a **virtual folder tree** that maps user-facing paths to real shares on real servers.

```
What users see:           What DFS maps it to:
\\corp.example.com\shares\Finance   →   \\fileserver01.corp.example.com\Finance
\\corp.example.com\shares\HR        →   \\fileserver02.corp.example.com\HR
\\corp.example.com\shares\IT        →   \\nas01.corp.example.com\IT
```

The namespace server (usually a domain controller) holds this mapping. When a user opens `\\corp.example.com\shares\Finance`, the DFS client receives a **referral** — a redirect to the actual server — and connects there directly.

#### Why This Matters

- **Path stability**: if `fileserver01` is replaced by `fileserver03`, only the DFS mapping changes. Users' bookmarks and mapped drives (`Z: \\corp.example.com\shares\Finance`) continue to work
- **Location transparency**: users don't know or care which physical server they're hitting
- **Multiple targets**: a single DFS folder can have two or more targets (servers) — DFS selects the nearest or most available one

### DFS Replication (DFS-R)

DFS Replication keeps folders **in sync across two or more servers** using multi-master replication.

Use cases:
- **Branch office replication**: a London office file server holds a local copy of data replicated from HQ, reducing WAN latency for reads
- **Disaster recovery**: a standby server in a DR site mirrors production data
- **Read replicas**: multiple servers hold the same content; DFS-N routes each user to the closest one

> [!important] DFS-N and DFS-R are independent
> You can use DFS Namespace without Replication (one target per folder, just for path stability). You can use DFS Replication without Namespace (just syncing folders, no virtual path). They work together but neither requires the other.

---

## DFS vs. Direct UNC — Key Differences

| Dimension | Direct UNC | DFS Namespace |
|---|---|---|
| **Path example** | `\\fileserver01\Finance` | `\\corp.example.com\shares\Finance` |
| **Resolves to** | That specific server | Whichever target DFS selects |
| **Failover** | None — if the server is down, the path breaks | DFS redirects to an available target automatically |
| **Path stability** | Path must change if server is renamed or replaced | Path stays stable; only DFS mapping changes |
| **Multi-site support** | User always hits the named server, regardless of location | DFS can route each user to their nearest replica |
| **Infrastructure required** | None — works with any server | DFS Namespace role on a server (or DC) |
| **Server name visibility** | Server name is in the path | Server names are hidden behind the namespace |
| **Permissions** | Set on the real server | Set on the real server (DFS is just a pointer) |
| **Best for** | Small environments, test shares, explicit server access | Enterprise environments with multiple sites or servers |

> [!tip] DFS doesn't change permissions
> DFS Namespace only affects *how you find the share*. Once DFS redirects you to `\\fileserver01\Finance`, all permission checking (Kerberos, NTFS ACLs, AD groups) happens on `fileserver01` exactly as if you'd typed its UNC path directly.

### A Concrete Example

**Without DFS:**
```
Helpdesk shortcut: \\fileserver01\Finance
Problem: fileserver01 is decommissioned, replaced by fileserver03
Result: every shortcut, every mapped drive, every hardcoded path breaks
Fix: update every machine's drive mapping — a painful, error-prone rollout
```

**With DFS:**
```
Helpdesk shortcut: \\corp.example.com\shares\Finance  (DFS namespace)
Problem: fileserver01 is decommissioned, replaced by fileserver03
Fix: update the DFS mapping on the namespace server — 30 seconds
Result: all shortcuts and mapped drives continue to work immediately
```

---

## How IIQ Sees File Share Access

IIQ governs **the AD groups on the ACLs**, not the ACLs themselves. The chain from IIQ approval to actual file access:

```
User requests "Finance Read" in IIQ access request
    │
    ▼
IIQ provisioner adds user to G-Finance-Analysts (Global group) via LDAP write
    │
    ▼
G-Finance-Analysts is already nested in DL-Finance-Read
    │
    ▼
DL-Finance-Read is already on the NTFS ACL of \\nas01\Finance with Read & Execute
    │
    ▼
User's next Kerberos login → new ticket includes DL-Finance-Read SID
    │
    ▼
User opens \\corp.example.com\shares\Finance → DFS referral → \\nas01\Finance
NAS reads SID from ticket → DL-Finance-Read matches ACL → Access granted
```

**What IIQ does and does not do:**

| IIQ does | IIQ does not |
|---|---|
| Manage group membership (add/remove users to AD groups) | Crawl NTFS ACLs or read what's on the file system |
| Discover that AD groups exist (via aggregation) | Know which DFS namespace path a group grants access to |
| Store group descriptions / metadata as entitlement context | Create or modify share/NTFS permissions |
| Certify and review group membership | Enumerate every folder a group has access to |

IIQ relies on **naming conventions and group descriptions** to give business meaning to `DL-Finance-Read` — it doesn't verify what that group actually grants on the file system. This is why keeping group names and descriptions accurate is critical for meaningful access certifications.

---

## Related

- [[AD-LDAP-Fundamentals]] — AD group types, `member`/`memberOf` attributes, group scope
- [[AD-Domain-Forest-Trusts]] — AGDLP pattern, trust types, cross-domain group membership rules
- [[AD-Application-Integration]] — Pattern 1: how Kerberos tokens carry SIDs to authorize file share access
- [[AD-Groups-in-IIQ-Governance]] — how IIQ models and governs the Domain Local groups that sit on share ACLs
