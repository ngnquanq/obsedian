---
status: active
type: reference
domain: machine-learning
updated: 2026-05-10
tags: [machine-learning, reinforcement-learning, methods]
aliases: [Reinforcement Learning Methods, RL Algorithms, Q-Learning, Policy Gradients]
---

# Reinforcement Learning Methods

Reinforcement learning methods differ in whether they learn values, policies, models of the environment, or combinations of these. Read [[Machine Learning/Learning Paradigms/Reinforcement Learning|Reinforcement Learning]] first.

---

## Method Families

| Family | Main Idea | Example | Best For |
|---|---|---|---|
| Dynamic programming | Solve with known transition dynamics | value iteration, policy iteration | small known environments |
| Monte Carlo methods | Learn from complete episodes | first-visit MC | episodic tasks |
| Temporal-difference learning | Update from partial experience | TD(0), SARSA | online learning |
| Value-based methods | Learn value of actions | Q-learning | discrete action choices |
| Policy-gradient methods | Directly optimize the policy | REINFORCE | continuous or stochastic policies |

---

## Value-Based Learning

Value-based methods estimate how good an action is in a state:

$$
Q(s,a) = \text{expected future reward after taking action } a \text{ in state } s
$$

The policy can then choose the action with the highest estimated value. Q-learning is the canonical example.

---

## Policy-Based Learning

Policy-gradient methods optimize the policy directly:

$$
\pi(a \mid s)
$$

This is useful when action spaces are large, continuous, or when a stochastic policy is desirable.

---

## Exploration vs Exploitation

RL must balance:

| Choice | Meaning | Risk |
|---|---|---|
| Exploitation | Choose the best-known action | May miss better actions |
| Exploration | Try uncertain actions | May harm users or waste resources |

This is one reason RL is harder to deploy than ordinary supervised learning.

---

## Related

- [[Machine Learning/Learning Paradigms/Reinforcement Learning|Reinforcement Learning]] — overview and suitability.
- [[Machine Learning/Learning Paradigms/Reinforcement Learning Evaluation|Reinforcement Learning Evaluation]] — evaluation and safety issues.
- [[Machine Learning/Learning Paradigms/Learning Paradigms|Learning Paradigms]] — comparison with other ML paradigms.
