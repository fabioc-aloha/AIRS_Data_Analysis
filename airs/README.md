# AIRS Analysis Notebooks

This folder contains the primary analysis notebooks for the AI Readiness Scale (AIRS) psychometric validation study.

## Analysis Workflow

### Phase 1: Data Preparation
**00_Create_Split_Samples.ipynb**
- Creates stratified 50/50 split (development N=159, holdout N=159)
- Stratification by Work_Context × AI_Adoption
- Validates balance across demographic and item-level distributions
- **Status**: ✅ Complete

### Phase 2: Scale Development
**01_EFA_Construct_Balanced_12_Item.ipynb**
- Develops 12-item construct-balanced diagnostic scale
- Selects best item per construct (1 × 12 constructs)
- Determines empirical factor structure (2 factors via parallel analysis)
- Validates reliability (α = 0.897) and predictive validity (R² = 0.811)
- **Status**: ✅ Complete

**Output Files:**
- `../data/airs_12item_selection.json` - Item selection documentation
- `../data/AIRS_clean_dev_12item.csv` - 12-item development dataset

## Scale Characteristics

**12-Item AIRS Scale:**
- **Purpose**: Dual-purpose diagnostic and predictive tool
- **Items**: 12 (1 per construct for comprehensive coverage)
- **Factors**: 2 empirically supported dimensions
  - Factor 1: Positive attitudes/facilitators (PE, FC, HM, PV, HB, TR, VO)
  - Factor 2: Concerns/barriers (AX, ER, EE, SI, EX)
- **Reliability**: α = 0.897 (Good)
- **Variance Explained**: 58.1%
- **Predictive Validity**: R² = 0.811 (predicting BI/AI adoption)
- **Efficiency**: 50% item reduction with 96.3% retained predictive power

**Selected Items:**
- PE: PE1, EE: EE2, SI: SI2, FC: FC1
- HM: HM1, PV: PV2, HB: HB2, VO: VO1
- TR: TR1, EX: EX1, ER: ER1, AX: AX2

## Next Steps (Pending)

### Phase 3: Confirmatory Validation
**02_CFA_Measurement_Model.ipynb** (to be created)
- Validate 2-factor structure on holdout sample (N=159)
- Assess fit indices (CFI/TLI ≥ 0.90, RMSEA ≤ 0.08)
- Calculate composite reliability (CR) and average variance extracted (AVE)
- Test discriminant validity (Fornell-Larcker, HTMT)

### Phase 4: Measurement Invariance
**03_Measurement_Invariance.ipynb** (to be created)
- Test invariance across role (student vs. professional)
- Test invariance across usage frequency (low vs. high)
- Test invariance across business unit

### Phase 5: Structural Models & Hypothesis Testing
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
- `../data/AIRS_clean.csv` - Full preprocessed dataset (N=318)
- `../data/AIRS_clean_dev.csv` - Development sample (N=159)
- `../data/AIRS_clean_holdout.csv` - Holdout sample (N=159)

**Output:**
- `../data/airs_12item_selection.json` - Item selection record
- `../data/AIRS_clean_dev_12item.csv` - 12-item development data

---

**Project**: DBA Dissertation - AI Readiness Scale Validation
**Institution**: Touro University Worldwide
**Timeline**: Weeks 23-32
**Last Updated**: November 22, 2025
