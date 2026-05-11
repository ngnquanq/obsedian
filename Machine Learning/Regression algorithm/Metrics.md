---
status: active
type: reference
domain: machine-learning
updated: 2026-05-10
tags: [machine-learning, regression, metrics, evaluation]
aliases: [Regression Metrics, Regression Evaluation, Prediction Error Metrics]
---

# Regression Metrics

Regression metrics translate prediction errors into evidence about whether a model is useful. Read [[Machine Learning/Foundations/Prediction as Conditional Expectation|Prediction as Conditional Expectation]] first: once a model estimates $E[Y \mid X]$, metrics tell us how far its predictions are from observed $Y$.

---

## Why Regression Metrics Exist

A model that predicts customer value with an average error of 5 dollars may be excellent. The same average error for predicting daily revenue in millions may be irrelevant. Error only has meaning relative to the decision.

**Regression metrics solve this by summarizing prediction error in ways that can be compared across models and interpreted against business cost.**

---

## Core Metrics

| Metric | Formula | Best Use | Watch Out For |
|---|---|---|---|
| MAE | $\frac{1}{n}\sum_i \lvert y_i - \hat{y}_i \rvert$ | Typical absolute error in target units | Treats all errors linearly |
| MSE | $\frac{1}{n}\sum_i (y_i - \hat{y}_i)^2$ | Training objective and large-error penalty | Harder to interpret because units are squared |
| RMSE | $\sqrt{\frac{1}{n}\sum_i (y_i - \hat{y}_i)^2}$ | Error in target units, sensitive to large misses | Can be dominated by outliers |
| $R^2$ | $1 - \frac{SS_{res}}{SS_{tot}}$ | Share of variance explained vs a mean baseline | Can look good while decision errors remain bad |
| MAPE | $\frac{100}{n}\sum_i \left\lvert \frac{y_i - \hat{y}_i}{y_i} \right\rvert$ | Percent error for positive nonzero targets | Breaks near zero and can bias toward underprediction |

---

## Choosing a Metric

| If the Cost of Error Is... | Prefer |
|---|---|
| Same per unit of error | MAE |
| Much worse for large misses | RMSE or MSE |
| Easier to discuss as percentage | MAPE, only when $Y$ is safely away from zero |
| About ranking high-value cases | Ranking metrics or segment-level lift, not only MAE |
| About calibrated numeric estimates | Error plots, residual analysis, and calibration checks |

> [!tip] Rule of thumb
> Pick the metric that matches the decision cost first, then use secondary metrics to understand failure modes.

---

## Error Analysis

One aggregate metric is not enough. Always inspect error by:

- target range;
- important customer or product segment;
- time period;
- geography or operational region;
- cases near decision thresholds;
- outliers and high-cost errors.

This turns evaluation from "which model has the lowest score?" into "where is this model reliable enough to use?"

---

## Related

- [[Machine Learning]] — curriculum map for this section.
- [[Machine Learning/Foundations/Prediction as Conditional Expectation|Prediction as Conditional Expectation]] — foundation for prediction tasks.
- [[Machine Learning/Regression algorithm/Regression Algorithm|Regression Algorithm]] — supervised models these metrics evaluate.
- [[Machine Learning/Clustering algorithm/Metrics|Clustering Metrics]] — clustering metrics for unsupervised learning.
