# CPM (Central Policy Manager)

## What It Is

The CPM is CyberArk's **password rotation engine**. It automatically changes, verifies, and reconciles passwords on target systems based on platform policies. CPM is what makes CyberArk "manage" passwords rather than just "store" them.

Without CPM, CyberArk would just be an encrypted password vault. With CPM, passwords are rotated automatically, ensuring that even if a credential is stolen, it becomes useless after the next rotation.

## The Three CPM Operations

### 1. Verify
**"Does the password in the Vault match the target?"**
- CPM connects to the target system using the stored password
- If authentication succeeds → password is verified ✓
- If authentication fails → password is out of sync, triggers reconciliation
- Verification runs on a configurable schedule (e.g., every 7 days)

### 2. Change (Rotate)
**"Change the password to something new."**
- CPM generates a new password according to the platform's complexity rules
- CPM connects to the target system and changes the password
- CPM stores the new password in the Vault
- The old password is retained as a previous version (for rollback)
- Change runs on a configurable schedule (e.g., every 30 days) or on-demand

### 3. Reconcile
**"The password is out of sync — force reset it."**
- Triggered when verification fails (Vault password doesn't work on target)
- CPM uses a **reconciliation account** (a higher-privileged account like a domain admin) to force-reset the password on the target
- This is a recovery mechanism — reconciliation means something went wrong

```
Normal flow:     Verify ✓ ──► Change ──► Verify ✓ ──► Change ──► ...

Failure flow:    Verify ✗ ──► Reconcile ──► Change ──► Verify ✓ ──► ...
```

## CPM Status Values

These status values are **critical for dashboards** — they tell you the health of password management:

| Status | Meaning | Dashboard Action |
|--------|---------|-----------------|
| **Success** | Last CPM operation succeeded | Good — account is healthy |
| **Failure** | Last operation failed | Alert — investigate the error |
| **InProcess** | CPM is currently working on this account | Normal if transient |
| **WillNotChange** | CPM determined it cannot change this account | Investigate — possible config issue |
| **CPMDisabled** | CPM management is disabled for this account | May be intentional or may need attention |

### CPMDisabled Reasons
When CPM is disabled, there's a reason field:

- **Manual**: An admin explicitly disabled CPM for this account
- **Policy**: The platform policy disables automatic management
- **InitializedNoManage**: Account was onboarded but CPM management was not enabled
- **PasswordNeverExpires**: Account is configured to never rotate

## Key Account Timestamps

CPM operations produce timestamps that are essential for dashboards:

| Field | Meaning |
|-------|---------|
| `LastModifiedTime` | When the password was last changed (rotated) |
| `LastVerifiedTime` | When the password was last verified against the target |
| `LastReconciledTime` | When the password was last reconciled (force-reset) |
| `LastTask` | The last CPM operation type (change/verify/reconcile) |
| `LastFailDate` | When the last failure occurred |
| `LastFailReason` | Why the last failure occurred (error description) |

**Password Age** = Current Time − LastModifiedTime

## CPM Architecture

- CPM runs as a Windows service
- Connects to the Vault on port 1858 to retrieve and update credentials
- Connects to target systems using their native protocols (RDP, SSH, SQL, LDAP, etc.)
- Each CPM instance manages accounts assigned to it (via the Safe's "ManagingCPM" property)
- Multiple CPM instances can be deployed for scalability

```
┌─────────┐     1858     ┌─────────┐
│   CPM   │─────────────►│  Vault  │
│ (pulls  │              │(stores  │
│  tasks) │              │ creds)  │
└────┬────┘              └─────────┘
     │
     │  Native protocols
     │  (RDP, SSH, SQL, LDAP, API...)
     ▼
┌─────────────────────────────────┐
│        Target Systems           │
│  Windows  Linux  DBs  Network   │
└─────────────────────────────────┘
```

## Dashboard Relevance

CPM data is the backbone of password management dashboards:

- **Rotation success rate**: % of accounts where last CPM change = Success
- **Failed rotations**: Count and list of accounts where last CPM change = Failure
- **Password age distribution**: Histogram of (now - LastModifiedTime) across all accounts
- **Accounts overdue for rotation**: Accounts where password age > policy threshold
- **CPM disabled accounts**: Count and reasons
- **Reconciliation frequency**: High reconciliation rates indicate systemic issues
- **CPM queue depth**: How many operations are pending (available via System Health API)
- **Top failure reasons**: Aggregate LastFailReason to find common issues

## Common CPM Failure Reasons

| Error Code | Description |
|------------|-------------|
| CACPM001 | Cannot connect to target machine |
| CACPM004 | Authentication failure on target |
| CACPM007 | Password does not meet complexity requirements |
| CACPM009 | Account is locked on target system |
| CACPM012 | Timeout connecting to target |
| CACPM018 | Reconcile account not found or invalid |
| CACPM036 | Target system returned an unexpected error |

See [Common Error Codes](../06-reference/common-error-codes.md) for a more complete list.
