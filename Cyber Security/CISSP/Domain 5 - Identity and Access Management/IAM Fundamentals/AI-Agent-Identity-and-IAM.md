---
tags: [ai-agent, agentic-ai, iam, non-human-identity, workload-identity, authorization, governance, provisioning, access-control, cissp, domain-5-iam, cissp/5.2-identification-authentication, cissp/5.4-authorization, cissp/5.5-provisioning-lifecycle]
aliases: [AI Agent Identity, Agentic IAM, Agent Access Management, Non-Human Agent Identity]
---

# AI Agent Identity and IAM — Governing Autonomous Digital Actors

Before treating AI agents as "just another service account," you need the core model from [[IAM-Overview|IAM]] and [[Privilege-Escalation-Service-Accounts|service account management]]. AI agents are non-human identities, but they add autonomy, tool use, memory, delegated action, and agent-to-agent communication that classic service-account controls do not fully cover.

> [!important] Exam framing
> This is an **emerging IAM addendum**, not a core CISSP objective today. Use it to understand where Domain 5 is going: AI agents still need identification, authentication, authorization, provisioning, access review, and accountability.

---

## Why AI Agent Identity Exists — The Problem It Solves

Imagine a company deploys 500 AI agents:
- a Finance agent reads invoices, queries the ERP, and drafts payment exceptions;
- an HR agent reads employee records and opens ServiceNow tickets;
- a Security agent queries SIEM logs and disables suspicious accounts;
- a Data agent queries production databases and sends summaries to business teams.

If those agents run under human accounts or shared service accounts, the organisation cannot reliably answer:
- which actions came from a human and which came from an agent;
- which human or team is accountable for each agent;
- whether the agent inherited broader permissions than its task requires;
- whether the agent retained memory, tokens, or data after the task ended.

**AI agent identity solves this by giving each agent a distinct, governable identity with scoped permissions, lifecycle ownership, and attributable audit trails.**

> [!tip] Mental model
> A service account is usually a predictable machine worker. An AI agent is closer to a junior employee with tools: it can interpret goals, choose actions, call systems, and make mistakes at machine speed.

---

## What an AI Agent Looks Like in IAM

An AI agent is an application-like actor that can reason over context, choose actions, and use tools to pursue a goal. Microsoft describes agents as systems that understand context, make decisions, and act autonomously using available tools; tools can include APIs, databases, file systems, web search, or software integrations.

```
Human user or business event
    │  asks for a goal
    ▼
AI agent identity
    │  receives scoped authority
    ▼
Tools and data systems
    │  API call, database query, ticket creation, email draft
    ▼
Audit trail
    │  records agent, sponsor, human requester, tool, data, and action
    ▼
Review / revoke / expire
```

### Agent identity vs. related identities

| Identity type | What it represents | Why it is not enough by itself |
|---|---|---|
| **Human identity** | A person with credentials, MFA, role, manager, and employment lifecycle | If an agent borrows it, logs blur human vs. agent action |
| **Service account** | A non-human account used by an application or scheduled task | Often static, long-lived, and broader than one agent task |
| **Workload identity** | A software workload such as a container, function, or service | Useful for runtime authentication, but may not capture agent sponsor, delegation, memory, or tool-level intent |
| **Application identity** | A registered application or service principal | Often designed for stable apps, not rapidly created and retired agents |
| **Agent identity** | A distinct account for an AI agent | Supports agent-specific policy, audit, lifecycle, sponsor, and revocation |

> [!note] Vendor-specific example
> Microsoft Entra Agent ID is currently documented as a preview capability. Microsoft describes an agent identity as a special identity construct for AI agents, with concepts such as identifier, sponsor, blueprint, token issuance, and agent-specific auditability. Other vendors may model this differently.

