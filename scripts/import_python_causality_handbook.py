#!/usr/bin/env python3
"""Import Causal Inference for the Brave and True into this Obsidian vault."""

from __future__ import annotations

import argparse
import base64
import json
import re
import shutil
import subprocess
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Iterable

import nbformat
import yaml


REPO_URL = "https://github.com/matheusfacure/python-causality-handbook.git"
REPO_WEB = "https://github.com/matheusfacure/python-causality-handbook"
SITE_URL = "https://matheusfacure.github.io/python-causality-handbook"
SOURCE_SUBDIR = "causal-inference-for-the-brave-and-true"

VAULT_ROOT = Path(__file__).resolve().parents[1]
TARGET_DIR = VAULT_ROOT / "Statistics" / "Causal Inference"
SOURCE_DIR = TARGET_DIR / "_Source" / "Python Causality Handbook"
RAW_DIR = SOURCE_DIR / "raw"
ASSET_DIR = SOURCE_DIR / "assets"
DATA_DIR = SOURCE_DIR / "data"
HELPER_DIR = SOURCE_DIR / "helpers"
DEFAULT_CLONE_DIR = Path("/tmp/python-causality-handbook")


CONCEPT_LINKS = {
    "ate": "Average Treatment Effect",
    "average treatment effect": "Average Treatment Effect",
    "att": "Average Treatment on the Treated",
    "confounding": "Confounding",
    "confounder": "Confounding",
    "randomized": "Randomized Experiments",
    "randomised": "Randomized Experiments",
    "potential outcome": "Potential Outcomes",
    "dag": "DAGs",
    "graphical causal": "DAGs",
    "instrumental variable": "Instrumental Variables",
    "late": "LATE",
    "matching": "Matching",
    "propensity score": "Propensity Score",
    "doubly robust": "Doubly Robust Estimation",
    "difference-in-differences": "Difference in Differences",
    "diff-in-diff": "Difference in Differences",
    "fixed effects": "Fixed Effects",
    "synthetic control": "Synthetic Control",
    "regression discontinuity": "Regression Discontinuity",
    "heterogeneous treatment": "Heterogeneous Treatment Effects",
    "meta learner": "Meta-Learners",
    "meta-learner": "Meta-Learners",
    "orthogonal": "Orthogonal Machine Learning",
    "double machine learning": "Double Machine Learning",
    "causal model": "Causal Model Evaluation",
}

ASSUMPTION_HINTS = {
    "exchangeability": "Exchangeability",
    "unconfoundedness": "Unconfoundedness",
    "ignorability": "Ignorability",
    "overlap": "Overlap / Positivity",
    "positivity": "Overlap / Positivity",
    "exclusion": "Exclusion Restriction",
    "parallel trends": "Parallel Trends",
    "continuity": "Continuity",
    "interference": "No Interference / SUTVA",
    "sutva": "SUTVA",
}


@dataclass
class Entry:
    part: str
    source_file: str
    source_path: Path
    raw_path: Path
    note_path: Path
    title: str
    source_url: str
    site_url: str
    kind: str
    order: int


def run(cmd: list[str], cwd: Path | None = None) -> str:
    result = subprocess.run(cmd, cwd=cwd, text=True, capture_output=True, check=True)
    return result.stdout.strip()


def slug_title(value: str) -> str:
    value = re.sub(r"\.ipynb$|\.md$", "", value)
    value = re.sub(r"^\d+[-_\s]*", "", value)
    value = value.replace("-", " ").replace("_", " ")
    value = re.sub(r"\s+", " ", value).strip()
    acronyms = {"to", "and", "with", "for", "the", "of", "in"}
    words = []
    for word in value.split(" "):
        low = word.lower()
        if low in {"iv", "late", "ate", "att", "dag", "dags"}:
            words.append(low.upper())
        elif low in acronyms:
            words.append(low)
        else:
            words.append(word[:1].upper() + word[1:])
    titled = " ".join(words)
    return titled[:1].upper() + titled[1:]


def safe_filename(title: str, prefix: str | None = None) -> str:
    clean = re.sub(r"[\\/:*?\"<>|]", " ", title).strip()
    clean = re.sub(r"\s+", " ", clean)
    if prefix:
        return f"{prefix} - {clean}.md"
    return f"{clean}.md"


def yaml_list(items: Iterable[str]) -> str:
    escaped = [item.replace('"', '\\"') for item in items]
    return "[" + ", ".join(f'"{item}"' for item in escaped) + "]"


