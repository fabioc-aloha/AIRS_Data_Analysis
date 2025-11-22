# AIRS Analysis Plan
**Proposal Compliance Roadmap**

## Quick Reference

**Current Status**: Phase 2 (CFA) Complete ✅ | Phase 1 Complete ✅
**Week**: 24 of 32 (November 22, 2025)
**Scale**: 12-item construct-balanced (2 empirical factors)
**Samples**: Development N=162 | Holdout N=163
**Next Action**: Execute `03_Measurement_Invariance.ipynb` to test invariance across groups

### Analysis Roadmap

| Phase              | Notebook | Description                           | Status       | Target Week |
| ------------------ | -------- | ------------------------------------- | ------------ | ----------- |
| **1. Measurement** | 00       | Data Splitting                        | ✅ Complete  | 23          |
| **1. Measurement** | 01       | EFA - Scale Development               | ✅ Complete  | 24          |
| **2. Validation**  | 02       | CFA - Measurement Model               | ✅ Complete  | 25          |
| **2. Validation**  | 03       | Measurement Invariance                | ⏭️ Next      | 26          |
| **3. Hypothesis**  | 04       | Structural Models (H1-H3)             | ⏳ Pending   | 27          |
| **3. Hypothesis**  | 05       | Mediation Analysis (H5)               | ⏳ Pending   | 28          |
| **4. Moderation**  | 06       | Multi-group Analysis (H4)             | ⏳ Pending   | 29-30       |
| **5. Integration** | 07       | Comprehensive Results Summary         | ⏳ Pending   | 31          |

---

## Dual Purpose

**Purpose 1: Diagnostic Tool**
- Provide comprehensive construct coverage across 12 AI readiness dimensions
- Enable individual and organizational readiness profiling
- Identify specific strengths and barriers to AI adoption
- Support targeted intervention strategies

**Purpose 2: Predictive Model**
- Achieve parsimonious prediction of behavioral intention (BI) to adopt AI
- Test incremental validity of AI-specific constructs beyond UTAUT2
- Validate empirical factor structure (2 dimensions: Facilitators vs. Barriers)
- Maintain high predictive power with reduced item burden

---

## Research Questions

**RQ1**: What is the psychometric structure of AI readiness among knowledge workers?
- Addressed by: EFA (Phase 1 ✅), CFA (Phase 2 ⏭️)

**RQ2**: Do UTAUT2 constructs predict behavioral intention to adopt AI in the workplace?
- Addressed by: Structural modeling (Phase 3, H1)

**RQ3**: Do AI-specific constructs (Trust, Explainability, Ethical Risk, Anxiety) add explanatory power beyond UTAUT2?
- Addressed by: Model comparison (Phase 3, H2-H3)

**RQ4**: What mediating mechanisms explain the relationship between AI-specific perceptions and adoption intention?
- Addressed by: Mediation analysis (Phase 3, H5a-H5c)

**RQ5**: Are relationships between predictors and adoption intention moderated by individual and contextual factors?
- Addressed by: Multi-group SEM (Phase 4, H4)

---

## Hypotheses

### H1: UTAUT2 Baseline Model
**H1**: UTAUT2 constructs—Performance Expectancy (PE), Effort Expectancy (EE), Social Influence (SI), Facilitating Conditions (FC), Hedonic Motivation (HM), Price Value (PV), Habit (HB), and Voluntariness of Use (VO)—will significantly predict behavioral intention to adopt AI.

**Status**: ⏳ Pending Phase 3
**Test**: Structural model with 7 UTAUT2 + VO constructs → BI
**Note**: VO reintroduced for enterprise AI context (see theoretical justification below)

#### Clarification: Voluntariness of Use in UTAUT and UTAUT2

**Original UTAUT (2003)**: VO functioned as a **moderator** (not direct predictor) of the Social Influence → Behavioral Intention relationship. In mandatory contexts, social influence was stronger; in voluntary contexts, weaker (Venkatesh et al., 2003).

**UTAUT2 (2012)**: VO was removed as a moderator because UTAUT2 focused on consumer contexts where technology use is almost always voluntary. Social influence operates differently in consumer decision-making (Venkatesh et al., 2012).

**Reintroduction for Enterprise AI**: This study reintroduces VO because:
- Enterprise environments often have mandatory AI tools or strong managerial expectations
- Employee readiness differs dramatically when AI use feels forced vs. self-initiated
- Modern UTAUT extensions for organizational AI adoption reintroduce voluntariness as it influences perceived autonomy, psychological reactance, motivation, and resistance behaviors
- Aligns with study's exploration of AI anxiety and ethical risk as organizational barriers

