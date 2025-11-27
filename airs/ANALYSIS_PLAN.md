# AIRS Analysis Plan
**Dissertation Roadmap: From Theory to Empirical Validation**

---

## Study Overview

**Purpose**: Develop and validate the Artificial Intelligence Readiness Score (AIRS), a theory-grounded extension of UTAUT2 for enterprise AI adoption contexts.

**Theoretical Foundation**: AIRS extends the Unified Theory of Acceptance and Use of Technology 2 (Venkatesh et al., 2012) by integrating four AI-specific constructs—two enablers (Trust in AI, Perceived Explainability) and two inhibitors (Perceived Ethical Risk, AI-Related Anxiety)—that contemporary scholarship identifies as critical for understanding acceptance of probabilistic and partially opaque systems (Shin, 2021; Langer et al., 2023; Floridi et al., 2018).

**Contribution**: Both theoretical (refining acceptance theory for socio-technical AI systems) and applied (a validated diagnostic instrument for organizational readiness assessment).

---

## Three-Model Approach

This study produces **three independent measurement models** to examine whether AI readiness has the same psychometric structure across populations:

| Model | Population | Expected N | EFA Split | CFA Split | Validation Strategy |
|-------|------------|------------|-----------|-----------|---------------------|
| **Full** | All respondents | ~509 | ~254 | ~254 | Standard 50/50 split |
| **Academic** | Students (FT + PT) | ~194 | ~136 | ~58 | 70/30 split + bootstrap CFA |
| **Professional** | Employed + Freelance | ~274 | ~137 | ~137 | Standard 50/50 split |

### Population Definitions
- **Academic**: Full-time students + Part-time students
- **Professional**: Employed (IC, Manager, Executive) + Freelancers
- **Excluded from subsamples**: "Other" and "Not currently employed" (included in Full only)

### Dual Goals

**Goal 1: Parsimony** — Achieve the minimum viable scale (fewest items and factors) that maintains acceptable psychometric properties and predictive validity.

**Goal 2: Diagnostic Coverage** — Retain representation across all 13 theoretical constructs where the data supports it, enabling comprehensive organizational readiness profiling.

**Tension Resolution**: Start with full item pool. Let EFA determine which constructs emerge empirically. Prioritize constructs with strong loadings. Accept that subsamples may yield sparser structures due to sample size constraints.

### Analytical Philosophy
1. **Theory-guided, data-driven**: 13 constructs proposed; EFA reveals which emerge empirically
2. **Parsimony with coverage**: Minimum items per factor (ideally 2-3), but preserve construct breadth
3. **Population-specific structures**: Full sample likely supports all constructs; subsamples may require consolidation
4. **Transparent reporting**: Document both retained and dropped constructs with rationale

---

## Quick Reference

| Parameter | Value |
|-----------|-------|
| **Total Sample** | N ≈ 509 (data collection ongoing) |
| **Academic Subsample** | N ≈ 194 (FT + PT students) |
| **Professional Subsample** | N ≈ 274 (Employed + Freelance) |
| **Item Pool** | 49 items across 13 constructs |
| **Target Scale** | Minimum viable (24-36 items full, 18-24 subsamples) |
| **Design** | Cross-sectional survey with split-sample validation |
| **Approach** | Theory-guided EFA → CFA; parsimony + diagnostic coverage |

### Analysis Roadmap

| Phase | Notebook | Description | Status |
|-------|----------|-------------|--------|
| **0. Preparation** | 00 | Sample Splits (Full, Academic, Professional) | ✅ Complete |
| **1. EFA Full** | 01-Full | Data-driven EFA on full sample | ✅ Complete |
| **1. EFA Academic** | 01-Academic | Data-driven EFA on student sample | ✅ Complete |
| **1. EFA Professional** | 01-Professional | Data-driven EFA on professional sample | ✅ Complete |
| **2. CFA Validation** | 02 | Confirm structures on holdout samples | ✅ Complete |
| **2a. Model Optimization** | 02a | Refine model based on CFA diagnostics | ⏭️ Pending |
| **3. Measurement Invariance** | 03 | Cross-population structure comparison | ⏭️ Pending |
| **4. Structural** | 04 | Hypothesis testing (H1-H3) per model | ⏭️ Pending |
| **5. Mediation** | 05 | H5a-c mediation analysis | ⏭️ Pending |
| **6. Moderation** | 06 | H4a-e contextual moderation | ⏭️ Pending |
| **7. Exploratory** | 07-08 | Tool usage + qualitative themes | ⏭️ Pending |
| **9. Integration** | -- | Chapter 4 results synthesis | ⏭️ Pending |