def clone_or_refresh(repo_dir: Path) -> None:
    if repo_dir.exists():
        run(["git", "fetch", "--depth", "1", "origin"], cwd=repo_dir)
        run(["git", "checkout", "origin/master"], cwd=repo_dir)
        return
    run(["git", "clone", "--depth", "1", REPO_URL, str(repo_dir)])


def read_toc(book_dir: Path) -> tuple[str, list[tuple[str, str]]]:
    toc = yaml.safe_load((book_dir / "_toc.yml").read_text(encoding="utf-8"))
    files: list[tuple[str, str]] = []
    root = toc["root"]
    root_file = root if root.endswith((".md", ".ipynb")) else f"{root}.md"
    files.append(("Book Overview", root_file))
    for part in toc.get("parts", []):
        caption = part.get("caption", "Book")
        for chapter in part.get("chapters", []):
            if "file" in chapter:
                files.append((caption, chapter["file"]))
    return root_file, files


def first_markdown_heading(markdown: str, fallback: str) -> str:
    for line in markdown.splitlines():
        match = re.match(r"^#\s+(.+?)\s*$", line)
        if match:
            title = re.sub(r"\{.*?\}", "", match.group(1)).strip()
            title = re.sub(r"^\d+\s*[-.:]\s*", "", title).strip()
            if title:
                return title
    return fallback


def convert_notebook(source_path: Path, raw_path: Path, asset_subdir: str) -> str:
    notebook = nbformat.read(source_path, as_version=4)
    asset_output_dir = ASSET_DIR / asset_subdir
    if asset_output_dir.exists():
        shutil.rmtree(asset_output_dir)
    asset_output_dir.mkdir(parents=True, exist_ok=True)
    chunks: list[str] = []
    for cell_index, cell in enumerate(notebook.cells):
        if cell.cell_type == "markdown":
            chunks.append(cell.source.rstrip())
            continue
        if cell.cell_type != "code":
            continue
        source = cell.source.rstrip()
        if source:
            chunks.append("```python\n" + source + "\n```")
        output_chunks = []
        for output_index, output in enumerate(cell.get("outputs", [])):
            output_type = output.get("output_type")
            if output_type == "stream" and output.get("text"):
                output_chunks.append("```text\n" + as_text(output["text"]).rstrip() + "\n```")
                continue
            data = output.get("data", {})
            if "image/png" in data:
                filename = f"cell-{cell_index:03d}-output-{output_index:02d}.png"
                image_data = data["image/png"]
                if isinstance(image_data, list):
                    image_data = "".join(image_data)
                (asset_output_dir / filename).write_bytes(base64.b64decode(image_data))
                output_chunks.append(
                    f"![[Statistics/Causal Inference/_Source/Python Causality Handbook/assets/{asset_subdir}/{filename}]]"
                )
                continue
            text_value = data.get("text/plain") or output.get("text")
            if text_value:
                output_chunks.append("```text\n" + as_text(text_value).rstrip() + "\n```")
        if output_chunks:
            chunks.append("\n\n".join(output_chunks))
    body = rewrite_source_asset_links("\n\n".join(chunk for chunk in chunks if chunk.strip()) + "\n")
    raw_path.parent.mkdir(parents=True, exist_ok=True)
    raw_path.write_text(body, encoding="utf-8")
    return body


def as_text(value: str | list[str]) -> str:
    if isinstance(value, list):
        return "".join(value)
    return value


def rewrite_source_asset_links(markdown: str) -> str:
    replacements = {
        "(./data/": "(Statistics/Causal%20Inference/_Source/Python%20Causality%20Handbook/data/",
        "(data/": "(Statistics/Causal%20Inference/_Source/Python%20Causality%20Handbook/data/",
        '("./data/': '("Statistics/Causal%20Inference/_Source/Python%20Causality%20Handbook/data/',
        '("data/': '("Statistics/Causal%20Inference/_Source/Python%20Causality%20Handbook/data/',
    }
    for old, new in replacements.items():
        markdown = markdown.replace(old, new)
    return markdown


def convert_markdown(source_path: Path, raw_path: Path) -> str:
    body = rewrite_source_asset_links(source_path.read_text(encoding="utf-8"))
    raw_path.parent.mkdir(parents=True, exist_ok=True)
    raw_path.write_text(body, encoding="utf-8")
    return body


