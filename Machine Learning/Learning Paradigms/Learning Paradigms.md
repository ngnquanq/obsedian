---
status: active
type: index
domain: machine-learning
updated: 2026-05-10
tags: [machine-learning, learning-paradigms, study-notes]
aliases: [Learning Paradigms, ML Learning Paradigms, Machine Learning Paradigms]
---

# Learning Paradigms

Before choosing an algorithm, identify what kind of training signal the data provides. The same business problem can look very different depending on whether labels are abundant, scarce, created from the data itself, or replaced by rewards from actions.

---

## Why This Exists

Imagine building a fraud system. You may have a few confirmed fraud labels, millions of unlabeled transactions, raw sequences that can teach useful representations, and delayed business outcomes after blocking or allowing transactions. Calling all of this "machine learning" hides the real design question.

**Learning paradigms solve this by classifying the source of supervision: labels, structure, self-generated targets, or rewards.**

---

## Comparison Map

| Paradigm | Training Signal | Core Question | Typical Use |
|---|---|---|---|
| Supervised learning | Observed labels $Y$ for each $X$ | Can we predict $Y$ from $X$? | regression, classification, risk scoring |
| Unsupervised learning | Structure in $X$ only | What structure exists without labels? | clustering, dimensionality reduction |
| Semi-supervised learning | Few labeled examples plus many unlabeled examples | Can unlabeled data improve a supervised task? | label-scarce classification |
| Self-supervised learning | Targets generated from the data itself | Can the data create its own pretraining task? | representation learning, language/image pretraining |
| Reinforcement learning | Rewards from actions over time | Which actions maximize long-run reward? | control, recommendation, sequential decision-making |

---

## Reading Path

- [[Machine Learning/Foundations/Prediction as Conditional Expectation|Prediction as Conditional Expectation]] — start here for supervised prediction.
- [[Machine Learning/Learning Paradigms/Semi-Supervised Learning|Semi-Supervised Learning]] — use unlabeled data to improve a labeled task.
- [[Machine Learning/Learning Paradigms/Self-Supervised Learning|Self-Supervised Learning]] — create training targets from raw data.
- [[Machine Learning/Learning Paradigms/Reinforcement Learning|Reinforcement Learning]] — learn policies from action, state, and reward.
- [[Machine Learning/Clustering algorithm/Clustering Algorithm|Clustering Algorithm]] — concrete unsupervised method family.

---

## Decision Rule

| If You Have... | Start With |
|---|---|
| Many examples with reliable labels | Supervised learning |
| Many examples and no target label | Unsupervised learning |
| A small labeled set and a large unlabeled set from the same population | Semi-supervised learning |
| Raw text, images, audio, logs, or sequences where labels can be generated automatically | Self-supervised learning |
| A system where the model chooses actions and observes delayed rewards | Reinforcement learning |

> [!warning] Common mistake
> Do not choose the paradigm because it sounds modern. Choose it because it matches the training signal and the decision problem.

---

## Related

- [[Machine Learning]] — main curriculum map.
- [[Machine Learning/Learning Paradigms/Semi-Supervised Learning|Semi-Supervised Learning]] — learning from labeled and unlabeled examples.
- [[Machine Learning/Learning Paradigms/Self-Supervised Learning|Self-Supervised Learning]] — representation learning from generated targets.
- [[Machine Learning/Learning Paradigms/Reinforcement Learning|Reinforcement Learning]] — learning actions from rewards.
