# AIRS Project Archive

Consolidated archive of outdated, superseded, and historical project files.
Reorganized on 2026-03-11 during project audit.

**Source of truth** for analysis data: `airs_experiment/data/AIRS_clean.csv` (N=523, 41 columns)

## Archived Data Files

| File | Original Location | Reason |
|------|-------------------|--------|
| `AIRS_clean.csv` | `data/` | Earlier processing pass (511 rows, 45 cols) — superseded by canonical version (523 rows, 41 cols). Missing `Open_Feedback` column; contains 5 derived columns not in canonical version. |
| `CentimentTables.md` | `data/` | Early Centiment platform frequency tables from N=218 pilot data collection, superseded by final N=523 dataset. |

## Archived Directories

| Directory | Original Location | Contents |
|-----------|-------------------|----------|
| `alex-v1/` | `archive/` | Early Alex cognitive architecture files (pre-v5) |
| `data-old/` | `archive/` | Legacy data processing artifacts |
| `docs-outdated/` | `archive/` | Superseded documentation drafts |
| `thesis-drafts/` | `archive/` | Earlier thesis manuscript versions (pre-thesis-v2) |
| `thesis/` | root | Legacy thesis folder (59 files) — superseded by `thesis-v2/` build system |
| `defense-old/` | `defense/OLD/` | Earlier presentation versions (v0, v2, v4, v5) |
| `results/` | root | Stale HTML export (NB08, Nov 2025) — notebook outputs in `airs_experiment/results/` |
| `scripts-archive/` | `scripts/archive/` | Deprecated dream-state scripts and old cognitive configs |
| `archive-README.md` | `archive/README.md` | Original archive directory README |

## Archived Root Files

| File | Original Location | Reason |
|------|-------------------|--------|
| `PDF_GENERATION.md` | root | Documented legacy `thesis/` build scripts — superseded by `thesis-v2/README.md` |
| `run_efa_item_reduction.py` | `scripts/` | Standalone EFA script (Nov 2025) — superseded by `airs_experiment/01_EFA_Experiment.ipynb` |
| `scripts-README.md` | `scripts/README.md` | Dream state automation docs for archived scripts |
| `AUDIT_REPORT.md` | root | Project audit report from 2026-03-11 |
