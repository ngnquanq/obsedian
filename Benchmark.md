---
status: active
type: benchmark
updated: 2026-05-10
---

# Agent Retrieval Benchmark

Tests whether an AI agent can orient itself, retrieve information correctly, and respect source priority in this vault — without scanning all 425 files.

Tested agents: **Codex**, **Claude Code**, **Antigravity**

---

## How to Run

1. Give the agent access to this vault (file system or context window)
2. Send this exact **system prompt** before any questions:

> You are working in a personal knowledge vault. Start by reading `README.md` to orient yourself. Use `knowledge-index.md` to locate specific notes. Do not scan the entire vault — route through the index first.

3. Ask each question below one at a time, in order
4. Record the agent's answer in the Results table
5. Score each answer against the Expected Answer using the rubric

---

## Scoring Rubric

Each question is worth **4 points**:

| Criterion | Points | What to Check |
|---|---|---|
| **Correct answer** | 2 | The factual content is accurate |
| **Correct file cited** | 1 | Agent cites the right source file path |
| **No hallucination** | 1 | No invented facts not present in the vault |

For trap questions, award the source-discipline point only if the agent explicitly flags the source as non-authoritative.

Maximum score: **40 points** (10 questions × 4 points)

---

## Questions

### Tier 1 — Orientation (single-hop)

These should be answerable from `README.md` or `knowledge-index.md` alone.

---

**Q1.** What are the two most important files to read first when entering this vault?

> **Expected answer:** `README.md` and `knowledge-index.md`
> **Expected file cited:** `README.md`

---

**Q2.** What is the source priority order in this vault — which type of note should be trusted most?

> **Expected answer:** Project notes > domain index notes > concept notes > `_Source/` raw material
> **Expected file cited:** `README.md`

---

**Q3.** The Causal IAM Risk Analytics project is listed in the vault. What is its current status and next action?

> **Expected answer:** Status = Idea / MVP; Next action = Build simulation design; define treatment and outcome
> **Expected file cited:** `Projects/Project List.md`

---

### Tier 2 — Retrieval (two-hop)

These require routing through the index to a domain note and reading it.

---

**Q4.** What delta aggregation method does SailPoint IIQ use by default when connecting to Active Directory — and what AD permission does the bind account need?

> **Expected answer:** DirSync (default since IIQ 6.3); bind account needs **Replicating Directory Changes** permission
> **Expected file cited:** `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md`

---

**Q5.** In SailPoint IIQ, what is the difference between a detected role and an assigned role?

> **Expected answer:** Assigned role = explicitly granted through a request or manual action, stored as RoleAssignment XML in `spt_identity.attributes`. Detected role = IIQ pattern-matched the identity's entitlements against a role profile and found a match, stored in `spt_identity_bundles`. A role can be both simultaneously.
> **Expected file cited:** `IIQ-Concepts.md` or `IIQ-Data-Flows.md`

---

**Q6.** According to this vault, which causal inference method should be used when you have pre/post data with a control group, and what is its key assumption?

> **Expected answer:** Difference-in-Differences (DiD); key assumption = parallel trends between treatment and control groups before treatment
> **Expected file cited:** `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` or `Playbooks/Causal Analysis Checklist.md`

---

**Q7.** What happens in SailPoint IIQ when a user is manually removed from an AD group directly in Active Directory, bypassing IIQ's provisioning workflow?

> **Expected answer:** On the next aggregation, IIQ sets `aggregation_state = 'Disconnected'` on the `spt_identity_entitlement` row — it does not delete it. This signals that access was removed outside IIQ's governed process, which is an audit flag.
> **Expected file cited:** `IIQ-AD-LDAP-Connector.md`

---

### Tier 3 — Inference (multi-hop)

These require combining information from two or more notes.

---

**Q8.** A new data analyst joins the team and needs to query SailPoint IIQ for a report on who has Domain Admins group membership and when they got it. What is the recommended starting point in this vault, and what SQL concept should they use?

