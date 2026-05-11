---
status: active
type: reference
domain: machine-learning
updated: 2026-05-10
tags: [machine-learning, reinforcement-learning, evaluation]
aliases: [Reinforcement Learning Evaluation, RL Evaluation, Policy Evaluation]
---

# Reinforcement Learning Evaluation

Reinforcement learning evaluation is difficult because a new policy changes which actions are taken and therefore changes which data will be observed. A policy can look good in logs and fail when deployed.

---

## Evaluation Modes

| Mode | What It Tests | Main Risk |
|---|---|---|
| Simulator evaluation | Policy behavior in a controlled environment | Simulator may not match reality |
| Offline policy evaluation | Estimate new policy value from historical logs | Requires strong assumptions about logged actions |
| Online experiment | Deploy policy to real users or systems | Exploration can be unsafe or costly |
| Shadow mode | Observe recommendations without acting on them | Cannot measure full feedback loop |
| Guardrail monitoring | Track safety and business constraints | Reward may improve while guardrails degrade |

---

## What to Measure

Measure more than average reward:

- cumulative reward over the right horizon;
- variance and tail outcomes;
- safety or compliance violations;
- user or system-level guardrails;
- distribution shift after policy changes;
- exploration cost;
- rollback triggers.

> [!warning] Common mistake
> Do not evaluate RL like ordinary supervised learning. Prediction accuracy on logged data does not prove that a new policy will produce better outcomes.

---

## Failure Modes

| Failure Mode | Symptom |
|---|---|
| Reward hacking | Policy optimizes the metric while harming the real goal. |
| Unsafe exploration | Trying actions creates unacceptable cost or risk. |
| Off-policy bias | Historical logs do not support estimating the new policy. |
| Non-stationarity | Environment changes after the policy changes behavior. |
| Sparse reward | Learning is unstable because feedback is delayed or rare. |

---

## Related

- [[Machine Learning/Learning Paradigms/Reinforcement Learning|Reinforcement Learning]] — overview and suitability.
- [[Machine Learning/Learning Paradigms/Reinforcement Learning Methods|Reinforcement Learning Methods]] — algorithm families.
- [[Machine Learning/Machine Learning|Machine Learning]] — main curriculum map.
