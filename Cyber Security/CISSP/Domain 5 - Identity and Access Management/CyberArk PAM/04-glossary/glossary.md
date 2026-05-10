# CyberArk Glossary

A-Z reference of CyberArk and PAM terminology.

---

## A

**AAM (Application Access Manager)**
A CyberArk module that allows applications (not humans) to retrieve privileged credentials from the Vault programmatically. Ensures applications don't have hardcoded passwords. Formerly called AIM.

**Account**
A privileged credential managed by CyberArk. An account consists of a username, address (target system), platform, and the secret itself (password, SSH key, etc.). Accounts are stored inside Safes. This is the central entity in CyberArk.

**Account Discovery**
The automated process of scanning target systems (Active Directory, servers, databases) to find privileged accounts that are not yet managed by CyberArk. Discovered accounts appear as "pending" until onboarded.

**Address**
The target machine or service associated with an account — e.g., a server hostname, IP address, database server, or domain name. Used by CPM to know where to rotate the password and by PSM to know where to connect.

**AIM (Application Identity Manager)**
Legacy name for AAM. You may see this in older documentation or installed component names.

## B

**Break-Glass**
An emergency procedure that bypasses normal approval workflows to access a privileged account urgently. Break-glass events are heavily audited and should appear on dashboards as a security metric.

## C

**CCP (Central Credential Provider)**
A web service component of AAM that applications call to retrieve credentials from the Vault via REST. Runs as an IIS web service on Windows.

**Check-In / Check-Out**
A workflow where a user "checks out" a privileged account (gains exclusive access), uses it, then "checks it in" when done. While checked out, no other user can access that account. The password can be rotated automatically after check-in.

**Connection Component**
A PSM configuration that defines how a session is established to a target — e.g., PSM-RDP (Remote Desktop), PSM-SSH (SSH terminal), PSM-WinSCP (file transfer). Determines what protocol and client the user sees.

**Conjur**
CyberArk's secrets management solution for DevOps, containers, and CI/CD pipelines. Available as open-source (Conjur OSS) and Enterprise. Separate from core PAM.

**CPM (Central Policy Manager)**
The component that automatically rotates (changes), verifies, and reconciles passwords on target systems. CPM is the engine behind password management. Each CPM instance can manage thousands of accounts.

**CPM Status**
The result of the last CPM operation on an account. Key values: `Success`, `Failure`, `InProcess`, `WillNotChange`, `CPMDisabled`. Critical for password management dashboards.

## D

**Digital Vault**
See: Vault.

**DR Vault (Disaster Recovery Vault)**
A replica of the primary Vault that receives continuous replication. If the primary Vault fails, the DR Vault can be promoted to take over. Dashboard metric: last successful replication time.

**Dual Control**
A security workflow requiring one or more approvers to authorize access before a user can retrieve or use a privileged credential. Also called "dual authorization" or "approval workflow."

## E

**EPM (Endpoint Privilege Manager)**
A separate CyberArk product (not core PAM) that enforces least privilege on endpoints — application control, privilege elevation/de-elevation on workstations and servers.

**EPV (Enterprise Password Vault)**
Legacy name for the CyberArk Vault. The installed service is still called "PrivateArk Server." You may see "EPV" in older documentation.

**Exclusive Access**
A setting that ensures only one user can access an account at a time. When enabled, the account must be checked out/checked in. Prevents credential sharing.

## H

**Hardened Vault OS**
The CyberArk Vault runs on a purpose-built hardened Windows Server with most services disabled, no internet access, and custom firewall rules. This is a key security differentiator.

## L

**Logon Account**
A separate privileged account that CPM uses to log in to a target system in order to rotate another account's password. For example, a domain admin account used by CPM to reset local admin passwords on servers.

## M

**Master Policy**
A global set of rules that apply to all platforms and accounts by default. Includes settings like: require dual control, enforce check-in/check-out, password rotation frequency, require session recording. Individual platforms can override Master Policy settings.

## O

**Object**
The generic term for anything stored in the Vault: passwords, SSH keys, files, certificates, API keys. Accounts are a specific type of object.

**Onboarding**
The process of bringing a discovered or manually identified privileged account into CyberArk management — assigning it to a Safe, associating it with a Platform, and enabling CPM management.

**OTP (One-Time Password)**
A configuration where the password is automatically changed after each use (each check-in). Ensures no password reuse and provides maximum credential isolation.

## P

**PACLI (PrivateArk Command Line Interface)**
A command-line tool for interacting with the Vault directly (bypassing PVWA). Used for administrative tasks, scripting, and automation. Not commonly used for dashboards.