def extract_markdown_from_notebook(source_path: Path) -> str:
    notebook = nbformat.read(source_path, as_version=4)
    chunks = []
    for cell in notebook.cells:
        if cell.cell_type == "markdown":
            chunks.append(cell.source)
        elif cell.cell_type == "code":
            chunks.append("```python\n" + cell.source.rstrip() + "\n```")
    return "\n\n".join(chunks)


def infer_concepts(text: str, limit: int = 10) -> list[str]:
    low = text.lower()
    found = []
    for needle, concept in CONCEPT_LINKS.items():
        if needle in low and concept not in found:
            found.append(concept)
    return found[:limit]


def infer_assumptions(text: str) -> list[str]:
    low = text.lower()
    found = []
    for needle, assumption in ASSUMPTION_HINTS.items():
        if needle in low and assumption not in found:
            found.append(assumption)
    return found


def excerpt_first_paragraph(markdown: str) -> str:
    cleaned = re.sub(r"```.*?```", "", markdown, flags=re.S)
    cleaned = re.sub(r"!\[.*?\]\(.*?\)", "", cleaned)
    for block in re.split(r"\n\s*\n", cleaned):
        block = block.strip()
        if not block or block.startswith("#") or block.startswith("{"):
            continue
        block = re.sub(r"\s+", " ", block)
        if len(block) > 80:
            return block[:450].rstrip() + ("..." if len(block) > 450 else "")
    return "This chapter develops one part of the causal inference workflow and should be read with the surrounding chapters."


def strip_book_boilerplate(markdown: str) -> str:
    blocks = re.split(r"\n\s*\n", markdown)
    kept = []
    for block in blocks:
        low = block.lower()
        if "patreon.com/causal_inference_for_the_brave_and_true" in low:
            continue
        kept.append(block)
    return "\n\n".join(kept).strip()


def source_page_url(source_file: str) -> str:
    if source_file.endswith(".ipynb"):
        return f"{SITE_URL}/{source_file[:-6]}.html"
    if source_file == "landing-page.md":
        return f"{SITE_URL}/landing-page.html"
    return f"{SITE_URL}/{source_file}"


def github_source_url(source_file: str) -> str:
    return f"{REPO_WEB}/blob/master/{SOURCE_SUBDIR}/{source_file}"


def build_entry(
    book_dir: Path,
    part: str,
    source_file: str,
    order: int,
    raw_body: str,
) -> Entry:
    source_path = book_dir / source_file
    fallback_title = "Causal Inference" if source_file == "landing-page.md" else slug_title(source_file)
    title = first_markdown_heading(raw_body, fallback_title)
    if source_file == "landing-page.md":
        note_path = TARGET_DIR / "Causal Inference.md"
    else:
        prefix = source_file[:2] if re.match(r"^\d\d-", source_file) else f"A{order - 25:02d}"
        note_path = TARGET_DIR / safe_filename(title, prefix)
    raw_name = source_file.replace(".ipynb", ".md")
    raw_path = RAW_DIR / raw_name
    return Entry(
        part=part,
        source_file=source_file,
        source_path=source_path,
        raw_path=raw_path,
        note_path=note_path,
        title=title,
        source_url=github_source_url(source_file),
        site_url=source_page_url(source_file),
        kind="overview" if source_file == "landing-page.md" else "chapter",
        order=order,
    )


def related_links(entries: list[Entry], entry: Entry) -> list[str]:
    links = []
    idx = entries.index(entry)
    if entry.note_path.name != "Causal Inference.md":
        links.append("[[Causal Inference]] - main index for the imported handbook.")
    links.append("[[Causal Inference - Knowledge Map]] - concept graph and method-selection map.")
    if idx > 0:
        prev_entry = entries[idx - 1]
        links.append(f"[[{prev_entry.note_path.stem}]] - previous chapter in the source reading path.")
    if idx + 1 < len(entries):
        next_entry = entries[idx + 1]
        links.append(f"[[{next_entry.note_path.stem}]] - next chapter in the source reading path.")
    return links


