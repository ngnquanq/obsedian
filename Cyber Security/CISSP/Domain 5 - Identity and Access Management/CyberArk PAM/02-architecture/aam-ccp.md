# AAM / CCP (Application Access Manager / Central Credential Provider)

## What It Is

AAM (Application Access Manager) enables **applications** — not humans — to retrieve privileged credentials from the Vault. This eliminates hardcoded passwords in scripts, configuration files, and application code.

The most common deployment of AAM is the **CCP (Central Credential Provider)**, a web service that applications call to get credentials.

## The Problem AAM Solves

Without AAM, application credentials are often:
- Hardcoded in source code or config files
- Stored in plaintext in scripts
- Shared across environments (dev/staging/prod use the same password)
- Never rotated (because changing them might break the application)

AAM ensures applications get their credentials from the Vault at runtime, and those credentials can be rotated by CPM without breaking the application.

## How CCP Works

```
┌─────────────┐    HTTPS    ┌─────────────┐    1858    ┌─────────────┐
│ Application │────────────►│    CCP      │───────────►│   Vault     │
│ (web app,   │  GET cred   │ (IIS web    │  retrieve  │ (credential │
│  script,    │◄────────────│  service)   │◄───────────│  storage)   │
│  service)   │  password   │             │  password   │             │
└─────────────┘             └─────────────┘             └─────────────┘
```

1. Application calls CCP's REST endpoint with: AppID, Safe, Object name
2. CCP authenticates the application (by IP, OS user, hash, certificate, or path)
3. CCP retrieves the credential from the Vault
4. CCP returns the credential to the application
5. Application uses the credential to connect to its target (database, API, etc.)

## Application Authentication Methods

CCP verifies the calling application's identity using one or more of:

| Method | How It Works |
|--------|-------------|
| **IP Address** | Only allows requests from specific IPs |
| **OS User** | Validates the operating system user running the application |
| **Path** | Validates the file path of the calling application |
| **Hash** | Validates the binary hash of the calling application |
| **Certificate** | Validates a client certificate presented by the application |

Multiple methods can be combined for stronger authentication (defense in depth).

## Other AAM Variants

| Variant | Description |
|---------|-------------|
| **CCP** (Central Credential Provider) | Centralized web service (most common) |
| **CP** (Credential Provider) | Agent installed on the application server (legacy) |
| **Conjur** | For DevOps/cloud-native (Kubernetes, CI/CD) |
| **Secrets Hub** | Syncs CyberArk secrets to cloud-native stores (AWS Secrets Manager, Azure Key Vault) |

## Dashboard Relevance

AAM/CCP is less central to dashboards than CPM or PSM, but provides useful metrics:

- **Application credential retrieval count** — how many times applications request credentials (volume indicator)
- **Retrieval success vs failure rate** — failures may indicate misconfigured applications
- **Top applications by retrieval count** — which apps are most active
- **Application inventory** — how many applications are integrated with CyberArk

### Data Access

Application access data is available through:
- Account activity logs (`GET /api/Accounts/{id}/Activities`) — shows CCP retrieval events
- PVWA audit logs
- CCP's own logs (on the CCP server)

## When AAM Is Not Deployed

If your organization has not licensed or deployed AAM/CCP:
- Applications may still have hardcoded credentials
- There will be no application retrieval data for dashboards
- This is itself a dashboard insight: "X accounts are used by applications but not managed through AAM"
