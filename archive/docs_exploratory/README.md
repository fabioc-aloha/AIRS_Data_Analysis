# Exploratory Documentation Archive

**Archive Date**: November 22, 2025
**Status**: Historical record from exploratory phase (N=281, pre-dissertation)
**Replacement**: See `../../docs/` for active dissertation documentation

---

## 📋 Archive Context

This directory contains documentation from the **exploratory phase** (pre-October 2025) when the project focused on:
- **Data-driven optimization** (N=281 single sample)
- **Multiple outcome testing** (adoption vs. BI vs. usage intensity)
- **Item-level correlation analysis** (not construct-balanced)
- **Short-form exploration** (5-24 item variations)
- **Notebook modularization** (script refactoring experiments)

**Divergence from Dissertation**: Current dissertation (Phase 1+) uses:
- **Split-sample validation** (Development N=159, Holdout N=159, Total N=318)
- **Construct-balanced approach** (1 item per 12 constructs)
- **Fixed outcome** (Behavioral Intention only, per UTAUT2)
- **Fixed framework** (8 UTAUT2 + 4 AI-specific constructs)
- **A priori hypotheses** (H1-H5 for confirmatory testing)

**Key Learnings**: See `../../EXPLORATORY_PHASE_LEARNINGS.md` for synthesis

---

## 📊 Archived Document Contents

