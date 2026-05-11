---
status: active
type: reference
domain: machine-learning
updated: 2026-05-10
tags: [machine-learning, semi-supervised-learning, methods]
aliases: [Semi-Supervised Methods, Semi-Supervised Algorithms, Pseudo-Labeling]
---

# Semi-Supervised Methods

Semi-supervised methods try to turn unlabeled examples into useful training signal without pretending that unlabeled data is automatically trustworthy. Read [[Machine Learning/Learning Paradigms/Semi-Supervised Learning|Semi-Supervised Learning]] first.

---

## Method Families

| Method | Main Idea | Good For | Main Risk |
|---|---|---|---|
| Pseudo-labeling | Train on labeled data, predict labels for unlabeled data, retrain on confident predictions | Simple classification workflows | Confident wrong labels reinforce model errors |
| Self-training | Iteratively add model-labeled examples to the training set | Gradual expansion from a small labeled set | Error accumulation |
| Consistency regularization | Require predictions to stay stable under small input perturbations | Images, text, tabular augmentation with care | Bad augmentations can change the true label |
| Label propagation | Spread labels through a similarity graph | Data with meaningful neighborhoods | Poor distance metric spreads wrong labels |
| Co-training | Train multiple views that teach each other | Problems with genuinely different feature views | Views may not be independent enough |

---

## Practical Workflow

```text
Train labeled-only baseline
    |
    v
Score unlabeled examples
    |
    v
Select only high-confidence or stable pseudo-labels
    |
    v
Retrain with labeled + selected pseudo-labeled data
    |
    v
Evaluate on clean labeled holdout
```

Use conservative selection first. A smaller set of high-quality pseudo-labels is usually safer than a large set of noisy labels.

---

## Assumptions

Semi-supervised methods rely on at least one of these assumptions:

| Assumption | Meaning |
|---|---|
| Smoothness | Similar examples should have similar labels. |
| Cluster assumption | Decision boundaries should pass through low-density regions. |
| Manifold assumption | High-dimensional data lies near a lower-dimensional structure. |

If these assumptions are false, unlabeled data can make performance worse.

---

## Related

- [[Machine Learning/Learning Paradigms/Semi-Supervised Learning|Semi-Supervised Learning]] — overview and suitability.
- [[Machine Learning/Learning Paradigms/Semi-Supervised Evaluation|Semi-Supervised Evaluation]] — how to validate semi-supervised systems.
- [[Machine Learning/Regression algorithm/Metrics|Regression Metrics]] — metric-selection principles for supervised evaluation.
