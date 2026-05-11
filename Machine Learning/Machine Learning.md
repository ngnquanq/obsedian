---
status: active
type: index
domain: machine-learning
updated: 2026-05-10
tags: [machine-learning, data-science, study-notes]
aliases: [Machine Learning, ML, Applied Machine Learning]
---

# Machine Learning

Machine learning is useful when a decision can be improved by learning a mapping from known information to an unknown but observable outcome. Instead of starting with algorithms, start with the prediction task: what is known at decision time, what must be predicted, and how good predictions will change an action.

This section is the applied machine learning curriculum for the vault. It emphasizes practical data science and mathematical foundations first, then keeps algorithm and interview-style references as lookup material.

---

## Reading Path

| Stage | Start Here | What It Answers |
|---|---|---|
| Foundations | [[Machine Learning/Foundations/Prediction as Conditional Expectation|Prediction as Conditional Expectation]] | Why prediction can be framed as estimating $E[Y \mid X]$ |
| Learning paradigms | [[Machine Learning/Learning Paradigms/Learning Paradigms|Learning Paradigms]] | What kind of training signal the data provides |
| Supervised learning | [[Machine Learning/Regression algorithm/Regression Algorithm|Regression Algorithm]] | How models learn from labeled examples |
| Evaluation | [[Machine Learning/Regression algorithm/Metrics|Regression Metrics]] | How to judge whether predictions are useful |
| Unsupervised learning | [[Machine Learning/Clustering algorithm/Clustering Algorithm|Clustering Algorithm]] | How to find structure when there is no target label |
| Cluster evaluation | [[Machine Learning/Clustering algorithm/Metrics|Clustering Metrics]] | How to assess clusters with and without ground truth |

---

## Curriculum Map

### 1. Foundations

Start here before choosing an algorithm.

- [[Machine Learning/Foundations/Prediction as Conditional Expectation|Prediction as Conditional Expectation]] — prediction as estimating the average target value conditional on available information.
- [[Deep Learning/Foundations/Loss function|Loss functions]] — how a model is punished for being wrong.
- Risk minimization — why training means choosing a function that performs well under a loss.
- Generalization — why the model must work on new cases, not just training data.
- Data leakage — why features must be available at the moment of prediction.

### 2. Learning Paradigms

The first modeling question is what kind of training signal exists.

- [[Machine Learning/Learning Paradigms/Learning Paradigms|Learning Paradigms]] — supervised, unsupervised, semi-supervised, self-supervised, and reinforcement learning.
- [[Machine Learning/Learning Paradigms/Semi-Supervised Learning|Semi-Supervised Learning]] — use unlabeled data to improve a labeled prediction task.
- [[Machine Learning/Learning Paradigms/Self-Supervised Learning|Self-Supervised Learning]] — create labels from raw data to learn reusable representations.
- [[Machine Learning/Learning Paradigms/Reinforcement Learning|Reinforcement Learning]] — learn policies from actions, rewards, and future states.

### 3. Supervised Learning

Supervised learning needs examples where both $X$ and $Y$ are observed.

- [[Machine Learning/Regression algorithm/Regression Algorithm|Regression Algorithm]] — predicting continuous outcomes such as price, demand, revenue, risk score, or time-to-resolution.
- Classification — predicting categories or probabilities such as fraud/not fraud, churn/not churn, or approval/denial.
- Model selection — choosing between baseline, linear, tree-based, and ensemble methods.
- Calibration — checking whether predicted probabilities behave like probabilities.

### 4. Unsupervised Learning

Unsupervised learning looks for structure without a direct target label.

- [[Machine Learning/Clustering algorithm/Clustering Algorithm|Clustering Algorithm]] — grouping similar observations.
- Dimensionality reduction — compressing features for visualization, modeling, or denoising.
- Representation learning — creating useful features from raw data.

### 5. Evaluation

Evaluation turns model output into a decision about whether the model is useful.

- [[Machine Learning/Regression algorithm/Metrics|Regression Metrics]] — MAE, MSE, RMSE, $R^2$, and business-facing error interpretation.
- [[Machine Learning/Clustering algorithm/Metrics|Clustering Metrics]] — internal and external clustering metrics.
- [[Machine Learning/Learning Paradigms/Semi-Supervised Evaluation|Semi-Supervised Evaluation]] — whether unlabeled data improves a labeled task.
- [[Machine Learning/Learning Paradigms/Self-Supervised Evaluation|Self-Supervised Evaluation]] — whether pretraining improves downstream tasks.
- [[Machine Learning/Learning Paradigms/Reinforcement Learning Evaluation|Reinforcement Learning Evaluation]] — whether a policy improves long-run reward safely.
- Validation design — train/test split, cross-validation, time-based split, and holdout sets.
- Error analysis — finding where the model fails, not just reporting one score.

### 6. Applied ML Workflow

Applied ML starts before modeling and continues after model training.

```text
Problem framing
    |
    v
Define X, Y, unit, and prediction time
    |
    v
Build baseline and validation design
    |
    v
Train candidate models
    |
    v
Evaluate errors and decision impact
    |
    v
Deploy, monitor, or decide not to use the model
```

Use this workflow when reviewing project ideas such as fraud detection, churn prediction, customer value, anomaly detection, forecasting, or risk scoring.

### 7. Interview Reference

Interview preparation should come after the applied frame. Use algorithm notes for compact recall:

| Prompt | Good Answer Shape |
|---|---|
| What problem does this algorithm solve? | State the prediction or grouping task. |
| What assumptions does it make? | Explain where the method works and fails. |
| How do you evaluate it? | Pick metrics that match the decision cost. |
| What can go wrong in production? | Mention leakage, drift, bias, poor calibration, or bad monitoring. |

---

## Prediction vs Causality

Prediction estimates what outcome is expected given observed information:

$$
E[Y \mid X]
$$

Causal inference asks what would happen under an intervention. For that contrast, see [[17 - Predictive Models 101]] and [[Causal Inference - Knowledge Map]].

---

## What Is Not Here

- Deep learning models -> see [[Deep Learning]].
- Statistical foundations -> see [[Statistics]].
- Causal identification -> see [[Causal Inference]].
- Applied project planning -> see [[Project List]].

---

## Related

- [[Machine Learning/Foundations/Prediction as Conditional Expectation|Prediction as Conditional Expectation]] — first foundation note for the ML curriculum.
- [[Machine Learning/Learning Paradigms/Learning Paradigms|Learning Paradigms]] — map of supervised, unsupervised, semi-supervised, self-supervised, and reinforcement learning.
- [[Deep Learning]] — neural network-based models and LLMs.
- [[Statistics]] — probability, estimation, and causal inference background.
- [[Data Science]] — top-level vault index.
