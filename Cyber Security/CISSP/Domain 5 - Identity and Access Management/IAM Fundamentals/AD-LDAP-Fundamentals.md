---
tags: [active-directory, ldap, directory, fundamentals, groups, attributes, cissp, domain-5-iam, cissp/5.2-identification-authentication]
aliases: [Active Directory Basics, LDAP Fundamentals, AD Groups]
---

# AD and LDAP Fundamentals

Before understanding how [[IIQ-AD-LDAP-Connector|SailPoint IIQ connects to Active Directory]], you need a working model of what LDAP and Active Directory actually are. These are the directories where identities and groups live.

---

## Why Active Directory Exists — The Problem It Solves

Imagine a company with 5,000 employees and 200 servers. Without a directory:
- Every server has its own list of usernames and passwords
- When someone joins, IT creates 200 separate accounts
- When someone leaves, IT must remember to disable 200 accounts — and often forgets some
- There is no central answer to "who has access to what?"

**Active Directory solves this by being the single source of truth for identity.**

Every Windows machine in the organisation trusts AD. You log in once with your AD credentials (your `sAMAccountName` (Security Account Manager (SAM) Account Name) and password) and that one login gives you access to file shares, email, applications, and printers — as long as your account is in the right AD groups. When someone leaves, an administrator disables one account in AD, and that person is immediately locked out of everything.

> [!tip] Mental model
> Active Directory is like a company's phone book + security badge system combined. It knows who you are, what department you're in, what doors you're allowed through, and whether your badge is active.

### What About macOS and Linux?

The statement "every Windows machine trusts AD" is accurate but incomplete. macOS and Linux can also authenticate against AD — just with more setup and with some limitations.

| OS | AD Integration | How | Limitations |
|---|---|---|---|
| **Windows** | Native, tight | Built into the OS; just join the domain | None — Group Policy, Kerberos, LDAP all work out of the box |
| **macOS** | Supported, partial | Directory Utility / `dsconfigad` to join the domain; uses LDAP + Kerberos under the hood | **Group Policy does not apply.** Mac-specific policies need a separate MDM tool (Jamf, Mosyle, etc.) |
| **Linux** | Supported, manual | `realmd` + SSSD (most common modern method), or Winbind (Samba), or raw Kerberos + LDAP | Group Policy does not apply. Less seamless; requires admin setup per distro |

#### macOS and AD

A Mac can join an AD domain via **System Settings → Users & Groups → Network Account Server** (or via the `dsconfigad` command line tool). Once joined:
- Users can log in to the Mac with their AD username and password
- The Mac authenticates via Kerberos and looks up accounts via LDAP
- File share access (SMB shares) uses the AD Kerberos ticket — SSO works

What doesn't work natively: Windows Group Policy (GPOs). Enterprises managing Macs use tools like **Jamf Pro** or **Mosyle** alongside AD to push Mac-specific policies (disk encryption, app allowlists, screen lock timers).

#### Linux and AD

The most common approach on modern Linux (RHEL, Ubuntu, CentOS) is:

```bash
# 1. Install tools
sudo apt install realmd sssd adcli   # Ubuntu/Debian
sudo dnf install realmd sssd adcli   # RHEL/Fedora

# 2. Discover the domain
realm discover corp.example.com

# 3. Join the domain (prompts for AD admin credentials)
sudo realm join corp.example.com -U administrator

# 4. Verify — AD users can now log in
id jsmith@corp.example.com
```

After joining via `realmd`/SSSD:
- AD users can SSH into the Linux machine using their AD credentials
- Kerberos tickets are issued just like on Windows
- `sudo` access can be controlled via AD group membership (with additional config)

What doesn't work: Group Policy. Linux policy management is done separately (Ansible, Puppet, Chef, or SELinux policy).

#### Service Accounts on Linux — Keytabs