**References**:
- Venkatesh, V., Morris, M. G., Davis, G. B., & Davis, F. D. (2003). User acceptance of information technology: Toward a unified view. *MIS Quarterly, 27*(3), 425–478.
- Venkatesh, V., Thong, J. Y. L., & Xu, X. (2012). Consumer acceptance and use of information technology: Extending the Unified Theory of Acceptance and Use of Technology. *MIS Quarterly, 36*(1), 157–178.

---

### H2: AI-Specific Constructs
**H2**: AI-specific constructs—Trust in AI (TR), Explainability (EX), Ethical Risk (ER), and AI Anxiety (AX)—will significantly predict behavioral intention to adopt AI beyond UTAUT2 constructs.

**Directional Predictions**:
- TR (+): Higher trust → higher adoption intention
- EX (+): Greater explainability → higher adoption intention
- ER (−): Greater ethical risk perception → lower adoption intention
- AX (−): Higher anxiety → lower adoption intention

**Status**: ⏳ Pending Phase 3
**Test**: Incremental effect of 4 AI constructs in full model

---

### H3: Incremental Validity
**H3**: The AIRS extended model (UTAUT2 + AI-specific constructs) will explain significantly more variance in behavioral intention than the UTAUT2 baseline model alone.

**Operationalization**: R²(AIRS) > R²(UTAUT2), ΔR² significant
**Expected Effect**: ΔR² ≥ 0.10 (medium incremental validity)

**Status**: ⏳ Pending Phase 3
**Test**: Chi-square difference test or F-test for nested models

---

### H4: Contextual Moderation
**H4**: The relationships between predictors (UTAUT2 and AI-specific constructs) and behavioral intention will be moderated by:
- **Role** (Student vs. Professional vs. Faculty)
- **AI Usage Frequency** (Low vs. High)
- **AI Adoption Status** (Adopter vs. Non-adopter)

**Specific Predictions**:
- **H4a (Role)**: Trust and Explainability effects stronger for professionals (discretionary context)
- **H4b (Role)**: Social Influence effects stronger for students (normative pressure)
- **H4c (Usage)**: Habit effect stronger for high-frequency users
- **H4d (Usage)**: Anxiety effect weaker for high-frequency users (exposure effect)
- **H4e (Adoption)**: Facilitators (Factor 1) more salient for adopters; Barriers (Factor 2) more salient for non-adopters

**Status**: ⏳ Pending Phase 4
**Test**: Multi-group SEM with chi-square difference tests for path equality

---

### H5: Mediation Mechanisms (Exploratory)
**H5**: The relationships between AI-specific constructs and behavioral intention will be mediated by Trust in AI and AI Anxiety:

**H5a**: Trust in AI (TR) will mediate the relationship between Explainability (EX) and behavioral intention (BI).
- Path: EX → TR → BI (indirect effect significant)

**H5b**: Trust in AI (TR) will mediate the relationship between Ethical Risk (ER) and behavioral intention (BI).
- Path: ER → TR → BI (indirect effect significant)
- Direction: Higher ethical risk → lower trust → lower adoption intention

**H5c**: AI Anxiety (AX) will mediate the relationship between Ethical Risk (ER) and behavioral intention (BI).
- Path: ER → AX → BI (indirect effect significant)
- Direction: Higher ethical risk → higher anxiety → lower adoption intention

**Status**: ⏳ Pending Phase 3
**Test**: Bootstrap mediation analysis (5000 iterations, 95% CI)
**Addresses**: RQ4 (mediating mechanisms)

---

## Overview
This plan bridges the gap between current exploratory analysis and the dissertation proposal requirements (DBA Project Proposal v4). Phase 1 (scale development) is complete; this document guides Phases 2-5 to ensure full proposal compliance.

---

## Current Status (Updated: November 22, 2025)

### 📊 Phase 1 Summary: Key Achievements

**Scale Design Decision**: Construct-balanced 12-item diagnostic scale
- **Rationale**: Dual-purpose instrument balancing comprehensive construct coverage (diagnostic utility) with parsimonious predictive modeling
- **Approach**: Selected 1 best item per 12 constructs from 24-item pool
- **Factor Structure**: Data-driven empirical determination (not theory-forced)

**Empirical Results**:
- **Sample**: Development N=162 (stratified by Work_Context × AI_Adoption)
- **Factor Solution**: 2 factors (via parallel analysis)
  - Factor 1: Mixed Readiness (PE, EE, SI, FC, HM, PV, HB, TR, VO, EX) - 10 items
  - Factor 2: Risk/Anxiety (ER, AX) - 2 items
  - Inter-factor correlation: r = 0.135 (weak, supporting discriminant validity)