### 1. DISSERTATION_MODEL_EVALUATION.md (1190 lines)
**Purpose**: Comprehensive model evaluation from exploratory phase
**Sample**: N=281
**Outcome**: Binary adoption (not BI)
**Key Results**:
- AUC = 92.2% for adoption discrimination
- Cohen's d effect sizes for 13 constructs
- Performance Expectancy d=1.837 (strongest)
- Explainability d=1.728 (#3 overall)

**Status**: Superseded by dissertation's BI-focused structural models
**Value**: Documents exploratory adoption prediction methodology
**Learning**: Validated predictive feasibility of UTAUT2 + AI-specific constructs

---

### 2. AIRS_12_ITEM_DIAGNOSTIC_RATIONALE.md (663 lines)
**Purpose**: Justification for 12-item construct-balanced diagnostic tool
**Date**: November 21, 2025
**Context**: Bridge document between exploratory and dissertation phases

**Key Arguments**:
- Empirical factor analysis shows dominant general factor (λ=6.81, 57% variance)
- Theoretical completeness justifies retaining all 12 constructs
- Diagnostic utility requires construct-specific assessment
- Content validity demands full nomological network coverage

**Status**: Relevant to Phase 1 dissertation rationale
**Value**: Explains empirical-theoretical tension in scale design
**Learning**: Theoretical coverage can override empirical parsimony for diagnostic tools

---

### 3. AIRS_7_ITEM_QUESTIONNAIRE.md (231 lines)
**Purpose**: Ultra-short form questionnaire (71% time reduction)
**Version**: 1.0, November 2025
**Psychometrics**: α=0.939, r(BI)=0.776, R²=60.2%

**Items**: HM2, PV2, PE2, SI2, FC1, TR1, BI1
**Administration**: ~70 seconds

**Status**: Not dissertation-aligned (data-driven selection, not construct-balanced)
**Value**: Demonstrates extreme efficiency trade-offs
**Learning**: Single best items can achieve 60% R² with 7 items (vs. 81% with 12)

---

### 4. ITEM_LEVEL_ANALYSIS_REPORT.md (1050 lines)
**Purpose**: Item-level predictive validity analysis
**Sample**: N=309
**Focus**: Individual items vs. construct averaging

**Key Findings**:
- 12/24 items (50%) show very strong correlations (r ≥ 0.70) with BI
- Top predictors: HM2, PV2, PE2 (r ≈ 0.82)
- 7-item short form: 71% time reduction, r=0.78
- Item-level selection outperforms construct averaging

**Status**: Informed Phase 1 best-item-per-construct selection
**Value**: Demonstrates diminishing returns after 8-10 items
**Learning**: Item quality varies significantly within constructs

---

### 5. AI_READINESS_OUTCOME_ANALYSIS.md (283 lines)
**Purpose**: Evaluate BI as outcome variable vs. predictor
**Date**: November 21, 2025
**Sample**: N=309

**Key Findings**:
- BI as predictor: Cohen's d=1.67 (#2 discriminator for adoption)
- BI as outcome: R²=0.583 (12 constructs predicting BI)
- Decision: NOT selected as primary outcome (intention-behavior gap)

**Status**: Informed dissertation's standardization on BI as outcome
**Value**: Documents outcome variable selection process
**Learning**: Cross-sectional design limits outcome to intention, not behavior

---

### 6. OUTCOME_VARIABLE_THEORETICAL_JUSTIFICATION.md (610 lines)
**Purpose**: Scholarly justification for outcome variable choice
**Author**: Fabio Correa, Touro University
**Date**: November 20, 2025

**Core Argument**:
- Sample composition: 88.6% post-adoption (N=281)
- Primary outcome: AI_Adoption (binary adopter status)
- BI functions as strongest predictor construct
- Justification: Post-adoption context, practical objectives, UTAUT2 precedent

**Status**: Partially relevant—dissertation uses BI as outcome (not adoption)
**Value**: Thorough theoretical treatment of intention-behavior relationship
**Learning**: Outcome selection depends on sample composition and study design

---

### 7. ANALYSIS_SCRIPT_UPDATES.md (207 lines)
**Purpose**: Document R Markdown script updates
**Date**: November 20, 2025
**File**: AIRS_Analysis.Rmd

**Updates**:
- Data source: SPSS → CSV (AIRS_clean.csv)
- Sample: N=500 assumed → N=201 actual
- Variable names: Corrected all construct items
- Constructs: 12 → 13 (added Voluntariness/VO)

**Status**: R Markdown workflow not used in dissertation (Python Jupyter)
**Value**: Documents data cleaning and variable standardization
**Learning**: Variable naming consistency critical for reproducibility

---

### 8. NOTEBOOK_MODULARIZATION_SUMMARY.md
**Purpose**: Document code refactoring into modules
**Status**: Script modularization experiment
**Value**: Software engineering practices for analysis workflows
**Learning**: Modular code improves reproducibility and maintenance

---

### 9. NOTEBOOK_FACT_CHECK_AND_REVISIONS.md
**Purpose**: Fact-checking session documentation
**Status**: Quality assurance record for exploratory notebooks
**Value**: Documents correction process and validation procedures
**Learning**: Systematic fact-checking essential for dissertation rigor

---

### 10. MODULARIZATION_PHASE2_SUMMARY.md (480 lines)
**Purpose**: Data screening utilities extraction
**Date**: November 20, 2025
**Module**: scripts/data_screening.py

**Components**:
- Missing data analysis
- Descriptive statistics
- Outlier detection (Mahalanobis distance)
- 90 lines extracted into reusable utilities

**Status**: Modularization approach not continued in dissertation
**Value**: Template for psychometric utility functions

---

### 11. MODULARIZATION_PHASE3_SUMMARY.md
**Purpose**: Extended modularization phase
**Status**: Continuation of refactoring experiments
**Value**: Software engineering methodology documentation

---

### 12. HYPOTHESIS_TESTING_AUDIT.md
**Purpose**: Hypothesis testing implementation review
**Status**: Pre-dissertation hypothesis specification
**Value**: Early hypothesis formulation attempts

---

### 13. HYPOTHESIS_TESTING_IMPLEMENTATION.md (641 lines)
**Purpose**: Hypothesis testing code implementation
**Date**: 2025-01-31
**Version**: 1.0

**Hypotheses**:
- H1: UTAUT2 core constructs predict BI
- H2: AI-specific constructs provide incremental validity
- H3: AIRS explains more variance than UTAUT2
- H4: Moderation by role, usage frequency, business unit

**Status**: Early hypothesis testing framework, superseded by dissertation H1-H5
**Value**: Template for hypothesis testing code structure
**Learning**: Explicit verdict logic improves clarity

---

### 14. PROJECT_README.md (328 lines)
**Purpose**: Project overview from exploratory phase
**Sample**: N=201
**Constructs**: 13 (12 predictors + 1 outcome)

**Key Content**:
- UTAUT2 core (7 constructs)
- Extensions (5 constructs: VO, TR, EX, ER, AX)
- Research questions (RQ1-RQ4)
- Critical discovery: VO, ER, AX measurement issues

**Status**: Superseded by main README.md focusing on 12-item scale
**Value**: Documents exploratory framework and issues

---

### 15. AIRS_Analysis_Guide_Concise v13.html
**Purpose**: HTML analysis guide from exploratory phase
**Status**: Legacy documentation format
**Value**: Historical reference

---

## 🔄 Methodological Evolution: Exploratory → Dissertation

| Dimension | Exploratory (Archived) | Dissertation Phase 1 |
|-----------|----------------------|---------------------|
| **Sample** | N=281 (or N=201-309 variants) | N=318, split 159/159 |
| **Outcome** | Mixed (adoption, BI, usage) | Behavioral Intention only |
| **Item Selection** | Data-driven (r with outcome) | Construct-balanced (1 per 12) |
| **Validation** | Single-sample metrics | Split-sample (EFA→CFA) |
| **Framework** | Exploratory (13 constructs) | Fixed (12 constructs) |
| **Factors** | Varied (1-4 factors tested) | 2 factors (parallel analysis) |
| **Purpose** | Exploration & optimization | Confirmatory hypothesis testing |
| **Hypotheses** | Post-hoc | A priori (H1-H5) |

---

## 📚 Key Learnings Extracted

### From DISSERTATION_MODEL_EVALUATION.md
**Learning**: UTAUT2 + AI-specific constructs achieve 92.2% AUC for adoption discrimination
**Application**: Validates feasibility of extended framework
**Dissertation Impact**: Informed construct selection for Phase 1

### From ITEM_LEVEL_ANALYSIS_REPORT.md
**Learning**: Item quality varies significantly within constructs (r = 0.50-0.82 range)
**Application**: Best-item-per-construct selection strategy
**Dissertation Impact**: Phase 1 selected strongest item per construct from preliminary EFA

### From AIRS_12_ITEM_DIAGNOSTIC_RATIONALE.md
**Learning**: Diagnostic utility requires theoretical coverage despite empirical parsimony
**Application**: Justified 12-item construct-balanced approach
**Dissertation Impact**: Dual-purpose design (diagnostic + predictive)

### From OUTCOME_VARIABLE_THEORETICAL_JUSTIFICATION.md
**Learning**: Cross-sectional design limits outcome to intention, not behavior
**Application**: BI as standard outcome per UTAUT2 framework
**Dissertation Impact**: Dissertation uses BI as outcome (not binary adoption)

### From Multiple Documents
**Learning**: 12-item forms achieve 80-82% R² with 50% reduction in burden
**Application**: 12-item target validated as optimal efficiency point
**Dissertation Impact**: Phase 1 developed 12-item construct-balanced scale

---

## 🎯 Archive Purpose

This archive preserves exploratory documentation that:

1. **Validated 12-Item Feasibility**: Multiple analyses showed 12-item efficiency
2. **Informed Item Selection**: Item-level analysis identified strongest indicators
3. **Explored Outcome Options**: Systematic comparison justified BI as outcome
4. **Documented Methodology**: Software engineering and quality assurance practices
5. **Tested Hypotheses**: Early hypothesis formulation informed final H1-H5

**Status**: Historical record enabling methodological transparency
**Use Case**: Reference for understanding design decisions, not for dissertation hypothesis testing

---

## 📖 Related Documentation

- **Learnings Synthesis**: `../../EXPLORATORY_PHASE_LEARNINGS.md` (primary synthesis document)
- **Dissertation Plan**: `../../airs/ANALYSIS_PLAN.md` (current roadmap)
- **Active Documentation**: `../../docs/` (dissertation proposal, data dictionary, etc.)
- **Main README**: `../../README.md` (project overview)

---

## 🚫 Why Archive?

**Critical Misalignments with Dissertation**:

1. **Mixed Samples**: N=201, N=281, N=309 variants (not standardized N=318 split-sample)
2. **Multiple Outcomes**: Adoption, BI, usage intensity (not standardized BI-only)
3. **Data-Driven Selection**: Correlation-based optimization (not construct-balanced)
4. **Single-Sample Metrics**: No independent validation (not split-sample EFA→CFA)
5. **Post-Hoc Analysis**: Exploratory findings (not a priori hypothesis testing)

**Dissertation Requirements**:
- A priori hypotheses (H1-H5) for confirmatory testing
- Split-sample validation (development + holdout)
- Construct-balanced scale (theoretical coverage)
- Fixed framework (8 UTAUT2 + 4 AI-specific = 12 total)
- Standardized outcome (BI per UTAUT2)

---

**Last Updated**: November 22, 2025 (Week 24/32)
**Archive Status**: Complete
**Next Action**: Phase 2 CFA validation on holdout sample using construct-balanced 12-item scale
