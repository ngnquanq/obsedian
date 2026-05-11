---
status: active
type: concept
domain: machine-learning
updated: 2026-05-10
tags: [machine-learning, regression, supervised-learning]
aliases: [Regression Algorithm, Regression, Regression Models]
---

# Regression Algorithm

Regression is the supervised learning family used when the target is numeric. Read [[Machine Learning/Foundations/Prediction as Conditional Expectation|Prediction as Conditional Expectation]] first: regression is one way to estimate $E[Y \mid X]$ when $Y$ is a quantity such as price, demand, revenue, duration, or risk score.

---

## Why Regression Exists

Imagine estimating the sale price of a house. You know its location, square footage, number of rooms, age, and condition, but the sale price is unknown until the house sells. A hand-written rule such as "larger houses cost more" is too crude because the features interact.

**Regression solves this by learning a function that maps observed features to an expected numeric target.**

```text
House features X
    |
    v
Regression model
    |
    v
Predicted price Y_hat
```

---

## Core Framing

The regression task is:

$$
\hat{f}(X) \approx E[Y \mid X]
$$

Where:

- $X$ is the information available at prediction time.
- $Y$ is the numeric target observed in historical data.
- $\hat{f}(X)$ is the learned prediction rule.
- $\hat{Y}$ is the prediction for a new case.

Regression is suitable when error size matters. Predicting a house price off by 5,000 dollars is usually better than being off by 100,000 dollars.

---

## Common Regression Families

| Family | What It Learns | Good For | Common Risk |
|---|---|---|---|
| Linear regression | Weighted sum of features | Baselines, interpretability, simple relationships | Underfitting nonlinear patterns |
| Regularized regression | Linear model with penalty | Many correlated features, simpler models | Too much penalty can erase signal |
| Decision tree regression | Feature splits into regions | Nonlinear rules, interactions | Overfitting |
| Random forest | Average of many trees | Strong tabular baseline | Less interpretable than a single tree |
| Gradient boosting | Sequential trees correcting errors | High-performing tabular prediction | Tuning complexity and leakage risk |

---

## Evaluation Comes Before Algorithm Choice

Regression is only useful if the error is acceptable for the decision. Start with [[Machine Learning/Regression algorithm/Metrics|Regression Metrics]] before treating a lower loss as automatically better.

| Decision Context | Metric Priority |
|---|---|
| Business forecast | MAE or RMSE, plus error by segment |
| Risk score | Ranking quality, calibration, and threshold behavior |
| Price estimate | Absolute error and bias by price band |
| Operational planning | Error at high-demand or high-cost cases |

> [!warning] Common mistake
> A high $R^2$ does not guarantee a useful model. A model can explain variance while still making costly errors in the cases where decisions matter most.

---

## Interview Reference

For a concise answer:

- Regression predicts a continuous target.
- It estimates a function close to $E[Y \mid X]$.
- Linear regression is the baseline; tree ensembles are common strong tabular models.
- Evaluate with metrics that match the cost of being wrong.
- Watch for leakage, overfitting, extrapolation, and unstable performance across groups.

---

## Related

- [[Machine Learning]] — curriculum map for this section.
- [[Machine Learning/Foundations/Prediction as Conditional Expectation|Prediction as Conditional Expectation]] — foundation for the supervised prediction frame.
- [[Machine Learning/Regression algorithm/Metrics|Regression Metrics]] — metrics for regression evaluation.
- [[Machine Learning/Clustering algorithm/Clustering Algorithm|Clustering Algorithm]] — contrast with unsupervised learning, where there is no target $Y$.
