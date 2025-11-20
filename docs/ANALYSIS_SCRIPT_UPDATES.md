# AIRS Analysis Script Update Summary

**Date**: November 20, 2025
**File Updated**: `AIRS_Analysis.Rmd`
**Purpose**: Align analysis script with preprocessed data (AIRS_clean.csv) and correct variable names

---

## Major Changes

### 1. Data Source Updated
- **Old**: `data/AIRS---AI-Readiness-Scale.sav` (SPSS file with unknown variable names)
- **New**: `data/AIRS_clean.csv` (preprocessed CSV with standardized names)
- **Benefit**: Skip complex SPSS reading; use pre-cleaned data with attention check filtering

### 2. Sample Size Updated
- **Old**: N = 500 (assumed split 250/250)
- **New**: N = 201 (actual valid responses after attention check)
- **Impact**: Smaller sample but adequate for SEM with moderate model complexity

### 3. Variable Names Corrected
All item references updated from incorrect naming to actual CSV variable names:

| Construct | Old Names | New Names | Items |
|-----------|-----------|-----------|-------|
| Performance Expectancy (PE) | PE1, PE2 | PE1, PE2 | ✓ Same |
| Effort Expectancy (EE) | EE5, EE6 | **EE1, EE2** | ✓ Fixed |
| Social Influence (SI) | SI9, SI10 | **SI1, SI2** | ✓ Fixed |
| Facilitating Conditions (FC) | FC13, FC14 | **FC1, FC2** | ✓ Fixed |
| Hedonic Motivation (HM) | HM17, HM18 | **HM1, HM2** | ✓ Fixed |
| Price Value (PV) | PV21, PV22 | **PV1, PV2** | ✓ Fixed |
| Habit (HB) | HB25, HB26 | **HB1, HB2** | ✓ Fixed |
| **Voluntariness (VO)** | *(not included)* | **VO1, VO2** | ✓ Added |
| Trust (TR) | TR29, TR30 | **TR1, TR2** | ✓ Fixed |
| Explainability (EX) | EX33, EX34 | **EX1, EX2** | ✓ Fixed |
| Ethical Risk (ER) | ER37, ER38 | **ER1, ER2** | ✓ Fixed |
| Anxiety (AX) | AX41, AX42 | **AX1, AX2** | ✓ Fixed |
| Behavioral Intention (BI) | BI45-BI48 | **BI1-BI4** | ✓ Fixed |

### 4. Construct Count Updated
- **Old**: 12 constructs (11 predictors + 1 outcome)
- **New**: 13 constructs (12 predictors + 1 outcome)
- **Added**: Voluntariness (VO) - 2 items measuring freedom of choice to use AI

### 5. Item Count Updated
- **Old**: 30 total items
- **New**: 28 total items (29 if counting attention check, but excluded from analysis)
- **Reason**: Attention check item (Q24/ATT_CHECK) removed during preprocessing

---

## Specific Code Updates

### Data Import Section
```r
# OLD:
airs_full <- haven::read_sav("data/AIRS---AI-Readiness-Scale.sav")

# NEW:
airs_full <- read.csv("data/AIRS_clean.csv", stringsAsFactors = FALSE)
```

### Variable Setup Section
```r
# NEW: Added Voluntariness
vo_items <- c("VO1", "VO2")

# NEW: Updated all_items to include VO
all_items <- c(
  pe_items, ee_items, si_items, fc_items, hm_items, pv_items, hb_items,
  vo_items,  # <-- Added
  tr_items, ex_items, er_items, ax_items, bi_items
)
```

### Reliability Analysis
```r
# NEW: Added Voluntariness to construct_items list
construct_items <- list(
  ...
  "Voluntariness" = vo_items,  # <-- Added
  ...
)
```

