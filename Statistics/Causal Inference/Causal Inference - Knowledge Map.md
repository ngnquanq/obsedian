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
