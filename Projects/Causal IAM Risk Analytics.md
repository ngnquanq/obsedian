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
