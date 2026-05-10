# Benchmark Scoring Guide

Standalone reference for evaluating agent responses. Source of truth is `Benchmark.md`.

---

## Rubric (per question, max 4 points)

| Criterion | Points | What to Check |
|---|---|---|
| Correct answer | 2 | Factual content matches expected answer |
| Correct file cited | 1 | Agent cites the right source file path |
| No hallucination | 1 | No invented facts not present in the vault |

**Trap questions (Q10):** Award the source-discipline point ONLY if the agent explicitly flags that `_Source/` content is raw imported material, not the vault owner's processed notes.

---

## Expected Answers

### Q1 — Entry points
- **Answer:** `README.md` and `knowledge-index.md`
- **File:** `README.md`

### Q2 — Source priority
- **Answer:** Project notes > domain index notes > concept notes > `_Source/` raw material
- **File:** `README.md`

### Q3 — Project status
- **Answer:** Status = Idea / MVP; Next action = Build simulation design; define treatment and outcome
- **File:** `Projects/Project List.md`

### Q4 — DirSync / AD permission
- **Answer:** DirSync (default since IIQ 6.3); bind account needs **Replicating Directory Changes** permission
- **File:** `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-AD-LDAP-Connector.md`

### Q5 — Detected vs assigned role
- **Answer:** Assigned role = explicitly granted through a request or manual action, stored as RoleAssignment XML in `spt_identity.attributes`. Detected role = IIQ pattern-matched entitlements against a role profile, stored in `spt_identity_bundles`. A role can be both simultaneously.
- **File:** `IIQ-Concepts.md` or `IIQ-Data-Flows.md`

### Q6 — DiD method + assumption
- **Answer:** Difference-in-Differences (DiD); key assumption = parallel trends between treatment and control groups before treatment
- **File:** `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` or `Playbooks/Causal Analysis Checklist.md`

### Q7 — Disconnected state
- **Answer:** On the next aggregation, IIQ sets `aggregation_state = 'Disconnected'` on the `spt_identity_entitlement` row — does not delete it. Signals access removed outside IIQ's governed process; audit flag.
- **File:** `IIQ-AD-LDAP-Connector.md`

### Q8 — Analyst SQL starting point
- **Answer:** Start at `IIQ-Analyst-Playbook.md`. Query `spt_identity_entitlement` filtering by application (AD) and entitlement value (Domain Admins DN), join to `spt_identity`. For "when they got it": check `spt_provisioning_transaction` or `spt_audit_event` — entitlement table is current-state only.
- **Files:** `IIQ-Analyst-Playbook.md`, `IIQ.md` or `IIQ-Concepts.md`

### Q9 — IAM causal project steps
- **Answer (abbreviated):**
  1. Read `Projects/Causal IAM Risk Analytics.md`
  2. Run `Playbooks/Start a New Project.md`
  3. Run `Playbooks/Evaluate a Dataset.md`
  4. Run `Playbooks/Causal Analysis Checklist.md`
  5. Use `Statistics/Causal Inference/Causal Inference - Knowledge Map.md`
- **Files:** At least 3 of the 5 above

### Q10 — Source discipline (trap)
- **Answer:** Synthetic Control requires pre-treatment outcome of the synthetic control to closely fit the actual treatment unit. Covered in `Statistics/Causal Inference/` chapters 21–25.
- **Source discipline:** Agent must flag that `_Source/Python Causality Handbook/` is raw imported material — NOT the vault owner's conclusions.
- **Award source-discipline point ONLY IF** agent makes this distinction unprompted.

---

## Scoring Workflow

1. Open a result file (`results/claude_results.md` etc.)
2. For each question, check answer against expected above
3. Record score in `results/scores.md` and `Benchmark.md` results table
