---
status: idea
type: project
domain: nlp
updated: 2026-05-11
tags: [project, nlp, information-retrieval, tfidf, bm25, classical-ml, enterprise, extractive-qa, chatbot, document-routing]
aliases: [Local Search Chatbot, Internal Document Search, Local RAG Chatbot]
---

# Local RAG Chatbot

> [!note] On the name
> Filename kept as "Local RAG Chatbot" for graph continuity with the original scoping. The system is **not** a generative RAG — it is a classical IR + extractive QA pipeline. No LLM, no neural embeddings, no GPU. Treat the word "RAG" here as shorthand for "retrieve then respond," where the response is templated and extractive.

This project is an enterprise POC for an **internal chatbot** that answers questions over a corpus of JSON-like documents using **only traditional machine learning** running on local compute. Zero external APIs, zero generative models, zero GPU dependency. The current baseline is **document representation**: every document is converted into a structured retrieval profile, then user questions are routed to the documents whose profile and supporting chunks best align with the question. The chatbot can still return extracted passages, but the systematic first problem is question-to-document alignment.

Before working on this project, read the prerequisites: [[Introduction to Retrieval Augmented Generation]] (as contrast — what we are deliberately not building), [[LLMOps]] (operational patterns still apply), and [[Machine Learning]] (classical methods MOC).

---

## Why This Project Exists

Internal teams own ~2,000 JSON documents (runbooks, configs, ticket exports, internal wiki dumps). Three problems with the status quo:

1. **Keyword search misses semantically related answers.** Users phrase queries differently from how docs are written.
2. **Cloud LLM APIs are disallowed** for this data class (PII, internal IP, compliance review pending).
3. **Local LLM deployment was rejected** in the architecture review for three reasons: GPU budget unavailable, hallucination risk in regulated answers, and lack of audit story for generated text.

The constraint became the design: build something useful **without any generative component**. Retrieval + extractive answers + transparent ranking is a credible product when "the answer is in the docs" is the dominant query shape.

> [!tip] Mental model
> Generative RAG answers "what is the answer?" This system answers "where is the answer?" — and returns the passage verbatim with a citation. No paraphrase, no synthesis, no risk of fabrication.

---

## User Stories and Outcomes

### What a response actually looks like

Before the stories, anchor the response shape — this is **not** a chatbot in the ChatGPT sense. The output is a ranked list of extracted spans inside a fixed template, not flowing prose.

```
Q: How do I revoke an API key for the legacy auth service?

[1] runbooks/legacy-auth/key-rotation.json — updated 2025-08-14
    "To revoke a legacy API key, navigate to Admin Console > Keys,
     select the key, and click Disable. The key remains valid for
     up to 5 minutes due to caching."

[2] incidents/2024-Q3/INC-4421.json — updated 2024-09-02
    "Operator must also remove the cached entry in Redis via the
     auth:invalidate admin endpoint."

[3] wiki/auth-deprecation-plan.json — updated 2025-11-10
    "All legacy keys will be auto-revoked after 2026-01-01."

Confidence: high (rank-1 BM25 gap = 12.4)
```

The product is "search with citations," not "conversation." Setting that expectation in onboarding is part of the project. The trade-off bought is: zero fabrication, fully auditable, deterministic, CPU-only.

### Story 1 — Support engineer mid-ticket (the volume case)

> **As a** Tier-2 support engineer responding to a customer ticket,
> **I want** to find the authoritative steps for a runbook I don't have memorized,
> **so that** I close the ticket without escalating to engineering or stalling in `#help-eng`.

| | |
|---|---|
| Example query | `how do I revoke an API key for the legacy auth service` |
| System returns | Top-3 verbatim sentences from `runbooks/legacy-auth/key-rotation.json`, `incidents/2024-Q3/INC-4421.json`, `wiki/auth-deprecation-plan.json`. Each shows last-updated date, owner, and a "view full doc" link. |
| Why extractive fits | The engineer needs text they can paste into the ticket. A paraphrase would force them to open the source doc anyway to verify — defeating the time-savings. |
| Failure mode | Vocabulary mismatch (engineer says "revoke," doc says "rotate and disable"). Mitigated by WordNet expansion (Phase 2) and the synonyms dictionary (Phase 3). |

### Story 2 — Compliance officer responding to audit (the headline case)

> **As a** compliance officer answering an external auditor,
> **I want** the exact text of an internal policy with its version and last-updated date,
> **so that** I cite the authoritative source rather than a paraphrase the auditor will reject.

| | |
|---|---|
| Example query | `customer PII data retention period` |
| System returns | Verbatim sentence from `policies/data-retention.json` with policy version, approver name, and last-updated date pinned in the response template. |
| Why extractive fits | **This is the structural reason the project rejected LLMs.** A generated summary is unusable in an audit response — the auditor wants the actual policy text plus a timestamp. The extractive output IS the audit artifact, not a precursor to it. |
| Failure mode | Stale policy. Mitigated by surfacing `updated_at` in every response and a reindex sweep flagging policies untouched for >12 months. |

### Story 3 — Incident commander in a P1 war room (the high-stakes case)

> **As an** incident commander during an active production incident,
> **I want** to find prior incidents and postmortems with similar symptoms,
> **so that** I don't redo investigation work someone has already done.

