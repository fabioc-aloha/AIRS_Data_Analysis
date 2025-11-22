# Exploratory Phase Learnings

**Archive Status**: This document summarizes key methodological insights from the exploratory phase (N=281) that informed Phase 1 dissertation decisions. Original materials archived in:
- **Notebooks**: `archive/notebooks_exploratory/` (8 Jupyter notebooks)
- **Documentation**: `archive/docs_exploratory/` (15 analysis reports)

**Date Range**: Pre-October 2025 (exploratory) → November 2025 (dissertation Phase 1)

**Context**: Early exploratory work tested multiple approaches to scale development before settling on the construct-balanced methodology required for dissertation validity.

---

## 🎯 Key Methodological Insights That Informed Phase 1

### 1. Item-Level Performance Analysis
**Exploratory Finding**: Item-level correlation analysis with adoption outcome revealed 12 items with "very strong" correlations (r ≥ 0.70)

**Dissertation Application**:
- Confirmed feasibility of 12-item scale
- Informed selection of best-loading item per construct in Phase 1
- Validated that single items per construct could maintain predictive power

**Key Learning**: Item quality varies significantly within constructs—selecting highest-loading items per construct maximizes both theoretical coverage and empirical strength

**Source**: `AIRS_Item_Level_Analysis.ipynb` (archived)

---

### 2. Short-Form Optimization Principles
**Exploratory Finding**:
- 12-item data-driven form achieved R² = 82.2% (peak performance)
- 10-item empirical form achieved 99.7% of peak with 17% fewer items
- Optimal range: 8-12 items for efficiency vs. coverage trade-off

**Dissertation Application**:
- Established 12-item target as optimal balance
- Demonstrated 50% item reduction with minimal predictive loss is achievable
- Validated dual-purpose design (diagnostic coverage + predictive efficiency)

**Key Learning**: Diminishing returns occur beyond 12 items—additional items increase burden without meaningful R² gains

**Source**: `AIRS_Short_Form_Validation.ipynb` (archived)

---

### 3. Construct Coverage vs. Predictive Performance
**Exploratory Finding**: Data-driven selection (correlation-based) maximized prediction but created construct imbalance (some constructs had 0-3 items)

**Dissertation Decision**: Shifted to **construct-balanced** approach (1 item per 12 constructs) to ensure:
- Theoretical coverage for diagnostic utility
- Face validity with UTAUT2 + AI-specific framework
- Defensible item selection rationale (best item per construct, not atheoretical optimization)

**Key Learning**: Pure performance optimization sacrifices construct validity—theoretical frameworks require balanced representation

**Rationale**: `AIRS_Alternative_Outcomes_Optimization.ipynb` explored efficiency extremes; dissertation requires theoretical coherence

---

### 4. Sample Size and Split-Sample Design
**Exploratory Context**:
- Initial analyses used N=281 (after 201-205 data cleaning variations)
- No split-sample validation in exploratory phase
- Risk of overfitting to single sample

**Dissertation Improvement**:
- Expanded to N=318 (13% increase)
- Implemented stratified split: Development N=159, Holdout N=159
- Phase 1 uses development sample only; Phase 2 validates on independent holdout
- Reduces overfitting risk and strengthens generalizability claims

**Key Learning**: Split-sample validation is essential for scale development—single-sample psychometrics are insufficient for publication

---

### 5. Factor Structure Determination
**Exploratory Context**: Various notebooks tested 2-4 factor solutions without clear decision rules

**Dissertation Standardization**:
- **Kaiser Criterion**: Eigenvalues > 1.0 (3 factors suggested)
- **Parallel Analysis**: Compared with random data (2 factors empirically supported)
- **Decision Rule**: Accept parallel analysis result (more conservative, reduces over-extraction)
- **Outcome**: 2-factor structure (Facilitators, Barriers) with theoretical coherence

**Key Learning**: Multiple factor determination methods must be applied systematically—parallel analysis provides empirical anchor against over-extraction

**Implementation**: Phase 1 ran 100 random iterations for robust parallel analysis baseline

---

### 6. Outcome Variable Selection
**Exploratory Issue**: Mixed use of "adoption" (binary) vs. "behavioral intention" (continuous) as outcome

