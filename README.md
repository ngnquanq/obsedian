---
status: active
type: index
updated: 2026-05-10
benchmark: Claude Code 40/40 · Codex 39/40 (2026-05-10)
---

# Knowledge Vault

Personal knowledge base for CISSP exam preparation, enterprise IAM, data science, and machine learning. Notes are written for long-term retention — every note is independently useful weeks after it was written.

For writing standards and folder conventions, see `CLAUDE.md`.

---

## Where to Start

Route by task:

| I want to... | Start here |
|---|---|
| Study IAM / access control / identity governance | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` |
| Understand SailPoint IIQ or CyberArk | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/SailPoint IIQ/IIQ-Concepts.md` |
| Study causal inference methods | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` |
| Find or review a project | `Projects/Project List.md` |
| Navigate any domain | `knowledge-index.md` |
| Understand the full CISSP curriculum | `Cyber Security/CISSP/CISSP - Index.md` |

---

## Source Priority

When multiple notes cover the same topic, prefer in this order:

1. **Project notes** (`Projects/`) — current applied context
2. **Domain index / MOC notes** — authoritative navigation layer
3. **Concept notes** — detailed topic explanations
4. **`_Source/` folders** — raw imported material, not the owner's final opinion

Do not treat `_Source/` content as advice or conclusions. It is reference material only.

---

## Domain Map

| Domain | MOC / Entry Point | Status |
|---|---|---|
| Cyber Security — IAM | `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` | Active |
| Cyber Security — CISSP | `Cyber Security/CISSP/CISSP - Index.md` | Active (Domain 5 only) |
| Statistics — Causal Inference | `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` | Active |
| Statistics | `Statistics/Statistics.md` | Active |
| Deep Learning | `Deep Learning/Deep Learning.md` | Study notes |
| Machine Learning | `Machine Learning/Machine Learning.md` | Study notes |
| Finance | `Finance/Finance.md` | Study notes |
| Projects | `Projects/Project List.md` | Active |
| Playbooks | `Playbooks/` | Active |

---

## Rules

- Always read the domain MOC or index note before diving into deep concept notes
- `_Source/` folders contain raw imported material — do not treat as authoritative
- Notes link bidirectionally — if note A links to B, B links back to A
- A note with `status: stale` in its frontmatter may be outdated — verify before using
- Wikilinks (`[[Note Name]]`) are Obsidian-specific; resolve them as relative file paths

---

## Status Guide

| Status | Meaning |
|---|---|
| `active` | Current, maintained, reliable |
| `draft` | Work in progress, incomplete |
| `reference` | Stable reference material, not actively updated |
| `stale` | Potentially outdated — verify before using |
| `imported` | Raw source material, not processed into vault opinion |

---

## Agent Retrieval Benchmark

This vault has been tested for agent-agnostic retrievability. Any AI agent given access to this vault should be able to answer domain questions correctly by routing through this file and `knowledge-index.md`.

**Last run:** 2026-05-10

| Agent | Score / 40 | Notes |
|---|---|---|
| Claude Code | **40** | Perfect. Cited file paths with line numbers. Strongest source-discipline answer on Q10. |
| Codex | **39** | −1 on Q6 (correct answer, file not cited). Zero hallucinations. Re-reads index every session. |
| Antigravity | — | GUI-only chat; no headless CLI output capture. Pending manual run. |

**What was tested:** 10 questions across 4 tiers — orientation (single-hop from this file), retrieval (two-hop through the index), inference (multi-note synthesis), and source discipline (distinguishing `_Source/` imported material from vault owner notes).

Full benchmark design, questions, expected answers, and per-question scores: `Benchmark.md`
Runner scripts and raw results: `scripts/benchmark/`