| | |
|---|---|
| Example query | `checkout service 502 burst after deploy` |
| System returns | Top-3 spans from `incidents/2025-02-INC-9912.json` (root-cause sentence), `incidents/2024-11-INC-7755.json` (mitigation steps), `postmortems/checkout-canary-2024.json` (preventive action). |
| Why extractive fits | A war room cannot trust a paraphrase. The IC needs to read the exact root-cause sentence from a real prior incident before acting on it — anything less risks a wrong mitigation under pressure. Verbatim + citation is the only acceptable shape. |
| Failure mode | The relevant incident exists but uses different terminology than the current symptoms. Phase 3 multi-turn lets the IC chain "checkout 502" → "post-deploy" → "rollback" without re-typing context. |

---

### Outcomes — what success looks like

| Outcome | Leading indicator (Phase 1–2) | Lagging indicator (Phase 3+) |
|---|---|---|
| Faster ticket resolution | Daily active users among support engineers; queries-per-user-per-week | Median time-to-resolution on ticket categories that have runbook coverage |
| Reduced "where is X?" Slack noise | `#help-eng` question volume on indexable topics; thumbs-up rate on responses | Quarterly survey: "I found what I needed" ≥70% yes |
| Onboarding velocity | New-joiner query count in weeks 1–4 vs control cohort | Time-to-first-merged-PR (correlational, not causal) |
| Audit-ready evidence trail | Compliance queries with cited-passage export | Audit responses backed by chatbot citations vs paraphrased recollection |
| Cross-team safety | Engineer queries on configs owned by other teams | Cross-team incident root causes traceable to "I didn't know X" — should drop |

**Counter-signals that mean the product is failing:**

- Daily active users drop after week 2 — users found it unhelpful and stopped trying.
- Refusal rate climbing — corpus has gaps, or the chunker is fragmenting answers across chunks.
- Click-through consistently lands on rank 3+ — the reranker isn't learning the right features.
- Queries shift toward synthesis ("summarize all incidents this quarter") — users are asking for something this product structurally cannot do. That's a signal to either expand scope (different project) or set clearer expectations in onboarding.

---

## What It Looks Like in Practice

### Ingestion flow

```
┌─────────────┐   ┌──────────┐   ┌──────────────┐   ┌─────────────────┐   ┌──────────────┐
│ JSON corpus │ → │  loader  │ → │ JSON-aware   │ → │ TF-IDF vectoriz │ → │ SQLite FTS5  │
│  (~2k docs) │   │ (stream) │   │ chunker      │   │ + BM25 index    │   │ inverted idx │
└─────────────┘   └──────────┘   └──────────────┘   └─────────────────┘   └──────────────┘
                                        ↓                                          ↓
                                  spaCy lemmatize                          chunk metadata
                                  + stopword strip                         (doc_id, path, ts)
```

### Query flow

```
┌──────────┐   ┌─────────────┐   ┌──────────────┐   ┌──────────────┐   ┌────────────────┐
│  user    │ → │ query       │ → │ BM25 top-100 │ → │ LambdaMART   │ → │ sentence       │
│ question │   │ preprocess  │   │ + TF-IDF     │   │ reranker     │   │ ranker (top-3) │
└──────────┘   │ (lemma,     │   │ cosine merge │   │ (LightGBM)   │   └────────────────┘
               │  WordNet    │   └──────────────┘   └──────────────┘            ↓
               │  expand)    │                                          ┌────────────────┐
               └─────────────┘                                          │ Jinja template │
                                                                        │ + citations    │
                                                                        └────────────────┘
                                                                                ↓
                                                                        ┌────────────────┐
                                                                        │ SQLite audit   │
                                                                        │ log (query,    │
                                                                        │  results, user)│
                                                                        └────────────────┘
```

---

## Core Definitions

| Term | Definition in this project |
|---|---|
| Retrieval | Returning the top-k passages most likely to contain the answer, ranked by a scoring function. |
| Lexical retrieval (BM25) | Sparse term-matching with TF, IDF, and document length normalization. The Okapi BM25 family. Primary retriever here. |
| Semantic retrieval (LSI) | Dimensionality reduction (TruncatedSVD) on the TF-IDF matrix to capture term co-occurrence patterns. Approximates "semantic" matching without neural embeddings. |
| Learning to rank (LTR) | Supervised reranker that takes retriever scores plus hand-crafted features and reorders the top-k. LambdaMART here. |
| Extractive QA | Answer = a verbatim span (sentence or passage) from the corpus. No paraphrase. |
| Templated response | The chatbot's reply is a Jinja template with slots filled by extracted spans, citations, and a confidence band. The template text is fixed. |

**What this is NOT:**

| Not this | Why not |
|---|---|
| Dense embeddings (sentence-transformers) | Requires neural model — out of scope by constraint. |
| Generative answering (LLM, seq2seq) | Excluded by architecture review. |
| Vector DB (Chroma, FAISS, Qdrant) | No vectors to store. SQLite FTS5 or Whoosh is sufficient. |
| Fine-tuning | No model to fine-tune; only LTR feature engineering. |

---

## What the Data Looks Like

The system ingests JSON documents in three recognized shapes. Each shape needs a minimum set of fields for the chunker, indexer, and ranker to work. Documents missing required fields are routed to the skip log and surfaced in a weekly review.

### Required metadata (all shapes)