def build_reframed_note(entry: Entry, entries: list[Entry], raw_body: str, commit: str) -> str:
    concepts = infer_concepts(raw_body)
    assumptions = infer_assumptions(raw_body)
    aliases = [entry.title, f"Causal Inference - {entry.title}"]
    tags = ["causal-inference", "statistics", "python-causality-handbook"]
    if entry.part:
        tags.append(entry.part.lower().replace(" ", "-").replace("--", "-"))
    if entry.kind == "overview":
        tags.append("moc")
    frontmatter = [
        "---",
        f"tags: {yaml_list(tags)}",
        f"aliases: {yaml_list(aliases)}",
        f"source: {entry.source_url}",
        f"source_commit: {commit}",
        "---",
        "",
    ]
    concept_lines = "\n".join(f"- [[{concept}]]" for concept in concepts) or "- No high-signal concept tags inferred automatically."
    assumption_lines = "\n".join(f"- {assumption}" for assumption in assumptions) or "- No explicit assumption keywords were detected automatically; review the source-derived notes."
    related = "\n".join(f"- {link}" for link in related_links(entries, entry))
    imported = strip_book_boilerplate(raw_body)
    if imported:
        imported = re.sub(r"^#\s+.+?\n+", "", imported, count=1)
    if not imported:
        imported = "_No source body was extracted._"

    body = f"""# {entry.title}

{excerpt_first_paragraph(raw_body)}

> [!note] Source framing
> This note was generated from Matheus Facure's MIT-licensed *Causal Inference for the Brave and True*. The section structure below reframes the chapter for this Obsidian vault, while the source-derived notes preserve the converted chapter content.

## Why This Exists

This chapter exists to solve one practical causal inference problem in the handbook's reading path: how to move from statistical association toward a defensible causal claim. Read it as part of the sequence in [[Causal Inference]] rather than as an isolated formula sheet.

## Core Idea

- Source part: {entry.part}
- Source chapter file: `{entry.source_file}`
- Main concepts detected:
{concept_lines}

## Method / Mechanics

Use the source-derived notes below for the detailed derivation, examples, and Python code. When turning this into an applied workflow, identify:
- the causal question;
- the treatment, outcome, unit, and time index;
- the identification assumption;
- the estimator;
- the diagnostic or falsification check;
- the failure mode that would invalidate the result.

## Assumptions

{assumption_lines}

## Failure Modes

- Confusing prediction quality with causal identification.
- Treating adjustment, matching, or machine learning as a substitute for a credible research design.
- Ignoring overlap, data leakage, time ordering, or hidden confounding.
- Reporting one estimate without the assumption that makes it interpretable.

## Python / Implementation Notes

The imported source keeps Python code blocks and notebook outputs where conversion could preserve them. Treat the code as educational reference, then adapt it to project-specific data validation, reproducibility, and experiment tracking before using it in production analysis.

## Connections

- [[Statistical thinking]] - background for estimates, uncertainty, and comparisons.
- [[AB Testing fundamental]] - randomized experiment intuition.
- [[Machine Learning]] - predictive modeling context for Part II methods.
- [[Causal Inference - Knowledge Map]] - method selection and concept relationships.

## Source

- Web page: {entry.site_url}
- GitHub source: {entry.source_url}
- Source commit: `{commit}`
- Raw converted mirror: [[{entry.raw_path.stem}]]
- License: MIT License, Copyright (c) 2020 Matheus Facure.

## Source-Derived Notes

{imported}

## Related

{related}
"""
    return "\n".join(frontmatter) + body


def build_index(entries: list[Entry], commit: str) -> str:
    chapter_lines = []
    for entry in entries:
        if entry.note_path.name == "Causal Inference.md":
            continue
        chapter_lines.append(f"- [[{entry.note_path.stem}]] - {entry.part}; source `{entry.source_file}`")
    return f"""---
tags: ["causal-inference", "statistics", "moc", "python-causality-handbook"]
aliases: ["Causal Inference", "Causal Inference for the Brave and True", "Python Causality Handbook"]
source: {REPO_WEB}
source_commit: {commit}
---

# Causal Inference

This section imports and reframes Matheus Facure's MIT-licensed *Causal Inference for the Brave and True* into this Obsidian vault. The goal is not only to store the book, but to make the causal inference ideas discoverable through links, method maps, assumptions, and connections to statistics and machine learning notes.

## Why This Exists

Machine learning can predict what is likely to happen. Causal inference asks what would happen under an intervention. That difference matters when the question is "will this policy, treatment, email, price, or product change cause a different outcome?"

## Reading Path

{chr(10).join(chapter_lines)}

## How To Use This Section

- Read Part I when the goal is identification: what assumption lets us interpret an estimate causally?
- Read Part II when the goal is heterogeneous effects, causal model evaluation, or machine-learning-assisted estimation.
- Use [[Causal Inference - Knowledge Map]] when choosing a method for a new problem.
- Check the `_Source/Python Causality Handbook` folder when you need provenance, raw converted Markdown, assets, datasets, or source commit metadata.

## Source

- Website: {SITE_URL}
- GitHub: {REPO_WEB}
- Imported commit: `{commit}`
- License: MIT License, Copyright (c) 2020 Matheus Facure.

## Related

- [[Causal Inference - Knowledge Map]] - concept graph, method selection, and assumptions.
- [[Statistical thinking]] - statistical background for causal estimands and uncertainty.
- [[AB Testing fundamental]] - randomized experiment foundation.
- [[Machine Learning]] - predictive modeling background for Part II methods.
"""