**Dissertation Standardization**:
- **Primary Outcome**: Behavioral Intention (BI) per UTAUT2 framework
- **Rationale**: Cross-sectional design cannot measure actual adoption (future behavior)
- **Theoretical Alignment**: BI is proximal predictor of adoption in TPB/UTAUT lineage
- **Measurement**: 3-item BI construct (BI1, BI2, BI3) averaging

**Key Learning**: Outcome selection has theoretical and methodological implications—must align with study design (cross-sectional = intention, not behavior)

**Source**: `docs/OUTCOME_VARIABLE_THEORETICAL_JUSTIFICATION.md` documents this decision

---

### 7. Psychometric Validation Procedures
**Exploratory Templates Tested**:
- KMO and Bartlett's tests for factorability
- Cronbach's α for internal consistency
- Factor loadings with multiple rotation methods (Varimax, Promax, Oblimin)
- Variance explained calculations
- Cross-loadings assessment

**Dissertation Standards Adopted**:
- **Factorability**: KMO ≥ 0.60 (adequate), ≥ 0.80 (good), Bartlett's p < 0.001
- **Reliability**: α ≥ 0.70 (acceptable), ≥ 0.80 (good)
- **Loadings**: λ ≥ 0.40 (minimum), ≥ 0.50 (preferred)
- **Rotation**: Promax (oblique) for correlated factors
- **Variance**: ≥ 50% cumulative explained (2-factor solution achieved 58.1%)

**Key Learning**: Consistent thresholds and reporting standards essential for rigor—exploratory phase tested procedures, dissertation applies them systematically

---

### 8. Statistical Software and Reproducibility
**Exploratory Approach**: Mixed use of various libraries without version control

**Dissertation Standardization**:
```python
# Phase 1 Standard Environment
Python 3.11.9
factor-analyzer==0.5.1  # EFA/CFA
pandas==2.2.3           # Data manipulation
numpy==2.1.2            # Numerical operations
scikit-learn==1.5.2     # Predictive modeling
matplotlib==3.9.2       # Visualization
random_state=42         # All stochastic operations
```

**Key Learning**: Reproducibility requires version-locked dependencies and consistent random seeds—exploratory phase identified stable tool combinations

---

## 📊 Methodological Evolution: Exploratory → Dissertation

| Dimension | Exploratory Phase | Dissertation Phase 1 |
|-----------|------------------|---------------------|
| **Sample** | N=281, single sample | N=318, split 159/159 |
| **Item Selection** | Data-driven (correlation-based) | Construct-balanced (1 per 12) |
| **Factor Determination** | Multiple methods, inconsistent | Parallel analysis (standardized) |
| **Outcome Variable** | Mixed (adoption + BI) | Behavioral Intention only |
| **Validation** | Single-sample metrics | Development + holdout validation |
| **Theoretical Framework** | Exploratory construct testing | UTAUT2 + 4 AI-specific (fixed) |
| **Reproducibility** | Partial documentation | Full version control + seed=42 |
| **Purpose** | Exploration & optimization | Hypothesis testing & validation |

---

## 🔬 Critical Decisions Informed by Exploratory Work

### Decision 1: 12-Item Target
**Evidence Base**:
- Exploratory work showed 12-item forms achieved 82.0-82.2% R² (peak performance)
- 24→12 item reduction retained 96.3% of predictive power
- 12 items = 12 constructs → clean 1:1 mapping

**Dissertation Rationale**: 12-item construct-balanced scale optimizes dual purpose (diagnostic coverage + predictive efficiency)

---

### Decision 2: 2-Factor Acceptance
**Evidence Base**:
- Kaiser criterion suggested 3 factors (eigenvalues > 1.0)
- Parallel analysis supported 2 factors (empirical data > random baseline)
- 2-factor interpretation had theoretical coherence (Facilitators vs. Barriers)

**Dissertation Rationale**: Accept more conservative parallel analysis result; 2-factor structure aligns with approach-avoidance psychology

---

### Decision 3: Item Selection Strategy
**Evidence Base**:
- Item-level analysis identified strongest item per construct
- Data-driven optimization created construct imbalance
- Balanced representation required for diagnostic validity

**Dissertation Rationale**: Select best-loading item per construct from preliminary 4-factor EFA (balances empirical strength with theoretical coverage)

---

### Decision 4: Split-Sample Design
**Evidence Base**:
- Single-sample analyses in exploratory phase couldn't assess generalizability
- Risk of overfitting to specific sample characteristics
- Scale development best practices require independent validation