| Field | Required? | Used by |
|---|---|---|
| `doc_id` (or derivable from file path) | Required | Indexer, audit log, citations |
| `purpose` (one-line, human-written) | **Strongly recommended** | Highest-weighted text field in BM25 (boost ≈ 3×); dedicated LTR feature `field_match_purpose`; surfaced in citation footer |
| `updated_at` (ISO-8601) | Required | LTR `doc_recency_days` feature, UI staleness badge |
| `owner` (team or email) | Required | Citation footer ("ask the owner" link), audit trail |
| `title` or `heading` | Strongly recommended | LTR `field_match_title` feature, citation header |
| `tags` (array of strings) | Optional | Synonym dictionary anchoring, filter UI |

> [!tip] Why `purpose` is the highest-leverage field
> Body text is written for an expert reader; a `purpose` line is a human writing *what this doc is for* in plain language. That phrasing tends to match the way users phrase queries far better than the body does. One sentence of `purpose` often outperforms reindexing the entire body — it is the single cheapest quality improvement available to doc owners.

### Shape A — Flat config records

Used for service configs, environment manifests, feature-flag records. **One chunk per record.** Fields concatenated as `"key: value"` lines for indexing.

```json
{
  "doc_id": "config-checkout-api-prod",
  "title": "checkout-api prod configuration",
  "purpose": "Production runtime configuration for the checkout API, including batch sizing, timeouts, rate limits, and active feature flags.",
  "service": "checkout-api",
  "env": "prod",
  "owner": "payments-platform",
  "max_batch_size": 256,
  "timeout_ms": 3000,
  "rate_limit_per_min": 1200,
  "feature_flags": {
    "new_pricing_engine": true,
    "legacy_fallback": false
  },
  "updated_at": "2025-10-14T09:33:00Z",
  "updated_by": "alice@example.com"
}
```

What the chunker produces (the indexed text — `purpose` and `title` placed at the top so BM25 term proximity favors them):
```
title: checkout-api prod configuration
purpose: Production runtime configuration for the checkout API, including batch sizing, timeouts, rate limits, and active feature flags.
service: checkout-api
env: prod
max_batch_size: 256
timeout_ms: 3000
rate_limit_per_min: 1200
feature_flags.new_pricing_engine: true
feature_flags.legacy_fallback: false
```

### Shape B — Nested document with long text (runbooks, postmortems, wiki)

Used for runbooks, postmortems, internal wiki dumps. **One chunk per top-level section.** Long sections split at sentence boundaries to stay under 600 lemmatized tokens. The doc-level `purpose` is prepended to every chunk so section-level retrieval still benefits from the doc-level intent line.

```json
{
  "doc_id": "runbook-legacy-auth-rotation",
  "title": "Legacy auth API key rotation",
  "purpose": "Step-by-step procedure for safely rotating or revoking API keys issued by the legacy auth service, including cache invalidation and verification.",
  "owner": "identity-team",
  "tags": ["auth", "rotation", "legacy"],
  "summary": "How to rotate or revoke legacy auth API keys safely.",
  "sections": [
    {
      "heading": "Prerequisites",
      "purpose": "What the operator must have before starting the rotation.",
      "body": "Operator must have admin role in the legacy auth console and SSH access to the redis-prod cluster."
    },
    {
      "heading": "Revoke procedure",
      "purpose": "How to revoke a legacy API key and propagate the change through the auth cache.",
      "body": "To revoke a legacy API key, navigate to Admin Console > Keys, select the key, and click Disable. The key remains valid for up to 5 minutes due to caching. Operator must also remove the cached entry in Redis via the auth:invalidate admin endpoint."
    },
    {
      "heading": "Verification",
      "purpose": "How to confirm the key is fully revoked.",
      "body": "Attempt an API call with the revoked key. Expect HTTP 401 within 30 seconds of cache invalidation."
    }
  ],
  "updated_at": "2025-08-14T11:00:00Z"
}
```

Section-level `purpose` is optional but recommended for runbooks — it lets the retriever land directly on the right step instead of the whole runbook.

### Shape C — Array of records (ticket exports, incident logs, audit dumps)

Used for ticket exports, incident histories, change logs. **One chunk per array element.** Common envelope fields hoisted into each chunk for context.

```json
[
  {
    "ticket_id": "INC-4421",
    "type": "incident",
    "severity": "P2",
    "title": "Legacy auth keys not invalidating",
    "purpose": "Records the P2 incident where revoked legacy API keys remained usable for ~5 minutes due to Redis cache TTL, and the resolution.",
    "body": "Customer reported revoked API keys still worked for ~5 minutes. Root cause: Redis cache TTL of 300s on auth lookups. Resolution: Operator must also remove the cached entry in Redis via the auth:invalidate admin endpoint.",
    "tags": ["auth", "cache", "legacy"],
    "owner": "identity-team",
    "resolved_at": "2024-09-02T14:22:00Z",
    "updated_at": "2024-09-02T14:22:00Z"
  }
]
```

For ticket exports, `purpose` is most useful when backfilled at export time (e.g., the export script writes a templated one-liner: `"Records the {severity} incident: {title}. Resolution: {one-line summary}."`). This converts low-quality ticket text into a high-signal retrieval target without rewriting every ticket by hand.

### Doc-quality tiers

Because `purpose` is recommended but not required, the system runs at three quality tiers per document:

