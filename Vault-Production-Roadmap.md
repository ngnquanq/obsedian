---
status: active
type: meta
updated: 2026-05-10
---

# Vault Production Roadmap

This document tracks what is needed to take this knowledge vault from a personal study system to a production-grade knowledge hub — one that supports reliable AI agent retrieval, tool integration, and information integrity at scale.

Organised into three layers: what is already in place, what needs to be built, and the failure modes each item addresses.

---

## Layer 1 — Retrieval Optimization

**Goal:** Any agent or human should be able to find the right note in two hops.

| Item | Status | What It Does |
|---|---|---|
| Consistent frontmatter schema | Done | Tags, aliases, and status fields enable semantic and keyword search |
| MOC / index notes per domain | Done | Single entry point per domain; `knowledge-index.md` as flat global index |
| Bidirectional linking | Done | Enforced by CLAUDE.md; prevents orphan notes |
| `README.md` source priority rules | Done | Tells agents which note to trust when multiple cover the same topic |
| Benchmark suite | Done | Validates agent retrievability; see `Benchmark.md` |
| Chunking strategy for vector search | **Not started** | Long notes need section-level chunking so embeddings are topic-specific, not document-level |
| Explicit "entry point" tags | **Not started** | Mark notes that are safe to start from vs. notes that require prerequisite reading; agents need this signal to avoid mid-graph entry |

---

## Layer 2 — Tool Integration

**Goal:** Notes should be *actionable*, not just readable. An agent should be able to retrieve a note and immediately know what to do with it.

| Item | Status | What It Does |
|---|---|---|
| Reading path in MOC notes | Done | Agents can follow a linear path without inferring structure |
| Python code blocks in source notes | Done (imported) | Executable reference material exists for causal inference methods |
| Structured schemas for tool parsing | **Not started** | Key notes (playbooks, checklists) should have a machine-parseable section — structured YAML or JSON blocks — so tools can extract steps without NLP |
| Tool-oriented entry tags | **Not started** | A `tool-entry: true` frontmatter flag marks notes designed as agent starting points; helps tools skip navigational notes and land directly on actionable content |
| Runnable playbook format | **Not started** | `Playbooks/` notes currently written for human readers; needs a parallel format where each step is an atomic, checkable action a tool can execute or verify |

---

## Layer 3 — Guard-rails and Integrity

**Goal:** No PII, no unverified claims, no silent staleness. Failures should be loud.

### 3a — PII Prevention

| Item | Status | What It Does |
|---|---|---|
| No PII policy (implicit) | Partial | Vault contains no known PII, but there is no enforced check |
| PII scrub checklist | **Not started** | Before ingesting any note derived from real work (project notes, incident analysis), run a checklist: names, emails, internal system names, client identifiers |
| Automated PII classifier on write | **Not started** | A pre-commit hook or ingestion step that flags candidate PII patterns (email regex, employee IDs, internal hostnames) before a note lands in the vault |

### 3b — Information Integrity and Dual Review

| Item | Status | What It Does |
|---|---|---|
| "Verify before writing" standard | Done | CLAUDE.md requires primary-source confirmation for all factual claims |
| Source separation (`_Source/`) | Done | Raw imported material is structurally separate from processed vault notes |
| Provenance tags (`source:` field) | Partial | Present in some notes; not consistently enforced |
| Dual-review workflow | **Not started** | Formal two-step process: (1) raw note in `_Source/` or `_Draft/`, (2) processed note in domain folder only after claims are verified against a primary source. No note moves to a domain folder in a single step. |
| Uncertainty flagging convention | Done | CLAUDE.md specifies `> [!note]` for vendor-specific behaviour and omitting unverifiable claims |
| Staleness conditions (not just dates) | **Not started** | Notes should carry an explicit re-verify condition: "valid until vendor releases new schema docs" or "re-check if RFC superseded" — not just a date, which goes stale silently |

