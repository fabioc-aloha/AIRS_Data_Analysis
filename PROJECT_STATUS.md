# AIRS Project Status Report

**Last Updated**: November 23, 2025
**Project**: AI Readiness Scale (AIRS) Psychometric Validation
**Researcher**: Fabio Correa
**Institution**: Touro University Worldwide - DBA Program
**Timeline**: Week 27 of 32

---

## 📊 Overall Progress: 71% Complete

```
Phase 1: Scale Development        ████████████████████ 100% ✅
Phase 2: CFA Validation          ████████████████████ 100% ✅
Phase 3: Invariance Testing      ████████████████████ 100% ✅
Phase 4: Structural Models       ████████████████████ 100% ✅
Phase 5: Mediation Analysis      ████████████████████ 100% ✅
Phase 6: Multi-Group Analysis    ░░░░░░░░░░░░░░░░░░░░   0% ⏭️
Phase 7: Integration & Writing   ░░░░░░░░░░░░░░░░░░░░   0% ⏳
```

---

## ✅ Completed Phases (Phases 1-5)

### Phase 1: Scale Development (Complete - November 2025)
**Notebook**: `airs/01_EFA_Construct_Balanced_12_Item.ipynb`

**Achievements**:
- ✅ Created stratified 50/50 split (181 dev, 181 holdout)
- ✅ Developed 12-item construct-balanced scale (1 item per construct)
- ✅ Determined 2-factor structure via parallel analysis
- ✅ Achieved excellent reliability (12-item α=0.845)
- ✅ Validated factorability (KMO=0.919, Bartlett's p<.001)
- ✅ Manual refinement for F2 reliability (ER1→ER2, AX2→AX1)

**Key Decisions**:
- Selected best-loading item per construct (not correlation-based)
- Accepted 2-factor empirical structure (not 12-factor theoretical)
- Prioritized theoretical coverage over pure prediction optimization

**Final 12-Item Scale**:
- **F1 (AI Readiness - 10 items)**: PE2, EE1, SI1, FC1, HM2, PV2, HB2, VO1, TR2, EX1
- **F2 (Risk/Anxiety - 2 items)**: ER2, AX1

---

### Phase 2: CFA Validation (Complete - November 2025)
**Notebook**: `airs/02_CFA_Measurement_Model.ipynb`

**Achievements**:
- ✅ Validated 2-factor structure on independent holdout sample (N=181)
- ✅ Achieved good model fit (CFI=0.952, TLI=0.941, RMSEA=0.080)
- ✅ Confirmed F1 excellent reliability (α=0.924, CR=0.923, AVE=0.554)
- ✅ Confirmed F2 adequate reliability (α=0.691, CR=0.765, AVE=0.640)
- ✅ Established discriminant validity (HTMT=0.527, Fornell-Larcker met)
- ✅ Generated publication-quality figures (3 comprehensive visualizations)

**Psychometric Summary**:
| Factor | Items | α | CR | AVE | Quality |
|--------|-------|---|----|----|---------|
| F1: AI Readiness | 10 | 0.924 | 0.923 | 0.554 | Excellent |
| F2: Risk/Anxiety | 2 | 0.691 | 0.765 | 0.640 | Adequate |

**Model Fit**:
- χ²(52) = 122.55, p < .001
- CFI = 0.952 (> 0.90 ✓)
- TLI = 0.941 (> 0.90 ✓)
- RMSEA = 0.080 (≤ 0.08 ✓)
- χ²/df = 2.36 (< 3.0 ✓)

---

### Phase 3: Measurement Invariance Testing (Complete - November 23, 2025)
**Notebook**: `airs/03_Measurement_Invariance.ipynb`

**Achievements**:
- ✅ Tested invariance across 3 grouping variables (Role, Usage, Adoption)
- ✅ Confirmed configural invariance across all groups (same factor structure)
- ✅ Documented metric non-invariance (factor loadings differ)
- ✅ Documented scalar non-invariance (item intercepts differ)
- ✅ Scholarly validation of methodology against 5+ key references
- ✅ Critical analysis of item selection decision (justified keeping current items)
- ✅ Comprehensive interpretation with theoretical explanations

**Invariance Results**:

| Grouping | Configural CFI | Metric ΔCFI | Scalar ΔCFI | Status |
|----------|----------------|-------------|-------------|--------|
| Role (Student/Professional) | 0.945 | 0.072 | 0.059 | Config ✓, Metric ✗, Scalar ✗ |
| Usage (Low/High) | 0.922 | 0.062 | 0.095 | Config ✓, Metric ✗, Scalar ✗ |
| Adoption (Non/Adopter) | 0.946 | 0.052 | 0.093 | Config ✓, Metric ✗, Scalar ✗ |

**Problematic Items** (loading differences exceed 0.20 threshold):
- **EX1**: Students 0.349 vs Professionals 0.830 (Δ=0.481)
- **VO1**: Low users 1.116 vs High users 0.642 (Δ=0.474)
- **SI1**: Students 0.705 vs Professionals 0.983 (Δ=0.278)
- **FC1**: Students 0.440 vs Professionals 0.825 (Δ=0.385)

**Key Finding**: Non-invariance reflects **theoretically meaningful contextual differences**, not measurement error. For example:
- Explainability matters more to professionals (accountability expectations)
- Autonomy matters more to novices (discretion sensitivity)
- Infrastructure access more relevant to workplace professionals

**Implication for H4**: Use separate-group structural models (NOT constrained multi-group SEM) for moderation analysis.

---

### Phase 4: Structural Models & Hypothesis Testing (Complete - November 2025)
**Notebook**: `airs/04_Structural_Model_Hypothesis_Testing.ipynb`
**Timeline**: Weeks 25-26

**Achievements**:
- ✅ H1 STRONGLY SUPPORTED: UTAUT2 R²=0.8046 (80.46%), 6/8 constructs significant
- ✅ H2 PARTIALLY SUPPORTED: 3/4 AI constructs significant (TR*, EX*, AX**; ER ns)
- ✅ H3 PARTIALLY SUPPORTED: ΔR²=1.46%, F(4,349)=7.025, p<.001*** (below 10% threshold but statistically significant)

**Key Results**:
- **Model 1 (UTAUT2)**: R²=0.8046, Adj R²=0.8001, 6/8 significant (PE***, SI***, HM***, PV***, HB**, VO*)
- **Model 2 (AIRS)**: R²=0.8191, Adj R²=0.8129, 3/4 AI constructs significant (TR*, EX*, AX**)
- **Incremental Validity**: ΔR²=1.46%, p<.001***, Cohen's f²=0.0805 (small effect)
- **Critical Discovery**: AI Anxiety dominates with sr²=0.525% (36% of ΔR²)
- **Sample**: Full N=362

**Deliverables**:
- ✅ 3 statistical tables (model comparison, coefficients)
- ✅ 5 publication-quality visualizations (300 dpi)
- ✅ Comprehensive fact-check report (66KB, 60+ verification points)
- ✅ All hypothesis decisions documented

---

### Phase 5: Mediation Analysis (Complete - November 2025)
**Notebook**: `airs/05_Mediation_Analysis.ipynb`
**Timeline**: Week 27

**Achievements**:
- ✅ H5a SUPPORTED: EX → TR → BI, ab=0.287*** [0.214, 0.361], 55% mediated (partial)
- ✅ H5b SUPPORTED: ER → TR → BI, ab=-0.220*** [-0.312, -0.120], 64% mediated (partial)
- ✅ H5c STRONGLY SUPPORTED: ER → AX → BI, ab=-0.333*** [-0.414, -0.255], 96% mediated (near-complete)
- ✅ **100% hypothesis support rate** across all three mediation tests

**Key Discovery - Dual-Pathway Suppression**:
- Ethical Risk operates entirely through indirect pathways (combined ab=-0.553***)
- Anxiety pathway 1.51× stronger than trust pathway (affective dominance)
- Explains Phase 4 ER non-significance (β=0.001, p=.917) via suppression mechanism
- Strategic implication: Address anxiety FIRST, then trust—emotional > cognitive

**Method**: Bootstrap mediation with 5,000 iterations, percentile-based 95% CIs

**Deliverables**:
- ✅ 7 publication-quality visualizations (3 path diagrams, 4 analytical plots at 300 dpi)
- ✅ 2 statistical tables (summary + detailed results)
- ✅ Comprehensive interpretation with theoretical implications
- ✅ Intervention priority framework validated

---

## ⏳ Pending Phases (6-7)

### Phase 6: Multi-Group Analysis (H4)
**Target**: Week 28-29
**Notebook**: `airs/06_Multi_Group_Analysis.ipynb` (to be created)

---

### Phase 6: Multi-Group Analysis (H4)
**Target**: Week 29-30
**Notebook**: `airs/06_Multi_Group_Analysis.ipynb` (to be created)

**Approach** (Modified based on Phase 3 findings):
- **Original Plan**: Constrained multi-group SEM with equality constraints
- **Updated Plan**: Separate-group structural models (exploratory moderation)
- **Rationale**: Metric invariance not supported; cannot constrain loadings equal

**Moderators**:
- H4a-b: Role (Student vs. Professional)
- H4c-d: Usage Frequency (Low vs. High)
- H4e: Adoption Status (Non-Adopter vs. Adopter)

**Analysis**:
1. Fit structural model independently for each group
2. Compare β coefficients descriptively (not inferentially)
3. Report group-specific parameter estimates
4. Frame as exploratory (no formal equality tests)

---

### Phase 7: Integration & Chapter 4 Draft
**Target**: Week 30-32
**Deliverable**: Dissertation Chapter 4 (Results)

**Objectives**:
- Synthesize findings from Phases 1-6
- Create comprehensive results narrative
- Generate final publication-quality figures
- Document decision points and rationale
- Prepare implications for Chapter 5 (Discussion)

---

## 📁 Repository Organization

### Analysis Notebooks (`airs/`)
- ✅ `00_Create_Split_Samples.ipynb` - Stratified split creation
- ✅ `01_EFA_Construct_Balanced_12_Item.ipynb` - Scale development
- ✅ `02_CFA_Measurement_Model.ipynb` - CFA validation
- ✅ `03_Measurement_Invariance.ipynb` - Invariance testing
- ✅ `04_Structural_Model_Hypothesis_Testing.ipynb` - H1-H3 testing
- ✅ `05_Mediation_Analysis.ipynb` - H5 mediation (dual-pathway suppression)
- ⏭️ `06_Multi_Group_Analysis.ipynb` - H4 moderation (separate-group models)

### Documentation (`docs/`)
- `AIRS DBA Project Proposal v4.md` - Complete proposal with all hypotheses
- `DATA_DICTIONARY.md` - Variable definitions and measurement details
- `FACT_CHECK_REPORT.md` - Scholarly validation of methodology
- `AIRS_empirical_model_phase2_mermaid.md` - Visual model documentation

### Data Files (`data/`)
- `AIRS_clean.csv` - Full dataset (N=362)
- `AIRS_clean_dev.csv` - Development sample (N=181)
- `AIRS_clean_dev_12item.csv` - 12-item development subset
- `AIRS_clean_holdout.csv` - Holdout sample (N=181)
- `airs_12item_selection.json` - Item selection documentation

### Results (`results/`)
- `tables/` - 32 CSV files with statistical outputs (added Phase 4-5 results)
- `plots/` - 35 publication-quality visualizations (added 5 Phase 4, 7 Phase 5 at 300 dpi)
- Key outputs: CFA fit indices, factor loadings, reliability metrics, invariance summary, structural coefficients, mediation pathways

---

## 🎯 Research Questions & Hypothesis Status

| RQ | Hypothesis | Status | Finding |
|----|------------|--------|---------|
| RQ1 | Psychometric structure | ✅ Complete | 2-factor structure validated (F1: 10 items, F2: 2 items) |
| RQ2 | H1: UTAUT2 → BI | ⏭️ Phase 4 | Structural modeling pending |
| RQ3 | H2: AI constructs → BI | ⏭️ Phase 4 | Incremental validity test pending |
| RQ3 | H3: ΔR² ≥ 0.10 | ⏭️ Phase 4 | Model comparison pending |
| RQ4 | H5a: EX → TR → BI | ⏳ Phase 5 | Mediation analysis pending |
| RQ4 | H5b: ER → TR → BI | ⏳ Phase 5 | Mediation analysis pending |
| RQ4 | H5c: ER → AX → BI | ⏳ Phase 5 | Mediation analysis pending |
| RQ5 | H4: Moderation effects | ✅ Phase 3 | Invariance prerequisite complete; moderation in Phase 6 |

**Overall**: 3/9 analyses complete (33%)

---

## 📊 Sample Characteristics

**Total Sample**: N = 362 valid responses

### Development Sample (N=181)
- Used for EFA, item selection, initial model development

### Holdout Sample (N=181)
- Used for CFA, independent validation

### Full Sample (N=362)
- Used for invariance testing (Phase 3)
- Will be used for structural modeling (Phase 4-6)

### Demographics (Full Sample)
- **Role**: 157 Students (43%), 205 Professionals (57%)
- **Usage**: 159 Low usage (44%), 203 High usage (56%)
- **Adoption**: 171 Non-adopters (47%), 191 Adopters (53%)

---

## 🔬 Methodological Strengths

1. **Split-Sample Validation**: Independent development and holdout samples prevent overfitting
2. **Construct-Balanced Design**: Ensures theoretical coverage (all 12 constructs represented)
3. **Data-Driven Factor Determination**: Parallel analysis provides empirical support for 2 factors
4. **Scholarly Validation**: Methodology fact-checked against 10+ key psychometric references
5. **Transparent Reporting**: All decisions documented with rationale (including limitations)
6. **Invariance Foundation**: Thorough testing before multi-group comparisons
7. **Reproducibility**: Complete code, data, and documentation in version control

---

## ⚠️ Known Limitations (Documented)

1. **F2 Reliability**: Only 2 items (α=0.691), below ideal 3-item minimum
   - *Mitigation*: Adequate CR (0.765) and AVE (0.640) support validity
   - *Implication*: F2 results should be interpreted with caution

2. **Metric Non-Invariance**: Factor loadings differ across groups
   - *Mitigation*: Configural invariance supported (same structure)
   - *Implication*: Cannot use formal multi-group SEM with constraints; use separate-group models

3. **Sample Size**: N=362 of target N=500
   - *Mitigation*: Exceeds minimum SEM requirements (N>200)
   - *Implication*: Results are preliminary pending final sample

4. **Cross-Sectional Design**: Cannot infer causality
   - *Mitigation*: Hypotheses framed as predictive relationships
   - *Implication*: Longitudinal validation needed for causal claims

---

## 📅 Timeline to Completion

**Week 24** (Current): Phase 3 complete, documentation updated
**Week 25-26**: Phase 4 structural modeling (H1-H3)
**Week 27-28**: Phase 5 mediation analysis (H5)
**Week 29-30**: Phase 6 multi-group analysis (H4)
**Week 31-32**: Integration, dissertation writing, final deliverables

**Target Completion**: Week 32 (8 weeks remaining)

---

## 📧 Contact & Resources

**Researcher**: Fabio Correa
**Email**: fcorrea@student.touro.edu
**Institution**: Touro University Worldwide
**Program**: Doctor of Business Administration (DBA)
**Committee Chair**: Dr. Karina Kasztelnik
**Research Mentor**: Dr. Venkatesh

**Repository**: [github.com/fabioc-aloha/AIRS_Data_Analysis](https://github.com/fabioc-aloha/AIRS_Data_Analysis)
**Documentation**: See `README.md` and `airs/ANALYSIS_PLAN.md` for complete details

---

**Document Version**: 1.0
**Last Updated**: November 23, 2025
**Next Update**: After Phase 4 completion (estimated Week 26)