| Tier | Fields present | Retrieval quality |
|---|---|---|
| Gold | `doc_id`, `title`, `purpose`, `owner`, `updated_at`, body | Best — BM25 hits the purpose line; LTR has full feature set |
| Silver | `doc_id`, `title`, `owner`, `updated_at`, body (no `purpose`) | Acceptable — body-only retrieval; LTR `field_match_purpose` = 0 |
| Bronze | Missing `owner` or `updated_at` | Indexed but flagged; UI shows a "metadata incomplete" badge |

A backlog dashboard (Phase 2) lists Silver / Bronze docs by query traffic, so doc owners know which docs would benefit most from adding a `purpose` line.

---

## Systematic Question-to-Document Routing

The near-term product task is not full chat. The user has a **list of questions**, and the system should route each question to the document or documents most aligned with it. This turns the document representation baseline into a reviewable matching workflow:

```
question list → question preprocessing → document profile scoring
              → chunk evidence scoring → document rollup
              → alignment table for review
```

The output is document-first, with evidence attached. That matters because a document-only route is hard to audit, while a passage-only route hides the actual routing decision. The routing artifact should answer: "Which document should this question point to, and what text made the system think so?"

### Document profile

Each document gets a compact profile used specifically for routing. It is separate from the chunk text used for final answer extraction.

| Profile field | Source | Routing role |
|---|---|---|
| `doc_id` | Metadata or file path | Stable target for the route. |
| `title` / `heading` | Metadata | High-weight cue for obvious topic matches. |
| `purpose` | Metadata | Highest-value field because it is written in user-facing language. |
| `tags` | Metadata | Useful for domain and owner-level routing. |
| `owner` | Metadata | Review handoff and accountability. |
| `updated_at` | Metadata | Staleness signal; not a semantic match signal by itself. |
| section headings / section purposes | Nested docs | Bridges document-level routing to the best supporting section. |
| aggregated chunk text | Chunker output | Fallback when metadata is thin. |

For routing, `purpose` should be treated as the baseline representation target. If a document lacks a `purpose`, the system can still route against title and body text, but the route should be marked lower quality. This gives document owners a concrete improvement loop: add better purpose lines for questions that miss.

### Batch routing output

The first implementation should be an offline batch report rather than a live chat path. For each question, return the top documents plus the best supporting evidence:

```json
{
  "question_id": "q-001",
  "question": "how do I revoke a legacy API key",
  "top_docs": [
    {
      "rank": 1,
      "doc_id": "runbook-legacy-auth-rotation",
      "score": 0.87,
      "confidence": "high",
      "matched_fields": ["purpose", "title"],
      "evidence": {
        "chunk_id": "runbook-legacy-auth-rotation#revoke-procedure",
        "sentence": "To revoke a legacy API key, navigate to Admin Console > Keys, select the key, and click Disable."
      }
    }
  ],
  "needs_review": false
}
```

The human-facing report can be a CSV or markdown table with these columns:

| Column | Meaning |
|---|---|
| `question_id` | Stable ID from the input question list. |
| `question` | Original user question. |
| `rank_1_doc` | Best aligned document. |
| `rank_1_evidence` | Best matching sentence or chunk. |
| `rank_1_confidence` | `high`, `medium`, or `low` from score gap and absolute score. |
| `alternatives` | Rank 2-5 documents for reviewer comparison. |
| `needs_review` | True when scores are close, weak, or all matches rely on body fallback. |

### Scoring strategy

Use two candidate paths, then merge them at the document level:

| Path | What it scores | Why it exists |
|---|---|---|
| Document profile scoring | Question against `title`, `purpose`, `tags`, section purposes, and aggregated document text | Finds the most likely target document. |
| Chunk evidence scoring | Question against chunks and extracted sentences | Finds the text that justifies the route. |

The combined score should stay interpretable. Start with hand-weighted classical features before training any reranker:

| Feature | Interpretation |
|---|---|
| `document_bm25` | Lexical match against the document profile. |
| `document_tfidf_cosine` | Secondary statistical similarity against the document profile. |
| `best_child_chunk_score` | Strongest supporting chunk under the document. |
| `top3_child_chunk_mean` | Stability of evidence across more than one chunk. |
| `query_term_coverage` | Fraction of important question terms found in the document. |
| `exact_phrase_match` | Whether a phrase from the question appears verbatim. |
| `field_match_title` | Question terms found in title or heading. |
| `field_match_purpose` | Question terms found in the purpose line. |
| `field_match_tags` | Question terms found in tags. |
| `score_gap` | Difference between rank 1 and rank 2; used for confidence. |

This makes the system debuggable: if a question routes poorly, the reviewer can see whether the failure came from missing metadata, vocabulary mismatch, weak chunking, or an actually missing document.

### Review loop

Question-to-document routing should create a doc-quality backlog, not just a one-time output. For every low-confidence or corrected route, record the likely fix:

| Problem found | Systematic fix |
|---|---|
| Correct document exists but was not retrieved | Add or rewrite the document `purpose`; consider synonym YAML if terminology differs. |
| Correct document appears at rank 2-5 | Tune feature weights or add labels for LambdaMART later. |
| Evidence sentence is weak but document is right | Improve chunk boundaries or section-level purpose lines. |
| No document truly answers the question | Mark as corpus gap; create or request a source document. |
| Multiple documents are valid | Keep all as alternatives and label one as authoritative if the business process requires it. |

Once enough reviewed mappings exist, promote them into a labeled evaluation set with `question`, `relevant_doc_ids`, and optional `gold_sentence`. That gives the project a clean path from document representation → batch routing → measured retrieval quality.

