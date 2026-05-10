---
status: active
type: playbook
updated: 2026-05-10
---

# Playbook: Start a New Project

Follow these steps every time you initialize a new project in this vault.

---

## Steps

**1. Define the domain and problem**
- What domain does this belong to? (Cyber Security / ML / NLP / Finance / Data Engineering)
- What is the core question or outcome you want to achieve?
- Is this exploratory (Idea) or do you have a concrete plan (MVP / Draft)?

**2. Check existing notes**
- Search the vault for related concept notes before creating new ones
- Check `knowledge-index.md` for existing coverage in the relevant domain
- Check `Projects/Project List.md` for similar or overlapping projects

**3. Create the project file**
- Create `Projects/<Project Name>.md`
- Add frontmatter: `status`, `domain`, `updated`
- Sections to include:
  - **Problem** — what question this project answers
  - **Data** — what data is needed; availability and source
  - **Method** — planned approach (algorithm, model, causal method)
  - **Next Action** — the single most immediate step
  - **Related** — links to relevant concept notes

**4. Register in Project List**
- Add a row to `Projects/Project List.md` with status and next action
- Keep the next action column current — it is the primary navigation signal

**5. Link from domain notes**
- Add a link to the project from the relevant domain MOC or concept note
- Ensures the project is reachable from both the domain and the project registry

**6. Identify data**
- Is real data available? If not, is synthetic/simulated data sufficient?
- Note the unit of analysis, key variables, and any known gaps
- If causal inference is involved, run `Playbooks/Causal Analysis Checklist.md` before committing to a method

---

## Related

- `Projects/Project List.md` — the project registry
- `Playbooks/Causal Analysis Checklist.md` — method selection for causal projects
- `Playbooks/Evaluate a Dataset.md` — dataset readiness assessment
- `knowledge-index.md` — find existing notes to link from
