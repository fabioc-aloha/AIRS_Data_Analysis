# AIRS Academic Students Subsample Analysis

**Population**: Academic-Student work context (N=185)
**Analysis Date**: November 26, 2025
**Comparison Group**: [Professionals Subsample (N=263)](../airs_professional/README.md)

---

## 📁 Folder Contents

### Core Documentation
- **`STUDENTS_MODEL_TRACKING.md`** - Complete psychometric validation report for students subsample
  - Sample characteristics (N=185: Dev=92, Holdout=93)
  - EFA results (24→15 items, KMO=0.869, α=0.877)
  - CFA validation (15→12 items, CFI=0.887, α=0.944)
  - Reliability and validity assessment
  - Comparison with professionals subsample
  - Limitations and recommendations

### Supporting Directories
- **`plots/`** - All visualization outputs from 8-notebook analysis pipeline (36 images)
- **`tables/`** - Reserved for statistical tables (currently empty)
- **`data/`** - Reserved for subsample-specific exports (currently empty)

---

## 🎯 Key Findings

### Final Validated Instrument
- **12-Item AI Readiness Scale (AIRS-12 Student Version)**
- **Structure**: Unidimensional (AI Readiness only)
- **Reliability**: Cronbach's α = 0.944, CR = 0.945
- **Validity**: AVE = 0.588 (convergent)
- **Model Fit**: CFI = 0.887, TLI = 0.862, RMSEA = 0.136 (marginal)