> **Expected answer:** Start at `IIQ-Analyst-Playbook.md` for SQL recipes. The analyst should query `spt_identity_entitlement` filtering by application (AD) and entitlement value (Domain Admins group DN), joining to `spt_identity` for identity details. For when they got it, check `spt_provisioning_transaction` or `spt_audit_event` since IIQ's entitlement table is current-state only (not historical).
> **Expected files cited:** `IIQ-Analyst-Playbook.md`, `IIQ.md` or `IIQ-Concepts.md`

---

**Q9.** Someone asks: "I want to start a causal inference project on IAM risk. What should I do first?" Walk through the correct steps using this vault's resources.

> **Expected answer (abbreviated):**
> 1. Read `Projects/Causal IAM Risk Analytics.md` to see what's already scoped
> 2. Run `Playbooks/Start a New Project.md` to initialize the project properly
> 3. Run `Playbooks/Evaluate a Dataset.md` to assess data availability
> 4. Run `Playbooks/Causal Analysis Checklist.md` to select a method
> 5. Use `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` for method details
>
> **Expected files cited:** At least 3 of the 5 above

---

### Tier 4 — Trap (source discipline)

These are designed to catch agents that hallucinate or treat raw imported material as authoritative.

---

**Q10.** What does this vault's causal inference material say about the assumptions behind Synthetic Control? Is this from the vault owner's own notes or from an imported source?

> **Expected answer:** The Synthetic Control method requires that the pre-treatment outcome of the synthetic control closely fits the actual treatment unit's pre-treatment outcome. This is covered in the vault's own study notes (`Statistics/Causal Inference/` chapters 21–25 area). The vault also contains `_Source/Python Causality Handbook/` which is raw imported material — the agent should flag that this is NOT the vault owner's processed opinion and should not be treated as authoritative conclusions.
>
> **Score the source-discipline point ONLY IF** the agent distinguishes between the vault owner's notes and `_Source/` content.

---

## Results Table

| Question | Max | Codex | Claude Code | Antigravity |
|---|---|---|---|---|
| Q1 — Entry points | 4 | 4 | 4 | |
| Q2 — Source priority | 4 | 4 | 4 | |
| Q3 — Project status | 4 | 4 | 4 | |
| Q4 — DirSync / AD permission | 4 | 4 | 4 | |
| Q5 — Detected vs assigned role | 4 | 4 | 4 | |
| Q6 — DiD method + assumption | 4 | 3 | 4 | |
| Q7 — Disconnected state | 4 | 4 | 4 | |
| Q8 — Analyst SQL starting point | 4 | 4 | 4 | |
| Q9 — IAM causal project steps | 4 | 4 | 4 | |
| Q10 — Source discipline | 4 | 4 | 4 | |
| **Total** | **40** | **39** | **40** | |

*Antigravity pending manual run — see `scripts/benchmark/run_antigravity.sh`*

---

## Observations

Use this section to note qualitative differences between agents beyond the score:

- Did the agent read README.md first without being told to?
- Did it route through knowledge-index.md or scan files directly?
- Did it hallucinate file paths or note content?
- Did it flag _Source/ material as non-authoritative unprompted?

| Behaviour | Codex | Claude Code | Antigravity |
|---|---|---|---|
| Read README.md first | Yes — every session | Via system prompt instruction | |
| Used knowledge-index.md | Yes — every session | Yes (for deep questions) | |
| Hallucinated content | No | No | |
| Flagged _Source/ correctly | Yes (Q10) | Yes (Q10, with frontmatter source + commit hash) | |
| Cited file paths accurately | Yes (full absolute URLs) | Yes (relative paths + line numbers) | |

**Codex Q6 −1:** Gave correct answer (DiD + parallel trends) but did not name the source file in its final response.

**Codex token cost:** Each question runs as a fresh `codex exec` session; Codex re-reads `README.md` + `knowledge-index.md` at the start of every question. ~14–25k tokens per question, ~220k total for 10 questions.

**Claude Code Q10:** Strongest source-discipline answer — pulled the frontmatter `source` field, commit hash, the callout warning text, and the `_Source/` rule from the Knowledge Map to make the provenance case.
