---
status: active
type: concept
domain: machine-learning
updated: 2026-05-10
tags: [machine-learning, clustering, unsupervised-learning]
aliases: [Clustering Algorithm, Clustering, Unsupervised Clustering]
---

# Clustering Algorithm

Clustering is used when there is no target variable $Y$ to predict, but you still want to discover structure in the feature space $X$. Read [[Machine Learning/Foundations/Prediction as Conditional Expectation|Prediction as Conditional Expectation]] first for the supervised contrast: clustering does not estimate $E[Y \mid X]$ because there is no observed $Y$.

---

## Why Clustering Exists

Imagine a product team with 100,000 customers and no reliable labels for "customer type." They still need to understand whether customers naturally group by behavior: occasional buyers, high-value loyal users, discount-driven users, or inactive accounts.

**Clustering solves this by grouping observations that are similar under a chosen representation and distance notion.**

```text
Feature matrix X
    |
    v
Similarity or distance rule
    |
    v
Groups of similar observations
```

---

## Core Framing

Clustering asks:

- What does "similar" mean for these observations?
- Which features define that similarity?
- How many groups are useful?
- Are the groups stable, interpretable, and actionable?

The algorithm does not know the real-world meaning of a cluster. The analyst assigns meaning after inspecting the grouped observations.

---

## Common Clustering Families

| Family | Main Idea | Good For | Common Risk |
|---|---|---|---|
| K-means | Assign points to nearest centroid | Compact spherical clusters, simple baselines | Requires choosing $k$ and scaling features |
| Hierarchical clustering | Build nested group structure | Exploration and dendrograms | Can be expensive on large data |
| DBSCAN | Find dense regions separated by sparse areas | Irregular shapes and noise detection | Sensitive to density parameters |
| Gaussian mixture model | Model clusters as probability distributions | Soft cluster membership | Assumes distributional shape |

---

## Evaluation

Clustering evaluation is harder than supervised evaluation because there may be no ground truth label. Use [[Machine Learning/Clustering algorithm/Metrics|Clustering Metrics]] to separate:

- internal metrics, which assess compactness and separation from the data alone;
- external metrics, which compare clusters to known labels if labels exist;
- qualitative checks, which test whether clusters are interpretable and useful.

> [!warning] Common mistake
> A high clustering score does not automatically mean the clusters are meaningful. It may only mean the algorithm found compact shapes under the chosen distance metric.

---

## Interview Reference

For a concise answer:

- Clustering is unsupervised grouping.
- It uses features $X$ but no target $Y$.
- The result depends heavily on scaling, feature choice, and distance metric.
- Evaluate with internal metrics, external labels when available, and domain interpretation.
- Clusters are hypotheses about structure, not guaranteed real categories.

---

## Related

- [[Machine Learning]] — curriculum map for this section.
- [[Machine Learning/Foundations/Prediction as Conditional Expectation|Prediction as Conditional Expectation]] — supervised prediction contrast.
- [[Machine Learning/Clustering algorithm/Metrics|Clustering Metrics]] — clustering evaluation metrics.
- [[Machine Learning/Regression algorithm/Regression Algorithm|Regression Algorithm]] — supervised learning contrast.
