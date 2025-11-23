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

**Output Files:**
- `../data/airs_12item_selection.json` - Item selection documentation
- `../data/AIRS_clean_dev_12item.csv` - 12-item development dataset

## Validated Scale Characteristics

**AIRS 12-Item Diagnostic Scale:**
- **Sample**: N=362 (Development N=181 | Holdout N=181 | Full N=362)
- **Theoretical Framework**: 12 constructs (7 UTAUT2 + VO + 4 AI-specific)
- **Empirical Structure**: 2 factors discovered via parallel analysis
  - **Factor 1: Mixed Readiness** (10 items: PE2, EE1, SI1, FC1, HM2, PV2, HB2, VO1, TR2, EX1)
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

**Selected Items:**
- PE: PE2, EE: EE1, SI: SI1, FC: FC1
- HM: HM2, PV: PV2, HB: HB2, VO: VO1
- TR: TR2, EX: EX1, ER: ER2, AX: AX1

### Phase 3: Measurement Invariance
**03_Measurement_Invariance.ipynb**
- Tests invariance across Role (Student vs. Professional), Usage (Low vs. High), Adoption (Non-Adopter vs. Adopter)
- Configural invariance: SUPPORTED (CFI 0.922-0.946, all groups maintain 2-factor structure)
- Metric invariance: NOT SUPPORTED (max loading diffs 0.414-0.481, ΔCFI 0.052-0.072)
- Scalar invariance: NOT SUPPORTED (max mean diffs 0.487-0.639, ΔCFI 0.059-0.095)
- Implication: Constructs function differently across contexts (theoretically meaningful); use separate-group models for H4
- **Status**: ✅ Complete (November 23, 2025)

**Output Files:**
- `../results/tables/measurement_invariance_summary.csv` - Complete invariance test results
- `../results/plots/` - 5 visualization figures with comprehensive interpretations

## Next Steps (Phase 4-6 Pending)

### Phase 4: Structural Models & Hypothesis Testing

**04_Structural_Model_Hypothesis_Testing.ipynb** (to be created)
- H1-H3: Test direct effects of constructs on BI
- Compare UTAUT2 baseline vs. AIRS extended model
- Calculate incremental variance explained (ΔR²)

**05_Mediation_Analysis.ipynb** (to be created)
- Test mediation paths (e.g., EX → TR → BI)

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
**Timeline**: Weeks 23-32
**Last Updated**: November 22, 2025
