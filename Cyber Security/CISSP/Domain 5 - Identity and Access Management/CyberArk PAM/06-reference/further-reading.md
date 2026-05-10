# Further Reading

## Official CyberArk Documentation

| Resource | Description |
|----------|-------------|
| **CyberArk Documentation Portal** | Official documentation for all CyberArk products. Requires a CyberArk support account. Available at `docs.cyberark.com` |
| **CyberArk REST API Documentation** | Available via Swagger UI on your PVWA: `https://<pvwa>/PasswordVault/swagger/` |
| **CyberArk Marketplace** | Plugins, connection components, platform extensions, and community tools. Available at `cyberark.com/marketplace` |

## Community and Support

| Resource | Description |
|----------|-------------|
| **CyberArk Community** | Forums, knowledge base articles, and best practices shared by CyberArk users and staff |
| **CyberArk Support** | Formal support for licensed customers (requires support contract) |
| **CyberArk University** | Official training and certification programs (CDE, CPC, CSE certifications) |

## Open-Source Tools

| Tool | Description |
|------|-------------|
| **psPAS** | PowerShell module for CyberArk REST API. Wraps all API endpoints in PowerShell cmdlets. Excellent for scripting data extraction for dashboards. GitHub: `psPAS` by Pete Maan |
| **CyberArk Conjur OSS** | Open-source secrets management for DevOps |
| **CyberArk Ansible Collection** | Ansible modules for CyberArk automation |
| **CyberArk Terraform Provider** | Terraform provider for CyberArk PAM |

### psPAS — Highly Recommended

psPAS is particularly useful for building dashboard data pipelines. Instead of writing raw API calls, you can use PowerShell cmdlets:

```powershell
# Example: Get all accounts using psPAS
New-PASSession -Credential $cred -BaseURI "https://<pvwa>/PasswordVault"
$accounts = Get-PASAccount
$accounts | Export-Csv -Path "accounts.csv"
Close-PASSession
```

This is much simpler than writing raw HTTP requests and handling pagination manually.

## Books and Publications

| Title | Relevance |
|-------|-----------|
| **CyberArk PAS Administration Guide** | Official admin guide (bundled with product) — covers all components |
| **NIST SP 800-53** | Security controls framework — PAM maps to AC-6, AU-2, IA-5 controls |
| **Verizon DBIR (Data Breach Investigations Report)** | Annual report showing the role of privileged credential compromise in breaches |

## Related Technologies

| Technology | Relation to CyberArk |
|-----------|----------------------|
| **Active Directory** | Primary identity source for CyberArk users and target accounts |
| **SIEM (Splunk, Sentinel, QRadar)** | Receives PTA security events; data source for security dashboards |
| **ITSM (ServiceNow, BMC)** | Integrates with CyberArk for ticketing-based access approval |
| **Power BI** | Our dashboard tool — connects to CyberArk data via API or staging DB |

## CyberArk Certifications

If you want to deepen your CyberArk expertise:

| Certification | Level | Focus |
|--------------|-------|-------|
| **CDE** (CyberArk Defender) | Foundation | Basic PAM concepts and administration |
| **CSE** (CyberArk Sentry) | Intermediate | Implementation and configuration |
| **CGE** (CyberArk Guardian) | Advanced | Advanced troubleshooting and architecture |
| **CPC** (CyberArk Privilege Cloud Certified) | Specialized | Privilege Cloud deployment (not our model, but useful knowledge) |