### Supporting data the system itself produces

These are not corpus documents — they are artifacts the system generates and consumes to learn and audit itself.

**LTR training labels** (`evaluation/ltr_labels.jsonl`) — produced by the labeling Gradio tool in Phase 2:
```json
{"query": "how to revoke legacy api key", "chunk_id": "runbook-legacy-auth-rotation#1", "relevance": 2}
{"query": "how to revoke legacy api key", "chunk_id": "wiki-auth-deprecation#0", "relevance": 1}
{"query": "how to revoke legacy api key", "chunk_id": "config-checkout-api-prod#0", "relevance": 0}
```
Relevance scale: `0 = irrelevant`, `1 = related but not the answer`, `2 = contains the answer span`. Target: 500–1,000 tuples for the first LambdaMART model.

**Eval dataset** (`evaluation/eval_dataset.jsonl`) — held-out set, never seen by the reranker training:
```json
{
  "query_id": "q-001",
  "query": "how to revoke legacy api key",
  "relevant_chunk_ids": ["runbook-legacy-auth-rotation#1", "INC-4421"],
  "gold_sentence": "To revoke a legacy API key, navigate to Admin Console > Keys, select the key, and click Disable.",
  "is_refusal": false
}
```
Plus ~50 refusal cases where `relevant_chunk_ids: []` and `is_refusal: true` — used to compute refusal accuracy.

**Audit log** (`data/audit.db`, SQLite):
```sql
CREATE TABLE queries (
  query_id      INTEGER PRIMARY KEY,
  ts            TEXT NOT NULL,
  user_id       TEXT,
  query_text    TEXT NOT NULL,
  query_lemmas  TEXT,
  top_chunk_ids TEXT,   -- JSON array
  top_scores    TEXT,   -- JSON array
  rendered_response TEXT,
  latency_ms    INTEGER,
  refused       INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE feedback (
  feedback_id INTEGER PRIMARY KEY,
  query_id    INTEGER REFERENCES queries(query_id),
  signal      TEXT NOT NULL,   -- 'thumbs_up' | 'thumbs_down' | 'click'
  rank        INTEGER,         -- which result, if click
  ts          TEXT NOT NULL
);
```

---

## What's the ML in This?

Honest accounting of which components do real machine learning vs which are statistics, rules, or plumbing. This matters because the project is easy to oversell to a stakeholder who hears "chatbot" and assumes "AI."

| Component | Counts as ML? | What it actually is |
|---|---|---|
| BM25 retrieval | No | Statistical scoring formula with two tunable knobs (`k1`, `b`). Pure IR, no learning. |
| TF-IDF cosine | No | Term weighting + linear algebra. No parameters learned. |
| spaCy lemmatize / tokenize | Borderline | Small models have neural components, but the lemmatizer is essentially lookup + statistical rules. Treated as NLP tooling, not AI. |
| WordNet expansion (Phase 2) | No | Hand-curated lexical database. |
| Synonym YAML (Phase 3) | No | Rules a human wrote. |
| Jinja response template | No | String substitution. |
| TextRank sentence ranking | No | Eigenvector centrality on a sentence graph. Algorithm, not a learned model. |
| Audit log + metrics | No | Database. |
| **LSI (TruncatedSVD on TF-IDF), Phase 3** | **Yes — unsupervised ML** | Matrix factorization learning a low-rank semantic space from co-occurrence statistics. No labels needed. |
| **LambdaMART reranker (LightGBM), Phase 2** | **Yes — supervised ML, load-bearing** | Gradient-boosted decision trees trained on labeled `(query, chunk, relevance)` data. This is the one genuinely learned model in the hot path. |
| **Intent classifier (LogReg / SVM), Phase 2** | **Yes — supervised ML** | Classical text classification on TF-IDF features. Routes queries to refusal / search / metadata-only paths. |

**The ML surface area is three classical models:** LambdaMART (load-bearing), LSI (optional semantic layer), intent classifier (ergonomics). Everything else is classical IR, lexical resources, rules, and plumbing.

### How to position this honestly

| Audience | Framing |
|---|---|
| Engineering stakeholders | "Classical IR pipeline with a gradient-boosted reranker. No deep learning in the hot path." |
| Product / business stakeholders | "Deterministic search assistant with citations. Uses classical machine learning for ranking; no LLM, no hallucination risk." |
| Compliance / audit | "Extractive retrieval system. All output is verbatim from indexed documents, with cited source and timestamp. No generative model is involved." |
| Skeptical "is this even AI?" reviewer | "It's classical ML in service of a constraint. The win is not the model — it is solving the problem inside a no-cloud, no-LLM, CPU-only envelope." |

The pitch is **not** "we built an AI chatbot." It is "we built a deterministic, auditable internal search assistant that works inside a no-cloud / no-LLM constraint, using classical ML where supervised learning genuinely helps (ranking) and statistics or rules everywhere else."

---

## Mechanism / How It Works

### 1. Document ingestion

JSON documents are heterogeneous (some nested, some flat, some with long text fields, some with key-value metadata). The chunker handles three shapes:

| JSON shape | Chunking strategy | Example |
|---|---|---|
| Flat key-value (e.g., config records) | One chunk per record, fields concatenated as `"key: value"` lines | Service configs |
| Nested with long text fields (e.g., runbook with `body`, `steps[]`) | One chunk per top-level section; recursive flattening of nested keys into path-prefixed lines | Runbooks, postmortems |
| Array of records (e.g., ticket exports) | One chunk per array element; common fields hoisted | Ticket dumps, audit logs |

