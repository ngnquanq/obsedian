---
status: active
type: reference
domain: machine-learning
updated: 2026-05-10
tags: [machine-learning, self-supervised-learning, evaluation]
aliases: [Self-Supervised Evaluation, Evaluating Self-Supervised Learning, Downstream Evaluation]
---

# Self-Supervised Evaluation

Self-supervised models can perform well on their pretext task while learning representations that do not help the real task. Evaluation must focus on transfer, not just pretraining loss.

---

## Evaluation Modes

| Mode | What It Tests | Use When |
|---|---|---|
| Linear probe | Freeze representation and train a simple linear model | Measuring representation quality |
| Fine-tuning | Update the pretrained model on labeled data | Measuring practical downstream performance |
| Few-shot evaluation | Train with very few labels | Testing data efficiency |
| Retrieval evaluation | Check nearest neighbors in embedding space | Testing semantic similarity |
| Robustness checks | Test shifts, corruptions, or rare segments | Testing reliability |

---

## What to Compare

Compare against:

- a supervised model trained from scratch;
- a simple baseline using hand-crafted or existing features;
- a model pretrained on generic data;
- a model pretrained on domain-specific data;
- different pretext objectives with the same downstream evaluation.

> [!warning] Common mistake
> Do not choose a self-supervised method only because it lowers pretraining loss. A lower proxy loss can still produce worse downstream representations.

---

## Failure Modes

| Failure Mode | Symptom |
|---|---|
| Shortcut learning | The model solves the pretext task without learning useful structure. |
| Domain mismatch | Generic pretraining fails to help specialized downstream data. |
| Representation collapse | Embeddings become too similar to distinguish cases. |
| Expensive overkill | Pretraining cost exceeds the value of the downstream improvement. |
| Evaluation leakage | Downstream test information leaks into pretraining or tuning. |

---

## Related

- [[Machine Learning/Learning Paradigms/Self-Supervised Learning|Self-Supervised Learning]] — overview and suitability.
- [[Machine Learning/Learning Paradigms/Self-Supervised Methods|Self-Supervised Methods]] — pretext-task families.
- [[Machine Learning/Machine Learning|Machine Learning]] — main curriculum map.