### Phase 1 Results Summary (EFA Complete)

| Metric | Full (N=254) | Academic (N=135) | Professional (N=145) |
|--------|--------------|------------------|----------------------|
| **KMO** | 0.935 (Marvelous) | 0.890 (Meritorious) | 0.928 (Marvelous) |
| **Factors** | 2 | 2 | 2 |
| **Variance** | 51.0% | 45.0% | 59.6% |
| **Good Items** | 18/24 (75%) | 14/24 (58%) | 23/24 (96%) |
| **Problem Items** | 6 | 10 | 1 |
| **Factor Correlation** | r = -0.065 | r = 0.179 | r = -0.009 |

**Key Finding**: All three populations converge on a **2-factor solution** with near-orthogonal factors (r < .32), supporting measurement invariance potential.

**Outputs Generated** (per population):
- `data/efa_solution.json` - Factor solution for downstream CFA
- `tables/01_pattern_matrix.csv` - Factor loadings
- `tables/01_item_quality.csv` - Item quality assessment
- `tables/01_factor_reliability.csv` - Cronbach's alpha per factor
- `tables/01_eigenvalues.csv` - Eigenvalue analysis
- `plots/01_scree_plot_parallel_analysis.png` - Factor extraction justification
- `plots/01_pattern_matrix_heatmap.png` - Loading structure visualization
- `plots/01_communality_chart.png` - Item quality visualization
- `plots/01_factor_correlation.png` - Factor relationship visualization

### Phase 2 Results Summary (CFA Validation Complete)

| Metric | Full (N=255) | Academic (N=59) | Professional (N=146) |
|--------|--------------|-----------------|----------------------|
| **CFI** | 0.824 ❌ | 0.697 ❌ | 0.866 ❌ |
| **TLI** | 0.806 ❌ | 0.667 ❌ | 0.853 ❌ |
| **RMSEA** | 0.111 ❌ | 0.120 ❌ | 0.102 ❌ |
| **χ²/df** | 3.14 | 1.84 | 2.51 |
| **Facilitators CR** | 0.957 ✓ | 0.897 ✓ | 0.966 ✓ |
| **Inhibitors CR** | 0.625 ⚠️ | 0.001 ❌ | 0.662 ⚠️ |
| **Facilitators AVE** | 0.539 ✓ | 0.384 ⚠️ | 0.596 ✓ |
| **Inhibitors AVE** | 0.371 ❌ | 0.009 ❌ | 0.385 ❌ |

**Key Findings**:
1. **Model fit is poor** across all populations (CFI < 0.90, RMSEA > 0.08)
2. **Facilitators factor is reliable** across all samples (CR > 0.89)
3. **Inhibitors factor is problematic** in all samples, especially Academic
4. **Consistent problem items**: VO2, ER1, ER2, AX2, SI2 show weak loadings

**Outputs Generated** (per population):
- `data/cfa_solution.json` - CFA results for downstream analysis
- `tables/02_cfa_loadings.csv` - Standardized factor loadings
- `tables/02_cfa_reliability.csv` - CR, AVE, Cronbach's alpha
- `tables/02_cfa_fit_statistics.csv` - Model fit indices
- `plots/02_cfa_loadings.png` - Loading visualization
- `plots/02_correlation_matrix.png` - Item correlation heatmap

### Phase 2a: Model Optimization (Pending)

**Rationale**: The 24-item 2-factor model shows poor fit across all populations. Before invariance testing, the model requires refinement.

**Planned Activities**:
1. **Modification indices analysis** - Identify specification errors (correlated residuals, cross-loadings)
2. **Item reduction** - Remove items with consistently low loadings across populations:
   - Priority drops: VO2 (λ < 0.20), AX2 (λ < 0.25), SI2 (λ < 0.10 in Academic)
   - Candidates: ER1, ER2, EX1, EX2 (low loadings in some samples)
3. **Inhibitors factor reconceptualization** - Options:
   - Retain only ER2 as single-item indicator
   - Merge strong Inhibitors items into Facilitators (reversed)
   - Drop factor entirely and model AI-specific concerns differently
4. **Reduced model CFA** - Test 16-20 item model with improved fit
5. **Cross-validation** - Confirm reduced model on all three holdout samples

**Decision Criteria for Item Retention**:
- Standardized loading ≥ 0.50 in at least 2 of 3 populations
- No severe cross-loadings (MI < 10)
- Theoretical importance for diagnostic profiling

