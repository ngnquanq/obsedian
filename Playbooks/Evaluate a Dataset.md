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