def build_knowledge_map(entries: list[Entry], commit: str) -> str:
    by_source = {entry.source_file: f"[[{entry.note_path.stem}]]" for entry in entries}
    method_rows = [
        ("Clean randomized assignment", "Randomized experiments", by_source["02-Randomised-Experiments.ipynb"]),
        ("Observed confounders, no hidden confounding", "Regression, matching, propensity score, doubly robust estimation", f"{by_source['05-The-Unreasonable-Effectiveness-of-Linear-Regression.ipynb']}, {by_source['10-Matching.ipynb']}, {by_source['11-Propensity-Score.ipynb']}, {by_source['12-Doubly-Robust-Estimation.ipynb']}"),
        ("Hidden confounding but valid instrument", "Instrumental variables / LATE", f"{by_source['08-Instrumental-Variables.ipynb']}, {by_source['09-Non-Compliance-and-LATE.ipynb']}"),
        ("Panel data with treated and control groups", "Difference-in-differences / fixed effects", f"{by_source['13-Difference-in-Differences.ipynb']}, {by_source['14-Panel-Data-and-Fixed-Effects.ipynb']}"),
        ("One treated unit and weighted control pool", "Synthetic control", by_source["15-Synthetic-Control.ipynb"]),
        ("Treatment changes sharply at a threshold", "Regression discontinuity", by_source["16-Regression-Discontinuity-Design.ipynb"]),
        ("Treatment effects vary across units", "HTE, meta-learners, DML", f"{by_source['18-Heterogeneous-Treatment-Effects-and-Personalization.ipynb']}, {by_source['21-Meta-Learners.ipynb']}, {by_source['22-Debiased-Orthogonal-Machine-Learning.ipynb']}"),
    ]
    rows = "\n".join(f"| {problem} | {method} | {notes} |" for problem, method, notes in method_rows)
    chapter_links = "\n".join(
        f"- [[{entry.note_path.stem}]]" for entry in entries if entry.note_path.name != "Causal Inference.md"
    )
    return f"""---
tags: ["causal-inference", "statistics", "knowledge-map", "method-selection"]
aliases: ["Causal Inference Knowledge Map", "Causal Method Map", "Causal Discovery Map"]
source: {REPO_WEB}
source_commit: {commit}
---

# Causal Inference - Knowledge Map

This map connects the imported handbook chapters into a working mental model for choosing methods, checking assumptions, and discovering follow-up ideas.

## Method Selection

| Problem shape | Consider | Notes |
|---|---|---|
{rows}

## Assumption Map

| Assumption | What it protects against | Typical methods |
|---|---|---|
| Exchangeability / unconfoundedness | Treated and untreated units differ in ways that also affect the outcome | Regression, matching, propensity score, doubly robust methods |
| Overlap / positivity | Some groups have no comparable treated or untreated observations | Matching, propensity score trimming, design restriction |
| Exclusion restriction | Instrument affects outcome through channels other than treatment | Instrumental variables |
| Parallel trends | Treated and control groups would not have followed comparable paths without treatment | Difference-in-differences |
| Continuity around cutoff | Units just above and below a threshold are not comparable | Regression discontinuity |
| No interference / SUTVA | One unit's treatment changes another unit's outcome | Most potential-outcomes estimators |

## Discovery Questions

- What is the intervention, not just the prediction target?
- Which counterfactual is missing?
- What assumption identifies that counterfactual?
- Which observed pattern would falsify or weaken the assumption?
- Which method gives the clearest story to a skeptical reader?
- Where can machine learning improve nuisance estimation without replacing identification?

## Imported Chapter Links

{chapter_links}

## Source

- Website: {SITE_URL}
- GitHub: {REPO_WEB}
- Imported commit: `{commit}`
- License: MIT License, Copyright (c) 2020 Matheus Facure.

## Related

- [[Causal Inference]] - main index for the imported handbook.
- [[Statistical thinking]] - statistical primitives used across causal inference.
- [[AB Testing fundamental]] - experimental baseline for causal identification.
- [[Machine Learning]] - predictive modeling context for heterogeneous treatment effect methods.
"""


