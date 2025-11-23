# Data Directory

This directory contains the AIRS survey data files.

## Files (Not Tracked in Git)

Due to privacy and size considerations, actual data files are not included in version control:

- `AIRS---AI-Readiness-Scale.csv` - Original survey data (N=205)
- `AIRS_clean.csv` - Preprocessed data with attention check filtering (N=201)
- `AIRS---AI-Readiness-Scale.sav` - SPSS format data file

## Data Access

For reproducibility, researchers may request access to de-identified data by contacting the repository owner.

## Data Description

- **Sample Size**: N = 362 valid responses (181 dev, 181 holdout)
- **Variables**: 51 columns (49 survey items + demographics + usage metadata)
- **Final Scale**: 12 items across 10 constructs (PE2, EE1, SI1, FC1, HM2, PV2, HB2, VO1, TR2, EX1, ER2, AX1)
- **Scale**: 5-point Likert (1=Strongly Disagree to 5=Strongly Agree)
- **Format**: CSV with header rows
- **Documentation**: See `../docs/DATA_DICTIONARY.md` for complete variable definitions

## Available Data Files

- `AIRS_clean.csv` - Full preprocessed dataset (N=362)
- `AIRS_clean_dev.csv` - Development sample (N=181)
- `AIRS_clean_dev_12item.csv` - 12-item development subset
- `AIRS_clean_holdout.csv` - Holdout validation sample (N=181)
- `airs_12item_selection.json` - Documentation of final item selection with rationale
- `AIRS---AI-Readiness-Scale-labels.csv` - Variable label mapping

## Data Quality

- Attention check pass rate: High (excluded cases removed)
- Missing data: <1% on any item
- Completion rate: 100% for valid responses
- Sample split: 50/50 stratified (N=181 dev, N=181 holdout)

## Preprocessing Steps

See `AIRS_Analysis_Python.ipynb` for complete preprocessing workflow:
1. Load raw CSV data
2. Variable renaming (descriptive → codes)
3. Attention check validation
4. Numeric conversion
5. Missing data assessment
6. Export clean dataset

---

**Note**: Raw data files are excluded from git tracking per `.gitignore` configuration.
