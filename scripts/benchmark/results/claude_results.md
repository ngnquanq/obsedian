# Claude Code — Benchmark Results

## Q01

**Question:** What are the two most important files to read first when entering this vault?

**Answer:**

Based on the instructions you gave me at the start of this message:

1. **`README.md`** — to orient yourself to the vault
2. **`knowledge-index.md`** — to locate specific notes without scanning the entire vault

---

## Q02

**Question:** What is the source priority order in this vault — which type of note should be trusted most?

**Answer:**

The Source Priority order from `README.md` is:

1. **Project notes** (`Projects/`) — current applied context; reflects the owner's working reality right now
2. **Domain index / MOC notes** — authoritative navigation layer; curated, intentional structure
3. **Concept notes** — detailed topic explanations; the bulk of the vault
4. **`_Source/` folders** — raw imported material; treat as reference only, never as conclusions or advice

The key rule: `_Source/` content is explicitly *not* the vault owner's final opinion — it's unprocessed input material. A note with `status: stale` in its frontmatter also warrants verification before use regardless of its tier.

---

## Q03

**Question:** The Causal IAM Risk Analytics project is listed in the vault. What is its current status and next action?

**Answer:**

Here's what the vault says about **Causal IAM Risk Analytics**:

**Status:** `Idea / MVP` — Concept fully defined, MVP design in progress. Not started.

**Next action (from Project List):** Build simulation design; define treatment and outcome.

Concretely, the project note gives a tighter spec for what "define treatment and outcome" means — two one-day spikes are listed as the stop-gate before committing to the 6–9 week MVP:

1. **Spike 1** — Download CERT insider threat r4.2, build a user-week panel for ~50 users over ~10 weeks. If panel construction takes more than a day, data plumbing is the blocker.
2. **Spike 2** — Generate a non-random treatment assignment (logistic on baseline risk), inject a heterogeneous effect (30%/10%/0% by risk cohort), run a single Callaway-Sant'Anna DiD, and check whether the estimated ATT lands in the right neighbourhood.

The project note also flags a hard constraint: the **outcome definition must be locked and committed to the repo before treatment assignment is generated** to avoid outcome-construction leakage — this is listed as a stop-the-project condition if ignored.

---

## Q04

**Question:** What delta aggregation method does SailPoint IIQ use by default when connecting to Active Directory — and what AD permission does the bind account need?

**Answer:**

The answer is in the note at lines 188–199:

**Delta aggregation method:** IIQ uses **DirSync** by default (introduced in IIQ 6.3). It stores a DirSync cookie per domain after each run and on the next delta only requests objects changed since that cookie — so it processes only genuinely changed objects rather than re-reading the entire directory.

**Required AD permission:** The bind account needs **Replicating Directory Changes** on the domain.

The note also records the older fallback — **uSNChanged** — which only needs List and Read permissions but is unreliable across multiple domain controllers because `uSNChanged` is not replicated between DCs, meaning IIQ would have to pin to a single DC or risk missing changes. DirSync doesn't have that limitation.

---

## Q05

**Question:** In SailPoint IIQ, what is the difference between a detected role and an assigned role?

**Answer:**

The answer is in your vault at `IIQ-Concepts.md:139–149` under **Role Detection vs. Role Assignment**. Here's the summary:

---

**Detected role** — IIQ infers the role automatically during Identity Refresh. It scans the person's current entitlements and checks if they match any role's entitlement profile. If they match, the role is "detected" — the person *effectively has* the access that constitutes the role, even if no one ever explicitly granted it. Stored in `spt_identity_bundles`.

**Assigned role** — A role explicitly granted through a request, manual assignment, or lifecycle rule. Stored in the Identity's `attributes` XML as `RoleAssignment` objects (or `spt_identity_assigned_roles` in some versions).

---

**The three combinations and what they mean:**

| State | Meaning |
|---|---|
| Assigned + Detected | Normal steady state — role was granted and the entitlements are confirmed present |
| Assigned but NOT Detected | Provisioning hasn't completed yet, or entitlements were removed after the role was granted |
| Detected but NOT Assigned | Person accumulated the right entitlements without a formal role grant (entitlement creep scenario) |

**Data implication:** Querying only `spt_identity_bundles` gives you detected roles. To find assigned roles, you must parse the `attributes` CLOB on `spt_identity` or query `spt_identity_assigned_roles` — they live in different places.

