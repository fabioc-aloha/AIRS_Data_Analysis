# AI Readiness Scale - Professionals Subsample Analysis Archive

**Analysis Period**: November 25-26, 2025
**Status**: Phase 4 Complete (CFA Validated)
**Purpose**: Context-specific AI readiness model for workplace professionals

---

## 📁 Archive Contents

This folder contains complete results from the professionals-only subsample analysis to prevent overwriting during future analyses (e.g., students subsample, full sample re-runs).

### Directory Structure

```
airs_professional/
├── README.md                           # This file
├── PROFESSIONALS_MODEL_TRACKING.md     # Complete analysis documentation
├── data/                               # Preserved data files
│   ├── AIRS_clean.csv                 # Full professionals sample (N=263)
│   ├── AIRS_clean_dev.csv             # Development sample (N=131)
│   ├── AIRS_clean_holdout.csv         # Holdout/validation sample (N=132)
│   ├── airs_15item_selection.json     # EFA-selected 15 items
│   └── airs_24item_complete.json      # Complete 24-item pool
├── plots/                              # Key visualizations
│   ├── sample_*.png                   # Sample characteristics & stratification
│   ├── scree_*.png                    # EFA factor retention analysis
│   ├── loading_*.png                  # Factor loading visualizations
│   ├── iterative_*.png                # Item reduction process
│   └── cfa_*.png                      # CFA model results (3 figures)
└── tables/                             # Results tables (CSV)
    ├── cfa_model_fit.csv              # Fit indices for PRO-M2
    ├── cfa_factor_loadings.csv        # Standardized loadings
    └── cfa_reliability_validity.csv   # Reliability & validity metrics
```

---

## 📊 Quick Reference

### Sample Characteristics
- **Total N**: 263 professionals (filtered from 472 full sample)
- **Development N**: 131 (EFA)
- **Holdout N**: 132 (CFA)
- **AI Adoption**: 85% adopters, 15% non-adopters
- **Experience**: 55% Expert (11+ years), 70% Senior+ combined

### Final Model: PRO-M2 (14-item, 2-factor)
- **Factor 1 (AI Readiness)**: 12 items, α=0.967, AVE=0.711
- **Factor 2 (AI Resistance)**: 2 items, α=0.722, AVE=0.661
- **Model Fit**: CFI=0.910, TLI=0.885, RMSEA=0.130, SRMR=0.050
- **Validity**: Convergent ✅, Discriminant ✅

### Key Findings
1. Professionals show superior psychometric properties vs. full sample
2. 2-factor structure: Unified readiness + distinct resistance dimensions
3. Hedonic motivation (enjoyment) is strongest predictor
4. Effort expectancy & facilitating conditions not discriminating (removed)
5. Acceptable fit achieved with full convergent/discriminant validity

---

## 🔄 Reproducibility

### To Reproduce This Analysis

1. **Set configuration** in `airs/00_Create_Split_Samples.ipynb`:
   ```python
   SUBSAMPLE_MODE = 'professionals'  # Line ~30
   ```

2. **Run notebooks sequentially**:
   - `00_Create_Split_Samples.ipynb` → Generate professionals-only data
   - `01_EFA_Streamlined.ipynb` → Exploratory factor analysis (N=131)
   - `02_CFA_Measurement_Model.ipynb` → Confirmatory factor analysis (N=132)

3. **Expected outputs**:
   - Data files in `data/` (AIRS_clean*.csv)
   - Plots in `results/plots/`
   - Tables in `results/tables/`

4. **Preserve results**:
   - Copy files to `airs_professional/` before changing SUBSAMPLE_MODE
   - Update PROFESSIONALS_MODEL_TRACKING.md with new findings

### Configuration Note
⚠️ **Important**: Setting `SUBSAMPLE_MODE = 'professionals'` filters the dataset at generation level, producing different N and composition than subsample testing within full sample (as done in original Notebook 02a).

---

## 📈 Analysis Phases

### ✅ Completed Phases

- [x] **Phase 1**: Baseline establishment (from Notebook 02a)
- [x] **Phase 2**: Professionals-specific data generation (N=263)
- [x] **Phase 3**: Exploratory factor analysis (15-item selection)
- [x] **Phase 4**: Confirmatory factor analysis (PRO-M1, PRO-M2)

### 🔜 Future Phases

- [ ] **Phase 5**: Measurement invariance (experience/education levels)
- [ ] **Phase 6**: Hypothesis testing (UTAUT2 structural model)
- [ ] **Phase 7**: Advanced optimization (PRO-M3+ with correlated errors)

---

## 📚 Documentation

### Main Document
`PROFESSIONALS_MODEL_TRACKING.md` contains:
- Executive summary with key findings
- Detailed phase-by-phase findings logs
- Model comparison tables (5 comprehensive tables)
- Visual results summary (8 figures)
- Theoretical insights and practical implications
- Quality assurance checklists

### Quick Links
- **EFA Results**: See "Phase 3 Findings" section
- **CFA Results**: See "Phase 4 Findings" section
- **Model Comparison**: See "Table 2: Model Progression"
- **Item Loadings**: See "Table 3: Item Performance"
- **Reliability/Validity**: See "Table 4: Metrics"
- **Visualizations**: See "Visual Results Summary" section
- **Conclusions**: See "Key Findings & Conclusions" section

---

## 🎯 Model Selection Decision

**Selected Model**: PRO-M2 (14-item, 2-factor)

**Rationale**:
1. Establishes convergent validity (AVE ≥ 0.50 for both factors)
2. Achieves acceptable model fit (CFI=0.910 ≥ 0.90)
3. All items meet loading threshold (λ ≥ 0.50)
4. Maintains excellent reliability (F1 α=0.967, F2 α=0.722)
5. Parsimonious scale suitable for workplace assessment

**Trade-offs**:
- RMSEA=0.130 remains elevated (acceptable given N=132)
- Factor 2 only 2 items (meets identification minimum)
- TLI=0.885 slightly below 0.90 threshold

---

## 📖 Citation

If using this professionals-specific model, cite:
- Original instrument development (to be published)
- Subsample configuration: `SUBSAMPLE_MODE = 'professionals'`
- Final model: PRO-M2 (14-item, 2-factor, N=132 holdout)

---

## 📧 Contact

For questions about this analysis:
- See main project README.md
- Review PROFESSIONALS_MODEL_TRACKING.md documentation
- Check analysis notebooks in `airs/` folder

---

**Archive Date**: November 26, 2025
**Version**: PRO-M2 (Final)
**Status**: Ready for Phase 5-6 (Invariance & Hypothesis Testing)