**Dissertation Rationale**: Stratified split (159/159) enables EFA on development sample with CFA validation on independent holdout

---

## 🎓 Implications for Phases 2-5

### Phase 2 (CFA Validation)
**Apply Learnings**:
- Use holdout sample (N=159) for independent validation
- Test 2-factor structure with fit indices (CFI/TLI ≥ 0.90, RMSEA ≤ 0.08)
- Calculate composite reliability (CR ≥ 0.70) and AVE (≥ 0.50)
- Assess discriminant validity (Fornell-Larcker, HTMT < 0.85)

**Exploratory Foundation**: Templates for CFA procedures tested in `AIRS_Analysis_Python.ipynb` (archived)

---

### Phase 3 (Structural Models)
**Apply Learnings**:
- Model 1: 8 UTAUT2 constructs → BI (R² baseline)
- Model 2: 12 constructs → BI (incremental validity test)
- Test ΔR² ≥ 0.10 for meaningful improvement (H3)

**Exploratory Foundation**: Regression comparisons in `AIRS_Adoption_Analysis_v2.ipynb` demonstrated model comparison logic

---

### Phase 4 (Mediation)
**Apply Learnings**:
- Bootstrap procedures (5000 iterations, 95% CI)
- Indirect effects: EX→TR→BI, ER→TR→BI, ER→AX→BI
- Exploratory work validated bootstrap stability

**Exploratory Foundation**: Preliminary mediation templates tested pathways feasibility

---

### Phase 5 (Moderation)
**Apply Learnings**:
- Multi-group SEM by role, usage, adoption status
- Measurement invariance prerequisite (Phase 2)
- Chi-square difference tests for path differences

**Exploratory Foundation**: Subgroup analyses in exploratory notebooks demonstrated heterogeneity

---

## 📁 Archived Notebooks Summary

All exploratory notebooks moved to `archive/notebooks_exploratory/`:

1. **AIRS_Adoption_Analysis_v2.ipynb** - Adoption prediction with N=281, logistic regression, AUC=92.2%
2. **AIRS_Alternative_Outcomes_Optimization.ipynb** - Multiple outcome variable comparisons
3. **AIRS_Analysis_Python.ipynb** - Preliminary EFA/CFA psychometric validation (63 cells)
4. **AIRS_Data_Exploration.ipynb** - Initial data quality and distribution analysis
5. **AIRS_Item_Level_Analysis.ipynb** - Item-outcome correlations, construct-level performance
6. **AIRS_Short_Form_Validation.ipynb** - Short-form optimization (5-24 items), R² curves
7. **Construct_Reliability_Validation.ipynb** - Reliability metrics across construct subsets
8. **AIRS_Analysis.Rmd** - R Markdown alternative analysis

**Archive Status**: Historical record of exploratory decisions that informed dissertation methodology

---

## 🔄 Continuity & Discontinuity

### What Continued from Exploratory → Dissertation
✅ 12-item target length (validated efficiency)
✅ 2-factor empirical structure (parallel analysis support)
✅ Psychometric validation procedures (KMO, α, loadings)
✅ Python statistical stack (factor-analyzer, pandas, sklearn)
✅ Behavioral Intention as outcome (theoretical alignment)

### What Changed for Dissertation Rigor
🔄 **Sample**: N=281 single → N=318 split (159/159)
🔄 **Item Selection**: Data-driven → Construct-balanced
🔄 **Validation**: Single-sample → Split-sample (EFA→CFA)
🔄 **Framework**: Exploratory constructs → Fixed 12 (8 UTAUT2 + 4 AI)
🔄 **Hypotheses**: Post-hoc → A priori (H1-H5)
🔄 **Purpose**: Exploration → Confirmatory hypothesis testing

---

## 📚 Key References from Exploratory Work

**Methodological Foundations Applied**:
- Venkatesh et al. (2012) - UTAUT2 framework
- Kaiser (1974) - Kaiser criterion for factor extraction
- Horn (1965) - Parallel analysis methodology
- Hu & Bentler (1999) - CFA fit index cutoffs
- Fornell & Larcker (1981) - Discriminant validity assessment
- Hair et al. (2010) - Multivariate data analysis procedures