**Target Metrics Post-Optimization**:
- CFI ≥ 0.90 (acceptable), ideally ≥ 0.95 (good)
- RMSEA ≤ 0.08 (acceptable), ideally ≤ 0.06 (good)
- All factors: CR ≥ 0.70, AVE ≥ 0.50

---

## Dual Purpose

**Purpose 1: Parsimonious Predictive Model**
- Achieve minimum viable scale with strongest predictors
- Incremental validity testing of AI-specific constructs beyond UTAUT2 baseline
- Empirically validated factor structure per population

**Purpose 2: Diagnostic Tool**
- Comprehensive coverage of AI readiness dimensions (all 13 constructs if data supports)
- Population-specific profiling (academic vs professional contexts)
- Actionable insights: link construct scores to targeted interventions

**Balance**: Full sample prioritizes breadth (diagnostic). Subsamples accept sparser structures if needed for parsimony.

---

## Research Questions

| RQ | Question | Notebook |
|----|----------|----------|
| **RQ1** | What is the psychometric structure of AI readiness among knowledge workers? | 01, 02 |
| **RQ2** | Do UTAUT2 constructs predict behavioral intention to adopt AI? | 04 |
| **RQ3** | Do AI-specific constructs add explanatory power beyond UTAUT2? | 04 |
| **RQ4** | What mediating mechanisms explain AI-specific construct effects? | 05 |
| **RQ5** | Are predictor-intention relationships moderated by context? | 06 |
| **RQ6** | Do usage patterns differ across AI tool types? | 07 |
| **RQ10** | What themes emerge from open-text feedback? | 08 |

---

## Theoretical Construct Framework

### Full Item Pool: 49 Items Across 13 Constructs

**UTAUT2 Core Constructs** (8 constructs, 32 items) — Venkatesh et al. (2003, 2012)

| Construct | Code | Items | Role | Expected β |
|-----------|------|-------|------|------------|
| Performance Expectancy | PE | 4 (Q1-4) | Enabler | (+) → BI |
| Effort Expectancy | EE | 4 (Q5-8) | Enabler | (+) → BI |
| Social Influence | SI | 4 (Q9-12) | Enabler | (+) → BI |
| Facilitating Conditions | FC | 4 (Q13-16) | Enabler | (+) → BI |
| Hedonic Motivation | HM | 4 (Q17-20) | Enabler | (+) → BI |
| Price Value | PV | 4 (Q21-24) | Enabler | (+) → BI |
| Habit | HB | 4 (Q25-28) | Enabler | (+) → BI |
| Voluntariness of Use | VO | 4 (Q1-4 S1b) | Moderator/Predictor | (+) → BI |

**AI-Specific Constructs** (4 constructs, 16 items) — Shin (2021); Langer et al. (2023); Floridi et al. (2018)

| Construct | Code | Items | Role | Expected β | Theoretical Basis |
|-----------|------|-------|------|------------|-------------------|
| Trust in AI | TR | 4 (Q29-32) | Enabler | (+) → BI | Gateway for consequential use; mediates EX→BI |
| Perceived Explainability | EX | 4 (Q33-36) | Enabler | (+) → TR → BI | Clarity of AI reasoning; builds trust |
| Perceived Ethical Risk | ER | 4 (Q37-40) | Inhibitor | (−) → BI | Job displacement, privacy, bias concerns |
| AI-Related Anxiety | AX | 4 (Q41-44) | Inhibitor | (−) → BI | Affective unease about AI pace/autonomy |

**Outcome Construct** (1 construct, 5 items)

| Construct | Code | Items | Description |
|-----------|------|-------|-------------|
| Behavioral Intention | BI | 5 (Q45-49) | Readiness to adopt AI at work/study |

### Construct Coverage Expectations by Population

| Population | N | Expected Constructs | Rationale |
|------------|---|---------------------|-----------|
| **Full** | ~509 | All 13 | Sufficient N for full theoretical model |
| **Academic** | ~194 | 8-10 | Some constructs may merge (e.g., PV+HM, ER+AX) |
| **Professional** | ~274 | 10-12 | May lose weaker constructs (e.g., VO) |

### Minimum Viable Scale Target

| Criterion | Target | Rationale |
|-----------|--------|-----------|
| Items per construct | 2-3 | Minimum for identification + parsimony |
| Total items (full) | 24-36 | Balance coverage with respondent burden |
| Total items (subsample) | 18-24 | Sparser structures acceptable |
| Constructs retained | ≥10 (full), ≥8 (subsample) | Diagnostic utility requires breadth |