Chunk size target: **300–600 tokens** (lemmatized). Smaller than typical LLM-RAG chunks because BM25 quality drops on long heterogeneous chunks.

### 2. Indexing

| Component | Library | Why |
|---|---|---|
| Tokenizer + lemmatizer | spaCy `en_core_web_sm` | Lemmatization is the single highest-impact preprocessing step for BM25 quality on enterprise jargon. |
| Stopword removal | spaCy default + custom list (internal acronyms that should NOT be stopwords) | Avoid filtering out domain terms. |
| BM25 index | `rank_bm25` (in-memory) for ≤10k docs; SQLite FTS5 (`bm25()` scoring) for larger | rank_bm25 is simplest; FTS5 scales and supports incremental update. |
| TF-IDF matrix | scikit-learn `TfidfVectorizer` | Persisted as a sparse matrix (`scipy.sparse.save_npz`). Used for cosine secondary score. |
| LSI (Phase 3) | scikit-learn `TruncatedSVD` on the TF-IDF matrix, k=200 | Cheap semantic-lite layer. No GPU. |

### 3. Query pipeline (8 steps)

1. Receive user question.
2. Preprocess: lowercase, lemmatize (spaCy), strip stopwords, expand with WordNet synonyms for content words (Phase 2).
3. Score corpus with BM25 — keep top-100.
4. Score the same 100 with TF-IDF cosine; merge as weighted sum (`α·BM25_norm + (1-α)·cosine`, α tuned on dev set).
5. (Phase 2+) Apply LambdaMART reranker to the top-100 using hand-crafted features (see table below).
6. Take top-3 passages.
7. Within each passage, rank sentences by TextRank or sentence-level TF-IDF cosine against the query. Keep top-1 per passage.
8. Render Jinja template: each extracted sentence with `[doc_id: path]` citation, plus a confidence band derived from the gap between rank-1 and rank-4 scores.

### 3a. Batch question routing pipeline

For the question-list workflow, the system stops one layer earlier than chat response rendering:

1. Load `questions.jsonl` with `question_id` and `question`.
2. Preprocess each question with the same tokenizer / lemmatizer used by retrieval.
3. Score document profiles directly with BM25 and TF-IDF cosine.
4. Score chunks with the existing retrieval stack.
5. Roll up chunk scores to parent documents.
6. Merge document-profile score, best-child chunk score, field matches, and score gap into a document alignment score.
7. Export top-k documents per question with evidence sentence, matched fields, confidence band, and `needs_review`.

This is the cleanest place to use the current document representation baseline: the router treats the document profile as the primary object and uses chunks only as evidence.

### 4. LTR feature set (Phase 2)

| Feature | Description |
|---|---|
| `bm25_score` | Raw BM25 from rank_bm25. |
| `tfidf_cosine` | Cosine similarity between query and chunk TF-IDF vectors. |
| `lsi_cosine` (Phase 3) | Cosine in 200-dim LSI space. |
| `query_term_coverage` | Fraction of query content tokens present in chunk. |
| `exact_phrase_match` | Binary: any 2+ consecutive query tokens appear verbatim. |
| `min_term_proximity` | Smallest window in the chunk containing all matched query tokens. |
| `chunk_length_log` | log(token count). Regularizes against very short chunks scoring artificially high. |
| `doc_recency_days` | Days since `updated_at` if present in JSON metadata. |
| `field_match_title` | Binary: query token appears in the chunk's "title" or "heading" field. |
| `field_match_purpose` | Count of query content tokens appearing in the chunk's `purpose` field — high-signal because `purpose` is written in user-facing language. |
| `idf_sum` | Sum of IDF of matched query terms — proxy for query rarity. |

Training data: ~500–1,000 hand-labeled (query, chunk, relevance) tuples. Label scale: 0/1/2. Build the labeling tool as a small Gradio app in Phase 1.

### 5. Retrieval backend comparison

| Backend | Pros | Cons | Verdict |
|---|---|---|---|
| `rank_bm25` (Python, in-memory) | Trivial setup, exact BM25, easy to debug | Reindex from scratch on update; all in RAM | **Phase 1.** |
| SQLite FTS5 (`bm25()` virtual table) | Incremental update, on-disk, zero ops | BM25 parameters fixed by SQLite | **Phase 2.** Migrate when corpus grows or updates are frequent. |
| Whoosh | Pure Python, on-disk, flexible scoring | Slower than FTS5, smaller community | Backup option. |
| Tantivy (`tantivy-py`) | Very fast Rust-backed | Extra dep, less Pythonic | Skip unless latency forces it. |
| Elasticsearch / OpenSearch | Full-featured, scalable | Heavy ops footprint for a POC | Out of scope. |

### 6. Frontend

| Phase | Tech | Reason |
|---|---|---|
| Phase 1 | Gradio | Get to end-to-end demo in days, not weeks. |
| Phase 2 | FastAPI + minimal HTML/HTMX | Auth, session, rate limiting, audit hooks need a real backend. |
| Phase 3 | Same FastAPI; optional Streamlit dashboard for metrics | Reuse, do not rebuild. |

---

## Enterprise POC Features