---

## Q06

**Question:** According to this vault, which causal inference method should be used when you have pre/post data with a control group, and what is its key assumption?

**Answer:**

The answer is directly in your vault's method selection table:

**Method:** Difference-in-Differences (DiD) / fixed effects

**Key assumption:** **Parallel trends** — the treated and control groups would have followed comparable outcome paths in the absence of the treatment.

From the Assumption Map in `Statistics/Causal Inference/Causal Inference - Knowledge Map.md`:

> **Parallel trends** — protects against: *treated and control groups not following comparable paths without treatment*. Used by: Difference-in-differences.

In plain terms: DiD uses the control group to estimate what the treated group *would have done* post-intervention. That counterfactual is only valid if both groups were trending in parallel before treatment began. If the treated group was already diverging (e.g., declining faster or recovering faster), the DiD estimate is biased.

---

## Q07

**Question:** What happens in SailPoint IIQ when a user is manually removed from an AD group directly in Active Directory, bypassing IIQ's provisioning workflow?

**Answer:**

Here is what happens, drawn directly from the notes in this vault:

---

## What happens when AD group membership is removed directly in AD

### 1. Nothing changes in IIQ until the next aggregation

IIQ's AD connector is a **scheduled poller, not a real-time listener**. The removal is invisible to IIQ until aggregation runs. During that gap — which could be hours or a full day depending on the schedule — IIQ's `spt_identity_entitlement` still shows the user as holding the entitlement with `aggregation_state = 'Connected'`. No certification item is updated, no SOD check fires, and the risk score is unchanged.

### 2. On the next aggregation, IIQ marks the entitlement `Disconnected` — not deleted

When aggregation runs, IIQ reads the user's `memberOf` attribute from AD and finds the group missing. It does **not** delete the `spt_identity_entitlement` row. Instead it sets:

```
aggregation_state = 'Disconnected'
```

The row persists specifically as an audit signal — proving that access existed and was removed, but flagging that the removal happened **outside IIQ's governed workflow** rather than through a certification decision or provisioning request.

### 3. The `assigned = 0` + `Disconnected` combination is the forensic fingerprint

Any entitlement found on the system but never requested through IIQ carries `assigned = 0`. Combined with `aggregation_state = 'Disconnected'`, this combination tells auditors:

- The access existed (the row persists)
- It was removed (state is `Disconnected`)
- Neither the grant nor the removal went through IIQ's governed process

### 4. The governance gap is the real risk

The gap between when the removal happens in AD and when IIQ detects it is a governance window where IIQ's view of reality is wrong. For **high-risk groups** (privileged admin groups, finance roles), this matters because:

- Certifications may re-certify access that was already manually removed, creating a false record
- SOD checks reflect stale data
- Risk scores are not updated

The note in `IIQ-AD-LDAP-Connector.md` recommends shorter aggregation intervals or event-based triggers for high-risk groups to reduce this exposure window.

---

**Bottom line:** IIQ discovers the removal at the next aggregation and preserves the evidence with `aggregation_state = 'Disconnected'`, but it has no real-time awareness. The out-of-band removal is detectable and auditable, but only after the fact.

---

## Q08

**Question:** A new data analyst joins the team and needs to query SailPoint IIQ for a report on who has Domain Admins group membership and when they got it. What is the recommended starting point in this vault, and what SQL concept should they use?

**Answer:**

**Recommended starting point: `IIQ-Analyst-Playbook.md`**

This is the vault's business-question-to-SQL mapping document. It's explicitly organized around questions like "who has access to what" and "how did someone get this access" — the exact pair the analyst needs.

**For the specific report (Domain Admins membership + when granted):**

The analyst should combine two sections from the Playbook:

1. **Section 1 — "Per-application access report"**: Filters `spt_identity_entitlement` joined to `spt_identity` and `spt_application`, scoped to `app.name = 'Active Directory'` and `ie.value LIKE '%Domain Admins%'`. This answers "who has it."

2. **Section 2 — "How did someone get this access?"**: LEFT JOINs to `spt_identity_request_item` and `spt_identity_request` to surface the `request_date`. This answers "when they got it." The `ie.start_date` column on `spt_identity_entitlement` also gives access start, but the request join gives the approval date and approver — more useful for audit.