- **Psychometric Quality (Development Sample)**:
  - Internal consistency: Cronbach's α = 0.892 (Good)
  - Variance explained: 58.4% (2-factor model)
  - KMO: 0.909 (Excellent sampling adequacy)
- **Selected Items**: PE1, EE1, SI1, FC1, HM2, PV2, HB1, VO1, TR2, EX1, ER1, AX2

**Critical Insight**: While theoretical framework posits 12 distinct constructs, empirical data converge on 2 higher-order dimensions (positive attitudes/facilitators vs. concerns/barriers). This pattern suggests potential second-order factor structure to explore in CFA.

### ✅ Completed
- **Preprocessing pipeline** (`preprocess_airs_data.py`)
  - Quality controls (attention checks, speeders, duration outliers)
  - IP geolocation for regional analysis
  - Construct/item renaming to standard codes
  - Complete survey filtering

- **Data Splitting** (`00_Create_Split_Samples.ipynb`)
  - Stratified 50/50 split by Work_Context × AI_Adoption
  - Development sample: N=162
  - Holdout sample: N=163
  - Validated balance across demographics and item distributions

- **12-Item Scale Development** (`01_EFA_Construct_Balanced_12_Item.ipynb`)
  - Construct-balanced item selection (1 item per 12 constructs)
  - Parallel analysis for empirical factor determination (2 factors)
  - Reliability: Cronbach's α = 0.892
  - KMO: 0.909 (Excellent)
  - Factor 1: Mixed Readiness (10 items: PE1, EE1, SI1, FC1, HM2, PV2, HB1, VO1, TR2, EX1)
  - Factor 2: Risk/Anxiety (2 items: ER1, AX2)

- **Confirmatory Factor Analysis** (`02_CFA_Measurement_Model.ipynb`)
  - Validated 2-factor structure on independent holdout sample (N=163)
  - Model fit: **ADEQUATE** (CFI=0.926, TLI=0.907, RMSEA=0.096, SRMR≈0.050)
  - Factor 1 reliability: **EXCELLENT** (α=0.924, CR=0.925, AVE=0.557)
  - Factor 2 reliability: **PROBLEMATIC** (α=0.545, CR=0.688, AVE=0.571)
  - Discriminant validity: **ESTABLISHED** (HTMT=0.337 < 0.85)
  - Critical finding: ER1 loading=0.376 (below 0.50 threshold) - documented limitation

### ❌ Missing (Proposal Requirements)

| Proposal Section | Requirement | Status | Priority |
|-----------------|-------------|---------|----------|
| 7.7 Analysis Plan | Split-sample validation (EFA → CFA) | ✅ Complete | **P1** |
| 7.7 | Composite Reliability (CR) ≥ 0.70 | ✅ Complete (F1 only) | **P1** |
| 7.7 | Average Variance Extracted (AVE) ≥ 0.50 | ✅ Complete | **P1** |
| 7.7 | Fornell-Larcker discriminant validity | ✅ Complete | **P1** |
| 7.7 | Heterotrait-Monotrait (HTMT) ratios | ✅ Complete | **P1** |
| 7.7 | Model fit indices (CFI, TLI, RMSEA, SRMR) | ✅ Complete | **P1** |
| 7.7 | Measurement invariance (role, usage) | Missing | **P2** |
| 7.7 | Structural modeling: UTAUT2 baseline | Missing | **P2** |
| 7.7 | Structural modeling: AIRS extended | Missing | **P2** |
| 7.7 | Mediation: Explainability → Trust → BI | Missing | **P2** |
| 7.7 | Moderation: Role, usage, business unit | Missing | **P3** |
| H1 | Test UTAUT2 constructs → BI | Missing | **P2** |
| H2 | Test AI-specific constructs → BI | Missing | **P2** |
| H3 | Incremental validity (UTAUT2 vs. AIRS) | Missing | **P2** |
| H4 | Contextual moderators | Missing | **P3** |

---

## Phase 1: Measurement Model Validation (Weeks 23-26)

### ✅ Notebook 1: Data Splitting and Scale Development
**Files**: `00_Create_Split_Samples.ipynb`, `01_EFA_Construct_Balanced_12_Item.ipynb`

**Status**: COMPLETE

**Completed Objectives**:
- ✅ Created stratified 50/50 split (Development N=159, Holdout N=159)
- ✅ Stratified by Work_Context × AI_Adoption
- ✅ Validated balance across demographics and item distributions
- ✅ Developed 12-item construct-balanced scale
- ✅ Selected best item per construct via preliminary 4-factor EFA
- ✅ Determined empirical factor structure via parallel analysis (2 factors)
- ✅ Validated reliability (α = 0.897) and predictive validity (R² = 0.811)