Linux *services* (web servers, database connectors, IIQ itself) authenticate to AD using a **keytab file** — a stored Kerberos credential for a service account. This is how the IIQ AD connector's bind account works behind the scenes when Kerberos authentication is configured.

> [!note] IIQ doesn't care what OS you use
> IIQ governs the AD account — the `sAMAccountName`, group memberships, and enabled/disabled status. Whether the end user logs in from a Windows laptop, a Mac, or a Linux workstation, they're using the same AD account. IIQ manages that account regardless of the client OS.

---

## What Active Directory Looks Like in Practice

### The Management Tool: Active Directory Users and Computers (ADUC)

Administrators manage AD through a Windows GUI tool called **Active Directory Users and Computers (ADUC)**. It looks like Windows Explorer — a tree on the left, objects on the right.

![ADUC interface showing group member management](https://www.varonis.com/hs-fs/hubfs/Imported%20sitepage%20images/aduc-for-adding-a-new-group-step-3@2x.png)
*The ADUC interface — the left pane shows the OU tree (folders), the right pane shows objects inside the selected OU. Here, a group's Members tab shows who belongs to it. Source: [Varonis](https://www.varonis.com/blog/active-directory-users-and-computers)*

What you see in ADUC:
- **Left pane** — the OU tree, representing the directory hierarchy (`DC=corp,DC=example,DC=com` at the root, then OUs like `Users`, `Groups`, `Computers`)
- **Right pane** — objects inside the selected OU (user accounts, groups, computers)
- **Right-click menu** — create, modify, move, or delete objects
- **Properties dialog** — view/edit all attributes of an object (name, email, group memberships, password settings)

### What the Forest Looks Like (Domain Topology)

![Active Directory forest and domain structure](https://cdn.comparitech.com/wp-content/uploads/2018/12/Active-Directory-forests-domains.jpg)
*An AD forest containing multiple domains. Each domain has its own domain controllers, and the forest provides a shared schema and automatic trust between domains. Source: [Comparitech](https://www.comparitech.com/net-admin/active-directory-forests-domains/)*

### What a Single User Object Looks Like

When you open a user in ADUC and click "Properties", you see tabs with all the user's attributes:

```
General tab:     Full name, description, office, phone, email, web page
Account tab:     sAMAccountName, UPN, logon hours, account expiry, disabled flag
Member Of tab:   List of all AD groups the user belongs to  ← most relevant for IIQ
Profile tab:     Home drive, login script path
```

The **Member Of** tab directly shows what AD security groups a user is in — this is the same data IIQ reads as `memberOf` during aggregation.

### What a Group Object Looks Like

```
General tab:     Group name, description, group scope (Domain Local/Global/Universal),
                 group type (Security/Distribution)
Members tab:     List of users and groups that are members  ← the `member` attribute
Member Of tab:   Groups that this group belongs to (for nested groups)
Managed By tab:  Who is responsible for managing this group
```

> [!note] Connecting ADUC to IIQ
> Everything you see in ADUC maps directly to what IIQ stores. The **Member Of** tab on a user = `spt_identity_entitlement` rows. The **Members** tab on a group = the `member` attribute in `spt_managed_attribute`. The OU path in the left pane = the `distinguishedName` attribute on `spt_link`.

---

## What is LDAP?

**LDAP** (Lightweight Directory Access Protocol) is a protocol for querying and modifying a directory service. Think of it like HTTP for directories: just as HTTP defines how browsers talk to web servers, LDAP defines how applications talk to directory servers.

Key facts:
- Runs on **port 389** (plain) or **port 636** (LDAPS — LDAP over TLS)
- Reads are fast and cheap; directories are optimised for reads over writes
- Data is stored in a hierarchical tree structure called the **Directory Information Tree (DIT)**

> [!note] LDAP vs Active Directory
> LDAP is the protocol. Active Directory is a directory *server* that speaks LDAP (among other protocols). You can use LDAP to query AD just like you use it to query OpenLDAP or any other LDAP-compliant directory.

---

## The Directory Information Tree (DIT)

Data in an LDAP directory is organised as a tree. Each node in the tree is an **entry** (an object), and each entry has a unique address called a **Distinguished Name (DN)**.

### DN Components

| Abbreviation | Full Name | Meaning | Example |
|---|---|---|---|
| **DC** | Domain Component | Part of the domain name | `DC=corp,DC=example,DC=com` |
| **OU** | Organisational Unit | A folder/container | `OU=Finance,OU=Users` |
| **CN** | Common Name | The object's name | `CN=John Smith` |

A full DN reads right-to-left from root to leaf:

```
CN=John Smith,OU=Finance,OU=Users,DC=corp,DC=example,DC=com
```

This means: the user "John Smith" is in the Finance sub-OU of the Users OU, in the domain `corp.example.com`.

> [!tip] Reading DNs
> Read a DN like a file path, but backwards. The domain components (`DC=`) are the root, OUs are folders, and CN is the object at the end.

---

## LDAP Object Classes

Every entry in an LDAP directory belongs to one or more **object classes**, which define what attributes the entry must or may have.

| Object Class | Represents | Key Attributes |
|---|---|---|
| `person` | A human being | `cn`, `sn` (surname) |
| `organizationalPerson` | A person in an org | `telephoneNumber`, `title` |
| `inetOrgPerson` | Internet-standard person | `mail`, `uid`, `jpegPhoto` |
| `organizationalUnit` | A folder/container | `ou` |
| `groupOfNames` | A group (LDAP standard) | `member`, `cn` |
| `posixGroup` | A Unix group | `gidNumber`, `memberUid` |

Active Directory adds its own proprietary object classes on top of these.

---

## What is Active Directory?

Active Directory (AD) is Microsoft's directory service, first released with Windows 2000. It is the dominant enterprise directory for on-premises environments.

AD is built on three main technologies:
1. **LDAP** — for storing and querying objects (users, groups, computers)
2. **Kerberos** — for authentication (Windows login, SSO)
3. **DNS** — for locating domain controllers and services

> [!note] Azure AD / Entra ID
> Azure AD (now rebranded as Microsoft Entra ID) is Microsoft's cloud directory. It is related to but architecturally distinct from on-premises AD — it does not use LDAP or Kerberos internally. Many organisations sync their on-prem AD to Azure AD using **Azure AD Connect**.

---

## AD Object Types

| Object | What It Represents | Key Attributes |
|---|---|---|
| **User** | A person's account | `sAMAccountName`, `userPrincipalName`, `distinguishedName` |
| **Group** | A collection of users (or other objects) | `member`, `groupType`, `distinguishedName` |
| **Computer** | A domain-joined machine | `dNSHostName`, `operatingSystem` |
| **OrganisationalUnit** | A container for objects | `ou`, `description` |
| **Contact** | External person (no login) | `mail`, `displayName` |

---

## AD Groups — Types and Scope

Groups are the primary mechanism for granting access in AD. A user is added to a group; the group is granted a permission; the user inherits that permission. Understanding group types is essential.

### Security vs. Distribution Groups

| | Security Group | Distribution Group |
|---|---|---|
| **Purpose** | Controlling access to resources | Email distribution lists only |
| **Can assign permissions** | Yes | No |
| **Used by IIQ** | Yes — these are the entitlements that matter | Rarely |

> [!warning] Distribution groups and IIQ
> Distribution groups cannot be used to control access to systems. IIQ typically only governs security groups. If you see a group with no apparent permissions, it may be a distribution group.

### Group Scope — The Critical Dimension

Scope controls **who can be a member** and **where the group can be used**. This is covered in depth in [[AD-Domain-Forest-Trusts]], but here is the summary:

| Scope | Members Can Come From | Can Be Used (Assign Permissions) In |
|---|---|---|
| **Domain Local** | Any trusted domain or forest | Own domain only |
| **Global** | Same domain only | Any trusted domain |
| **Universal** | Any domain in the forest | Any domain in the forest |

> [!tip] Rule of thumb
> **Universal groups** are the most flexible but have replication overhead — they replicate to every Global Catalog server. Use them when you genuinely need cross-domain membership. Use **Global groups** for same-domain collections, and **Domain Local groups** to assign permissions on local resources.

---

## Group Nesting

Groups can contain other groups. This is called **nesting**.

```
Business Role: "Finance Analyst"  (Universal group)
    └── IT Role: "SAP Finance Read"  (Global group)
            └── AD Security Group: "SG-SAP-FI-READ"  (Domain Local)
                    └── User: John Smith
```

Nesting means a user's effective permissions come from all groups they are a member of, directly or through nested membership.

> [!warning] Nesting depth
> Deep nesting (5+ levels) makes it very hard to audit who has what access. IIQ's role model helps by making role membership explicit and visible.

---

## The `member` and `memberOf` Attributes

Group membership is stored in two complementary attributes:

| Attribute | Lives On | Contains |
|---|---|---|
| `member` | The **group** object | DNs of all members (users, nested groups) |
| `memberOf` | The **user** object | DNs of all groups the user belongs to |

These are kept in sync automatically by AD. When you add a user to a group via `member`, AD adds the group to the user's `memberOf` — and vice versa.

> [!note] LDAP query pattern
> To find all groups a user belongs to:
> `(&(objectClass=user)(sAMAccountName=jsmith))`  → read `memberOf` attribute
>
> To find all members of a group:
> `(&(objectClass=group)(cn=SG-Finance-Read))` → read `member` attribute

---

## Key AD User Attributes

These are the attributes IIQ reads when it aggregates an AD account:

| Attribute | Description | Example |
|---|---|---|
| `sAMAccountName` | Pre-Windows 2000 login name; unique within domain | `jsmith` |
| `userPrincipalName` | Modern login (email format); unique in forest | `jsmith@corp.example.com` |
| `distinguishedName` | Full LDAP path; globally unique | `CN=John Smith,OU=Finance,...` |
| `objectGUID` | Permanent unique identifier; never changes even on rename | `{a3f2...}` |
| `objectSID` | Security identifier used for permission grants | `S-1-5-21-...` |
| `displayName` | Full name shown in directory | `John Smith` |
| `mail` | Email address | `john.smith@example.com` |
| `department` | Department attribute | `Finance` |
| `userAccountControl` | Bitfield encoding account status (enabled/disabled/locked) | `512` = normal enabled |
| `memberOf` | List of group DNs this user belongs to | `[CN=SG-Finance,...]` |
| `whenCreated` / `whenChanged` | Account creation and last modification timestamps | |
| `pwdLastSet` | When password was last changed | |

> [!tip] IIQ and `objectGUID`
> IIQ uses `objectGUID` as the stable identifier for an AD account. Even if a user is renamed or moved to a different OU, the GUID stays the same, so IIQ can still correlate the account to the correct identity.

---

## Key AD Group Attributes

| Attribute | Description |
|---|---|
| `cn` | Group name |
| `distinguishedName` | Full LDAP path |
| `objectGUID` | Permanent unique ID |
| `objectSID` | Security identifier (used in ACLs) |
| `groupType` | Encoded integer: scope + security/distribution flag |
| `member` | Multi-valued list of member DNs |
| `description` | Human-readable purpose of the group |
| `managedBy` | DN of the group's owner/manager |

---

## Related

- [[IAM-Overview]] — how LDAP and AD fit into the broader IAM stack
- [[AD-Domain-Forest-Trusts]] — domain and forest topology; group scope rules in depth
- [[AD-Application-Integration]] — how applications actually consume AD groups (Kerberos, LDAP bind, SAML, PAM)
- [[IIQ-AD-LDAP-Connector]] — how IIQ reads these attributes during aggregation
- [[AD-Groups-in-IIQ-Governance]] — how AD groups become governed entitlements
