# Exploratory Phase Notebooks (ARCHIVED)

**Archive Date**: November 22, 2025
**Status**: Historical record - not aligned with current dissertation methodology
**Replacement**: See `../../airs/` for active dissertation analysis notebooks

---

## 📋 Archive Context

This directory contains exploratory notebooks from the **pre-dissertation phase** (N=281, pre-October 2025). These analyses used:
- **Data-driven item selection** (correlation-based optimization)
- **Single-sample validation** (no split-sample design)
- **Mixed outcomes** (adoption + behavioral intention)
- **Exploratory framework testing** (not fixed UTAUT2 + 4 AI-specific)

**Divergence from Dissertation**: Current dissertation (Phase 1+) uses:
- **Construct-balanced item selection** (1 item per 12 constructs)
- **Split-sample validation** (Development N=159, Holdout N=159)
- **Standardized outcome** (Behavioral Intention only)
- **Fixed theoretical framework** (8 UTAUT2 + 4 AI-specific constructs)

**Key Learnings Extracted**: See `../../EXPLORATORY_PHASE_LEARNINGS.md` for methodological insights that informed dissertation Phase 1 decisions.

---

## 📊 Archived Notebook Contents

### 1. AIRS_Adoption_Analysis_v2.ipynb
**Purpose**: Adoption prediction modeling with logistic regression
**Sample**: N=281
**Outcome**: Binary adoption (not BI)
**Key Results**: AUC = 92.2% ± 3.8%, effect sizes (Cohen's d) for 13 constructs
**Status**: Superseded by dissertation's focus on Behavioral Intention (continuous)

### 2. AIRS_Alternative_Outcomes_Optimization.ipynb
**Purpose**: Compare multiple outcome variables (adoption, BI, usage intensity)
**Sample**: N=281
**Key Findings**: BI shows highest R² with optimal items
**Status**: Informed dissertation's standardization on BI as outcome

### 3. AIRS_Analysis_Python.ipynb
**Purpose**: Comprehensive psychometric validation (63 cells, 1487 lines)
**Sample**: N=281
**Pipeline**: EFA → CFA → Reliability → Validity → SEM → Model comparison
**Key Results**: KMO=0.917, CFI=0.933, TLI=0.923, RMSEA=0.065
**Status**: Template for Phase 2 CFA validation procedures

### 4. AIRS_Data_Exploration.ipynb
**Purpose**: Initial data quality assessment and distribution analysis
**Sample**: N=201-205 (various cleaning versions)
**Status**: Data cleaning procedures applied to dissertation N=318 sample

### 5. AIRS_Item_Level_Analysis.ipynb
**Purpose**: Item-outcome correlation analysis, construct-level performance
**Key Findings**: 12 items with "very strong" correlations (r ≥ 0.70)
**Status**: Informed best-item-per-construct selection in Phase 1

### 6. AIRS_Short_Form_Validation.ipynb
**Purpose**: Short-form optimization (5-24 items), predictive efficiency curves
**Key Findings**:
- 12-item peak: R² = 82.2%, α = 0.963
- 10-item empirical: 99.7% of peak performance
- Optimal range: 8-12 items
**Status**: Validated 12-item target for dissertation scale

### 7. Construct_Reliability_Validation.ipynb
**Purpose**: Reliability metrics across construct subsets
**Sample**: N=281
**Status**: Informed reliability thresholds (α ≥ 0.70)

### 8. AIRS_Analysis.Rmd
**Purpose**: R Markdown alternative analysis
**Language**: R (not primary dissertation language)
**Output**: HTML report in `../../docs/`
**Status**: Supplementary exploratory work

---

## 🔄 Methodological Evolution: Exploratory → Dissertation

| Dimension | Exploratory (Archived) | Dissertation Phase 1 |
|-----------|----------------------|---------------------|
| **Sample** | N=281, single sample | N=318, split 159/159 |
| **Item Selection** | Data-driven (correlation) | Construct-balanced (1 per 12) |
| **Validation** | Single-sample metrics | Development + holdout |
| **Outcome** | Mixed (adoption + BI) | Behavioral Intention only |
| **Framework** | Exploratory (13 constructs) | Fixed (8 UTAUT2 + 4 AI-specific) |
| **Purpose** | Exploration & optimization | Confirmatory hypothesis testing |

---

## ✅ Value of Archived Work

1. **Validated Feasibility**: Confirmed 12-item scale achieves 96.3% of 24-item predictive power
2. **Informed Item Selection**: Identified strongest items per construct
3. **Established Procedures**: Tested psychometric validation workflows
4. **Revealed Trade-offs**: Documented coverage vs. prediction tensions
5. **Guided Design**: Provided evidence base for dissertation methodology

**Key Document**: See `../../EXPLORATORY_PHASE_LEARNINGS.md` for complete synthesis

---

## 🚫 Why Not Use These Notebooks for Dissertation?

**Critical Misalignments**:
1. **No Split-Sample Validation**: Single-sample metrics cannot assess generalizability
2. **Data-Driven Selection**: Creates construct imbalance (some constructs missing)
3. **Mixed Outcomes**: Inconsistent use of adoption vs. BI undermines comparability
4. **Exploratory Framework**: 13 constructs (not dissertation's fixed 12)
5. **No A Priori Hypotheses**: Post-hoc optimization vs. confirmatory testing

**Dissertation Requirements**:
- Hypothesis testing (H1-H5) requires a priori framework
- Scale validation requires independent holdout sample
- Construct balance required for diagnostic utility
- Theoretical coherence required for publication

---

## 📁 Active Dissertation Analysis

**Current Location**: `../../airs/`

**Active Notebooks**:
- `00_Create_Split_Samples.ipynb` - Stratified split (159/159)
- `01_EFA_Construct_Balanced_12_Item.ipynb` - Phase 1 scale development ✅
- `02_CFA_Measurement_Model.ipynb` - Phase 2 validation (next)
- `03-07_*.ipynb` - Phases 3-5 (pending)

**Status**: Phase 1 complete (α=0.897, R²=0.811, 2 factors), Phase 2 next

---

## 📖 How to Use This Archive

**For Reference**:
- Review exploratory item-level findings
- Understand methodological evolution
- Access preliminary psychometric templates

**Do NOT Use For**:
- Dissertation hypothesis testing (use `../../airs/` notebooks)
- Results reporting (exploratory ≠ confirmatory)
- Publication (single-sample, data-driven)

**Recommended Reading Order**:
1. Read `../../EXPLORATORY_PHASE_LEARNINGS.md` first (synthesizes key insights)
2. Reference specific notebooks for detailed procedures
3. Compare with active dissertation notebooks in `../../airs/`

---

## 🔗 Related Documentation

- **Learnings Synthesis**: `../../EXPLORATORY_PHASE_LEARNINGS.md`
- **Dissertation Plan**: `../../airs/ANALYSIS_PLAN.md`
- **Consistency Check**: `../../airs/CONSISTENCY_CHECK.md`
- **Main README**: `../../README.md`

---

**Archive Purpose**: Historical record documenting exploratory decisions that informed rigorous dissertation methodology

**Last Active**: October 2025 (before dissertation Phase 1)
**Archived**: November 22, 2025 (Week 24/32)