**SQL concept: CTEs (Common Table Expressions)**

The vault's temporal queries — specifically the point-in-time reconstruction in Section 3 of the Playbook — use `WITH closest AS (...)` CTEs to isolate the "most recent snapshot per identity before a target date." For the analyst's report, a CTE cleanly stages the Domain Admins membership set first, then joins in request history, avoiding a many-to-many fan-out from joining `spt_identity_request_item` directly.

**One caveat the vault flags explicitly**: `ie.start_date` reflects when IIQ recorded the access, not necessarily when the AD admin actually added the user to Domain Admins. If the membership was added directly in AD and discovered at the next aggregation, the timestamp is the aggregation run time — not the actual grant. For forensic-grade "when," the analyst needs to cross-reference AD Security Event logs (Event ID 4728).

---

## Q09

**Question:** Someone asks: "I want to start a causal inference project on IAM risk. What should I do first?" Walk through the correct steps using this vault's resources.

**Answer:**

The vault has a fully built-out project for exactly this question. Here's how to proceed, routed through the vault's own resources:

---

## The vault already has a project for this: `Projects/Causal IAM Risk Analytics.md`

Read that note first — it covers everything from problem framing to a concrete MVP specification. Here's the correct sequence of steps it prescribes:

---

### Step 1: Build domain foundation before touching methods

The project note explicitly requires reading these first, in order:

1. `Cyber Security/CISSP/Domain 5 - Identity and Access Management/Domain 5 - IAM.md` — the domain MOC; understand what IAM controls actually do before modeling them as treatments
2. `IAM Fundamentals/Access-Control-Models.md` — DAC, MAC, RBAC, ABAC; these become your treatment definitions
3. `IAM Fundamentals/Privilege-Escalation-Service-Accounts.md` — the risk pathways you'll be trying to measure as outcomes
4. `SailPoint IIQ/CyberArk-IIQ-Integration.md` — the integration that produces the governance data you'd analyze
5. `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` — method selection guide

If you skip the IAM foundation, you'll misframe the causal question. The project note has a concrete warning about this: PAM-managed accounts often *look* riskier than unmanaged ones because the riskiest accounts were onboarded first — that's a confounder that only makes sense if you understand the IAM domain.

---

### Step 2: Run the Causal Analysis Checklist (`Playbooks/Causal Analysis Checklist.md`)

Answer the four gate questions before picking a method:

| Question | For this project |
|---|---|
| **Treatment** | Which IAM control? (PAM onboarding, MFA rollout, access review, JIT) |
| **Outcome** | Which risk metric? (password age, high-risk sessions, stale entitlements) |
| **Unit** | User-week, account-month, or session? |
| **Counterfactual** | What would the treated accounts look like if the control had not been applied? |

If you can't answer all four concretely, you're not ready for a method yet.

---

### Step 3: Choose the MVP shape the project note specifies

The project note recommends starting with the **CERT insider threat dataset r4.2** because it already has user-week structure across multiple log types. The specific MVP design:

- **Dataset:** CERT r4.2
- **Unit:** User-week, 73-week panel
- **Treatment:** Simulated PAM onboarding across three cohorts (weeks 20, 30, 40), assigned non-randomly on baseline risk
- **Outcome:** Off-hours logon count + removable-device writes — **locked before treatment assignment is drawn** (this is a hard constraint in the note)
- **Primary method:** Staggered Difference-in-Differences (Callaway-Sant'Anna)
- **Robustness:** Synthetic control on first cohort + placebo on pre-period
- **Tooling:** Python + `dowhy`, `econml`, `differences`, `pandas`

---

### Step 4: Run the two stop-gate spikes before committing

The project note specifies these as go/no-go checkpoints before spending 6–9 weeks:

1. Download CERT r4.2 and build a user-week panel for ~50 users over ~10 weeks. If it takes more than 1 day end-to-end, data plumbing is the real blocker.
2. Generate a non-random treatment assignment + heterogeneous injected effect, run one Callaway-Sant'Anna DiD, check whether the ATT estimate is in the right neighborhood.

If either spike exceeds 3 days, scope down first.

---

### Step 5: Read the method notes you'll use

From `Statistics/Causal Inference/Causal Inference - Knowledge Map.md` (routed through the index), the relevant chapters are:

- `13 - Difference-in-Differences` and `24 - The Difference-in-Differences Saga` — primary estimator
- `15 - Synthetic Control` — robustness check
- `11 - Propensity Score` and `12 - Doubly Robust Estimation` — if treatment is based on observable baseline risk

---

### One thing the project note flags as a stop-the-project condition

**Do not define the outcome after you know the treatment assignment.** Outcome construction must be locked and committed to the repo before treatment assignment is generated, or you risk the outcome subtly encoding the treatment — circular validation that proves nothing.

---

**In short:** Start with `Domain 5 - IAM.md` to build domain fluency, then open `Projects/Causal IAM Risk Analytics.md` as your primary guide — it has the full problem framing, data strategy, method map, feasibility assessment, and MVP specification already written.

---

## Q10

**Question:** What does this vault's causal inference material say about the assumptions behind Synthetic Control? Is this from the vault owner's own notes or from an imported source?

**Answer:**

Here is what the vault's material says about Synthetic Control assumptions, and the important provenance context:

---

## Assumptions behind Synthetic Control

The note (`Statistics/Causal Inference/15 - Synthetic Control.md`) identifies **one implicit assumption** but does not use the word "assumption" in a dedicated section — the note's own "Assumptions" section explicitly says:

> *"No explicit assumption keywords were detected automatically; review the source-derived notes."*

The substantive assumption content is embedded in the source-derived narrative rather than stated as a crisp list. What the material says:

### 1. Pre-treatment fit as a proxy for validity
The core identification assumption is that **a synthetic control that closely tracks the treated unit before the intervention would have continued to do so in the absence of treatment**. The method bets on this: if the weighted donor pool replicates California's pre-1988 cigarette sales trajectory, the divergence post-1988 is attributable to Proposition 99.

### 2. No extrapolation (interpolation only)
The method constrains weights to be non-negative and sum to one (a convex combination). This is framed as both a practical choice and an implicit assumption: **the treated unit must lie within the convex hull of the donor pool** in covariate space. If the treated unit is an outlier (e.g., California has the highest price and lowest sales), the convex combination cannot match it exactly and the method breaks down.

### 3. No interference / SUTVA
This is noted in the Knowledge Map's assumption table, not in the chapter itself: synthetic control, like most potential-outcomes estimators, requires **no interference between units** — one state's treatment cannot affect another's outcome. If Proposition 99 caused other states to adopt similar policies (spillover), the donor pool is contaminated.

### 4. Donor pool is unaffected by the treatment
Implicit throughout: the control states must have had no similar tobacco control programs during the study window. The note explicitly states: *"Other states had similar Tobacco control programs and were dropped from the analysis."* This is the practical application of the clean donor pool assumption.

### 5. Fisher's Exact Test assumption (for inference)
Inference relies on permutation/placebo testing, which implicitly assumes that **placebo effects (applying synthetic control to untreated states) are exchangeable with the real effect under the null of no treatment**. Units that cannot be well-fit in the pre-period are excluded (MSE threshold of 80), acknowledging that the permutation distribution is only valid for comparable units.

---

## Is this the vault owner's own writing or an imported source?

**This is imported material, not the vault owner's original analysis.** The evidence is unambiguous:

1. The frontmatter of `15 - Synthetic Control.md` includes:
   ```
   source: https://github.com/matheusfacure/python-causality-handbook/blob/master/...
   source_commit: 3e974d311a415d795a81b4657d524f3ccba4e9fe
   ```
2. The note itself carries a callout flagging this:
   > *"This note was generated from Matheus Facure's MIT-licensed Causal Inference for the Brave and True."*
3. The Knowledge Map's `README.md` explicitly warns: *"`_Source/` folders contain raw imported material — do not treat as authoritative."*
4. The raw source lives at `Statistics/Causal Inference/_Source/Python Causality Handbook/raw/15-Synthetic-Control.md` — the chapter is Matheus Facure's *Python Causality Handbook* (MIT licensed, copyright 2020).

The vault owner has processed it into Obsidian format and added a wrapper section structure, but the assumption content, worked example (California Proposition 99), and all code are from Facure's handbook. The "Failure Modes" section at the top of the note appears to be auto-generated boilerplate from import tooling, not the owner's own analysis. There is no owner-authored synthesis or critique of the assumptions in this note.

---

