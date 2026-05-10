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
