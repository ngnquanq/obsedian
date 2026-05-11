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

- `Machine Learning/Machine Learning.md` — applied ML curriculum; prediction framing, learning paradigms, supervised learning, unsupervised learning, evaluation
- `Machine Learning/Foundations/Prediction as Conditional Expectation.md` — why supervised prediction is framed as estimating E[Y | X]
- `Machine Learning/Learning Paradigms/Learning Paradigms.md` — map of supervised, unsupervised, semi-supervised, self-supervised, and reinforcement learning
- `Machine Learning/Learning Paradigms/Semi-Supervised Learning.md` — overview of learning from labeled and unlabeled examples
- `Machine Learning/Learning Paradigms/Semi-Supervised Methods.md` — pseudo-labeling, consistency regularization, label propagation, and self-training
- `Machine Learning/Learning Paradigms/Semi-Supervised Evaluation.md` — evaluation design and failure modes for pseudo-label and unlabeled-data workflows
- `Machine Learning/Learning Paradigms/Self-Supervised Learning.md` — overview of representation learning from generated targets
- `Machine Learning/Learning Paradigms/Self-Supervised Methods.md` — masked prediction, contrastive learning, next-step prediction, and reconstruction
- `Machine Learning/Learning Paradigms/Self-Supervised Evaluation.md` — downstream evaluation, linear probes, fine-tuning, and transfer checks
- `Machine Learning/Learning Paradigms/Reinforcement Learning.md` — overview of policy learning from states, actions, and rewards
- `Machine Learning/Learning Paradigms/Reinforcement Learning Methods.md` — dynamic programming, temporal-difference learning, Q-learning, and policy gradients
- `Machine Learning/Learning Paradigms/Reinforcement Learning Evaluation.md` — simulator, offline, online, and guardrail evaluation for RL policies
- `Machine Learning/Regression algorithm/Regression Algorithm.md` — regression as supervised prediction for numeric targets
- `Machine Learning/Regression algorithm/Metrics.md` — regression error metrics and error analysis
- `Machine Learning/Clustering algorithm/Clustering Algorithm.md` — clustering as unsupervised structure discovery
- `Machine Learning/Clustering algorithm/Metrics.md` — internal and external clustering evaluation metrics

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
- `Projects/Local RAG Chatbot.md` — local classical-ML search chatbot over JSON documents, no LLM (Idea)

---

## Playbooks

- `Playbooks/Start a New Project.md` — steps to initialize a new project in this vault
- `Playbooks/Causal Analysis Checklist.md` — method selection and data readiness for causal inference
- `Playbooks/Evaluate a Dataset.md` — dataset assessment before starting analysis

---

## Vault Meta

- `Vault-Production-Roadmap.md` — roadmap for taking the vault to a production-grade knowledge hub; tracks retrieval, tool integration, guard-rails, and operational quality gaps
