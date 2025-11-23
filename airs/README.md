# AIRS Analysis Notebooks
**The Journey from Theory to Validated Instrument**

This folder contains the sequential analysis notebooks documenting our analytical journey from theoretical framework to validated measurement instrument.

## The Story in Notebooks

### Phase 1: Discovery (Weeks 23-24) ✅
**00_Create_Split_Samples.ipynb** - *Proving Methodological Rigor*
- Stratified 50/50 split (Development N=181, Holdout N=181)
- Statistical validation of balance (χ² tests, p>0.05)
- **Key Insight**: Split-sample design prevents overfitting

**01_EFA_Construct_Balanced_12_Item.ipynb** - *The Factor Structure Surprise*
- Expected: 12 factors (theory-driven)
- Found: 2 factors (data-driven via parallel analysis)
- **Key Insight**: AI readiness is two-dimensional ("Can I?" + "What risks?")
- Reliability: 12-item α=0.845, F1 α=0.924, F2 α=0.691

### Phase 2: Validation (Week 24) ✅
**02_CFA_Measurement_Model.ipynb** - *Independent Confirmation*
- Independent holdout sample validation (N=181)
- Model fit: CFI=0.952, TLI=0.941, RMSEA=0.080
- **Key Insight**: 2-factor structure replicates in new sample
- Psychometric quality: F1 excellent, F2 adequate

### Phase 3: Context Discovery (Week 24) ✅
**03_Measurement_Invariance.ipynb** - *Why Context Matters*
- Multi-group CFA across Role, Usage, Adoption status
- Configural ✓ (constructs exist), Metric ✗ (loadings differ)
- **Key Insight**: Constructs function differently by context (EX1 Δλ=0.481, VO1 Δλ=0.474)
- **Implication**: Use separate-group models for H4 moderation testing

### Phase 4: Hypothesis Testing (Weeks 25-26) ✅
**04_Structural_Model_Hypothesis_Testing.ipynb** - *The Anxiety Discovery*
- H1: UTAUT2 R²=0.8046 (80.46%), 6/8 constructs significant — STRONGLY SUPPORTED
- H2: 3/4 AI constructs significant (TR*, EX*, AX**; ER ns) — PARTIALLY SUPPORTED
- H3: ΔR²=0.0146 (1.46%), F(4,349)=7.025, p<.001*** — PARTIALLY SUPPORTED
- **Key Discovery**: AI Anxiety dominates with sr²=0.525% (36% of total ΔR²)
- **Critical Finding**: Anxiety explains MORE than Trust+Explainability combined
- **Intervention Priority**: Anxiety reduction > Transparency > Trust-building

**Phase 4 Output Files:**
- `../results/tables/structural_model_comparison.csv` - Model fit metrics
- `../results/tables/structural_coefficients_utaut2.csv` - UTAUT2 baseline coefficients
- `../results/tables/structural_coefficients_airs.csv` - AIRS extended coefficients
- `../results/plots/correlation_vif_heatmap.png` - Multicollinearity network (300 dpi)
- `../results/plots/residual_diagnostics.png` - 4-panel assumption validation (300 dpi)
- `../results/plots/effect_sizes_with_ci.png` - Standardized coefficients with 95% CIs (300 dpi)
- `../results/plots/incremental_contributions.png` - Variance decomposition + semi-partial R² (300 dpi)
- `../results/plots/predicted_vs_actual.png` - Model comparison scatter plots (300 dpi)
- `FACT_CHECK_NOTEBOOK_04.md` - Comprehensive statistical validation (66KB, 60+ checks)

## Validated Scale Characteristics

**AIRS 12-Item Diagnostic Scale:**
- **Sample**: N=362 (Development N=181 | Holdout N=181 | Full N=362)
- **Theoretical Framework**: 12 constructs (7 UTAUT2 + VO + 4 AI-specific)
- **Empirical Structure**: 2 factors discovered via parallel analysis
  - **Factor 1: AI Readiness** (10 items: PE2, EE1, SI1, FC1, HM2, PV2, HB2, VO1, TR2, EX1)
  - **Factor 2: Risk/Anxiety** (2 items: ER2, AX1)