Source anchors:
- [Microsoft Entra — What are agent identities](https://learn.microsoft.com/en-us/entra/agent-id/what-are-agent-identities)
- [Microsoft Entra — Agent identities in Microsoft Entra Agent ID](https://learn.microsoft.com/en-us/entra/agent-id/agent-identities)
- [Microsoft Entra — Governing Agent Identities](https://learn.microsoft.com/en-us/entra/id-governance/agent-id-governance-overview)

---

## The Agentic IAM Stack

AI agents need the same IAM layers as humans and service accounts, but the enforcement points move closer to tools, prompts, memory, and data.

| Layer | Human IAM question | Agentic IAM question |
|---|---|---|
| **Identification** | Who is this user? | Which agent is acting, and which blueprint, sponsor, or owner created it? |
| **Authentication** | Did the user prove identity? | Did the agent receive a valid workload, agent, or delegated token? |
| **Authorization** | What can the user do? | Which tools, APIs, records, data classes, and actions can this agent use for this task? |
| **Governance** | Is access still appropriate? | Does this agent still need this permission, owner, memory, and tool binding? |
| **Audit** | What did the user do? | What did the agent do, for which human/request, using which tool and data? |

```
Policy: agent may summarize invoices, not approve payment
    │
    ▼
Agent receives task from Finance user
    │
    ▼
Authorization checks:
  - agent identity
  - human requester
  - tool allowlist
  - invoice data classification
  - action = read/summarize only
    │
    ▼
Allowed: query invoices and draft summary
Denied: submit payment approval
```

---

## Access Patterns for AI Agents

### 1. Autonomous agent access

The agent acts using permissions granted directly to the agent identity.

| Good fit | Risk |
|---|---|
| Scheduled monitoring, report generation, triage, reconciliation | Standing privilege can become invisible privilege if the agent is not reviewed |

Controls:
- unique agent identity;
- least-privilege tool permissions;
- short-lived tokens;
- clear owner or sponsor;
- automated expiry for unused agents.

### 2. Delegated user access

The agent acts on behalf of a human user, using a scoped delegation model. OAuth-style delegation is the mental model: the agent should receive only the scopes required for the task, not the user's entire effective access.

| Good fit | Risk |
|---|---|
| "Read my calendar and draft a meeting summary" | Agent inherits broad user access and performs actions the user did not intend |

Controls:
- explicit consent or approval;
- narrow scopes;
- visible "actor = agent, subject = user" audit trail;
- re-consent for sensitive actions;
- step-up approval before write/delete/submit actions.

### 3. Tool-mediated access

The agent does not receive direct database or application credentials. It calls tools that enforce policy.

```
Agent
  │ request: "query customer balance"
  ▼
Tool gateway / MCP server / API gateway
  │ checks: agent, user, purpose, data class, action
  ▼
Database or application
```

This is the safest pattern when the tool gateway acts as a [[Access-Control-Models#The PDP / PEP Architecture|PEP]] and consults policy before each action.

### 4. Agent-to-agent communication

One agent asks another agent to perform work. Without identity propagation, the downstream agent only sees "another service called me," not the original requester or business purpose.

Controls:
- signed requests or trusted tokens between agents;
- preserve original requester, agent chain, and purpose;
- deny privilege escalation through agent chaining;
- log the full chain, not just the final action.

---

## Risk Patterns Unique to Agentic IAM

| Risk | Why classic IAM misses it | Control |
|---|---|---|
| **Borrowed identity** | Logs show the human or service account, not the agent | Distinct agent identity and actor/subject audit fields |
| **Inherited permissions** | Agent receives everything the human or service account has | Delegated scopes and task-specific authorization |
| **Tool misuse** | Legitimate tools are chained into unintended outcomes | Tool allowlists, per-tool policy, approval gates |
| **Prompt or goal hijack** | Untrusted content changes what the agent tries to do | Separate instructions from data; constrain tools by policy, not prompt text |
| **Memory leakage** | Agent stores sensitive context beyond the task | Memory classification, retention, deletion, and review controls |
| **Agent sprawl** | Agents are created quickly and forgotten | Inventory, owner/sponsor, expiry, decommissioning workflow |
| **Blurry accountability** | No one owns the agent's behavior or access | Named sponsor, business owner, and access reviewer |

CSA reports that AI agents often operate in an "identity gray area," borrowing human or shared identities instead of being managed as distinct entities. CSA also highlights inherited permissions, fragmented ownership, unclear attribution, and the need for identity-centric controls, least privilege, and real-time visibility.

OWASP's Agentic Security Initiative frames agentic AI as autonomous systems whose expanded capabilities introduce new threats and require threat-model-based mitigations.

Source anchors:
- [CSA — Identity and Access Gaps in the Age of Autonomous AI](https://cloudsecurityalliance.org/artifacts/identity-and-access-gaps-in-the-age-of-autonomous-ai)
- [OWASP — Agentic AI Threats and Mitigations](https://genai.owasp.org/resource/agentic-ai-threats-and-mitigations/)
- [NIST AI RMF Generative AI Profile](https://www.nist.gov/publications/artificial-intelligence-risk-management-framework-generative-artificial-intelligence)

---

## Control Checklist for Agentic IAM

| Control | What to require |
|---|---|
| **Agent inventory** | Every production agent has an identity, purpose, owner, sponsor, and lifecycle state |
| **Identity separation** | Agent actions are distinguishable from human, service account, and workload actions |
| **Least privilege** | Permissions are scoped to the agent's task, tools, data class, and action type |
| **JIT access** | Sensitive access is granted only for the task window, then expires |
| **Tool allowlist** | Agent can use only approved tools; high-risk tools require approval |
| **Delegation boundary** | Acting for a human does not mean inheriting all human permissions |
| **Memory governance** | Agent memory is classified, retained, deleted, and reviewed like other data stores |
| **Approval gates** | Write, delete, submit, approve, transfer, or disable actions require stronger controls |
| **Audit chain** | Logs preserve agent identity, sponsor, human requester, tool, data, action, and result |
| **Kill switch** | Security can disable the agent, revoke tokens, remove tool grants, and quarantine memory |

> [!warning] Prompt instructions are not access control
> "Do not access payroll data" in a system prompt is not equivalent to an IAM policy. The agent should be technically unable to access payroll unless an authorization decision permits that action.

---

## How This Connects to Existing IAM Notes

AI agent IAM is not a replacement for the existing Domain 5 stack. It is the next place those controls must be applied.

| Existing note | Agentic extension |
|---|---|
| [[OAuth2-OIDC]] | Delegated scopes, short-lived tokens, actor/subject distinction |
| [[Access-Control-Models]] | ABAC and risk-based policies for tool, data, action, requester, and context |
| [[Privilege-Escalation-Service-Accounts]] | Non-human identity lifecycle, credential vaults, service secrets, and kill switches |
| [[IAM-Overview]] | Agents become another identity type in the IAM stack |
| [[IIQ-Concepts]] | Agents may need lifecycle governance, access reviews, and ownership just like people and service accounts |

```
Human IAM principle
    │
    ▼
Non-human identity control
    │
    ▼
Agent-specific enforcement:
  identity + sponsor + tool + memory + delegated purpose
    │
    ▼
Auditable autonomous action
```

> [!tip] Rule of thumb
> If an AI agent can read, write, approve, delete, transfer, disable, or trigger a workflow, treat it as an IAM subject with its own identity, not as a script hidden behind someone else's account.

---

## Related

- [[IAM-Overview]] — where agent identities fit in the broader IAM stack
- [[OAuth2-OIDC]] — delegated access, scopes, tokens, and actor/subject patterns used by agents
- [[Access-Control-Models]] — ABAC, risk-based access, PDP/PEP, and policy enforcement for tool use
- [[Privilege-Escalation-Service-Accounts]] — non-human identity risks, credential vaults, and service-account controls
- [[Authentication-Factors-MFA]] — credential lifecycle and authentication assurance concepts that still apply to agent platforms
- [[IIQ-Concepts]] — governance lifecycle concepts that can be extended to agent ownership and access reviews
- [[Domain 5 - IAM]] — Domain 5 map; this note is an emerging addendum, not current CISSP core