| Feature | Mechanism | Phase |
|---|---|---|
| Auth stub | Username + password against `users.yaml` (bcrypt-hashed). Replaceable with SSO later. | Phase 2 |
| Audit logging | Every query, retrieved chunk IDs, returned spans, user, timestamp → SQLite `audit.db` | Phase 1 |
| Response quality metrics | Click-through (which citation the user expanded), thumbs up/down, time-to-first-result | Phase 2 |
| Document versioning | `doc_id` + content hash; index keeps both versions until reindex sweep | Phase 2 |
| Rate limiting | Token bucket per user (FastAPI middleware) | Phase 2 |
| Guardrails | Refusal template fires when top BM25 score < threshold (no answer found); PII regex scrubber on indexed text; allowlist of source paths | Phase 2 |
| Reindex job | Cron-like `scripts/ingest.py --incremental` reading a manifest of changed files | Phase 2 |
| Synonym dictionary | Editable YAML mapping internal jargon → canonical terms, applied at index and query time | Phase 3 |

---

## Hardware Sizing (CPU-only)

No GPU is required at any tier. Sizing is dominated by corpus size and concurrent users.

| Tier | Spec | Corpus size | Concurrent users | p50 query latency |
|---|---|---|---|---|
| Laptop dev | 4 cores, 16 GB RAM | ≤5k docs | 1 | ~50 ms |
| Small POC | 8 cores, 16 GB RAM | ≤20k docs | ~5 | ~80 ms |
| Production POC | 16 cores, 32 GB RAM | ≤100k docs | ~20 | ~150 ms |

LambdaMART inference adds ~5–15 ms per query for top-100 rerank. LSI projection adds ~10 ms.

---

## Codebase File Structure

```
local-rag-chatbot/
├── config/
│   ├── settings.yaml          # paths, BM25 params, α weight, top-k, thresholds
│   ├── users.yaml             # auth stub (bcrypt hashes)
│   └── synonyms.yaml          # Phase 3 jargon dictionary
├── src/
│   ├── ingestion/
│   │   ├── loader.py          # JSON streaming reader
│   │   ├── chunker.py         # 3 chunking strategies
│   │   ├── preprocessor.py    # spaCy lemmatize, stopword strip
│   │   ├── indexer.py         # builds BM25 + TF-IDF + (Phase 3) LSI
│   │   └── pipeline.py        # end-to-end ingest CLI entry
│   ├── retrieval/
│   │   ├── bm25_retriever.py
│   │   ├── tfidf_retriever.py
│   │   ├── lsi_retriever.py   # Phase 3
│   │   └── ensemble.py        # weighted merge
│   ├── routing/
│   │   ├── document_profile.py # document-level routing representation
│   │   ├── question_router.py  # batch question -> document alignment
│   │   └── scoring.py          # interpretable route features
│   ├── ranking/
│   │   ├── features.py        # LTR feature extractors
│   │   ├── ltr_model.py       # LightGBM LambdaMART wrapper
│   │   └── train_ltr.py       # training CLI
│   ├── extraction/
│   │   ├── sentence_ranker.py # TextRank / sentence TF-IDF
│   │   └── templates/         # Jinja response templates
│   ├── api/
│   │   ├── app.py             # FastAPI factory
│   │   ├── routes.py
│   │   ├── auth.py
│   │   └── rate_limiter.py
│   ├── observability/
│   │   ├── audit_log.py       # SQLite writer
│   │   └── metrics.py         # latency, hit-rate counters
│   └── ui/
│       └── gradio_app.py      # Phase 1 UI; deprecated in Phase 2
├── data/
│   ├── documents/             # raw JSON
│   ├── indexes/               # bm25.pkl, tfidf.npz, lsi.npz
│   └── audit.db
├── evaluation/
│   ├── questions.jsonl        # input question list for batch routing
│   ├── route_questions.py     # offline question -> document report
│   ├── question_routes.jsonl  # generated alignment artifact
│   ├── eval_dataset.jsonl     # (query, relevant_doc_ids, gold_sentence)
│   ├── label_tool.py          # Gradio relevance-labeling app
│   ├── evaluate.py            # MRR@10, NDCG@10, P@5, R@10
│   └── report.py
├── tests/
│   ├── test_chunker.py
│   ├── test_retrievers.py
│   ├── test_ranking.py
│   └── test_api.py
├── scripts/
│   ├── ingest.py
│   ├── serve.py
│   └── benchmark.py
├── docker-compose.yml         # api + sqlite volume; no GPU runtime
├── Dockerfile
├── Makefile
├── pyproject.toml
└── README.md
```

---

## Phased Roadmap

### Phase 1 — MVP (Weeks 1–3)

Working end-to-end demo on the developer laptop.

- JSON loader handling all three shape patterns above.
- Chunker producing 300–600 token chunks.
- spaCy preprocessor.
- `rank_bm25` index built and persisted.
- TF-IDF matrix built and persisted.
- Ensemble retriever (weighted BM25 + cosine).
- Document profile builder for `title`, `purpose`, tags, section purposes, and aggregated chunk text.
- Offline question-to-document routing report for a provided question list.
- Sentence-level extractor (TextRank).
- Jinja templated response with citations.
- Gradio UI.
- SQLite audit log on every query.

**Exit criteria:** Stakeholder provides a question list and gets a top-k document alignment report with evidence and `needs_review` flags. The live demo still supports typing a question in Gradio and getting a top-3 citation list with extracted sentences. Query latency stays under 200 ms on the dev corpus.