**Delivered Output Files**:
```python
data/AIRS_clean_dev.csv              # Development sample (N=162)
data/AIRS_clean_holdout.csv          # Holdout sample (N=163)
data/airs_12item_selection.json      # Item selection documentation
data/AIRS_clean_dev_12item.csv       # 12-item development dataset
```

**Key Results**:
- KMO = 0.909 (sampling adequacy: Excellent)
- Bartlett's test p < 0.001 (factorability confirmed)
- All factor loadings ≥ 0.50 (range: 0.54-0.85)
- 2-factor structure empirically supported (Parallel analysis: 2 factors)
- Selected items: PE1, EE1, SI1, FC1, HM2, PV2, HB1, VO1, TR2, EX1, ER1, AX2

**Acceptance Criteria Met**:
- ✅ Sample split documented and reproducible (random_state=42)
- ✅ Loading matrix meets thresholds (all ≥ 0.50)
- ✅ Construct definitions align with proposal
- ✅ Dual-purpose design: diagnostic coverage + predictive parsimony

---

### ✅ Notebook 2: Confirmatory Factor Analysis
**File**: `02_CFA_Measurement_Model.ipynb` ✅ COMPLETE

**Status**: COMPLETE

**Objectives**: ✅ All achieved
- Validated 2-factor structure on holdout sample (N=163)
- Tested 12-item measurement model fit
- Estimated reliability and validity metrics
- Assessed discriminant validity between factors

**Model Specification**:
```python
# Factor 1: Mixed Readiness (10 items)
F1: PE1, EE1, SI1, FC1, HM2, PV2, HB1, VO1, TR2, EX1

# Factor 2: Risk/Anxiety (2 items)
F2: ER1, AX2

# Allow factors to correlate (oblique model)
```

**Deliverables**:

**A. Model Fit Indices** (Proposal Section 7.7 thresholds):
- CFI ≥ 0.90
- TLI ≥ 0.90
- RMSEA ≤ 0.08
- SRMR ≤ 0.08
- Chi-square test and df

**B. Reliability** (Per Factor):
- Cronbach's α ≥ 0.70
- McDonald's ω ≥ 0.70
- Composite Reliability (CR) ≥ 0.70

**C. Convergent Validity** (Per Factor):
- Standardized loadings ≥ 0.50
- Average Variance Extracted (AVE) ≥ 0.50

**D. Discriminant Validity**:
- Fornell-Larcker criterion: √AVE(F1) and √AVE(F2) > |r(F1,F2)|
- HTMT < 0.85 (conservative) or < 0.90 (liberal)
- Inter-factor correlation (expected r ≈ 0.17 based on EFA)

**Implementation**:
```python
# Using semopy for Python-based SEM
import semopy
from semopy import Model

# Define model specification
model_spec = """
# Measurement model
F1 =~ PE1 + FC1 + HM1 + PV2 + HB2 + TR1 + VO1
F2 =~ AX2 + ER1 + EE2 + SI2 + EX1

# Factor covariance (oblique model)
F1 ~~ F2
"""

# Fit model on holdout sample
model = Model(model_spec)
result = model.fit(df_holdout)

# Extract fit indices, CR, AVE, HTMT
# Generate APA-formatted tables
```

**Acceptance Criteria**:
- [x] Model fit indices assessed: CFI=0.926 ✅, TLI=0.907 ✅, RMSEA=0.096 ⚠️, SRMR≈0.050 ✅
- [x] CR and AVE calculated for both factors
- [x] Fornell-Larcker and HTMT discriminant validity assessed (both met)
- [x] Standardized loadings table generated
- [x] Model limitations documented (ER1 loading=0.376, F2 marginal reliability)
- [x] Results tables formatted for dissertation

**Actual Outcomes**:
- ✅ 2-factor structure replicated on holdout sample (N=163)
- ✅ Factor 1 (Mixed Readiness): **EXCELLENT** reliability (α=0.924, CR=0.925, AVE=0.557)
  - All 10 items load ≥ 0.50 (range: 0.594-0.850, mean=0.740)
- ⚠️ Factor 2 (Risk/Anxiety): **PROBLEMATIC** reliability (α=0.545, CR=0.688, AVE=0.571)
  - ER1 loading=0.376 (below 0.50 threshold) - documented as limitation
  - AX2 loading=1.000 (constrained for identification)
