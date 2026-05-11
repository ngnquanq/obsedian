---
status: active
type: concept
domain: machine-learning
updated: 2026-05-10
tags: [machine-learning, self-supervised-learning, representation-learning]
aliases: [Self-Supervised Learning, SSL, Self-Supervised Representation Learning]
---

# Self-Supervised Learning

Self-supervised learning is useful when raw data is abundant but manual labels are scarce. It creates a training task from the data itself so the model can learn representations before being adapted to a downstream task.

---

## Why Self-Supervised Learning Exists

Imagine having millions of customer-support messages but only a small labeled set for ticket priority. The unlabeled text still contains grammar, domain vocabulary, product names, and recurring issue patterns. A model can learn that structure before it ever sees priority labels.

**Self-supervised learning solves this by generating labels from the input data, then using the learned representation for downstream prediction.**

```text
Raw data
    |
    v
Create pretext task from the data itself
    |
    v
Pretrain representation
    |
    v
Fine-tune or evaluate on downstream task
```

---

## Core Framing

Self-supervised learning does not start with human labels. It creates a proxy task such as:

- predict a masked word from surrounding words;
- predict a missing image patch;
- decide whether two augmented views come from the same item;
- predict the next event in a sequence.

The goal is not the proxy task itself. The goal is a representation that transfers well.

---

## When It Is Suitable

Use self-supervised learning when:

- raw data is large and structured;
- human labels are expensive or narrow;
- the same representation can support multiple downstream tasks;
- the domain has useful sequence, spatial, temporal, or semantic structure;
- compute cost is justified by reuse.

Avoid it when the dataset is small, the downstream task is simple, or a supervised baseline already solves the problem cheaply.

---

## Main Methods

See [[Machine Learning/Learning Paradigms/Self-Supervised Methods|Self-Supervised Methods]] for method families:

- masked prediction;
- contrastive learning;
- next-step or next-token prediction;
- autoencoding and reconstruction;
- augmentation-based representation learning.

---

## Evaluation

See [[Machine Learning/Learning Paradigms/Self-Supervised Evaluation|Self-Supervised Evaluation]]. The key question is not whether the pretext loss is low. The key question is whether the learned representation improves downstream performance, data efficiency, robustness, or transfer.

---

## Interview Reference

- Self-supervised learning creates labels from the data itself.
- It is mainly used for representation learning and pretraining.
- It differs from semi-supervised learning because it does not require a labeled seed set.
- Evaluate it through downstream tasks, not only pretext-task accuracy.
- Many modern language and vision models use self-supervised objectives.

---

## Related

- [[Machine Learning/Learning Paradigms/Learning Paradigms|Learning Paradigms]] — comparison with other training signals.
- [[Machine Learning/Learning Paradigms/Self-Supervised Methods|Self-Supervised Methods]] — common pretraining objectives.
- [[Machine Learning/Learning Paradigms/Self-Supervised Evaluation|Self-Supervised Evaluation]] — transfer and downstream evaluation.
- [[Deep Learning]] — neural architectures often used for large-scale self-supervised learning.
