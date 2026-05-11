---
status: active
type: reference
domain: machine-learning
updated: 2026-05-10
tags: [machine-learning, self-supervised-learning, methods]
aliases: [Self-Supervised Methods, Pretext Tasks, Contrastive Learning]
---

# Self-Supervised Methods

Self-supervised methods differ by how they create a useful pretext task from unlabeled data. Read [[Machine Learning/Learning Paradigms/Self-Supervised Learning|Self-Supervised Learning]] first.

---

## Method Families

| Method | Generated Target | Common Domains | What It Learns |
|---|---|---|---|
| Masked prediction | Missing token, patch, or feature | text, images, tabular data | context-aware representation |
| Contrastive learning | Same vs different instance/view | images, text, audio, events | similarity-aware embedding |
| Next-step prediction | Next token, event, or state | language, clickstreams, time series | sequential structure |
| Reconstruction | Rebuild corrupted input | images, signals, tabular data | compressed representation |
| Augmentation prediction | Relationship between transformed views | images, sensor data | invariances useful for downstream tasks |

---

## Pretext Task vs Downstream Task

| Task Type | Purpose | Example |
|---|---|---|
| Pretext task | Learn representation from raw data | predict masked words |
| Downstream task | Solve the real applied task | classify ticket priority |

A good pretext task forces the model to learn structure that downstream tasks can reuse. A bad pretext task can be solved with shortcuts that do not transfer.

---

## Practical Workflow

```text
Collect raw data
    |
    v
Define pretext objective
    |
    v
Pretrain model or embedding
    |
    v
Freeze, fine-tune, or reuse representation
    |
    v
Evaluate on downstream task
```

---

## Related

- [[Machine Learning/Learning Paradigms/Self-Supervised Learning|Self-Supervised Learning]] — overview and suitability.
- [[Machine Learning/Learning Paradigms/Self-Supervised Evaluation|Self-Supervised Evaluation]] — downstream validation.
- [[Deep Learning/Foundations/Loss function|Loss function]] — loss functions used to optimize pretext tasks.