def copy_support_files(repo_dir: Path, book_dir: Path, commit: str) -> None:
    SOURCE_DIR.mkdir(parents=True, exist_ok=True)
    license_text = (repo_dir / "LICENSE").read_text(encoding="utf-8")
    (SOURCE_DIR / "LICENSE.md").write_text(
        "# Source License\n\n"
        f"Source repository: {REPO_WEB}\n\n"
        f"Imported commit: `{commit}`\n\n"
        + license_text,
        encoding="utf-8",
    )
    if (book_dir / "data").exists():
        if DATA_DIR.exists():
            shutil.rmtree(DATA_DIR)
        shutil.copytree(book_dir / "data", DATA_DIR)
    HELPER_DIR.mkdir(parents=True, exist_ok=True)
    for helper in sorted(book_dir.glob("*.py")):
        shutil.copy2(helper, HELPER_DIR / helper.name)


def generate(repo_dir: Path, dry_run: bool = False) -> dict:
    clone_or_refresh(repo_dir)
    commit = run(["git", "rev-parse", "HEAD"], cwd=repo_dir)
    book_dir = repo_dir / SOURCE_SUBDIR
    _, toc_files = read_toc(book_dir)
    if not dry_run:
        TARGET_DIR.mkdir(parents=True, exist_ok=True)
        for old_note in TARGET_DIR.glob("*.md"):
            old_note.unlink()
        if SOURCE_DIR.exists():
            shutil.rmtree(SOURCE_DIR)
    entries: list[Entry] = []
    raw_bodies: dict[str, str] = {}
    for order, (part, source_file) in enumerate(toc_files, start=0):
        source_path = book_dir / source_file
        if not source_path.exists():
            raise FileNotFoundError(source_path)
        raw_name = source_file.replace(".ipynb", ".md")
        raw_path = RAW_DIR / raw_name
        if source_file.endswith(".ipynb"):
            asset_subdir = source_file[:-6]
            body = extract_markdown_from_notebook(source_path) if dry_run else convert_notebook(source_path, raw_path, asset_subdir)
        else:
            body = source_path.read_text(encoding="utf-8") if dry_run else convert_markdown(source_path, raw_path)
        raw_bodies[source_file] = body
        entries.append(build_entry(book_dir, part, source_file, order, body))

    manifest = {
        "source_repo": REPO_WEB,
        "source_commit": commit,
        "source_site": SITE_URL,
        "imported_at_utc": datetime.now(timezone.utc).isoformat(),
        "entry_count": len(entries),
        "entries": [
            {
                "part": entry.part,
                "title": entry.title,
                "source_file": entry.source_file,
                "source_url": entry.source_url,
                "site_url": entry.site_url,
                "raw_path": str(entry.raw_path.relative_to(VAULT_ROOT)),
                "note_path": str(entry.note_path.relative_to(VAULT_ROOT)),
            }
            for entry in entries
        ],
    }
    if dry_run:
        return manifest

    TARGET_DIR.mkdir(parents=True, exist_ok=True)
    RAW_DIR.mkdir(parents=True, exist_ok=True)
    ASSET_DIR.mkdir(parents=True, exist_ok=True)
    copy_support_files(repo_dir, book_dir, commit)

    for entry in entries:
        if entry.note_path.name == "Causal Inference.md":
            continue
        note = build_reframed_note(entry, entries, raw_bodies[entry.source_file], commit)
        entry.note_path.write_text(note, encoding="utf-8")

    (TARGET_DIR / "Causal Inference.md").write_text(build_index(entries, commit), encoding="utf-8")
    (TARGET_DIR / "Causal Inference - Knowledge Map.md").write_text(build_knowledge_map(entries, commit), encoding="utf-8")
    (SOURCE_DIR / "manifest.json").write_text(json.dumps(manifest, indent=2), encoding="utf-8")
    return manifest


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo-dir", type=Path, default=DEFAULT_CLONE_DIR)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    manifest = generate(args.repo_dir, dry_run=args.dry_run)
    print(json.dumps({
        "source_commit": manifest["source_commit"],
        "entry_count": manifest["entry_count"],
        "target_dir": str(TARGET_DIR.relative_to(VAULT_ROOT)),
        "dry_run": args.dry_run,
    }, indent=2))


if __name__ == "__main__":
    main()
