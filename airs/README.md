# AIRS Analysis Notebooks

This folder contains the primary analysis notebooks for the AI Readiness Scale (AIRS) psychometric validation study.

## Analysis Workflow

### Phase 1: Data Preparation
**00_Create_Split_Samples.ipynb**
- Creates stratified 50/50 split (development N=181, holdout N=181)
- Stratification by Work_Context × AI_Adoption
- Validates balance across demographic and item-level distributions
- **Status**: ✅ Complete

### Phase 2: Scale Development
**01_EFA_Construct_Balanced_12_Item.ipynb**
- Develops 12-item construct-balanced diagnostic scale
- Manual refinement: ER1→ER2, AX2→AX1 for improved F2 reliability
- Determines empirical factor structure (2 factors via parallel analysis)
- Validates reliability (12-item α = 0.845) and factorability (KMO = 0.919)
- **Status**: ✅ Complete

**02_CFA_Measurement_Model.ipynb**
- Validates 2-factor structure on holdout sample (N=181)
- Model fit: CFI=0.925, TLI=0.905, RMSEA=0.101, χ²/df=2.85
- F1 reliability: α=0.924, CR=0.923, AVE=0.554
- F2 reliability: α=0.691, CR=0.765, AVE=0.640
- Discriminant validity: HTMT=0.527, Fornell-Larcker criterion met
- **Status**: ✅ Complete

**Output Files:**
- `../data/airs_12item_selection.json` - Item selection documentation
- `../data/AIRS_clean_dev_12item.csv` - 12-item development dataset

## Scale Characteristics

**12-Item AIRS Scale:**
- **Purpose**: Dual-purpose diagnostic and predictive tool
- **Sample**: N=362 (181 dev, 181 holdout)
- **Items**: 12 items across 10 constructs
- **Factors**: 2 empirically supported dimensions
  - **F1: AI Readiness** (10 items: PE2, EE1, SI1, FC1, HM2, PV2, HB2, VO1, TR2, EX1)
  - **F2: Tech-Averse Barriers** (2 items: ER2, AX1)
- **Reliability**:
  - Overall 12-item scale: α = 0.845 (Good)
  - F1: α = 0.924, CR = 0.923, AVE = 0.554 (Excellent)
  - F2: α = 0.691, CR = 0.765, AVE = 0.640 (Acceptable)
- **Model Fit**: CFI = 0.925, TLI = 0.905, RMSEA = 0.101, χ²/df = 2.85
- **Discriminant Validity**: HTMT = 0.527 (< 0.85), Fornell-Larcker criterion met

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