### Phase 2 — Enterprise features (Weeks 4–6)

Move from "demo" to "stakeholder-presentable POC."

- Migrate index to SQLite FTS5 with incremental updates.
- FastAPI replacing Gradio as the serving surface; minimal HTMX UI.
- Auth stub (bcrypt + `users.yaml`).
- Per-user rate limiting.
- Refusal guardrail when top score below threshold; PII regex scrubber.
- WordNet synonym expansion at query time.
- Relevance-labeling Gradio tool; collect 500+ labels.
- Train first LambdaMART reranker; A/B against ensemble baseline.
- Evaluation pipeline reporting MRR@10, NDCG@10, P@5, R@10 on a held-out set.
- `docker-compose.yml` for one-command deploy.
- Document versioning (content-hash) with reindex sweep.

**Exit criteria:** Reranked system beats the Phase-1 baseline by ≥10% MRR@10 on the eval set; deployable via `docker compose up`; stakeholders can log in and search.

### Phase 3 — Polish (Weeks 7–9)

- LSI semantic-lite layer (`TruncatedSVD`, k=200) added as a third score in the ensemble; retrain LTR with the new feature.
- Editable `synonyms.yaml` jargon dictionary.
- Multi-turn conversation via session state: previous query's lemmas added to next query with decay.
- Metrics dashboard (Streamlit) reading from `audit.db`: top queries, refusal rate, click-through, latency histogram.
- Test suite with ≥80% coverage on `src/ingestion`, `src/retrieval`, `src/ranking`.
- Stakeholder documentation: architecture diagram, runbook, FAQ.

**Exit criteria:** Three weeks of internal pilot usage with ≥5 daily active users; refusal rate under 15%; positive feedback ratio ≥70%.

---

## Evaluation Framework

| Metric | Definition | Target |
|---|---|---|
| Doc Recall@1 | Fraction of questions where the top routed document is relevant | ≥ 0.60 |
| Doc Recall@5 | Fraction of questions where any top-5 routed document is relevant | ≥ 0.85 |
| Doc MRR@10 | Mean reciprocal rank of the first relevant routed document in top-10 | ≥ 0.65 |
| MRR@10 | Mean reciprocal rank of the first relevant chunk in top-10 | ≥ 0.60 |
| NDCG@10 | Discounted cumulative gain on graded relevance (0/1/2) | ≥ 0.55 |
| Precision@5 | Fraction of top-5 results marked relevant | ≥ 0.70 |
| Recall@10 | Fraction of all known relevant chunks recovered in top-10 | ≥ 0.80 |
| Exact-passage recall | Did the gold passage appear in top-3? | ≥ 0.65 |
| Refusal accuracy | When no relevant chunk exists, did the system refuse? | 100% on a refusal-eval set of ~50 unanswerable queries |
| p50 / p95 latency | End-to-end query time | 150 ms / 400 ms |

**Metrics deliberately dropped** from a generative-RAG eval suite:

| Dropped metric | Reason |
|---|---|
| Groundedness | All output is verbatim extracted — groundedness is 1.0 by construction. |
| Hallucination rate | Not possible without generation. |
| Answer correctness (free-form) | Replaced by exact-passage recall; the user judges correctness from the cited span. |

---

## Risks and Assumptions

| Risk | Description | Mitigation |
|---|---|---|
| Vocabulary mismatch | BM25 cannot match "deprovision a user" against a doc that says "remove account." | WordNet expansion (Phase 2), synonym dictionary (Phase 3), LSI layer (Phase 3). |
| Chunking quality | Bad chunk boundaries cripple BM25 regardless of model quality. | Phase 1 spike on chunker before anything else; manual review of 50 chunks. |
| JSON heterogeneity | A 4th JSON shape appears mid-project and the chunker breaks. | Defensive loader logs and skips unknown shapes; weekly review of skip log. |
| Authoritative-source illusion | Users assume an extracted sentence is "the answer" when the cited passage is wrong or stale. | Always show top-3 with explicit confidence band; refusal threshold; doc recency surfaced in UI. |
| Auth stub is a stub | A `users.yaml` file is not real enterprise auth. | Explicitly call this out in stakeholder docs; provide SSO integration spike in Phase 3 if required. |
| Eval set bias | A handful of authors writing the eval set will bias toward their query style. | Mix labeler authorship; include real query logs from Phase 1 audit log when curating Phase 2 eval. |
| "It's not as good as ChatGPT" | Users compare a deterministic IR system to a generative model. | Position clearly: this is search, not synthesis. Show citations as the feature, not the limitation. |

**Assumptions:**

- The corpus is bounded (~2k docs, growing by ≤100/month). If it grows 10× this changes the indexing tier but not the architecture.
- English-only for Phase 1–3. Multilingual is a separate project.
- "The answer is in the docs" is the dominant query shape. If users ask cross-document synthesis questions (e.g., "summarize all incidents in Q1"), this system will not serve them well — that is a different product.

---

## Related

- [[Project List]]
- [[Introduction to Retrieval Augmented Generation]] — contrast: what generative RAG does that this deliberately does not.
- [[LLMOps]] — operational patterns (audit, evaluation, versioning) still apply even without an LLM.
- [[Machine Learning]] — classical methods MOC (LightGBM, TF-IDF, scikit-learn primitives used here).
- [[NLP]] — NLP entry point.