---

## Hypotheses

### H1: UTAUT2 Baseline
UTAUT2 constructs (PE, EE, SI, FC, HM, PV, HB, VO) will significantly predict behavioral intention to adopt AI (Venkatesh et al., 2012).

- **Test**: Structural model with 8 UTAUT2 constructs → BI
- **Notebook**: 04

---

### H2: AI-Specific Constructs
AI-specific constructs (TR, EX, ER, AX) will significantly predict behavioral intention beyond UTAUT2 (Langer et al., 2023; Shin, 2021).

- **Test**: Incremental effect of 4 AI constructs in full AIRS model
- **Notebook**: 04

---

### H3: Incremental Validity
The AIRS extended model will explain significantly more variance than UTAUT2 baseline (Dwivedi et al., 2021).

- **Test**: F-test for nested models comparing R² values
- **Threshold**: ΔR² ≥ 0.10 (medium incremental validity)
- **Notebook**: 04

---

### H4: Contextual Moderation
Predictor-intention relationships will be moderated by contextual factors (Dwivedi et al., 2021):

| Hypothesis | Moderator | Expected Pattern |
|------------|-----------|------------------|
| **H4a** | Role (Student vs Professional) | Trust/EX stronger for professionals |
| **H4b** | Role | SI stronger for students |
| **H4c** | Usage Frequency | Habit stronger for high-frequency users |
| **H4d** | Usage Frequency | Anxiety weaker for high-frequency users |
| **H4e** | Adoption Status | Facilitators salient for adopters; Barriers for non-adopters |

- **Test**: Separate-group structural models with bootstrap CIs (5000 iterations)
- **Notebook**: 06

---

### H5: Mediation Mechanisms
AI-specific construct effects will be mediated by Trust and Anxiety:

| Hypothesis | Path | Mechanism | Theoretical Basis |
|------------|------|-----------|-------------------|
| **H5a** | EX → TR → BI | Explainability builds trust | Shin (2021); Langer et al. (2023) |
| **H5b** | ER → TR → BI | Ethical concerns erode trust | Floridi et al. (2018) |
| **H5c** | ER → AX → BI | Ethical concerns amplify anxiety | Kim et al. (2025) |

- **Test**: Bootstrap mediation (Preacher & Hayes, 2008)
- **Parameters**: 5000 iterations, percentile-based 95% CI
- **Notebook**: 05

---

## Phase Implementation

### Phase 0: Sample Preparation (Notebook 00)
**Objective**: Create development/holdout splits for all three populations

**Approach**:
- Load full dataset, create population flags
- **Full sample**: 50/50 stratified split → ~254 dev / ~254 holdout
- **Academic**: 70/30 stratified split → ~136 dev / ~58 holdout (bootstrap CFA due to small N)
- **Professional**: 50/50 stratified split → ~137 dev / ~137 holdout
- Stratification variables: Role, AI usage frequency, demographics

**Deliverables**:
- `data/AIRS_clean.csv` (master)
- `airs_full/data/` (dev + holdout)
- `airs_academic/data/` (dev + holdout)
- `airs_professional/data/` (dev + holdout)
- **APA Method Summary**: Dynamic f-string generated conclusions using computed variables

---

### Phase 1: Theory-Guided EFA (Notebooks 01-Full, 01-Academic, 01-Professional)
**Objective**: Identify factor structure empirically while preserving theoretical construct coverage

**Approach** (per population):
1. **Factor count determination**:
   - Parallel analysis (primary criterion)
   - Scree plot inspection
   - Eigenvalue > 1 (secondary)
   - Theoretical expectation: 12-13 factors (full), 8-10 factors (subsamples)
2. **EFA specification**:
   - Estimator: MINRES or ML (depending on normality)
   - Rotation: Oblique (Promax or Oblimin) — factors expected to correlate
   - All 49 candidate items included initially
3. **Item retention criteria**:
   - Primary loading ≥ 0.50
   - Cross-loading < 0.32 (or difference > 0.20)
   - Communality ≥ 0.40
   - No Heywood cases
4. **Construct coverage check**:
   - After item removal, verify each theoretical construct has ≥2 items
   - If construct lost entirely, document and justify
   - Prioritize parsimony but preserve diagnostic breadth
5. **Iterative refinement**: Remove problematic items, re-run until clean structure

**Deliverables per population**:
- Factor structure documentation with construct mapping
- Item-factor alignment to theoretical constructs
- Reliability statistics (α, ω) per retained factor
- Pattern/structure matrices
- Dropped items with rationale
- **APA Method Summary**: Dynamic f-string generated conclusions using computed variables

