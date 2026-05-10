# Benchmark Scores

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

## Observations

| Behaviour | Codex | Claude Code | Antigravity |
|---|---|---|---|
| Read README.md first | Yes (every session) | Via system prompt instruction | |
| Used knowledge-index.md | Yes (every session) | Yes (for deep questions) | |
| Hallucinated content | No | No | |
| Flagged _Source/ correctly | Yes (Q10) | Yes (Q10) | |
| Cited file paths accurately | Yes (full absolute URLs) | Yes (relative paths + line numbers) | |

## Notes

**Codex Q6 (-1):** Answered DiD + parallel trends correctly, but the final clean answer did not name the source file. -1 for missing file citation.

**Codex behavior:** Each question runs as a fresh `codex exec` session, so Codex re-reads `README.md` and `knowledge-index.md` at the start of every single question. This is consistent and correct routing behavior, but costs ~14–25k tokens per question (total ~220k tokens for 10 questions). The bubblewrap sandbox warning fires every session but does not affect functionality.

**Claude Code behavior:** Responds to the system prompt instruction immediately and follows the routing pattern. For deeper questions (Q4, Q5, Q7, Q8), it cited specific line numbers within files, showing it actually navigated to and read the correct notes. Q10 produced the most thorough source-discipline answer: it pulled the frontmatter `source` field, commit hash, callout text, and the `_Source/` warning from the knowledge map.

**Both agents:** Neither invented file paths, table names, or SQL column names that don't exist in the vault. All IIQ schema references (`spt_identity_entitlement`, `spt_identity_bundles`, `aggregation_state`) were cited correctly.