**Psychometric Quality (Holdout Sample N=181):**
- **Overall Scale**: α=0.845 (Good), Variance Explained=57.5%
- **Factor 1**: α=0.924, CR=0.923, AVE=0.554 (Excellent)
- **Factor 2**: α=0.691, CR=0.765, AVE=0.640 (Adequate)
- **Model Fit**: CFI=0.952 (Excellent), TLI=0.941 (Good), RMSEA=0.080 (Acceptable)
- **Discriminant Validity**: HTMT=0.527 (<0.85), √AVE > correlations ✓

**Measurement Invariance (Full Sample N=362):**
- **Configural**: ✅ Supported (CFI 0.922-0.946)
- **Metric**: ❌ Not supported (ΔCFI>0.01) - context-dependent loadings
- **Scalar**: ❌ Not supported (ΔCFI>0.01) - different response patterns
- **Implication**: Separate-group models required for moderation analyses (H4)

**Structural Model Results (Full Sample N=362):**
- **UTAUT2 Baseline**: R²=0.8046 (Adj R²=0.8001), 6/8 constructs significant
  - Significant: PE***, SI***, HM***, PV***, HB**, VO*
  - Non-significant: EE (p=.113), FC (p=.179)
- **AIRS Extended**: R²=0.8191 (Adj R²=0.8129), 3/4 AI constructs significant
  - Significant: TR* (β=0.091, p=.022), EX* (β=0.069, p=.019), AX** (β=-0.099, p=.002)
  - Non-significant: ER (β=0.001, p=.917)
- **Incremental Validity**: ΔR²=0.0146 (1.46%), F(4,349)=7.025, p<.001***, Cohen's f²=0.0805
- **Semi-partial R² Hierarchy**: AX (0.525%**) > EX (0.290%*) > TR (0.275%*) > ER (0.001% ns)
- **Key Finding**: AI Anxiety dominates — explains 36% of total AI contribution (ΔR²)

**Selected Items:**
- PE: PE2, EE: EE1, SI: SI1, FC: FC1
- HM: HM2, PV: PV2, HB: HB2, VO: VO1
- TR: TR2, EX: EX1, ER: ER2, AX: AX1



## Next Steps (Phase 5-7 Pending)

### Phase 5: Mediation Analysis (Weeks 27-28) ⏳ NEXT PRIORITY

**05_Mediation_Analysis.ipynb** (to be created)
- **H5a**: Explainability → Trust → BI (does transparency build trust?)
- **H5b**: Ethical Risk → Trust → BI (explains ER non-significance via trust erosion?)
- **H5c**: Ethical Risk → Anxiety → BI (alternative pathway via anxiety amplification?)
- Bootstrap confidence intervals (5000 iterations)
- **Critical Question**: Why is Ethical Risk non-significant in direct test?

**06_Moderation_Analysis.ipynb** (to be created)
- H4: Test moderation by role, usage, business unit
- Multi-group SEM comparisons

### Phase 6: Integration & Reporting
**07_Comprehensive_Results.ipynb** (to be created)
- Integrate findings from all analyses
- Generate APA-formatted tables
- Create publication-quality figures
- Produce diagnostic scoring protocols

## Archived Files

See `../archive/` folder for outdated analysis versions:
- `01_EFA_Development_Sample_24item.ipynb` - Original 24-item, 12-factor attempt
- `01_EFA_Construct_Balanced_12_Item_Model_OLD.ipynb` - Previous short-form version

## Data Files

**Input:**
- `../data/AIRS_clean.csv` - Full preprocessed dataset (N=362)
- `../data/AIRS_clean_dev.csv` - Development sample (N=181)
- `../data/AIRS_clean_holdout.csv` - Holdout sample (N=181)

**Output:**
- `../data/airs_12item_selection.json` - Item selection record
- `../data/AIRS_clean_dev_12item.csv` - 12-item development data

---

**Project**: DBA Dissertation - AI Readiness Scale Validation
**Institution**: Touro University Worldwide
**Timeline**: Weeks 23-32 (Currently Week 26)
**Phases Complete**: 1-4 (Discovery, Validation, Invariance, Structural Modeling) ✅
**Next Phase**: 5 (Mediation Analysis) ⏳
**Last Updated**: November 23, 2025
