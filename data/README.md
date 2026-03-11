# Data Directory

Raw source data for the AIRS (AI Readiness Scale) dissertation research.

> **Source of truth** for cleaned analysis data is `airs_experiment/data/AIRS_clean.csv` (N=523, 41 columns). Files here are raw inputs consumed by `airs_experiment/00_Create_Split_Samples.ipynb`.

## Current Files

| File | Description |
|------|-------------|
| `AIRS---AI-Readiness-Scale-labels.csv` | Raw Qualtrics export with variable labels (read by NB00) |
| `airs_28item_complete.json` | Original 28-item instrument metadata (read by NB01, NB02) |

## Archived Files

Outdated files moved to `airs_archive/` on 2026-03-11:

| File | Reason |
|------|--------|
| `AIRS_clean.csv` | Superseded — earlier processing pass (511 rows, 45 cols) vs canonical (523 rows, 41 cols) |
| `CentimentTables.md` | Early Centiment platform export from N=218 pilot collection |

## Sample Overview

| Parameter | Value |
|-----------|-------|
| **Full Sample** | N = 523 |
| **EFA Development** | n = 261 (50%) |
| **CFA Holdout** | n = 262 (50%) |
| **Random Seed** | 67 |

### Role Distribution

| Role | n | % |
|------|---|---|
| Student | 216 | 41.3% |
| Professional | 184 | 35.2% |
| Leader | 123 | 23.5% |

## Validated Model

The final validated instrument comprises **16 items across 8 factors**:

| Factor | Items | Cronbach's α |
|--------|-------|--------------|
| Performance Expectancy (PE) | PE1, PE2 | .803 |
| Effort Expectancy (EE) | EE1, EE2 | .859 |
| Social Influence (SI) | SI1, SI2 | .752 |
| Facilitating Conditions (FC) | FC1, FC2 | .743 |
| Hedonic Motivation (HM) | HM1, HM2 | .864 |
| Price Value (PV) | PV1, PV2 | .883 |
| Habit (HB) | HB1, HB2 | .909 |
| AI Trust (TR) | TR1, TR2 | .891 |

## Data Quality

- **Attention check**: All responses passed validation
- **Missing data**: 0% on validated items
- **Completion rate**: 100% for included responses
- **Data collection**: November 2024 via Centiment platform

## Variable Documentation

See `../docs/DATA_DICTIONARY.md` for complete variable definitions.

## Data Availability

The cleaned dataset is included in this repository for dissertation reproducibility. See Appendix H in the thesis for full data availability statement.

---

**Note**: Raw data from Centiment has been processed according to the methodology documented in `airs_experiment/00_Create_Split_Samples.ipynb`.