**Complete Bibliography**: See `notebooks_exploratory/AIRS_Analysis_Python.ipynb` (Cell #63, archived)

---

## 🎯 Summary: Value of Exploratory Phase

The exploratory phase (N=281, pre-October 2025) served critical preparatory functions:

1. **Validated Feasibility**: Confirmed 12-item scale could achieve 96.3% of 24-item predictive power
2. **Informed Item Selection**: Identified strongest items per construct through correlation analysis
3. **Established Procedures**: Tested and refined psychometric validation workflows
4. **Revealed Trade-offs**: Documented construct coverage vs. prediction optimization tensions
5. **Guided Design Decisions**: Provided evidence base for split-sample, construct-balanced approach

**Transition Point**: October 2025 shift from exploratory optimization → confirmatory validation for dissertation

**Current Status**: Phase 1 complete (November 2025) with 12-item construct-balanced scale, α=0.897, R²=0.811, 2-factor structure validated on development sample (N=159). Phase 2 (CFA on holdout N=159) next.

---

---

## 📂 Additional Exploratory Documentation Insights

### From Archived Reports (`archive/docs_exploratory/`)

**9. Adoption Prediction Excellence (DISSERTATION_MODEL_EVALUATION.md)**
**Exploratory Finding**: UTAUT2 + AI-specific constructs achieved 92.2% AUC for adoption discrimination (N=281)

**Key Results**:
- Performance Expectancy: Cohen's d=1.837 (strongest predictor)
- Explainability: d=1.728 (#3 overall, ahead of Hedonic Motivation)
- Trust in AI: Part of validated enabler pathway
- AI-specific inhibitors (ER, AX): Non-significant in adoption context

**Dissertation Application**: Validated feasibility of extended UTAUT2 framework with AI-specific constructs
**Learning**: AI-specific enablers (Trust, Explainability) show stronger effects than inhibitors (Ethical Risk, Anxiety)

---

**10. Diagnostic Tool Rationale (AIRS_12_ITEM_DIAGNOSTIC_RATIONALE.md)**
**Exploratory Finding**: Empirical factor analysis showed dominant general factor (λ=6.81, 57% variance), but 12 constructs retained for diagnostic utility

**Key Argument**: Theoretical completeness overrides empirical parsimony when scale purpose is organizational diagnosis

**Dissertation Application**: Justified 12-item construct-balanced design (diagnostic granularity + predictive efficiency)
**Learning**: Dual-purpose scales require balancing empirical parsimony with theoretical coverage

---

**11. Ultra-Short Form Efficiency (AIRS_7_ITEM_QUESTIONNAIRE.md)**
**Exploratory Finding**: 7-item form (HM2, PV2, PE2, SI2, FC1, TR1, BI1) achieved α=0.939, r(BI)=0.776, R²=60.2% with 71% time reduction

**Dissertation Application**: Demonstrated extreme efficiency trade-offs (7 items = 60% R², 12 items = 81% R²)
**Learning**: Optimal efficiency point is 12 items (balance of coverage and prediction)

---

**12. Outcome Variable Justification (OUTCOME_VARIABLE_THEORETICAL_JUSTIFICATION.md)**
**Exploratory Context**: 88.6% post-adoption sample (N=281) required justification for adoption vs. BI as outcome

**Key Argument**: Binary adoption appropriate for post-adoption context, but cross-sectional design limits to intention

**Dissertation Application**: Standardized on Behavioral Intention (BI) as outcome per UTAUT2 framework
**Learning**: Cross-sectional design cannot measure future behavior—intention is appropriate outcome

---

**13. Modularization & Quality Assurance**
**Exploratory Experiments**:
- Code refactoring into reusable modules (MODULARIZATION_PHASE2/3_SUMMARY.md)
- Systematic fact-checking (NOTEBOOK_FACT_CHECK_AND_REVISIONS.md)
- Hypothesis testing frameworks (HYPOTHESIS_TESTING_IMPLEMENTATION.md)

**Dissertation Application**: Software engineering practices (version control, modular code, systematic validation)
**Learning**: Reproducibility requires modular code, consistent standards, systematic fact-checking

---

**Prepared**: November 22, 2025
**Context**: Week 24 of 32 (Dissertation Timeline)
**Purpose**: Document exploratory learnings that informed dissertation methodology
**Archives**: `archive/notebooks_exploratory/` (8 notebooks) + `archive/docs_exploratory/` (15 reports)
**Status**: Exploratory notebooks archived, dissertation Phase 1 complete, Phase 2 next