### 3c — Trust Tiers

| Item | Status | What It Does |
|---|---|---|
| Source priority in README | Done | Project notes > MOC notes > concept notes > `_Source/` |
| Source credibility taxonomy | **Not started** | Explicit tiers for source types: RFC/vendor docs (tier 1) > peer-reviewed papers (tier 2) > well-maintained public repos (tier 3) > blog posts/talks (tier 4). A note's trust tier is inherited from its lowest-tier source. |
| Trust tier frontmatter field | **Not started** | Add `source_tier: 1-4` to frontmatter so agents can weight conflicting notes correctly without reading their full body |

---

## Layer 4 — Operational Quality

**Goal:** The vault should fail loudly, detect its own gaps, and stay consistent as it grows.

### 4a — Observability

| Item | Status | What It Does |
|---|---|---|
| Benchmark suite | Done | Validates retrieval quality at a point in time |
| Retrieval logging | **Not started** | When an agent uses this vault, log which notes were retrieved per query. Without this, failures surface as wrong answers with no trace of what went wrong. |
| Benchmark re-run trigger | **Not started** | Define a condition that triggers a benchmark re-run: any structural change to `README.md`, `knowledge-index.md`, or CLAUDE.md |

### 4b — Coverage Gap Detection

| Item | Status | What It Does |
|---|---|---|
| Domain status table in README | Done | Marks which domains are active vs. empty shells |
| Unanswered query log | **Not started** | Track queries that returned no confident answer. This is the signal for where to write next — a question without a note is a gap, not just a miss. |
| Gap-to-backlog pipeline | **Not started** | Unanswered queries → tagged `#todo-note` items in a `Vault-Backlog.md` file |

### 4c — Canonicalization

| Item | Status | What It Does |
|---|---|---|
| Bidirectional links | Done | Prevents duplicate paths through the same concept |
| Deduplication process | **Not started** | When two notes cover the same concept from different angles, one becomes the canonical note and the other becomes a redirect (frontmatter `canonical: [[Note-Name]]` and a one-line body pointing to it). Without this, agents retrieve inconsistent answers depending on which note lands in context. |

### 4d — Negative Knowledge

| Item | Status | What It Does |
|---|---|---|
| Failure modes in concept notes | Partial | Some notes include failure modes or gotchas as `> [!warning]` callouts |
| Explicit "what doesn't work" convention | **Not started** | Notes derived from investigation or debugging should include a `## Dead Ends` section listing approaches tried and why they failed. This prevents the same wrong path being taken again — by a human or an agent. |

### 4e — Schema Evolution

| Item | Status | What It Does |
|---|---|---|
| Frontmatter schema in CLAUDE.md | Done | Defines the required fields and tag taxonomy |
| Migration strategy | **Not started** | When the frontmatter schema changes (new required fields, renamed tags), old notes silently become non-conformant. A migration playbook and a conformance check script are needed so schema changes don't silently degrade retrieval. |

---

## Priority Order

If picking up one item at a time, suggested order based on impact-to-effort:

1. **Dual-review workflow** — highest integrity risk; a single unverified claim in a heavily-linked note propagates widely
2. **Staleness conditions** — dates are already partially present; upgrading to conditions is low effort, high value
3. **PII scrub checklist** — manual process first; automate later
4. **Trust tier frontmatter field** — one new field, immediately useful for agent weighting
5. **Chunking strategy** — needed before any vector search integration
6. **Deduplication process** — becomes critical as the vault grows past ~500 notes
7. **Retrieval logging** — requires an agent integration layer; build after the above are stable
8. **Coverage gap detection** — useful once retrieval logging exists

---

## Related

- `README.md` — vault orientation and current benchmark results
- `Benchmark.md` — full benchmark design and per-question scores
- `CLAUDE.md` — writing standards, naming conventions, integrity requirements
- `knowledge-index.md` — flat index of all notes
