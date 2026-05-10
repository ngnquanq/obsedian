# Why PAM Matters

## The Security Case

Privileged accounts are the most valuable targets in any cyberattack:

- **80% of data breaches** involve compromised privileged credentials (Verizon DBIR)
- Attackers who gain privileged access can move laterally, escalate privileges, exfiltrate data, and cover their tracks
- Many high-profile breaches (Target, SolarWinds, Colonial Pipeline) involved compromised privileged credentials
- Service accounts with static, never-rotated passwords are especially dangerous — they often have broad access and no human monitoring them

Without PAM, privileged credentials are:
- Shared informally ("the root password is on that sticky note")
- Never rotated (same password for years)
- Scattered in scripts, config files, spreadsheets
- Used without any audit trail
- Impossible to revoke quickly when an employee leaves

## Compliance and Regulatory Drivers

Almost every major compliance framework requires controls over privileged access. PAM is often a primary control mechanism:

### SOX (Sarbanes-Oxley)
- Requires controls over access to financial systems
- Privileged access to ERP systems, databases, and servers must be audited
- PAM provides: access control, audit logs, session recordings

### PCI-DSS (Payment Card Industry Data Security Standard)
- **Requirement 2**: Do not use vendor-supplied defaults for system passwords
- **Requirement 7**: Restrict access to cardholder data by business need-to-know
- **Requirement 8**: Assign unique ID to each person with computer access
- **Requirement 10**: Track and monitor all access to network resources and cardholder data
- PAM provides: unique accountability for shared accounts, password rotation, session recording

### HIPAA (Health Insurance Portability and Accountability Act)
- Requires access controls and audit trails for systems handling PHI (Protected Health Information)
- PAM provides: role-based access, session monitoring, audit logs

### GDPR (General Data Protection Regulation)
- Requires "appropriate technical measures" to protect personal data
- Requires ability to demonstrate who accessed what data and when
- PAM provides: access control, detailed audit logs, session recordings

### ISO 27001
- **A.9 Access Control**: Privileged access rights shall be restricted and controlled
- **A.12 Operations Security**: Logging and monitoring requirements
- PAM provides: centralized privileged access control, comprehensive logging

### NIST 800-53
- **AC-6 (Least Privilege)**: Employ the principle of least privilege
- **AU-2 (Audit Events)**: Audit privileged function execution
- **IA-5 (Authenticator Management)**: Manage credentials (rotate, protect, revoke)
- PAM provides: least privilege enforcement, audit of all privileged activity, automated credential management

## Business Risk Reduction

Beyond compliance checkboxes, PAM reduces real business risks:

| Risk | Without PAM | With PAM |
|------|-------------|----------|
| **Credential theft** | Attacker uses stolen admin password indefinitely | Password was rotated 2 hours ago — stolen credential is useless |
| **Insider threat** | Admin with root access has no oversight | All sessions recorded, anomalies flagged by PTA |
| **Employee departure** | Which systems did they have admin access to? | Centralized access records; revoke vault access = revoke all privileged access |
| **Audit failure** | Cannot prove who accessed what | Complete audit trail with session recordings |
| **Ransomware spread** | Attacker uses domain admin to encrypt everything | Domain admin password is vaulted and rotated; access requires approval |

## Why This Matters for Dashboards

Every compliance framework listed above requires **evidence**. Dashboards are how you produce that evidence efficiently:

- **"Show me all accounts that haven't rotated in 90 days"** → Password rotation dashboard
- **"Prove that all privileged sessions are recorded"** → Session monitoring dashboard
- **"Who has access to financial system credentials?"** → Compliance/entitlement dashboard
- **"Are all PAM components operational?"** → System health dashboard
- **"Flag any suspicious privileged activity"** → Threat detection dashboard

CyberArk provides the raw data through its REST API and audit logs. Power BI is the tool we use to turn that data into actionable compliance evidence and operational visibility.