### Sample Characteristics
- **Total N**: 185 students (38.5% of full dataset)
- **Age Profile**: Entry-level dominant (48%), younger cohort
- **AI Adoption**: 95% adopters (higher than professionals' 85%)
- **Experience**: 78% Entry/Early career (limited work experience)

### Structural Differences from Professionals
| Aspect | Students (N=185) | Professionals (N=263) |
|--------|------------------|----------------------|
| **Final Model** | 12-item, 1-factor | 14-item, 2-factor |
| **Factors** | AI Readiness only | Readiness + Resistance |
| **Cronbach's α** | 0.944 | 0.922 (F1), 0.632 (F2) |
| **CFI** | 0.887 | 0.912 |
| **Inter-Factor r** | N/A (unidimensional) | -0.296 (negative) |
| **Resistance Construct** | Collapsed/failed | Stable (2 items) |

---

## ⚠️ Critical Limitations

### Sample Size Constraints
- **Development N=92**: Below recommended N≥150 (only 61% of threshold)
- **Holdout N=93**: Below recommended N≥150 (only 62% of threshold)
- **Total N=185**: Below ideal N≥200 for CFA (93% of threshold)
- **N:Items Ratio**: 7.7:1 for 24 items (below 10:1 guideline)

**Implications**:
- EFA factors may lack stability and replicability
- CFA fit indices (especially RMSEA) less reliable with small N
- Parameter estimates have wider confidence intervals
- Statistical power reduced for detecting misspecification

### Sample Homogeneity
- **78% Entry/Early career**: Limited representation of advanced students
- **95% AI adopters**: Low variance in adoption status
- **Academic context only**: No workplace diversity
- **Single institution**: Unknown generalizability

### Psychometric Concerns
- **Model Fit**: CFI (0.887) and TLI (0.862) below 0.90 threshold
- **RMSEA**: 0.136 indicates moderate misspecification (exceeds 0.08 threshold)
- **Factor Collapse**: AI Resistance failed to emerge as distinct dimension
- **No Measurement Invariance**: Cannot directly compare students vs. professionals statistically

---

## 🔍 Validation Status

**Current Status**: ⚠️ **EXPLORATORY - Replication Required**

This analysis provides preliminary evidence for AI readiness measurement in student populations, but findings should be treated as **exploratory** pending:

1. ✅ **Immediate Actions**:
   - Use 12-item scale for exploratory assessment only
   - Report findings with prominent sample size disclaimer
   - Acknowledge marginal model fit (CFI/TLI < 0.90)

2. 🔄 **Short-Term Validation** (6-12 months):
   - Collect larger student sample (target N≥300)
   - Test measurement invariance across students vs. professionals
   - Conduct qualitative interviews about resistance construct
   - Pilot student-specific resistance items

3. 📊 **Long-Term Research** (1-3 years):
   - Longitudinal tracking from student → workforce transition
   - Multi-institutional replication across universities
   - Criterion validity studies linking scores to actual AI usage
   - Cross-cultural validation

**Recommendation**: Current findings suitable for hypothesis generation and intervention design, but **not for high-stakes decisions** (admissions, grading, performance evaluation).

---

## 📊 Comparison with Professionals

### Structural Interpretation

**Why Students Show Unidimensional Structure**:
1. **Developmental Stage**: Younger workers lack established routines to resist disruption
2. **Cohort Effect**: Digital natives (Gen Z) show uniformly high tech acceptance
3. **Context**: Academic environments prioritize innovation over stability
4. **Measurement Gap**: Current resistance items miss student concerns (academic integrity, learning dependency)

**Professionals' 2-Factor Model**:
- Distinct AI Readiness (13 items, α=0.922) and AI Resistance (2 items, α=0.632)
- Negative inter-factor correlation (r=-0.296) suggests readiness-resistance trade-off
- Reflects experienced workers balancing enthusiasm with pragmatic concerns

**Key Insight**: AI readiness measurement is **context-dependent**; factors that emerge in professional settings may not generalize to academic contexts.

---

## 🔗 Related Documentation

### Within This Repository
- **[Main README](../README.md)** - Project overview and full dataset analysis
- **[Professionals Analysis](../airs_professional/PROFESSIONALS_MODEL_TRACKING.md)** - Comparison subsample (N=263)
- **[Analysis Plan](../airs/ANALYSIS_PLAN.md)** - 8-notebook validation pipeline
- **[Data Dictionary](../docs/DATA_DICTIONARY.md)** - Variable definitions and coding

### Analysis Notebooks (airs/ folder)
1. `00_Create_Split_Samples.ipynb` - Sample creation with SUBSAMPLE_MODE='students'
2. `01_EFA_Streamlined.ipynb` - Exploratory Factor Analysis (24→15 items)
3. `02_CFA_Measurement_Model.ipynb` - Confirmatory Factor Analysis (15→12 items)
4. `03_Measurement_Invariance.ipynb` - Invariance testing
5. `04_Structural_Model_Hypothesis_Testing.ipynb` - UTAUT2 hypotheses
6. `05_Mediation_Analysis.ipynb` - Indirect effects
7. `06_Moderation_Analysis.ipynb` - Role-based differences
8. `07_Tool_Usage_Patterns.ipynb` - Tool-specific insights
9. `08_Qualitative_Feedback_Analysis.ipynb` - Open-ended responses

---

## 📝 Citation

**Recommended Format**:
> [Authors]. (2025). *AI Readiness Scale for Students (AIRS-12): Exploratory validation in academic contexts*. Development sample N=92, Holdout sample N=93. Cronbach's α=0.944, CR=0.945, AVE=0.588, CFI=0.887, RMSEA=0.136. **Note**: Findings are exploratory pending replication with larger samples (target N≥300).

**Include Disclaimer**:
- Sample sizes below recommended thresholds (N<150)
- Model fit marginal (CFI=0.887, TLI=0.862, RMSEA=0.136)
- Unidimensional structure specific to student population
- Replication required before operational use

---

## 📧 Contact & Contributions

For questions about the students subsample analysis:
1. Review `STUDENTS_MODEL_TRACKING.md` for complete documentation
2. Compare with `../airs_professional/PROFESSIONALS_MODEL_TRACKING.md` for context differences
3. See `../CONTRIBUTING_AIRS.md` for contribution guidelines
4. Refer to `../docs/SUBSAMPLE_ANALYSIS_GUIDE.md` for technical methodology

**Replication Data**: Students subsample data available in:
- `../data/AIRS_clean.csv` (filtered: Work_Context == 'Academic-Student')
- `../data/AIRS_clean_dev.csv` (N=92, development sample)
- `../data/AIRS_clean_holdout.csv` (N=93, holdout sample)

---

**Last Updated**: November 26, 2025
**Analysis Version**: AIRS v1.0 (Students Subsample)
**Validation Status**: ⚠️ Exploratory - Pending Replication