- ✅ Discriminant validity: HTMT=0.337 < 0.85, Fornell-Larcker criterion met
- ✅ Overall model fit: **ADEQUATE** (4 of 6 indices meet thresholds)
- 📋 Decision: Proceed with 12-item scale, document F2 limitations in dissertation

---

### Notebook 3: Measurement Invariance Testing
**File**: `03_Measurement_Invariance.ipynb` (TO BE CREATED)

**Status**: ⏭️ NEXT PRIORITY (CFA complete)

**Objectives**:
- Test configural, metric, and scalar invariance
- Validate that 2-factor structure measures the same constructs across groups
- Required before multi-group structural comparisons (H4 moderation)

**Groups to Test** (Proposal Section 7.7):
1. **Role**: Students vs. Professionals vs. Faculty
2. **AI Usage Frequency**: Low (Never/Rarely) vs. High (Often/Daily)
3. **AI Adoption**: Adopters vs. Non-adopters

**Deliverables**:

**A. Configural Invariance**:
- Same factor structure holds across groups
- CFI/TLI ≥ 0.90 in both groups

**B. Metric Invariance**:
- Factor loadings equivalent across groups
- ΔCFI ≤ 0.010 or ΔRMSEA ≤ 0.015

**C. Scalar Invariance**:
- Item intercepts equivalent across groups
- ΔCFI ≤ 0.010 or ΔRMSEA ≤ 0.015

**Implementation**:
```python
# Multi-group CFA
# Test nested models: configural → metric → scalar
# Report chi-square difference tests and fit index changes
```

**Acceptance Criteria**:
- [ ] Configural invariance established for all grouping variables
- [ ] Metric invariance tested (loadings constrained)
- [ ] Scalar invariance tested (intercepts constrained)
- [ ] Non-invariant items identified and documented
- [ ] Decision on partial vs. full invariance justified

---

## Phase 2: Structural Models & Hypothesis Testing (Weeks 27-28)

### Notebook 4: Structural Model Comparison (H1-H3)
**File**: `04_Structural_Model_Hypothesis_Testing.ipynb` (TO BE CREATED)

**Status**: PENDING (requires CFA completion)

**Objectives**:
- Test H1: UTAUT2 constructs predict AI adoption readiness
- Test H2: AI-specific constructs add explanatory power
- Test H3: AIRS extended model explains more variance than UTAUT2

**Models to Compare**:

**Model 1: UTAUT2 Baseline** (H1)
```
Predictors: 7 UTAUT2 constructs (PE, EE, SI, FC, HM, PV, HB) + VO (reintroduced)
Outcome: BI (Behavioral Intention / AI Adoption Readiness)
Note: VO (Voluntariness) included based on 12-item scale
```

**Model 2: AIRS Extended** (H2 + H3)
```
Predictors: 12 constructs (UTAUT2 + AI-specific: TR, EX, ER, AX)
Outcome: BI
Note: Can model as 2 factors → BI or 12 individual items → BI
```

**Alternative**: Factor-Based Structural Model
```
Model 1: Factor 1 (Facilitators) → BI
Model 2: Factor 1 + Factor 2 (Facilitators + Barriers) → BI
Test ΔR² for incremental validity of barriers dimension
```

**Deliverables**:

**A. Direct Effects Table**:
| Construct | UTAUT2 β | AIRS β | UTAUT2 p | AIRS p | Change |
|-----------|----------|---------|----------|---------|---------|
| PE        | 0.xx     | 0.xx    | <.001    | <.001   | ↓       |
| EE        | 0.xx     | 0.xx    | <.01     | <.05    | ↓       |
| ...       | ...      | ...     | ...      | ...     | ...     |
| TR        | —        | 0.xx    | —        | <.001   | **New** |
| EX        | —        | 0.xx    | —        | <.01    | **New** |
| ER        | —        | -0.xx   | —        | <.01    | **New** |
| AX        | —        | -0.xx   | —        | <.05    | **New** |

