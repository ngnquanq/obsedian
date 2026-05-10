# Codex — Benchmark Results

## Q01

**Question:** What are the two most important files to read first when entering this vault?

**Answer:**

Reading additional input from stdin...
OpenAI Codex v0.130.0
--------
workdir: /home/nhatquang/Knowledge
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, /home/nhatquang/.codex/memories]
reasoning effort: medium
reasoning summaries: none
session id: 019e11db-868c-7c91-930c-76e0fe270722
--------
user
You are working in a personal knowledge vault. Start by reading `README.md` to orient yourself. Use `knowledge-index.md` to locate specific notes. Do not scan the entire vault — route through the index first.

What are the two most important files to read first when entering this vault?
warning: Codex's Linux sandbox uses bubblewrap and needs access to create user namespaces.
2026-05-10T12:27:42.143313Z ERROR rmcp::transport::worker: worker quit with fatal: Transport channel closed, when AuthRequired(AuthRequiredError { www_authenticate_header: "Bearer error=\"invalid_request\", error_description=\"No access token was provided in this request\", resource_metadata=\"https://api.githubcopilot.com/.well-known/oauth-protected-resource/mcp/\"" })
codex
I’ll read the vault entrypoint first, then check the index only for the specific orientation guidance the README points to.
exec
/bin/bash -lc "sed -n '1,220p' knowledge-index.md" in /home/nhatquang/Knowledge
exec
/bin/bash -lc "sed -n '1,220p' README.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Index

Flat index of every major area in this vault. Load this file first to orient without scanning 425 files. One entry per note: path → what it covers.

---

## Cyber Security

### CISSP
- `Cyber Security/CISSP/CISSP - Index.md` — top-level map of all 8 CISSP domains; only Domain 5 has notes
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` — Domain 5 MOC and reading path

### IAM Fundamentals
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/IAM-Overview.md` — what IAM is and how the stack fits together
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-LDAP-Fundamentals.md` — Active Directory and LDAP basics; group types, memberOf, ADUC
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-Domain-Forest-Trusts.md` — domain topology, forest trusts, group scope rules
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Authentication-Factors-MFA.md` — MFA types and authentication factors
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/OAuth2-OIDC.md` — OAuth2 and OpenID Connect protocols
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Access-Control-Models.md` — DAC, MAC, RBAC, ABAC models
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Physical-vs-Logical-Access.md` — physical vs logical access controls
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Privilege-Escalation-Service-Accounts.md` — privilege escalation paths and service account risks

### SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` — business context for IIQ: identity cube, aggregation, entitlements, roles, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ.md` — complete spt_* schema reference; all tables, columns, joins
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Field-Values.md` — status codes, type enumerations, flag values for all tables
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Data-Flows.md` — step-by-step flows: aggregation, refresh, JML, requests, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md` — how IIQ connects to AD; aggregation types, delta/DirSync, connector gap
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Analyst-Playbook.md` — 60+ SQL recipes for common business questions
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/AD-Groups-in-IIQ-Governance.md` — how AD groups become governed entitlements in IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/CyberArk-IIQ-Integration.md` — three integration patterns between CyberArk PAM and SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/PrivilegedA-Account-Data-Queries.md` — MySQL queries for PRIV_*_A privileged accounts

---

## Statistics

- `Statistics/Statistics.md` — top-level MOC for all statistics topics
- `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` — method selection guide: DiD, matching, RDD, synthetic control
- `Statistics/Causal Inference/Causal Inference.md` — entry point to 25-chapter causal inference study notes
- `Statistics/AB Testing/AB Testing fundamental.md` — A/B testing fundamentals
- `Statistics/Statistical thinking.md` — statistical thinking principles
- `Statistics/Causal Inference/_Source/` — raw imported Python Causality Handbook; not authoritative

---

## Deep Learning

- `Deep Learning/Deep Learning.md` — domain MOC; all subfields and entry points
- `Deep Learning/NLP/NLP.md` — NLP entry point; most developed subfield in this vault
- `Deep Learning/NLP/LLMOps/LLMOps.md` — LLM operations and deployment
- `Deep Learning/NLP/LLMs/Building Production-Grade LLM apps.md` — production LLM application patterns
- `Deep Learning/NLP/LLMs/Multi-Agent LLMs.md` — multi-agent LLM architectures
- `Deep Learning/Foundations/Loss function.md` — loss functions overview
- `Deep Learning/Computer Vision/Generate Image.md` — image generation entry point
- `Deep Learning/XAI/Trustworthy and Explainable AI.md` — XAI and model interpretability
- `Deep Learning/GNN/Advanced GNN.md` — graph neural networks
- `Deep Learning/Open Source/HuggingFace open source.md` — HuggingFace ecosystem

---

## Machine Learning

- `Machine Learning/Machine Learning.md` — domain MOC; clustering and regression
- `Machine Learning/Clustering algorithm/Clustering Algorithm.md` — clustering methods
- `Machine Learning/Regression algorithm/Regression Algorithm.md` — regression methods

---

## Finance

- `Finance/Finance.md` — domain MOC; corporate finance and bank management
- `Finance/Corporate Finance.md` — corporate finance section index
- `Finance/Bank Management and Strategy.md` — bank management section index

---

## Projects

- `Projects/Project List.md` — project registry with status and next actions
- `Projects/Causal IAM Risk Analytics.md` — causal analysis of IAM risk (Idea/MVP)
- `Projects/Fraud Detection using ML.md` — fraud detection project (Draft)
- `Projects/Neural Style Transfer.md` — neural style transfer (Active)

---

## Playbooks

- `Playbooks/Start a New Project.md` — steps to initialize a new project in this vault
- `Playbooks/Causal Analysis Checklist.md` — method selection and data readiness for causal inference
- `Playbooks/Evaluate a Dataset.md` — dataset assessment before starting analysis

 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Vault

Personal knowledge base for CISSP exam preparation, enterprise IAM, data science, and machine learning. Notes are written for long-term retention — every note is independently useful weeks after it was written.

For writing standards and folder conventions, see `CLAUDE.md`.

---

## Where to Start

Route by task:

| I want to... | Start here |
|---|---|
| Study IAM / access control / identity governance | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` |
| Understand SailPoint IIQ or CyberArk | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` |
| Study causal inference methods | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` |
| Find or review a project | `Projects/Project List.md` |
| Navigate any domain | `knowledge-index.md` |
| Understand the full CISSP curriculum | `Cyber Security/CISSP/CISSP - Index.md` |

---

## Source Priority

When multiple notes cover the same topic, prefer in this order:

1. **Project notes** (`Projects/`) — current applied context
2. **Domain index / MOC notes** — authoritative navigation layer
3. **Concept notes** — detailed topic explanations
4. **`_Source/` folders** — raw imported material, not the owner's final opinion

Do not treat `_Source/` content as advice or conclusions. It is reference material only.

---

## Domain Map

| Domain | MOC / Entry Point | Status |
|---|---|---|
| Cyber Security — IAM | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` | Active |
| Cyber Security — CISSP | `Cyber Security/CISSP/CISSP - Index.md` | Active (Domain 5 only) |
| Statistics — Causal Inference | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` | Active |
| Statistics | `Statistics/Statistics.md` | Active |
| Deep Learning | `Deep Learning/Deep Learning.md` | Study notes |
| Machine Learning | `Machine Learning/Machine Learning.md` | Study notes |
| Finance | `Finance/Finance.md` | Study notes |
| Projects | `Projects/Project List.md` | Active |
| Playbooks | `Playbooks/` | Active |

---

## Rules

- Always read the domain MOC or index note before diving into deep concept notes
- `_Source/` folders contain raw imported material — do not treat as authoritative
- Notes link bidirectionally — if note A links to B, B links back to A
- A note with `status: stale` in its frontmatter may be outdated — verify before using
- Wikilinks (`[[Note Name]]`) are Obsidian-specific; resolve them as relative file paths

---

## Status Guide

| Status | Meaning |
|---|---|
| `active` | Current, maintained, reliable |
| `draft` | Work in progress, incomplete |
| `reference` | Stable reference material, not actively updated |
| `stale` | Potentially outdated — verify before using |
| `imported` | Raw source material, not processed into vault opinion |

codex
The two most important files to read first are:

1. [README.md](/home/nhatquang/Knowledge/README.md) — vault orientation, source priority, rules, and domain entry points.
2. [knowledge-index.md](/home/nhatquang/Knowledge/knowledge-index.md) — flat routing index for locating notes without scanning the whole vault.

After those, read the relevant domain MOC/index for the task, such as `Domain 5 - IAM.md`, `Causal Inference - Knowledge Map.md`, or `Project List.md`.
tokens used
24,024
The two most important files to read first are:

1. [README.md](/home/nhatquang/Knowledge/README.md) — vault orientation, source priority, rules, and domain entry points.
2. [knowledge-index.md](/home/nhatquang/Knowledge/knowledge-index.md) — flat routing index for locating notes without scanning the whole vault.

After those, read the relevant domain MOC/index for the task, such as `Domain 5 - IAM.md`, `Causal Inference - Knowledge Map.md`, or `Project List.md`.

---

## Q02

**Question:** What is the source priority order in this vault — which type of note should be trusted most?

**Answer:**

Reading additional input from stdin...
OpenAI Codex v0.130.0
--------
workdir: /home/nhatquang/Knowledge
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, /home/nhatquang/.codex/memories]
reasoning effort: medium
reasoning summaries: none
session id: 019e11dc-2c25-7fd0-b5a7-18a7f528c827
--------
user
You are working in a personal knowledge vault. Start by reading `README.md` to orient yourself. Use `knowledge-index.md` to locate specific notes. Do not scan the entire vault — route through the index first.

What is the source priority order in this vault — which type of note should be trusted most?
warning: Codex's Linux sandbox uses bubblewrap and needs access to create user namespaces.
2026-05-10T12:28:24.577567Z ERROR rmcp::transport::worker: worker quit with fatal: Transport channel closed, when AuthRequired(AuthRequiredError { www_authenticate_header: "Bearer error=\"invalid_request\", error_description=\"No access token was provided in this request\", resource_metadata=\"https://api.githubcopilot.com/.well-known/oauth-protected-resource/mcp/\"" })
codex
I’ll orient through the vault entry points first, then answer from the relevant note rather than scanning broadly.
exec
/bin/bash -lc "sed -n '1,240p' knowledge-index.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Index

Flat index of every major area in this vault. Load this file first to orient without scanning 425 files. One entry per note: path → what it covers.

---

## Cyber Security

### CISSP
- `Cyber Security/CISSP/CISSP - Index.md` — top-level map of all 8 CISSP domains; only Domain 5 has notes
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` — Domain 5 MOC and reading path

### IAM Fundamentals
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/IAM-Overview.md` — what IAM is and how the stack fits together
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-LDAP-Fundamentals.md` — Active Directory and LDAP basics; group types, memberOf, ADUC
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-Domain-Forest-Trusts.md` — domain topology, forest trusts, group scope rules
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Authentication-Factors-MFA.md` — MFA types and authentication factors
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/OAuth2-OIDC.md` — OAuth2 and OpenID Connect protocols
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Access-Control-Models.md` — DAC, MAC, RBAC, ABAC models
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Physical-vs-Logical-Access.md` — physical vs logical access controls
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Privilege-Escalation-Service-Accounts.md` — privilege escalation paths and service account risks

### SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` — business context for IIQ: identity cube, aggregation, entitlements, roles, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ.md` — complete spt_* schema reference; all tables, columns, joins
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Field-Values.md` — status codes, type enumerations, flag values for all tables
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Data-Flows.md` — step-by-step flows: aggregation, refresh, JML, requests, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md` — how IIQ connects to AD; aggregation types, delta/DirSync, connector gap
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Analyst-Playbook.md` — 60+ SQL recipes for common business questions
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/AD-Groups-in-IIQ-Governance.md` — how AD groups become governed entitlements in IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/CyberArk-IIQ-Integration.md` — three integration patterns between CyberArk PAM and SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/PrivilegedA-Account-Data-Queries.md` — MySQL queries for PRIV_*_A privileged accounts

---

## Statistics

- `Statistics/Statistics.md` — top-level MOC for all statistics topics
- `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` — method selection guide: DiD, matching, RDD, synthetic control
- `Statistics/Causal Inference/Causal Inference.md` — entry point to 25-chapter causal inference study notes
- `Statistics/AB Testing/AB Testing fundamental.md` — A/B testing fundamentals
- `Statistics/Statistical thinking.md` — statistical thinking principles
- `Statistics/Causal Inference/_Source/` — raw imported Python Causality Handbook; not authoritative

---

## Deep Learning

- `Deep Learning/Deep Learning.md` — domain MOC; all subfields and entry points
- `Deep Learning/NLP/NLP.md` — NLP entry point; most developed subfield in this vault
- `Deep Learning/NLP/LLMOps/LLMOps.md` — LLM operations and deployment
- `Deep Learning/NLP/LLMs/Building Production-Grade LLM apps.md` — production LLM application patterns
- `Deep Learning/NLP/LLMs/Multi-Agent LLMs.md` — multi-agent LLM architectures
- `Deep Learning/Foundations/Loss function.md` — loss functions overview
- `Deep Learning/Computer Vision/Generate Image.md` — image generation entry point
- `Deep Learning/XAI/Trustworthy and Explainable AI.md` — XAI and model interpretability
- `Deep Learning/GNN/Advanced GNN.md` — graph neural networks
- `Deep Learning/Open Source/HuggingFace open source.md` — HuggingFace ecosystem

---

## Machine Learning

- `Machine Learning/Machine Learning.md` — domain MOC; clustering and regression
- `Machine Learning/Clustering algorithm/Clustering Algorithm.md` — clustering methods
- `Machine Learning/Regression algorithm/Regression Algorithm.md` — regression methods

---

## Finance

- `Finance/Finance.md` — domain MOC; corporate finance and bank management
- `Finance/Corporate Finance.md` — corporate finance section index
- `Finance/Bank Management and Strategy.md` — bank management section index

---

## Projects

- `Projects/Project List.md` — project registry with status and next actions
- `Projects/Causal IAM Risk Analytics.md` — causal analysis of IAM risk (Idea/MVP)
- `Projects/Fraud Detection using ML.md` — fraud detection project (Draft)
- `Projects/Neural Style Transfer.md` — neural style transfer (Active)

---

## Playbooks

- `Playbooks/Start a New Project.md` — steps to initialize a new project in this vault
- `Playbooks/Causal Analysis Checklist.md` — method selection and data readiness for causal inference
- `Playbooks/Evaluate a Dataset.md` — dataset assessment before starting analysis

codex
The index loaded cleanly. The README read hit a sandbox wrapper issue on that combined command, so I’m retrying it directly before I answer.
exec
/bin/bash -lc "sed -n '1,220p' README.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Vault

Personal knowledge base for CISSP exam preparation, enterprise IAM, data science, and machine learning. Notes are written for long-term retention — every note is independently useful weeks after it was written.

For writing standards and folder conventions, see `CLAUDE.md`.

---

## Where to Start

Route by task:

| I want to... | Start here |
|---|---|
| Study IAM / access control / identity governance | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` |
| Understand SailPoint IIQ or CyberArk | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` |
| Study causal inference methods | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` |
| Find or review a project | `Projects/Project List.md` |
| Navigate any domain | `knowledge-index.md` |
| Understand the full CISSP curriculum | `Cyber Security/CISSP/CISSP - Index.md` |

---

## Source Priority

When multiple notes cover the same topic, prefer in this order:

1. **Project notes** (`Projects/`) — current applied context
2. **Domain index / MOC notes** — authoritative navigation layer
3. **Concept notes** — detailed topic explanations
4. **`_Source/` folders** — raw imported material, not the owner's final opinion

Do not treat `_Source/` content as advice or conclusions. It is reference material only.

---

## Domain Map

| Domain | MOC / Entry Point | Status |
|---|---|---|
| Cyber Security — IAM | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` | Active |
| Cyber Security — CISSP | `Cyber Security/CISSP/CISSP - Index.md` | Active (Domain 5 only) |
| Statistics — Causal Inference | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` | Active |
| Statistics | `Statistics/Statistics.md` | Active |
| Deep Learning | `Deep Learning/Deep Learning.md` | Study notes |
| Machine Learning | `Machine Learning/Machine Learning.md` | Study notes |
| Finance | `Finance/Finance.md` | Study notes |
| Projects | `Projects/Project List.md` | Active |
| Playbooks | `Playbooks/` | Active |

---

## Rules

- Always read the domain MOC or index note before diving into deep concept notes
- `_Source/` folders contain raw imported material — do not treat as authoritative
- Notes link bidirectionally — if note A links to B, B links back to A
- A note with `status: stale` in its frontmatter may be outdated — verify before using
- Wikilinks (`[[Note Name]]`) are Obsidian-specific; resolve them as relative file paths

---

## Status Guide

| Status | Meaning |
|---|---|
| `active` | Current, maintained, reliable |
| `draft` | Work in progress, incomplete |
| `reference` | Stable reference material, not actively updated |
| `stale` | Potentially outdated — verify before using |
| `imported` | Raw source material, not processed into vault opinion |

codex
The vault’s source priority order is:

1. **Project notes** in `Projects/` — most trusted for current applied context
2. **Domain index / MOC notes** — authoritative navigation layer
3. **Concept notes** — detailed topic explanations
4. **`_Source/` folders** — least authoritative; raw imported reference material only

`_Source/` content should not be treated as the vault owner’s advice or final conclusions.
tokens used
14,174
The vault’s source priority order is:

1. **Project notes** in `Projects/` — most trusted for current applied context
2. **Domain index / MOC notes** — authoritative navigation layer
3. **Concept notes** — detailed topic explanations
4. **`_Source/` folders** — least authoritative; raw imported reference material only

`_Source/` content should not be treated as the vault owner’s advice or final conclusions.

---

## Q03

**Question:** The Causal IAM Risk Analytics project is listed in the vault. What is its current status and next action?

**Answer:**

Reading additional input from stdin...
OpenAI Codex v0.130.0
--------
workdir: /home/nhatquang/Knowledge
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, /home/nhatquang/.codex/memories]
reasoning effort: medium
reasoning summaries: none
session id: 019e11dc-e7b8-77b0-8831-bf137717e4da
--------
user
You are working in a personal knowledge vault. Start by reading `README.md` to orient yourself. Use `knowledge-index.md` to locate specific notes. Do not scan the entire vault — route through the index first.

The Causal IAM Risk Analytics project is listed in the vault. What is its current status and next action?
warning: Codex's Linux sandbox uses bubblewrap and needs access to create user namespaces.
2026-05-10T12:29:12.613473Z ERROR rmcp::transport::worker: worker quit with fatal: Transport channel closed, when AuthRequired(AuthRequiredError { www_authenticate_header: "Bearer error=\"invalid_request\", error_description=\"No access token was provided in this request\", resource_metadata=\"https://api.githubcopilot.com/.well-known/oauth-protected-resource/mcp/\"" })
codex
I’ll orient through the vault README, then use the index to find the Causal IAM Risk Analytics note without doing a broad scan.
exec
/bin/bash -lc "sed -n '1,220p' README.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Vault

Personal knowledge base for CISSP exam preparation, enterprise IAM, data science, and machine learning. Notes are written for long-term retention — every note is independently useful weeks after it was written.

For writing standards and folder conventions, see `CLAUDE.md`.

---

## Where to Start

Route by task:

| I want to... | Start here |
|---|---|
| Study IAM / access control / identity governance | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` |
| Understand SailPoint IIQ or CyberArk | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` |
| Study causal inference methods | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` |
| Find or review a project | `Projects/Project List.md` |
| Navigate any domain | `knowledge-index.md` |
| Understand the full CISSP curriculum | `Cyber Security/CISSP/CISSP - Index.md` |

---

## Source Priority

When multiple notes cover the same topic, prefer in this order:

1. **Project notes** (`Projects/`) — current applied context
2. **Domain index / MOC notes** — authoritative navigation layer
3. **Concept notes** — detailed topic explanations
4. **`_Source/` folders** — raw imported material, not the owner's final opinion

Do not treat `_Source/` content as advice or conclusions. It is reference material only.

---

## Domain Map

| Domain | MOC / Entry Point | Status |
|---|---|---|
| Cyber Security — IAM | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` | Active |
| Cyber Security — CISSP | `Cyber Security/CISSP/CISSP - Index.md` | Active (Domain 5 only) |
| Statistics — Causal Inference | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` | Active |
| Statistics | `Statistics/Statistics.md` | Active |
| Deep Learning | `Deep Learning/Deep Learning.md` | Study notes |
| Machine Learning | `Machine Learning/Machine Learning.md` | Study notes |
| Finance | `Finance/Finance.md` | Study notes |
| Projects | `Projects/Project List.md` | Active |
| Playbooks | `Playbooks/` | Active |

---

## Rules

- Always read the domain MOC or index note before diving into deep concept notes
- `_Source/` folders contain raw imported material — do not treat as authoritative
- Notes link bidirectionally — if note A links to B, B links back to A
- A note with `status: stale` in its frontmatter may be outdated — verify before using
- Wikilinks (`[[Note Name]]`) are Obsidian-specific; resolve them as relative file paths

---

## Status Guide

| Status | Meaning |
|---|---|
| `active` | Current, maintained, reliable |
| `draft` | Work in progress, incomplete |
| `reference` | Stable reference material, not actively updated |
| `stale` | Potentially outdated — verify before using |
| `imported` | Raw source material, not processed into vault opinion |

codex
The README says project notes are the source of truth for current applied work, and `Projects/Project List.md` is the project entry point. The initial indexed search hit a sandbox issue, so I’m reading the index and project list directly in small slices.
exec
/bin/bash -lc "sed -n '1,260p' knowledge-index.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Index

Flat index of every major area in this vault. Load this file first to orient without scanning 425 files. One entry per note: path → what it covers.

---

## Cyber Security

### CISSP
- `Cyber Security/CISSP/CISSP - Index.md` — top-level map of all 8 CISSP domains; only Domain 5 has notes
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` — Domain 5 MOC and reading path

### IAM Fundamentals
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/IAM-Overview.md` — what IAM is and how the stack fits together
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-LDAP-Fundamentals.md` — Active Directory and LDAP basics; group types, memberOf, ADUC
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-Domain-Forest-Trusts.md` — domain topology, forest trusts, group scope rules
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Authentication-Factors-MFA.md` — MFA types and authentication factors
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/OAuth2-OIDC.md` — OAuth2 and OpenID Connect protocols
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Access-Control-Models.md` — DAC, MAC, RBAC, ABAC models
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Physical-vs-Logical-Access.md` — physical vs logical access controls
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Privilege-Escalation-Service-Accounts.md` — privilege escalation paths and service account risks

### SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` — business context for IIQ: identity cube, aggregation, entitlements, roles, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ.md` — complete spt_* schema reference; all tables, columns, joins
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Field-Values.md` — status codes, type enumerations, flag values for all tables
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Data-Flows.md` — step-by-step flows: aggregation, refresh, JML, requests, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md` — how IIQ connects to AD; aggregation types, delta/DirSync, connector gap
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Analyst-Playbook.md` — 60+ SQL recipes for common business questions
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/AD-Groups-in-IIQ-Governance.md` — how AD groups become governed entitlements in IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/CyberArk-IIQ-Integration.md` — three integration patterns between CyberArk PAM and SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/PrivilegedA-Account-Data-Queries.md` — MySQL queries for PRIV_*_A privileged accounts

---

## Statistics

- `Statistics/Statistics.md` — top-level MOC for all statistics topics
- `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` — method selection guide: DiD, matching, RDD, synthetic control
- `Statistics/Causal Inference/Causal Inference.md` — entry point to 25-chapter causal inference study notes
- `Statistics/AB Testing/AB Testing fundamental.md` — A/B testing fundamentals
- `Statistics/Statistical thinking.md` — statistical thinking principles
- `Statistics/Causal Inference/_Source/` — raw imported Python Causality Handbook; not authoritative

---

## Deep Learning

- `Deep Learning/Deep Learning.md` — domain MOC; all subfields and entry points
- `Deep Learning/NLP/NLP.md` — NLP entry point; most developed subfield in this vault
- `Deep Learning/NLP/LLMOps/LLMOps.md` — LLM operations and deployment
- `Deep Learning/NLP/LLMs/Building Production-Grade LLM apps.md` — production LLM application patterns
- `Deep Learning/NLP/LLMs/Multi-Agent LLMs.md` — multi-agent LLM architectures
- `Deep Learning/Foundations/Loss function.md` — loss functions overview
- `Deep Learning/Computer Vision/Generate Image.md` — image generation entry point
- `Deep Learning/XAI/Trustworthy and Explainable AI.md` — XAI and model interpretability
- `Deep Learning/GNN/Advanced GNN.md` — graph neural networks
- `Deep Learning/Open Source/HuggingFace open source.md` — HuggingFace ecosystem

---

## Machine Learning

- `Machine Learning/Machine Learning.md` — domain MOC; clustering and regression
- `Machine Learning/Clustering algorithm/Clustering Algorithm.md` — clustering methods
- `Machine Learning/Regression algorithm/Regression Algorithm.md` — regression methods

---

## Finance

- `Finance/Finance.md` — domain MOC; corporate finance and bank management
- `Finance/Corporate Finance.md` — corporate finance section index
- `Finance/Bank Management and Strategy.md` — bank management section index

---

## Projects

- `Projects/Project List.md` — project registry with status and next actions
- `Projects/Causal IAM Risk Analytics.md` — causal analysis of IAM risk (Idea/MVP)
- `Projects/Fraud Detection using ML.md` — fraud detection project (Draft)
- `Projects/Neural Style Transfer.md` — neural style transfer (Active)

---

## Playbooks

- `Playbooks/Start a New Project.md` — steps to initialize a new project in this vault
- `Playbooks/Causal Analysis Checklist.md` — method selection and data readiness for causal inference
- `Playbooks/Evaluate a Dataset.md` — dataset assessment before starting analysis

exec
/bin/bash -lc "sed -n '1,220p' 'Projects/Project List.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
domain: projects
updated: 2026-05-10
---

# Project List

Registry of all projects in this vault. Each row has a status and next action so any agent or reviewer can immediately see what is active and what needs doing next.

---

## Registry

| Project | Status | Domain | Data | Next Action |
|---|---|---|---|---|
| [[Causal IAM Risk Analytics]] | Idea / MVP | Cyber Security | Synthetic / public | Build simulation design; define treatment and outcome |
| [[Fraud Detection using ML]] | Draft | Machine Learning | TBD | Define dataset source; set up baseline model |
| [[Neural Style Transfer]] | Active | Deep Learning / CV | Public | Build extended version with text-driven style capture |
| Sentiment Analysis with Mamba | Draft | NLP | Public | Link to `Sentiment Analysis With Mamba.md` |
| Poem Generation | Idea | NLP | TBD | Define scope |
| Bank Transaction Database | Idea | Data Engineering | TBD | Define schema |

---

## Status Definitions

| Status | Meaning |
|---|---|
| Idea | Scoped but not started |
| Idea / MVP | Concept defined; MVP design in progress |
| Draft | Started; incomplete |
| Active | In progress with clear next action |
| Complete | Shipped or finished |
| Paused | On hold |

---

## Related

- `README.md` — vault entry point
- `knowledge-index.md` — full flat index including project file paths
- `Playbooks/Start a New Project.md` — how to initialize a new project in this vault

codex
The project registry confirms the row-level status and points to `Projects/Causal IAM Risk Analytics.md`. I’m opening that note now to check whether it has a more specific current status or action than the registry summary.
exec
/bin/bash -lc "sed -n '1,260p' 'Projects/Causal IAM Risk Analytics.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: [project, cybersecurity, iam, causal-inference, pam, sailpoint-iiq, cyberark]
aliases: [Causal IAM Risk Analytics, IAM Causal Inference Project, Causal Analysis for IAM Controls]
---

# Causal IAM Risk Analytics

This project applies [[Causal Inference - Knowledge Map|causal inference]] to [[Domain 5 - IAM|Identity and Access Management]] controls. The goal is to move from "the dashboard metric changed" to a stronger question: **did this IAM control cause a measurable reduction in access risk?**

Because real enterprise IAM, PAM, and SIEM data is usually private, the first version of this project should be built as a public-data and simulation project: use public or synthetic security logs as the behavioral baseline, simulate IAM control rollouts, inject known effects, and test whether causal methods recover those effects.

Before working on this project, read the IAM baseline first: [[Domain 5 - IAM]], [[Access-Control-Models]], [[Privilege-Escalation-Service-Accounts]], [[CyberArk-IIQ-Integration]], and [[Causal Inference - Knowledge Map]].

---

## Why This Project Exists

IAM programs generate many useful metrics: MFA adoption, PAM coverage, password rotation success, access review completion, high-risk sessions, orphan accounts, dormant users, and excessive entitlements. These metrics are good for monitoring, but they do not automatically prove that a control works.

For example, if CyberArk-managed accounts have more high-risk sessions than unmanaged accounts, that does not mean CyberArk increases risk. It may simply mean the riskiest privileged accounts were onboarded first.

**This project solves that by treating IAM changes as interventions and estimating their causal effect on security outcomes.**

> [!tip] Mental model
> IAM dashboards answer "what changed?" Causal IAM analytics asks "what would have happened without the control?"

---

## Core Idea

Model each IAM control as a treatment:

| IAM control | Treatment definition | Possible outcome |
|---|---|---|
| CyberArk PAM onboarding | Account, safe, or application becomes managed by PAM | Password age, rotation success, high-risk sessions, PAM coverage |
| Access certification | Identity or entitlement enters a review campaign | Revoked stale access, entitlement count, policy violations |
| MFA or adaptive MFA rollout | User, app, or group becomes subject to stronger authentication | Risky login rate, account compromise, helpdesk friction |
| JIT privileged access | Standing admin access replaced by time-limited approval | Standing entitlement count, privileged session volume, approval latency |
| Service account hardening | Account moved to vault, gMSA, rotation, or no-interactive-login policy | Excessive privilege, unmanaged account count, credential age |
| RBAC or ABAC redesign | Access moves from direct grants to role or attribute policy | Role explosion, direct entitlement count, SOD violations |

The core output should be an evidence-backed statement:

> "After accounting for baseline differences and time trends, this IAM control changed this risk outcome by this estimated amount, under these assumptions."

---

## Candidate Causal Questions

### CyberArk PAM

- Did CyberArk onboarding reduce password age and increase rotation compliance?
- Did session isolation or recording reduce high-risk privileged sessions?
- Did PAM coverage reduce the number of unmanaged privileged accounts?
- Did integrating CyberArk with SailPoint IIQ reduce stale safe memberships?

Relevant notes:
- [[CyberArk PAM/05-dashboard-guide/key-metrics-and-kpis|CyberArk Key Metrics and KPIs]]
- [[CyberArk-IIQ-Integration]]
- [[safes]]
- [[accounts]]
- [[CyberArk PAM/03-key-entities/sessions|CyberArk Sessions]]

### SailPoint IIQ Governance

- Did access certification campaigns remove stale or excessive entitlements?
- Did Joiner-Mover-Leaver controls reduce privilege creep after role changes?
- Did role-based provisioning reduce direct access grants?
- Did SOD policies reduce toxic access combinations?

Relevant notes:
- [[IIQ-Concepts]]
- [[IIQ-Data-Flows]]
- [[IIQ-Analyst-Playbook]]
- [[AD-Groups-in-IIQ-Governance]]

### Authentication and Adaptive Access

- Did MFA reduce risky login events?
- Did adaptive MFA reduce risk without creating too much user friction?
- Did JIT access reduce standing privilege while preserving operational access?
- Did risk-based access policies improve outcomes beyond static RBAC rules?

Relevant notes:
- [[Authentication-Factors-MFA]]
- [[OAuth2-OIDC]]
- [[SAML-Federation]]
- [[Access-Control-Models]]

### Service Accounts and Non-Human Identities

- Did service account vaulting reduce credential age and unmanaged secrets?
- Did gMSA adoption reduce service account password risk?
- Did no-interactive-login policy reduce lateral movement exposure?
- Did agent identity governance reduce borrowed identity and overbroad delegated access?

Relevant notes:
- [[Privilege-Escalation-Service-Accounts]]
- [[AI-Agent-Identity-and-IAM]]

---

## Data Strategy

There are two versions of this project:

| Version | Data | What it can prove |
|---|---|---|
| Public/synthetic MVP | Public security datasets plus simulated IAM interventions | The causal workflow works, the assumptions are explicit, and the estimators can recover known effects |
| Real enterprise extension | SailPoint, CyberArk, Entra ID, AD, SIEM, HR, and ticketing data | Whether a real IAM control reduced risk in a specific environment |

The MVP should be honest about its limitation: it cannot prove that CyberArk, SailPoint, MFA, or JIT worked in a real company. It can prove that the project can model IAM controls as interventions, construct counterfactuals, and estimate effects under controlled assumptions.

### Public or Synthetic Data Options

| Dataset | What it provides | Best use in this project |
|---|---|---|
| LANL authentication dataset | Large enterprise user-computer authentication graph over time | Login/session behavior, lateral-movement proxy features, user-week panels |
| CERT insider threat dataset | Synthetic logon, device, file, email, HTTP, and insider-threat scenarios | User-risk outcomes, simulated access reviews, insider-risk proxy modeling |
| Splunk Boss of the SOC datasets | Realistic SOC/attack investigation logs | Security event outcomes and attack/risk labels |
| OTRF Security Datasets / Mordor | Windows and attack logs mapped to MITRE ATT&CK | Lab-style detection events and endpoint activity |

### Simulated IAM Rollouts

Add a treatment layer on top of the public dataset:

| Simulated control | Example treatment rule | Example injected effect |
|---|---|---|
| MFA rollout | Selected users become MFA-required after week 8 | Reduce risky login probability by a fixed percentage |
| Access review campaign | High-entitlement users reviewed after a chosen date | Reduce stale entitlement count or risky access score |
| PAM onboarding | Privileged or service-account-like identities become managed | Reduce credential-age violations or privileged-risk score |
| JIT access | Standing admin access replaced by time-limited access | Reduce standing privilege exposure |
| Service account hardening | `svc_*`-like identities get vaulting or no-interactive-login control | Reduce suspicious service-account login events |

This simulation layer should be saved and documented so the true treatment effect is known. The project can then compare estimated effects against the injected ground truth.

## Real Enterprise Data Sources

| Source | Useful fields or metrics | Project use |
|---|---|---|
| SailPoint IIQ | identities, accounts, entitlements, roles, access requests, certifications, policy violations | Access lifecycle, privilege creep, certification outcomes |
| CyberArk PAM | accounts, safes, safe memberships, rotation status, password age, sessions, risk score | Privileged account control and PAM effectiveness |
| Active Directory / LDAP | users, groups, service accounts, disabled accounts, last logon, group membership | Baseline access state and account lifecycle |
| SIEM / authentication logs | login risk, MFA prompts, failures, location, device, suspicious activity | Authentication and adaptive access outcomes |
| HR or authoritative source | department, role, manager, joiner/mover/leaver status | Confounders and lifecycle events |
| Ticketing / access request system | request date, approval, revoke, exception, incident | Operational friction and approval latency |

Important unit choices:
- Identity-month for user access lifecycle questions.
- Account-month for service account and privileged account questions.
- Safe-month or application-month for CyberArk onboarding questions.
- Login-session for authentication questions.

---

## Method Map

| Problem shape | Causal method | IAM example |
|---|---|---|
| Clean randomized rollout | [[02 - Randomised Experiments]] | Randomly phase adaptive MFA by low-risk user group |
| Observed confounders, no hidden confounding | [[10 - Matching]], [[11 - Propensity Score]], [[12 - Doubly Robust Estimation]] | Compare reviewed vs non-reviewed users with similar role, department, access level, and history |
| Panel data with treated and control groups | [[13 - Difference-in-Differences]], [[14 - Panel Data and Fixed Effects]] | Compare departments before and after CyberArk onboarding waves |
| One treated business unit or application | [[15 - Synthetic Control]] | Build a counterfactual for the first application onboarded to PAM |
| Treatment changes at a policy threshold | [[16 - Regression Discontinuity Design]] | Compare sessions just above and below a risk-score threshold for step-up MFA |
| Treatment effects vary across users or systems | [[18 - Heterogeneous Treatment Effects and Personalization]], [[21 - Meta Learners]], [[22 - Debiased Orthogonal Machine Learning]] | Estimate which departments, apps, or account types benefit most from stricter controls |

> [!warning] Prediction is not causal evidence
> A model that predicts high-risk users or sessions is useful, but it does not prove which IAM control will reduce that risk. For causal claims, define the intervention, the counterfactual, and the identification assumptions.

---

## MVP

Start with a public or synthetic dataset, then simulate the IAM rollout. The cleanest first version is based on the CERT insider threat dataset because it already contains multiple user-activity log types and malicious-behavior scenarios.

**Research question:** Can causal inference estimate the effect of a simulated IAM control rollout on insider-risk or access-risk proxy outcomes?

**Unit:** User-week.

**Treatment:** A simulated control such as MFA, access review, PAM onboarding, JIT access, or service-account hardening is applied after a chosen rollout date.

**Primary outcomes:**
- Risky activity score.
- Abnormal login/session count.
- Sensitive file/device activity.
- Simulated stale entitlement count.
- Simulated standing privilege exposure.

**Candidate design:**
- Use difference-in-differences if treated and untreated users have pre/post periods.
- Use matching or propensity scores if treated users are selected based on baseline risk.
- Use synthetic control if one department, application, or high-risk group is treated first.
- Use regression discontinuity if the simulated policy uses a risk-score threshold.

**Minimum deliverable:**
- One project notebook or report with:
  - public dataset description;
  - simulation design and known injected effect;
  - data dictionary;
  - treatment and outcome definitions;
  - baseline trend plots;
  - causal design choice;
  - assumption checks;
  - estimated effect size;
  - limitations and alternative explanations.

---

## Feasibility Assessment

**Verdict: feasible as a methods-demonstration MVP. Not feasible as evidence that real IAM products reduce real risk.** The note framing on lines 112 and 216 is honest about this — score the project on what it actually proposes, not what it sounds like at first read.

| Dimension | Score | Reasoning |
|---|---|---|
| Data availability | 8/10 | CERT r4.2/r5.2, LANL auth dataset, OTRF/Mordor are all freely downloadable today |
| Method fit | 9/10 | DiD, matching, synthetic control, RDD map cleanly onto staggered IAM rollouts |
| Prerequisite skills | 9/10 | Causal Inference 01–25 covered; IAM domain knowledge is deep |
| MVP scope realism | 7/10 | Achievable in 6–9 weeks part-time; the simulation harness is the hidden cost |
| External validity | 3/10 | Recovering an injected effect proves the pipeline works, not that any product reduces risk in production — this is the project's structural ceiling |
| Portfolio value | 8/10 | Rare intersection (security + causal inference) with a defensible writeup |
| Self-deception risk | 6/10 risk | Easy to validate your own injected effect with a method designed to recover it — mitigations below are non-negotiable |

### What makes it work

- **Semi-synthetic benchmarking is a legitimate methodology.** EconML's IHDP benchmark, the ACIC competitions, and most causal-ML papers use injected ground-truth effects on real or quasi-real covariates. This project sits in that established tradition.
- **CERT insider-threat dataset is purpose-built for this.** It already has user-week structure across logon/device/file/email/HTTP logs and labelled malicious scenarios. Panel construction is mechanical, not novel research.
- **Method-to-problem mapping is sound.** Staggered PAM onboarding waves → staggered DiD ([[24 - The Difference-in-Differences Saga]]). Risk-score threshold for step-up MFA → RDD ([[16 - Regression Discontinuity Design]]). First app onboarded to PAM → Synthetic Control ([[15 - Synthetic Control]]). Reviewed-vs-unreviewed users with selection on baseline risk → Propensity Score / DR ([[11 - Propensity Score]], [[12 - Doubly Robust Estimation]]).

### What will sink it if ignored

> [!warning] Three structural risks
> These are not optional design notes. They are stop-the-project conditions if not addressed before the MVP report is written.

1. **Circular validation.** Injecting a linear, additive treatment effect and recovering it with linear DiD proves nothing except that the code runs. The simulation must include non-random treatment assignment (riskiest accounts onboarded first), effect heterogeneity (different sizes by department/account type/baseline risk), realistic outcome noise, and at least one "unfaithful" scenario with a hidden confounder the methods *cannot* recover — to demonstrate honesty about identification.
2. **Outcome-construction leakage.** "Risky activity score" and "stale entitlement count" don't exist natively in CERT/LANL — they're constructed by the analyst. If the same person designs the outcome and the treatment, the outcome can subtly encode the treatment. **Outcome definition must be locked and committed to the repo before treatment assignment is generated.**
3. **The V2 "real enterprise extension" is aspirational.** SailPoint/CyberArk/SIEM/HR data is not in hand. Treat V2 as a design spec for if data became available, not as a planned phase. Do not oversell the project as "I analyzed real PAM rollouts."

### Concrete MVP shape that will work

| Element | Specification |
|---|---|
| Dataset | CERT insider threat r4.2 (smaller; r5.2 if compute allows) |
| Unit | User-week |
| Panel window | 73 weeks (matches CERT timeline) |
| Treatment | Simulated PAM onboarding wave: privileged-like users onboarded across weeks 20, 30, 40 in three cohorts |
| Assignment rule | Logistic on baseline-risk covariates → non-random by design |
| Outcome | Off-hours logon count + removable-device write count per user-week (locked spec, frozen before assignment is drawn) |
| Injected effect | Heterogeneous: 30% reduction for high-baseline cohort, 10% for medium, 0% for low |
| Primary estimator | Staggered DiD (Callaway-Sant'Anna) with PSM-trimmed sample |
| Robustness | Synthetic control on the first cohort; placebo treatment on pre-period |
| Honesty check | One scenario with a hidden confounder (e.g., department-wide policy change at the same time) — show the methods over/under-estimate, and explain why |

**Effort:** 6–9 weeks part-time. The simulation harness is ~30% of the work; people underestimate it. **Tooling:** Python + `dowhy`, `econml`, `differences` (Callaway-Sant'Anna), `pandas`, `pyarrow`.

### Stop-gate before committing

Run two 1-day spikes before committing to the full 6–9 week MVP:

1. Download CERT r4.2 and build a user-week panel for ~50 users over ~10 weeks. If panel construction takes more than 1 day end-to-end, data plumbing is the blocker.
2. Generate a non-random treatment assignment and a heterogeneous injected effect; run a single Callaway-Sant'Anna DiD; check whether the estimated ATT is in the right neighbourhood.

codex
The Causal IAM Risk Analytics project is currently at **Idea / MVP** status: the concept is defined, but the MVP still needs design work.

Current framing: it is feasible as a **methods-demonstration MVP**, not as evidence that real IAM products reduce real-world risk. The intended MVP uses public or synthetic data, likely CERT insider-threat data, with simulated IAM control rollouts and known injected effects.

Next action: **build the simulation design and define the treatment and outcome.** More concretely, the project note says to run two 1-day spikes first:

1. Build a small CERT r4.2 user-week panel for about 50 users over 10 weeks.
2. Generate non-random treatment assignment plus a heterogeneous injected effect, then run a first DiD estimate to see whether the estimated ATT is in the right range.

Source notes used: `README.md`, `knowledge-index.md`, `Projects/Project List.md`, and `Projects/Causal IAM Risk Analytics.md`.
tokens used
20,219
The Causal IAM Risk Analytics project is currently at **Idea / MVP** status: the concept is defined, but the MVP still needs design work.

Current framing: it is feasible as a **methods-demonstration MVP**, not as evidence that real IAM products reduce real-world risk. The intended MVP uses public or synthetic data, likely CERT insider-threat data, with simulated IAM control rollouts and known injected effects.

Next action: **build the simulation design and define the treatment and outcome.** More concretely, the project note says to run two 1-day spikes first:

1. Build a small CERT r4.2 user-week panel for about 50 users over 10 weeks.
2. Generate non-random treatment assignment plus a heterogeneous injected effect, then run a first DiD estimate to see whether the estimated ATT is in the right range.

Source notes used: `README.md`, `knowledge-index.md`, `Projects/Project List.md`, and `Projects/Causal IAM Risk Analytics.md`.

---

## Q04

**Question:** What delta aggregation method does SailPoint IIQ use by default when connecting to Active Directory — and what AD permission does the bind account need?

**Answer:**

Reading additional input from stdin...
OpenAI Codex v0.130.0
--------
workdir: /home/nhatquang/Knowledge
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, /home/nhatquang/.codex/memories]
reasoning effort: medium
reasoning summaries: none
session id: 019e11dd-ce04-7501-bce6-d4916a3d555b
--------
user
You are working in a personal knowledge vault. Start by reading `README.md` to orient yourself. Use `knowledge-index.md` to locate specific notes. Do not scan the entire vault — route through the index first.

What delta aggregation method does SailPoint IIQ use by default when connecting to Active Directory — and what AD permission does the bind account need?
warning: Codex's Linux sandbox uses bubblewrap and needs access to create user namespaces.
2026-05-10T12:30:11.521691Z ERROR rmcp::transport::worker: worker quit with fatal: Transport channel closed, when AuthRequired(AuthRequiredError { www_authenticate_header: "Bearer error=\"invalid_request\", error_description=\"No access token was provided in this request\", resource_metadata=\"https://api.githubcopilot.com/.well-known/oauth-protected-resource/mcp/\"" })
codex
I’ll orient through the vault entry points first, then use the index to find the relevant SailPoint/AD note without scanning broadly.
exec
/bin/bash -lc "sed -n '1,220p' README.md" in /home/nhatquang/Knowledge
exec
/bin/bash -lc "sed -n '1,260p' knowledge-index.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Vault

Personal knowledge base for CISSP exam preparation, enterprise IAM, data science, and machine learning. Notes are written for long-term retention — every note is independently useful weeks after it was written.

For writing standards and folder conventions, see `CLAUDE.md`.

---

## Where to Start

Route by task:

| I want to... | Start here |
|---|---|
| Study IAM / access control / identity governance | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` |
| Understand SailPoint IIQ or CyberArk | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` |
| Study causal inference methods | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` |
| Find or review a project | `Projects/Project List.md` |
| Navigate any domain | `knowledge-index.md` |
| Understand the full CISSP curriculum | `Cyber Security/CISSP/CISSP - Index.md` |

---

## Source Priority

When multiple notes cover the same topic, prefer in this order:

1. **Project notes** (`Projects/`) — current applied context
2. **Domain index / MOC notes** — authoritative navigation layer
3. **Concept notes** — detailed topic explanations
4. **`_Source/` folders** — raw imported material, not the owner's final opinion

Do not treat `_Source/` content as advice or conclusions. It is reference material only.

---

## Domain Map

| Domain | MOC / Entry Point | Status |
|---|---|---|
| Cyber Security — IAM | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` | Active |
| Cyber Security — CISSP | `Cyber Security/CISSP/CISSP - Index.md` | Active (Domain 5 only) |
| Statistics — Causal Inference | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` | Active |
| Statistics | `Statistics/Statistics.md` | Active |
| Deep Learning | `Deep Learning/Deep Learning.md` | Study notes |
| Machine Learning | `Machine Learning/Machine Learning.md` | Study notes |
| Finance | `Finance/Finance.md` | Study notes |
| Projects | `Projects/Project List.md` | Active |
| Playbooks | `Playbooks/` | Active |

---

## Rules

- Always read the domain MOC or index note before diving into deep concept notes
- `_Source/` folders contain raw imported material — do not treat as authoritative
- Notes link bidirectionally — if note A links to B, B links back to A
- A note with `status: stale` in its frontmatter may be outdated — verify before using
- Wikilinks (`[[Note Name]]`) are Obsidian-specific; resolve them as relative file paths

---

## Status Guide

| Status | Meaning |
|---|---|
| `active` | Current, maintained, reliable |
| `draft` | Work in progress, incomplete |
| `reference` | Stable reference material, not actively updated |
| `stale` | Potentially outdated — verify before using |
| `imported` | Raw source material, not processed into vault opinion |

 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Index

Flat index of every major area in this vault. Load this file first to orient without scanning 425 files. One entry per note: path → what it covers.

---

## Cyber Security

### CISSP
- `Cyber Security/CISSP/CISSP - Index.md` — top-level map of all 8 CISSP domains; only Domain 5 has notes
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` — Domain 5 MOC and reading path

### IAM Fundamentals
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/IAM-Overview.md` — what IAM is and how the stack fits together
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-LDAP-Fundamentals.md` — Active Directory and LDAP basics; group types, memberOf, ADUC
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-Domain-Forest-Trusts.md` — domain topology, forest trusts, group scope rules
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Authentication-Factors-MFA.md` — MFA types and authentication factors
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/OAuth2-OIDC.md` — OAuth2 and OpenID Connect protocols
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Access-Control-Models.md` — DAC, MAC, RBAC, ABAC models
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Physical-vs-Logical-Access.md` — physical vs logical access controls
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Privilege-Escalation-Service-Accounts.md` — privilege escalation paths and service account risks

### SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` — business context for IIQ: identity cube, aggregation, entitlements, roles, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ.md` — complete spt_* schema reference; all tables, columns, joins
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Field-Values.md` — status codes, type enumerations, flag values for all tables
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Data-Flows.md` — step-by-step flows: aggregation, refresh, JML, requests, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md` — how IIQ connects to AD; aggregation types, delta/DirSync, connector gap
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Analyst-Playbook.md` — 60+ SQL recipes for common business questions
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/AD-Groups-in-IIQ-Governance.md` — how AD groups become governed entitlements in IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/CyberArk-IIQ-Integration.md` — three integration patterns between CyberArk PAM and SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/PrivilegedA-Account-Data-Queries.md` — MySQL queries for PRIV_*_A privileged accounts

---

## Statistics

- `Statistics/Statistics.md` — top-level MOC for all statistics topics
- `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` — method selection guide: DiD, matching, RDD, synthetic control
- `Statistics/Causal Inference/Causal Inference.md` — entry point to 25-chapter causal inference study notes
- `Statistics/AB Testing/AB Testing fundamental.md` — A/B testing fundamentals
- `Statistics/Statistical thinking.md` — statistical thinking principles
- `Statistics/Causal Inference/_Source/` — raw imported Python Causality Handbook; not authoritative

---

## Deep Learning

- `Deep Learning/Deep Learning.md` — domain MOC; all subfields and entry points
- `Deep Learning/NLP/NLP.md` — NLP entry point; most developed subfield in this vault
- `Deep Learning/NLP/LLMOps/LLMOps.md` — LLM operations and deployment
- `Deep Learning/NLP/LLMs/Building Production-Grade LLM apps.md` — production LLM application patterns
- `Deep Learning/NLP/LLMs/Multi-Agent LLMs.md` — multi-agent LLM architectures
- `Deep Learning/Foundations/Loss function.md` — loss functions overview
- `Deep Learning/Computer Vision/Generate Image.md` — image generation entry point
- `Deep Learning/XAI/Trustworthy and Explainable AI.md` — XAI and model interpretability
- `Deep Learning/GNN/Advanced GNN.md` — graph neural networks
- `Deep Learning/Open Source/HuggingFace open source.md` — HuggingFace ecosystem

---

## Machine Learning

- `Machine Learning/Machine Learning.md` — domain MOC; clustering and regression
- `Machine Learning/Clustering algorithm/Clustering Algorithm.md` — clustering methods
- `Machine Learning/Regression algorithm/Regression Algorithm.md` — regression methods

---

## Finance

- `Finance/Finance.md` — domain MOC; corporate finance and bank management
- `Finance/Corporate Finance.md` — corporate finance section index
- `Finance/Bank Management and Strategy.md` — bank management section index

---

## Projects

- `Projects/Project List.md` — project registry with status and next actions
- `Projects/Causal IAM Risk Analytics.md` — causal analysis of IAM risk (Idea/MVP)
- `Projects/Fraud Detection using ML.md` — fraud detection project (Draft)
- `Projects/Neural Style Transfer.md` — neural style transfer (Active)

---

## Playbooks

- `Playbooks/Start a New Project.md` — steps to initialize a new project in this vault
- `Playbooks/Causal Analysis Checklist.md` — method selection and data readiness for causal inference
- `Playbooks/Evaluate a Dataset.md` — dataset assessment before starting analysis

codex
The index points to the SailPoint IIQ connector note as the likely source. I’m also reading the Domain 5 and IIQ entry notes because the vault rules say to route through the MOC before deep concept notes.
exec
/bin/bash -lc "sed -n '1,220p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: [cissp, domain-5-iam, moc, identity, access-management]
aliases: [CISSP Domain 5, IAM Domain, Identity and Access Management]
---

# CISSP Domain 5 — Identity and Access Management

Identity and Access Management (IAM) ensures the right people have the right access to the right resources at the right time. Domain 5 covers the full lifecycle: from proving identity, to granting access, to reviewing and revoking it.

---

## CISSP Domain 5 Subtopics

| Subtopic                                    | What It Covers                                                                                                   | Notes in This Vault                                                                                                                                                                       |
| ------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **5.1** Control physical and logical access | Access control models, physical access, least privilege                                                          | [[Physical-vs-Logical-Access]], [[IAM-Overview]], [[what-is-pam]], [[CyberArk-IIQ-Integration]]                                                                                           |
| **5.2** Identification & Authentication     | Groups and roles, AAA, MFA, passwordless, session management, identity proofing, credential management, SSO, JIT | [[AD-LDAP-Fundamentals]], [[AD-Application-Integration]], [[Authentication-Factors-MFA]], [[Kerberos-Protocol]], [[Privilege-Escalation-Service-Accounts]], [[AI-Agent-Identity-and-IAM]] |
| **5.3** Federated Identity                  | SAML, OAuth, OIDC, domain trusts, cross-forest                                                                   | [[AD-Domain-Forest-Trusts]], [[AD-Application-Integration]], [[SAML-Federation]], [[OAuth2-OIDC]]                                                                                         |
| **5.4** Authorization mechanisms            | RBAC, ABAC, ACLs, group-based access                                                                             | [[Access-Control-Models]], [[AD-Application-Integration]], [[AD-File-Shares-NAS-DFS]], [[AD-Groups-in-IIQ-Governance]], [[AI-Agent-Identity-and-IAM]]                                     |
| **5.5** Provisioning lifecycle              | JML (Joiner-Mover-Leaver), access requests, certifications                                                       | [[IIQ-Concepts]], [[IIQ-Data-Flows]], [[IIQ-AD-LDAP-Connector]], [[Privilege-Escalation-Service-Accounts]], [[AI-Agent-Identity-and-IAM]]                                                 |
| **5.6** Authentication systems              | SSO, Kerberos, RADIUS, TACACS+                                                                                   | [[Kerberos-Protocol]], [[SAML-Federation]], [[OAuth2-OIDC]], [[RADIUS-TACACS-Diameter]], [[AD-Application-Integration]]                                                                   |

---

## Reading Path

Start here if you're new to IAM:

```
1.  IAM-Overview                        — understand the technology stack and where each tool fits
2.  AD-LDAP-Fundamentals                — understand directories, groups, and AD itself
3.  AD-Domain-Forest-Trusts             — understand cross-domain topology (key for 5.3)
4.  AD-Application-Integration          — understand how apps consume AD (key for 5.2, 5.4, 5.6)
5.  AD-File-Shares-NAS-DFS             — file share access model: NAS, DFS, UNC, NTFS ACLs
6.  Access-Control-Models               — MAC, DAC, RBAC, ABAC, Rule-Based, Risk-Based, PDP/PEP (key for 5.4)
7.  Authentication-Factors-MFA          — identity proofing, factor types, biometrics, AAL, credential management, SSO, JIT, session management (key for 5.2)
8.  Kerberos-Protocol                   — KDC, TGT, service tickets, AES, NTP (key for 5.6)
9.  SAML-Federation                     — SAML 2.0, IDaaS, on-prem/cloud/hybrid federation (key for 5.3, 5.6)
10. OAuth2-OIDC                         — OAuth 2.0 delegation, OIDC authentication, JWT (key for 5.3, 5.6)
11. RADIUS-TACACS-Diameter              — AAA protocols, network access authentication (key for 5.6)
12. Privilege-Escalation-Service-Accounts — escalation types, service accounts, credential vaults, privilege creep (key for 5.2, 5.5)
13. IIQ-Concepts                        — understand governance tooling (key for 5.5)
14. IIQ-Data-Flows                      — understand the provisioning and certification flows
15. AD-Groups-in-IIQ-Governance         — tie everything together
16. AI-Agent-Identity-and-IAM           — emerging addendum: agents as governable IAM subjects (future-system context)
```

---

## IAM Fundamentals

Notes covering the underlying technology — no tooling yet, just the protocols and concepts.

- [[Physical-vs-Logical-Access]] — CISSP 5.1 foundations: AAA model, defense-in-depth principles, and how logical access materializes in IIQ
- [[IAM-Overview]] — the IAM stack: directory, authentication, authorization, governance, PAM layers
- [[AD-LDAP-Fundamentals]] — LDAP protocol, Active Directory, group types, key attributes, macOS/Linux integration
- [[AD-Domain-Forest-Trusts]] — domains, forests, trust types, cross-domain group scope rules, AGDLP
- [[AD-Application-Integration]] — Kerberos tokens, LDAP bind, SAML/federation, PAM/SSSD; how apps actually consume AD groups
- [[AD-File-Shares-NAS-DFS]] — NAS devices, UNC paths, DFS namespaces, NTFS vs. share permissions, AGDLP on file share ACLs
- [[Access-Control-Models]] — MAC, DAC, RBAC, Rule-Based, ABAC, Risk-Based; PDP/PEP architecture; implicit deny and constrained interfaces
- [[Authentication-Factors-MFA]] — identity registration/proofing, five factor types, MFA vs 2FA, biometrics (FAR/FRR/CER), AAL1/2/3, credential management systems, TOTP/FIDO2, SSO, JIT provisioning, session management
- [[Kerberos-Protocol]] — KDC, AS, TGS, TGT, Service Ticket, PAC; full ticket exchange flow; AES, NTP dependency, port 88
- [[SAML-Federation]] — SAML 2.0 assertion types, SP/IdP-initiated flows, metadata, IDaaS, WS-Federation, on-prem/cloud/hybrid federation
- [[OAuth2-OIDC]] — OAuth 2.0 grant types, OIDC authentication layer, JWT/ID tokens, delegated access, OAuth vs SAML
- [[RADIUS-TACACS-Diameter]] — AAA model, RADIUS (UDP 1812/1813), TACACS+ (TCP 49, full encryption), Diameter
- [[Privilege-Escalation-Service-Accounts]] — horizontal/vertical escalation, lateral movement, privilege creep, credential vaults, service account management, gMSA
- [[AI-Agent-Identity-and-IAM]] — emerging addendum: AI agents as non-human IAM subjects with delegated access, tool permissions, memory, ownership, and audit requirements

---

## SailPoint IIQ — Enterprise IAM Governance

Notes covering SailPoint IdentityIQ as a concrete implementation of IAM governance (CISSP 5.5).

### Concepts & Architecture
- [[IIQ-Concepts]] — Identity Cube, authoritative sources, roles, entitlements, JML lifecycle
- [[IIQ-Data-Flows]] — aggregation, correlation, access request, certification, and provisioning flows
- [[IIQ-Field-Values]] — enumerated values for all key status fields

### Active Directory Integration
- [[IIQ-AD-LDAP-Connector]] — connector config, aggregation mechanics, correlation rules, delta sync
- [[AD-Groups-in-IIQ-Governance]] — managed entitlements, role modelling, certifications, SQL recipes

### Schema Reference
- [[IIQ]] — complete database schema for all ~80 `spt_*` tables

### Analytics & Reporting
- [[IIQ-Analyst-Playbook]] — SQL recipes for common business questions

### Privileged Access
- [[CyberArk-IIQ-Integration]] — CyberArk PAM + SailPoint IIQ integration patterns
- [[PrivilegedA-Account-Data-Queries]] — SQL queries for privileged "A" accounts in AD

---

## CyberArk PAM — Privileged Access Management

Standalone reference for CyberArk Self-Hosted PAM, focused on data model, architecture, and dashboarding via Power BI. Treat this section as **supporting implementation context**, not the exam-core reading path. It reinforces CISSP 5.1 (control of privileged access), 5.2 (credential management systems / password vault), 5.4 (authorization for shared/admin accounts), and 5.5 (privileged account lifecycle), but many dashboard/API/reference notes are vendor-specific rather than CISSP objectives.

### Index
- [[CyberArk PAM/README|CyberArk PAM Index]] — entry point with full table of contents

### Core Concepts
- [[what-is-pam]] — Privileged Access Management fundamentals
- [[what-is-cyberark]] — CyberArk product suite overview (Self-Hosted)
- [[why-pam-matters]] — compliance and security drivers (SOX, PCI-DSS, SOC 2)

### Architecture
- [[CyberArk PAM/02-architecture/overview|CyberArk Architecture Overview]] — high-level architecture and data flows
- [[digital-vault]] — encrypted credential storage at the centre
- [[pvwa]] — web interface and REST API gateway (the dashboard integration point)
- [[cpm]] — password rotation engine
- [[psm]] — session isolation and recording
- [[pta]] — threat analytics
- [[aam-ccp]] — application credential retrieval
- [[deployment-models]] — Self-Hosted vs Privilege Cloud deployment options

### Data Model (Key Entities)
- [[safes]] — logical containers for accounts (the primary access boundary)
- [[accounts]] — privileged credentials (the central entity)
- [[platforms]] — management behaviour definitions per target type
- [[CyberArk PAM/03-key-entities/users-and-groups|CyberArk Users and Groups]] — vault users and LDAP integration
- [[policies-and-permissions]] — access control on safes
- [[CyberArk PAM/03-key-entities/sessions|CyberArk Sessions]] — privileged session objects

### Glossary & Reference
- [[CyberArk PAM/04-glossary/glossary|CyberArk Glossary]] — A–Z reference of CyberArk-specific terms
- [[common-error-codes]] — error code lookup
- [[further-reading]] — external docs and resources

### Dashboarding (Power BI)
- [[key-metrics-and-kpis]] — master metrics list
- [[password-management-dashboard]]
- [[session-monitoring-dashboard]]
- [[compliance-dashboard]]
- [[system-health-dashboard]]
- [[power-bi-integration]] — REST API authentication and query patterns

---

## Related

- [[CISSP - Index]] — all 8 CISSP domains
- [[Cyber Security]] — top-level cybersecurity note

exec
/bin/bash -lc "sed -n '1,240p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
# IIQ Concepts: Business Context for Data Analysts

This document gives a data analyst with zero IAM background enough conceptual understanding to interpret SailPoint IdentityIQ data. It answers the **why** — why these tables exist, why the data looks the way it does, and what business processes drive it. For the **what** — column names, types, join paths, and SQL — see [IIQ.md](IIQ.md).

---

## What is Identity Governance?

Every organization faces the same problem: **people join, move between roles, and leave — and each transition requires changes to their system access.** A new hire in Finance needs SAP, a shared drive, and an expense approval group. When she moves to Marketing, she needs different access. When she leaves, everything must be revoked.

Without governance, this creates three risks:

1. **Excessive access** — People accumulate permissions they no longer need ("entitlement creep") -> This is why big enterprise often create something known as "User Access Review".
2. **Orphan accounts** — Former employees retain active accounts on target systems
3. **Segregation of Duties (SOD) violations** — One person holds conflicting permissions (e.g., creating vendors AND approving payments)

**Regulatory frameworks** (SOX, SOD, GDPR, banking regulations) require organizations to demonstrate that access is appropriate, reviewed periodically, and revocable. Identity Governance and Administration (IGA) tools like SailPoint IdentityIQ exist to automate and audit this entire lifecycle.

**The core question IGA answers**: *Who has access to what, how did they get it, and is it still appropriate?*

As a data analyst, your job is to answer this question from the database. Everything in the IIQ schema exists to support some part of this answer.

---

## The Identity Cube

IIQ's central concept is the **Identity Cube** — a unified profile that aggregates a person's data from every connected system into a single view.

```
                          ┌──────────────────────┐
                          │    IDENTITY CUBE      │
                          │   "Jane Smith"        │
                          │   Dept: Finance       │
                          │   Manager: Bob Lee    │
                          │   Risk Score: 450     │
                          │   Status: Active      │
                          ├──────────────────────┤
                          │       ACCOUNTS        │
                ┌─────────┼─────────┬─────────────┤
                ↓         ↓         ↓             ↓
          ┌──────────┐ ┌────────┐ ┌─────────┐ ┌────────┐
          │ Active   │ │  SAP   │ │ Oracle  │ │ Unix   │
          │ Directory│ │  ERP   │ │  DB     │ │ Server │
          │          │ │        │ │         │ │        │
          │ jsmith   │ │ JSMITH │ │ jane.s  │ │ janes  │
          │          │ │        │ │         │ │        │
          │ Groups:  │ │ Roles: │ │ Grants: │ │ Groups:│
          │ Finance  │ │ FI01   │ │ SELECT  │ │ sudo   │
          │ VPN_Users│ │ FI02   │ │ INSERT  │ │ admin  │
          └──────────┘ └────────┘ └─────────┘ └────────┘
```

**How this maps to the database:**

| Concept | Table(s) | What it stores |
|---|---|---|
| The person (cube) | `spt_identity` | Core attributes: name, department, manager, status |
| Each account | `spt_link` | One row per account per application |
| Each entitlement | `spt_identity_entitlement` | One row per entitlement held by the identity |
| Roles assigned | `spt_identity_bundles` + `spt_identity.attributes` XML | Detected and assigned role memberships |

One person with accounts on 5 applications and 20 entitlements across those accounts produces: 1 row in `spt_identity`, 5 rows in `spt_link`, and 20 rows in `spt_identity_entitlement`. This is why `spt_identity_entitlement` is typically the largest table.

So basically, each account is associate with multiple entitlements. And often most of the time, AD group are the realization of these entitlements. 

---

## Key Concepts in Plain Language

### Application (authoritative vs. regular)

An **application** in IIQ represents any system that IIQ connects to — Active Directory, SAP, a database, a flat file from HR. Stored in `spt_application`.

The critical distinction is **authoritative vs. regular**:

- **Authoritative application** (`authoritative = 1`) — The source of truth for identity data, usually the HR system. When IIQ pulls data from this source, it **creates new identities** in `spt_identity` and updates core attributes (name, department, manager, status). There is typically one authoritative source.
- **Regular application** (`authoritative = 0`) — A target system where people have accounts. IIQ pulls account and entitlement data from these but does **not** create identities from them. Instead, it tries to match (correlate) accounts to existing identities.

**What this means for your data**: If `spt_application.authoritative = 1`, that application's aggregation drives identity lifecycle. Changes in the HR feed create, modify, and deactivate identities.

### Aggregation

**Aggregation** is the process of IIQ pulling data from a connected application into its database. Think of it as a scheduled import — IIQ reaches out to the target system, reads its current state, and synchronizes its local copy.

There are two types of aggregation:
- **Account aggregation** — Imports user accounts and their attributes. Creates/updates rows in `spt_link`.
- **Group/Entitlement aggregation** — Imports entitlement definitions (group names, role names). Creates/updates rows in `spt_managed_attribute` (the entitlement catalog).

When account aggregation runs:
1. IIQ connects to the application via its connector
2. Pulls all accounts → creates/updates rows in `spt_link`
3. For each account, reads entitlement attributes (e.g., AD group memberships) → updates `spt_identity_entitlement` per identity
4. Entitlements confirmed present are marked `aggregation_state = 'Connected'`
5. Entitlements previously seen but now absent are marked `aggregation_state = 'Disconnected'`
6. Results are logged in `spt_task_result`

**What this means for your data**: IIQ data is only as fresh as the last aggregation. The `spt_link.last_refresh` and `spt_identity.last_refresh` timestamps tell you when data was last pulled. If an aggregation hasn't run in a week, the entitlement data is a week old. The cube is a **mutable current-state store, overwritten on every aggregation** — it is neither a real-time mirror of the target systems nor a historical record of what they used to be. See [IIQ-Data-Flows.md — Aggregation Flow](IIQ-Data-Flows.md#1-aggregation-flow) for the complete step-by-step process.

### Correlation

**Correlation** is matching an account on a target application to a known identity. When IIQ aggregates an Active Directory account `jsmith`, it needs to figure out which `spt_identity` row that account belongs to.

Correlation uses rules (often matching on employee ID, email, or naming convention). When a match is found, `spt_link.identity_id` points to the correct `spt_identity` row, and the identity's `correlated` flag is set to `1`.

When **no match is found**, IIQ creates a new `spt_identity` row with `correlated = 0`. This is an **orphan account holder** — a placeholder identity that exists only because an uncorrelated account was found.

**What this means for your data**: The `correlated` flag on `spt_identity` is your most important filter. Always use `correlated = 1` to count real people. Uncorrelated identities (`correlated = 0`) inflate counts and produce misleading reports. See [IIQ.md — The correlated flag](IIQ.md#the-correlated-flag-is-your-most-important-filter).

### Entitlement

An **entitlement** is a single unit of access on an application. It could be an AD group membership, an SAP role, a database privilege, or a Unix group. It is the most granular building block of access.

Two tables work together:

- **`spt_managed_attribute`** — The entitlement **catalog**. One row per unique entitlement definition across all applications. Think of it as the "menu" of all possible access.
- **`spt_identity_entitlement`** — The entitlement **assignments**. One row per person per entitlement they hold. Think of it as "who ordered what from the menu."

These two tables connect through a **logical join** on `(application, attribute, value)`, not a foreign key. See [IIQ.md — Entitlement catalog](IIQ.md#entitlement-catalog-spt_managed_attribute).

### Role / Bundle

In IIQ, a **role** is called a **Bundle** in the database (`spt_bundle`). The name comes from the Java class `sailpoint.object.Bundle`. In the UI and documentation, you see "Role" — in the database, you see "Bundle."

Roles follow a hierarchy:

```
Business Role (type = 'business')
    └── requires → IT Role (type = 'it')
                       └── contains → Entitlement Profile (spt_profile)
                                          └── matches → Entitlements on Application
```

- **Business Role** — A logical grouping meaningful to the business (e.g., "Accounts Payable Clerk")
- **IT Role** — A technical grouping that maps to specific entitlements on specific applications (e.g., "SAP AP Access")
- **Entitlement Profile** — A filter definition that says "these entitlements on this application constitute this IT role"

The join tables `spt_bundle_requirements` (required IT roles) and `spt_bundle_permits` (optional IT roles) connect business roles to IT roles. See [IIQ.md — Roles and the bundle model](IIQ.md#roles-and-the-bundle-model).

### Role Detection vs. Role Assignment

This is one of the most confusing aspects of IIQ data. A person can have a role in two fundamentally different ways:

**Detected roles** — During Identity Refresh, IIQ looks at a person's current entitlements and checks if they match any role's entitlement profile. If they do, the role is **detected** — the person effectively *already has* the access that constitutes the role, even if nobody explicitly granted it. Detected roles are stored in `spt_identity_bundles`.

**Assigned roles** — A role explicitly granted to a person through a request, manual assignment, or lifecycle rule. Assigned roles are stored in the Identity's `attributes` XML as `RoleAssignment` objects (some versions also use `spt_identity_assigned_roles`).

A role can be **both assigned and detected** simultaneously. A role can be **assigned but not detected** (the provisioning hasn't completed yet, or entitlements changed). A role can be **detected but not assigned** (the person accumulated the right entitlements without a formal role grant).

**What this means for your data**: If you only query `spt_identity_bundles`, you see detected roles. For assigned roles, you must parse the `attributes` XML in `spt_identity` or query `spt_identity_assigned_roles` if available. See [IIQ.md — Assigned vs. detected roles](IIQ.md#assigned-roles-versus-detected-roles).

### Provisioning

**Provisioning** is the act of making changes on target systems — creating an account, adding a group membership, disabling an account. It is the "write" operation, as opposed to aggregation which is "read."

Provisioning can be:
- **Automatic** — IIQ directly changes the target system via its connector
- **Manual** — IIQ creates a work item for someone to make the change manually (when no connector supports the operation)

Provisioning history is recorded in `spt_provisioning_transaction`. Each row captures the operation, target system, identity, status (Success/Pending/Failed), and whether it was automatic or manual. See [IIQ.md — spt_provisioning_transaction](IIQ.md#spt_provisioning_transaction--provisioning-audit-trail).

### Certification / Access Review

A **certification** (also called an **access review**) is a periodic process where reviewers verify that people's access is still appropriate. Regulations like SOX require these reviews.

The process follows a strict hierarchy in the database:

1. **Definition** (`spt_certification_definition`) — The campaign template: who reviews, what scope, what schedule
2. **Group** (`spt_certification_group`) — A campaign instance (one execution of the definition)
3. **Certification** (`spt_certification`) — An individual review assignment per reviewer
4. **Entity** (`spt_certification_entity`) — Each identity being reviewed
5. **Item** (`spt_certification_item`) — Each entitlement/role under review
6. **Action** (`spt_certification_action`) — The reviewer's decision: Approved, Remediated, Mitigated, Delegated

**What this means for your data**: Certification data is deeply nested. To answer "what was decided about Jane's SAP access," you must join through the entire chain. See [IIQ.md — Certification and access review tables](IIQ.md#certification-and-access-review-tables).

### SOD and Policy Violations

**Separation of Duties (SOD)** policies define combinations of access that no single person should hold simultaneously. For example, "no one should have both Create Vendor and Approve Payment roles."

When IIQ detects a violation (usually during Identity Refresh or role assignment), it creates a row in `spt_policy_violation` with:
- The conflicting roles/entitlements (`left_bundles`, `right_bundles`)
- A `status`: **Open** (unaddressed), **Mitigated** (accepted with justification), or **Remediated** (access removed)

**Mitigation** means "we know this is a violation, but we accept it with a compensating control" — the access stays. **Remediation** means "remove the conflicting access." See [IIQ.md — Policy and SOD tables](IIQ.md#policy-and-sod-tables).

### Work Items

A **work item** is a task assigned to a person or workgroup in IIQ. The most common type is an **Approval** — when someone requests access, the approver gets a work item.

Work items are stored in `spt_work_item`. Key behaviors:
- **Open** work items have `state IS NULL` (not "Open" — null)
- **Completed** items have `state = 'Finished'`, `'Rejected'`, or `'Expired'`
- Completed items eventually move to `spt_work_item_archive`

Other work item types include Certification (review assignment), Remediation (fix a revocation), Challenge (dispute a revocation decision), and PolicyViolation (address a violation). See [IIQ.md — spt_work_item](IIQ.md#spt_work_item--approvals-and-manual-tasks).

### Lifecycle Events (Joiner / Mover / Leaver)

The **Joiner-Mover-Leaver** (JML) lifecycle is the backbone of identity management:

- **Joiner** — New identity arrives from the authoritative source. IIQ creates the `spt_identity` row, may auto-assign "birthright" roles (baseline access everyone gets), and triggers provisioning.
- **Mover** — Identity attributes change (department, title, manager). IIQ detects the change, may reassign roles based on new attributes, and provisions/deprovisions accordingly.
- **Leaver** — Identity is marked inactive in the authoritative source. IIQ sets `inactive = 1`, triggers disable/removal workflows, and may create work items for manual cleanup.

**What this means for your data**: The `inactive` flag on `spt_identity` is IIQ's leaver marker. An identity with `inactive = 1` is (or should be) in some stage of access removal. The `spt_identity` row persists — IIQ does not hard-delete leavers immediately.

---

## IIQ in the Enterprise Architecture

IIQ sits as **middleware between HR systems and target applications**:

```
┌────────────────┐        ┌──────────────────┐        ┌────────────────────┐
│  HR System     │───────→│  SailPoint IIQ   │───────→│  Target Systems    │
│  (Workday,     │  Auth  │                  │  Prov  │  (AD, SAP, DB,     │
│   SAP HCM,     │  Agg   │  Identity Cube   │  Agg   │   Unix, Cloud)     │
│   PeopleSoft)  │        │  Policy Engine   │        │                    │
└────────────────┘        │  Cert Engine     │        └────────────────────┘
                          │  Workflow Engine  │
                          └──────────────────┘
                                   ↑
                          ┌────────────────────┐
                          │  Reviewers/Admins  │
                          │  (UI, API, LCM)    │
                          └────────────────────┘
```

Key implications for analysts:

1. **IIQ is a secondary data source.** It reflects the state of other systems as of the last aggregation, not the current state. Always check `last_refresh` timestamps.
2. **IIQ does not own the data.** If an account exists in AD but IIQ hasn't aggregated it yet, it won't appear in `spt_link`. Conversely, if an account was deleted in AD but IIQ hasn't aggregated since, the `spt_link` row still exists.
3. **The authoritative source drives the identity lifecycle.** Changes in HR (new hire, termination) flow into IIQ and trigger downstream processes. IIQ doesn't decide who joins or leaves — it reacts to the HR feed.
4. **Data quality depends on connector configuration.** What IIQ sees is limited by what the connector is configured to pull. If the AD connector doesn't read the `memberOf` attribute, no AD group memberships appear in `spt_identity_entitlement`. Always check `spt_application` and `spt_schema` to understand what each connector imports.
5. **Timing matters.** Aggregation, identity refresh, role detection, and policy checks often run as separate scheduled tasks. Between these steps, data can be in a transitional state (e.g., new entitlements aggregated but roles not yet detected). See [IIQ-Data-Flows.md — Cross-Process Interactions](IIQ-Data-Flows.md#cross-process-interactions) for timing dependencies.

---

## Mental Models for Analysts


exec
/bin/bash -lc "sed -n '1,260p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: [iiq, active-directory, ldap, aggregation, connector, correlation, provisioning, cissp, domain-5-iam, cissp/5.5-provisioning-lifecycle]
aliases: [IIQ AD Connector, SailPoint AD Integration, LDAP Aggregation]
---

# IIQ AD/LDAP Connector

[[IIQ-Concepts|SailPoint IIQ]] does not store identities in a vacuum — it reads them from source systems. For most enterprises, [[AD-LDAP-Fundamentals|Active Directory]] is the most important source. This note explains how IIQ connects to AD/LDAP, what it reads, and how that data lands in IIQ's database.

---

## What an IIQ Application Is

In IIQ, an **Application** represents a connection to a single external system — a source of accounts and entitlements. For Active Directory, one Application typically corresponds to one [[AD-Domain-Forest-Trusts|domain]] (or the Global Catalog if reading across domains).

In the database, Applications live in `spt_application`. Key columns:

| Column | What it Stores |
|---|---|
| `name` | Human-readable name, e.g. `"Active Directory - Corp"` |
| `type` | Connector type, e.g. `"Active Directory"` or `"LDAP"` |
| `authoritative` | `1` = this app is a source of truth for identity attributes |
| `features_string` | Comma-separated capabilities: `AUTHENTICATE,PROVISIONING,SYNC` |
| `attributes` | XML blob containing all connector configuration |

> [!note] Authoritative applications
> An authoritative application (usually HR or the primary AD domain) drives identity creation in IIQ. When a new account appears in an authoritative app that has no matching identity, IIQ creates a new identity record. Non-authoritative apps add accounts to existing identities but don't create new ones.


---

## Connector Configuration

The AD connector configuration is stored in `spt_application.attributes` as XML, but conceptually it includes:

| Parameter | What It Controls | Example |
|---|---|---|
| **Host** | Domain controller hostname or IP | `dc01.corp.example.com` |
| **Port** | LDAP port | `389` (plain) or `636` (LDAPS) or `3268` (GC) |
| **Bind DN** | Service account used to query AD | `CN=svc-iiq,OU=ServiceAccounts,DC=corp,...` |
| **Bind Password** | Password for the service account | (encrypted in IIQ) |
| **Base DN** | Where in the DIT to start searching | `DC=corp,DC=example,DC=com` |
| **Object Filter** | LDAP filter to select accounts | `(&(objectClass=user)(!(objectClass=computer)))` |
| **Group Object Filter** | LDAP filter to select groups | `(objectClass=group)` |

> [!tip] Global Catalog port
> Using port **3268** (or 3269 for LDAPS) points IIQ at the Global Catalog, which returns objects from all domains in the forest in a single query. Useful for multi-domain forests where you want one IIQ Application to see everyone. Trade-off: the GC only returns a subset of attributes.

### Multi-Domain Environments

For multi-domain environments, see [[AD-Domain-Forest-Trusts]] for topology rules. In IIQ:

| Topology | Recommended Configuration |
|---|---|
| Single domain | One Application, point at a domain controller |
| Multi-domain, same forest | One Application per domain **or** one Application at GC port 3268 |
| Multi-forest | One Application per forest (or per domain) |

---

## What Gets Aggregated

Aggregation runs as **two separate scans** that answer two different questions:

| Scan | Question it answers | Data perspective | Target table |
|---|---|---|---|
| **Account aggregation** | Who exists and what are they a member of? | User's perspective | `spt_link`, `spt_identity_entitlement` |
| **Group aggregation** | What groups exist and what are their properties? | Group's perspective | `spt_managed_attribute` |

You need both. Account aggregation alone gives you memberships but no metadata about the groups themselves. Group aggregation alone gives you a catalog but no idea who holds what.

> [!warning] Run order dependency
> Group aggregation should run first (or be kept current). When account aggregation processes a user's `memberOf` and tries to write an `spt_identity_entitlement` row, it looks up the corresponding `spt_managed_attribute` record. If the group hasn't been aggregated yet — no catalog row exists — the entitlement may be created as unmanaged or skipped entirely. If you see AD memberships that aren't appearing in `spt_identity_entitlement`, check whether the group exists in `spt_managed_attribute` first.

### 1. Account Aggregation (`spt_link`)

Each user account in AD becomes one row in `spt_link`. Data flows from the **user's perspective** — "here is jsmith, and here are all the groups jsmith belongs to":

| `spt_link` Column | Source in AD |
|---|---|
| `native_identity` | Usually `sAMAccountName` or `distinguishedName` |
| `display_name` | `displayName` |
| `application` | FK to `spt_application.id` |
| `identity_id` | FK to `spt_identity.id` (set after correlation) |
| `attributes` | XML blob containing all aggregated AD attributes |
| `last_refresh` | Timestamp of most recent aggregation |

The `attributes` XML blob on `spt_link` stores every AD attribute IIQ was configured to collect: `sAMAccountName`, `userPrincipalName`, `department`, `memberOf`, `userAccountControl`, etc.

> [!note] Reading spt_link attributes
> Because `attributes` is an XML blob, querying specific AD attributes requires either IIQ's built-in attribute extraction or staging tables. See `staging_tables_generic.sql` in this repo for a pattern that normalises these into queryable columns.

### 2. Group Aggregation (`spt_managed_attribute`)

Each AD security group that IIQ is configured to manage becomes a row in `spt_managed_attribute`. Data flows from the **group's perspective** — "here is Finance_VPN_Group, and here is its description and owner":

| `spt_managed_attribute` Column | Source in AD |
|---|---|
| `attribute` | Always `"memberOf"` for AD groups |
| `value` | The group DN or `sAMAccountName` (connector-dependent) |
| `display_name` | Group's `displayName` or `cn` |
| `type` | `"Entitlement"` |
| `application` | FK to `spt_application.id` |
| `descriptions` | XML blob of group descriptions |
| `requestable` | Whether users can request this group via IIQ LCM |

This table is the **entitlement catalog** — the menu of all possible access IIQ knows about. It answers questions account aggregation cannot: what does this group actually grant? who owns it? can it be requested through IIQ?

---

## Attribute Mapping: AD → IIQ

When IIQ aggregates, it maps AD attributes to IIQ's schema. This mapping is configured in the Application's **schema**:

```
AD Attribute          →  IIQ Account Attribute
─────────────────────────────────────────────────
sAMAccountName        →  name (used as native identity)
displayName           →  displayName
mail                  →  email
department            →  department
userAccountControl    →  IIQ computes "inactive" from this
memberOf              →  drives entitlement population
objectGUID            →  objectGUID (stable correlation key)
```

IIQ uses `objectGUID` as the most reliable correlation key for AD accounts because it never changes, even when accounts are renamed or moved between OUs.

---

## How Group Membership Becomes an Entitlement

This is the bridge between AD groups and IIQ's governance model:

1. IIQ aggregates a user account from AD and reads the `memberOf` attribute
2. For each group DN in `memberOf`, IIQ looks up the corresponding `spt_managed_attribute` record
3. If found, IIQ writes a row to `spt_identity_entitlement` linking the identity to that entitlement
4. The row has `aggregation_state = 'Connected'` and `source = 'Application'`

If a user is removed from a group in AD and IIQ runs aggregation again, the corresponding `spt_identity_entitlement` row gets `aggregation_state = 'Disconnected'` — it is not immediately deleted, which allows IIQ to detect and report on access that was removed outside of IIQ's governance.

See [[AD-Groups-in-IIQ-Governance]] for the full picture of how these entitlements flow into roles, certifications, and provisioning.

---

## Correlation Rules

**Correlation** is the process of matching an aggregated AD account to the correct `spt_identity` record. Without correlation, IIQ cannot associate the AD account "jsmith" with the identity "John Smith" from HR.

Correlation rules are written in BeanShell (Java-like scripting) or configured declaratively. A typical correlation rule for AD:

```java
// Match on employeeNumber: AD's employeeID = HR's employee number
String empId = account.getAttribute("employeeID");
if (empId != null) {
    return "employeeNumber == '" + empId + "'";
}
// Fallback: match on email
String email = account.getAttribute("mail");
if (email != null) {
    return "email == '" + email + "'";
}
return null; // No match found — account becomes uncorrelated
```

| Correlation Outcome | Result |
|---|---|
| Match found | `spt_link.identity_id` is set; `spt_identity.correlated = 1` |
| No match found | Account stays uncorrelated; identity cube shows it as orphan |
| Multiple matches | Ambiguous — IIQ logs an error; manual resolution needed |

> [!warning] Uncorrelated accounts
> Uncorrelated accounts are a risk: IIQ cannot govern access it cannot attribute to a person. Regular orphan account cleanup is a key IAM hygiene task. See [[AD-Groups-in-IIQ-Governance]] for the SQL to find them.

---

## Full vs. Delta Aggregation

IIQ supports two aggregation modes for AD:

### Full Aggregation
- Reads every object matching the configured filter
- Compares against what IIQ already has
- Detects additions, removals, and changes
- Slow for large directories (tens of thousands of accounts)
- Typically scheduled weekly or monthly

### Delta Aggregation (Recommended for AD)
- Uses Microsoft's **DirSync** protocol by default to detect only objects modified since the last sync
- IIQ stores a DirSync cookie per domain after each run; the next delta reads only changes since that cookie
- Fast — only processes genuinely changed objects
- Typically scheduled hourly or more frequently

> [!note] DirSync vs. uSNChanged
> The AD connector uses **DirSync** as the default delta mechanism (introduced in IIQ 6.3). DirSync requires the bind account to have **Replicating Directory Changes** permission on the domain.
>
> An older method, **uSNChanged**, tracks the highest `uSNChanged` value seen and queries for anything higher on the next run. It requires only List and Read permissions but is unreliable in multi-DC or load-balanced environments — `uSNChanged` is not replicated across domain controllers, so IIQ must always query the same DC to avoid missing changes. DirSync does not have this limitation.
>
> Source: [SailPoint — Active Directory delta aggregation: DirSync vs. uSNChanged](https://community.sailpoint.com/t5/IdentityIQ-Wiki/Active-Directory-delta-aggregation-DirSync-vs-uSNChanged/ta-p/72397)

### What Triggers Aggregation
- Scheduled tasks configured in IIQ's task scheduler
- Manual run by an IIQ administrator
- Event-based triggers (e.g., an HR event fires a lifecycle workflow, which triggers a targeted aggregation)

---

## The Connector Gap

The connector is a **scheduled reader, not a real-time listener**. It polls AD on a cadence. Everything IIQ knows about AD is only as fresh as the last aggregation timestamp on `spt_link.last_refresh`.

```
IIQ scheduler fires
        │
        ▼
Connector opens LDAP connection to AD
        │
        ▼
Reads all accounts + their memberOf attributes
        │
        ▼
Compares what it found against what IIQ already has
        │
        ▼
Updates spt_link, spt_identity_entitlement, flags needs_refresh
```

**The gap is the window between polls.** If a sysadmin manually adds Jane to `Domain Admins` in AD at 9am, and the next aggregation runs at midnight, IIQ has no visibility for 15 hours. During that window:

- Jane has the access in reality
- `spt_identity_entitlement` shows nothing
- No certification item exists for it
- No SOD check has fired
- Risk score has not updated

When aggregation finally runs, IIQ finds the new membership and writes a row with `aggregation_state = 'Connected'` and `assigned = 0` — meaning the entitlement was found on the system but was never requested through IIQ. This is the signal that access was granted outside the governed process.

### The `Disconnected` signal works in reverse

If Jane is removed from `Domain Admins` directly in AD — bypassing IIQ's provisioning — the next aggregation finds the group missing from her `memberOf`. IIQ does **not** delete the `spt_identity_entitlement` row. It sets `aggregation_state = 'Disconnected'`.

This distinction matters for auditors: the record proves that access existed and was removed, but the `Disconnected` state specifically flags that removal happened outside IIQ's workflow rather than through a governed request or certification decision.

> [!warning] Gap size is a governance risk
> A 24-hour delta aggregation schedule means changes made directly in AD are invisible to IIQ for up to a day. For high-risk groups (privileged admin groups, finance application roles), shorter aggregation intervals or event-based triggers reduce this exposure window.

---

## Useful SQL: Accounts from AD

Find all accounts aggregated from a specific AD application:

```sql
-- All accounts from "Active Directory - Corp"
SELECT
    i.display_name          AS identity_name,
    l.native_identity       AS ad_account,
    l.display_name          AS account_display_name,
    l.last_refresh          AS last_aggregated
FROM spt_link l

codex
I found the relevant connector section. One line-number lookup hit a sandbox wrapper issue, so I’m retrying it plainly to anchor the answer to the note.
exec
/bin/bash -lc "sed -n '150,180p' '/home/nhatquang/Knowledge/Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
Correlation rules are written in BeanShell (Java-like scripting) or configured declaratively. A typical correlation rule for AD:

```java
// Match on employeeNumber: AD's employeeID = HR's employee number
String empId = account.getAttribute("employeeID");
if (empId != null) {
    return "employeeNumber == '" + empId + "'";
}
// Fallback: match on email
String email = account.getAttribute("mail");
if (email != null) {
    return "email == '" + email + "'";
}
return null; // No match found — account becomes uncorrelated
```

| Correlation Outcome | Result |
|---|---|
| Match found | `spt_link.identity_id` is set; `spt_identity.correlated = 1` |
| No match found | Account stays uncorrelated; identity cube shows it as orphan |
| Multiple matches | Ambiguous — IIQ logs an error; manual resolution needed |

> [!warning] Uncorrelated accounts
> Uncorrelated accounts are a risk: IIQ cannot govern access it cannot attribute to a person. Regular orphan account cleanup is a key IAM hygiene task. See [[AD-Groups-in-IIQ-Governance]] for the SQL to find them.

---

## Full vs. Delta Aggregation

IIQ supports two aggregation modes for AD:


exec
/bin/bash -lc "sed -n '180,220p' '/home/nhatquang/Knowledge/Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:

### Full Aggregation
- Reads every object matching the configured filter
- Compares against what IIQ already has
- Detects additions, removals, and changes
- Slow for large directories (tens of thousands of accounts)
- Typically scheduled weekly or monthly

### Delta Aggregation (Recommended for AD)
- Uses Microsoft's **DirSync** protocol by default to detect only objects modified since the last sync
- IIQ stores a DirSync cookie per domain after each run; the next delta reads only changes since that cookie
- Fast — only processes genuinely changed objects
- Typically scheduled hourly or more frequently

> [!note] DirSync vs. uSNChanged
> The AD connector uses **DirSync** as the default delta mechanism (introduced in IIQ 6.3). DirSync requires the bind account to have **Replicating Directory Changes** permission on the domain.
>
> An older method, **uSNChanged**, tracks the highest `uSNChanged` value seen and queries for anything higher on the next run. It requires only List and Read permissions but is unreliable in multi-DC or load-balanced environments — `uSNChanged` is not replicated across domain controllers, so IIQ must always query the same DC to avoid missing changes. DirSync does not have this limitation.
>
> Source: [SailPoint — Active Directory delta aggregation: DirSync vs. uSNChanged](https://community.sailpoint.com/t5/IdentityIQ-Wiki/Active-Directory-delta-aggregation-DirSync-vs-uSNChanged/ta-p/72397)

### What Triggers Aggregation
- Scheduled tasks configured in IIQ's task scheduler
- Manual run by an IIQ administrator
- Event-based triggers (e.g., an HR event fires a lifecycle workflow, which triggers a targeted aggregation)

---

## The Connector Gap

The connector is a **scheduled reader, not a real-time listener**. It polls AD on a cadence. Everything IIQ knows about AD is only as fresh as the last aggregation timestamp on `spt_link.last_refresh`.

```
IIQ scheduler fires
        │
        ▼
Connector opens LDAP connection to AD
        │
        ▼
Reads all accounts + their memberOf attributes
        │

codex
SailPoint IIQ’s AD connector uses **Microsoft DirSync** by default for delta aggregation.

The AD bind account needs **Replicating Directory Changes** permission on the domain.

Source: [IIQ-AD-LDAP-Connector.md](/home/nhatquang/Knowledge/Cyber%20Security/CISSP/Domain%205%20-%20Identity%20and%20Access%20Management/SailPoint%20IIQ/IIQ-AD-LDAP-Connector.md), section “Full vs. Delta Aggregation”.
tokens used
17,639
SailPoint IIQ’s AD connector uses **Microsoft DirSync** by default for delta aggregation.

The AD bind account needs **Replicating Directory Changes** permission on the domain.

Source: [IIQ-AD-LDAP-Connector.md](/home/nhatquang/Knowledge/Cyber%20Security/CISSP/Domain%205%20-%20Identity%20and%20Access%20Management/SailPoint%20IIQ/IIQ-AD-LDAP-Connector.md), section “Full vs. Delta Aggregation”.

---

## Q05

**Question:** In SailPoint IIQ, what is the difference between a detected role and an assigned role?

**Answer:**

Reading additional input from stdin...
OpenAI Codex v0.130.0
--------
workdir: /home/nhatquang/Knowledge
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, /home/nhatquang/.codex/memories]
reasoning effort: medium
reasoning summaries: none
session id: 019e11df-01c6-7ee1-9f10-ad819b326a8a
--------
user
You are working in a personal knowledge vault. Start by reading `README.md` to orient yourself. Use `knowledge-index.md` to locate specific notes. Do not scan the entire vault — route through the index first.

In SailPoint IIQ, what is the difference between a detected role and an assigned role?
warning: Codex's Linux sandbox uses bubblewrap and needs access to create user namespaces.
2026-05-10T12:31:30.295841Z ERROR rmcp::transport::worker: worker quit with fatal: Transport channel closed, when AuthRequired(AuthRequiredError { www_authenticate_header: "Bearer error=\"invalid_request\", error_description=\"No access token was provided in this request\", resource_metadata=\"https://api.githubcopilot.com/.well-known/oauth-protected-resource/mcp/\"" })
codex
I’ll orient through the vault entry points first, then use the index to find the SailPoint note rather than scanning broadly.
exec
/bin/bash -lc "sed -n '1,220p' README.md" in /home/nhatquang/Knowledge
exec
/bin/bash -lc "sed -n '1,260p' knowledge-index.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Vault

Personal knowledge base for CISSP exam preparation, enterprise IAM, data science, and machine learning. Notes are written for long-term retention — every note is independently useful weeks after it was written.

For writing standards and folder conventions, see `CLAUDE.md`.

---

## Where to Start

Route by task:

| I want to... | Start here |
|---|---|
| Study IAM / access control / identity governance | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` |
| Understand SailPoint IIQ or CyberArk | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` |
| Study causal inference methods | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` |
| Find or review a project | `Projects/Project List.md` |
| Navigate any domain | `knowledge-index.md` |
| Understand the full CISSP curriculum | `Cyber Security/CISSP/CISSP - Index.md` |

---

## Source Priority

When multiple notes cover the same topic, prefer in this order:

1. **Project notes** (`Projects/`) — current applied context
2. **Domain index / MOC notes** — authoritative navigation layer
3. **Concept notes** — detailed topic explanations
4. **`_Source/` folders** — raw imported material, not the owner's final opinion

Do not treat `_Source/` content as advice or conclusions. It is reference material only.

---

## Domain Map

| Domain | MOC / Entry Point | Status |
|---|---|---|
| Cyber Security — IAM | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` | Active |
| Cyber Security — CISSP | `Cyber Security/CISSP/CISSP - Index.md` | Active (Domain 5 only) |
| Statistics — Causal Inference | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` | Active |
| Statistics | `Statistics/Statistics.md` | Active |
| Deep Learning | `Deep Learning/Deep Learning.md` | Study notes |
| Machine Learning | `Machine Learning/Machine Learning.md` | Study notes |
| Finance | `Finance/Finance.md` | Study notes |
| Projects | `Projects/Project List.md` | Active |
| Playbooks | `Playbooks/` | Active |

---

## Rules

- Always read the domain MOC or index note before diving into deep concept notes
- `_Source/` folders contain raw imported material — do not treat as authoritative
- Notes link bidirectionally — if note A links to B, B links back to A
- A note with `status: stale` in its frontmatter may be outdated — verify before using
- Wikilinks (`[[Note Name]]`) are Obsidian-specific; resolve them as relative file paths

---

## Status Guide

| Status | Meaning |
|---|---|
| `active` | Current, maintained, reliable |
| `draft` | Work in progress, incomplete |
| `reference` | Stable reference material, not actively updated |
| `stale` | Potentially outdated — verify before using |
| `imported` | Raw source material, not processed into vault opinion |

 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Index

Flat index of every major area in this vault. Load this file first to orient without scanning 425 files. One entry per note: path → what it covers.

---

## Cyber Security

### CISSP
- `Cyber Security/CISSP/CISSP - Index.md` — top-level map of all 8 CISSP domains; only Domain 5 has notes
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` — Domain 5 MOC and reading path

### IAM Fundamentals
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/IAM-Overview.md` — what IAM is and how the stack fits together
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-LDAP-Fundamentals.md` — Active Directory and LDAP basics; group types, memberOf, ADUC
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-Domain-Forest-Trusts.md` — domain topology, forest trusts, group scope rules
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Authentication-Factors-MFA.md` — MFA types and authentication factors
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/OAuth2-OIDC.md` — OAuth2 and OpenID Connect protocols
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Access-Control-Models.md` — DAC, MAC, RBAC, ABAC models
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Physical-vs-Logical-Access.md` — physical vs logical access controls
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Privilege-Escalation-Service-Accounts.md` — privilege escalation paths and service account risks

### SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` — business context for IIQ: identity cube, aggregation, entitlements, roles, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ.md` — complete spt_* schema reference; all tables, columns, joins
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Field-Values.md` — status codes, type enumerations, flag values for all tables
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Data-Flows.md` — step-by-step flows: aggregation, refresh, JML, requests, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md` — how IIQ connects to AD; aggregation types, delta/DirSync, connector gap
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Analyst-Playbook.md` — 60+ SQL recipes for common business questions
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/AD-Groups-in-IIQ-Governance.md` — how AD groups become governed entitlements in IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/CyberArk-IIQ-Integration.md` — three integration patterns between CyberArk PAM and SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/PrivilegedA-Account-Data-Queries.md` — MySQL queries for PRIV_*_A privileged accounts

---

## Statistics

- `Statistics/Statistics.md` — top-level MOC for all statistics topics
- `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` — method selection guide: DiD, matching, RDD, synthetic control
- `Statistics/Causal Inference/Causal Inference.md` — entry point to 25-chapter causal inference study notes
- `Statistics/AB Testing/AB Testing fundamental.md` — A/B testing fundamentals
- `Statistics/Statistical thinking.md` — statistical thinking principles
- `Statistics/Causal Inference/_Source/` — raw imported Python Causality Handbook; not authoritative

---

## Deep Learning

- `Deep Learning/Deep Learning.md` — domain MOC; all subfields and entry points
- `Deep Learning/NLP/NLP.md` — NLP entry point; most developed subfield in this vault
- `Deep Learning/NLP/LLMOps/LLMOps.md` — LLM operations and deployment
- `Deep Learning/NLP/LLMs/Building Production-Grade LLM apps.md` — production LLM application patterns
- `Deep Learning/NLP/LLMs/Multi-Agent LLMs.md` — multi-agent LLM architectures
- `Deep Learning/Foundations/Loss function.md` — loss functions overview
- `Deep Learning/Computer Vision/Generate Image.md` — image generation entry point
- `Deep Learning/XAI/Trustworthy and Explainable AI.md` — XAI and model interpretability
- `Deep Learning/GNN/Advanced GNN.md` — graph neural networks
- `Deep Learning/Open Source/HuggingFace open source.md` — HuggingFace ecosystem

---

## Machine Learning

- `Machine Learning/Machine Learning.md` — domain MOC; clustering and regression
- `Machine Learning/Clustering algorithm/Clustering Algorithm.md` — clustering methods
- `Machine Learning/Regression algorithm/Regression Algorithm.md` — regression methods

---

## Finance

- `Finance/Finance.md` — domain MOC; corporate finance and bank management
- `Finance/Corporate Finance.md` — corporate finance section index
- `Finance/Bank Management and Strategy.md` — bank management section index

---

## Projects

- `Projects/Project List.md` — project registry with status and next actions
- `Projects/Causal IAM Risk Analytics.md` — causal analysis of IAM risk (Idea/MVP)
- `Projects/Fraud Detection using ML.md` — fraud detection project (Draft)
- `Projects/Neural Style Transfer.md` — neural style transfer (Active)

---

## Playbooks

- `Playbooks/Start a New Project.md` — steps to initialize a new project in this vault
- `Playbooks/Causal Analysis Checklist.md` — method selection and data readiness for causal inference
- `Playbooks/Evaluate a Dataset.md` — dataset assessment before starting analysis

codex
The index points to the SailPoint IIQ concept note as the authoritative starting point, with schema and data-flow notes available if the concept answer needs table-level grounding. I’m checking those targeted notes now.
exec
/bin/bash -lc "sed -n '1,240p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: [cissp, domain-5-iam, moc, identity, access-management]
aliases: [CISSP Domain 5, IAM Domain, Identity and Access Management]
---

# CISSP Domain 5 — Identity and Access Management

Identity and Access Management (IAM) ensures the right people have the right access to the right resources at the right time. Domain 5 covers the full lifecycle: from proving identity, to granting access, to reviewing and revoking it.

---

## CISSP Domain 5 Subtopics

| Subtopic                                    | What It Covers                                                                                                   | Notes in This Vault                                                                                                                                                                       |
| ------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **5.1** Control physical and logical access | Access control models, physical access, least privilege                                                          | [[Physical-vs-Logical-Access]], [[IAM-Overview]], [[what-is-pam]], [[CyberArk-IIQ-Integration]]                                                                                           |
| **5.2** Identification & Authentication     | Groups and roles, AAA, MFA, passwordless, session management, identity proofing, credential management, SSO, JIT | [[AD-LDAP-Fundamentals]], [[AD-Application-Integration]], [[Authentication-Factors-MFA]], [[Kerberos-Protocol]], [[Privilege-Escalation-Service-Accounts]], [[AI-Agent-Identity-and-IAM]] |
| **5.3** Federated Identity                  | SAML, OAuth, OIDC, domain trusts, cross-forest                                                                   | [[AD-Domain-Forest-Trusts]], [[AD-Application-Integration]], [[SAML-Federation]], [[OAuth2-OIDC]]                                                                                         |
| **5.4** Authorization mechanisms            | RBAC, ABAC, ACLs, group-based access                                                                             | [[Access-Control-Models]], [[AD-Application-Integration]], [[AD-File-Shares-NAS-DFS]], [[AD-Groups-in-IIQ-Governance]], [[AI-Agent-Identity-and-IAM]]                                     |
| **5.5** Provisioning lifecycle              | JML (Joiner-Mover-Leaver), access requests, certifications                                                       | [[IIQ-Concepts]], [[IIQ-Data-Flows]], [[IIQ-AD-LDAP-Connector]], [[Privilege-Escalation-Service-Accounts]], [[AI-Agent-Identity-and-IAM]]                                                 |
| **5.6** Authentication systems              | SSO, Kerberos, RADIUS, TACACS+                                                                                   | [[Kerberos-Protocol]], [[SAML-Federation]], [[OAuth2-OIDC]], [[RADIUS-TACACS-Diameter]], [[AD-Application-Integration]]                                                                   |

---

## Reading Path

Start here if you're new to IAM:

```
1.  IAM-Overview                        — understand the technology stack and where each tool fits
2.  AD-LDAP-Fundamentals                — understand directories, groups, and AD itself
3.  AD-Domain-Forest-Trusts             — understand cross-domain topology (key for 5.3)
4.  AD-Application-Integration          — understand how apps consume AD (key for 5.2, 5.4, 5.6)
5.  AD-File-Shares-NAS-DFS             — file share access model: NAS, DFS, UNC, NTFS ACLs
6.  Access-Control-Models               — MAC, DAC, RBAC, ABAC, Rule-Based, Risk-Based, PDP/PEP (key for 5.4)
7.  Authentication-Factors-MFA          — identity proofing, factor types, biometrics, AAL, credential management, SSO, JIT, session management (key for 5.2)
8.  Kerberos-Protocol                   — KDC, TGT, service tickets, AES, NTP (key for 5.6)
9.  SAML-Federation                     — SAML 2.0, IDaaS, on-prem/cloud/hybrid federation (key for 5.3, 5.6)
10. OAuth2-OIDC                         — OAuth 2.0 delegation, OIDC authentication, JWT (key for 5.3, 5.6)
11. RADIUS-TACACS-Diameter              — AAA protocols, network access authentication (key for 5.6)
12. Privilege-Escalation-Service-Accounts — escalation types, service accounts, credential vaults, privilege creep (key for 5.2, 5.5)
13. IIQ-Concepts                        — understand governance tooling (key for 5.5)
14. IIQ-Data-Flows                      — understand the provisioning and certification flows
15. AD-Groups-in-IIQ-Governance         — tie everything together
16. AI-Agent-Identity-and-IAM           — emerging addendum: agents as governable IAM subjects (future-system context)
```

---

## IAM Fundamentals

Notes covering the underlying technology — no tooling yet, just the protocols and concepts.

- [[Physical-vs-Logical-Access]] — CISSP 5.1 foundations: AAA model, defense-in-depth principles, and how logical access materializes in IIQ
- [[IAM-Overview]] — the IAM stack: directory, authentication, authorization, governance, PAM layers
- [[AD-LDAP-Fundamentals]] — LDAP protocol, Active Directory, group types, key attributes, macOS/Linux integration
- [[AD-Domain-Forest-Trusts]] — domains, forests, trust types, cross-domain group scope rules, AGDLP
- [[AD-Application-Integration]] — Kerberos tokens, LDAP bind, SAML/federation, PAM/SSSD; how apps actually consume AD groups
- [[AD-File-Shares-NAS-DFS]] — NAS devices, UNC paths, DFS namespaces, NTFS vs. share permissions, AGDLP on file share ACLs
- [[Access-Control-Models]] — MAC, DAC, RBAC, Rule-Based, ABAC, Risk-Based; PDP/PEP architecture; implicit deny and constrained interfaces
- [[Authentication-Factors-MFA]] — identity registration/proofing, five factor types, MFA vs 2FA, biometrics (FAR/FRR/CER), AAL1/2/3, credential management systems, TOTP/FIDO2, SSO, JIT provisioning, session management
- [[Kerberos-Protocol]] — KDC, AS, TGS, TGT, Service Ticket, PAC; full ticket exchange flow; AES, NTP dependency, port 88
- [[SAML-Federation]] — SAML 2.0 assertion types, SP/IdP-initiated flows, metadata, IDaaS, WS-Federation, on-prem/cloud/hybrid federation
- [[OAuth2-OIDC]] — OAuth 2.0 grant types, OIDC authentication layer, JWT/ID tokens, delegated access, OAuth vs SAML
- [[RADIUS-TACACS-Diameter]] — AAA model, RADIUS (UDP 1812/1813), TACACS+ (TCP 49, full encryption), Diameter
- [[Privilege-Escalation-Service-Accounts]] — horizontal/vertical escalation, lateral movement, privilege creep, credential vaults, service account management, gMSA
- [[AI-Agent-Identity-and-IAM]] — emerging addendum: AI agents as non-human IAM subjects with delegated access, tool permissions, memory, ownership, and audit requirements

---

## SailPoint IIQ — Enterprise IAM Governance

Notes covering SailPoint IdentityIQ as a concrete implementation of IAM governance (CISSP 5.5).

### Concepts & Architecture
- [[IIQ-Concepts]] — Identity Cube, authoritative sources, roles, entitlements, JML lifecycle
- [[IIQ-Data-Flows]] — aggregation, correlation, access request, certification, and provisioning flows
- [[IIQ-Field-Values]] — enumerated values for all key status fields

### Active Directory Integration
- [[IIQ-AD-LDAP-Connector]] — connector config, aggregation mechanics, correlation rules, delta sync
- [[AD-Groups-in-IIQ-Governance]] — managed entitlements, role modelling, certifications, SQL recipes

### Schema Reference
- [[IIQ]] — complete database schema for all ~80 `spt_*` tables

### Analytics & Reporting
- [[IIQ-Analyst-Playbook]] — SQL recipes for common business questions

### Privileged Access
- [[CyberArk-IIQ-Integration]] — CyberArk PAM + SailPoint IIQ integration patterns
- [[PrivilegedA-Account-Data-Queries]] — SQL queries for privileged "A" accounts in AD

---

## CyberArk PAM — Privileged Access Management

Standalone reference for CyberArk Self-Hosted PAM, focused on data model, architecture, and dashboarding via Power BI. Treat this section as **supporting implementation context**, not the exam-core reading path. It reinforces CISSP 5.1 (control of privileged access), 5.2 (credential management systems / password vault), 5.4 (authorization for shared/admin accounts), and 5.5 (privileged account lifecycle), but many dashboard/API/reference notes are vendor-specific rather than CISSP objectives.

### Index
- [[CyberArk PAM/README|CyberArk PAM Index]] — entry point with full table of contents

### Core Concepts
- [[what-is-pam]] — Privileged Access Management fundamentals
- [[what-is-cyberark]] — CyberArk product suite overview (Self-Hosted)
- [[why-pam-matters]] — compliance and security drivers (SOX, PCI-DSS, SOC 2)

### Architecture
- [[CyberArk PAM/02-architecture/overview|CyberArk Architecture Overview]] — high-level architecture and data flows
- [[digital-vault]] — encrypted credential storage at the centre
- [[pvwa]] — web interface and REST API gateway (the dashboard integration point)
- [[cpm]] — password rotation engine
- [[psm]] — session isolation and recording
- [[pta]] — threat analytics
- [[aam-ccp]] — application credential retrieval
- [[deployment-models]] — Self-Hosted vs Privilege Cloud deployment options

### Data Model (Key Entities)
- [[safes]] — logical containers for accounts (the primary access boundary)
- [[accounts]] — privileged credentials (the central entity)
- [[platforms]] — management behaviour definitions per target type
- [[CyberArk PAM/03-key-entities/users-and-groups|CyberArk Users and Groups]] — vault users and LDAP integration
- [[policies-and-permissions]] — access control on safes
- [[CyberArk PAM/03-key-entities/sessions|CyberArk Sessions]] — privileged session objects

### Glossary & Reference
- [[CyberArk PAM/04-glossary/glossary|CyberArk Glossary]] — A–Z reference of CyberArk-specific terms
- [[common-error-codes]] — error code lookup
- [[further-reading]] — external docs and resources

### Dashboarding (Power BI)
- [[key-metrics-and-kpis]] — master metrics list
- [[password-management-dashboard]]
- [[session-monitoring-dashboard]]
- [[compliance-dashboard]]
- [[system-health-dashboard]]
- [[power-bi-integration]] — REST API authentication and query patterns

---

## Related

- [[CISSP - Index]] — all 8 CISSP domains
- [[Cyber Security]] — top-level cybersecurity note

exec
/bin/bash -lc "sed -n '1,260p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
# IIQ Concepts: Business Context for Data Analysts

This document gives a data analyst with zero IAM background enough conceptual understanding to interpret SailPoint IdentityIQ data. It answers the **why** — why these tables exist, why the data looks the way it does, and what business processes drive it. For the **what** — column names, types, join paths, and SQL — see [IIQ.md](IIQ.md).

---

## What is Identity Governance?

Every organization faces the same problem: **people join, move between roles, and leave — and each transition requires changes to their system access.** A new hire in Finance needs SAP, a shared drive, and an expense approval group. When she moves to Marketing, she needs different access. When she leaves, everything must be revoked.

Without governance, this creates three risks:

1. **Excessive access** — People accumulate permissions they no longer need ("entitlement creep") -> This is why big enterprise often create something known as "User Access Review".
2. **Orphan accounts** — Former employees retain active accounts on target systems
3. **Segregation of Duties (SOD) violations** — One person holds conflicting permissions (e.g., creating vendors AND approving payments)

**Regulatory frameworks** (SOX, SOD, GDPR, banking regulations) require organizations to demonstrate that access is appropriate, reviewed periodically, and revocable. Identity Governance and Administration (IGA) tools like SailPoint IdentityIQ exist to automate and audit this entire lifecycle.

**The core question IGA answers**: *Who has access to what, how did they get it, and is it still appropriate?*

As a data analyst, your job is to answer this question from the database. Everything in the IIQ schema exists to support some part of this answer.

---

## The Identity Cube

IIQ's central concept is the **Identity Cube** — a unified profile that aggregates a person's data from every connected system into a single view.

```
                          ┌──────────────────────┐
                          │    IDENTITY CUBE      │
                          │   "Jane Smith"        │
                          │   Dept: Finance       │
                          │   Manager: Bob Lee    │
                          │   Risk Score: 450     │
                          │   Status: Active      │
                          ├──────────────────────┤
                          │       ACCOUNTS        │
                ┌─────────┼─────────┬─────────────┤
                ↓         ↓         ↓             ↓
          ┌──────────┐ ┌────────┐ ┌─────────┐ ┌────────┐
          │ Active   │ │  SAP   │ │ Oracle  │ │ Unix   │
          │ Directory│ │  ERP   │ │  DB     │ │ Server │
          │          │ │        │ │         │ │        │
          │ jsmith   │ │ JSMITH │ │ jane.s  │ │ janes  │
          │          │ │        │ │         │ │        │
          │ Groups:  │ │ Roles: │ │ Grants: │ │ Groups:│
          │ Finance  │ │ FI01   │ │ SELECT  │ │ sudo   │
          │ VPN_Users│ │ FI02   │ │ INSERT  │ │ admin  │
          └──────────┘ └────────┘ └─────────┘ └────────┘
```

**How this maps to the database:**

| Concept | Table(s) | What it stores |
|---|---|---|
| The person (cube) | `spt_identity` | Core attributes: name, department, manager, status |
| Each account | `spt_link` | One row per account per application |
| Each entitlement | `spt_identity_entitlement` | One row per entitlement held by the identity |
| Roles assigned | `spt_identity_bundles` + `spt_identity.attributes` XML | Detected and assigned role memberships |

One person with accounts on 5 applications and 20 entitlements across those accounts produces: 1 row in `spt_identity`, 5 rows in `spt_link`, and 20 rows in `spt_identity_entitlement`. This is why `spt_identity_entitlement` is typically the largest table.

So basically, each account is associate with multiple entitlements. And often most of the time, AD group are the realization of these entitlements. 

---

## Key Concepts in Plain Language

### Application (authoritative vs. regular)

An **application** in IIQ represents any system that IIQ connects to — Active Directory, SAP, a database, a flat file from HR. Stored in `spt_application`.

The critical distinction is **authoritative vs. regular**:

- **Authoritative application** (`authoritative = 1`) — The source of truth for identity data, usually the HR system. When IIQ pulls data from this source, it **creates new identities** in `spt_identity` and updates core attributes (name, department, manager, status). There is typically one authoritative source.
- **Regular application** (`authoritative = 0`) — A target system where people have accounts. IIQ pulls account and entitlement data from these but does **not** create identities from them. Instead, it tries to match (correlate) accounts to existing identities.

**What this means for your data**: If `spt_application.authoritative = 1`, that application's aggregation drives identity lifecycle. Changes in the HR feed create, modify, and deactivate identities.

### Aggregation

**Aggregation** is the process of IIQ pulling data from a connected application into its database. Think of it as a scheduled import — IIQ reaches out to the target system, reads its current state, and synchronizes its local copy.

There are two types of aggregation:
- **Account aggregation** — Imports user accounts and their attributes. Creates/updates rows in `spt_link`.
- **Group/Entitlement aggregation** — Imports entitlement definitions (group names, role names). Creates/updates rows in `spt_managed_attribute` (the entitlement catalog).

When account aggregation runs:
1. IIQ connects to the application via its connector
2. Pulls all accounts → creates/updates rows in `spt_link`
3. For each account, reads entitlement attributes (e.g., AD group memberships) → updates `spt_identity_entitlement` per identity
4. Entitlements confirmed present are marked `aggregation_state = 'Connected'`
5. Entitlements previously seen but now absent are marked `aggregation_state = 'Disconnected'`
6. Results are logged in `spt_task_result`

**What this means for your data**: IIQ data is only as fresh as the last aggregation. The `spt_link.last_refresh` and `spt_identity.last_refresh` timestamps tell you when data was last pulled. If an aggregation hasn't run in a week, the entitlement data is a week old. The cube is a **mutable current-state store, overwritten on every aggregation** — it is neither a real-time mirror of the target systems nor a historical record of what they used to be. See [IIQ-Data-Flows.md — Aggregation Flow](IIQ-Data-Flows.md#1-aggregation-flow) for the complete step-by-step process.

### Correlation

**Correlation** is matching an account on a target application to a known identity. When IIQ aggregates an Active Directory account `jsmith`, it needs to figure out which `spt_identity` row that account belongs to.

Correlation uses rules (often matching on employee ID, email, or naming convention). When a match is found, `spt_link.identity_id` points to the correct `spt_identity` row, and the identity's `correlated` flag is set to `1`.

When **no match is found**, IIQ creates a new `spt_identity` row with `correlated = 0`. This is an **orphan account holder** — a placeholder identity that exists only because an uncorrelated account was found.

**What this means for your data**: The `correlated` flag on `spt_identity` is your most important filter. Always use `correlated = 1` to count real people. Uncorrelated identities (`correlated = 0`) inflate counts and produce misleading reports. See [IIQ.md — The correlated flag](IIQ.md#the-correlated-flag-is-your-most-important-filter).

### Entitlement

An **entitlement** is a single unit of access on an application. It could be an AD group membership, an SAP role, a database privilege, or a Unix group. It is the most granular building block of access.

Two tables work together:

- **`spt_managed_attribute`** — The entitlement **catalog**. One row per unique entitlement definition across all applications. Think of it as the "menu" of all possible access.
- **`spt_identity_entitlement`** — The entitlement **assignments**. One row per person per entitlement they hold. Think of it as "who ordered what from the menu."

These two tables connect through a **logical join** on `(application, attribute, value)`, not a foreign key. See [IIQ.md — Entitlement catalog](IIQ.md#entitlement-catalog-spt_managed_attribute).

### Role / Bundle

In IIQ, a **role** is called a **Bundle** in the database (`spt_bundle`). The name comes from the Java class `sailpoint.object.Bundle`. In the UI and documentation, you see "Role" — in the database, you see "Bundle."

Roles follow a hierarchy:

```
Business Role (type = 'business')
    └── requires → IT Role (type = 'it')
                       └── contains → Entitlement Profile (spt_profile)
                                          └── matches → Entitlements on Application
```

- **Business Role** — A logical grouping meaningful to the business (e.g., "Accounts Payable Clerk")
- **IT Role** — A technical grouping that maps to specific entitlements on specific applications (e.g., "SAP AP Access")
- **Entitlement Profile** — A filter definition that says "these entitlements on this application constitute this IT role"

The join tables `spt_bundle_requirements` (required IT roles) and `spt_bundle_permits` (optional IT roles) connect business roles to IT roles. See [IIQ.md — Roles and the bundle model](IIQ.md#roles-and-the-bundle-model).

### Role Detection vs. Role Assignment

This is one of the most confusing aspects of IIQ data. A person can have a role in two fundamentally different ways:

**Detected roles** — During Identity Refresh, IIQ looks at a person's current entitlements and checks if they match any role's entitlement profile. If they do, the role is **detected** — the person effectively *already has* the access that constitutes the role, even if nobody explicitly granted it. Detected roles are stored in `spt_identity_bundles`.

**Assigned roles** — A role explicitly granted to a person through a request, manual assignment, or lifecycle rule. Assigned roles are stored in the Identity's `attributes` XML as `RoleAssignment` objects (some versions also use `spt_identity_assigned_roles`).

A role can be **both assigned and detected** simultaneously. A role can be **assigned but not detected** (the provisioning hasn't completed yet, or entitlements changed). A role can be **detected but not assigned** (the person accumulated the right entitlements without a formal role grant).

**What this means for your data**: If you only query `spt_identity_bundles`, you see detected roles. For assigned roles, you must parse the `attributes` XML in `spt_identity` or query `spt_identity_assigned_roles` if available. See [IIQ.md — Assigned vs. detected roles](IIQ.md#assigned-roles-versus-detected-roles).

### Provisioning

**Provisioning** is the act of making changes on target systems — creating an account, adding a group membership, disabling an account. It is the "write" operation, as opposed to aggregation which is "read."

Provisioning can be:
- **Automatic** — IIQ directly changes the target system via its connector
- **Manual** — IIQ creates a work item for someone to make the change manually (when no connector supports the operation)

Provisioning history is recorded in `spt_provisioning_transaction`. Each row captures the operation, target system, identity, status (Success/Pending/Failed), and whether it was automatic or manual. See [IIQ.md — spt_provisioning_transaction](IIQ.md#spt_provisioning_transaction--provisioning-audit-trail).

### Certification / Access Review

A **certification** (also called an **access review**) is a periodic process where reviewers verify that people's access is still appropriate. Regulations like SOX require these reviews.

The process follows a strict hierarchy in the database:

1. **Definition** (`spt_certification_definition`) — The campaign template: who reviews, what scope, what schedule
2. **Group** (`spt_certification_group`) — A campaign instance (one execution of the definition)
3. **Certification** (`spt_certification`) — An individual review assignment per reviewer
4. **Entity** (`spt_certification_entity`) — Each identity being reviewed
5. **Item** (`spt_certification_item`) — Each entitlement/role under review
6. **Action** (`spt_certification_action`) — The reviewer's decision: Approved, Remediated, Mitigated, Delegated

**What this means for your data**: Certification data is deeply nested. To answer "what was decided about Jane's SAP access," you must join through the entire chain. See [IIQ.md — Certification and access review tables](IIQ.md#certification-and-access-review-tables).

### SOD and Policy Violations

**Separation of Duties (SOD)** policies define combinations of access that no single person should hold simultaneously. For example, "no one should have both Create Vendor and Approve Payment roles."

When IIQ detects a violation (usually during Identity Refresh or role assignment), it creates a row in `spt_policy_violation` with:
- The conflicting roles/entitlements (`left_bundles`, `right_bundles`)
- A `status`: **Open** (unaddressed), **Mitigated** (accepted with justification), or **Remediated** (access removed)

**Mitigation** means "we know this is a violation, but we accept it with a compensating control" — the access stays. **Remediation** means "remove the conflicting access." See [IIQ.md — Policy and SOD tables](IIQ.md#policy-and-sod-tables).

### Work Items

A **work item** is a task assigned to a person or workgroup in IIQ. The most common type is an **Approval** — when someone requests access, the approver gets a work item.

Work items are stored in `spt_work_item`. Key behaviors:
- **Open** work items have `state IS NULL` (not "Open" — null)
- **Completed** items have `state = 'Finished'`, `'Rejected'`, or `'Expired'`
- Completed items eventually move to `spt_work_item_archive`

Other work item types include Certification (review assignment), Remediation (fix a revocation), Challenge (dispute a revocation decision), and PolicyViolation (address a violation). See [IIQ.md — spt_work_item](IIQ.md#spt_work_item--approvals-and-manual-tasks).

### Lifecycle Events (Joiner / Mover / Leaver)

The **Joiner-Mover-Leaver** (JML) lifecycle is the backbone of identity management:

- **Joiner** — New identity arrives from the authoritative source. IIQ creates the `spt_identity` row, may auto-assign "birthright" roles (baseline access everyone gets), and triggers provisioning.
- **Mover** — Identity attributes change (department, title, manager). IIQ detects the change, may reassign roles based on new attributes, and provisions/deprovisions accordingly.
- **Leaver** — Identity is marked inactive in the authoritative source. IIQ sets `inactive = 1`, triggers disable/removal workflows, and may create work items for manual cleanup.

**What this means for your data**: The `inactive` flag on `spt_identity` is IIQ's leaver marker. An identity with `inactive = 1` is (or should be) in some stage of access removal. The `spt_identity` row persists — IIQ does not hard-delete leavers immediately.

---

## IIQ in the Enterprise Architecture

IIQ sits as **middleware between HR systems and target applications**:

```
┌────────────────┐        ┌──────────────────┐        ┌────────────────────┐
│  HR System     │───────→│  SailPoint IIQ   │───────→│  Target Systems    │
│  (Workday,     │  Auth  │                  │  Prov  │  (AD, SAP, DB,     │
│   SAP HCM,     │  Agg   │  Identity Cube   │  Agg   │   Unix, Cloud)     │
│   PeopleSoft)  │        │  Policy Engine   │        │                    │
└────────────────┘        │  Cert Engine     │        └────────────────────┘
                          │  Workflow Engine  │
                          └──────────────────┘
                                   ↑
                          ┌────────────────────┐
                          │  Reviewers/Admins  │
                          │  (UI, API, LCM)    │
                          └────────────────────┘
```

Key implications for analysts:

1. **IIQ is a secondary data source.** It reflects the state of other systems as of the last aggregation, not the current state. Always check `last_refresh` timestamps.
2. **IIQ does not own the data.** If an account exists in AD but IIQ hasn't aggregated it yet, it won't appear in `spt_link`. Conversely, if an account was deleted in AD but IIQ hasn't aggregated since, the `spt_link` row still exists.
3. **The authoritative source drives the identity lifecycle.** Changes in HR (new hire, termination) flow into IIQ and trigger downstream processes. IIQ doesn't decide who joins or leaves — it reacts to the HR feed.
4. **Data quality depends on connector configuration.** What IIQ sees is limited by what the connector is configured to pull. If the AD connector doesn't read the `memberOf` attribute, no AD group memberships appear in `spt_identity_entitlement`. Always check `spt_application` and `spt_schema` to understand what each connector imports.
5. **Timing matters.** Aggregation, identity refresh, role detection, and policy checks often run as separate scheduled tasks. Between these steps, data can be in a transitional state (e.g., new entitlements aggregated but roles not yet detected). See [IIQ-Data-Flows.md — Cross-Process Interactions](IIQ-Data-Flows.md#cross-process-interactions) for timing dependencies.

---

## Mental Models for Analysts

These mental models will help you avoid common pitfalls when working with IIQ data:

### "Everything is an identity"

People, service accounts, and workgroups all share the same `spt_identity` table. Always filter with:
- `correlated = 1` — Real identities (not orphan account holders)
- `is_workgroup = 0` — Actual people (not workgroups)
- Consider `inactive = 0` — Currently active (unless you want leavers)

### "The CLOB is the truth"

The relational columns in IIQ tables are a **subset** of the object's data. The `attributes` CLOB contains the complete serialized XML of the object. When you can't find a value in a flat column, it's probably in the CLOB. Role assignments, extended attributes, workflow variables, provisioning details — all live in CLOBs. See [IIQ.md — Handling XML/CLOB columns](IIQ.md#handling-xmlclob-columns).

### "Time is epoch milliseconds"

Every timestamp in IIQ is a `BIGINT` storing **milliseconds since January 1, 1970 UTC**. Not seconds — milliseconds. You must divide by 1000 for most standard conversion functions. A `NULL` timestamp usually means "hasn't happened yet" (e.g., null `end_date` = no sunset). See [IIQ.md — Timestamp conversion](IIQ.md#timestamp-conversion-is-mandatory-for-every-date-column).

### "GUIDs, not integers"

All primary keys are `VARCHAR(128)` containing GUIDs like `2c9084ee8234ab01018234b5c6700012`. They are not sequential, not sortable by creation order, and not predictable. Use `created` timestamps to determine chronological order, not ID values.

codex
The concept note has the direct distinction. I’m pulling the schema section too so the answer can distinguish the business meaning from where each one appears in IIQ data.
exec
/bin/bash -lc "sed -n '118,155p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
These two tables connect through a **logical join** on `(application, attribute, value)`, not a foreign key. See [IIQ.md — Entitlement catalog](IIQ.md#entitlement-catalog-spt_managed_attribute).

### Role / Bundle

In IIQ, a **role** is called a **Bundle** in the database (`spt_bundle`). The name comes from the Java class `sailpoint.object.Bundle`. In the UI and documentation, you see "Role" — in the database, you see "Bundle."

Roles follow a hierarchy:

```
Business Role (type = 'business')
    └── requires → IT Role (type = 'it')
                       └── contains → Entitlement Profile (spt_profile)
                                          └── matches → Entitlements on Application
```

- **Business Role** — A logical grouping meaningful to the business (e.g., "Accounts Payable Clerk")
- **IT Role** — A technical grouping that maps to specific entitlements on specific applications (e.g., "SAP AP Access")
- **Entitlement Profile** — A filter definition that says "these entitlements on this application constitute this IT role"

The join tables `spt_bundle_requirements` (required IT roles) and `spt_bundle_permits` (optional IT roles) connect business roles to IT roles. See [IIQ.md — Roles and the bundle model](IIQ.md#roles-and-the-bundle-model).

### Role Detection vs. Role Assignment

This is one of the most confusing aspects of IIQ data. A person can have a role in two fundamentally different ways:

**Detected roles** — During Identity Refresh, IIQ looks at a person's current entitlements and checks if they match any role's entitlement profile. If they do, the role is **detected** — the person effectively *already has* the access that constitutes the role, even if nobody explicitly granted it. Detected roles are stored in `spt_identity_bundles`.

**Assigned roles** — A role explicitly granted to a person through a request, manual assignment, or lifecycle rule. Assigned roles are stored in the Identity's `attributes` XML as `RoleAssignment` objects (some versions also use `spt_identity_assigned_roles`).

A role can be **both assigned and detected** simultaneously. A role can be **assigned but not detected** (the provisioning hasn't completed yet, or entitlements changed). A role can be **detected but not assigned** (the person accumulated the right entitlements without a formal role grant).

**What this means for your data**: If you only query `spt_identity_bundles`, you see detected roles. For assigned roles, you must parse the `attributes` XML in `spt_identity` or query `spt_identity_assigned_roles` if available. See [IIQ.md — Assigned vs. detected roles](IIQ.md#assigned-roles-versus-detected-roles).

### Provisioning

**Provisioning** is the act of making changes on target systems — creating an account, adding a group membership, disabling an account. It is the "write" operation, as opposed to aggregation which is "read."

Provisioning can be:

codex
In SailPoint IIQ, the difference is **how the role relationship was created**.

A **detected role** means IIQ inferred the role during Identity Refresh by comparing the identity’s current entitlements against the role’s entitlement profile. In plain terms: “this person already has the access that matches this role.” It may not have been formally granted as a role. These are stored in `spt_identity_bundles`.

An **assigned role** means the role was explicitly granted to the identity through an access request, manual assignment, or lifecycle rule. In plain terms: “IIQ intended this person to have this role.” These are typically stored in the identity `attributes` XML as `RoleAssignment` objects, and in some versions in `spt_identity_assigned_roles`.

Important cases:

- **Assigned + detected**: role was granted and the expected entitlements are present.
- **Assigned but not detected**: role was granted, but provisioning is incomplete or entitlements changed.
- **Detected but not assigned**: person has the matching entitlements, but not through a formal role assignment.

Source used: [IIQ-Concepts.md](/home/nhatquang/Knowledge/Cyber%20Security/CISSP/Domain%205%20-%20Identity%20and%20Access%20Management/SailPoint%20IIQ/IIQ-Concepts.md), via `README.md` and `knowledge-index.md`.
tokens used
26,113
In SailPoint IIQ, the difference is **how the role relationship was created**.

A **detected role** means IIQ inferred the role during Identity Refresh by comparing the identity’s current entitlements against the role’s entitlement profile. In plain terms: “this person already has the access that matches this role.” It may not have been formally granted as a role. These are stored in `spt_identity_bundles`.

An **assigned role** means the role was explicitly granted to the identity through an access request, manual assignment, or lifecycle rule. In plain terms: “IIQ intended this person to have this role.” These are typically stored in the identity `attributes` XML as `RoleAssignment` objects, and in some versions in `spt_identity_assigned_roles`.

Important cases:

- **Assigned + detected**: role was granted and the expected entitlements are present.
- **Assigned but not detected**: role was granted, but provisioning is incomplete or entitlements changed.
- **Detected but not assigned**: person has the matching entitlements, but not through a formal role assignment.

Source used: [IIQ-Concepts.md](/home/nhatquang/Knowledge/Cyber%20Security/CISSP/Domain%205%20-%20Identity%20and%20Access%20Management/SailPoint%20IIQ/IIQ-Concepts.md), via `README.md` and `knowledge-index.md`.

---

## Q06

**Question:** According to this vault, which causal inference method should be used when you have pre/post data with a control group, and what is its key assumption?

**Answer:**

Reading additional input from stdin...
OpenAI Codex v0.130.0
--------
workdir: /home/nhatquang/Knowledge
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, /home/nhatquang/.codex/memories]
reasoning effort: medium
reasoning summaries: none
session id: 019e11e0-2ffe-7bf3-b830-ce0d4ea8d552
--------
user
You are working in a personal knowledge vault. Start by reading `README.md` to orient yourself. Use `knowledge-index.md` to locate specific notes. Do not scan the entire vault — route through the index first.

According to this vault, which causal inference method should be used when you have pre/post data with a control group, and what is its key assumption?
warning: Codex's Linux sandbox uses bubblewrap and needs access to create user namespaces.
2026-05-10T12:32:47.715628Z ERROR rmcp::transport::worker: worker quit with fatal: Transport channel closed, when AuthRequired(AuthRequiredError { www_authenticate_header: "Bearer error=\"invalid_request\", error_description=\"No access token was provided in this request\", resource_metadata=\"https://api.githubcopilot.com/.well-known/oauth-protected-resource/mcp/\"" })
codex
I’ll orient through the vault entry points first, then use the index to find the relevant causal inference note rather than scanning broadly.
exec
/bin/bash -lc "sed -n '1,220p' README.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Vault

Personal knowledge base for CISSP exam preparation, enterprise IAM, data science, and machine learning. Notes are written for long-term retention — every note is independently useful weeks after it was written.

For writing standards and folder conventions, see `CLAUDE.md`.

---

## Where to Start

Route by task:

| I want to... | Start here |
|---|---|
| Study IAM / access control / identity governance | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` |
| Understand SailPoint IIQ or CyberArk | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` |
| Study causal inference methods | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` |
| Find or review a project | `Projects/Project List.md` |
| Navigate any domain | `knowledge-index.md` |
| Understand the full CISSP curriculum | `Cyber Security/CISSP/CISSP - Index.md` |

---

## Source Priority

When multiple notes cover the same topic, prefer in this order:

1. **Project notes** (`Projects/`) — current applied context
2. **Domain index / MOC notes** — authoritative navigation layer
3. **Concept notes** — detailed topic explanations
4. **`_Source/` folders** — raw imported material, not the owner's final opinion

Do not treat `_Source/` content as advice or conclusions. It is reference material only.

---

## Domain Map

| Domain | MOC / Entry Point | Status |
|---|---|---|
| Cyber Security — IAM | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` | Active |
| Cyber Security — CISSP | `Cyber Security/CISSP/CISSP - Index.md` | Active (Domain 5 only) |
| Statistics — Causal Inference | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` | Active |
| Statistics | `Statistics/Statistics.md` | Active |
| Deep Learning | `Deep Learning/Deep Learning.md` | Study notes |
| Machine Learning | `Machine Learning/Machine Learning.md` | Study notes |
| Finance | `Finance/Finance.md` | Study notes |
| Projects | `Projects/Project List.md` | Active |
| Playbooks | `Playbooks/` | Active |

---

## Rules

- Always read the domain MOC or index note before diving into deep concept notes
- `_Source/` folders contain raw imported material — do not treat as authoritative
- Notes link bidirectionally — if note A links to B, B links back to A
- A note with `status: stale` in its frontmatter may be outdated — verify before using
- Wikilinks (`[[Note Name]]`) are Obsidian-specific; resolve them as relative file paths

---

## Status Guide

| Status | Meaning |
|---|---|
| `active` | Current, maintained, reliable |
| `draft` | Work in progress, incomplete |
| `reference` | Stable reference material, not actively updated |
| `stale` | Potentially outdated — verify before using |
| `imported` | Raw source material, not processed into vault opinion |

exec
/bin/bash -lc "sed -n '1,260p' knowledge-index.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Index

Flat index of every major area in this vault. Load this file first to orient without scanning 425 files. One entry per note: path → what it covers.

---

## Cyber Security

### CISSP
- `Cyber Security/CISSP/CISSP - Index.md` — top-level map of all 8 CISSP domains; only Domain 5 has notes
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` — Domain 5 MOC and reading path

### IAM Fundamentals
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/IAM-Overview.md` — what IAM is and how the stack fits together
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-LDAP-Fundamentals.md` — Active Directory and LDAP basics; group types, memberOf, ADUC
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-Domain-Forest-Trusts.md` — domain topology, forest trusts, group scope rules
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Authentication-Factors-MFA.md` — MFA types and authentication factors
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/OAuth2-OIDC.md` — OAuth2 and OpenID Connect protocols
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Access-Control-Models.md` — DAC, MAC, RBAC, ABAC models
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Physical-vs-Logical-Access.md` — physical vs logical access controls
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Privilege-Escalation-Service-Accounts.md` — privilege escalation paths and service account risks

### SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` — business context for IIQ: identity cube, aggregation, entitlements, roles, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ.md` — complete spt_* schema reference; all tables, columns, joins
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Field-Values.md` — status codes, type enumerations, flag values for all tables
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Data-Flows.md` — step-by-step flows: aggregation, refresh, JML, requests, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md` — how IIQ connects to AD; aggregation types, delta/DirSync, connector gap
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Analyst-Playbook.md` — 60+ SQL recipes for common business questions
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/AD-Groups-in-IIQ-Governance.md` — how AD groups become governed entitlements in IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/CyberArk-IIQ-Integration.md` — three integration patterns between CyberArk PAM and SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/PrivilegedA-Account-Data-Queries.md` — MySQL queries for PRIV_*_A privileged accounts

---

## Statistics

- `Statistics/Statistics.md` — top-level MOC for all statistics topics
- `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` — method selection guide: DiD, matching, RDD, synthetic control
- `Statistics/Causal Inference/Causal Inference.md` — entry point to 25-chapter causal inference study notes
- `Statistics/AB Testing/AB Testing fundamental.md` — A/B testing fundamentals
- `Statistics/Statistical thinking.md` — statistical thinking principles
- `Statistics/Causal Inference/_Source/` — raw imported Python Causality Handbook; not authoritative

---

## Deep Learning

- `Deep Learning/Deep Learning.md` — domain MOC; all subfields and entry points
- `Deep Learning/NLP/NLP.md` — NLP entry point; most developed subfield in this vault
- `Deep Learning/NLP/LLMOps/LLMOps.md` — LLM operations and deployment
- `Deep Learning/NLP/LLMs/Building Production-Grade LLM apps.md` — production LLM application patterns
- `Deep Learning/NLP/LLMs/Multi-Agent LLMs.md` — multi-agent LLM architectures
- `Deep Learning/Foundations/Loss function.md` — loss functions overview
- `Deep Learning/Computer Vision/Generate Image.md` — image generation entry point
- `Deep Learning/XAI/Trustworthy and Explainable AI.md` — XAI and model interpretability
- `Deep Learning/GNN/Advanced GNN.md` — graph neural networks
- `Deep Learning/Open Source/HuggingFace open source.md` — HuggingFace ecosystem

---

## Machine Learning

- `Machine Learning/Machine Learning.md` — domain MOC; clustering and regression
- `Machine Learning/Clustering algorithm/Clustering Algorithm.md` — clustering methods
- `Machine Learning/Regression algorithm/Regression Algorithm.md` — regression methods

---

## Finance

- `Finance/Finance.md` — domain MOC; corporate finance and bank management
- `Finance/Corporate Finance.md` — corporate finance section index
- `Finance/Bank Management and Strategy.md` — bank management section index

---

## Projects

- `Projects/Project List.md` — project registry with status and next actions
- `Projects/Causal IAM Risk Analytics.md` — causal analysis of IAM risk (Idea/MVP)
- `Projects/Fraud Detection using ML.md` — fraud detection project (Draft)
- `Projects/Neural Style Transfer.md` — neural style transfer (Active)

---

## Playbooks

- `Playbooks/Start a New Project.md` — steps to initialize a new project in this vault
- `Playbooks/Causal Analysis Checklist.md` — method selection and data readiness for causal inference
- `Playbooks/Evaluate a Dataset.md` — dataset assessment before starting analysis

codex
The index points to the causal inference knowledge map as the method-selection layer, so I’m reading that next and only following links if the answer needs more detail.
exec
/bin/bash -lc "sed -n '1,260p' 'Statistics/Causal Inference/Causal Inference - Knowledge Map.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: ["causal-inference", "statistics", "knowledge-map", "method-selection"]
aliases: ["Causal Inference Knowledge Map", "Causal Method Map", "Causal Discovery Map"]
source: https://github.com/matheusfacure/python-causality-handbook
source_commit: 3e974d311a415d795a81b4657d524f3ccba4e9fe
---

# Causal Inference - Knowledge Map

This map connects the imported handbook chapters into a working mental model for choosing methods, checking assumptions, and discovering follow-up ideas.

## Method Selection

| Problem shape | Consider | Notes |
|---|---|---|
| Clean randomized assignment | Randomized experiments | [[02 - Randomised Experiments]] |
| Observed confounders, no hidden confounding | Regression, matching, propensity score, doubly robust estimation | [[05 - The Unreasonable Effectiveness of Linear Regression]], [[10 - Matching]], [[11 - Propensity Score]], [[12 - Doubly Robust Estimation]] |
| Hidden confounding but valid instrument | Instrumental variables / LATE | [[08 - Instrumental Variables]], [[09 - Non Compliance and LATE]] |
| Panel data with treated and control groups | Difference-in-differences / fixed effects | [[13 - Difference-in-Differences]], [[14 - Panel Data and Fixed Effects]] |
| One treated unit and weighted control pool | Synthetic control | [[15 - Synthetic Control]] |
| Treatment changes sharply at a threshold | Regression discontinuity | [[16 - Regression Discontinuity Design]] |
| Treatment effects vary across units | HTE, meta-learners, DML | [[18 - Heterogeneous Treatment Effects and Personalization]], [[21 - Meta Learners]], [[22 - Debiased Orthogonal Machine Learning]] |

## Assumption Map

| Assumption | What it protects against | Typical methods |
|---|---|---|
| Exchangeability / unconfoundedness | Treated and untreated units differ in ways that also affect the outcome | Regression, matching, propensity score, doubly robust methods |
| Overlap / positivity | Some groups have no comparable treated or untreated observations | Matching, propensity score trimming, design restriction |
| Exclusion restriction | Instrument affects outcome through channels other than treatment | Instrumental variables |
| Parallel trends | Treated and control groups would not have followed comparable paths without treatment | Difference-in-differences |
| Continuity around cutoff | Units just above and below a threshold are not comparable | Regression discontinuity |
| No interference / SUTVA | One unit's treatment changes another unit's outcome | Most potential-outcomes estimators |

## Discovery Questions

- What is the intervention, not just the prediction target?
- Which counterfactual is missing?
- What assumption identifies that counterfactual?
- Which observed pattern would falsify or weaken the assumption?
- Which method gives the clearest story to a skeptical reader?
- Where can machine learning improve nuisance estimation without replacing identification?

## Imported Chapter Links

- [[01 - Introduction To Causality]]
- [[02 - Randomised Experiments]]
- [[03 - Stats Review The Most Dangerous Equation]]
- [[04 - Graphical Causal Models]]
- [[05 - The Unreasonable Effectiveness of Linear Regression]]
- [[06 - Grouped and Dummy Regression]]
- [[07 - Beyond Confounders]]
- [[08 - Instrumental Variables]]
- [[09 - Non Compliance and LATE]]
- [[10 - Matching]]
- [[11 - Propensity Score]]
- [[12 - Doubly Robust Estimation]]
- [[13 - Difference-in-Differences]]
- [[14 - Panel Data and Fixed Effects]]
- [[15 - Synthetic Control]]
- [[16 - Regression Discontinuity Design]]
- [[17 - Predictive Models 101]]
- [[18 - Heterogeneous Treatment Effects and Personalization]]
- [[19 - Evaluating Causal Models]]
- [[20 - Plug-and-Play Estimators]]
- [[21 - Meta Learners]]
- [[22 - Debiased Orthogonal Machine Learning]]
- [[23 - Challenges with Effect Heterogeneity and Nonlinearity]]
- [[24 - The Difference-in-Differences Saga]]
- [[25 - Synthetic Difference-in-Differences]]
- [[A01 - Debiasing with Orthogonalization]]
- [[A02 - Debiasing with Propensity Score]]
- [[A03 - When Prediction Fails]]
- [[A04 - Why Prediction Metrics are Dangerous For Causal Models]]
- [[A05 - Conformal Inference for Synthetic Controls]]

## Source

- Website: https://matheusfacure.github.io/python-causality-handbook
- GitHub: https://github.com/matheusfacure/python-causality-handbook
- Imported commit: `3e974d311a415d795a81b4657d524f3ccba4e9fe`
- License: MIT License, Copyright (c) 2020 Matheus Facure.

## Related

- [[Causal Inference]] - main index for the imported handbook.
- [[Statistical thinking]] - statistical primitives used across causal inference.
- [[AB Testing fundamental]] - experimental baseline for causal identification.
- [[Machine Learning]] - predictive modeling context for heterogeneous treatment effect methods.

codex
Use **difference-in-differences**, optionally with **fixed effects**, when you have **pre/post data with treated and control groups**.

Its key assumption is **parallel trends**: without the treatment, the treated and control groups would have followed comparable outcome trends over time.
tokens used
15,438
Use **difference-in-differences**, optionally with **fixed effects**, when you have **pre/post data with treated and control groups**.

Its key assumption is **parallel trends**: without the treatment, the treated and control groups would have followed comparable outcome trends over time.

---

## Q07

**Question:** What happens in SailPoint IIQ when a user is manually removed from an AD group directly in Active Directory, bypassing IIQ's provisioning workflow?

**Answer:**

Reading additional input from stdin...
OpenAI Codex v0.130.0
--------
workdir: /home/nhatquang/Knowledge
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, /home/nhatquang/.codex/memories]
reasoning effort: medium
reasoning summaries: none
session id: 019e11e0-d9ec-7a22-8a11-fb1570fa55e9
--------
user
You are working in a personal knowledge vault. Start by reading `README.md` to orient yourself. Use `knowledge-index.md` to locate specific notes. Do not scan the entire vault — route through the index first.

What happens in SailPoint IIQ when a user is manually removed from an AD group directly in Active Directory, bypassing IIQ's provisioning workflow?
warning: Codex's Linux sandbox uses bubblewrap and needs access to create user namespaces.
2026-05-10T12:33:31.103702Z ERROR rmcp::transport::worker: worker quit with fatal: Transport channel closed, when AuthRequired(AuthRequiredError { www_authenticate_header: "Bearer error=\"invalid_request\", error_description=\"No access token was provided in this request\", resource_metadata=\"https://api.githubcopilot.com/.well-known/oauth-protected-resource/mcp/\"" })
codex
I’ll orient through the vault entry points first, then follow the index to the relevant SailPoint/IIQ notes without doing a broad scan.
exec
/bin/bash -lc "sed -n '1,220p' README.md" in /home/nhatquang/Knowledge
exec
/bin/bash -lc "sed -n '1,260p' knowledge-index.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Vault

Personal knowledge base for CISSP exam preparation, enterprise IAM, data science, and machine learning. Notes are written for long-term retention — every note is independently useful weeks after it was written.

For writing standards and folder conventions, see `CLAUDE.md`.

---

## Where to Start

Route by task:

| I want to... | Start here |
|---|---|
| Study IAM / access control / identity governance | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` |
| Understand SailPoint IIQ or CyberArk | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` |
| Study causal inference methods | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` |
| Find or review a project | `Projects/Project List.md` |
| Navigate any domain | `knowledge-index.md` |
| Understand the full CISSP curriculum | `Cyber Security/CISSP/CISSP - Index.md` |

---

## Source Priority

When multiple notes cover the same topic, prefer in this order:

1. **Project notes** (`Projects/`) — current applied context
2. **Domain index / MOC notes** — authoritative navigation layer
3. **Concept notes** — detailed topic explanations
4. **`_Source/` folders** — raw imported material, not the owner's final opinion

Do not treat `_Source/` content as advice or conclusions. It is reference material only.

---

## Domain Map

| Domain | MOC / Entry Point | Status |
|---|---|---|
| Cyber Security — IAM | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` | Active |
| Cyber Security — CISSP | `Cyber Security/CISSP/CISSP - Index.md` | Active (Domain 5 only) |
| Statistics — Causal Inference | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` | Active |
| Statistics | `Statistics/Statistics.md` | Active |
| Deep Learning | `Deep Learning/Deep Learning.md` | Study notes |
| Machine Learning | `Machine Learning/Machine Learning.md` | Study notes |
| Finance | `Finance/Finance.md` | Study notes |
| Projects | `Projects/Project List.md` | Active |
| Playbooks | `Playbooks/` | Active |

---

## Rules

- Always read the domain MOC or index note before diving into deep concept notes
- `_Source/` folders contain raw imported material — do not treat as authoritative
- Notes link bidirectionally — if note A links to B, B links back to A
- A note with `status: stale` in its frontmatter may be outdated — verify before using
- Wikilinks (`[[Note Name]]`) are Obsidian-specific; resolve them as relative file paths

---

## Status Guide

| Status | Meaning |
|---|---|
| `active` | Current, maintained, reliable |
| `draft` | Work in progress, incomplete |
| `reference` | Stable reference material, not actively updated |
| `stale` | Potentially outdated — verify before using |
| `imported` | Raw source material, not processed into vault opinion |

 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Index

Flat index of every major area in this vault. Load this file first to orient without scanning 425 files. One entry per note: path → what it covers.

---

## Cyber Security

### CISSP
- `Cyber Security/CISSP/CISSP - Index.md` — top-level map of all 8 CISSP domains; only Domain 5 has notes
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` — Domain 5 MOC and reading path

### IAM Fundamentals
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/IAM-Overview.md` — what IAM is and how the stack fits together
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-LDAP-Fundamentals.md` — Active Directory and LDAP basics; group types, memberOf, ADUC
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-Domain-Forest-Trusts.md` — domain topology, forest trusts, group scope rules
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Authentication-Factors-MFA.md` — MFA types and authentication factors
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/OAuth2-OIDC.md` — OAuth2 and OpenID Connect protocols
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Access-Control-Models.md` — DAC, MAC, RBAC, ABAC models
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Physical-vs-Logical-Access.md` — physical vs logical access controls
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Privilege-Escalation-Service-Accounts.md` — privilege escalation paths and service account risks

### SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` — business context for IIQ: identity cube, aggregation, entitlements, roles, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ.md` — complete spt_* schema reference; all tables, columns, joins
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Field-Values.md` — status codes, type enumerations, flag values for all tables
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Data-Flows.md` — step-by-step flows: aggregation, refresh, JML, requests, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md` — how IIQ connects to AD; aggregation types, delta/DirSync, connector gap
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Analyst-Playbook.md` — 60+ SQL recipes for common business questions
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/AD-Groups-in-IIQ-Governance.md` — how AD groups become governed entitlements in IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/CyberArk-IIQ-Integration.md` — three integration patterns between CyberArk PAM and SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/PrivilegedA-Account-Data-Queries.md` — MySQL queries for PRIV_*_A privileged accounts

---

## Statistics

- `Statistics/Statistics.md` — top-level MOC for all statistics topics
- `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` — method selection guide: DiD, matching, RDD, synthetic control
- `Statistics/Causal Inference/Causal Inference.md` — entry point to 25-chapter causal inference study notes
- `Statistics/AB Testing/AB Testing fundamental.md` — A/B testing fundamentals
- `Statistics/Statistical thinking.md` — statistical thinking principles
- `Statistics/Causal Inference/_Source/` — raw imported Python Causality Handbook; not authoritative

---

## Deep Learning

- `Deep Learning/Deep Learning.md` — domain MOC; all subfields and entry points
- `Deep Learning/NLP/NLP.md` — NLP entry point; most developed subfield in this vault
- `Deep Learning/NLP/LLMOps/LLMOps.md` — LLM operations and deployment
- `Deep Learning/NLP/LLMs/Building Production-Grade LLM apps.md` — production LLM application patterns
- `Deep Learning/NLP/LLMs/Multi-Agent LLMs.md` — multi-agent LLM architectures
- `Deep Learning/Foundations/Loss function.md` — loss functions overview
- `Deep Learning/Computer Vision/Generate Image.md` — image generation entry point
- `Deep Learning/XAI/Trustworthy and Explainable AI.md` — XAI and model interpretability
- `Deep Learning/GNN/Advanced GNN.md` — graph neural networks
- `Deep Learning/Open Source/HuggingFace open source.md` — HuggingFace ecosystem

---

## Machine Learning

- `Machine Learning/Machine Learning.md` — domain MOC; clustering and regression
- `Machine Learning/Clustering algorithm/Clustering Algorithm.md` — clustering methods
- `Machine Learning/Regression algorithm/Regression Algorithm.md` — regression methods

---

## Finance

- `Finance/Finance.md` — domain MOC; corporate finance and bank management
- `Finance/Corporate Finance.md` — corporate finance section index
- `Finance/Bank Management and Strategy.md` — bank management section index

---

## Projects

- `Projects/Project List.md` — project registry with status and next actions
- `Projects/Causal IAM Risk Analytics.md` — causal analysis of IAM risk (Idea/MVP)
- `Projects/Fraud Detection using ML.md` — fraud detection project (Draft)
- `Projects/Neural Style Transfer.md` — neural style transfer (Active)

---

## Playbooks

- `Playbooks/Start a New Project.md` — steps to initialize a new project in this vault
- `Playbooks/Causal Analysis Checklist.md` — method selection and data readiness for causal inference
- `Playbooks/Evaluate a Dataset.md` — dataset assessment before starting analysis

codex
The index points to the SailPoint IIQ cluster, especially `IIQ-AD-LDAP-Connector.md`, `AD-Groups-in-IIQ-Governance.md`, and the data-flow note. I’m opening those targeted notes now.
exec
/bin/bash -lc "sed -n '1,220p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: [cissp, domain-5-iam, moc, identity, access-management]
aliases: [CISSP Domain 5, IAM Domain, Identity and Access Management]
---

# CISSP Domain 5 — Identity and Access Management

Identity and Access Management (IAM) ensures the right people have the right access to the right resources at the right time. Domain 5 covers the full lifecycle: from proving identity, to granting access, to reviewing and revoking it.

---

## CISSP Domain 5 Subtopics

| Subtopic                                    | What It Covers                                                                                                   | Notes in This Vault                                                                                                                                                                       |
| ------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **5.1** Control physical and logical access | Access control models, physical access, least privilege                                                          | [[Physical-vs-Logical-Access]], [[IAM-Overview]], [[what-is-pam]], [[CyberArk-IIQ-Integration]]                                                                                           |
| **5.2** Identification & Authentication     | Groups and roles, AAA, MFA, passwordless, session management, identity proofing, credential management, SSO, JIT | [[AD-LDAP-Fundamentals]], [[AD-Application-Integration]], [[Authentication-Factors-MFA]], [[Kerberos-Protocol]], [[Privilege-Escalation-Service-Accounts]], [[AI-Agent-Identity-and-IAM]] |
| **5.3** Federated Identity                  | SAML, OAuth, OIDC, domain trusts, cross-forest                                                                   | [[AD-Domain-Forest-Trusts]], [[AD-Application-Integration]], [[SAML-Federation]], [[OAuth2-OIDC]]                                                                                         |
| **5.4** Authorization mechanisms            | RBAC, ABAC, ACLs, group-based access                                                                             | [[Access-Control-Models]], [[AD-Application-Integration]], [[AD-File-Shares-NAS-DFS]], [[AD-Groups-in-IIQ-Governance]], [[AI-Agent-Identity-and-IAM]]                                     |
| **5.5** Provisioning lifecycle              | JML (Joiner-Mover-Leaver), access requests, certifications                                                       | [[IIQ-Concepts]], [[IIQ-Data-Flows]], [[IIQ-AD-LDAP-Connector]], [[Privilege-Escalation-Service-Accounts]], [[AI-Agent-Identity-and-IAM]]                                                 |
| **5.6** Authentication systems              | SSO, Kerberos, RADIUS, TACACS+                                                                                   | [[Kerberos-Protocol]], [[SAML-Federation]], [[OAuth2-OIDC]], [[RADIUS-TACACS-Diameter]], [[AD-Application-Integration]]                                                                   |

---

## Reading Path

Start here if you're new to IAM:

```
1.  IAM-Overview                        — understand the technology stack and where each tool fits
2.  AD-LDAP-Fundamentals                — understand directories, groups, and AD itself
3.  AD-Domain-Forest-Trusts             — understand cross-domain topology (key for 5.3)
4.  AD-Application-Integration          — understand how apps consume AD (key for 5.2, 5.4, 5.6)
5.  AD-File-Shares-NAS-DFS             — file share access model: NAS, DFS, UNC, NTFS ACLs
6.  Access-Control-Models               — MAC, DAC, RBAC, ABAC, Rule-Based, Risk-Based, PDP/PEP (key for 5.4)
7.  Authentication-Factors-MFA          — identity proofing, factor types, biometrics, AAL, credential management, SSO, JIT, session management (key for 5.2)
8.  Kerberos-Protocol                   — KDC, TGT, service tickets, AES, NTP (key for 5.6)
9.  SAML-Federation                     — SAML 2.0, IDaaS, on-prem/cloud/hybrid federation (key for 5.3, 5.6)
10. OAuth2-OIDC                         — OAuth 2.0 delegation, OIDC authentication, JWT (key for 5.3, 5.6)
11. RADIUS-TACACS-Diameter              — AAA protocols, network access authentication (key for 5.6)
12. Privilege-Escalation-Service-Accounts — escalation types, service accounts, credential vaults, privilege creep (key for 5.2, 5.5)
13. IIQ-Concepts                        — understand governance tooling (key for 5.5)
14. IIQ-Data-Flows                      — understand the provisioning and certification flows
15. AD-Groups-in-IIQ-Governance         — tie everything together
16. AI-Agent-Identity-and-IAM           — emerging addendum: agents as governable IAM subjects (future-system context)
```

---

## IAM Fundamentals

Notes covering the underlying technology — no tooling yet, just the protocols and concepts.

- [[Physical-vs-Logical-Access]] — CISSP 5.1 foundations: AAA model, defense-in-depth principles, and how logical access materializes in IIQ
- [[IAM-Overview]] — the IAM stack: directory, authentication, authorization, governance, PAM layers
- [[AD-LDAP-Fundamentals]] — LDAP protocol, Active Directory, group types, key attributes, macOS/Linux integration
- [[AD-Domain-Forest-Trusts]] — domains, forests, trust types, cross-domain group scope rules, AGDLP
- [[AD-Application-Integration]] — Kerberos tokens, LDAP bind, SAML/federation, PAM/SSSD; how apps actually consume AD groups
- [[AD-File-Shares-NAS-DFS]] — NAS devices, UNC paths, DFS namespaces, NTFS vs. share permissions, AGDLP on file share ACLs
- [[Access-Control-Models]] — MAC, DAC, RBAC, Rule-Based, ABAC, Risk-Based; PDP/PEP architecture; implicit deny and constrained interfaces
- [[Authentication-Factors-MFA]] — identity registration/proofing, five factor types, MFA vs 2FA, biometrics (FAR/FRR/CER), AAL1/2/3, credential management systems, TOTP/FIDO2, SSO, JIT provisioning, session management
- [[Kerberos-Protocol]] — KDC, AS, TGS, TGT, Service Ticket, PAC; full ticket exchange flow; AES, NTP dependency, port 88
- [[SAML-Federation]] — SAML 2.0 assertion types, SP/IdP-initiated flows, metadata, IDaaS, WS-Federation, on-prem/cloud/hybrid federation
- [[OAuth2-OIDC]] — OAuth 2.0 grant types, OIDC authentication layer, JWT/ID tokens, delegated access, OAuth vs SAML
- [[RADIUS-TACACS-Diameter]] — AAA model, RADIUS (UDP 1812/1813), TACACS+ (TCP 49, full encryption), Diameter
- [[Privilege-Escalation-Service-Accounts]] — horizontal/vertical escalation, lateral movement, privilege creep, credential vaults, service account management, gMSA
- [[AI-Agent-Identity-and-IAM]] — emerging addendum: AI agents as non-human IAM subjects with delegated access, tool permissions, memory, ownership, and audit requirements

---

## SailPoint IIQ — Enterprise IAM Governance

Notes covering SailPoint IdentityIQ as a concrete implementation of IAM governance (CISSP 5.5).

### Concepts & Architecture
- [[IIQ-Concepts]] — Identity Cube, authoritative sources, roles, entitlements, JML lifecycle
- [[IIQ-Data-Flows]] — aggregation, correlation, access request, certification, and provisioning flows
- [[IIQ-Field-Values]] — enumerated values for all key status fields

### Active Directory Integration
- [[IIQ-AD-LDAP-Connector]] — connector config, aggregation mechanics, correlation rules, delta sync
- [[AD-Groups-in-IIQ-Governance]] — managed entitlements, role modelling, certifications, SQL recipes

### Schema Reference
- [[IIQ]] — complete database schema for all ~80 `spt_*` tables

### Analytics & Reporting
- [[IIQ-Analyst-Playbook]] — SQL recipes for common business questions

### Privileged Access
- [[CyberArk-IIQ-Integration]] — CyberArk PAM + SailPoint IIQ integration patterns
- [[PrivilegedA-Account-Data-Queries]] — SQL queries for privileged "A" accounts in AD

---

## CyberArk PAM — Privileged Access Management

Standalone reference for CyberArk Self-Hosted PAM, focused on data model, architecture, and dashboarding via Power BI. Treat this section as **supporting implementation context**, not the exam-core reading path. It reinforces CISSP 5.1 (control of privileged access), 5.2 (credential management systems / password vault), 5.4 (authorization for shared/admin accounts), and 5.5 (privileged account lifecycle), but many dashboard/API/reference notes are vendor-specific rather than CISSP objectives.

### Index
- [[CyberArk PAM/README|CyberArk PAM Index]] — entry point with full table of contents

### Core Concepts
- [[what-is-pam]] — Privileged Access Management fundamentals
- [[what-is-cyberark]] — CyberArk product suite overview (Self-Hosted)
- [[why-pam-matters]] — compliance and security drivers (SOX, PCI-DSS, SOC 2)

### Architecture
- [[CyberArk PAM/02-architecture/overview|CyberArk Architecture Overview]] — high-level architecture and data flows
- [[digital-vault]] — encrypted credential storage at the centre
- [[pvwa]] — web interface and REST API gateway (the dashboard integration point)
- [[cpm]] — password rotation engine
- [[psm]] — session isolation and recording
- [[pta]] — threat analytics
- [[aam-ccp]] — application credential retrieval
- [[deployment-models]] — Self-Hosted vs Privilege Cloud deployment options

### Data Model (Key Entities)
- [[safes]] — logical containers for accounts (the primary access boundary)
- [[accounts]] — privileged credentials (the central entity)
- [[platforms]] — management behaviour definitions per target type
- [[CyberArk PAM/03-key-entities/users-and-groups|CyberArk Users and Groups]] — vault users and LDAP integration
- [[policies-and-permissions]] — access control on safes
- [[CyberArk PAM/03-key-entities/sessions|CyberArk Sessions]] — privileged session objects

### Glossary & Reference
- [[CyberArk PAM/04-glossary/glossary|CyberArk Glossary]] — A–Z reference of CyberArk-specific terms
- [[common-error-codes]] — error code lookup
- [[further-reading]] — external docs and resources

### Dashboarding (Power BI)
- [[key-metrics-and-kpis]] — master metrics list
- [[password-management-dashboard]]
- [[session-monitoring-dashboard]]
- [[compliance-dashboard]]
- [[system-health-dashboard]]
- [[power-bi-integration]] — REST API authentication and query patterns

---

## Related

- [[CISSP - Index]] — all 8 CISSP domains
- [[Cyber Security]] — top-level cybersecurity note

exec
/bin/bash -lc "sed -n '1,260p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: [iiq, active-directory, ldap, aggregation, connector, correlation, provisioning, cissp, domain-5-iam, cissp/5.5-provisioning-lifecycle]
aliases: [IIQ AD Connector, SailPoint AD Integration, LDAP Aggregation]
---

# IIQ AD/LDAP Connector

[[IIQ-Concepts|SailPoint IIQ]] does not store identities in a vacuum — it reads them from source systems. For most enterprises, [[AD-LDAP-Fundamentals|Active Directory]] is the most important source. This note explains how IIQ connects to AD/LDAP, what it reads, and how that data lands in IIQ's database.

---

## What an IIQ Application Is

In IIQ, an **Application** represents a connection to a single external system — a source of accounts and entitlements. For Active Directory, one Application typically corresponds to one [[AD-Domain-Forest-Trusts|domain]] (or the Global Catalog if reading across domains).

In the database, Applications live in `spt_application`. Key columns:

| Column | What it Stores |
|---|---|
| `name` | Human-readable name, e.g. `"Active Directory - Corp"` |
| `type` | Connector type, e.g. `"Active Directory"` or `"LDAP"` |
| `authoritative` | `1` = this app is a source of truth for identity attributes |
| `features_string` | Comma-separated capabilities: `AUTHENTICATE,PROVISIONING,SYNC` |
| `attributes` | XML blob containing all connector configuration |

> [!note] Authoritative applications
> An authoritative application (usually HR or the primary AD domain) drives identity creation in IIQ. When a new account appears in an authoritative app that has no matching identity, IIQ creates a new identity record. Non-authoritative apps add accounts to existing identities but don't create new ones.


---

## Connector Configuration

The AD connector configuration is stored in `spt_application.attributes` as XML, but conceptually it includes:

| Parameter | What It Controls | Example |
|---|---|---|
| **Host** | Domain controller hostname or IP | `dc01.corp.example.com` |
| **Port** | LDAP port | `389` (plain) or `636` (LDAPS) or `3268` (GC) |
| **Bind DN** | Service account used to query AD | `CN=svc-iiq,OU=ServiceAccounts,DC=corp,...` |
| **Bind Password** | Password for the service account | (encrypted in IIQ) |
| **Base DN** | Where in the DIT to start searching | `DC=corp,DC=example,DC=com` |
| **Object Filter** | LDAP filter to select accounts | `(&(objectClass=user)(!(objectClass=computer)))` |
| **Group Object Filter** | LDAP filter to select groups | `(objectClass=group)` |

> [!tip] Global Catalog port
> Using port **3268** (or 3269 for LDAPS) points IIQ at the Global Catalog, which returns objects from all domains in the forest in a single query. Useful for multi-domain forests where you want one IIQ Application to see everyone. Trade-off: the GC only returns a subset of attributes.

### Multi-Domain Environments

For multi-domain environments, see [[AD-Domain-Forest-Trusts]] for topology rules. In IIQ:

| Topology | Recommended Configuration |
|---|---|
| Single domain | One Application, point at a domain controller |
| Multi-domain, same forest | One Application per domain **or** one Application at GC port 3268 |
| Multi-forest | One Application per forest (or per domain) |

---

## What Gets Aggregated

Aggregation runs as **two separate scans** that answer two different questions:

| Scan | Question it answers | Data perspective | Target table |
|---|---|---|---|
| **Account aggregation** | Who exists and what are they a member of? | User's perspective | `spt_link`, `spt_identity_entitlement` |
| **Group aggregation** | What groups exist and what are their properties? | Group's perspective | `spt_managed_attribute` |

You need both. Account aggregation alone gives you memberships but no metadata about the groups themselves. Group aggregation alone gives you a catalog but no idea who holds what.

> [!warning] Run order dependency
> Group aggregation should run first (or be kept current). When account aggregation processes a user's `memberOf` and tries to write an `spt_identity_entitlement` row, it looks up the corresponding `spt_managed_attribute` record. If the group hasn't been aggregated yet — no catalog row exists — the entitlement may be created as unmanaged or skipped entirely. If you see AD memberships that aren't appearing in `spt_identity_entitlement`, check whether the group exists in `spt_managed_attribute` first.

### 1. Account Aggregation (`spt_link`)

Each user account in AD becomes one row in `spt_link`. Data flows from the **user's perspective** — "here is jsmith, and here are all the groups jsmith belongs to":

| `spt_link` Column | Source in AD |
|---|---|
| `native_identity` | Usually `sAMAccountName` or `distinguishedName` |
| `display_name` | `displayName` |
| `application` | FK to `spt_application.id` |
| `identity_id` | FK to `spt_identity.id` (set after correlation) |
| `attributes` | XML blob containing all aggregated AD attributes |
| `last_refresh` | Timestamp of most recent aggregation |

The `attributes` XML blob on `spt_link` stores every AD attribute IIQ was configured to collect: `sAMAccountName`, `userPrincipalName`, `department`, `memberOf`, `userAccountControl`, etc.

> [!note] Reading spt_link attributes
> Because `attributes` is an XML blob, querying specific AD attributes requires either IIQ's built-in attribute extraction or staging tables. See `staging_tables_generic.sql` in this repo for a pattern that normalises these into queryable columns.

### 2. Group Aggregation (`spt_managed_attribute`)

Each AD security group that IIQ is configured to manage becomes a row in `spt_managed_attribute`. Data flows from the **group's perspective** — "here is Finance_VPN_Group, and here is its description and owner":

| `spt_managed_attribute` Column | Source in AD |
|---|---|
| `attribute` | Always `"memberOf"` for AD groups |
| `value` | The group DN or `sAMAccountName` (connector-dependent) |
| `display_name` | Group's `displayName` or `cn` |
| `type` | `"Entitlement"` |
| `application` | FK to `spt_application.id` |
| `descriptions` | XML blob of group descriptions |
| `requestable` | Whether users can request this group via IIQ LCM |

This table is the **entitlement catalog** — the menu of all possible access IIQ knows about. It answers questions account aggregation cannot: what does this group actually grant? who owns it? can it be requested through IIQ?

---

## Attribute Mapping: AD → IIQ

When IIQ aggregates, it maps AD attributes to IIQ's schema. This mapping is configured in the Application's **schema**:

```
AD Attribute          →  IIQ Account Attribute
─────────────────────────────────────────────────
sAMAccountName        →  name (used as native identity)
displayName           →  displayName
mail                  →  email
department            →  department
userAccountControl    →  IIQ computes "inactive" from this
memberOf              →  drives entitlement population
objectGUID            →  objectGUID (stable correlation key)
```

IIQ uses `objectGUID` as the most reliable correlation key for AD accounts because it never changes, even when accounts are renamed or moved between OUs.

---

## How Group Membership Becomes an Entitlement

This is the bridge between AD groups and IIQ's governance model:

1. IIQ aggregates a user account from AD and reads the `memberOf` attribute
2. For each group DN in `memberOf`, IIQ looks up the corresponding `spt_managed_attribute` record
3. If found, IIQ writes a row to `spt_identity_entitlement` linking the identity to that entitlement
4. The row has `aggregation_state = 'Connected'` and `source = 'Application'`

If a user is removed from a group in AD and IIQ runs aggregation again, the corresponding `spt_identity_entitlement` row gets `aggregation_state = 'Disconnected'` — it is not immediately deleted, which allows IIQ to detect and report on access that was removed outside of IIQ's governance.

See [[AD-Groups-in-IIQ-Governance]] for the full picture of how these entitlements flow into roles, certifications, and provisioning.

---

## Correlation Rules

**Correlation** is the process of matching an aggregated AD account to the correct `spt_identity` record. Without correlation, IIQ cannot associate the AD account "jsmith" with the identity "John Smith" from HR.

Correlation rules are written in BeanShell (Java-like scripting) or configured declaratively. A typical correlation rule for AD:

```java
// Match on employeeNumber: AD's employeeID = HR's employee number
String empId = account.getAttribute("employeeID");
if (empId != null) {
    return "employeeNumber == '" + empId + "'";
}
// Fallback: match on email
String email = account.getAttribute("mail");
if (email != null) {
    return "email == '" + email + "'";
}
return null; // No match found — account becomes uncorrelated
```

| Correlation Outcome | Result |
|---|---|
| Match found | `spt_link.identity_id` is set; `spt_identity.correlated = 1` |
| No match found | Account stays uncorrelated; identity cube shows it as orphan |
| Multiple matches | Ambiguous — IIQ logs an error; manual resolution needed |

> [!warning] Uncorrelated accounts
> Uncorrelated accounts are a risk: IIQ cannot govern access it cannot attribute to a person. Regular orphan account cleanup is a key IAM hygiene task. See [[AD-Groups-in-IIQ-Governance]] for the SQL to find them.

---

## Full vs. Delta Aggregation

IIQ supports two aggregation modes for AD:

### Full Aggregation
- Reads every object matching the configured filter
- Compares against what IIQ already has
- Detects additions, removals, and changes
- Slow for large directories (tens of thousands of accounts)
- Typically scheduled weekly or monthly

### Delta Aggregation (Recommended for AD)
- Uses Microsoft's **DirSync** protocol by default to detect only objects modified since the last sync
- IIQ stores a DirSync cookie per domain after each run; the next delta reads only changes since that cookie
- Fast — only processes genuinely changed objects
- Typically scheduled hourly or more frequently

> [!note] DirSync vs. uSNChanged
> The AD connector uses **DirSync** as the default delta mechanism (introduced in IIQ 6.3). DirSync requires the bind account to have **Replicating Directory Changes** permission on the domain.
>
> An older method, **uSNChanged**, tracks the highest `uSNChanged` value seen and queries for anything higher on the next run. It requires only List and Read permissions but is unreliable in multi-DC or load-balanced environments — `uSNChanged` is not replicated across domain controllers, so IIQ must always query the same DC to avoid missing changes. DirSync does not have this limitation.
>
> Source: [SailPoint — Active Directory delta aggregation: DirSync vs. uSNChanged](https://community.sailpoint.com/t5/IdentityIQ-Wiki/Active-Directory-delta-aggregation-DirSync-vs-uSNChanged/ta-p/72397)

### What Triggers Aggregation
- Scheduled tasks configured in IIQ's task scheduler
- Manual run by an IIQ administrator
- Event-based triggers (e.g., an HR event fires a lifecycle workflow, which triggers a targeted aggregation)

---

## The Connector Gap

The connector is a **scheduled reader, not a real-time listener**. It polls AD on a cadence. Everything IIQ knows about AD is only as fresh as the last aggregation timestamp on `spt_link.last_refresh`.

```
IIQ scheduler fires
        │
        ▼
Connector opens LDAP connection to AD
        │
        ▼
Reads all accounts + their memberOf attributes
        │
        ▼
Compares what it found against what IIQ already has
        │
        ▼
Updates spt_link, spt_identity_entitlement, flags needs_refresh
```

**The gap is the window between polls.** If a sysadmin manually adds Jane to `Domain Admins` in AD at 9am, and the next aggregation runs at midnight, IIQ has no visibility for 15 hours. During that window:

- Jane has the access in reality
- `spt_identity_entitlement` shows nothing
- No certification item exists for it
- No SOD check has fired
- Risk score has not updated

When aggregation finally runs, IIQ finds the new membership and writes a row with `aggregation_state = 'Connected'` and `assigned = 0` — meaning the entitlement was found on the system but was never requested through IIQ. This is the signal that access was granted outside the governed process.

### The `Disconnected` signal works in reverse

If Jane is removed from `Domain Admins` directly in AD — bypassing IIQ's provisioning — the next aggregation finds the group missing from her `memberOf`. IIQ does **not** delete the `spt_identity_entitlement` row. It sets `aggregation_state = 'Disconnected'`.

This distinction matters for auditors: the record proves that access existed and was removed, but the `Disconnected` state specifically flags that removal happened outside IIQ's workflow rather than through a governed request or certification decision.

> [!warning] Gap size is a governance risk
> A 24-hour delta aggregation schedule means changes made directly in AD are invisible to IIQ for up to a day. For high-risk groups (privileged admin groups, finance application roles), shorter aggregation intervals or event-based triggers reduce this exposure window.

---

## Useful SQL: Accounts from AD

Find all accounts aggregated from a specific AD application:

```sql
-- All accounts from "Active Directory - Corp"
SELECT
    i.display_name          AS identity_name,
    l.native_identity       AS ad_account,
    l.display_name          AS account_display_name,
    l.last_refresh          AS last_aggregated
FROM spt_link l

exec
/bin/bash -lc "sed -n '1,260p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/AD-Groups-in-IIQ-Governance.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: [iiq, active-directory, governance, roles, entitlements, certification, provisioning, sql, cissp, domain-5-iam, cissp/5.4-authorization, cissp/5.5-provisioning-lifecycle]
aliases: [AD Groups Governance, IIQ Entitlements AD, Group-based Access Governance]
---

# AD Groups in IIQ Governance

After [[IIQ-AD-LDAP-Connector|IIQ aggregates from Active Directory]], the raw account and group data is transformed into IIQ's governance model: entitlements, roles, certifications, and provisioning. This note explains that transformation end-to-end.

---

## From AD Group to Managed Entitlement

An AD security group becomes a **managed entitlement** in IIQ — a governed, catalogued access right that can be requested, reviewed, and revoked through IIQ's processes.

The journey:

```
AD Security Group (e.g. "SG-Finance-Read")
    │
    │  Aggregation reads group object
    ▼
spt_managed_attribute
    ├── attribute   = 'memberOf'
    ├── value       = 'CN=SG-Finance-Read,OU=Groups,DC=corp,...'
    ├── display_name = 'SG-Finance-Read'
    ├── type        = 'Entitlement'
    └── application → spt_application (Active Directory - Corp)
```

Not every AD group is automatically a managed entitlement. IIQ only manages groups that:
1. Match the group filter configured in the Application
2. Have been explicitly included in the entitlement catalogue (or all groups are included by default, depending on configuration)

> [!tip] Entitlement descriptions
> The `spt_managed_attribute.descriptions` column (XML blob) can store a human-readable description of what the group grants. Keeping these populated is an IAM hygiene practice — it makes certifications meaningful because reviewers know what they're approving.

---

## spt_identity_entitlement — The Entitlement Assignment Record

When IIQ determines that an identity holds an entitlement, it writes a row to `spt_identity_entitlement`. This is the central table for "who has what."

| Column | Meaning |
|---|---|
| `identity_id` | FK to `spt_identity` |
| `application` | FK to `spt_application` (which AD domain this came from) |
| `name` | Attribute name — always `'memberOf'` for AD groups |
| `value` | Group DN or name (matches `spt_managed_attribute.value`) |
| `display_name` | Human-readable group name |
| `aggregation_state` | `'Connected'` = currently a member; `'Disconnected'` = removed in AD |
| `assigned` | `1` = IIQ explicitly assigned this; `0` = detected from aggregation |
| `granted_by_role` | `1` = entitlement is held because of a role assignment |
| `source` | `'Application'` (aggregated) or `'Role'` (role-provisioned) |
| `start_date` / `end_date` | Optional validity window |

### aggregation_state Values

| Value | Meaning |
|---|---|
| `Connected` | User is currently a member of this group in AD |
| `Disconnected` | User was a member, but the group was not found in the last aggregation |

> [!warning] Disconnected ≠ deleted
> A `Disconnected` entitlement means IIQ has detected that access was removed in AD, possibly outside of IIQ's control. This is an important audit signal — it may mean someone manually removed a user from a group, bypassing the IIQ approval workflow.

---

## Role Modelling with AD Groups

IIQ's role model provides a business-friendly layer over raw AD group membership. Instead of governing hundreds of individual groups, you govern roles composed of those groups.

### The Two-Layer Role Model

```
Business Role: "Finance Analyst"         (spt_bundle, type='business')
    │  composed of
    ▼
IT Role: "SAP Finance Read Access"       (spt_bundle, type='it')
    │  requires entitlement
    ▼
AD Group: "SG-SAP-FI-READ"              (spt_managed_attribute)
    │
    ▼
Permission on SAP system
```

**IT Roles** wrap one or more entitlements (AD groups). They represent technical access.
**Business Roles** wrap one or more IT roles. They represent a job function.

This separation means:
- Business users can request "Finance Analyst" without knowing which AD groups are involved
- When an AD group changes, only the IT Role needs updating — all Business Roles that include it automatically reflect the change

### How Roles Are Stored

IT Role entitlement requirements are stored in `spt_profile` and `spt_profile_constraints`:

```sql
-- Find which AD groups are required by an IT Role
SELECT
    b.name          AS role_name,
    b.type          AS role_type,
    p.application   AS application,
    pc.elt          AS required_group_value
FROM spt_bundle b
JOIN spt_profile p            ON p.bundle_id = b.id
JOIN spt_profile_constraints pc ON pc.profile_id = p.id
WHERE b.type = 'it'
  AND b.name = 'SAP Finance Read Access';
```

### Role Detection vs. Role Assignment

| Mode | How it Works |
|---|---|
| **Role Detection** | IIQ scans entitlements and *infers* which role a person qualifies for. No explicit assignment — the role is detected from what they have. |
| **Role Assignment** | IIQ explicitly assigns a role (via access request or lifecycle rule). The role then provisions the required AD groups. |

The `spt_identity_role` table records explicit role assignments; the `granted_by_role` flag on `spt_identity_entitlement` indicates that an entitlement was provisioned as part of a role assignment.

---

## Cross-Domain Entitlements

When a user in `corp.example.com` is a member of a group owned by `emea.corp.example.com` (see [[AD-Domain-Forest-Trusts]]), IIQ records this as an entitlement on the **`emea` Application** — because the group belongs to the `emea` domain's Application.

In `spt_identity_entitlement`:
- `identity_id` → the user's identity (from any domain)
- `application` → FK to the `emea` Application in `spt_application`
- `value` → the cross-domain group's DN

> [!note] Cross-domain entitlements in certifications
> When certifying access, a manager reviewing a user from `corp` may see entitlements from the `emea` Application. This is expected and correct — it reflects that the user has access to resources in the other domain. Reviewers sometimes find this confusing without context; entitlement descriptions help here.

---

## Access Request Flow (Requesting an AD Group)

When a user requests an AD group through IIQ's Lifecycle Manager (LCM):

```
User requests "SG-Finance-Read" via IIQ portal
    │
    ▼
IIQ creates spt_identity_request (state = 'ApprovalPhase')
    │
    ▼
Approval workflow: manager or group owner approves
    │
    ▼
spt_identity_request state → 'Provision'
    │
    ▼
IIQ AD connector: modify group's 'member' attribute
    (adds user's DN to SG-Finance-Read's member list)
    │
    ▼
spt_identity_request state → 'Finished'
spt_identity_entitlement row created (assigned=1, granted_by_role=0)
    │
    ▼
Next aggregation: confirms membership, sets aggregation_state='Connected'
```

---

## Certification (Access Review)

Certifications ask: *should this person still have this access?*

For AD groups, a certification campaign (e.g., Manager Certification) shows each manager a list of their team's entitlements and asks them to **Approve** or **Revoke** each one.

| Decision | Result |
|---|---|
| **Approve** | `spt_certification_action.status = 'Approved'`; access retained |
| **Revoke** | `spt_certification_action.status = 'Remediated'`; IIQ removes user from AD group |
| **Delegate** | Forwarded to another reviewer |
| **Mitigate** | Acknowledged as exceptional; access retained with a note |

After a Revoke decision, IIQ's provisioning removes the user from the AD group's `member` attribute. The `spt_identity_entitlement` row will have `aggregation_state = 'Disconnected'` on the next aggregation cycle.

---

## Provisioning: How IIQ Modifies AD Group Membership

When IIQ needs to add or remove a user from an AD group (whether from access request, certification revocation, or lifecycle event), it:

1. Connects to AD using the Application's bind account
2. Issues an LDAP **modify** operation on the group object:
   - **Add**: `member: CN=John Smith,OU=Finance,...` (adds the DN to the `member` attribute)
   - **Remove**: deletes the user's DN from the `member` attribute
3. Records the operation in `spt_provisioning_transaction`

> [!warning] Provisioning failures
> If IIQ cannot connect to AD (network issue, bind account locked), provisioning fails. The `spt_provisioning_transaction` table records the failure. IIQ will retry based on task configuration. Monitor for stuck provisioning transactions regularly.

---

## SQL Recipes

### All identities with a specific AD group

```sql
SELECT
    i.display_name              AS identity_name,
    i.email,
    ie.value                    AS group_value,
    ie.aggregation_state,
    ie.assigned,
    ie.granted_by_role,
    ie.start_date
FROM spt_identity_entitlement ie
JOIN spt_identity i    ON i.id = ie.identity_id
JOIN spt_application a ON a.id = ie.application
WHERE a.type = 'Active Directory'
  AND ie.name = 'memberOf'
  AND ie.value LIKE '%SG-Finance-Read%'
  AND ie.aggregation_state = 'Connected'
ORDER BY i.display_name;
```

### Ungoverned AD groups (in AD but not catalogued in IIQ)

```sql
-- Groups aggregated into spt_link.attributes but not in spt_managed_attribute
-- Note: this requires staging tables to extract memberOf from the XML blob.
-- Assumes staging_link_attributes table normalises spt_link.attributes.
-- See staging_tables_generic.sql for the staging approach.

SELECT DISTINCT
    sla.attribute_value         AS group_dn,
    a.name                      AS application
FROM staging_link_attributes sla
JOIN spt_link l    ON l.id = sla.link_id
JOIN spt_application a ON a.id = l.application
WHERE sla.attribute_name = 'memberOf'
  AND NOT EXISTS (
      SELECT 1
      FROM spt_managed_attribute ma
      WHERE ma.application = l.application
        AND ma.value = sla.attribute_value
  )
ORDER BY a.name, group_dn;
```

### Cross-domain entitlement breakdown

```sql
-- Identities who have entitlements from a different domain's application
SELECT
    i.display_name              AS identity_name,
    corr_app.name               AS primary_ad_app,   -- where account lives
    ent_app.name                AS entitlement_app,  -- where the group lives
    ie.value                    AS group_value,
    ie.aggregation_state
FROM spt_identity_entitlement ie
JOIN spt_identity i     ON i.id = ie.identity_id
JOIN spt_application ent_app ON ent_app.id = ie.application
-- Find the identity's primary AD account application

exec
/bin/bash -lc "sed -n '1,260p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Data-Flows.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
# IIQ Data Flows: Process-Level Data Movement

This document describes what happens in the database when key SailPoint IIQ business processes execute. Each section follows a consistent format: business context, trigger, step-by-step data flow through tables, state transitions, an ASCII flow diagram, and indicators for analysts. For table structures, see [IIQ.md](IIQ.md). For field value meanings, see [IIQ-Field-Values.md](IIQ-Field-Values.md). For business concepts, see [IIQ-Concepts.md](IIQ-Concepts.md).

---

## 1. Aggregation Flow

### Business Context

Aggregation is IIQ's **data import** process — it pulls accounts and entitlements from connected applications into the IIQ database. This is the foundation of everything else: IIQ cannot govern access it doesn't know about.

There are two types:
- **Account aggregation** — Imports accounts and their attributes into `spt_link`
- **Entitlement/Group aggregation** — Imports the entitlement catalog (group definitions) into `spt_managed_attribute`

### Trigger

Scheduled task (`spt_task_definition` with type `AccountAggregation` or `GroupAggregation`), or manual execution from the UI.

### Step-by-Step Data Flow

```
Step 1: Task starts
   └─→ spt_task_result: new row created (completion_status = null)

Step 2: Connector pulls accounts from target application
   └─→ For each account returned:

Step 3: Account matching
   └─→ Looks for existing spt_link row matching (application + native_identity)
       ├─→ Found: UPDATE spt_link (attributes CLOB, last_refresh, extended columns)
       └─→ Not found: INSERT new spt_link row

Step 4: Identity correlation (if new account)
   └─→ Runs correlation rules to find matching spt_identity
       ├─→ Match found: Set spt_link.identity_id = matched identity
       └─→ No match: Create new spt_identity (correlated = 0)

Step 5: Entitlement processing (for each account)
   └─→ Reads entitlement attributes (e.g., memberOf, groups)
       └─→ For each entitlement value:
           ├─→ spt_managed_attribute: Create if not exists (catalog entry)
           └─→ spt_identity_entitlement:
               ├─→ EXISTS and still on account: SET aggregation_state = 'Connected'
               ├─→ EXISTS but not on account: SET aggregation_state = 'Disconnected'
               └─→ Not exists: INSERT (aggregation_state = 'Connected')

Step 6: Delta processing
   └─→ Entitlements in spt_identity_entitlement for this identity/application
       that were NOT seen during this aggregation:
       └─→ SET aggregation_state = 'Disconnected'

Step 7: Identity refresh flags
   └─→ spt_identity.needs_refresh = 1 (for affected identities)

Step 8: Task completion
   └─→ spt_task_result: UPDATE completion_status, progress stats, timestamps
```

### State Transitions

**`spt_identity_entitlement.aggregation_state`:**
```
null → Connected      (first aggregation finds this entitlement)
Connected → Connected (subsequent aggregation confirms it)
Connected → Disconnected (aggregation no longer finds it)
Disconnected → Connected (entitlement reappears in next aggregation)
```

### Flow Diagram

```
┌──────────────┐     ┌──────────────────────┐
│ Target       │────→│ IIQ Connector        │
│ Application  │     └──────────┬───────────┘
│ (AD, SAP...) │                │
└──────────────┘                ↓
                    ┌───────────────────────┐
                    │ Account Data          │
                    │ (accounts + groups)   │
                    └───────┬───────┬───────┘
                            │       │
              ┌─────────────┘       └─────────────┐
              ↓                                   ↓
    ┌──────────────────┐              ┌────────────────────────┐
    │ spt_link         │              │ spt_managed_attribute  │
    │ (account records)│              │ (entitlement catalog)  │
    └────────┬─────────┘              └────────────────────────┘
             │                                    │
             ↓                                    ↓
    ┌──────────────────────────────────────────────────────┐
    │ spt_identity_entitlement                             │
    │ (per-identity entitlement assignments)               │
    └──────────────────────────┬───────────────────────────┘
                               │
                               ↓
                    ┌──────────────────────┐
                    │ spt_identity          │
                    │ (needs_refresh = 1)   │
                    └──────────────────────┘
```

### Analyst Indicators

- **Aggregation freshness**: `SELECT app.name, MAX(l.last_refresh) FROM spt_link l JOIN spt_application app ON l.application = app.id GROUP BY app.name` — shows last aggregation per app
- **Disconnected entitlements spike**: A sudden increase in `aggregation_state = 'Disconnected'` for one app may indicate an aggregation problem, not actual access removal
- **Task result check**: Query `spt_task_result` for the aggregation task to see counts processed, errors, and warnings

---

## 2. Correlation and Identity Refresh

### Business Context

After aggregation populates `spt_link` and `spt_identity_entitlement`, **Identity Refresh** recalculates derived data for each identity: role detection, risk scores, policy violation checks, and manager mapping. This is the process that makes the Identity Cube current.

### Trigger

Identity Refresh task (`spt_task_definition`), or automatically after aggregation if configured. Also triggered when `spt_identity.needs_refresh = 1`.

### Step-by-Step Data Flow

```
Step 1: Task starts
   └─→ spt_task_result: new row

Step 2: For each identity with needs_refresh = 1 (or all if full refresh):

Step 3: Attribute promotion
   └─→ Reads spt_link rows for this identity
   └─→ Promotes authoritative source attributes to spt_identity columns
       (display_name, firstname, lastname, email, manager, type, extended*)
   └─→ spt_identity: UPDATE promoted attributes

Step 4: Manager resolution
   └─→ Resolves manager reference (looks up manager identity)
   └─→ spt_identity.manager = resolved manager's identity ID

Step 5: Role detection
   └─→ Compares identity's entitlements against all role profiles
       (spt_profile + spt_profile_constraints)
   └─→ spt_identity_bundles:
       ├─→ Entitlements match profile: INSERT or keep row (role detected)
       └─→ Entitlements no longer match: DELETE row (role no longer detected)

Step 6: Risk score calculation
   └─→ Calculates composite risk from entitlements, roles, policy violations
   └─→ spt_identity.risk_score_weight = new score
   └─→ spt_scorecard: UPDATE risk metrics

Step 7: Policy violation check
   └─→ Evaluates SOD and other policies against current access
   └─→ spt_policy_violation:
       ├─→ New violation: INSERT (status = 'Open', active = 1)
       ├─→ Existing violation still valid: No change
       └─→ Previous violation no longer applies: SET active = 0

Step 8: Identity attributes XML
   └─→ spt_identity.attributes: UPDATE XML CLOB with current state
       (role assignments, trigger snapshots, calculated attributes)

Step 9: Cleanup
   └─→ spt_identity.needs_refresh = 0
   └─→ spt_identity.last_refresh = current epoch ms

Step 10: Task completion
   └─→ spt_task_result: UPDATE completion_status
```

### State Transitions

**`spt_identity.correlated`:**
```
0 → 1  (correlation rule matches this identity to an authoritative record)
1 → 1  (subsequent refreshes confirm correlation)
```
Once correlated, an identity typically stays correlated.

**`spt_policy_violation.active`:**
```
null → 1 (new violation detected)
1 → 0    (violation no longer applies — access changed or policy changed)
0 → 1    (rare — violation reappears after remediation reversed)
```

### Flow Diagram

```
┌──────────────────┐     ┌──────────────────┐
│ spt_link          │────→│                  │
│ (account data)    │     │   Identity       │
└──────────────────┘     │   Refresh        │
                          │   Engine         │
┌───────────────────────┐ │                  │
│ spt_identity_         │→│                  │
│ entitlement           │ └────┬────┬────┬───┘
│ (current access)      │      │    │    │
└───────────────────────┘      │    │    │
                               ↓    ↓    ↓
                ┌──────────┐ ┌────┐ ┌────────────────┐
                │spt_      │ │spt_│ │spt_policy_     │
                │identity_ │ │iden│ │violation       │
                │bundles   │ │tity│ │(new violations)│
                │(detected │ │(up-│ └────────────────┘
                │ roles)   │ │date│
                └──────────┘ │d)  │
                             └────┘
```

### Analyst Indicators

- **Stale identities**: `WHERE needs_refresh = 1 AND last_refresh < (threshold)` — identities stuck waiting for refresh
- **Role detection changes**: Compare `spt_identity_bundles` counts before/after refresh to spot mass role changes
- **New policy violations**: `WHERE active = 1 AND status = 'Open' AND created > (last_refresh_time)` — violations from this cycle

---

## 3. Joiner-Mover-Leaver Lifecycle

### Business Context

The **Joiner-Mover-Leaver (JML)** lifecycle handles the three major identity transitions: new hire, internal transfer, and departure. This is typically driven by changes in the authoritative source (HR system).

### Trigger

Aggregation from the authoritative application detects a new record, attribute change, or termination flag. Lifecycle events may also be triggered by scheduled tasks or manual actions.

### Joiner Flow

```
Step 1: Authoritative aggregation detects new employee record
   └─→ No matching spt_identity found

Step 2: Identity creation
   └─→ spt_identity: INSERT new row
       (correlated = 1, inactive = 0, attributes from HR feed)

Step 3: spt_link creation
   └─→ spt_link: INSERT row for authoritative application
       (identity_id = new identity, application = authoritative app)

Step 4: Birthright role assignment (if configured)
   └─→ Lifecycle rule evaluates identity attributes (department, type, location)
   └─→ spt_identity.attributes XML: Role assignments added
   └─→ spt_identity_request: INSERT (type = 'AccessRequest', source = joiner rule)

Step 5: Provisioning
   └─→ spt_identity_request.state: Init → Approve → Provision → Complete
   └─→ spt_provisioning_transaction: INSERT per provisioned item
       (operation = 'Create' for accounts, 'Modify' for entitlements)

Step 6: Account creation on target systems
   └─→ spt_link: INSERT new rows for each provisioned application
   └─→ spt_identity_entitlement: INSERT rows for provisioned entitlements
       (assigned = 1, granted_by_role = 1, source = 'Rule' or 'Workflow')
```

### Mover Flow


codex
I found the direct answer in the connector note: IIQ treats direct AD removals as something detected at the next aggregation, not as an immediate provisioning event. I’m grabbing line references so the answer is traceable.
codex
The parallel line-number read hit a sandbox issue, so I’m retrying the same targeted reads one at a time.
codex
When a user is manually removed from an AD group directly in Active Directory, IIQ does **not** know immediately. The AD connector is a scheduled reader, so IIQ only detects the change on the next account aggregation.

At that next aggregation, IIQ reads the user’s current `memberOf` values from AD. If the group is missing, IIQ does **not** immediately delete the entitlement record. It updates the existing `spt_identity_entitlement` row to:

```text
aggregation_state = 'Disconnected'
```

That means:

- The user no longer has the group membership in AD.
- IIQ keeps historical evidence that the entitlement previously existed.
- The removal is visible as an out-of-band change, because it bypassed IIQ provisioning, approval, certification remediation, or LCM workflow.
- Auditors can distinguish “access removed outside IIQ” from a normal IIQ-controlled revoke.

The key governance point: AD is the enforcement point, so the access is actually gone once removed in AD. IIQ is the governance record, so it catches up later through aggregation and marks the entitlement `Disconnected`.

Sources used: `IIQ-AD-LDAP-Connector.md`, `AD-Groups-in-IIQ-Governance.md`, and `IIQ-Data-Flows.md`.
tokens used
28,470
When a user is manually removed from an AD group directly in Active Directory, IIQ does **not** know immediately. The AD connector is a scheduled reader, so IIQ only detects the change on the next account aggregation.

At that next aggregation, IIQ reads the user’s current `memberOf` values from AD. If the group is missing, IIQ does **not** immediately delete the entitlement record. It updates the existing `spt_identity_entitlement` row to:

```text
aggregation_state = 'Disconnected'
```

That means:

- The user no longer has the group membership in AD.
- IIQ keeps historical evidence that the entitlement previously existed.
- The removal is visible as an out-of-band change, because it bypassed IIQ provisioning, approval, certification remediation, or LCM workflow.
- Auditors can distinguish “access removed outside IIQ” from a normal IIQ-controlled revoke.

The key governance point: AD is the enforcement point, so the access is actually gone once removed in AD. IIQ is the governance record, so it catches up later through aggregation and marks the entitlement `Disconnected`.

Sources used: `IIQ-AD-LDAP-Connector.md`, `AD-Groups-in-IIQ-Governance.md`, and `IIQ-Data-Flows.md`.

---

## Q08

**Question:** A new data analyst joins the team and needs to query SailPoint IIQ for a report on who has Domain Admins group membership and when they got it. What is the recommended starting point in this vault, and what SQL concept should they use?

**Answer:**

Reading additional input from stdin...
OpenAI Codex v0.130.0
--------
workdir: /home/nhatquang/Knowledge
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, /home/nhatquang/.codex/memories]
reasoning effort: medium
reasoning summaries: none
session id: 019e11e1-f4f1-70d0-a9ee-8168dd1979ec
--------
user
You are working in a personal knowledge vault. Start by reading `README.md` to orient yourself. Use `knowledge-index.md` to locate specific notes. Do not scan the entire vault — route through the index first.

A new data analyst joins the team and needs to query SailPoint IIQ for a report on who has Domain Admins group membership and when they got it. What is the recommended starting point in this vault, and what SQL concept should they use?
warning: Codex's Linux sandbox uses bubblewrap and needs access to create user namespaces.
2026-05-10T12:34:43.595763Z ERROR rmcp::transport::worker: worker quit with fatal: Transport channel closed, when AuthRequired(AuthRequiredError { www_authenticate_header: "Bearer error=\"invalid_request\", error_description=\"No access token was provided in this request\", resource_metadata=\"https://api.githubcopilot.com/.well-known/oauth-protected-resource/mcp/\"" })
codex
I’ll orient through the vault entry points first, then follow the index to the relevant SailPoint note instead of scanning broadly.
exec
/bin/bash -lc "sed -n '1,220p' README.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Vault

Personal knowledge base for CISSP exam preparation, enterprise IAM, data science, and machine learning. Notes are written for long-term retention — every note is independently useful weeks after it was written.

For writing standards and folder conventions, see `CLAUDE.md`.

---

## Where to Start

Route by task:

| I want to... | Start here |
|---|---|
| Study IAM / access control / identity governance | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` |
| Understand SailPoint IIQ or CyberArk | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` |
| Study causal inference methods | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` |
| Find or review a project | `Projects/Project List.md` |
| Navigate any domain | `knowledge-index.md` |
| Understand the full CISSP curriculum | `Cyber Security/CISSP/CISSP - Index.md` |

---

## Source Priority

When multiple notes cover the same topic, prefer in this order:

1. **Project notes** (`Projects/`) — current applied context
2. **Domain index / MOC notes** — authoritative navigation layer
3. **Concept notes** — detailed topic explanations
4. **`_Source/` folders** — raw imported material, not the owner's final opinion

Do not treat `_Source/` content as advice or conclusions. It is reference material only.

---

## Domain Map

| Domain | MOC / Entry Point | Status |
|---|---|---|
| Cyber Security — IAM | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` | Active |
| Cyber Security — CISSP | `Cyber Security/CISSP/CISSP - Index.md` | Active (Domain 5 only) |
| Statistics — Causal Inference | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` | Active |
| Statistics | `Statistics/Statistics.md` | Active |
| Deep Learning | `Deep Learning/Deep Learning.md` | Study notes |
| Machine Learning | `Machine Learning/Machine Learning.md` | Study notes |
| Finance | `Finance/Finance.md` | Study notes |
| Projects | `Projects/Project List.md` | Active |
| Playbooks | `Playbooks/` | Active |

---

## Rules

- Always read the domain MOC or index note before diving into deep concept notes
- `_Source/` folders contain raw imported material — do not treat as authoritative
- Notes link bidirectionally — if note A links to B, B links back to A
- A note with `status: stale` in its frontmatter may be outdated — verify before using
- Wikilinks (`[[Note Name]]`) are Obsidian-specific; resolve them as relative file paths

---

## Status Guide

| Status | Meaning |
|---|---|
| `active` | Current, maintained, reliable |
| `draft` | Work in progress, incomplete |
| `reference` | Stable reference material, not actively updated |
| `stale` | Potentially outdated — verify before using |
| `imported` | Raw source material, not processed into vault opinion |

exec
/bin/bash -lc "sed -n '1,260p' knowledge-index.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Index

Flat index of every major area in this vault. Load this file first to orient without scanning 425 files. One entry per note: path → what it covers.

---

## Cyber Security

### CISSP
- `Cyber Security/CISSP/CISSP - Index.md` — top-level map of all 8 CISSP domains; only Domain 5 has notes
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` — Domain 5 MOC and reading path

### IAM Fundamentals
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/IAM-Overview.md` — what IAM is and how the stack fits together
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-LDAP-Fundamentals.md` — Active Directory and LDAP basics; group types, memberOf, ADUC
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-Domain-Forest-Trusts.md` — domain topology, forest trusts, group scope rules
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Authentication-Factors-MFA.md` — MFA types and authentication factors
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/OAuth2-OIDC.md` — OAuth2 and OpenID Connect protocols
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Access-Control-Models.md` — DAC, MAC, RBAC, ABAC models
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Physical-vs-Logical-Access.md` — physical vs logical access controls
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Privilege-Escalation-Service-Accounts.md` — privilege escalation paths and service account risks

### SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` — business context for IIQ: identity cube, aggregation, entitlements, roles, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ.md` — complete spt_* schema reference; all tables, columns, joins
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Field-Values.md` — status codes, type enumerations, flag values for all tables
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Data-Flows.md` — step-by-step flows: aggregation, refresh, JML, requests, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md` — how IIQ connects to AD; aggregation types, delta/DirSync, connector gap
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Analyst-Playbook.md` — 60+ SQL recipes for common business questions
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/AD-Groups-in-IIQ-Governance.md` — how AD groups become governed entitlements in IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/CyberArk-IIQ-Integration.md` — three integration patterns between CyberArk PAM and SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/PrivilegedA-Account-Data-Queries.md` — MySQL queries for PRIV_*_A privileged accounts

---

## Statistics

- `Statistics/Statistics.md` — top-level MOC for all statistics topics
- `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` — method selection guide: DiD, matching, RDD, synthetic control
- `Statistics/Causal Inference/Causal Inference.md` — entry point to 25-chapter causal inference study notes
- `Statistics/AB Testing/AB Testing fundamental.md` — A/B testing fundamentals
- `Statistics/Statistical thinking.md` — statistical thinking principles
- `Statistics/Causal Inference/_Source/` — raw imported Python Causality Handbook; not authoritative

---

## Deep Learning

- `Deep Learning/Deep Learning.md` — domain MOC; all subfields and entry points
- `Deep Learning/NLP/NLP.md` — NLP entry point; most developed subfield in this vault
- `Deep Learning/NLP/LLMOps/LLMOps.md` — LLM operations and deployment
- `Deep Learning/NLP/LLMs/Building Production-Grade LLM apps.md` — production LLM application patterns
- `Deep Learning/NLP/LLMs/Multi-Agent LLMs.md` — multi-agent LLM architectures
- `Deep Learning/Foundations/Loss function.md` — loss functions overview
- `Deep Learning/Computer Vision/Generate Image.md` — image generation entry point
- `Deep Learning/XAI/Trustworthy and Explainable AI.md` — XAI and model interpretability
- `Deep Learning/GNN/Advanced GNN.md` — graph neural networks
- `Deep Learning/Open Source/HuggingFace open source.md` — HuggingFace ecosystem

---

## Machine Learning

- `Machine Learning/Machine Learning.md` — domain MOC; clustering and regression
- `Machine Learning/Clustering algorithm/Clustering Algorithm.md` — clustering methods
- `Machine Learning/Regression algorithm/Regression Algorithm.md` — regression methods

---

## Finance

- `Finance/Finance.md` — domain MOC; corporate finance and bank management
- `Finance/Corporate Finance.md` — corporate finance section index
- `Finance/Bank Management and Strategy.md` — bank management section index

---

## Projects

- `Projects/Project List.md` — project registry with status and next actions
- `Projects/Causal IAM Risk Analytics.md` — causal analysis of IAM risk (Idea/MVP)
- `Projects/Fraud Detection using ML.md` — fraud detection project (Draft)
- `Projects/Neural Style Transfer.md` — neural style transfer (Active)

---

## Playbooks

- `Playbooks/Start a New Project.md` — steps to initialize a new project in this vault
- `Playbooks/Causal Analysis Checklist.md` — method selection and data readiness for causal inference
- `Playbooks/Evaluate a Dataset.md` — dataset assessment before starting analysis

codex
The index points this to the SailPoint IIQ area, especially the analyst playbook for SQL recipes. I’m checking the IAM map first because the vault rules make that the navigation layer before deep notes.
exec
/bin/bash -lc "sed -n '1,260p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: [cissp, domain-5-iam, moc, identity, access-management]
aliases: [CISSP Domain 5, IAM Domain, Identity and Access Management]
---

# CISSP Domain 5 — Identity and Access Management

Identity and Access Management (IAM) ensures the right people have the right access to the right resources at the right time. Domain 5 covers the full lifecycle: from proving identity, to granting access, to reviewing and revoking it.

---

## CISSP Domain 5 Subtopics

| Subtopic                                    | What It Covers                                                                                                   | Notes in This Vault                                                                                                                                                                       |
| ------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **5.1** Control physical and logical access | Access control models, physical access, least privilege                                                          | [[Physical-vs-Logical-Access]], [[IAM-Overview]], [[what-is-pam]], [[CyberArk-IIQ-Integration]]                                                                                           |
| **5.2** Identification & Authentication     | Groups and roles, AAA, MFA, passwordless, session management, identity proofing, credential management, SSO, JIT | [[AD-LDAP-Fundamentals]], [[AD-Application-Integration]], [[Authentication-Factors-MFA]], [[Kerberos-Protocol]], [[Privilege-Escalation-Service-Accounts]], [[AI-Agent-Identity-and-IAM]] |
| **5.3** Federated Identity                  | SAML, OAuth, OIDC, domain trusts, cross-forest                                                                   | [[AD-Domain-Forest-Trusts]], [[AD-Application-Integration]], [[SAML-Federation]], [[OAuth2-OIDC]]                                                                                         |
| **5.4** Authorization mechanisms            | RBAC, ABAC, ACLs, group-based access                                                                             | [[Access-Control-Models]], [[AD-Application-Integration]], [[AD-File-Shares-NAS-DFS]], [[AD-Groups-in-IIQ-Governance]], [[AI-Agent-Identity-and-IAM]]                                     |
| **5.5** Provisioning lifecycle              | JML (Joiner-Mover-Leaver), access requests, certifications                                                       | [[IIQ-Concepts]], [[IIQ-Data-Flows]], [[IIQ-AD-LDAP-Connector]], [[Privilege-Escalation-Service-Accounts]], [[AI-Agent-Identity-and-IAM]]                                                 |
| **5.6** Authentication systems              | SSO, Kerberos, RADIUS, TACACS+                                                                                   | [[Kerberos-Protocol]], [[SAML-Federation]], [[OAuth2-OIDC]], [[RADIUS-TACACS-Diameter]], [[AD-Application-Integration]]                                                                   |

---

## Reading Path

Start here if you're new to IAM:

```
1.  IAM-Overview                        — understand the technology stack and where each tool fits
2.  AD-LDAP-Fundamentals                — understand directories, groups, and AD itself
3.  AD-Domain-Forest-Trusts             — understand cross-domain topology (key for 5.3)
4.  AD-Application-Integration          — understand how apps consume AD (key for 5.2, 5.4, 5.6)
5.  AD-File-Shares-NAS-DFS             — file share access model: NAS, DFS, UNC, NTFS ACLs
6.  Access-Control-Models               — MAC, DAC, RBAC, ABAC, Rule-Based, Risk-Based, PDP/PEP (key for 5.4)
7.  Authentication-Factors-MFA          — identity proofing, factor types, biometrics, AAL, credential management, SSO, JIT, session management (key for 5.2)
8.  Kerberos-Protocol                   — KDC, TGT, service tickets, AES, NTP (key for 5.6)
9.  SAML-Federation                     — SAML 2.0, IDaaS, on-prem/cloud/hybrid federation (key for 5.3, 5.6)
10. OAuth2-OIDC                         — OAuth 2.0 delegation, OIDC authentication, JWT (key for 5.3, 5.6)
11. RADIUS-TACACS-Diameter              — AAA protocols, network access authentication (key for 5.6)
12. Privilege-Escalation-Service-Accounts — escalation types, service accounts, credential vaults, privilege creep (key for 5.2, 5.5)
13. IIQ-Concepts                        — understand governance tooling (key for 5.5)
14. IIQ-Data-Flows                      — understand the provisioning and certification flows
15. AD-Groups-in-IIQ-Governance         — tie everything together
16. AI-Agent-Identity-and-IAM           — emerging addendum: agents as governable IAM subjects (future-system context)
```

---

## IAM Fundamentals

Notes covering the underlying technology — no tooling yet, just the protocols and concepts.

- [[Physical-vs-Logical-Access]] — CISSP 5.1 foundations: AAA model, defense-in-depth principles, and how logical access materializes in IIQ
- [[IAM-Overview]] — the IAM stack: directory, authentication, authorization, governance, PAM layers
- [[AD-LDAP-Fundamentals]] — LDAP protocol, Active Directory, group types, key attributes, macOS/Linux integration
- [[AD-Domain-Forest-Trusts]] — domains, forests, trust types, cross-domain group scope rules, AGDLP
- [[AD-Application-Integration]] — Kerberos tokens, LDAP bind, SAML/federation, PAM/SSSD; how apps actually consume AD groups
- [[AD-File-Shares-NAS-DFS]] — NAS devices, UNC paths, DFS namespaces, NTFS vs. share permissions, AGDLP on file share ACLs
- [[Access-Control-Models]] — MAC, DAC, RBAC, Rule-Based, ABAC, Risk-Based; PDP/PEP architecture; implicit deny and constrained interfaces
- [[Authentication-Factors-MFA]] — identity registration/proofing, five factor types, MFA vs 2FA, biometrics (FAR/FRR/CER), AAL1/2/3, credential management systems, TOTP/FIDO2, SSO, JIT provisioning, session management
- [[Kerberos-Protocol]] — KDC, AS, TGS, TGT, Service Ticket, PAC; full ticket exchange flow; AES, NTP dependency, port 88
- [[SAML-Federation]] — SAML 2.0 assertion types, SP/IdP-initiated flows, metadata, IDaaS, WS-Federation, on-prem/cloud/hybrid federation
- [[OAuth2-OIDC]] — OAuth 2.0 grant types, OIDC authentication layer, JWT/ID tokens, delegated access, OAuth vs SAML
- [[RADIUS-TACACS-Diameter]] — AAA model, RADIUS (UDP 1812/1813), TACACS+ (TCP 49, full encryption), Diameter
- [[Privilege-Escalation-Service-Accounts]] — horizontal/vertical escalation, lateral movement, privilege creep, credential vaults, service account management, gMSA
- [[AI-Agent-Identity-and-IAM]] — emerging addendum: AI agents as non-human IAM subjects with delegated access, tool permissions, memory, ownership, and audit requirements

---

## SailPoint IIQ — Enterprise IAM Governance

Notes covering SailPoint IdentityIQ as a concrete implementation of IAM governance (CISSP 5.5).

### Concepts & Architecture
- [[IIQ-Concepts]] — Identity Cube, authoritative sources, roles, entitlements, JML lifecycle
- [[IIQ-Data-Flows]] — aggregation, correlation, access request, certification, and provisioning flows
- [[IIQ-Field-Values]] — enumerated values for all key status fields

### Active Directory Integration
- [[IIQ-AD-LDAP-Connector]] — connector config, aggregation mechanics, correlation rules, delta sync
- [[AD-Groups-in-IIQ-Governance]] — managed entitlements, role modelling, certifications, SQL recipes

### Schema Reference
- [[IIQ]] — complete database schema for all ~80 `spt_*` tables

### Analytics & Reporting
- [[IIQ-Analyst-Playbook]] — SQL recipes for common business questions

### Privileged Access
- [[CyberArk-IIQ-Integration]] — CyberArk PAM + SailPoint IIQ integration patterns
- [[PrivilegedA-Account-Data-Queries]] — SQL queries for privileged "A" accounts in AD

---

## CyberArk PAM — Privileged Access Management

Standalone reference for CyberArk Self-Hosted PAM, focused on data model, architecture, and dashboarding via Power BI. Treat this section as **supporting implementation context**, not the exam-core reading path. It reinforces CISSP 5.1 (control of privileged access), 5.2 (credential management systems / password vault), 5.4 (authorization for shared/admin accounts), and 5.5 (privileged account lifecycle), but many dashboard/API/reference notes are vendor-specific rather than CISSP objectives.

### Index
- [[CyberArk PAM/README|CyberArk PAM Index]] — entry point with full table of contents

### Core Concepts
- [[what-is-pam]] — Privileged Access Management fundamentals
- [[what-is-cyberark]] — CyberArk product suite overview (Self-Hosted)
- [[why-pam-matters]] — compliance and security drivers (SOX, PCI-DSS, SOC 2)

### Architecture
- [[CyberArk PAM/02-architecture/overview|CyberArk Architecture Overview]] — high-level architecture and data flows
- [[digital-vault]] — encrypted credential storage at the centre
- [[pvwa]] — web interface and REST API gateway (the dashboard integration point)
- [[cpm]] — password rotation engine
- [[psm]] — session isolation and recording
- [[pta]] — threat analytics
- [[aam-ccp]] — application credential retrieval
- [[deployment-models]] — Self-Hosted vs Privilege Cloud deployment options

### Data Model (Key Entities)
- [[safes]] — logical containers for accounts (the primary access boundary)
- [[accounts]] — privileged credentials (the central entity)
- [[platforms]] — management behaviour definitions per target type
- [[CyberArk PAM/03-key-entities/users-and-groups|CyberArk Users and Groups]] — vault users and LDAP integration
- [[policies-and-permissions]] — access control on safes
- [[CyberArk PAM/03-key-entities/sessions|CyberArk Sessions]] — privileged session objects

### Glossary & Reference
- [[CyberArk PAM/04-glossary/glossary|CyberArk Glossary]] — A–Z reference of CyberArk-specific terms
- [[common-error-codes]] — error code lookup
- [[further-reading]] — external docs and resources

### Dashboarding (Power BI)
- [[key-metrics-and-kpis]] — master metrics list
- [[password-management-dashboard]]
- [[session-monitoring-dashboard]]
- [[compliance-dashboard]]
- [[system-health-dashboard]]
- [[power-bi-integration]] — REST API authentication and query patterns

---

## Related

- [[CISSP - Index]] — all 8 CISSP domains
- [[Cyber Security]] — top-level cybersecurity note

codex
The IAM map confirms `IIQ-Analyst-Playbook.md` is the reporting entry point, with AD group governance as supporting context. I’m narrowing inside those indexed SailPoint notes for the exact recipe and terminology.
exec
/bin/bash -lc "sed -n '1,260p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Analyst-Playbook.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
# IIQ Analyst Playbook: Business Questions → SQL Answers

This document maps common business questions to SQL queries against the IIQ database. Each recipe includes the question, business context, SQL, how to read the results, and variations. All queries use the join paths and patterns from [IIQ.md](IIQ.md), the field values from [IIQ-Field-Values.md](IIQ-Field-Values.md), and the process knowledge from [IIQ-Data-Flows.md](IIQ-Data-Flows.md).

**Conventions used throughout:**
- All queries filter on `correlated = 1 AND is_workgroup = 0` unless orphan accounts or workgroups are specifically needed
- Timestamps use Oracle conversion syntax — see [IIQ.md — Timestamp conversion](IIQ.md#timestamp-conversion-is-mandatory-for-every-date-column) for MySQL and SQL Server equivalents
- `/* filter */` comments mark where you should add environment-specific filters

---

## 1. Access Inventory

### Who has access to what? (Per-person access report)

**Context**: The most fundamental IAM question. Combines identity, account, and entitlement data into a single view.

```sql
SELECT
    i.name AS identity_name,
    i.display_name,
    i.extended2 AS department,
    app.name AS application,
    l.native_identity AS account_id,
    ie.name AS entitlement_attribute,
    ie.value AS entitlement_value,
    ma.display_name AS entitlement_display_name,
    CASE WHEN ie.assigned = 1 THEN 'Assigned' ELSE 'Aggregated' END AS origin,
    CASE WHEN ie.granted_by_role = 1 THEN 'Yes' ELSE 'No' END AS from_role,
    ie.aggregation_state
FROM spt_identity i
JOIN spt_identity_entitlement ie ON i.id = ie.identity_id
JOIN spt_application app ON ie.application = app.id
LEFT JOIN spt_link l ON l.identity_id = i.id AND l.application = ie.application
LEFT JOIN spt_managed_attribute ma
    ON ma.application = ie.application
    AND ma.value = ie.value
    AND ma.attribute = ie.name
WHERE i.correlated = 1 AND i.is_workgroup = 0
  /* filter: AND i.name = 'jsmith' */
ORDER BY i.name, app.name, ie.value;
```

**How to read**: Each row is one entitlement held by one person on one application. The `origin` column tells you if it was explicitly assigned or just found during aggregation. Check `aggregation_state` — `Disconnected` means the entitlement was not found on the last aggregation.

### Per-application access report

**Context**: Application owners need to know who has access to their system.

```sql
SELECT
    app.name AS application,
    i.name AS identity_name,
    i.display_name,
    i.extended2 AS department,
    l.native_identity AS account_id,
    ie.name AS entitlement_attribute,
    ie.value AS entitlement_value,
    ie.aggregation_state
FROM spt_application app
JOIN spt_identity_entitlement ie ON app.id = ie.application
JOIN spt_identity i ON ie.identity_id = i.id
LEFT JOIN spt_link l ON l.identity_id = i.id AND l.application = app.id
WHERE i.correlated = 1 AND i.is_workgroup = 0
  AND app.name = 'Active Directory' /* filter: your app name */
  AND ie.aggregation_state = 'Connected'
ORDER BY i.name, ie.value;
```

### Orphan accounts (uncorrelated)

**Context**: Accounts that IIQ could not match to a known identity. These are security risks — they may belong to former employees, shared accounts, or test accounts.

```sql
SELECT
    app.name AS application,
    l.native_identity AS account_id,
    l.display_name AS account_display_name,
    i.name AS placeholder_identity,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (l.last_refresh / 1000 / 86400) AS last_aggregated
FROM spt_link l
JOIN spt_application app ON l.application = app.id
JOIN spt_identity i ON l.identity_id = i.id
WHERE i.correlated = 0
ORDER BY app.name, l.native_identity;
```

**Variation — Count by application:**

```sql
SELECT
    app.name AS application,
    COUNT(*) AS orphan_account_count
FROM spt_link l
JOIN spt_application app ON l.application = app.id
JOIN spt_identity i ON l.identity_id = i.id
WHERE i.correlated = 0
GROUP BY app.name
ORDER BY orphan_account_count DESC;
```

### Service accounts

**Context**: Non-human accounts that need separate governance. Depending on your configuration, these may be identified by `spt_identity.type` or by naming convention.

```sql
SELECT
    i.name AS identity_name,
    i.display_name,
    i.type,
    app.name AS application,
    l.native_identity AS account_id,
    COUNT(ie.id) AS entitlement_count
FROM spt_identity i
JOIN spt_link l ON i.id = l.identity_id
JOIN spt_application app ON l.application = app.id
LEFT JOIN spt_identity_entitlement ie ON i.id = ie.identity_id AND ie.application = app.id
WHERE i.correlated = 1 AND i.is_workgroup = 0
  AND (i.type = 'Service' OR i.name LIKE 'svc_%') /* adjust to your naming convention */
GROUP BY i.name, i.display_name, i.type, app.name, l.native_identity
ORDER BY entitlement_count DESC;
```

### Identities with the most entitlements (excessive access)

**Context**: Identifies potential over-provisioned users for targeted review.

```sql
SELECT
    i.name AS identity_name,
    i.display_name,
    i.extended2 AS department,
    mgr.name AS manager,
    COUNT(ie.id) AS total_entitlements,
    COUNT(DISTINCT ie.application) AS application_count
FROM spt_identity i
JOIN spt_identity_entitlement ie ON i.id = ie.identity_id
LEFT JOIN spt_identity mgr ON i.manager = mgr.id
WHERE i.correlated = 1 AND i.is_workgroup = 0 AND i.inactive = 0
  AND ie.aggregation_state = 'Connected'
GROUP BY i.name, i.display_name, i.extended2, mgr.name
ORDER BY total_entitlements DESC
FETCH FIRST 50 ROWS ONLY; /* Oracle; use LIMIT 50 for MySQL */
```

---

## 2. Access Origin and Lineage

### How did someone get this access?

**Context**: Auditors frequently ask "why does this person have this entitlement?" Tracing the origin requires checking requests, roles, and aggregation.

```sql
SELECT
    ie.value AS entitlement_value,
    ie.name AS entitlement_attribute,
    app.name AS application,
    ie.source,
    CASE
        WHEN ie.assigned = 1 AND ie.granted_by_role = 1 THEN 'Assigned via role'
        WHEN ie.assigned = 1 AND ie.granted_by_role = 0 THEN 'Directly requested'
        WHEN ie.assigned = 0 AND ie.granted_by_role = 1 THEN 'Detected role match'
        ELSE 'Found on system (aggregated)'
    END AS access_origin,
    ie.aggregation_state,
    ir.name AS request_id,
    ir.requester_display_name,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (ir.created / 1000 / 86400) AS request_date
FROM spt_identity_entitlement ie
JOIN spt_identity i ON ie.identity_id = i.id
JOIN spt_application app ON ie.application = app.id
LEFT JOIN spt_identity_request_item iri ON ie.request_item = iri.id
LEFT JOIN spt_identity_request ir ON iri.identity_request_id = ir.id
WHERE i.name = 'jsmith' /* filter: target identity */
ORDER BY app.name, ie.value;
```

### Who approved this access?

**Context**: Traces from an entitlement back through the request to the approver.

```sql
SELECT
    ir.name AS request_id,
    ir.type AS request_type,
    ir.requester_display_name AS requester,
    ir.target_display_name AS target,
    iri.name AS attribute_name,
    iri.value AS attribute_value,
    iri.operation,
    iri.approver_name,
    iri.approval_state,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (ir.created / 1000 / 86400) AS request_date,
    ir.completion_status
FROM spt_identity_request ir
JOIN spt_identity_request_item iri ON ir.id = iri.identity_request_id
WHERE ir.target_display_name = 'Jane Smith' /* filter: target identity display name */
ORDER BY ir.created DESC;
```

### What role grants this entitlement?

**Context**: Maps from a specific entitlement back to the role(s) that include it in their profile.

```sql
SELECT
    b.name AS role_name,
    b.type AS role_type,
    b.display_name AS role_display_name,
    app.name AS application,
    pc.elt AS entitlement_filter_xml
FROM spt_bundle b
JOIN spt_profile p ON b.id = p.bundle_id
JOIN spt_application app ON p.application = app.id
JOIN spt_profile_constraints pc ON p.id = pc.profile
WHERE b.disabled = 0
  AND app.name = 'Active Directory' /* filter: your application */
  /* To find roles containing a specific entitlement, examine pc.elt XML */
ORDER BY b.type, b.name;
```

**Practical notes**: The `pc.elt` column contains XML Filter definitions that may use complex matching (equality, substring, regex). You may need to parse this CLOB to determine exact entitlement matching criteria.

---

## 3. Change Analysis

### Who joined since a given date?

```sql
SELECT
    i.name AS identity_name,
    i.display_name,
    i.extended2 AS department,
    i.type,
    mgr.name AS manager,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (i.created / 1000 / 86400) AS created_date
FROM spt_identity i
LEFT JOIN spt_identity mgr ON i.manager = mgr.id
WHERE i.correlated = 1 AND i.is_workgroup = 0
  AND i.created > (TO_DATE('2026-01-01','YYYY-MM-DD') - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
  /* adjust date above to your target date */
ORDER BY i.created DESC;
```

### Who left since a given date?

**Context**: Leavers are marked `inactive = 1`. Cross-reference with `spt_link` to check cleanup status.

```sql
SELECT
    i.name AS identity_name,
    i.display_name,
    i.extended2 AS department,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (i.modified / 1000 / 86400) AS modified_date,
    COUNT(l.id) AS remaining_accounts,
    SUM(CASE WHEN ie.aggregation_state = 'Connected' THEN 1 ELSE 0 END) AS connected_entitlements
FROM spt_identity i
LEFT JOIN spt_link l ON i.id = l.identity_id

exec
/bin/bash -lc "sed -n '260,620p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Analyst-Playbook.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
LEFT JOIN spt_link l ON i.id = l.identity_id
LEFT JOIN spt_identity_entitlement ie ON i.id = ie.identity_id
WHERE i.correlated = 1 AND i.is_workgroup = 0 AND i.inactive = 1
  AND i.modified > (TO_DATE('2026-01-01','YYYY-MM-DD') - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
GROUP BY i.name, i.display_name, i.extended2, i.modified
ORDER BY i.modified DESC;
```

**How to read**: `remaining_accounts > 0` or `connected_entitlements > 0` for leavers means cleanup is incomplete.

### Provisioning actions in a time window

```sql
SELECT
    pt.identity_name,
    pt.application_name,
    pt.native_identity,
    pt.operation,
    pt.source,
    pt.status,
    pt.type AS provisioning_type,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (pt.created / 1000 / 86400) AS action_date
FROM spt_provisioning_transaction pt
WHERE pt.created > (TO_DATE('2026-01-01','YYYY-MM-DD') - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
  AND pt.created < (TO_DATE('2026-04-01','YYYY-MM-DD') - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
  /* adjust date range above */
ORDER BY pt.created DESC;
```

**Variation — Provisioning summary by operation and status:**

```sql
SELECT
    pt.operation,
    pt.status,
    pt.source,
    COUNT(*) AS action_count
FROM spt_provisioning_transaction pt
WHERE pt.created > (TO_DATE('2026-01-01','YYYY-MM-DD') - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
GROUP BY pt.operation, pt.status, pt.source
ORDER BY action_count DESC;
```

### Point-in-time access reconstruction

**Context**: An auditor, regulator, or investigator asks "what logical access did each employee have on date `T`?" IIQ's cube tables (`spt_identity_entitlement`, `spt_link`, etc.) are **mutable current-state stores** — each aggregation overwrites the previous values, with no historical preservation. (See [IIQ-Concepts.md — Current-state, not real-time and not historical](IIQ-Concepts.md#current-state-not-real-time-and-not-historical) for why this matters.) Reconstruction is possible but the approach depends on what your deployment retains in its **archive layer** or **event layer**. Choose by decision tree:

```
Q: Does spt_identity_snapshot contain rows on or before T?
   YES  → Approach A: parse the snapshot XML        (most accurate)
   NO   → Q: Does spt_certification_archive cover T?
          YES  → Approach B: extract from cert archive (coarse but reliable, scoped)
          NO   → Q: Does spt_provisioning_transaction retention reach T?
                 YES  → Approach C: reverse-walk current state with deltas
                 NO   → Reconstruction is NOT POSSIBLE from IIQ alone.
                        Fall back to target-system audit logs.
```

#### Step 1 — Pre-flight: confirm retention covers your target date

Run **before** promising anything to the requester. If the oldest row in any source is *after* `T`, that source can't help.

```sql
/* (A) Identity snapshots — best source if enabled */
SELECT 'identity_snapshot' AS source, COUNT(*) AS row_count,
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MIN(created) / 1000 / 86400) AS oldest,
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MAX(created) / 1000 / 86400) AS newest
FROM spt_identity_snapshot
UNION ALL
SELECT 'certification_archive', COUNT(*),
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MIN(created) / 1000 / 86400),
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MAX(created) / 1000 / 86400)
FROM spt_certification_archive
UNION ALL
SELECT 'provisioning_transaction', COUNT(*),
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MIN(created) / 1000 / 86400),
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MAX(created) / 1000 / 86400)
FROM spt_provisioning_transaction
UNION ALL
SELECT 'audit_event', COUNT(*),
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MIN(created) / 1000 / 86400),
       TO_DATE('1970-01-01','YYYY-MM-DD') + (MAX(created) / 1000 / 86400)
FROM spt_audit_event;
```

#### Approach A — Identity snapshot (best case)

Use when `spt_identity_snapshot` has rows on or before `T`. For each identity, find the most recent snapshot at or before `T` and parse the embedded XML.

```sql
/* Find the closest snapshot per identity at or before the target date.
   Replace <TARGET_EPOCH_MS> with: 
     (TO_DATE('2026-01-31','YYYY-MM-DD') - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
*/
WITH closest AS (
    SELECT s.identity_id, MAX(s.created) AS snapshot_created
    FROM   spt_identity_snapshot s
    WHERE  s.created <= <TARGET_EPOCH_MS>
    GROUP  BY s.identity_id
)
SELECT
    i.name                                                                AS identity_name,
    i.display_name,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (s.created / 1000 / 86400)       AS snapshot_date,
    s.attributes                                                          AS snapshot_xml /* CLOB — parse below */
FROM spt_identity_snapshot s
JOIN closest      c ON c.identity_id = s.identity_id AND c.snapshot_created = s.created
JOIN spt_identity i ON s.identity_id = i.id
WHERE i.correlated = 1 AND i.is_workgroup = 0;
```

Then parse the snapshot XML to extract account-level entitlements. Schemas vary slightly by version — validate the path against one sample row before bulk-parsing:

```sql
/* Oracle XMLTABLE parse — adjust XPath for your snapshot schema.
   The typical structure is:
     <IdentitySnapshot>
       <links>
         <AccountSnapshot application="...">
           <attributes><Map><entry key="..."><value>...</value></entry></Map></attributes>
         </AccountSnapshot>
       </links>
     </IdentitySnapshot>
*/
SELECT
    i.name                                                                AS identity_name,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (s.created / 1000 / 86400)       AS snapshot_date,
    xt.application,
    xt.attribute_name,
    xt.attribute_value
FROM spt_identity_snapshot s
JOIN spt_identity i ON s.identity_id = i.id,
     XMLTABLE(
         '/IdentitySnapshot/links/AccountSnapshot/attributes/Map/entry'
         PASSING xmltype(s.attributes)
         COLUMNS
             application     VARCHAR2(256)  PATH 'ancestor::AccountSnapshot/@application',
             attribute_name  VARCHAR2(256)  PATH '@key',
             attribute_value VARCHAR2(2000) PATH 'value'
     ) xt
WHERE s.created BETWEEN <TARGET_EPOCH_MS> - 86400000 AND <TARGET_EPOCH_MS>
ORDER BY identity_name, application, attribute_name;
```

**Practical notes**: XML parsing across millions of CLOBs is slow — stage the result into a flat reporting table once, query that. Only group memberships and role-related attributes are usually needed; filter `attribute_name IN ('memberOf', 'groups', 'roles', ...)` to your environment's relevant entitlement attributes.

#### Approach B — Certification archive (coarse fallback)

Use when no snapshot exists but a certification campaign was archived around `T`. Each archive captures who had what *within campaign scope* at campaign start.

```sql
/* List archives near T to pick the most relevant one */
SELECT
    ca.name                                                                AS campaign_name,
    ca.parent                                                              AS definition_id,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (ca.created / 1000 / 86400)       AS archive_date,
    LENGTH(ca.contents)                                                    AS archive_xml_size
FROM spt_certification_archive ca
WHERE ca.created BETWEEN <TARGET_EPOCH_MS> - 90 * 86400000
                     AND <TARGET_EPOCH_MS> + 90 * 86400000
ORDER BY ABS(ca.created - <TARGET_EPOCH_MS>);
```

Then parse `ca.contents` (compressed XML — your DBA may need to decompress with `UTL_COMPRESS` or equivalent first):

```sql
/* Adjust XPath for your IIQ version. Items live at:
   /CertificationArchive/Certification/items/CertificationItem
   with attributes describing the entitlement under review. */
SELECT
    ca.name AS campaign_name,
    xt.reviewed_identity,
    xt.application,
    xt.attribute_name,
    xt.attribute_value,
    xt.action_status                                  /* Approved/Remediated when decided */
FROM spt_certification_archive ca,
     XMLTABLE(
         '//CertificationItem'
         PASSING xmltype(ca.contents)
         COLUMNS
             reviewed_identity VARCHAR2(256)  PATH '@parent',
             application       VARCHAR2(256)  PATH 'exceptionEntitlements/Permission/@application',
             attribute_name    VARCHAR2(256)  PATH 'exceptionEntitlements/Permission/@target',
             attribute_value   VARCHAR2(2000) PATH 'exceptionEntitlements/Permission/rights',
             action_status     VARCHAR2(64)   PATH 'action/@status'
     ) xt
WHERE ca.id = '<archive_id_from_previous_query>';
```

**How to read**: an entitlement appearing in the archive means the holder had it at campaign-creation time. **Caveat**: only entitlements *in the campaign scope* are present — out-of-scope applications are invisible.

#### Approach C — Reverse-walk current state with provisioning deltas

The most common workable approach when neither snapshot nor archive exists. Take today's state and back out every change that happened between `T` and now.

```sql
/* Step C1: Stage current state. This is your starting point. */
CREATE TABLE rpt_pit_current AS
SELECT
    i.name        AS identity_name,
    app.name      AS application_name,
    ie.name       AS attribute_name,
    ie.value      AS attribute_value,
    'CURRENT'     AS state_source
FROM spt_identity i
JOIN spt_identity_entitlement ie ON i.id = ie.identity_id
JOIN spt_application app ON ie.application = app.id
WHERE i.correlated = 1 AND i.is_workgroup = 0
  AND ie.aggregation_state = 'Connected';

/* Step C2: Stage successful provisioning deltas in (T, NOW].
   pt.attribute_request is a CLOB containing an AttributeRequest XML.
   Typical structure:
     <AttributeRequest name="memberOf" op="Add" value="CN=SAP_Approvers,..."/>
*/
CREATE TABLE rpt_pit_deltas AS
SELECT
    pt.identity_name,
    pt.application_name,
    pt.native_identity,
    pt.operation                                                           AS account_op,    /* Create/Modify/Delete */
    xt.attr_name,
    xt.attr_op                                                             AS entitlement_op, /* Add/Remove/Set */
    xt.attr_value,
    pt.status,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (pt.created / 1000 / 86400)       AS action_date
FROM spt_provisioning_transaction pt,
     XMLTABLE(
         '//AttributeRequest'
         PASSING xmltype(pt.attribute_request)
         COLUMNS
             attr_name  VARCHAR2(256)  PATH '@name',
             attr_op    VARCHAR2(32)   PATH '@op',
             attr_value VARCHAR2(2000) PATH '@value'
     ) xt
WHERE pt.status = 'Committed'
  AND pt.created > <TARGET_EPOCH_MS>
  AND pt.created <= (SYSDATE - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000;

CREATE INDEX ix_pit_deltas ON rpt_pit_deltas(identity_name, application_name, attr_name, attr_value);

/* Step C3: Reconstruct T-state. Logic:
     T_state = CURRENT
              MINUS  every (Add) between T and NOW   /* shouldn't have been there at T */
              UNION  every (Remove) between T and NOW /* should have been there at T */
*/
CREATE TABLE rpt_pit_reconstructed AS
SELECT identity_name, application_name, attribute_name AS attr_name, attribute_value AS attr_value
FROM   rpt_pit_current
MINUS
SELECT identity_name, application_name, attr_name, attr_value
FROM   rpt_pit_deltas
WHERE  entitlement_op = 'Add'
UNION
SELECT identity_name, application_name, attr_name, attr_value
FROM   rpt_pit_deltas
WHERE  entitlement_op = 'Remove';

/* Step C4: Final answer */
SELECT * FROM rpt_pit_reconstructed
WHERE identity_name = 'jsmith' /* filter as needed */
ORDER BY identity_name, application_name, attr_name;
```

**How to read**: each row in `rpt_pit_reconstructed` represents an entitlement the identity *should have held* on date `T`, based on IIQ's record of changes since then.

**Practical notes**:
- `pt.attribute_request` XML schema varies — check one row of your data and adjust the XPath in Step C2.
- For account-level events (`pt.operation IN ('Create','Delete')`), an account creation after `T` means the entire `spt_link` shouldn't have existed at `T`; an account deletion after `T` means the account's last-known entitlements should be added back. Handle these cases separately from per-attribute deltas.
- Modifications to identity attributes (department, manager) need `spt_audit_event` to reverse — provisioning transactions only cover account/entitlement deltas.
- Performance: stage everything, never join `spt_provisioning_transaction` directly to `spt_identity_entitlement` in a single query.

#### The blind spot — disclose this to the requester

> [!warning] Reconstruction is not forensic-grade
> Whichever approach you use, reconstruction has a **fundamental gap**: any change made directly on a target system (an AD admin manually adding a user to a group, an SAP basis admin granting a transaction code) **bypasses IIQ entirely**. It only surfaces when the next aggregation runs, with no event timestamp other than "discovered at aggregation time T+n." The reconstruction will be wrong for any window that contains direct-target activity.
>
> **Disclosure template for the requester:**
>
> > *"The reconstruction reflects logical access as recorded by IIQ, based on \[snapshot / certification archive / current state ± provisioning deltas]. Direct administrative changes made on the target systems outside the IIQ workflow are not captured here and may have caused brief discrepancies between actual access and recorded access during the requested window. For forensic-grade reconstruction, this output must be combined with the target systems' own audit logs (AD security events, SAP change documents, database audit trails)."*

#### Reconstruction sanity check

Always validate before delivering. Pick five identities at known life-cycle moments (a recent joiner, a recent leaver, a recent role assignment, a recent role removal, a long-tenured stable user) and inspect their reconstructed state by hand against the source events:

```sql
/* For one identity, list every event that contributed to its reconstruction */
SELECT
    'PROVISIONING' AS source,
    pt.application_name,
    pt.operation,
    pt.status,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (pt.created / 1000 / 86400) AS event_date
FROM spt_provisioning_transaction pt
WHERE pt.identity_name = 'jsmith'
  AND pt.created > <TARGET_EPOCH_MS>
UNION ALL
SELECT
    'AUDIT' AS source,
    ae.application,
    ae.action,
    ae.string1,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (ae.created / 1000 / 86400)
FROM spt_audit_event ae
WHERE ae.target = 'jsmith'
  AND ae.created > <TARGET_EPOCH_MS>
ORDER BY event_date;
```

If the reconstructed state for the test identities doesn't match what their lifecycle history suggests, your XPath is wrong, your `T` boundary is off-by-one, or a retention purge has eaten data you assumed was present.

---

### Roles created or modified recently

```sql
SELECT
    b.name AS role_name,
    b.type AS role_type,
    b.display_name,
    b.disabled,
    b.requestable,
    owner.name AS owner,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (b.created / 1000 / 86400) AS created_date,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (b.modified / 1000 / 86400) AS modified_date
FROM spt_bundle b
LEFT JOIN spt_identity owner ON b.owner = owner.id
WHERE b.modified > (TO_DATE('2026-01-01','YYYY-MM-DD') - TO_DATE('1970-01-01','YYYY-MM-DD')) * 86400 * 1000
ORDER BY b.modified DESC;
```

---

## 4. Certification Analytics

### Campaign completion rate

**Context**: How far along is each certification campaign? This is the primary tracking metric for compliance teams.

```sql
SELECT
    cd.name AS campaign_name,
    c.short_name AS cert_name,
    c.manager AS reviewer,
    c.phase,
    c.total_entities,
    c.completed_entities,
    c.percent_complete AS entity_pct,
    c.total_items,
    c.completed_items,
    c.item_percent_complete AS item_pct,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (c.activated / 1000 / 86400) AS start_date,
    TO_DATE('1970-01-01','YYYY-MM-DD') + (c.expiration / 1000 / 86400) AS due_date
FROM spt_certification c
JOIN spt_certification_definition cd ON c.certification_definition_id = cd.id
ORDER BY c.activated DESC;
```

### Completion by department (for manager certifications)


exec
/bin/bash -lc "sed -n '1,260p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/AD-Groups-in-IIQ-Governance.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: [iiq, active-directory, governance, roles, entitlements, certification, provisioning, sql, cissp, domain-5-iam, cissp/5.4-authorization, cissp/5.5-provisioning-lifecycle]
aliases: [AD Groups Governance, IIQ Entitlements AD, Group-based Access Governance]
---

# AD Groups in IIQ Governance

After [[IIQ-AD-LDAP-Connector|IIQ aggregates from Active Directory]], the raw account and group data is transformed into IIQ's governance model: entitlements, roles, certifications, and provisioning. This note explains that transformation end-to-end.

---

## From AD Group to Managed Entitlement

An AD security group becomes a **managed entitlement** in IIQ — a governed, catalogued access right that can be requested, reviewed, and revoked through IIQ's processes.

The journey:

```
AD Security Group (e.g. "SG-Finance-Read")
    │
    │  Aggregation reads group object
    ▼
spt_managed_attribute
    ├── attribute   = 'memberOf'
    ├── value       = 'CN=SG-Finance-Read,OU=Groups,DC=corp,...'
    ├── display_name = 'SG-Finance-Read'
    ├── type        = 'Entitlement'
    └── application → spt_application (Active Directory - Corp)
```

Not every AD group is automatically a managed entitlement. IIQ only manages groups that:
1. Match the group filter configured in the Application
2. Have been explicitly included in the entitlement catalogue (or all groups are included by default, depending on configuration)

> [!tip] Entitlement descriptions
> The `spt_managed_attribute.descriptions` column (XML blob) can store a human-readable description of what the group grants. Keeping these populated is an IAM hygiene practice — it makes certifications meaningful because reviewers know what they're approving.

---

## spt_identity_entitlement — The Entitlement Assignment Record

When IIQ determines that an identity holds an entitlement, it writes a row to `spt_identity_entitlement`. This is the central table for "who has what."

| Column | Meaning |
|---|---|
| `identity_id` | FK to `spt_identity` |
| `application` | FK to `spt_application` (which AD domain this came from) |
| `name` | Attribute name — always `'memberOf'` for AD groups |
| `value` | Group DN or name (matches `spt_managed_attribute.value`) |
| `display_name` | Human-readable group name |
| `aggregation_state` | `'Connected'` = currently a member; `'Disconnected'` = removed in AD |
| `assigned` | `1` = IIQ explicitly assigned this; `0` = detected from aggregation |
| `granted_by_role` | `1` = entitlement is held because of a role assignment |
| `source` | `'Application'` (aggregated) or `'Role'` (role-provisioned) |
| `start_date` / `end_date` | Optional validity window |

### aggregation_state Values

| Value | Meaning |
|---|---|
| `Connected` | User is currently a member of this group in AD |
| `Disconnected` | User was a member, but the group was not found in the last aggregation |

> [!warning] Disconnected ≠ deleted
> A `Disconnected` entitlement means IIQ has detected that access was removed in AD, possibly outside of IIQ's control. This is an important audit signal — it may mean someone manually removed a user from a group, bypassing the IIQ approval workflow.

---

## Role Modelling with AD Groups

IIQ's role model provides a business-friendly layer over raw AD group membership. Instead of governing hundreds of individual groups, you govern roles composed of those groups.

### The Two-Layer Role Model

```
Business Role: "Finance Analyst"         (spt_bundle, type='business')
    │  composed of
    ▼
IT Role: "SAP Finance Read Access"       (spt_bundle, type='it')
    │  requires entitlement
    ▼
AD Group: "SG-SAP-FI-READ"              (spt_managed_attribute)
    │
    ▼
Permission on SAP system
```

**IT Roles** wrap one or more entitlements (AD groups). They represent technical access.
**Business Roles** wrap one or more IT roles. They represent a job function.

This separation means:
- Business users can request "Finance Analyst" without knowing which AD groups are involved
- When an AD group changes, only the IT Role needs updating — all Business Roles that include it automatically reflect the change

### How Roles Are Stored

IT Role entitlement requirements are stored in `spt_profile` and `spt_profile_constraints`:

```sql
-- Find which AD groups are required by an IT Role
SELECT
    b.name          AS role_name,
    b.type          AS role_type,
    p.application   AS application,
    pc.elt          AS required_group_value
FROM spt_bundle b
JOIN spt_profile p            ON p.bundle_id = b.id
JOIN spt_profile_constraints pc ON pc.profile_id = p.id
WHERE b.type = 'it'
  AND b.name = 'SAP Finance Read Access';
```

### Role Detection vs. Role Assignment

| Mode | How it Works |
|---|---|
| **Role Detection** | IIQ scans entitlements and *infers* which role a person qualifies for. No explicit assignment — the role is detected from what they have. |
| **Role Assignment** | IIQ explicitly assigns a role (via access request or lifecycle rule). The role then provisions the required AD groups. |

The `spt_identity_role` table records explicit role assignments; the `granted_by_role` flag on `spt_identity_entitlement` indicates that an entitlement was provisioned as part of a role assignment.

---

## Cross-Domain Entitlements

When a user in `corp.example.com` is a member of a group owned by `emea.corp.example.com` (see [[AD-Domain-Forest-Trusts]]), IIQ records this as an entitlement on the **`emea` Application** — because the group belongs to the `emea` domain's Application.

In `spt_identity_entitlement`:
- `identity_id` → the user's identity (from any domain)
- `application` → FK to the `emea` Application in `spt_application`
- `value` → the cross-domain group's DN

> [!note] Cross-domain entitlements in certifications
> When certifying access, a manager reviewing a user from `corp` may see entitlements from the `emea` Application. This is expected and correct — it reflects that the user has access to resources in the other domain. Reviewers sometimes find this confusing without context; entitlement descriptions help here.

---

## Access Request Flow (Requesting an AD Group)

When a user requests an AD group through IIQ's Lifecycle Manager (LCM):

```
User requests "SG-Finance-Read" via IIQ portal
    │
    ▼
IIQ creates spt_identity_request (state = 'ApprovalPhase')
    │
    ▼
Approval workflow: manager or group owner approves
    │
    ▼
spt_identity_request state → 'Provision'
    │
    ▼
IIQ AD connector: modify group's 'member' attribute
    (adds user's DN to SG-Finance-Read's member list)
    │
    ▼
spt_identity_request state → 'Finished'
spt_identity_entitlement row created (assigned=1, granted_by_role=0)
    │
    ▼
Next aggregation: confirms membership, sets aggregation_state='Connected'
```

---

## Certification (Access Review)

Certifications ask: *should this person still have this access?*

For AD groups, a certification campaign (e.g., Manager Certification) shows each manager a list of their team's entitlements and asks them to **Approve** or **Revoke** each one.

| Decision | Result |
|---|---|
| **Approve** | `spt_certification_action.status = 'Approved'`; access retained |
| **Revoke** | `spt_certification_action.status = 'Remediated'`; IIQ removes user from AD group |
| **Delegate** | Forwarded to another reviewer |
| **Mitigate** | Acknowledged as exceptional; access retained with a note |

After a Revoke decision, IIQ's provisioning removes the user from the AD group's `member` attribute. The `spt_identity_entitlement` row will have `aggregation_state = 'Disconnected'` on the next aggregation cycle.

---

## Provisioning: How IIQ Modifies AD Group Membership

When IIQ needs to add or remove a user from an AD group (whether from access request, certification revocation, or lifecycle event), it:

1. Connects to AD using the Application's bind account
2. Issues an LDAP **modify** operation on the group object:
   - **Add**: `member: CN=John Smith,OU=Finance,...` (adds the DN to the `member` attribute)
   - **Remove**: deletes the user's DN from the `member` attribute
3. Records the operation in `spt_provisioning_transaction`

> [!warning] Provisioning failures
> If IIQ cannot connect to AD (network issue, bind account locked), provisioning fails. The `spt_provisioning_transaction` table records the failure. IIQ will retry based on task configuration. Monitor for stuck provisioning transactions regularly.

---

## SQL Recipes

### All identities with a specific AD group

```sql
SELECT
    i.display_name              AS identity_name,
    i.email,
    ie.value                    AS group_value,
    ie.aggregation_state,
    ie.assigned,
    ie.granted_by_role,
    ie.start_date
FROM spt_identity_entitlement ie
JOIN spt_identity i    ON i.id = ie.identity_id
JOIN spt_application a ON a.id = ie.application
WHERE a.type = 'Active Directory'
  AND ie.name = 'memberOf'
  AND ie.value LIKE '%SG-Finance-Read%'
  AND ie.aggregation_state = 'Connected'
ORDER BY i.display_name;
```

### Ungoverned AD groups (in AD but not catalogued in IIQ)

```sql
-- Groups aggregated into spt_link.attributes but not in spt_managed_attribute
-- Note: this requires staging tables to extract memberOf from the XML blob.
-- Assumes staging_link_attributes table normalises spt_link.attributes.
-- See staging_tables_generic.sql for the staging approach.

SELECT DISTINCT
    sla.attribute_value         AS group_dn,
    a.name                      AS application
FROM staging_link_attributes sla
JOIN spt_link l    ON l.id = sla.link_id
JOIN spt_application a ON a.id = l.application
WHERE sla.attribute_name = 'memberOf'
  AND NOT EXISTS (
      SELECT 1
      FROM spt_managed_attribute ma
      WHERE ma.application = l.application
        AND ma.value = sla.attribute_value
  )
ORDER BY a.name, group_dn;
```

### Cross-domain entitlement breakdown

```sql
-- Identities who have entitlements from a different domain's application
SELECT
    i.display_name              AS identity_name,
    corr_app.name               AS primary_ad_app,   -- where account lives
    ent_app.name                AS entitlement_app,  -- where the group lives
    ie.value                    AS group_value,
    ie.aggregation_state
FROM spt_identity_entitlement ie
JOIN spt_identity i     ON i.id = ie.identity_id
JOIN spt_application ent_app ON ent_app.id = ie.application
-- Find the identity's primary AD account application

exec
/bin/bash -lc "sed -n '260,620p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/AD-Groups-in-IIQ-Governance.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
-- Find the identity's primary AD account application
JOIN spt_link l         ON l.identity_id = i.id
JOIN spt_application corr_app ON corr_app.id = l.application
WHERE ent_app.type = 'Active Directory'
  AND corr_app.type = 'Active Directory'
  AND ent_app.id != corr_app.id    -- entitlement is from a DIFFERENT domain
  AND ie.aggregation_state = 'Connected'
ORDER BY i.display_name;
```

### Entitlements disconnected outside IIQ (removed in AD without IIQ approval)

```sql
SELECT
    i.display_name      AS identity_name,
    ie.value            AS group_value,
    a.name              AS application,
    ie.assigned,
    ie.granted_by_role
FROM spt_identity_entitlement ie
JOIN spt_identity i    ON i.id = ie.identity_id
JOIN spt_application a ON a.id = ie.application
WHERE ie.aggregation_state = 'Disconnected'
  AND a.type = 'Active Directory'
  AND ie.assigned = 1    -- IIQ had granted this, but it was removed outside IIQ
ORDER BY i.display_name;
```

---

## Related

- [[IAM-Overview]] — how governance fits into the IAM stack
- [[AD-LDAP-Fundamentals]] — what AD groups are and how membership is stored
- [[AD-Domain-Forest-Trusts]] — cross-domain group scope and entitlement implications
- [[IIQ-AD-LDAP-Connector]] — how groups are aggregated from AD into IIQ
- [[IIQ-Concepts]] — IIQ mental models for roles, entitlements, and certifications
- [[IIQ-Data-Flows]] — step-by-step data flows for access requests and certifications
- [[IIQ]] — full schema reference for `spt_identity_entitlement`, `spt_managed_attribute`
- [[IIQ-Field-Values]] — `aggregation_state`, `assigned`, `granted_by_role` value meanings

codex
Recommended starting point: [IIQ-Analyst-Playbook.md](/home/nhatquang/Knowledge/Cyber%20Security/CISSP/Domain%205%20-%20Identity%20and%20Access%20Management/SailPoint%20IIQ/IIQ-Analyst-Playbook.md), with [AD-Groups-in-IIQ-Governance.md](/home/nhatquang/Knowledge/Cyber%20Security/CISSP/Domain%205%20-%20Identity%20and%20Access%20Management/SailPoint%20IIQ/AD-Groups-in-IIQ-Governance.md) as the specific AD group reference.

For the report, start from the AD group recipe “All identities with a specific AD group” and adapt it to:

```sql
ie.name = 'memberOf'
AND ie.value LIKE '%Domain Admins%'
AND ie.aggregation_state = 'Connected'
```

The SQL concept they should use is `JOIN`: join `spt_identity_entitlement` to `spt_identity` for who has the group, `spt_application` for the AD source, and then optionally join/left join request or provisioning tables to trace when it was granted. They should also use the vault’s timestamp conversion pattern because IIQ stores dates as epoch milliseconds.
tokens used
51,829
Recommended starting point: [IIQ-Analyst-Playbook.md](/home/nhatquang/Knowledge/Cyber%20Security/CISSP/Domain%205%20-%20Identity%20and%20Access%20Management/SailPoint%20IIQ/IIQ-Analyst-Playbook.md), with [AD-Groups-in-IIQ-Governance.md](/home/nhatquang/Knowledge/Cyber%20Security/CISSP/Domain%205%20-%20Identity%20and%20Access%20Management/SailPoint%20IIQ/AD-Groups-in-IIQ-Governance.md) as the specific AD group reference.

For the report, start from the AD group recipe “All identities with a specific AD group” and adapt it to:

```sql
ie.name = 'memberOf'
AND ie.value LIKE '%Domain Admins%'
AND ie.aggregation_state = 'Connected'
```

The SQL concept they should use is `JOIN`: join `spt_identity_entitlement` to `spt_identity` for who has the group, `spt_application` for the AD source, and then optionally join/left join request or provisioning tables to trace when it was granted. They should also use the vault’s timestamp conversion pattern because IIQ stores dates as epoch milliseconds.

---

## Q09

**Question:** Someone asks: "I want to start a causal inference project on IAM risk. What should I do first?" Walk through the correct steps using this vault's resources.

**Answer:**

Reading additional input from stdin...
OpenAI Codex v0.130.0
--------
workdir: /home/nhatquang/Knowledge
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, /home/nhatquang/.codex/memories]
reasoning effort: medium
reasoning summaries: none
session id: 019e11e3-5cb7-7fb1-95b3-c8256cc2b490
--------
user
You are working in a personal knowledge vault. Start by reading `README.md` to orient yourself. Use `knowledge-index.md` to locate specific notes. Do not scan the entire vault — route through the index first.

Someone asks: "I want to start a causal inference project on IAM risk. What should I do first?" Walk through the correct steps using this vault's resources.
warning: Codex's Linux sandbox uses bubblewrap and needs access to create user namespaces.
2026-05-10T12:36:15.714852Z ERROR rmcp::transport::worker: worker quit with fatal: Transport channel closed, when AuthRequired(AuthRequiredError { www_authenticate_header: "Bearer error=\"invalid_request\", error_description=\"No access token was provided in this request\", resource_metadata=\"https://api.githubcopilot.com/.well-known/oauth-protected-resource/mcp/\"" })
codex
I’ll orient through the vault entry points first, then use the index to find only the notes relevant to causal inference and IAM risk.
exec
/bin/bash -lc "sed -n '1,220p' README.md" in /home/nhatquang/Knowledge
exec
/bin/bash -lc "sed -n '1,260p' knowledge-index.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Vault

Personal knowledge base for CISSP exam preparation, enterprise IAM, data science, and machine learning. Notes are written for long-term retention — every note is independently useful weeks after it was written.

For writing standards and folder conventions, see `CLAUDE.md`.

---

## Where to Start

Route by task:

| I want to... | Start here |
|---|---|
| Study IAM / access control / identity governance | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` |
| Understand SailPoint IIQ or CyberArk | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` |
| Study causal inference methods | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` |
| Find or review a project | `Projects/Project List.md` |
| Navigate any domain | `knowledge-index.md` |
| Understand the full CISSP curriculum | `Cyber Security/CISSP/CISSP - Index.md` |

---

## Source Priority

When multiple notes cover the same topic, prefer in this order:

1. **Project notes** (`Projects/`) — current applied context
2. **Domain index / MOC notes** — authoritative navigation layer
3. **Concept notes** — detailed topic explanations
4. **`_Source/` folders** — raw imported material, not the owner's final opinion

Do not treat `_Source/` content as advice or conclusions. It is reference material only.

---

## Domain Map

| Domain | MOC / Entry Point | Status |
|---|---|---|
| Cyber Security — IAM | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` | Active |
| Cyber Security — CISSP | `Cyber Security/CISSP/CISSP - Index.md` | Active (Domain 5 only) |
| Statistics — Causal Inference | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` | Active |
| Statistics | `Statistics/Statistics.md` | Active |
| Deep Learning | `Deep Learning/Deep Learning.md` | Study notes |
| Machine Learning | `Machine Learning/Machine Learning.md` | Study notes |
| Finance | `Finance/Finance.md` | Study notes |
| Projects | `Projects/Project List.md` | Active |
| Playbooks | `Playbooks/` | Active |

---

## Rules

- Always read the domain MOC or index note before diving into deep concept notes
- `_Source/` folders contain raw imported material — do not treat as authoritative
- Notes link bidirectionally — if note A links to B, B links back to A
- A note with `status: stale` in its frontmatter may be outdated — verify before using
- Wikilinks (`[[Note Name]]`) are Obsidian-specific; resolve them as relative file paths

---

## Status Guide

| Status | Meaning |
|---|---|
| `active` | Current, maintained, reliable |
| `draft` | Work in progress, incomplete |
| `reference` | Stable reference material, not actively updated |
| `stale` | Potentially outdated — verify before using |
| `imported` | Raw source material, not processed into vault opinion |

 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Index

Flat index of every major area in this vault. Load this file first to orient without scanning 425 files. One entry per note: path → what it covers.

---

## Cyber Security

### CISSP
- `Cyber Security/CISSP/CISSP - Index.md` — top-level map of all 8 CISSP domains; only Domain 5 has notes
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` — Domain 5 MOC and reading path

### IAM Fundamentals
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/IAM-Overview.md` — what IAM is and how the stack fits together
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-LDAP-Fundamentals.md` — Active Directory and LDAP basics; group types, memberOf, ADUC
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-Domain-Forest-Trusts.md` — domain topology, forest trusts, group scope rules
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Authentication-Factors-MFA.md` — MFA types and authentication factors
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/OAuth2-OIDC.md` — OAuth2 and OpenID Connect protocols
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Access-Control-Models.md` — DAC, MAC, RBAC, ABAC models
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Physical-vs-Logical-Access.md` — physical vs logical access controls
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Privilege-Escalation-Service-Accounts.md` — privilege escalation paths and service account risks

### SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` — business context for IIQ: identity cube, aggregation, entitlements, roles, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ.md` — complete spt_* schema reference; all tables, columns, joins
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Field-Values.md` — status codes, type enumerations, flag values for all tables
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Data-Flows.md` — step-by-step flows: aggregation, refresh, JML, requests, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md` — how IIQ connects to AD; aggregation types, delta/DirSync, connector gap
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Analyst-Playbook.md` — 60+ SQL recipes for common business questions
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/AD-Groups-in-IIQ-Governance.md` — how AD groups become governed entitlements in IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/CyberArk-IIQ-Integration.md` — three integration patterns between CyberArk PAM and SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/PrivilegedA-Account-Data-Queries.md` — MySQL queries for PRIV_*_A privileged accounts

---

## Statistics

- `Statistics/Statistics.md` — top-level MOC for all statistics topics
- `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` — method selection guide: DiD, matching, RDD, synthetic control
- `Statistics/Causal Inference/Causal Inference.md` — entry point to 25-chapter causal inference study notes
- `Statistics/AB Testing/AB Testing fundamental.md` — A/B testing fundamentals
- `Statistics/Statistical thinking.md` — statistical thinking principles
- `Statistics/Causal Inference/_Source/` — raw imported Python Causality Handbook; not authoritative

---

## Deep Learning

- `Deep Learning/Deep Learning.md` — domain MOC; all subfields and entry points
- `Deep Learning/NLP/NLP.md` — NLP entry point; most developed subfield in this vault
- `Deep Learning/NLP/LLMOps/LLMOps.md` — LLM operations and deployment
- `Deep Learning/NLP/LLMs/Building Production-Grade LLM apps.md` — production LLM application patterns
- `Deep Learning/NLP/LLMs/Multi-Agent LLMs.md` — multi-agent LLM architectures
- `Deep Learning/Foundations/Loss function.md` — loss functions overview
- `Deep Learning/Computer Vision/Generate Image.md` — image generation entry point
- `Deep Learning/XAI/Trustworthy and Explainable AI.md` — XAI and model interpretability
- `Deep Learning/GNN/Advanced GNN.md` — graph neural networks
- `Deep Learning/Open Source/HuggingFace open source.md` — HuggingFace ecosystem

---

## Machine Learning

- `Machine Learning/Machine Learning.md` — domain MOC; clustering and regression
- `Machine Learning/Clustering algorithm/Clustering Algorithm.md` — clustering methods
- `Machine Learning/Regression algorithm/Regression Algorithm.md` — regression methods

---

## Finance

- `Finance/Finance.md` — domain MOC; corporate finance and bank management
- `Finance/Corporate Finance.md` — corporate finance section index
- `Finance/Bank Management and Strategy.md` — bank management section index

---

## Projects

- `Projects/Project List.md` — project registry with status and next actions
- `Projects/Causal IAM Risk Analytics.md` — causal analysis of IAM risk (Idea/MVP)
- `Projects/Fraud Detection using ML.md` — fraud detection project (Draft)
- `Projects/Neural Style Transfer.md` — neural style transfer (Active)

---

## Playbooks

- `Playbooks/Start a New Project.md` — steps to initialize a new project in this vault
- `Playbooks/Causal Analysis Checklist.md` — method selection and data readiness for causal inference
- `Playbooks/Evaluate a Dataset.md` — dataset assessment before starting analysis

codex
The index points to a dedicated project note plus two playbooks, and README says project notes take priority over domain notes. I’m reading those first, then the causal and IAM MOCs for method/domain grounding.
exec
/bin/bash -lc "sed -n '1,260p' 'Projects/Project List.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
domain: projects
updated: 2026-05-10
---

# Project List

Registry of all projects in this vault. Each row has a status and next action so any agent or reviewer can immediately see what is active and what needs doing next.

---

## Registry

| Project | Status | Domain | Data | Next Action |
|---|---|---|---|---|
| [[Causal IAM Risk Analytics]] | Idea / MVP | Cyber Security | Synthetic / public | Build simulation design; define treatment and outcome |
| [[Fraud Detection using ML]] | Draft | Machine Learning | TBD | Define dataset source; set up baseline model |
| [[Neural Style Transfer]] | Active | Deep Learning / CV | Public | Build extended version with text-driven style capture |
| Sentiment Analysis with Mamba | Draft | NLP | Public | Link to `Sentiment Analysis With Mamba.md` |
| Poem Generation | Idea | NLP | TBD | Define scope |
| Bank Transaction Database | Idea | Data Engineering | TBD | Define schema |

---

## Status Definitions

| Status | Meaning |
|---|---|
| Idea | Scoped but not started |
| Idea / MVP | Concept defined; MVP design in progress |
| Draft | Started; incomplete |
| Active | In progress with clear next action |
| Complete | Shipped or finished |
| Paused | On hold |

---

## Related

- `README.md` — vault entry point
- `knowledge-index.md` — full flat index including project file paths
- `Playbooks/Start a New Project.md` — how to initialize a new project in this vault

exec
/bin/bash -lc "sed -n '1,320p' 'Projects/Causal IAM Risk Analytics.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: [project, cybersecurity, iam, causal-inference, pam, sailpoint-iiq, cyberark]
aliases: [Causal IAM Risk Analytics, IAM Causal Inference Project, Causal Analysis for IAM Controls]
---

# Causal IAM Risk Analytics

This project applies [[Causal Inference - Knowledge Map|causal inference]] to [[Domain 5 - IAM|Identity and Access Management]] controls. The goal is to move from "the dashboard metric changed" to a stronger question: **did this IAM control cause a measurable reduction in access risk?**

Because real enterprise IAM, PAM, and SIEM data is usually private, the first version of this project should be built as a public-data and simulation project: use public or synthetic security logs as the behavioral baseline, simulate IAM control rollouts, inject known effects, and test whether causal methods recover those effects.

Before working on this project, read the IAM baseline first: [[Domain 5 - IAM]], [[Access-Control-Models]], [[Privilege-Escalation-Service-Accounts]], [[CyberArk-IIQ-Integration]], and [[Causal Inference - Knowledge Map]].

---

## Why This Project Exists

IAM programs generate many useful metrics: MFA adoption, PAM coverage, password rotation success, access review completion, high-risk sessions, orphan accounts, dormant users, and excessive entitlements. These metrics are good for monitoring, but they do not automatically prove that a control works.

For example, if CyberArk-managed accounts have more high-risk sessions than unmanaged accounts, that does not mean CyberArk increases risk. It may simply mean the riskiest privileged accounts were onboarded first.

**This project solves that by treating IAM changes as interventions and estimating their causal effect on security outcomes.**

> [!tip] Mental model
> IAM dashboards answer "what changed?" Causal IAM analytics asks "what would have happened without the control?"

---

## Core Idea

Model each IAM control as a treatment:

| IAM control | Treatment definition | Possible outcome |
|---|---|---|
| CyberArk PAM onboarding | Account, safe, or application becomes managed by PAM | Password age, rotation success, high-risk sessions, PAM coverage |
| Access certification | Identity or entitlement enters a review campaign | Revoked stale access, entitlement count, policy violations |
| MFA or adaptive MFA rollout | User, app, or group becomes subject to stronger authentication | Risky login rate, account compromise, helpdesk friction |
| JIT privileged access | Standing admin access replaced by time-limited approval | Standing entitlement count, privileged session volume, approval latency |
| Service account hardening | Account moved to vault, gMSA, rotation, or no-interactive-login policy | Excessive privilege, unmanaged account count, credential age |
| RBAC or ABAC redesign | Access moves from direct grants to role or attribute policy | Role explosion, direct entitlement count, SOD violations |

The core output should be an evidence-backed statement:

> "After accounting for baseline differences and time trends, this IAM control changed this risk outcome by this estimated amount, under these assumptions."

---

## Candidate Causal Questions

### CyberArk PAM

- Did CyberArk onboarding reduce password age and increase rotation compliance?
- Did session isolation or recording reduce high-risk privileged sessions?
- Did PAM coverage reduce the number of unmanaged privileged accounts?
- Did integrating CyberArk with SailPoint IIQ reduce stale safe memberships?

Relevant notes:
- [[CyberArk PAM/05-dashboard-guide/key-metrics-and-kpis|CyberArk Key Metrics and KPIs]]
- [[CyberArk-IIQ-Integration]]
- [[safes]]
- [[accounts]]
- [[CyberArk PAM/03-key-entities/sessions|CyberArk Sessions]]

### SailPoint IIQ Governance

- Did access certification campaigns remove stale or excessive entitlements?
- Did Joiner-Mover-Leaver controls reduce privilege creep after role changes?
- Did role-based provisioning reduce direct access grants?
- Did SOD policies reduce toxic access combinations?

Relevant notes:
- [[IIQ-Concepts]]
- [[IIQ-Data-Flows]]
- [[IIQ-Analyst-Playbook]]
- [[AD-Groups-in-IIQ-Governance]]

### Authentication and Adaptive Access

- Did MFA reduce risky login events?
- Did adaptive MFA reduce risk without creating too much user friction?
- Did JIT access reduce standing privilege while preserving operational access?
- Did risk-based access policies improve outcomes beyond static RBAC rules?

Relevant notes:
- [[Authentication-Factors-MFA]]
- [[OAuth2-OIDC]]
- [[SAML-Federation]]
- [[Access-Control-Models]]

### Service Accounts and Non-Human Identities

- Did service account vaulting reduce credential age and unmanaged secrets?
- Did gMSA adoption reduce service account password risk?
- Did no-interactive-login policy reduce lateral movement exposure?
- Did agent identity governance reduce borrowed identity and overbroad delegated access?

Relevant notes:
- [[Privilege-Escalation-Service-Accounts]]
- [[AI-Agent-Identity-and-IAM]]

---

## Data Strategy

There are two versions of this project:

| Version | Data | What it can prove |
|---|---|---|
| Public/synthetic MVP | Public security datasets plus simulated IAM interventions | The causal workflow works, the assumptions are explicit, and the estimators can recover known effects |
| Real enterprise extension | SailPoint, CyberArk, Entra ID, AD, SIEM, HR, and ticketing data | Whether a real IAM control reduced risk in a specific environment |

The MVP should be honest about its limitation: it cannot prove that CyberArk, SailPoint, MFA, or JIT worked in a real company. It can prove that the project can model IAM controls as interventions, construct counterfactuals, and estimate effects under controlled assumptions.

### Public or Synthetic Data Options

| Dataset | What it provides | Best use in this project |
|---|---|---|
| LANL authentication dataset | Large enterprise user-computer authentication graph over time | Login/session behavior, lateral-movement proxy features, user-week panels |
| CERT insider threat dataset | Synthetic logon, device, file, email, HTTP, and insider-threat scenarios | User-risk outcomes, simulated access reviews, insider-risk proxy modeling |
| Splunk Boss of the SOC datasets | Realistic SOC/attack investigation logs | Security event outcomes and attack/risk labels |
| OTRF Security Datasets / Mordor | Windows and attack logs mapped to MITRE ATT&CK | Lab-style detection events and endpoint activity |

### Simulated IAM Rollouts

Add a treatment layer on top of the public dataset:

| Simulated control | Example treatment rule | Example injected effect |
|---|---|---|
| MFA rollout | Selected users become MFA-required after week 8 | Reduce risky login probability by a fixed percentage |
| Access review campaign | High-entitlement users reviewed after a chosen date | Reduce stale entitlement count or risky access score |
| PAM onboarding | Privileged or service-account-like identities become managed | Reduce credential-age violations or privileged-risk score |
| JIT access | Standing admin access replaced by time-limited access | Reduce standing privilege exposure |
| Service account hardening | `svc_*`-like identities get vaulting or no-interactive-login control | Reduce suspicious service-account login events |

This simulation layer should be saved and documented so the true treatment effect is known. The project can then compare estimated effects against the injected ground truth.

## Real Enterprise Data Sources

| Source | Useful fields or metrics | Project use |
|---|---|---|
| SailPoint IIQ | identities, accounts, entitlements, roles, access requests, certifications, policy violations | Access lifecycle, privilege creep, certification outcomes |
| CyberArk PAM | accounts, safes, safe memberships, rotation status, password age, sessions, risk score | Privileged account control and PAM effectiveness |
| Active Directory / LDAP | users, groups, service accounts, disabled accounts, last logon, group membership | Baseline access state and account lifecycle |
| SIEM / authentication logs | login risk, MFA prompts, failures, location, device, suspicious activity | Authentication and adaptive access outcomes |
| HR or authoritative source | department, role, manager, joiner/mover/leaver status | Confounders and lifecycle events |
| Ticketing / access request system | request date, approval, revoke, exception, incident | Operational friction and approval latency |

Important unit choices:
- Identity-month for user access lifecycle questions.
- Account-month for service account and privileged account questions.
- Safe-month or application-month for CyberArk onboarding questions.
- Login-session for authentication questions.

---

## Method Map

| Problem shape | Causal method | IAM example |
|---|---|---|
| Clean randomized rollout | [[02 - Randomised Experiments]] | Randomly phase adaptive MFA by low-risk user group |
| Observed confounders, no hidden confounding | [[10 - Matching]], [[11 - Propensity Score]], [[12 - Doubly Robust Estimation]] | Compare reviewed vs non-reviewed users with similar role, department, access level, and history |
| Panel data with treated and control groups | [[13 - Difference-in-Differences]], [[14 - Panel Data and Fixed Effects]] | Compare departments before and after CyberArk onboarding waves |
| One treated business unit or application | [[15 - Synthetic Control]] | Build a counterfactual for the first application onboarded to PAM |
| Treatment changes at a policy threshold | [[16 - Regression Discontinuity Design]] | Compare sessions just above and below a risk-score threshold for step-up MFA |
| Treatment effects vary across users or systems | [[18 - Heterogeneous Treatment Effects and Personalization]], [[21 - Meta Learners]], [[22 - Debiased Orthogonal Machine Learning]] | Estimate which departments, apps, or account types benefit most from stricter controls |

> [!warning] Prediction is not causal evidence
> A model that predicts high-risk users or sessions is useful, but it does not prove which IAM control will reduce that risk. For causal claims, define the intervention, the counterfactual, and the identification assumptions.

---

## MVP

Start with a public or synthetic dataset, then simulate the IAM rollout. The cleanest first version is based on the CERT insider threat dataset because it already contains multiple user-activity log types and malicious-behavior scenarios.

**Research question:** Can causal inference estimate the effect of a simulated IAM control rollout on insider-risk or access-risk proxy outcomes?

**Unit:** User-week.

**Treatment:** A simulated control such as MFA, access review, PAM onboarding, JIT access, or service-account hardening is applied after a chosen rollout date.

**Primary outcomes:**
- Risky activity score.
- Abnormal login/session count.
- Sensitive file/device activity.
- Simulated stale entitlement count.
- Simulated standing privilege exposure.

**Candidate design:**
- Use difference-in-differences if treated and untreated users have pre/post periods.
- Use matching or propensity scores if treated users are selected based on baseline risk.
- Use synthetic control if one department, application, or high-risk group is treated first.
- Use regression discontinuity if the simulated policy uses a risk-score threshold.

**Minimum deliverable:**
- One project notebook or report with:
  - public dataset description;
  - simulation design and known injected effect;
  - data dictionary;
  - treatment and outcome definitions;
  - baseline trend plots;
  - causal design choice;
  - assumption checks;
  - estimated effect size;
  - limitations and alternative explanations.

---

## Feasibility Assessment

**Verdict: feasible as a methods-demonstration MVP. Not feasible as evidence that real IAM products reduce real risk.** The note framing on lines 112 and 216 is honest about this — score the project on what it actually proposes, not what it sounds like at first read.

| Dimension | Score | Reasoning |
|---|---|---|
| Data availability | 8/10 | CERT r4.2/r5.2, LANL auth dataset, OTRF/Mordor are all freely downloadable today |
| Method fit | 9/10 | DiD, matching, synthetic control, RDD map cleanly onto staggered IAM rollouts |
| Prerequisite skills | 9/10 | Causal Inference 01–25 covered; IAM domain knowledge is deep |
| MVP scope realism | 7/10 | Achievable in 6–9 weeks part-time; the simulation harness is the hidden cost |
| External validity | 3/10 | Recovering an injected effect proves the pipeline works, not that any product reduces risk in production — this is the project's structural ceiling |
| Portfolio value | 8/10 | Rare intersection (security + causal inference) with a defensible writeup |
| Self-deception risk | 6/10 risk | Easy to validate your own injected effect with a method designed to recover it — mitigations below are non-negotiable |

### What makes it work

- **Semi-synthetic benchmarking is a legitimate methodology.** EconML's IHDP benchmark, the ACIC competitions, and most causal-ML papers use injected ground-truth effects on real or quasi-real covariates. This project sits in that established tradition.
- **CERT insider-threat dataset is purpose-built for this.** It already has user-week structure across logon/device/file/email/HTTP logs and labelled malicious scenarios. Panel construction is mechanical, not novel research.
- **Method-to-problem mapping is sound.** Staggered PAM onboarding waves → staggered DiD ([[24 - The Difference-in-Differences Saga]]). Risk-score threshold for step-up MFA → RDD ([[16 - Regression Discontinuity Design]]). First app onboarded to PAM → Synthetic Control ([[15 - Synthetic Control]]). Reviewed-vs-unreviewed users with selection on baseline risk → Propensity Score / DR ([[11 - Propensity Score]], [[12 - Doubly Robust Estimation]]).

### What will sink it if ignored

> [!warning] Three structural risks
> These are not optional design notes. They are stop-the-project conditions if not addressed before the MVP report is written.

1. **Circular validation.** Injecting a linear, additive treatment effect and recovering it with linear DiD proves nothing except that the code runs. The simulation must include non-random treatment assignment (riskiest accounts onboarded first), effect heterogeneity (different sizes by department/account type/baseline risk), realistic outcome noise, and at least one "unfaithful" scenario with a hidden confounder the methods *cannot* recover — to demonstrate honesty about identification.
2. **Outcome-construction leakage.** "Risky activity score" and "stale entitlement count" don't exist natively in CERT/LANL — they're constructed by the analyst. If the same person designs the outcome and the treatment, the outcome can subtly encode the treatment. **Outcome definition must be locked and committed to the repo before treatment assignment is generated.**
3. **The V2 "real enterprise extension" is aspirational.** SailPoint/CyberArk/SIEM/HR data is not in hand. Treat V2 as a design spec for if data became available, not as a planned phase. Do not oversell the project as "I analyzed real PAM rollouts."

### Concrete MVP shape that will work

| Element | Specification |
|---|---|
| Dataset | CERT insider threat r4.2 (smaller; r5.2 if compute allows) |
| Unit | User-week |
| Panel window | 73 weeks (matches CERT timeline) |
| Treatment | Simulated PAM onboarding wave: privileged-like users onboarded across weeks 20, 30, 40 in three cohorts |
| Assignment rule | Logistic on baseline-risk covariates → non-random by design |
| Outcome | Off-hours logon count + removable-device write count per user-week (locked spec, frozen before assignment is drawn) |
| Injected effect | Heterogeneous: 30% reduction for high-baseline cohort, 10% for medium, 0% for low |
| Primary estimator | Staggered DiD (Callaway-Sant'Anna) with PSM-trimmed sample |
| Robustness | Synthetic control on the first cohort; placebo treatment on pre-period |
| Honesty check | One scenario with a hidden confounder (e.g., department-wide policy change at the same time) — show the methods over/under-estimate, and explain why |

**Effort:** 6–9 weeks part-time. The simulation harness is ~30% of the work; people underestimate it. **Tooling:** Python + `dowhy`, `econml`, `differences` (Callaway-Sant'Anna), `pandas`, `pyarrow`.

### Stop-gate before committing

Run two 1-day spikes before committing to the full 6–9 week MVP:

1. Download CERT r4.2 and build a user-week panel for ~50 users over ~10 weeks. If panel construction takes more than 1 day end-to-end, data plumbing is the blocker.
2. Generate a non-random treatment assignment and a heterogeneous injected effect; run a single Callaway-Sant'Anna DiD; check whether the estimated ATT is in the right neighbourhood.

If either spike takes more than 3 days, scope down before committing further.

### What this project can honestly claim

- "I can model an IAM control rollout as a causal intervention on a security log panel."
- "Under documented assumptions, my pipeline recovers the injected treatment effect within X% of ground truth."
- "When the parallel-trends assumption is violated by a confounding policy change, the estimator drifts in this direction by this amount — and here is the diagnostic that catches it."
- "Here is what would be needed (data sources, identification strategy, ethical review) to repeat this on real enterprise data."

### What it cannot claim

- That CyberArk, SailPoint, MFA, or any specific product reduces risk in any specific organisation.
- Any external-validity statement about real IAM products.

This restraint is a feature, not a bug — it separates a credible portfolio piece from a vendor case study.

---

## Risks and Assumptions

- PAM vs non-PAM comparisons are biased if high-risk accounts were onboarded first.
- Access reviews may be triggered by known risk, so reviewed users are not automatically comparable to unreviewed users.
- Security events are rare, so proxy outcomes like password age, rotation compliance, excessive entitlement count, and high-risk session score may be needed.
- SIEM and IAM logs may have missing or inconsistent identifiers; identity resolution is part of the project, not a cleanup detail.
- Causal claims should be conservative unless the rollout design gives a credible counterfactual.
- Without real enterprise IAM data, the MVP should be presented as a causal-method demonstration, not evidence that a real IAM product works.

---

## Related

- [[Project List]]
- [[Causal Inference - Knowledge Map]] - method selection and assumptions.
- [[Domain 5 - IAM]] - IAM scope and CISSP Domain 5 map.
- [[CyberArk-IIQ-Integration]] - CyberArk and SailPoint governance integration.
- [[IIQ-Analyst-Playbook]] - SQL questions for IIQ data.
- [[CyberArk PAM/05-dashboard-guide/key-metrics-and-kpis|CyberArk Key Metrics and KPIs]] - metric definitions for PAM dashboards.

exec
/bin/bash -lc "sed -n '1,260p' 'Playbooks/Start a New Project.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: playbook
updated: 2026-05-10
---

# Playbook: Start a New Project

Follow these steps every time you initialize a new project in this vault.

---

## Steps

**1. Define the domain and problem**
- What domain does this belong to? (Cyber Security / ML / NLP / Finance / Data Engineering)
- What is the core question or outcome you want to achieve?
- Is this exploratory (Idea) or do you have a concrete plan (MVP / Draft)?

**2. Check existing notes**
- Search the vault for related concept notes before creating new ones
- Check `knowledge-index.md` for existing coverage in the relevant domain
- Check `Projects/Project List.md` for similar or overlapping projects

**3. Create the project file**
- Create `Projects/<Project Name>.md`
- Add frontmatter: `status`, `domain`, `updated`
- Sections to include:
  - **Problem** — what question this project answers
  - **Data** — what data is needed; availability and source
  - **Method** — planned approach (algorithm, model, causal method)
  - **Next Action** — the single most immediate step
  - **Related** — links to relevant concept notes

**4. Register in Project List**
- Add a row to `Projects/Project List.md` with status and next action
- Keep the next action column current — it is the primary navigation signal

**5. Link from domain notes**
- Add a link to the project from the relevant domain MOC or concept note
- Ensures the project is reachable from both the domain and the project registry

**6. Identify data**
- Is real data available? If not, is synthetic/simulated data sufficient?
- Note the unit of analysis, key variables, and any known gaps
- If causal inference is involved, run `Playbooks/Causal Analysis Checklist.md` before committing to a method

---

## Related

- `Projects/Project List.md` — the project registry
- `Playbooks/Causal Analysis Checklist.md` — method selection for causal projects
- `Playbooks/Evaluate a Dataset.md` — dataset readiness assessment
- `knowledge-index.md` — find existing notes to link from

exec
/bin/bash -lc "sed -n '1,320p' 'Playbooks/Causal Analysis Checklist.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: playbook
updated: 2026-05-10
---

# Playbook: Causal Analysis Checklist

Run this checklist before committing to a causal inference method for any project. It surfaces the key assumptions, data requirements, and method fit early — before building anything.

---

## Step 1: Define the Causal Question

- What is the **treatment** (intervention, policy, event)?
- What is the **outcome** (what changes as a result)?
- What is the **unit of analysis** (person, account, transaction, system)?
- What is the **counterfactual** — what would have happened without the treatment?

If you cannot answer these four questions, the project is not ready for causal analysis.

---

## Step 2: Check Existing Notes

Before designing from scratch, check what causal methods are already documented:

- `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` — method selection guide
- `Statistics/Causal Inference/Causal Inference.md` — entry to 25-chapter detailed notes
- `Projects/Causal IAM Risk Analytics.md` — applied causal inference example in IAM context

---

## Step 3: Select a Method

| Situation | Method | Key Assumption |
|---|---|---|
| Treatment assigned randomly | Randomized experiment / A/B test | Random assignment |
| Pre/post data with control group | Difference-in-Differences (DiD) | Parallel trends |
| Cutoff-based eligibility | Regression Discontinuity (RDD) | Continuity at cutoff |
| Observable confounders only | Matching / Propensity Score | No hidden confounders |
| Valid instrument available | Instrumental Variables (IV) | Exclusion restriction |
| No control group, aggregate data | Synthetic Control | Pre-treatment fit |

---

## Step 4: Check Data Availability

- Does the data have a **pre-treatment period** and a **post-treatment period**?
- Is there a **control group** (units not affected by treatment)?
- Is the **treatment timing** known and recorded?
- Are the **key confounders** observable in the data?

If real enterprise data is not available, flag this explicitly and decide: use **simulated/synthetic data** for proof of concept, or wait for real data.

> For IAM projects (e.g., Causal IAM Risk Analytics): real production data is rarely shareable. Design with synthetic data that mimics realistic access event patterns. Document the simulation assumptions clearly.

---

## Step 5: Check Assumptions

For the chosen method, explicitly state and verify its core assumption:

- **DiD**: Plot pre-treatment trends for treatment and control groups — do they move in parallel?
- **RDD**: Plot outcome vs. the running variable — is there a discontinuity at the cutoff?
- **Matching**: Check covariate balance before and after matching
- **IV**: Is the instrument truly exogenous? Does it affect the outcome only through the treatment?
- **Synthetic Control**: Does the synthetic control fit the pre-treatment outcome closely?

---

## Step 6: Define the Output

- What is the estimand? (ATE, ATT, LATE?)
- What is the expected effect size and its practical significance?
- How will results be communicated? (coefficient, % change, risk score delta?)

---

## Related

- `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` — detailed method guide
- `Projects/Causal IAM Risk Analytics.md` — causal IAM project applying these methods
- `Playbooks/Evaluate a Dataset.md` — dataset readiness before method selection
- `Playbooks/Start a New Project.md` — project initialization steps

exec
/bin/bash -lc "sed -n '1,320p' 'Statistics/Causal Inference/Causal Inference - Knowledge Map.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: ["causal-inference", "statistics", "knowledge-map", "method-selection"]
aliases: ["Causal Inference Knowledge Map", "Causal Method Map", "Causal Discovery Map"]
source: https://github.com/matheusfacure/python-causality-handbook
source_commit: 3e974d311a415d795a81b4657d524f3ccba4e9fe
---

# Causal Inference - Knowledge Map

This map connects the imported handbook chapters into a working mental model for choosing methods, checking assumptions, and discovering follow-up ideas.

## Method Selection

| Problem shape | Consider | Notes |
|---|---|---|
| Clean randomized assignment | Randomized experiments | [[02 - Randomised Experiments]] |
| Observed confounders, no hidden confounding | Regression, matching, propensity score, doubly robust estimation | [[05 - The Unreasonable Effectiveness of Linear Regression]], [[10 - Matching]], [[11 - Propensity Score]], [[12 - Doubly Robust Estimation]] |
| Hidden confounding but valid instrument | Instrumental variables / LATE | [[08 - Instrumental Variables]], [[09 - Non Compliance and LATE]] |
| Panel data with treated and control groups | Difference-in-differences / fixed effects | [[13 - Difference-in-Differences]], [[14 - Panel Data and Fixed Effects]] |
| One treated unit and weighted control pool | Synthetic control | [[15 - Synthetic Control]] |
| Treatment changes sharply at a threshold | Regression discontinuity | [[16 - Regression Discontinuity Design]] |
| Treatment effects vary across units | HTE, meta-learners, DML | [[18 - Heterogeneous Treatment Effects and Personalization]], [[21 - Meta Learners]], [[22 - Debiased Orthogonal Machine Learning]] |

## Assumption Map

| Assumption | What it protects against | Typical methods |
|---|---|---|
| Exchangeability / unconfoundedness | Treated and untreated units differ in ways that also affect the outcome | Regression, matching, propensity score, doubly robust methods |
| Overlap / positivity | Some groups have no comparable treated or untreated observations | Matching, propensity score trimming, design restriction |
| Exclusion restriction | Instrument affects outcome through channels other than treatment | Instrumental variables |
| Parallel trends | Treated and control groups would not have followed comparable paths without treatment | Difference-in-differences |
| Continuity around cutoff | Units just above and below a threshold are not comparable | Regression discontinuity |
| No interference / SUTVA | One unit's treatment changes another unit's outcome | Most potential-outcomes estimators |

## Discovery Questions

- What is the intervention, not just the prediction target?
- Which counterfactual is missing?
- What assumption identifies that counterfactual?
- Which observed pattern would falsify or weaken the assumption?
- Which method gives the clearest story to a skeptical reader?
- Where can machine learning improve nuisance estimation without replacing identification?

## Imported Chapter Links

- [[01 - Introduction To Causality]]
- [[02 - Randomised Experiments]]
- [[03 - Stats Review The Most Dangerous Equation]]
- [[04 - Graphical Causal Models]]
- [[05 - The Unreasonable Effectiveness of Linear Regression]]
- [[06 - Grouped and Dummy Regression]]
- [[07 - Beyond Confounders]]
- [[08 - Instrumental Variables]]
- [[09 - Non Compliance and LATE]]
- [[10 - Matching]]
- [[11 - Propensity Score]]
- [[12 - Doubly Robust Estimation]]
- [[13 - Difference-in-Differences]]
- [[14 - Panel Data and Fixed Effects]]
- [[15 - Synthetic Control]]
- [[16 - Regression Discontinuity Design]]
- [[17 - Predictive Models 101]]
- [[18 - Heterogeneous Treatment Effects and Personalization]]
- [[19 - Evaluating Causal Models]]
- [[20 - Plug-and-Play Estimators]]
- [[21 - Meta Learners]]
- [[22 - Debiased Orthogonal Machine Learning]]
- [[23 - Challenges with Effect Heterogeneity and Nonlinearity]]
- [[24 - The Difference-in-Differences Saga]]
- [[25 - Synthetic Difference-in-Differences]]
- [[A01 - Debiasing with Orthogonalization]]
- [[A02 - Debiasing with Propensity Score]]
- [[A03 - When Prediction Fails]]
- [[A04 - Why Prediction Metrics are Dangerous For Causal Models]]
- [[A05 - Conformal Inference for Synthetic Controls]]

## Source

- Website: https://matheusfacure.github.io/python-causality-handbook
- GitHub: https://github.com/matheusfacure/python-causality-handbook
- Imported commit: `3e974d311a415d795a81b4657d524f3ccba4e9fe`
- License: MIT License, Copyright (c) 2020 Matheus Facure.

## Related

- [[Causal Inference]] - main index for the imported handbook.
- [[Statistical thinking]] - statistical primitives used across causal inference.
- [[AB Testing fundamental]] - experimental baseline for causal identification.
- [[Machine Learning]] - predictive modeling context for heterogeneous treatment effect methods.

exec
/bin/bash -lc "sed -n '1,280p' 'Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: [cissp, domain-5-iam, moc, identity, access-management]
aliases: [CISSP Domain 5, IAM Domain, Identity and Access Management]
---

# CISSP Domain 5 — Identity and Access Management

Identity and Access Management (IAM) ensures the right people have the right access to the right resources at the right time. Domain 5 covers the full lifecycle: from proving identity, to granting access, to reviewing and revoking it.

---

## CISSP Domain 5 Subtopics

| Subtopic                                    | What It Covers                                                                                                   | Notes in This Vault                                                                                                                                                                       |
| ------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **5.1** Control physical and logical access | Access control models, physical access, least privilege                                                          | [[Physical-vs-Logical-Access]], [[IAM-Overview]], [[what-is-pam]], [[CyberArk-IIQ-Integration]]                                                                                           |
| **5.2** Identification & Authentication     | Groups and roles, AAA, MFA, passwordless, session management, identity proofing, credential management, SSO, JIT | [[AD-LDAP-Fundamentals]], [[AD-Application-Integration]], [[Authentication-Factors-MFA]], [[Kerberos-Protocol]], [[Privilege-Escalation-Service-Accounts]], [[AI-Agent-Identity-and-IAM]] |
| **5.3** Federated Identity                  | SAML, OAuth, OIDC, domain trusts, cross-forest                                                                   | [[AD-Domain-Forest-Trusts]], [[AD-Application-Integration]], [[SAML-Federation]], [[OAuth2-OIDC]]                                                                                         |
| **5.4** Authorization mechanisms            | RBAC, ABAC, ACLs, group-based access                                                                             | [[Access-Control-Models]], [[AD-Application-Integration]], [[AD-File-Shares-NAS-DFS]], [[AD-Groups-in-IIQ-Governance]], [[AI-Agent-Identity-and-IAM]]                                     |
| **5.5** Provisioning lifecycle              | JML (Joiner-Mover-Leaver), access requests, certifications                                                       | [[IIQ-Concepts]], [[IIQ-Data-Flows]], [[IIQ-AD-LDAP-Connector]], [[Privilege-Escalation-Service-Accounts]], [[AI-Agent-Identity-and-IAM]]                                                 |
| **5.6** Authentication systems              | SSO, Kerberos, RADIUS, TACACS+                                                                                   | [[Kerberos-Protocol]], [[SAML-Federation]], [[OAuth2-OIDC]], [[RADIUS-TACACS-Diameter]], [[AD-Application-Integration]]                                                                   |

---

## Reading Path

Start here if you're new to IAM:

```
1.  IAM-Overview                        — understand the technology stack and where each tool fits
2.  AD-LDAP-Fundamentals                — understand directories, groups, and AD itself
3.  AD-Domain-Forest-Trusts             — understand cross-domain topology (key for 5.3)
4.  AD-Application-Integration          — understand how apps consume AD (key for 5.2, 5.4, 5.6)
5.  AD-File-Shares-NAS-DFS             — file share access model: NAS, DFS, UNC, NTFS ACLs
6.  Access-Control-Models               — MAC, DAC, RBAC, ABAC, Rule-Based, Risk-Based, PDP/PEP (key for 5.4)
7.  Authentication-Factors-MFA          — identity proofing, factor types, biometrics, AAL, credential management, SSO, JIT, session management (key for 5.2)
8.  Kerberos-Protocol                   — KDC, TGT, service tickets, AES, NTP (key for 5.6)
9.  SAML-Federation                     — SAML 2.0, IDaaS, on-prem/cloud/hybrid federation (key for 5.3, 5.6)
10. OAuth2-OIDC                         — OAuth 2.0 delegation, OIDC authentication, JWT (key for 5.3, 5.6)
11. RADIUS-TACACS-Diameter              — AAA protocols, network access authentication (key for 5.6)
12. Privilege-Escalation-Service-Accounts — escalation types, service accounts, credential vaults, privilege creep (key for 5.2, 5.5)
13. IIQ-Concepts                        — understand governance tooling (key for 5.5)
14. IIQ-Data-Flows                      — understand the provisioning and certification flows
15. AD-Groups-in-IIQ-Governance         — tie everything together
16. AI-Agent-Identity-and-IAM           — emerging addendum: agents as governable IAM subjects (future-system context)
```

---

## IAM Fundamentals

Notes covering the underlying technology — no tooling yet, just the protocols and concepts.

- [[Physical-vs-Logical-Access]] — CISSP 5.1 foundations: AAA model, defense-in-depth principles, and how logical access materializes in IIQ
- [[IAM-Overview]] — the IAM stack: directory, authentication, authorization, governance, PAM layers
- [[AD-LDAP-Fundamentals]] — LDAP protocol, Active Directory, group types, key attributes, macOS/Linux integration
- [[AD-Domain-Forest-Trusts]] — domains, forests, trust types, cross-domain group scope rules, AGDLP
- [[AD-Application-Integration]] — Kerberos tokens, LDAP bind, SAML/federation, PAM/SSSD; how apps actually consume AD groups
- [[AD-File-Shares-NAS-DFS]] — NAS devices, UNC paths, DFS namespaces, NTFS vs. share permissions, AGDLP on file share ACLs
- [[Access-Control-Models]] — MAC, DAC, RBAC, Rule-Based, ABAC, Risk-Based; PDP/PEP architecture; implicit deny and constrained interfaces
- [[Authentication-Factors-MFA]] — identity registration/proofing, five factor types, MFA vs 2FA, biometrics (FAR/FRR/CER), AAL1/2/3, credential management systems, TOTP/FIDO2, SSO, JIT provisioning, session management
- [[Kerberos-Protocol]] — KDC, AS, TGS, TGT, Service Ticket, PAC; full ticket exchange flow; AES, NTP dependency, port 88
- [[SAML-Federation]] — SAML 2.0 assertion types, SP/IdP-initiated flows, metadata, IDaaS, WS-Federation, on-prem/cloud/hybrid federation
- [[OAuth2-OIDC]] — OAuth 2.0 grant types, OIDC authentication layer, JWT/ID tokens, delegated access, OAuth vs SAML
- [[RADIUS-TACACS-Diameter]] — AAA model, RADIUS (UDP 1812/1813), TACACS+ (TCP 49, full encryption), Diameter
- [[Privilege-Escalation-Service-Accounts]] — horizontal/vertical escalation, lateral movement, privilege creep, credential vaults, service account management, gMSA
- [[AI-Agent-Identity-and-IAM]] — emerging addendum: AI agents as non-human IAM subjects with delegated access, tool permissions, memory, ownership, and audit requirements

---

## SailPoint IIQ — Enterprise IAM Governance

Notes covering SailPoint IdentityIQ as a concrete implementation of IAM governance (CISSP 5.5).

### Concepts & Architecture
- [[IIQ-Concepts]] — Identity Cube, authoritative sources, roles, entitlements, JML lifecycle
- [[IIQ-Data-Flows]] — aggregation, correlation, access request, certification, and provisioning flows
- [[IIQ-Field-Values]] — enumerated values for all key status fields

### Active Directory Integration
- [[IIQ-AD-LDAP-Connector]] — connector config, aggregation mechanics, correlation rules, delta sync
- [[AD-Groups-in-IIQ-Governance]] — managed entitlements, role modelling, certifications, SQL recipes

### Schema Reference
- [[IIQ]] — complete database schema for all ~80 `spt_*` tables

### Analytics & Reporting
- [[IIQ-Analyst-Playbook]] — SQL recipes for common business questions

### Privileged Access
- [[CyberArk-IIQ-Integration]] — CyberArk PAM + SailPoint IIQ integration patterns
- [[PrivilegedA-Account-Data-Queries]] — SQL queries for privileged "A" accounts in AD

---

## CyberArk PAM — Privileged Access Management

Standalone reference for CyberArk Self-Hosted PAM, focused on data model, architecture, and dashboarding via Power BI. Treat this section as **supporting implementation context**, not the exam-core reading path. It reinforces CISSP 5.1 (control of privileged access), 5.2 (credential management systems / password vault), 5.4 (authorization for shared/admin accounts), and 5.5 (privileged account lifecycle), but many dashboard/API/reference notes are vendor-specific rather than CISSP objectives.

### Index
- [[CyberArk PAM/README|CyberArk PAM Index]] — entry point with full table of contents

### Core Concepts
- [[what-is-pam]] — Privileged Access Management fundamentals
- [[what-is-cyberark]] — CyberArk product suite overview (Self-Hosted)
- [[why-pam-matters]] — compliance and security drivers (SOX, PCI-DSS, SOC 2)

### Architecture
- [[CyberArk PAM/02-architecture/overview|CyberArk Architecture Overview]] — high-level architecture and data flows
- [[digital-vault]] — encrypted credential storage at the centre
- [[pvwa]] — web interface and REST API gateway (the dashboard integration point)
- [[cpm]] — password rotation engine
- [[psm]] — session isolation and recording
- [[pta]] — threat analytics
- [[aam-ccp]] — application credential retrieval
- [[deployment-models]] — Self-Hosted vs Privilege Cloud deployment options

### Data Model (Key Entities)
- [[safes]] — logical containers for accounts (the primary access boundary)
- [[accounts]] — privileged credentials (the central entity)
- [[platforms]] — management behaviour definitions per target type
- [[CyberArk PAM/03-key-entities/users-and-groups|CyberArk Users and Groups]] — vault users and LDAP integration
- [[policies-and-permissions]] — access control on safes
- [[CyberArk PAM/03-key-entities/sessions|CyberArk Sessions]] — privileged session objects

### Glossary & Reference
- [[CyberArk PAM/04-glossary/glossary|CyberArk Glossary]] — A–Z reference of CyberArk-specific terms
- [[common-error-codes]] — error code lookup
- [[further-reading]] — external docs and resources

### Dashboarding (Power BI)
- [[key-metrics-and-kpis]] — master metrics list
- [[password-management-dashboard]]
- [[session-monitoring-dashboard]]
- [[compliance-dashboard]]
- [[system-health-dashboard]]
- [[power-bi-integration]] — REST API authentication and query patterns

---

## Related

- [[CISSP - Index]] — all 8 CISSP domains
- [[Cyber Security]] — top-level cybersecurity note

exec
/bin/bash -lc "sed -n '1,280p' 'Playbooks/Evaluate a Dataset.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: playbook
updated: 2026-05-10
---

# Playbook: Evaluate a Dataset

Run this checklist before committing a dataset to any project. It determines whether the data is suitable for the intended analysis and surfaces gaps early.

---

## Step 1: Unit of Analysis

- What does one row represent? (person, account, event, transaction, session?)
- Is the unit consistent throughout the dataset, or does it mix levels?
- Does the unit of analysis match the project's causal question?

---

## Step 2: Timestamp Fields

- Are there timestamp fields? What do they represent?
- Are timestamps in a usable format, or need conversion?

> For IIQ data: timestamps are BIGINT epoch milliseconds — divide by 1000 for standard conversion. See `SailPoint IIQ/IIQ.md`.

- Is there a clear **event time** (when something happened) vs. **observation time** (when data was recorded)?
- Is there sufficient **pre-treatment history** for causal methods?

---

## Step 3: Target / Outcome Variable

- What is the outcome you want to predict or explain?
- Is it observable in the data, or must it be constructed?
- What is the base rate? (Is the outcome rare — <1%? Imbalanced classes?)
- Are there data quality issues with the outcome (missingness, proxy measures)?

---

## Step 4: Treatment / Intervention Variable

- Is the treatment variable recorded in the data?
- Is treatment timing known? Is there a clear before/after?
- Is treatment assignment observable and credible for causal inference?
- Is there selection bias in who received treatment?

---

## Step 5: Key Covariates / Confounders

- What variables could explain both treatment and outcome (confounders)?
- Are they present in the data?
- Are there important confounders that are unobserved or unmeasured?

---

## Step 6: Missingness

- What percentage of rows have missing values per column?
- Is missingness random (MAR) or systematic (MNAR)?
- For key variables (outcome, treatment, main covariates): is missingness acceptable?

---

## Step 7: Causal Inference Feasibility

Based on steps 1–6, determine feasibility:

| Check | Result |
|---|---|
| Unit of analysis is clear | Yes / No |
| Treatment variable is recorded | Yes / No |
| Treatment timing is known | Yes / No |
| Pre-treatment period exists | Yes / No |
| Control group exists | Yes / No |
| Key confounders are observable | Yes / No |

If most answers are No: causal inference is not directly possible. Either redesign the data collection, use synthetic data, or change the method to predictive modelling.

---

## Step 8: Recommendation

State one of:
- **Ready for causal inference** — specify the method (see `Playbooks/Causal Analysis Checklist.md`)
- **Ready for predictive modelling** — specify the model type
- **Not ready** — list what is missing and what would need to change

---

## Related

- `Playbooks/Causal Analysis Checklist.md` — method selection once data is confirmed suitable
- `Playbooks/Start a New Project.md` — project initialization steps
- `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` — method selection guide

codex
I have enough to answer from the vault’s maintained route: the project already exists, and its next action is explicit. I’ll pull line numbers for the key references so the walkthrough points to the exact notes.
codex
The parallel line-number read hit the sandbox’s loopback setup error, so I’m retrying those reads individually with the same scope.
codex
Start with the existing project note, not a blank project: [Causal IAM Risk Analytics](/home/nhatquang/Knowledge/Projects/Causal%20IAM%20Risk%20Analytics.md). The project is already registered in [Project List](/home/nhatquang/Knowledge/Projects/Project%20List.md) with the next action: build the simulation design and define treatment/outcome.

Correct first steps:

1. Read the IAM baseline first:
   [Domain 5 - IAM](/home/nhatquang/Knowledge/Cyber%20Security/CISSP/Domain%205%20-%20Identity%20and%20Access%20Management/Domain%205%20-%20IAM.md), especially access control, MFA, privilege escalation/service accounts, SailPoint IIQ, and CyberArk PAM context.

2. Define the causal question before touching data:
   Use [Causal Analysis Checklist](/home/nhatquang/Knowledge/Playbooks/Causal%20Analysis%20Checklist.md). You need four answers:
   - Treatment: which IAM control? MFA rollout, PAM onboarding, access review, JIT, service-account hardening.
   - Outcome: what risk metric changes?
   - Unit: likely `user-week`, `account-month`, `safe-month`, or `login-session`.
   - Counterfactual: what would have happened without the control?

3. Use the project’s recommended MVP:
   Start with CERT insider threat data, unit = `user-week`, and simulate an IAM rollout. The strongest starting design is a simulated PAM onboarding wave over weeks 20, 30, and 40.

4. Lock the outcome before simulating treatment:
   For the MVP, use something like off-hours logon count plus removable-device write count per user-week. Do not let the treatment assignment leak into the outcome definition.

5. Evaluate dataset readiness:
   Run [Evaluate a Dataset](/home/nhatquang/Knowledge/Playbooks/Evaluate%20a%20Dataset.md): confirm timestamps, pre/post periods, treatment timing, control group, confounders, missingness, and unit consistency.

6. Pick the causal method from the method map:
   Use [Causal Inference - Knowledge Map](/home/nhatquang/Knowledge/Statistics/Causal%20Inference/Causal%20Inference%20-%20Knowledge%20Map.md).
   - Staggered rollout with treated/control users: Difference-in-Differences.
   - Selection on baseline risk: matching / propensity score / doubly robust.
   - One treated department/app: synthetic control.
   - Risk-score threshold: regression discontinuity.

7. Run the two stop-gate spikes before committing:
   - Build a small CERT user-week panel for about 50 users over 10 weeks.
   - Generate non-random treatment assignment, inject a heterogeneous effect, and check whether a simple DiD estimate lands near the known ground truth.

The key framing: this should be presented as a semi-synthetic causal-method demonstration, not proof that CyberArk, SailPoint, MFA, or any real IAM product reduces risk in production.
tokens used
28,177
Start with the existing project note, not a blank project: [Causal IAM Risk Analytics](/home/nhatquang/Knowledge/Projects/Causal%20IAM%20Risk%20Analytics.md). The project is already registered in [Project List](/home/nhatquang/Knowledge/Projects/Project%20List.md) with the next action: build the simulation design and define treatment/outcome.

Correct first steps:

1. Read the IAM baseline first:
   [Domain 5 - IAM](/home/nhatquang/Knowledge/Cyber%20Security/CISSP/Domain%205%20-%20Identity%20and%20Access%20Management/Domain%205%20-%20IAM.md), especially access control, MFA, privilege escalation/service accounts, SailPoint IIQ, and CyberArk PAM context.

2. Define the causal question before touching data:
   Use [Causal Analysis Checklist](/home/nhatquang/Knowledge/Playbooks/Causal%20Analysis%20Checklist.md). You need four answers:
   - Treatment: which IAM control? MFA rollout, PAM onboarding, access review, JIT, service-account hardening.
   - Outcome: what risk metric changes?
   - Unit: likely `user-week`, `account-month`, `safe-month`, or `login-session`.
   - Counterfactual: what would have happened without the control?

3. Use the project’s recommended MVP:
   Start with CERT insider threat data, unit = `user-week`, and simulate an IAM rollout. The strongest starting design is a simulated PAM onboarding wave over weeks 20, 30, and 40.

4. Lock the outcome before simulating treatment:
   For the MVP, use something like off-hours logon count plus removable-device write count per user-week. Do not let the treatment assignment leak into the outcome definition.

5. Evaluate dataset readiness:
   Run [Evaluate a Dataset](/home/nhatquang/Knowledge/Playbooks/Evaluate%20a%20Dataset.md): confirm timestamps, pre/post periods, treatment timing, control group, confounders, missingness, and unit consistency.

6. Pick the causal method from the method map:
   Use [Causal Inference - Knowledge Map](/home/nhatquang/Knowledge/Statistics/Causal%20Inference/Causal%20Inference%20-%20Knowledge%20Map.md).
   - Staggered rollout with treated/control users: Difference-in-Differences.
   - Selection on baseline risk: matching / propensity score / doubly robust.
   - One treated department/app: synthetic control.
   - Risk-score threshold: regression discontinuity.

7. Run the two stop-gate spikes before committing:
   - Build a small CERT user-week panel for about 50 users over 10 weeks.
   - Generate non-random treatment assignment, inject a heterogeneous effect, and check whether a simple DiD estimate lands near the known ground truth.

The key framing: this should be presented as a semi-synthetic causal-method demonstration, not proof that CyberArk, SailPoint, MFA, or any real IAM product reduces risk in production.

---

## Q10

**Question:** What does this vault's causal inference material say about the assumptions behind Synthetic Control? Is this from the vault owner's own notes or from an imported source?

**Answer:**

Reading additional input from stdin...
OpenAI Codex v0.130.0
--------
workdir: /home/nhatquang/Knowledge
model: gpt-5.5
provider: openai
approval: never
sandbox: workspace-write [workdir, /tmp, /home/nhatquang/.codex/memories]
reasoning effort: medium
reasoning summaries: none
session id: 019e11e4-9552-7370-800d-619142d11cc2
--------
user
You are working in a personal knowledge vault. Start by reading `README.md` to orient yourself. Use `knowledge-index.md` to locate specific notes. Do not scan the entire vault — route through the index first.

What does this vault's causal inference material say about the assumptions behind Synthetic Control? Is this from the vault owner's own notes or from an imported source?
warning: Codex's Linux sandbox uses bubblewrap and needs access to create user namespaces.
2026-05-10T12:37:36.443667Z ERROR rmcp::transport::worker: worker quit with fatal: Transport channel closed, when AuthRequired(AuthRequiredError { www_authenticate_header: "Bearer error=\"invalid_request\", error_description=\"No access token was provided in this request\", resource_metadata=\"https://api.githubcopilot.com/.well-known/oauth-protected-resource/mcp/\"" })
codex
I’ll orient through the vault’s README and index first, then follow only the relevant links for Synthetic Control.
exec
/bin/bash -lc "sed -n '1,220p' README.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Vault

Personal knowledge base for CISSP exam preparation, enterprise IAM, data science, and machine learning. Notes are written for long-term retention — every note is independently useful weeks after it was written.

For writing standards and folder conventions, see `CLAUDE.md`.

---

## Where to Start

Route by task:

| I want to... | Start here |
|---|---|
| Study IAM / access control / identity governance | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` |
| Understand SailPoint IIQ or CyberArk | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` |
| Study causal inference methods | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` |
| Find or review a project | `Projects/Project List.md` |
| Navigate any domain | `knowledge-index.md` |
| Understand the full CISSP curriculum | `Cyber Security/CISSP/CISSP - Index.md` |

---

## Source Priority

When multiple notes cover the same topic, prefer in this order:

1. **Project notes** (`Projects/`) — current applied context
2. **Domain index / MOC notes** — authoritative navigation layer
3. **Concept notes** — detailed topic explanations
4. **`_Source/` folders** — raw imported material, not the owner's final opinion

Do not treat `_Source/` content as advice or conclusions. It is reference material only.

---

## Domain Map

| Domain | MOC / Entry Point | Status |
|---|---|---|
| Cyber Security — IAM | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` | Active |
| Cyber Security — CISSP | `Cyber Security/CISSP/CISSP - Index.md` | Active (Domain 5 only) |
| Statistics — Causal Inference | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` | Active |
| Statistics | `Statistics/Statistics.md` | Active |
| Deep Learning | `Deep Learning/Deep Learning.md` | Study notes |
| Machine Learning | `Machine Learning/Machine Learning.md` | Study notes |
| Finance | `Finance/Finance.md` | Study notes |
| Projects | `Projects/Project List.md` | Active |
| Playbooks | `Playbooks/` | Active |

---

## Rules

- Always read the domain MOC or index note before diving into deep concept notes
- `_Source/` folders contain raw imported material — do not treat as authoritative
- Notes link bidirectionally — if note A links to B, B links back to A
- A note with `status: stale` in its frontmatter may be outdated — verify before using
- Wikilinks (`[[Note Name]]`) are Obsidian-specific; resolve them as relative file paths

---

## Status Guide

| Status | Meaning |
|---|---|
| `active` | Current, maintained, reliable |
| `draft` | Work in progress, incomplete |
| `reference` | Stable reference material, not actively updated |
| `stale` | Potentially outdated — verify before using |
| `imported` | Raw source material, not processed into vault opinion |

exec
/bin/bash -lc "sed -n '1,260p' knowledge-index.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
status: active
type: index
updated: 2026-05-10
---

# Knowledge Index

Flat index of every major area in this vault. Load this file first to orient without scanning 425 files. One entry per note: path → what it covers.

---

## Cyber Security

### CISSP
- `Cyber Security/CISSP/CISSP - Index.md` — top-level map of all 8 CISSP domains; only Domain 5 has notes
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` — Domain 5 MOC and reading path

### IAM Fundamentals
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/IAM-Overview.md` — what IAM is and how the stack fits together
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-LDAP-Fundamentals.md` — Active Directory and LDAP basics; group types, memberOf, ADUC
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/AD-Domain-Forest-Trusts.md` — domain topology, forest trusts, group scope rules
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Authentication-Factors-MFA.md` — MFA types and authentication factors
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/OAuth2-OIDC.md` — OAuth2 and OpenID Connect protocols
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Access-Control-Models.md` — DAC, MAC, RBAC, ABAC models
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Physical-vs-Logical-Access.md` — physical vs logical access controls
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/IAM Fundamentals/Privilege-Escalation-Service-Accounts.md` — privilege escalation paths and service account risks

### SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` — business context for IIQ: identity cube, aggregation, entitlements, roles, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ.md` — complete spt_* schema reference; all tables, columns, joins
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Field-Values.md` — status codes, type enumerations, flag values for all tables
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Data-Flows.md` — step-by-step flows: aggregation, refresh, JML, requests, certifications
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md` — how IIQ connects to AD; aggregation types, delta/DirSync, connector gap
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Analyst-Playbook.md` — 60+ SQL recipes for common business questions
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/AD-Groups-in-IIQ-Governance.md` — how AD groups become governed entitlements in IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/CyberArk-IIQ-Integration.md` — three integration patterns between CyberArk PAM and SailPoint IIQ
- `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/PrivilegedA-Account-Data-Queries.md` — MySQL queries for PRIV_*_A privileged accounts

---

## Statistics

- `Statistics/Statistics.md` — top-level MOC for all statistics topics
- `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` — method selection guide: DiD, matching, RDD, synthetic control
- `Statistics/Causal Inference/Causal Inference.md` — entry point to 25-chapter causal inference study notes
- `Statistics/AB Testing/AB Testing fundamental.md` — A/B testing fundamentals
- `Statistics/Statistical thinking.md` — statistical thinking principles
- `Statistics/Causal Inference/_Source/` — raw imported Python Causality Handbook; not authoritative

---

## Deep Learning

- `Deep Learning/Deep Learning.md` — domain MOC; all subfields and entry points
- `Deep Learning/NLP/NLP.md` — NLP entry point; most developed subfield in this vault
- `Deep Learning/NLP/LLMOps/LLMOps.md` — LLM operations and deployment
- `Deep Learning/NLP/LLMs/Building Production-Grade LLM apps.md` — production LLM application patterns
- `Deep Learning/NLP/LLMs/Multi-Agent LLMs.md` — multi-agent LLM architectures
- `Deep Learning/Foundations/Loss function.md` — loss functions overview
- `Deep Learning/Computer Vision/Generate Image.md` — image generation entry point
- `Deep Learning/XAI/Trustworthy and Explainable AI.md` — XAI and model interpretability
- `Deep Learning/GNN/Advanced GNN.md` — graph neural networks
- `Deep Learning/Open Source/HuggingFace open source.md` — HuggingFace ecosystem

---

## Machine Learning

- `Machine Learning/Machine Learning.md` — domain MOC; clustering and regression
- `Machine Learning/Clustering algorithm/Clustering Algorithm.md` — clustering methods
- `Machine Learning/Regression algorithm/Regression Algorithm.md` — regression methods

---

## Finance

- `Finance/Finance.md` — domain MOC; corporate finance and bank management
- `Finance/Corporate Finance.md` — corporate finance section index
- `Finance/Bank Management and Strategy.md` — bank management section index

---

## Projects

- `Projects/Project List.md` — project registry with status and next actions
- `Projects/Causal IAM Risk Analytics.md` — causal analysis of IAM risk (Idea/MVP)
- `Projects/Fraud Detection using ML.md` — fraud detection project (Draft)
- `Projects/Neural Style Transfer.md` — neural style transfer (Active)

---

## Playbooks

- `Playbooks/Start a New Project.md` — steps to initialize a new project in this vault
- `Playbooks/Causal Analysis Checklist.md` — method selection and data readiness for causal inference
- `Playbooks/Evaluate a Dataset.md` — dataset assessment before starting analysis

codex
The README says causal inference should route through the domain map and that `_Source/` material is imported reference, not the owner’s final view. I’m opening the causal inference map next and will follow its Synthetic Control pointer.
exec
/bin/bash -lc "sed -n '1,260p' 'Statistics/Causal Inference/Causal Inference - Knowledge Map.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: ["causal-inference", "statistics", "knowledge-map", "method-selection"]
aliases: ["Causal Inference Knowledge Map", "Causal Method Map", "Causal Discovery Map"]
source: https://github.com/matheusfacure/python-causality-handbook
source_commit: 3e974d311a415d795a81b4657d524f3ccba4e9fe
---

# Causal Inference - Knowledge Map

This map connects the imported handbook chapters into a working mental model for choosing methods, checking assumptions, and discovering follow-up ideas.

## Method Selection

| Problem shape | Consider | Notes |
|---|---|---|
| Clean randomized assignment | Randomized experiments | [[02 - Randomised Experiments]] |
| Observed confounders, no hidden confounding | Regression, matching, propensity score, doubly robust estimation | [[05 - The Unreasonable Effectiveness of Linear Regression]], [[10 - Matching]], [[11 - Propensity Score]], [[12 - Doubly Robust Estimation]] |
| Hidden confounding but valid instrument | Instrumental variables / LATE | [[08 - Instrumental Variables]], [[09 - Non Compliance and LATE]] |
| Panel data with treated and control groups | Difference-in-differences / fixed effects | [[13 - Difference-in-Differences]], [[14 - Panel Data and Fixed Effects]] |
| One treated unit and weighted control pool | Synthetic control | [[15 - Synthetic Control]] |
| Treatment changes sharply at a threshold | Regression discontinuity | [[16 - Regression Discontinuity Design]] |
| Treatment effects vary across units | HTE, meta-learners, DML | [[18 - Heterogeneous Treatment Effects and Personalization]], [[21 - Meta Learners]], [[22 - Debiased Orthogonal Machine Learning]] |

## Assumption Map

| Assumption | What it protects against | Typical methods |
|---|---|---|
| Exchangeability / unconfoundedness | Treated and untreated units differ in ways that also affect the outcome | Regression, matching, propensity score, doubly robust methods |
| Overlap / positivity | Some groups have no comparable treated or untreated observations | Matching, propensity score trimming, design restriction |
| Exclusion restriction | Instrument affects outcome through channels other than treatment | Instrumental variables |
| Parallel trends | Treated and control groups would not have followed comparable paths without treatment | Difference-in-differences |
| Continuity around cutoff | Units just above and below a threshold are not comparable | Regression discontinuity |
| No interference / SUTVA | One unit's treatment changes another unit's outcome | Most potential-outcomes estimators |

## Discovery Questions

- What is the intervention, not just the prediction target?
- Which counterfactual is missing?
- What assumption identifies that counterfactual?
- Which observed pattern would falsify or weaken the assumption?
- Which method gives the clearest story to a skeptical reader?
- Where can machine learning improve nuisance estimation without replacing identification?

## Imported Chapter Links

- [[01 - Introduction To Causality]]
- [[02 - Randomised Experiments]]
- [[03 - Stats Review The Most Dangerous Equation]]
- [[04 - Graphical Causal Models]]
- [[05 - The Unreasonable Effectiveness of Linear Regression]]
- [[06 - Grouped and Dummy Regression]]
- [[07 - Beyond Confounders]]
- [[08 - Instrumental Variables]]
- [[09 - Non Compliance and LATE]]
- [[10 - Matching]]
- [[11 - Propensity Score]]
- [[12 - Doubly Robust Estimation]]
- [[13 - Difference-in-Differences]]
- [[14 - Panel Data and Fixed Effects]]
- [[15 - Synthetic Control]]
- [[16 - Regression Discontinuity Design]]
- [[17 - Predictive Models 101]]
- [[18 - Heterogeneous Treatment Effects and Personalization]]
- [[19 - Evaluating Causal Models]]
- [[20 - Plug-and-Play Estimators]]
- [[21 - Meta Learners]]
- [[22 - Debiased Orthogonal Machine Learning]]
- [[23 - Challenges with Effect Heterogeneity and Nonlinearity]]
- [[24 - The Difference-in-Differences Saga]]
- [[25 - Synthetic Difference-in-Differences]]
- [[A01 - Debiasing with Orthogonalization]]
- [[A02 - Debiasing with Propensity Score]]
- [[A03 - When Prediction Fails]]
- [[A04 - Why Prediction Metrics are Dangerous For Causal Models]]
- [[A05 - Conformal Inference for Synthetic Controls]]

## Source

- Website: https://matheusfacure.github.io/python-causality-handbook
- GitHub: https://github.com/matheusfacure/python-causality-handbook
- Imported commit: `3e974d311a415d795a81b4657d524f3ccba4e9fe`
- License: MIT License, Copyright (c) 2020 Matheus Facure.

## Related

- [[Causal Inference]] - main index for the imported handbook.
- [[Statistical thinking]] - statistical primitives used across causal inference.
- [[AB Testing fundamental]] - experimental baseline for causal identification.
- [[Machine Learning]] - predictive modeling context for heterogeneous treatment effect methods.

codex
The map points Synthetic Control to `[[15 - Synthetic Control]]` under the imported chapter links, and its frontmatter/source section ties that map to the Python Causality Handbook. I’m resolving the wikilink directly rather than doing a broad vault scan.
exec
/bin/bash -lc "sed -n '1,260p' 'Statistics/Causal Inference/15 - Synthetic Control.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: ["causal-inference", "statistics", "python-causality-handbook", "part-i--the-yang"]
aliases: ["Synthetic Control", "Causal Inference - Synthetic Control"]
source: https://github.com/matheusfacure/python-causality-handbook/blob/master/causal-inference-for-the-brave-and-true/15-Synthetic-Control.ipynb
source_commit: 3e974d311a415d795a81b4657d524f3ccba4e9fe
---
# Synthetic Control

When we looked at difference-in-difference, we had data on multiple customers from 2 different cities: Porto Alegre and Florianopolis. The data span 2 different time periods: before and after a marketing intervention was done in Porto Alegre to boost customer deposits. To estimate the treatment effect, we ran a regression that gave us the difference-in-difference estimator and its standard error.

> [!note] Source framing
> This note was generated from Matheus Facure's MIT-licensed *Causal Inference for the Brave and True*. The section structure below reframes the chapter for this Obsidian vault, while the source-derived notes preserve the converted chapter content.

## Why This Exists

This chapter exists to solve one practical causal inference problem in the handbook's reading path: how to move from statistical association toward a defensible causal claim. Read it as part of the sequence in [[Causal Inference]] rather than as an isolated formula sheet.

## Core Idea

- Source part: Part I - The Yang
- Source chapter file: `15-Synthetic-Control.ipynb`
- Main concepts detected:
- [[Average Treatment Effect]]
- [[Average Treatment on the Treated]]
- [[Potential Outcomes]]
- [[LATE]]
- [[Difference in Differences]]
- [[Synthetic Control]]

## Method / Mechanics

Use the source-derived notes below for the detailed derivation, examples, and Python code. When turning this into an applied workflow, identify:
- the causal question;
- the treatment, outcome, unit, and time index;
- the identification assumption;
- the estimator;
- the diagnostic or falsification check;
- the failure mode that would invalidate the result.

## Assumptions

- No explicit assumption keywords were detected automatically; review the source-derived notes.

## Failure Modes

- Confusing prediction quality with causal identification.
- Treating adjustment, matching, or machine learning as a substitute for a credible research design.
- Ignoring overlap, data leakage, time ordering, or hidden confounding.
- Reporting one estimate without the assumption that makes it interpretable.

## Python / Implementation Notes

The imported source keeps Python code blocks and notebook outputs where conversion could preserve them. Treat the code as educational reference, then adapt it to project-specific data validation, reproducibility, and experiment tracking before using it in production analysis.

## Connections

- [[Statistical thinking]] - background for estimates, uncertainty, and comparisons.
- [[AB Testing fundamental]] - randomized experiment intuition.
- [[Machine Learning]] - predictive modeling context for Part II methods.
- [[Causal Inference - Knowledge Map]] - method selection and concept relationships.

## Source

- Web page: https://matheusfacure.github.io/python-causality-handbook/15-Synthetic-Control.html
- GitHub source: https://github.com/matheusfacure/python-causality-handbook/blob/master/causal-inference-for-the-brave-and-true/15-Synthetic-Control.ipynb
- Source commit: `3e974d311a415d795a81b4657d524f3ccba4e9fe`
- Raw converted mirror: [[15-Synthetic-Control]]
- License: MIT License, Copyright (c) 2020 Matheus Facure.

## Source-Derived Notes

## One Amazing Math Trick to Learn What can’t be Known

When we looked at difference-in-difference, we had data on multiple customers from 2 different cities: Porto Alegre and Florianopolis. The data span 2 different time periods: before and after a marketing intervention was done in Porto Alegre to boost customer deposits. To estimate the treatment effect, we ran a regression that gave us the difference-in-difference estimator and its standard error. 

For that case, we had a lot of samples, because data was disaggregated. But what if all we have is aggregated data on the city level? For instance, let's pretend all we have is the average level of deposits in both cities before and after the intervention.

|city|before|after|
|--|--|--|
|FL|171.64|206.16|
|POA|46.01|87.06|

We would still be able to compute the Diff-in-Diff estimator 

$
(E[Y(1)|D=1] - E[Y(1)|D=0]) - (E[Y(0)|D=1] - E[Y(0)|D=0]) = (87.06 - 206.16) - (46.01 - 171.64) = 6.53
$

However, note that the sample size here is 4, which is also the number of parameters in our Diff-in-Diff models. In this case, the standard error is not well defined, so what should we do? Another problem is that Florianopolis might not be as similar to Porto Alegre as we would want to. For instance, Florianopolis is known for its beautiful beaches and easy going people while Porto Alegre is more famous for its barbecue and prairies. The problem here is that you can't ever know for sure if you are using an appropriate control group. 

To work around this, we will use what is known as [**"the most important innovation in the policy evaluation literature in the last few years"**](https://www.aeaweb.org/articles?id=10.1257/jep.31.2.3), Synthetic Controls. It is based on a simple, yet powerful idea. We don't need to find any single unit in the untreated that is very similar to the treated. Instead, we can forge our own as a combination of multiple untreated units, creating what is effectively a synthetic control. Synthetic control is so effective yet so intuitive that it even got an article published, not on a scientific journal, but on the [Washington Post](https://www.washingtonpost.com/news/wonk/wp/2015/10/30/how-to-measure-things-in-a-world-of-competing-claims/).

```python
import warnings
warnings.filterwarnings('ignore')

import pandas as pd
import numpy as np
from matplotlib import style
from matplotlib import pyplot as plt
import seaborn as sns
import statsmodels.formula.api as smf

%matplotlib inline

pd.set_option("display.max_columns", 6)
style.use("fivethirtyeight")
```

To see it in action, consider the problem of estimating the effect of cigarette taxation on its consumption. To give a bit of context, this is a question that had been debated for a long time in economics. One side of the argument says that taxes will increase the cost of cigars, which will lower its demand. The other side argues that since cigarettes cause addiction, change in their price won't change their demand by much. In economic terms, we would say that the demand for cigarettes is inelastic on price, and an increase in taxation is just a way to increase government income at the cost of smokers. To settle things, we will look at some US data regarding the matter.

In 1988, California passed a famous Tobacco Tax and Health Protection Act, which became known as [Proposition 99](https://en.wikipedia.org/wiki/1988_California_Proposition_99). "Its primary effect is to impose a 25-cent per pack state excise tax on the sale of tobacco cigarettes within California, with approximately equivalent excise taxes similarly imposed on the retail sale of other commercial tobacco products, such as cigars and chewing tobacco. Additional restrictions placed on the sale of tobacco include a ban on cigarette vending machines in public areas accessible by juveniles, and a ban on the individual sale of single cigarettes. Revenue generated by the act was earmarked for various environmental and health care programs, and anti-tobacco advertisements." 

To evaluate its effect, we can gather data on cigarette sales from multiple states and across a number of years. In our case, we got data from the year 1970 to 2000 from 39 states. Other states had similar Tobacco control programs and were dropped from the analysis. Here is what our data looks like.

```python
cigar = (pd.read_csv("Statistics/Causal%20Inference/_Source/Python%20Causality%20Handbook/data/smoking.csv")
         .drop(columns=["lnincome","beer", "age15to24"]))

cigar.query("california").head()
```

```text
    state  year     cigsale   retprice  california  after_treatment
62      3  1970  123.000000  38.799999        True            False
63      3  1971  121.000000  39.700001        True            False
64      3  1972  123.500000  39.900002        True            False
65      3  1973  124.400002  39.900002        True            False
66      3  1974  126.699997  41.900002        True            False
```

We have `state` as the state index, where California is the number 3. Our covariates are `retprice`, the cigarette retail price, and `cigsale`, the per-capita sales of cigarettes in packs. Our outcome variable of interest is `cigsale`. Finally, we have boolean helper variables to signal the state of California and the post intervention period. If we plot the sales of cigarettes for California and other states across time, this is what we would get.

```python
ax = plt.subplot(1, 1, 1)

(cigar
 .assign(california = np.where(cigar["california"], "California", "Other States"))
 .groupby(["year", "california"])
 ["cigsale"]
 .mean()
 .reset_index()
 .pivot("year", "california", "cigsale")
 .plot(ax=ax, figsize=(10,5)))

plt.vlines(x=1988, ymin=40, ymax=140, linestyle=":", lw=2, label="Proposition 99")
plt.ylabel("Cigarette Sales Trend")
plt.title("Gap in per-capita cigarette sales (in packs)")
plt.legend();
```

![[Statistics/Causal Inference/_Source/Python Causality Handbook/assets/15-Synthetic-Control/cell-005-output-00.png]]

During the time for which we have data, people in California apparently bought less cigarettes than the national average. Also, it appears to be a decreasing movement in cigarette consumption after the 80s. It looks like after Proposition 99 the decreasing trend accelerated for California, compared to other states, but we can't say that for sure. It is just a guess that we have by examining the plot. 

To answer the question of whether Proposition 99 had an effect on cigarette consumption, we will use the pre-intervention period to build a synthetic control. We will combine the other states to **build a fake state that resembles very closely the trend of California**. Then, we will see how this synthetic control behaves after the intervention. 

## We have Time

To make matters a little bit more formal, suppose that we have $J+1$ units. Without loss of generality, assume that unit 1 is the unit that gets affected by an intervention. Units $j=2,...,J+1$ are a collection of untreated units that we will refer to as the "donor pool". Also assume that the data we have span T time periods, with $T_0$ periods before the intervention. For each unit j and each time t, we observe the outcome $Y_{jt}$. For each unit j and period t, define $Y^N_{jt}$ as the potential outcome without intervention and $Y^I_{jt}$, the potential outcome with intervention. Then, the effect for the treated unit $j=1$ at time t, for $t>T_0$ is defined as 

$
\tau_{1t} = Y^I_{1t} - Y^N_{1t}
$

Since unit $j=1$ is the treated one, $Y^I_{1t}$ is factual but $Y^N_{1t}$ is not. The challenge then becomes how do we estimate $Y^N_{1t}$. Notice how the treatment effect is defined for each period, which means it can change in time. It doesn't need to be instantaneous. It can accumulate or dissipate. To put it in a picture, the problem of estimating the treatment effect boils down to the problem of **estimating what would have happened to the outcome of unit $j=1$ if it had not been treated**.

![img](Statistics/Causal%20Inference/_Source/Python%20Causality%20Handbook/data/img/synth-control/synth_img.png)

To estimate $Y^N_{1t}$, we remember that a combination of units in the donor pool may approximate the characteristics of the treated unit much better than any untreated unit alone. Thus, a synthetic control is defined as a weighted average of the units in the control pool. Given the weights $\pmb{W}=(w_2, ..., w_{J+1})$, the synthetic control estimate of $Y^N_{1t}$ is

$
\hat{Y}^N_{1t} = \sum^{J+1}_{j=2} w_j Y_{jt}
$

If all this math makes your head hurt, you are not alone. But don't worry, we have lots of examples to make it more intuitive. For once, I like to think about synthetic control as an upside down way of doing regression. As we know, linear regression is also a way of getting the prediction as a weighted average of the variables. Now, think about those regressions like the one in the diff-in-diff example where each variable is a dummy for a time period. In this case, regression can be represented as the following matrix multiplication

![img](Statistics/Causal%20Inference/_Source/Python%20Causality%20Handbook/data/img/synth-control/regr_time.png)

On the synthetic control case, we don't have lots of units, but we do have lots of time periods. So what we do is flip the input matrix around. Then, the units become the "variables" and we represent the outcome as a weighted average of the units, like in the following matrix multiplication.

![img](Statistics/Causal%20Inference/_Source/Python%20Causality%20Handbook/data/img/synth-control/regr_space.png)

If we have more than one feature per time period, we can pile up the features like this. The important thing is to make it so that the regression is trying to "predict" the treated unit 1 by using the other units. This way, we can choose the weights in some optimal way to achieve this proximity we want. We can even scale features differently to give different importance to them.

![img](Statistics/Causal%20Inference/_Source/Python%20Causality%20Handbook/data/img/synth-control/regr_space_x.png)

So, if synthetic control can be viewed as a linear regression, it also means that we can estimate its weights with OLS right? Yup! In fact, let's do this now.

## Synthetic Control as Linear Regression

![img](Statistics/Causal%20Inference/_Source/Python%20Causality%20Handbook/data/img/synth-control/allways.png)

To estimate the treatment effect with synthetic control, we will try to build a "fake unit" that resembles the treated unit before the intervention period. Then, we will see how this "fake unit" behaves after the intervention. The difference between the synthetic control and the unit that it mimics is the treatment effect.

To do this with linear regression, we will find the weight using OLS. We will minimise the square distance between the weighted average of the units in the donor pool and the treated unit for the pre-intervention period.

To do so, the first thing we need is to convert the units (in our case, the states) into the columns and the time into the rows. Since we have 2 features, `cigsale` and `retprice`, we will pile them on top of each other like we did in the picture above. We will build a synthetic control that looks a lot like California in the pre intervention period and see how it would behave in the post intervention period. For this reason, it is important that we select only the pre-intervention period. Here, the features seem to be on a similar scale, so we won't do anything to them. If features are in different scales, one in the thousands and another in the decimals, the bigger feature will be the most important when minimizing the difference. To avoid this, it's important to scale them first.

```python
features = ["cigsale", "retprice"]

inverted = (cigar.query("~after_treatment") # filter pre-intervention period
            .pivot(index='state', columns="year")[features] # make one column per year and one row per state
            .T) # flip the table to have one column per state

inverted.head()
```

```text
state                 1           2           3   ...          37          38  \
        year                                      ...                           
cigsale 1970   89.800003  100.300003  123.000000  ...  114.500000  106.400002   
        1971   95.400002  104.099998  121.000000  ...  111.500000  105.400002   
        1972  101.099998  103.900002  123.500000  ...  117.500000  108.800003   
        1973  102.900002  108.000000  124.400002  ...  116.599998  109.500000   
        1974  108.199997  109.699997  126.699997  ...  119.900002  111.800003   

state                 39  
        year              
cigsale 1970  132.199997  
        1971  131.699997  
        1972  140.000000  
        1973  141.199997  
        1974  145.800003  

[5 rows x 39 columns]
```

Now, we can define our Y variable as the state of California and the X as the other states.

```python
y = inverted[3].values # state of california
X = inverted.drop(columns=3).values  # other states
```

Then, we run a regression. Having an intercept is equivalent to adding another state where every row is 1. You can do that, but I think it's more complicated and I'll just leave it out. The regression will return the set of weights that minimize the square difference between the treated unit and the units in the donor pool.

```python
from sklearn.linear_model import LinearRegression
weights_lr = LinearRegression(fit_intercept=False).fit(X, y).coef_
weights_lr.round(3)
```

```text
array([-0.436, -1.038,  0.679,  0.078,  0.339,  1.213,  0.143,  0.555,
       -0.295,  0.052, -0.529,  1.235, -0.549,  0.437, -0.023, -0.266,
       -0.25 , -0.667, -0.106, -0.145,  0.109,  0.242, -0.328,  0.594,
        0.243, -0.171, -0.02 ,  0.14 , -0.811,  0.362,  0.519, -0.304,
        0.805, -0.318, -1.246,  0.773, -0.055, -0.032])
```

These weights show us how to build the synthetic control. We will multiply the outcome of state 1 by -0.436, of state 2 by -1.038, of state 4 by 0.679 and so on. We can achieve this with a dot product between the matrix from the states in the pool and the weights.

```python
calif_synth_lr = (cigar.query("~california")
                  .pivot(index='year', columns="state")["cigsale"]
                  .values.dot(weights_lr))
```


exec
/bin/bash -lc "sed -n '260,620p' 'Statistics/Causal Inference/15 - Synthetic Control.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:

Now that we have our synthetic control, we can plot it with the outcome variable of the State of California.

```python
plt.figure(figsize=(10,6))
plt.plot(cigar.query("california")["year"], cigar.query("california")["cigsale"], label="California")
plt.plot(cigar.query("california")["year"], calif_synth_lr, label="Synthetic Control")
plt.vlines(x=1988, ymin=40, ymax=140, linestyle=":", lw=2, label="Proposition 99")
plt.ylabel("Gap in per-capita cigarette sales (in packs)")
plt.legend();
```

![[Statistics/Causal Inference/_Source/Python Causality Handbook/assets/15-Synthetic-Control/cell-015-output-00.png]]

OK… Something seems off. What grabs your attention in this picture? First, after the intervention, the synthetic control has more cigarette sales than California. This is an indicative that the intervention was successful in lowering cigarette demand. Second, notice how the pre-intervention period is fitted perfectly. The synthetic control is able to match the state of California exactly. This is a sign that our synthetic control model is probably overfitting the data. Another sign is the huge variance on the outcome variable of the synthetic control after the intervention. Notice how it doesnt follow smooth patterns. Instead, it goes up and down and up and down. 

![img](Statistics/Causal%20Inference/_Source/Python%20Causality%20Handbook/data/img/synth-control/out-of-sample.png)

If we think about why this is happening, remember that we have 38 states in our donor pool. So our linear regression has 38 parameters to play with in order to make the pretreatment pool match the treatment as close as it can. This is the case where, even if T is large, N is also large, which gives too much flexibility to our linear regression model. If you are familiar with regularized models, know that you could use Ridge or Lasso regression to fix this. Here, we will look at another more traditional way to avoid overfitting.

## Don't Extrapolate

Suppose you have data like in this table below and are asked to build a synthetic control to reproduce the treated unit using any linear combination of the control units.

|unit|sales|price|
|--|--|--|
|control 1|8|8|
|control 2|8|4|
|control 3|4|5|
|treated  |2|10|

Since there are 3 units and only 2 attributes to match, there are multiple exact solutions to this problem, but a nice one is multiplying the first control by 2.25, multiplying the second by -2 and adding both. Notice how the second multiplication creates a fake unit with sales of -16 and price of -8. This multiplication is extrapolating the control 2 unit to a region of the data that doesn't make a lot of sense, since negative price and sales are almost impossible. The first multiplication is also an extrapolation, since it takes the first unit to a region where sales and price are 18. These numbers are much higher than anything we have in our data, hence the extrapolation.

This is what regression is doing when we ask it to create a synthetic control. Extrapolation is not technically wrong, but it's dangerous in practice. We are making assumptions that the data we have never seen behaves like the data that we have. 

One way to play safer is to constrain our synthetic control to only do interpolation. To do so, we will restrict the weights to be positive and sum up to one. Now, the synthetic control will be a convex combination of the units in the donor pool. When doing interpolation, we will project the treated unit in the convex hull defined by the untreated unit, much like in the picture below.

![img](Statistics/Causal%20Inference/_Source/Python%20Causality%20Handbook/data/img/synth-control/extrapolation.png)

Notice two things here. First, interpolation won't be able to create a perfect match of the treated unit in this case. This is because the treated is the unit with the smallest number of sales and the highest price. Convex combinations can only replicate exactly features that are in between the control units. Another thing to notice is that interpolation is sparse. We will project the treated unit on a wall of the convex hull and this wall is defined only by a few units. For this reason, interpolation will assign weight zero to many of the units. 

This is the general idea, now let's formalize it a little bit. The synthetic control is still defined as 

$
\hat{Y}^N_{jt} = \sum^{J+1}_{j=2} w_j Y_{jt}
$

but now, we will use weights $\pmb{W}=(w_2, ..., w_{J+1})$ that minimises

$
||\pmb{X}_1 - \pmb{X}_0 \pmb{W}|| = \bigg(\sum^k_{h=1}v_h \bigg(X_{h1} - \sum^{J+1}_{j=2} w_j X_{hj} \bigg)^2 \bigg)^{\frac{1}{2}}
$

subject to the restriction that $w_2, ..., w_{J+1}$ are positive and sum to one. Notice that $v_h$ reflect the importance of each variable when minimising the difference between the treated and the synthetic control. Different $v$s would give different optimal weights. One way to choose $V$ is to make it so that each variable has mean zero and unit variance. A more complex way is to choose $V$ in such a way that variables that help to predict $Y$ better get higher importance. Since we want to keep the code simple, we will simply give the same importance for each variable.

To implement this, first, define the above loss function.

```python
from typing import List
from operator import add
from toolz import reduce, partial

def loss_w(W, X, y) -> float:
    return np.sqrt(np.mean((y - X.dot(W))**2))
```

Since we are using the same importance for every feature, we don't need to worry about $v$.

Now, to get the optimal weights, we will use the quadratic programming optimisation of scipy. We will constrain the weights to sum up to 1 with 

```python 
lambda x: np.sum(x) - 1
```

Also, we will set optimization bounds to be between 0 and 1.

```python
from scipy.optimize import fmin_slsqp

def get_w(X, y):

    w_start = [1/X.shape[1]]*X.shape[1]

    weights = fmin_slsqp(partial(loss_w, X=X, y=y),
                         np.array(w_start),
                         f_eqcons=lambda x: np.sum(x) - 1,
                         bounds=[(0.0, 1.0)]*len(w_start),
                         disp=False)
    return weights
```

With this implemented, let's get the weights that define the synthetic control

```python
calif_weights = get_w(X, y)
print("Sum:", calif_weights.sum())
np.round(calif_weights, 4)
```

```text
Sum: 1.000000000000424
```

```text
array([0.    , 0.    , 0.    , 0.0852, 0.    , 0.    , 0.    , 0.    ,
       0.    , 0.    , 0.    , 0.    , 0.    , 0.    , 0.    , 0.    ,
       0.    , 0.    , 0.    , 0.113 , 0.1051, 0.4566, 0.    , 0.    ,
       0.    , 0.    , 0.    , 0.    , 0.    , 0.    , 0.    , 0.    ,
       0.2401, 0.    , 0.    , 0.    , 0.    , 0.    ])
```

With this weight, we are multiplying states 1,2, and 3 by zero, state 4 by 0.0852 and
so on. Notice how the weights are sparse, exactly as we've predicted. Also, all weights sum to one and are between 0 and 1, satisfying our convex combination constraint.

Now, to get the synthetic control, we can multiply those weights by the states exactly as we did before with the regression weights.

```python
calif_synth = cigar.query("~california").pivot(index='year', columns="state")["cigsale"].values.dot(calif_weights)
```

If we plot the outcome of the synthetic control now, we get a much smoother trend. Also notice that, in the pre intervention period, the synthetic control doesn't reproduce the treated exactly anymore. This is a good sign, as it indicates that we are not overfitting.

```python
plt.figure(figsize=(10,6))
plt.plot(cigar.query("california")["year"], cigar.query("california")["cigsale"], label="California")
plt.plot(cigar.query("california")["year"], calif_synth, label="Synthetic Control")
plt.vlines(x=1988, ymin=40, ymax=140, linestyle=":", lw=2, label="Proposition 99")
plt.ylabel("Per-capita cigarette sales (in packs)")
plt.legend();
```

![[Statistics/Causal Inference/_Source/Python Causality Handbook/assets/15-Synthetic-Control/cell-025-output-00.png]]

With the synthetic control at hand, we can estimate the treatment effect as the gap between treated and the synthetic control outcomes.

$
\tau_{1t} = Y^I_{jt} - Y^N_{jt}
$

In our particular case, the effect gets bigger and bigger as time passes.

```python
plt.figure(figsize=(10,6))
plt.plot(cigar.query("california")["year"], cigar.query("california")["cigsale"] - calif_synth,
         label="California Effect")
plt.vlines(x=1988, ymin=-30, ymax=7, linestyle=":", lw=2, label="Proposition 99")
plt.hlines(y=0, xmin=1970, xmax=2000, lw=2)
plt.title("State - Synthetic Across Time")
plt.ylabel("Gap in per-capita cigarette sales (in packs)")
plt.legend();
```

![[Statistics/Causal Inference/_Source/Python Causality Handbook/assets/15-Synthetic-Control/cell-027-output-00.png]]

By the year 2000, it looks like Proposition 99 has reduced the sales in cigarettes by 25 packs. That is very cool and all, but something you might be asking yourself is: how can I know if this is statistically significant?

## Making Inference

Since our sample size is very small (39), we will have to be a bit smarter when figuring out if our result is statistically significant and not just due to random luck. Here, we will use the idea of Fisher's Exact Test. Its intuition is very simple. We permute the treated and control exhaustively. Since we only have one treated unit, this would mean that, for each unit, we pretend it is the treated while the others are the control. 

|iteration|1|2|...|39|
|----|-|-|-|-|
|1|treated|0|0|0|
|2|0|treated|0|0|
|...|0|0|0|0|0|0|
|39|0|0|0|treated|

In the end, we will have one synthetic control and effect estimates for each state. So what this does is it pretends that the treatment actually happened for another state, not California, and see what would have been the estimated effect for this treatment that didn't happen. Then, we see if the treatment in California is sufficiently larger when compared to the other fake treatment. The idea is that for states that weren't actually treated, once we pretend they were, we won't be able to find any significant treatment effect. 

To implement this, I've built this function that takes as input a state and estimate the synthetic control for that state. This function returns a data frame with one column for the state, one for the year, one for the outcome `cigsale` and the synthetic outcome for that state.

```python
def synthetic_control(state: int, data: pd.DataFrame) -> np.array:

    features = ["cigsale", "retprice"]

    inverted = (data.query("~after_treatment")
                .pivot(index='state', columns="year")[features]
                .T)

    y = inverted[state].values # treated
    X = inverted.drop(columns=state).values # donor pool

    weights = get_w(X, y)
    synthetic = (data.query(f"~(state=={state})")
                 .pivot(index='year', columns="state")["cigsale"]
                 .values.dot(weights))

    return (data
            .query(f"state=={state}")[["state", "year", "cigsale", "after_treatment"]]
            .assign(synthetic=synthetic))
```

Here is the result of it when we apply it to the first state.

```python
synthetic_control(1, cigar).head()
```

```text
   state  year     cigsale  after_treatment   synthetic
0      1  1970   89.800003            False   95.029419
1      1  1971   95.400002            False   99.118199
2      1  1972  101.099998            False  101.881329
3      1  1973  102.900002            False  103.938655
4      1  1974  108.199997            False  107.038474
```

To get the result for all the state, we parallelize the computation across 8 processes. If your computer has more or less cores, you can use a different number. This code will return a list of data frames like the one above.

```python
from joblib import Parallel, delayed

control_pool = cigar["state"].unique()

parallel_fn = delayed(partial(synthetic_control, data=cigar))

synthetic_states = Parallel(n_jobs=8)(parallel_fn(state) for state in control_pool)
```

```python
synthetic_states[0].head()
```

```text
   state  year     cigsale  after_treatment   synthetic
0      1  1970   89.800003            False   95.029419
1      1  1971   95.400002            False   99.118199
2      1  1972  101.099998            False  101.881329
3      1  1973  102.900002            False  103.938655
4      1  1974  108.199997            False  107.038474
```

With the synthetic control for all the states, we can estimate the gap between the synthetic and the true state for all states. For California, this is the treatment effect. For the other states, this is like a placebo effect, where we estimate the synthetic control treatment effect where the treatment didn't actually happen. If we plot all the placebo effects along with the California treatment effect, we get the following figure.

```python
plt.figure(figsize=(12,7))
for state in synthetic_states:
    plt.plot(state["year"], state["cigsale"] - state["synthetic"], color="C5",alpha=0.4)

plt.plot(cigar.query("california")["year"], cigar.query("california")["cigsale"] - calif_synth,
        label="California");

plt.vlines(x=1988, ymin=-50, ymax=120, linestyle=":", lw=2, label="Proposition 99")
plt.hlines(y=0, xmin=1970, xmax=2000, lw=3)
plt.ylabel("Gap in per-capita cigarette sales (in packs)")
plt.title("State - Synthetic Across Time")
plt.legend();
```

![[Statistics/Causal Inference/_Source/Python Causality Handbook/assets/15-Synthetic-Control/cell-036-output-00.png]]

Two aspects of this figure jump to the eyes. First, we can see that the variance after the intervention is higher than the variance before the intervention. This is expected, since the synthetic control is designed to minimize the difference in the pre-intervention period. Another interesting aspect is that there are some units we can't fit very well even in the pre-intervention period. This is also to be expected. For example, if some states have very high cigarette consumption, no convex combination of the other states will ever match them. 

Since those units are so poorly fit, it is a good idea to remove them from the analysis. One way to do it objectively is to set a threshold for pre-intervention error 

$
MSE = \frac{1}{N}\sum\bigg(Y_t - \hat{Y}^{Synth}_t\bigg)^2
$

and remove those units with high error. If we proceed like this and plot the same figure, this is what we get.

```python
def pre_treatment_error(state):
    pre_treat_error = (state.query("~after_treatment")["cigsale"] 
                       - state.query("~after_treatment")["synthetic"]) ** 2
    return pre_treat_error.mean()

plt.figure(figsize=(12,7))
for state in synthetic_states:

    # remove units with mean error above 80.
    if pre_treatment_error(state) < 80:
        plt.plot(state["year"], state["cigsale"] - state["synthetic"], color="C5",alpha=0.4)

plt.plot(cigar.query("california")["year"], cigar.query("california")["cigsale"] - calif_synth,
        label="California");

plt.vlines(x=1988, ymin=-50, ymax=120, linestyle=":", lw=2, label="Proposition 99")
plt.hlines(y=0, xmin=1970, xmax=2000, lw=3)
plt.ylabel("Gap in per-capita cigarette sales (in packs)")
plt.title("Distribution of Effects")
plt.title("State - Synthetic Across Time (Large Pre-Treatment Errors Removed)")
plt.legend();
```

![[Statistics/Causal Inference/_Source/Python Causality Handbook/assets/15-Synthetic-Control/cell-038-output-00.png]]

Removing the noise, we can see how extreme of a value is the effect in the state of California. This image shows us that if we pretend the treatment had happened to any other state, we would almost never get an effect so extreme as the one we got with California.

This picture alone is a form of inference, but we can also derive a P-value from these results. All we have to do is see how many times the effects that we've got is below the effect of California.

```python
calif_number = 3

effects = [state.query("year==2000").iloc[0]["cigsale"] - state.query("year==2000").iloc[0]["synthetic"]
           for state in synthetic_states
           if pre_treatment_error(state) < 80] # filter out noise

calif_effect = cigar.query("california & year==2000").iloc[0]["cigsale"] - calif_synth[-1] 

print("California Treatment Effect for the Year 2000:", calif_effect)
np.array(effects)
```

```text
California Treatment Effect for the Year 2000: -24.83015975607075
```

```text
array([  5.79715887,   0.89458999, -24.83015976,  -7.16628121,
       -10.92204855,  37.1164056 , -15.06971721,  -0.49805125,
       -18.45795062,  21.13366447,  12.57782745,  -1.47547826,
        10.49627373, -11.67012352,   4.29850832,   8.04811402,
        14.023224  ,   8.25002775,   0.32576354,  -8.40826871,
        -2.12402707,  -7.42865061,   2.96157551,  24.10478137,
         4.25211766, -17.75844568,   7.93334017,   2.81640128,
        12.64955962, -17.47677514, -25.16040949, -12.26469139,
        24.69067386,  10.36299584,  -8.59880329])
```

if we want to test the one sided hypothesis that the effect in California is below zero, we can estimate the P-value as the proportion of times the effect in California is bigger than all the estimated effects.

$
PV=\frac{1}{N}\sum \mathcal{1}\{\hat{\tau}_{Calif} > \hat{\tau}_j\}
$

As it turns out, the treatment effect for California in the year 2000 is -24.8, meaning that the intervention reduced the consumption of cigarettes by almost 25 packs. Out of all the other 34 placebo effects that we've estimated, only one is higher than the effect we found in California. So the p-value would be 1/35.

```python
np.mean(np.array(effects) < calif_effect)
```

```text
0.02857142857142857
```

Finally, we can show the distribution of effects just to get a sense of how extreme the value of the effect in California really is.

```python
_, bins, _ = plt.hist(effects, bins=20, color="C5", alpha=0.5);
plt.hist([calif_effect], bins=bins, color="C0", label="California")
plt.ylabel("Frquency")
plt.title("Distribution of Effects")
plt.legend();
```

![[Statistics/Causal Inference/_Source/Python Causality Handbook/assets/15-Synthetic-Control/cell-044-output-00.png]]

## Key Ideas

We've learned that if we only have aggregated level data on entities like cities or states, diff-in-diff won't allow us to do inference. Also, it has some other limitations, since it has to define a control unit and one single control unit might not be a very good representation of the counterfactual for the treated unit. 

To correct for that, we learned that we can build a synthetic control that combines multiple control units to make them resemble the treated unit. With this synthetic control, we were able to see what would have happened to our treated unit in the absence of a treatment. 

Finally, we saw how we could use Fisher's Exact Tests to do inference with synthetic control. Namely, we've pretended that the non-treated units were actually the treated and computed their effect. These were the placebo effects: the effects we would observe even without a treatment. We used these to see if the treatment effect we've estimated was statistically significant. 

## References

I like to think of this entire book as a tribute to Joshua Angrist, Alberto Abadie and Christopher Walters for their amazing Econometrics class. Most of the ideas here are taken from their classes at the American Economic Association. Watching them is what is keeping me sane during this tough year of 2020.
* [Cross-Section Econometrics](https://www.aeaweb.org/conference/cont-ed/2017-webcasts)

exec
/bin/bash -lc "sed -n '1,80p' 'Statistics/Causal Inference/15 - Synthetic Control.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: ["causal-inference", "statistics", "python-causality-handbook", "part-i--the-yang"]
aliases: ["Synthetic Control", "Causal Inference - Synthetic Control"]
source: https://github.com/matheusfacure/python-causality-handbook/blob/master/causal-inference-for-the-brave-and-true/15-Synthetic-Control.ipynb
source_commit: 3e974d311a415d795a81b4657d524f3ccba4e9fe
---
# Synthetic Control

When we looked at difference-in-difference, we had data on multiple customers from 2 different cities: Porto Alegre and Florianopolis. The data span 2 different time periods: before and after a marketing intervention was done in Porto Alegre to boost customer deposits. To estimate the treatment effect, we ran a regression that gave us the difference-in-difference estimator and its standard error.

> [!note] Source framing
> This note was generated from Matheus Facure's MIT-licensed *Causal Inference for the Brave and True*. The section structure below reframes the chapter for this Obsidian vault, while the source-derived notes preserve the converted chapter content.

## Why This Exists

This chapter exists to solve one practical causal inference problem in the handbook's reading path: how to move from statistical association toward a defensible causal claim. Read it as part of the sequence in [[Causal Inference]] rather than as an isolated formula sheet.

## Core Idea

- Source part: Part I - The Yang
- Source chapter file: `15-Synthetic-Control.ipynb`
- Main concepts detected:
- [[Average Treatment Effect]]
- [[Average Treatment on the Treated]]
- [[Potential Outcomes]]
- [[LATE]]
- [[Difference in Differences]]
- [[Synthetic Control]]

## Method / Mechanics

Use the source-derived notes below for the detailed derivation, examples, and Python code. When turning this into an applied workflow, identify:
- the causal question;
- the treatment, outcome, unit, and time index;
- the identification assumption;
- the estimator;
- the diagnostic or falsification check;
- the failure mode that would invalidate the result.

## Assumptions

- No explicit assumption keywords were detected automatically; review the source-derived notes.

## Failure Modes

- Confusing prediction quality with causal identification.
- Treating adjustment, matching, or machine learning as a substitute for a credible research design.
- Ignoring overlap, data leakage, time ordering, or hidden confounding.
- Reporting one estimate without the assumption that makes it interpretable.

## Python / Implementation Notes

The imported source keeps Python code blocks and notebook outputs where conversion could preserve them. Treat the code as educational reference, then adapt it to project-specific data validation, reproducibility, and experiment tracking before using it in production analysis.

## Connections

- [[Statistical thinking]] - background for estimates, uncertainty, and comparisons.
- [[AB Testing fundamental]] - randomized experiment intuition.
- [[Machine Learning]] - predictive modeling context for Part II methods.
- [[Causal Inference - Knowledge Map]] - method selection and concept relationships.

## Source

- Web page: https://matheusfacure.github.io/python-causality-handbook/15-Synthetic-Control.html
- GitHub source: https://github.com/matheusfacure/python-causality-handbook/blob/master/causal-inference-for-the-brave-and-true/15-Synthetic-Control.ipynb
- Source commit: `3e974d311a415d795a81b4657d524f3ccba4e9fe`
- Raw converted mirror: [[15-Synthetic-Control]]
- License: MIT License, Copyright (c) 2020 Matheus Facure.

## Source-Derived Notes

## One Amazing Math Trick to Learn What can’t be Known

When we looked at difference-in-difference, we had data on multiple customers from 2 different cities: Porto Alegre and Florianopolis. The data span 2 different time periods: before and after a marketing intervention was done in Porto Alegre to boost customer deposits. To estimate the treatment effect, we ran a regression that gave us the difference-in-difference estimator and its standard error. 

For that case, we had a lot of samples, because data was disaggregated. But what if all we have is aggregated data on the city level? For instance, let's pretend all we have is the average level of deposits in both cities before and after the intervention.

|city|before|after|
|--|--|--|
|FL|171.64|206.16|

exec
/bin/bash -lc "sed -n '/Don.t Extrapolate/=' 'Statistics/Causal Inference/15 - Synthetic Control.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
280

exec
/bin/bash -lc "sed -n '/This note was generated/=' 'Statistics/Causal Inference/15 - Synthetic Control.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
12

exec
/bin/bash -lc "sed -n '/No explicit assumption/=' 'Statistics/Causal Inference/15 - Synthetic Control.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
42

exec
/bin/bash -lc "sed -n '/positive and sum up to one/=' 'Statistics/Causal Inference/15 - Synthetic Control.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
295

exec
/bin/bash -lc "sed -n '/pre-intervention period/=' 'Statistics/Causal Inference/15 - Synthetic Control.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
156
196
198
203
274
512

exec
/bin/bash -lc "sed -n '/pre_treatment_error/=' 'Statistics/Causal Inference/15 - Synthetic Control.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
523
532
557

exec
/bin/bash -lc "sed -n '/placebo/=' 'Statistics/Causal Inference/15 - Synthetic Control.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
493
587
615

exec
/bin/bash -lc "sed -n '/Source Priority/=' README.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
30

exec
/bin/bash -lc "sed -n '/_Source\\/ folders contain raw imported material/=' README.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
exec
/bin/bash -lc "sed -n '/One treated unit and weighted control pool/=' 'Statistics/Causal Inference/Causal Inference - Knowledge Map.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
20

exec
/bin/bash -lc "sed -n '/source: https/=' 'Statistics/Causal Inference/Causal Inference - Knowledge Map.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
4

exec
/bin/bash -lc "sed -n '30,41p' README.md" in /home/nhatquang/Knowledge
 succeeded in 0ms:
## Source Priority

When multiple notes cover the same topic, prefer in this order:

1. **Project notes** (`Projects/`) — current applied context
2. **Domain index / MOC notes** — authoritative navigation layer
3. **Concept notes** — detailed topic explanations
4. **`_Source/` folders** — raw imported material, not the owner's final opinion

Do not treat `_Source/` content as advice or conclusions. It is reference material only.

---

exec
/bin/bash -lc "sed -n '1,24p' 'Statistics/Causal Inference/Causal Inference - Knowledge Map.md' && sed -n '55,70p' 'Statistics/Causal Inference/Causal Inference - Knowledge Map.md'" in /home/nhatquang/Knowledge
 succeeded in 0ms:
---
tags: ["causal-inference", "statistics", "knowledge-map", "method-selection"]
aliases: ["Causal Inference Knowledge Map", "Causal Method Map", "Causal Discovery Map"]
source: https://github.com/matheusfacure/python-causality-handbook
source_commit: 3e974d311a415d795a81b4657d524f3ccba4e9fe
---

# Causal Inference - Knowledge Map

This map connects the imported handbook chapters into a working mental model for choosing methods, checking assumptions, and discovering follow-up ideas.

## Method Selection

| Problem shape | Consider | Notes |
|---|---|---|
| Clean randomized assignment | Randomized experiments | [[02 - Randomised Experiments]] |
| Observed confounders, no hidden confounding | Regression, matching, propensity score, doubly robust estimation | [[05 - The Unreasonable Effectiveness of Linear Regression]], [[10 - Matching]], [[11 - Propensity Score]], [[12 - Doubly Robust Estimation]] |
| Hidden confounding but valid instrument | Instrumental variables / LATE | [[08 - Instrumental Variables]], [[09 - Non Compliance and LATE]] |
| Panel data with treated and control groups | Difference-in-differences / fixed effects | [[13 - Difference-in-Differences]], [[14 - Panel Data and Fixed Effects]] |
| One treated unit and weighted control pool | Synthetic control | [[15 - Synthetic Control]] |
| Treatment changes sharply at a threshold | Regression discontinuity | [[16 - Regression Discontinuity Design]] |
| Treatment effects vary across units | HTE, meta-learners, DML | [[18 - Heterogeneous Treatment Effects and Personalization]], [[21 - Meta Learners]], [[22 - Debiased Orthogonal Machine Learning]] |

## Assumption Map
- [[10 - Matching]]
- [[11 - Propensity Score]]
- [[12 - Doubly Robust Estimation]]
- [[13 - Difference-in-Differences]]
- [[14 - Panel Data and Fixed Effects]]
- [[15 - Synthetic Control]]
- [[16 - Regression Discontinuity Design]]
- [[17 - Predictive Models 101]]
- [[18 - Heterogeneous Treatment Effects and Personalization]]
- [[19 - Evaluating Causal Models]]
- [[20 - Plug-and-Play Estimators]]
- [[21 - Meta Learners]]
- [[22 - Debiased Orthogonal Machine Learning]]
- [[23 - Challenges with Effect Heterogeneity and Nonlinearity]]
- [[24 - The Difference-in-Differences Saga]]
- [[25 - Synthetic Difference-in-Differences]]

codex
The vault’s Synthetic Control material says the key assumption is that a weighted combination of untreated donor units can stand in for the treated unit’s missing no-treatment counterfactual. It is framed for “one treated unit and weighted control pool” in the causal inference map: [Causal Inference - Knowledge Map.md](/home/nhatquang/Knowledge/Statistics/Causal%20Inference/Causal%20Inference%20-%20Knowledge%20Map.md:20).

The detailed note is careful about the practical assumptions:

- Build the synthetic unit using only the pre-intervention period, then compare treated vs. synthetic after treatment.
- A good pre-treatment match is central because the method is trying to estimate what would have happened to the treated unit without treatment.
- Unconstrained regression weights can overfit and extrapolate into unrealistic regions.
- The safer version restricts donor weights to be nonnegative and sum to one, making the synthetic control a convex combination of untreated units: [15 - Synthetic Control.md](/home/nhatquang/Knowledge/Statistics/Causal%20Inference/15%20-%20Synthetic%20Control.md:280).
- Poor pre-treatment fit is a warning sign; the note uses pre-treatment error and placebo-style comparisons as diagnostics/inference checks: [15 - Synthetic Control.md](/home/nhatquang/Knowledge/Statistics/Causal%20Inference/15%20-%20Synthetic%20Control.md:523).

This is mostly **imported/source-derived material**, not purely the vault owner’s own original notes. The Synthetic Control note frontmatter points to Matheus Facure’s Python Causality Handbook, and the note explicitly says it was generated from that MIT-licensed source while reframed for the vault: [15 - Synthetic Control.md](/home/nhatquang/Knowledge/Statistics/Causal%20Inference/15%20-%20Synthetic%20Control.md:4), [15 - Synthetic Control.md](/home/nhatquang/Knowledge/Statistics/Causal%20Inference/15%20-%20Synthetic%20Control.md:12). The owner-added wrapper includes a method checklist and failure modes, but the substantive chapter content is labeled “Source-Derived Notes.”
tokens used
28,590
The vault’s Synthetic Control material says the key assumption is that a weighted combination of untreated donor units can stand in for the treated unit’s missing no-treatment counterfactual. It is framed for “one treated unit and weighted control pool” in the causal inference map: [Causal Inference - Knowledge Map.md](/home/nhatquang/Knowledge/Statistics/Causal%20Inference/Causal%20Inference%20-%20Knowledge%20Map.md:20).

The detailed note is careful about the practical assumptions:

- Build the synthetic unit using only the pre-intervention period, then compare treated vs. synthetic after treatment.
- A good pre-treatment match is central because the method is trying to estimate what would have happened to the treated unit without treatment.
- Unconstrained regression weights can overfit and extrapolate into unrealistic regions.
- The safer version restricts donor weights to be nonnegative and sum to one, making the synthetic control a convex combination of untreated units: [15 - Synthetic Control.md](/home/nhatquang/Knowledge/Statistics/Causal%20Inference/15%20-%20Synthetic%20Control.md:280).
- Poor pre-treatment fit is a warning sign; the note uses pre-treatment error and placebo-style comparisons as diagnostics/inference checks: [15 - Synthetic Control.md](/home/nhatquang/Knowledge/Statistics/Causal%20Inference/15%20-%20Synthetic%20Control.md:523).

This is mostly **imported/source-derived material**, not purely the vault owner’s own original notes. The Synthetic Control note frontmatter points to Matheus Facure’s Python Causality Handbook, and the note explicitly says it was generated from that MIT-licensed source while reframed for the vault: [15 - Synthetic Control.md](/home/nhatquang/Knowledge/Statistics/Causal%20Inference/15%20-%20Synthetic%20Control.md:4), [15 - Synthetic Control.md](/home/nhatquang/Knowledge/Statistics/Causal%20Inference/15%20-%20Synthetic%20Control.md:12). The owner-added wrapper includes a method checklist and failure modes, but the substantive chapter content is labeled “Source-Derived Notes.”

---

