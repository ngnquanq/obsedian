---
tags: ["causal-inference", "statistics", "moc", "python-causality-handbook"]
aliases: ["Causal Inference", "Causal Inference for the Brave and True", "Python Causality Handbook"]
source: https://github.com/matheusfacure/python-causality-handbook
source_commit: 3e974d311a415d795a81b4657d524f3ccba4e9fe
---

# Causal Inference

This section imports and reframes Matheus Facure's MIT-licensed *Causal Inference for the Brave and True* into this Obsidian vault. The goal is not only to store the book, but to make the causal inference ideas discoverable through links, method maps, assumptions, and connections to statistics and machine learning notes.

## Why This Exists

Machine learning can predict what is likely to happen. Causal inference asks what would happen under an intervention. That difference matters when the question is "will this policy, treatment, email, price, or product change cause a different outcome?"

## Reading Path

- [[01 - Introduction To Causality]] - Part I - The Yang; source `01-Introduction-To-Causality.ipynb`
- [[02 - Randomised Experiments]] - Part I - The Yang; source `02-Randomised-Experiments.ipynb`
- [[03 - Stats Review The Most Dangerous Equation]] - Part I - The Yang; source `03-Stats-Review-The-Most-Dangerous-Equation.ipynb`
- [[04 - Graphical Causal Models]] - Part I - The Yang; source `04-Graphical-Causal-Models.ipynb`
- [[05 - The Unreasonable Effectiveness of Linear Regression]] - Part I - The Yang; source `05-The-Unreasonable-Effectiveness-of-Linear-Regression.ipynb`
- [[06 - Grouped and Dummy Regression]] - Part I - The Yang; source `06-Grouped-and-Dummy-Regression.ipynb`
- [[07 - Beyond Confounders]] - Part I - The Yang; source `07-Beyond-Confounders.ipynb`
- [[08 - Instrumental Variables]] - Part I - The Yang; source `08-Instrumental-Variables.ipynb`
- [[09 - Non Compliance and LATE]] - Part I - The Yang; source `09-Non-Compliance-and-LATE.ipynb`
- [[10 - Matching]] - Part I - The Yang; source `10-Matching.ipynb`
- [[11 - Propensity Score]] - Part I - The Yang; source `11-Propensity-Score.ipynb`
- [[12 - Doubly Robust Estimation]] - Part I - The Yang; source `12-Doubly-Robust-Estimation.ipynb`
- [[13 - Difference-in-Differences]] - Part I - The Yang; source `13-Difference-in-Differences.ipynb`
- [[14 - Panel Data and Fixed Effects]] - Part I - The Yang; source `14-Panel-Data-and-Fixed-Effects.ipynb`
- [[15 - Synthetic Control]] - Part I - The Yang; source `15-Synthetic-Control.ipynb`
- [[16 - Regression Discontinuity Design]] - Part I - The Yang; source `16-Regression-Discontinuity-Design.ipynb`
- [[17 - Predictive Models 101]] - Part II - The Yin; source `17-Predictive-Models-101.ipynb`
- [[18 - Heterogeneous Treatment Effects and Personalization]] - Part II - The Yin; source `18-Heterogeneous-Treatment-Effects-and-Personalization.ipynb`
- [[19 - Evaluating Causal Models]] - Part II - The Yin; source `19-Evaluating-Causal-Models.ipynb`
- [[20 - Plug-and-Play Estimators]] - Part II - The Yin; source `20-Plug-and-Play-Estimators.ipynb`
- [[21 - Meta Learners]] - Part II - The Yin; source `21-Meta-Learners.ipynb`
- [[22 - Debiased Orthogonal Machine Learning]] - Part II - The Yin; source `22-Debiased-Orthogonal-Machine-Learning.ipynb`
- [[23 - Challenges with Effect Heterogeneity and Nonlinearity]] - Part II - The Yin; source `23-Challenges-with-Effect-Heterogeneity-and-Nonlinearity.ipynb`
- [[24 - The Difference-in-Differences Saga]] - Part II - The Yin; source `24-The-Diff-in-Diff-Saga.ipynb`
- [[25 - Synthetic Difference-in-Differences]] - Part II - The Yin; source `25-Synthetic-Diff-in-Diff.ipynb`
- [[A01 - Debiasing with Orthogonalization]] - Appendix; source `Debiasing-with-Orthogonalization.ipynb`
- [[A02 - Debiasing with Propensity Score]] - Appendix; source `Debiasing-with-Propensity-Score.ipynb`
- [[A03 - When Prediction Fails]] - Appendix; source `When-Prediction-Fails.ipynb`
- [[A04 - Why Prediction Metrics are Dangerous For Causal Models]] - Appendix; source `Prediction-Metrics-For-Causal-Models.ipynb`
- [[A05 - Conformal Inference for Synthetic Controls]] - Appendix; source `Conformal-Inference-for-Synthetic-Control.ipynb`

## How To Use This Section

- Read Part I when the goal is identification: what assumption lets us interpret an estimate causally?
- Read Part II when the goal is heterogeneous effects, causal model evaluation, or machine-learning-assisted estimation.
- Use [[Causal Inference - Knowledge Map]] when choosing a method for a new problem.
- Check the `_Source/Python Causality Handbook` folder when you need provenance, raw converted Markdown, assets, datasets, or source commit metadata.

## Source

- Website: https://matheusfacure.github.io/python-causality-handbook
- GitHub: https://github.com/matheusfacure/python-causality-handbook
- Imported commit: `3e974d311a415d795a81b4657d524f3ccba4e9fe`
- License: MIT License, Copyright (c) 2020 Matheus Facure.

## Related

- [[Causal Inference - Knowledge Map]] - concept graph, method selection, and assumptions.
- [[Statistical thinking]] - statistical background for causal estimands and uncertainty.
- [[AB Testing fundamental]] - randomized experiment foundation.
- [[Machine Learning]] - predictive modeling background for Part II methods.
