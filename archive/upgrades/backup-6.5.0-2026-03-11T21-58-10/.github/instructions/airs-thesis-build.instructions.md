---
description: "AIRS DBA dissertation build pipeline — Pandoc + XeLaTeX + Mermaid CLI + APA 7th edition"
applyTo: "thesis-v2/**,**/*thesis*,**/build.ps1,**/meta.yaml,**/*apa7*"
---

# AIRS Thesis Build System

## Build Command

```powershell
cd thesis-v2; .\build.ps1
```

Targets: `all` (default), `draft`, `figures`, `validate`, `clean`, `watch`

## Pipeline Architecture

```
Markdown chapters → Mermaid extraction → mmdc rendering → Pandoc + citeproc → XeLaTeX → APA 7 PDF
```

### Dependencies (checked by `Test-Dependencies`)

| Tool | Purpose | Install |
|------|---------|---------|
| `pandoc` | Markdown → LaTeX conversion | `winget install pandoc` |
| `xelatex` | PDF rendering with font support | MiKTeX |
| `mmdc` | Mermaid diagram → PNG | `npm i -g @mermaid-js/mermaid-cli` |

### Chapter Structure

Chapters are ordered by filename prefix and assembled by `build.ps1`:

| File | Chapter |
|------|---------|
| `01_introduction.md` | Introduction |
| `02_literature_review.md` | Literature Review |
| `03_methodology.md` | Methodology |
| `04_results.md` | Results |
| `05_discussion.md` | Discussion |
| `06_conclusions.md` | Conclusions |

Front matter: `00_cover.md` through `06_list_of_figures.md`
Back matter: `references.md`, `appendices.md`

## Configuration Files

### meta.yaml

Thesis metadata: title, author, committee, dates, document class options, and chapter ordering. Located at `thesis-v2/meta.yaml`.

### apa7-thesis.tex

Custom Pandoc LaTeX template at `thesis-v2/templates/apa7-thesis.tex`. Uses XeLaTeX with `fontspec` for Times New Roman. Provides APA 7 heading hierarchy:

- **Level 1**: Centered, bold (chapters)
- **Level 2**: Left-aligned, bold (sections)
- **Level 3**: Left-aligned, bold italic (subsections)

### bibliography.bib

93 BibTeX references at `thesis-v2/references/bibliography.bib`. Processed by `citeproc` with `apa-7th-edition.csl`.

## Critical Rules

1. **Citation format**: Use `@key` or `[@key]` syntax only — narrative citations like `(Author, Year)` are invisible to citeproc
2. **LaTeX raw blocks**: `{=latex}` blocks bypass citeproc — never put citations inside them
3. **Mermaid diagrams**: Embedded in markdown fenced blocks; `build.ps1` extracts, renders via `mmdc`, and replaces with LaTeX figures
4. **Table formatting**: Tables use `longtable` + `booktabs` with single-spacing at smaller font via `\AtBeginEnvironment`
5. **Float placement**: All figures use `[H]` for precise positioning via the `float` package
6. **Running header**: "AI READINESS SCALE" on every page via `fancyhdr`

## Related Domain Knowledge

- `domain-knowledge/DK-DOCUMENT-CONVERSION-PIPELINE-v1.0.0.md` — Pandoc/LaTeX mastery
- `domain-knowledge/DK-PUBLICATION-WORKFLOW-v1.0.0.md` — Academic publication QA
- `domain-knowledge/DK-DISSERTATION-DOCUMENTATION-v1.0.0.md` — Dissertation structure

## Project Directory Map

| Directory | Purpose |
|-----------|---------|
| `airs_experiment/` | Jupyter notebooks (00-12), analysis data, plots, results, tables |
| `data/` | Source datasets (AIRS_clean.csv, airs_28item_complete.json) |
| `thesis-v2/` | Manuscript source, build system, templates, references |
| `defense/` | Defense slides (FINAL.pptx, FINAL.pdf) |
| `docs/field-deployment/` | 7 practitioner-facing deployment documents |
| `scripts/` | Analysis scripts (EFA item reduction, etc.) |
| `results/` | Exported analysis results |

## Connected Skills

- `dissertation-defense` — Defense preparation, committee dynamics
- `book-publishing` — Pandoc/LaTeX pipeline patterns (uses LuaLaTeX; thesis uses XeLaTeX)
- `citation-management` — APA 7 citation formatting and bibliography
- `academic-research` — Research methodology foundations