---

### Phase 2: CFA Validation (Notebook 02)
**Objective**: Confirm factor structures on independent holdout samples

**Approach**:
- **Full & Professional**: Standard CFA on holdout sample
- **Academic**: Bootstrap CFA (1000 iterations) due to smaller holdout N

**Fit Criteria**:
- CFI/TLI ≥ 0.90 (acceptable), ≥ 0.95 (good)
- RMSEA ≤ 0.08 (acceptable), ≤ 0.06 (good)
- SRMR ≤ 0.08

**If poor fit**: Modification indices → theoretically justified adjustments only

---

### Phase 3: Cross-Population Comparison (Notebook 03)
**Objective**: Document structural similarities and differences

**Approach**:
- Compare factor counts across populations
- Identify common vs population-specific factors
- Assess item overlap and divergence
- Test measurement invariance where structures align
- Document implications for theory and practice

---

### Phase 4: Structural Models (Notebook 04)
**Objective**: Test H1, H2, H3 hypotheses per population

**Approach**:
1. UTAUT2 baseline model (H1) - per population
2. Full AIRS model with AI-specific constructs (H2) - per population
3. Model comparison for incremental validity (H3)
4. Compare effect sizes across populations

---

### Phase 5: Mediation Analysis (Notebook 05)
**Objective**: Test H5a-c mediation hypotheses

**Approach**: Bootstrap mediation per Preacher & Hayes (2004, 2008)
- 5000 bootstrap iterations
- Percentile-based 95% confidence intervals
- Test on full sample (primary) and subsamples (exploratory)

---

### Phase 6: Moderation Analysis (Notebook 06)
**Objective**: Test H4a-e contextual moderation hypotheses

**Approach**:
- Multi-group comparison across populations
- Usage frequency moderation within populations
- Document population-specific patterns

---

### Phase 7: Exploratory Analyses (Notebooks 07-08)
**Objective**: Tool usage patterns (RQ6) and qualitative themes (RQ10)

**Approach**:
- Descriptive/inferential analyses per population
- Mixed-methods triangulation

---

### Phase 9: Integration
**Objective**: Synthesize findings into Chapter 4 results

**Deliverables**:
- Three validated measurement models (or documented convergence)
- Population-specific findings and implications
- Publication-ready tables, APA-formatted results

---

## Technical Requirements

| Parameter | Specification |
|-----------|---------------|
| **Software** | Python 3.x (scipy, numpy, pandas, statsmodels, sklearn) |
| **Random Seed** | 67 (all analyses) |
| **Bootstrap** | 5000 iterations |
| **Confidence Level** | 95% |
| **APA Conclusions** | Each notebook ends with dynamic f-string Method Summary using computed variables |

---

## Output Structure

```
results/
├── tables/          # Summary statistics, model comparisons
├── plots/           # Path diagrams, coefficient comparisons
└── [model outputs]  # Fit indices, parameter estimates
```

---

## Key References

**Foundational Frameworks**
- Venkatesh, V., Thong, J. Y. L., & Xu, X. (2012). Consumer acceptance and use of information technology: Extending the unified theory of acceptance and use of technology. *MIS Quarterly, 36*(1), 157-178.
- Venkatesh, V., Morris, M. G., Davis, G. B., & Davis, F. D. (2003). User acceptance of information technology: Toward a unified view. *MIS Quarterly, 27*(3), 425-478.

**AI-Specific Extensions**
- Shin, D. (2021). The effects of explainability and causability on perception, trust, and acceptance. *Technological Forecasting and Social Change, 166*, 120678.
- Langer, M., et al. (2023). Trust in artificial intelligence: A review and research agenda. *Computers in Human Behavior, 139*, 107510.
- Floridi, L., et al. (2018). AI4People—An ethical framework for a good AI society. *Minds and Machines, 28*(4), 689-707.
- Dwivedi, Y. K., et al. (2021). Artificial intelligence: Multidisciplinary perspectives on emerging challenges. *International Journal of Information Management, 57*, 101994.

**Methodology**
- Preacher, K. J., & Hayes, A. F. (2008). Asymptotic and resampling strategies for assessing and comparing indirect effects. *Behavior Research Methods, 40*(3), 879-891.
- Hinkin, T. R. (1998). A brief tutorial on the development of measures for use in survey questionnaires. *Organizational Research Methods, 1*(1), 104-121.
- DeVellis, R. F. (2017). *Scale development: Theory and applications* (4th ed.). Sage.