### CFA Model Specification
```r
# OLD: 12-factor model
cfa_model <- '
  PE  =~ PE1 + PE2
  EE  =~ EE5 + EE6  # Wrong names
  ...
'

# NEW: 13-factor model with correct names
cfa_model <- '
  PE  =~ PE1 + PE2
  EE  =~ EE1 + EE2  # Correct names
  SI  =~ SI1 + SI2
  ...
  VO  =~ VO1 + VO2  # Added
  ...
'
```

### SEM Model 1 (UTAUT2 Baseline)
```r
# Updated all variable names from EE5/EE6 to EE1/EE2, etc.
sem_model1 <- '
  PE  =~ PE1 + PE2
  EE  =~ EE1 + EE2  # Fixed
  SI  =~ SI1 + SI2  # Fixed
  ...
'
```

### SEM Model 2 (AIRS Extended)
```r
# Added VO construct and fixed all variable names
sem_model2 <- '
  ...
  VO  =~ VO1 + VO2  # Added
  ...
  BI ~ PE + EE + SI + FC + HM + PV + HB + VO + TR + EX + ER + AX  # Added VO
'
```

### Mediation Model
```r
# Updated variable names and added VO to structural paths
sem_model2_labeled <- '
  ...
  BI ~ b1*PE + b2*EE + b3*SI + b4*FC + b5*HM + b6*PV + b7*HB + b8*VO + TR_BI*TR + EX_BI*EX + b11*ER + b12*AX
  ...
'
```

---

## Files Required Before Running

### 1. Run Preprocessing First
```r
source("preprocess_data.R")
```
This creates `data/AIRS_clean.csv` with:
- Renamed variables (PE1, EE1, etc.)
- Attention check failures removed
- Numeric conversion completed

### 2. Check Data Dictionary
See `DATA_DICTIONARY.md` for:
- Complete variable descriptions
- Question text for each item
- Construct definitions
- Data quality notes

---

## Theoretical Notes

### Voluntariness (VO) Construct
- **Definition**: Perceived freedom to choose whether to use AI tools
- **Items**:
  - VO1: "I choose to use AI tools in my work because I find them helpful, not because I am required to"
  - VO2: "I could choose not to use AI tools in my work or studies if I preferred"
- **Source**: Extension beyond standard UTAUT2
- **Decision**: Can be excluded for strict UTAUT2 replication
  - To exclude: Comment out `vo_items` from `all_items` vector
  - Remove VO from construct_items, CFA model, and SEM models

### Sample Size Considerations
- **N = 201** is adequate for SEM with:
  - Simple models (< 10 parameters per construct)
  - MLR estimator (robust to non-normality)
  - Models with strong factor loadings (> .70)
- **Recommended**: Use full sample for SEM (not 50/50 split)
  - Alternative: 70/30 split if strict cross-validation needed
  - Or use full sample with modification indices carefully

---

## Next Steps

1. ✅ **Preprocessing Complete**: `preprocess_data.R` creates clean dataset
2. ✅ **Data Dictionary Created**: `DATA_DICTIONARY.md` documents all variables
3. ✅ **Analysis Script Updated**: `AIRS_Analysis.Rmd` uses correct variable names
4. ⏭️ **Run Setup**: Execute `setup_environment.R` to install R packages
5. ⏭️ **Execute Analysis**: Knit `AIRS_Analysis.Rmd` in RStudio
6. ⏭️ **Review Results**: Check fit indices, reliability, validity, hypothesis tests

---

## Validation Checklist

Before running analysis, verify:
- [ ] `data/AIRS_clean.csv` exists (201 rows, 28 Likert items + demographics)
- [ ] Variable names match: PE1, PE2, EE1, EE2, ..., BI1-BI4
- [ ] All R packages installed (`setup_environment.R` ran successfully)
- [ ] Working directory set to project root
- [ ] RStudio environment configured

---

**Status**: Analysis script fully updated and ready for execution
**Compatibility**: RStudio with R ≥ 4.0.0, lavaan ≥ 0.6-12, psych ≥ 2.0.0
