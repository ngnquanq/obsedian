# Common Error Codes

## CPM Error Codes (CACPM)

These appear in the `failReason` field of account objects when CPM operations fail. They are critical for troubleshooting password rotation failures.

### Connection Errors

| Code | Description | Common Cause |
|------|-------------|-------------|
| CACPM001 | Cannot connect to target machine | Target is down, firewall blocking, DNS resolution failure |
| CACPM002 | Cannot connect to target — host not found | DNS cannot resolve the target address |
| CACPM012 | Connection timeout | Network latency, firewall silently dropping packets |
| CACPM013 | Connection refused | Target service not running on expected port |

### Authentication Errors

| Code | Description | Common Cause |
|------|-------------|-------------|
| CACPM004 | Authentication failure on target | Password in Vault doesn't match target; needs reconciliation |
| CACPM009 | Account is locked on target system | Too many failed attempts or security policy locked the account |
| CACPM018 | Reconcile account not found or invalid | The reconciliation account is missing, locked, or has wrong credentials |
| CACPM019 | Logon account authentication failure | The logon account used by CPM has incorrect credentials |

### Password Policy Errors

| Code | Description | Common Cause |
|------|-------------|-------------|
| CACPM007 | Password does not meet complexity requirements | Generated password violates the target system's password policy |
| CACPM008 | Password was recently used | Target system's password history policy rejects the new password |
| CACPM010 | Password change not allowed at this time | Target system has time-based restrictions on password changes |

### Target System Errors

| Code | Description | Common Cause |
|------|-------------|-------------|
| CACPM036 | Target system returned an unexpected error | Generic — check CPM logs for details |
| CACPM050 | Target platform plugin error | Custom platform plugin has a bug or misconfiguration |
| CACPM051 | Script execution error | Custom rotation script failed |

### CPM Configuration Errors

| Code | Description | Common Cause |
|------|-------------|-------------|
| CACPM030 | Platform not configured correctly | Platform definition is missing or has invalid settings |
| CACPM031 | Required account property missing | Account is missing a property the platform needs (e.g., Port, Database) |
| CACPM032 | CPM cannot process this account type | Platform/account mismatch |

---

## PVWA API Error Codes (PASWS / ITATS)

These appear in API error responses when calling the PVWA REST API.

### Authentication Errors

| HTTP Status | Code | Description | Solution |
|------------|------|-------------|----------|
| 401 | PASWS001E | Authentication failure | Check username/password |
| 401 | PASWS004E | Session token expired | Re-authenticate (POST /api/auth/.../Logon) |
| 403 | PASWS006E | User does not have permission | Check Safe member permissions |
| 403 | ITATS005E | User is suspended | Contact Vault admin to unsuspend |

### Resource Errors

| HTTP Status | Code | Description | Solution |
|------------|------|-------------|----------|
| 404 | PASWS007E | Account not found | Verify account ID exists |
| 404 | PASWS008E | Safe not found | Verify Safe name (case-sensitive) |
| 404 | PASWS009E | User not found | Verify user ID exists |
| 409 | PASWS010E | Account already exists | Duplicate account detection |
| 409 | PASWS011E | Account is locked | Another user has exclusive access |

### Request Errors

| HTTP Status | Code | Description | Solution |
|------------|------|-------------|----------|
| 400 | PASWS012E | Invalid request parameters | Check request body/query parameters |
| 400 | PASWS013E | Invalid filter syntax | Check OData filter format |
| 400 | PASWS014E | Invalid sort parameter | Check field name in sort parameter |
| 413 | PASWS015E | Request too large | Reduce page size or filter results |

### Server Errors

| HTTP Status | Code | Description | Solution |
|------------|------|-------------|----------|
| 500 | PASWS016E | Internal server error | Check PVWA logs; may need restart |
| 503 | PASWS017E | Vault is unavailable | Vault may be down or unreachable |
| 503 | PASWS018E | Service temporarily unavailable | PVWA is overloaded; retry with backoff |
| 429 | — | Too many requests | Back off; respect Retry-After header |

---

## HTTP Status Code Summary

| Status | Meaning | Dashboard Action |
|--------|---------|-----------------|
| 200 | Success | Normal |
| 400 | Bad request | Fix the API call (your code has a bug) |
| 401 | Unauthorized | Re-authenticate; token expired |
| 403 | Forbidden | Service account lacks permission |
| 404 | Not found | Resource doesn't exist (safe deleted, account removed) |
| 409 | Conflict | Resource locked or duplicate |
| 429 | Rate limited | Back off, wait, retry |
| 500 | Server error | PVWA issue; check health dashboard |
| 503 | Service unavailable | PVWA or Vault is down |

---

## Troubleshooting Tips

### CPM Failures
1. Check the CPM error code in the account's `failReason` field
2. Look at the CPM server logs: `C:\Program Files (x86)\CyberArk\Password Manager\Logs\`
3. Verify network connectivity from CPM to the target system
4. Check if the target system's account is locked or password policy changed

### API Failures
1. Check the HTTP status code and error code in the response body
2. Verify the session token hasn't expired (re-authenticate if 401)
3. Check PVWA IIS logs for detailed error information
4. Verify the service account has appropriate Safe memberships and permissions
