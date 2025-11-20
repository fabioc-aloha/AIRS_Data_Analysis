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

- **Sample Size**: N = 201 valid responses
- **Variables**: 51 columns (28 analysis items + demographics + usage)
- **Scale**: 5-point Likert (1=Strongly Disagree to 5=Strongly Agree)
- **Format**: CSV with header rows
- **Documentation**: See `../DATA_DICTIONARY.md` for complete variable definitions

## Data Quality

- Attention check pass rate: 96% (4 responses excluded)
- Missing data: <1% on any item
- Completion rate: 100% for valid responses

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