**B. Model Comparison**:
- R² (UTAUT2) vs. R² (AIRS)
- ΔR² and F-test or chi-square difference
- AIC/BIC for model selection
- Effect sizes (Cohen's f²) for incremental predictors

**C. Path Diagram**:
- Visual representation of significant paths
- Standardized coefficients displayed
- Color-coded by construct family (UTAUT2 core vs. AI-specific)

**Acceptance Criteria**:
- [ ] H1 tested: 7 UTAUT2 constructs + VO (reintroduced from UTAUT 2003) significantly predict BI
- [ ] H2 tested: 4 AI-specific constructs significantly predict BI
- [ ] H3 tested: AIRS R² > UTAUT2 R², difference is significant
- [ ] Incremental validity documented with effect sizes
- [ ] Non-significant paths reported and discussed
- [ ] VO (Voluntariness) inclusion justified based on construct coverage

---

### Notebook 5: Mediation Analysis (H5)
**File**: `05_Mediation_Analysis.ipynb` (TO BE CREATED)

**Status**: PENDING (requires structural model completion)

**Objectives**:
- Test H5a: Explainability → Trust in AI → Behavioral Intention
- Test H5b: Ethical Risk → Trust → Behavioral Intention
- Test H5c: Ethical Risk → Anxiety → Behavioral Intention
- Decompose total, direct, and indirect effects
- Assess whether trust and anxiety mediate relationships (RQ4)

**Primary Mediation Models**:

**Model 1: Trust Mediation**
```
EX1 → TR1 → BI (indirect path)
EX1 → BI (direct path)
```

**Model 2: Ethical Risk → Trust**
```
ER1 → TR1 → BI (indirect path)
ER1 → BI (direct path)
```

**Model 3: Anxiety Mediation**
```
ER1 → AX2 → BI (indirect path)
ER1 → BI (direct path)
```

**B. Effect Decomposition**:
- Total effect of EX on BI
- Direct effect of EX on BI (controlling for TR)
- Indirect effect of EX on BI through TR
- Proportion mediated: (indirect / total) × 100%

**C. Bootstrap Confidence Intervals**:
- 95% CI for indirect effect (bias-corrected bootstrap, k=5000)
- Significance: CI excludes zero

**Implementation**:
```python
# Using semopy or process macro equivalent
# Report: a-path (EX→TR), b-path (TR→BI), c-path (EX→BI direct)
# Bootstrap indirect effect ab
```

**Acceptance Criteria**:
- [ ] H5a tested: EX → TR → BI mediation (bootstrap CI for indirect effect)
- [ ] H5b tested: ER → TR → BI mediation (bootstrap CI for indirect effect)
- [ ] H5c tested: ER → AX → BI mediation (bootstrap CI for indirect effect)
- [ ] Proportion mediated calculated for each pathway
- [ ] Direct vs. indirect effects decomposed and compared
- [ ] Results address RQ4 (mediating mechanisms)

---

## Phase 3: Moderation Analysis (Weeks 29-30)

### Notebook 6: Contextual Moderators (H4)
**File**: `06_Moderation_Analysis.ipynb` (TO BE CREATED)

**Status**: PENDING (requires invariance testing completion)

**Objectives**:
- Test H4: Relationships between predictors and BI are moderated by contextual factors
- Examine role, AI usage frequency, and business unit as moderators
- Use multi-group SEM to compare structural paths across groups

**Moderators to Test** (Proposal Section 5.3):

**1. Role (Student vs. Professional vs. Faculty)**:
- Prediction: Factor 1 (Facilitators) → BI stronger for professionals (discretionary context)
- Prediction: Factor 2 (Barriers) → BI stronger for students (anxiety, social influence)
- Three-group comparison (requires configural invariance)

**2. AI Usage Frequency (Low vs. High)**:
- Prediction: HB (Habit) effect stronger for high-frequency users
- Prediction: AX (Anxiety) effect weaker for high-frequency users (exposure reduces anxiety)
- Median split or categorical grouping

**3. AI Adoption Status (Adopter vs. Non-adopter)**:
- Prediction: Barriers (Factor 2) more salient for non-adopters
- Prediction: Facilitators (Factor 1) more salient for adopters
- Based on Work_Context stratification variable

**Deliverables**:

**A. Multi-Group SEM**:
- Estimate structural model separately for each group
- Compare path coefficients across groups
- Test equality constraints and chi-square differences

**B. Interaction Terms** (if continuous moderators):
- Mean-center predictors
- Create interaction terms (e.g., TR × Usage_Frequency)
- Test incremental R² from interaction

**C. Moderation Summary Table**:
| Path | Low Group β | High Group β | Δβ | p-value | Interpretation |
|------|-------------|--------------|-----|---------|----------------|
| TR → BI (by Role) | 0.30 (Students) | 0.45 (Professionals) | 0.15 | <.05 | Trust stronger for professionals |
| ...  | ... | ... | ... | ... | ... |

**Acceptance Criteria**:
- [ ] H4 tested for all specified moderators
- [ ] Multi-group models meet fit thresholds in both groups
- [ ] Significant moderation effects documented
- [ ] Non-significant moderators reported (null results valid)
- [ ] Interpretation aligns with proposal predictions (Section 5.3)

---

## Phase 4: Integration and Reporting (Week 31)

### Notebook 7: Comprehensive Results Summary
**File**: `07_Comprehensive_Results.ipynb` (TO BE CREATED)

**Status**: PENDING (final integration phase)

**Objectives**:
- Integrate all analyses into dissertation-ready output
- Generate APA-formatted tables and figures
- Document decision points and sensitivity analyses
- Create diagnostic scoring protocol for 12-item scale

**Deliverables**:

**A. Master Results Table**:
- Hypothesis test outcomes (H1-H4)
- Effect sizes and confidence intervals
- Model fit indices for all models

**B. Publication-Ready Figures**:
1. Path diagram: AIRS structural model with standardized coefficients
2. Bar chart: R² comparison (UTAUT2 vs. AIRS)
3. Forest plot: Indirect effects (mediation)
4. Multi-panel: Moderation interaction plots

**C. Supplementary Materials**:
- Correlation matrices (development and holdout samples)
- Item-level descriptive statistics
- Factor loading tables (EFA and CFA)
- Invariance test results
- Sensitivity analyses (e.g., outlier exclusion, alternate fit indices)

**D. Reproducibility Package**:
```
airs/
├── 00_Create_Split_Samples.ipynb ✅
├── 01_EFA_Construct_Balanced_12_Item.ipynb ✅
├── 02_CFA_Measurement_Model.ipynb ✅
├── 03_Measurement_Invariance.ipynb ⏭️
├── 04_Structural_Model_Hypothesis_Testing.ipynb ⏳
├── 05_Mediation_Analysis.ipynb ⏳
├── 06_Moderation_Analysis.ipynb ⏳
├── 07_Comprehensive_Results.ipynb ⏳
├── preprocess_airs_data.py ✅
├── ANALYSIS_PLAN.md ✅
└── README.md ✅

archive/ (outdated analyses)
├── 01_EFA_Development_Sample_24item.ipynb
├── 01_EFA_Construct_Balanced_12_Item_Model_OLD.ipynb
└── README.md

data/
├── AIRS_clean.csv ✅
├── AIRS_clean_dev.csv ✅
├── AIRS_clean_holdout.csv ✅
├── AIRS_clean_dev_12item.csv ✅
├── airs_12item_selection.json ✅
└── README.md ✅

results/
├── tables/ (APA-formatted .csv or .xlsx) ✅ (CFA tables exported)
└── figures/ (.png, 300 dpi) ✅ (CFA figures generated)

Legend: ✅ Complete | ⏭️ Next Priority | ⏳ Pending
```

**Acceptance Criteria**:
- [ ] All hypotheses addressed with statistical evidence
- [ ] Tables follow APA 7th edition formatting
- [ ] Figures publication-quality (300 dpi, labeled axes, legends)
- [ ] Code reproducible (relative paths, documented dependencies)
- [ ] Narrative interpretation provided for each result

---

## Technical Requirements

### Python Environment
```python
# requirements.txt additions
semopy>=2.3.0          # SEM estimation
pingouin>=0.5.0        # Additional psychometric functions
factor-analyzer>=0.4.0 # EFA/CFA
scikit-learn>=1.0.0    # Train/test split
scipy>=1.7.0           # Statistical tests
```

### Analysis Standards

**1. Missing Data**:
- Listwise deletion for primary analyses (complete cases only)
- Report missingness patterns and sensitivity to imputation (if applicable)

**2. Outliers**:
- Document univariate outliers (z > 3.29, p < .001)
- Assess multivariate outliers (Mahalanobis distance)
- Report analyses with/without outliers

**3. Assumptions**:
- Normality: Skewness/kurtosis within acceptable ranges (±2)
- Linearity: Scatterplots for key relationships
- Multicollinearity: VIF < 5 for predictors

**4. Statistical Power**:
- N ≈ 500 supports 12-factor CFA (N:q ratio ≈ 20:1)
- Adequate power (1-β ≥ 0.80) for medium effects (f² = 0.15) in regression

**5. Significance and Effect Sizes**:
- Report both p-values and effect sizes (Cohen's d, f², R²)
- Use α = 0.05 for hypothesis tests
- Flag marginal results (0.05 < p < 0.10) for discussion

---

## Quality Assurance Checklist

### Before Dissertation Defense

- [ ] All notebooks run without errors from top to bottom
- [ ] Results replicate across multiple runs (reproducibility)
- [ ] Sample sizes reported in every table/figure
- [ ] All proposal hypotheses addressed (H1-H4)
- [ ] Proposal methodology section accurately describes executed analyses
- [ ] Limitations section updated to reflect actual analysis decisions
- [ ] All data quality exclusions documented with audit trail
- [ ] IRB compliance verified (no PII in outputs, consent documented)
- [ ] Committee feedback from proposal defense integrated
- [ ] APA formatting verified (tables, figures, references)

---

## Contingency Plans

### If Measurement Model Fit is Poor (CFI/TLI < 0.90):
1. Examine modification indices (MIs > 10)
2. Consider correlated errors for theoretically justifiable pairs
3. Test alternative factor structures (e.g., collapse similar constructs)
4. Report model re-specification transparently with theoretical justification

### If Discriminant Validity Fails (HTMT > 0.90):
1. Focus on problematic construct pairs (e.g., EX vs. Transparency)
2. Consider second-order factor models (e.g., AI-Specific meta-construct)
3. Use average variance shared (AVS) as alternative criterion
4. Report limitations and interpret constructs cautiously

### If Invariance Tests Fail:
1. Establish partial invariance (free non-invariant parameters)
2. Proceed with multi-group comparisons using partially invariant model
3. Document non-invariant items and interpret group differences cautiously
4. Consider invariance failure as substantive finding (measurement differs by role)

### If AIRS Does Not Outperform UTAUT2 (H3 not supported):
1. Report null result honestly (important theoretical contribution)
2. Examine whether AI-specific constructs show direct effects (H2 may still hold)
3. Test alternative model: AI constructs as mediators rather than direct predictors
4. Discuss boundary conditions (sample characteristics, AI maturity)

---

## Timeline Alignment with Proposal

| Proposal Week | Phase | Deliverable | Status |
|--------------|-------|-------------|--------|
| 23-24 | Measurement (Phase 1) | Data split, 12-item scale development | ✅ Complete |
| 25 | Measurement (Phase 1) | CFA, CR/AVE, discriminant validity | ✅ Complete |
| 26 | Measurement (Phase 1) | Measurement invariance testing | ⏭️ Next |
| 27-28 | Hypothesis Testing (Phase 2) | Structural models, H1-H3 tested | ⏳ Pending |
| 29-30 | Moderation (Phase 3) | Multi-group SEM, H4 tested | ⏳ Pending |
| 31 | Integration (Phase 4) | Results summary, APA tables/figures | ⏳ Pending |
| 32 | Finalization | Manuscript integration, defense prep | ⏳ Pending |

**Current Week**: 24 (November 22, 2025)
**Progress**: Phase 1 complete (EFA + CFA), measurement invariance testing next priority

---

## Success Criteria

This analysis plan succeeds when:

✅ All four hypotheses (H1-H4) tested with appropriate methods
✅ Measurement model validated per proposal specifications (CFI/TLI ≥ 0.90, RMSEA ≤ 0.08)
✅ Reliability (CR ≥ 0.70) and validity (AVE ≥ 0.50, HTMT < 0.85) established
✅ UTAUT2 baseline vs. AIRS extended comparison completed with incremental validity assessment
✅ Mediation (EX → TR → BI) tested with bootstrap CIs
✅ Moderation by role and usage frequency examined with multi-group SEM
✅ Results documented in reproducible notebooks with publication-quality outputs
✅ Committee can verify alignment between proposal methodology and executed analyses

---

## Document Control

**Version**: 1.2
**Date**: November 22, 2025
**Author**: Fabio Costa
**Status**: Active - Phase 1 Complete (EFA + CFA), Measurement Invariance Next
**Next Review**: Upon completion of Measurement Invariance (Week 26)

**Change Log**:
- 2025-11-22 v1.2: Updated with CFA completion and actual results
  - CFA Status: ✅ Complete - ADEQUATE fit (CFI=0.926, TLI=0.907, RMSEA=0.096, SRMR≈0.050)
  - Factor 1 (Mixed Readiness): EXCELLENT reliability (α=0.924, CR=0.925, AVE=0.557)
  - Factor 2 (Risk/Anxiety): PROBLEMATIC reliability (α=0.545, CR=0.688), ER1 loading=0.376
  - Discriminant validity ESTABLISHED (HTMT=0.337, Fornell-Larcker met)
  - Updated sample sizes: N=162 dev, N=163 holdout
  - Corrected factor composition based on actual CFA results
  - Updated item list to match validated model
  - Marked CFA requirements as complete in proposal compliance table
  - Updated timeline: CFA complete in Week 24, invariance testing next
- 2025-11-22 v1.1: Updated with Phase 1 completion status, refined 2-factor model specifications
  - Documented 12-item scale development results (α=0.892)
  - Updated CFA specifications for 2-factor structure validation
  - Clarified factor composition
  - Added file status indicators (✅⏭️⏳) throughout
  - Updated timeline with current progress
- 2025-11-22 v1.0: Initial plan created to align current work with DBA proposal requirements
