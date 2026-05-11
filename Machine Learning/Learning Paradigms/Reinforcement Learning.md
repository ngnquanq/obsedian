---
status: active
type: concept
domain: machine-learning
updated: 2026-05-10
tags: [machine-learning, reinforcement-learning, sequential-decision-making]
aliases: [Reinforcement Learning, RL, Sequential Decision Learning]
---

# Reinforcement Learning

Reinforcement learning is useful when the model does not just predict an outcome; it chooses actions, observes rewards, and must improve future decisions. The central object is a policy, not a prediction function.

---

## Why Reinforcement Learning Exists

Imagine a recommendation system that decides what content to show next. The action affects what the user clicks, how long they stay, and what data the system will observe later. A one-step supervised model can predict clicks, but it does not directly optimize a long-run strategy.

**Reinforcement learning solves this by learning a policy that chooses actions to maximize expected cumulative reward.**

```text
State
    |
    v
Policy chooses action
    |
    v
Environment returns reward and next state
    |
    v
Policy improves over time
```

---

## Core Framing

The usual reinforcement learning setup is a Markov decision process:

| Term | Meaning | Example |
|---|---|---|
| State $S$ | Information available before acting | user context, cart state, robot position |
| Action $A$ | Choice the agent makes | recommend item, set bid, move left |
| Reward $R$ | Feedback after action | click, revenue, safety penalty |
| Policy $\pi(a \mid s)$ | Rule for choosing actions | probability of each action in a state |
| Value function $V(s)$ or $Q(s,a)$ | Expected future reward | long-run value of a state or action |

RL asks:

$$
\text{Which policy maximizes expected cumulative reward?}
$$

---

## When It Is Suitable

Use reinforcement learning when:

- decisions are sequential;
- actions change future states or future data;
- delayed rewards matter;
- exploration is possible or historical action logs are rich enough;
- the reward can be measured and aligned with the real objective.

Avoid RL when the task is a static prediction problem, experimentation is unsafe, rewards are sparse or badly defined, or a simple supervised/rule-based policy is enough.

---

## Main Methods

See [[Machine Learning/Learning Paradigms/Reinforcement Learning Methods|Reinforcement Learning Methods]] for foundations and core algorithms:

- dynamic programming;
- Monte Carlo learning;
- temporal-difference learning;
- Q-learning;
- policy gradients.

Deep RL methods such as DQN, actor-critic, and PPO are downstream extensions, not the focus of this first pass.

---

## Evaluation

See [[Machine Learning/Learning Paradigms/Reinforcement Learning Evaluation|Reinforcement Learning Evaluation]]. RL evaluation is hard because changing the policy changes the data distribution. Offline metrics are not enough unless the logging policy and counterfactual assumptions are clear.

---

## Interview Reference

- RL learns actions, not just predictions.
- The core loop is state, action, reward, next state.
- A policy maps states to actions.
- Value functions estimate long-run reward.
- The main practical risks are unsafe exploration, reward hacking, and unreliable offline evaluation.

---

## Related

- [[Machine Learning/Learning Paradigms/Learning Paradigms|Learning Paradigms]] — comparison with other training signals.
- [[Machine Learning/Learning Paradigms/Reinforcement Learning Methods|Reinforcement Learning Methods]] — core algorithm families.
- [[Machine Learning/Learning Paradigms/Reinforcement Learning Evaluation|Reinforcement Learning Evaluation]] — validation and deployment risks.
- [[Machine Learning/Foundations/Prediction as Conditional Expectation|Prediction as Conditional Expectation]] — contrast with static prediction.