**Password Rotation**
The automated process of changing a privileged account's password on both the target system and in the Vault. Performed by CPM on a schedule or on-demand.

**Password Verification**
CPM's process of checking that the password stored in the Vault matches the actual password on the target system. If they don't match, reconciliation is triggered.

**Platform**
A configuration template that defines how CyberArk manages a specific type of account. Specifies: rotation method, verification method, connection component, timeouts, and other behaviors. Examples: `WinDomain`, `UnixSSH`, `Oracle`, `CiscoIOS`. Also historically called a "Policy."

**Privilege Cloud**
CyberArk's SaaS offering. Not our deployment model — we use Self-Hosted.

**PrivateArk Client**
A thick client (Windows desktop application) for direct Vault administration. Used by Vault admins for tasks like safe creation, user management, and troubleshooting. Not a web interface.

**PSM (Privileged Session Manager)**
The component that acts as a secure proxy for privileged sessions. Users connect to the PSM, which then connects to the target on their behalf. All sessions are isolated and recorded.

**PSMP (PSM for SSH Proxy)**
A Linux-based component that proxies SSH sessions. The Windows PSM handles RDP; PSMP handles SSH/SFTP.

**PSMConnect**
A Windows account on the PSM server used to establish RDP connections to target machines. PSM logs in as PSMConnect and injects the privileged credential.

**PSMAdminConnect**
Similar to PSMConnect but used for administrative/monitoring connections to the PSM server itself.

**PTA (Privileged Threat Analytics)**
The CyberArk component that performs behavioral analytics on privileged access. Detects anomalies such as: suspected credential theft, unmanaged privileged accounts, unusual access patterns. Generates risk scores and security events.

**PVWA (Password Vault Web Access)**
The web-based interface for CyberArk. Also serves as the REST API gateway. Users interact with CyberArk primarily through PVWA. Dashboards pull data from PVWA's REST API.

## R

**Reconcile / Reconciliation**
The process of forcibly resetting a password on the target system when the Vault and target are out of sync (verification fails). Uses a reconciliation account (a higher-privileged account) to force the password change.

**Reconciliation Account**
A privileged account (often a domain admin or root) that CPM uses as a fallback to force-reset a password when normal rotation fails. Defined per platform or per account.

**Risk Score**
A numeric value (typically 0-100) assigned by PTA to a session or event indicating the level of suspected risk. Higher scores indicate more suspicious behavior. Sessions with high risk scores should appear on security dashboards.

## S

**Safe**
A logical container within the Vault that holds accounts and other objects. Safes are the primary unit of access control — permissions are assigned at the Safe level. Think of a Safe as a secure folder.

**Safe Member**
A user or group that has been granted permissions on a specific Safe. Each Safe Member has a defined set of permissions (e.g., list accounts, retrieve passwords, manage accounts).

**Secret Type**
The type of credential stored: `password`, `key` (SSH key), or `file`. Determines how CPM manages the credential.

**Session Recording**
A video-like recording of a privileged session captured by PSM. Stored in the Vault. Can be played back through PVWA for auditing. Recordings cannot be accessed programmatically via API — they are viewed through the PVWA UI.

**System Safe**
Built-in Safes created during CyberArk installation. Examples: `System`, `VaultInternal`, `PasswordManager`, `PVWAConfig`, `PVWAReports`, `PVWATicketingSystem`. These should be excluded from dashboard account counts.

## T

**Transparent Connection**
A PSM mode where users connect directly from their native client (RDP client, SSH client) through PSM without going through the PVWA web interface. PSM intercepts and proxies the connection.

## V

**Vault**
The CyberArk Digital Vault — the central, hardened, encrypted server that stores all privileged credentials. All other components (PVWA, CPM, PSM, PTA) connect to the Vault. Also called "EPV Server" or "PrivateArk Server."

**Vault ID**
A unique identifier assigned to each object stored in the Vault. Used internally but sometimes visible in API responses and logs.

## W

**WebConnect**
A PVWA feature that allows users to launch privileged web sessions (to web applications or management consoles) through PSM.

---

## Authentication Terms

**CyberArk Authentication**
Local Vault authentication using username/password stored in the Vault itself.

**LDAP Authentication**
Authentication against an LDAP directory (typically Active Directory). Most common in enterprise deployments.

**RADIUS Authentication**
Authentication via RADIUS protocol, often used for MFA (multi-factor authentication) integration.

**SAML Authentication**
Single Sign-On authentication using SAML 2.0 identity providers. Browser-based; not ideal for API/dashboard automation.

**PKI Authentication**
Certificate-based authentication to the Vault. Used for high-security administrative access.
