# Subsample Analysis Guide: Students vs Professionals

**Created**: November 25, 2025
**Purpose**: Enable context-specific model validation for AI Readiness Scale

---

## 🎯 Overview

Notebook 02a revealed that **Role (Student vs Professional) is the largest source of demographic heterogeneity** in the AI Readiness Scale, with a CFI difference of 0.117. This guide explains how to run subsample-specific analyses to develop context-optimized measurement models.

---

## 📊 Key Findings from Full Sample Analysis

| Group | N | CFI (12-item baseline) | RMSEA | Interpretation |
|-------|---|----------------------|-------|----------------|
| **Full Sample** | 472 | 0.868 | 0.148 | Marginal fit |
| **Students** | 176 | 0.794 | 0.155 | **Poor fit** - More heterogeneous construct |
| **Professionals** | 296 | 0.910 | 0.137 | **Acceptable CFI** - More coherent construct |
| **Δ CFI** | - | **0.117** | - | **Largest heterogeneity source** |

**Interpretation**: Students and professionals conceptualize AI readiness differently. Separate models may provide better measurement properties for each context.

---

## 🔧 How to Switch Between Subsamples

### Step 1: Configure Subsample Mode in Notebook 00

1. Open `airs/00_Create_Split_Samples.ipynb`
2. Navigate to **Section 0** (top of notebook after imports)
3. Locate the configuration cell:

```python
# ═══════════════════════════════════════════════════════════════════════════════
# SUBSAMPLE CONFIGURATION - EDIT THIS TO SWITCH BETWEEN SAMPLES
# ═══════════════════════════════════════════════════════════════════════════════

# OPTIONS: 'full', 'students', 'professionals'
SUBSAMPLE_MODE = 'full'  # ← CHANGE THIS VALUE

# ═══════════════════════════════════════════════════════════════════════════════
```

4. Change `SUBSAMPLE_MODE` to one of:
   - `'full'` - Complete sample (N=472)
   - `'students'` - Students only (N=176, Academic-Student context)
   - `'professionals'` - Professionals only (N=296, workplace context)

### Step 2: Regenerate Data Files

5. **Re-run ALL cells** in Notebook 00
   - This regenerates `AIRS_clean.csv`, `AIRS_clean_dev.csv`, `AIRS_clean_holdout.csv` with the selected subsample
   - Stratification occurs **within** the selected subsample (maintains Work Context × AI Adoption balance)

### Step 3: Re-run Analysis Pipeline

6. **Re-run all subsequent notebooks in sequence**:
   - `01_EFA_Streamlined.ipynb` - Factor analysis on selected subsample
   - `02a_Full_Sample_CFA_Revalidation.ipynb` - CFA model testing
   - `03_Measurement_Invariance.ipynb` - Invariance testing (if applicable)
   - `04_Structural_Model_Hypothesis_Testing.ipynb` - Hypothesis testing

7. Compare results across subsample configurations to identify:
   - Which model specification works best for each context
   - Whether items function differently across contexts
   - Context-specific reliability and validity evidence

---

## 📈 Expected Outcomes by Subsample

### Full Sample (N=472)
- **Best model**: 10-item + correlated errors (CFI=0.962, RMSEA=0.097)
- **Use case**: Comprehensive model for general population
- **Limitation**: May mask context-specific measurement issues

### Students Only (N=176)
- **Current fit**: Poor (CFI=0.794 in 12-item baseline)
- **Expectation**: May require different correlated errors or item removals
- **Use case**: Academic settings, educational research, student-focused interventions
- **Research question**: What drives heterogeneity in student AI readiness perceptions?

### Professionals Only (N=296)
- **Current fit**: Acceptable CFI (0.910 in 12-item baseline)
- **Expectation**: May achieve excellent fit with minor modifications
- **Use case**: Organizational contexts, workplace training, professional development
- **Research question**: Can we achieve a more parsimonious model for professionals?

---

## 🔍 Analysis Checklist

When running subsample analyses, document:

- [ ] **Sample characteristics** (N, demographics, usage patterns)
- [ ] **Model fit comparison** (CFI, TLI, RMSEA across models)
- [ ] **Item performance** (loadings, modification indices, residuals)
- [ ] **Reliability** (Cronbach's α, CR, AVE for each subsample)
- [ ] **Validity evidence** (convergent, discriminant, criterion)
- [ ] **Practical implications** (different cutoff scores? different interpretations?)

---

## 📝 Documentation Requirements

For dissertation/publication, report:

1. **Rationale**: Why subsample analysis was conducted (cite Δ CFI = 0.117 from Notebook 02a)
2. **Sample sizes**: Report N for each subsample and justify adequacy (>150 for CFA)
3. **Model modifications**: Document any context-specific changes
4. **Comparative analysis**: Present fit indices side-by-side
5. **Generalizability**: Discuss limitations of context-specific findings

---

## 🎓 Theoretical Implications

### Students: More Heterogeneous Construct
- **Possible explanations**:
  - Varied exposure to AI tools (some courses require, others don't)
  - Less workplace experience = less consistent mental models
  - Academic vs professional AI use cases differ fundamentally
  - Younger cohort = more variability in attitudes toward emerging tech

### Professionals: More Coherent Construct
- **Possible explanations**:
  - Workplace norms create convergent attitudes
  - Professional accountability makes AI adoption more strategic
  - Common organizational contexts (productivity, efficiency focus)
  - Veterans in sample = more experience = more stable perceptions

---

## 🚀 Research Questions Enabled

1. **Measurement invariance**: Does AI Readiness Scale measure the same construct across contexts?
2. **Differential item functioning**: Which items work differently for students vs professionals?
3. **Context-specific norms**: Should separate scoring guidelines be developed?
4. **Short form development**: Can we create optimized 6-8 item scales for each context?
5. **Intervention targeting**: Do students and professionals need different AI readiness interventions?

---

## ⚠️ Important Warnings

- **Do not mix results**: Report subsample findings separately, not as combined
- **Sample size concerns**: Students (N=176) approaches minimum for CFA - use robust estimation
- **Generalizability**: Results are context-specific, do not overgeneralize
- **File management**: Keep clear records of which subsample generated which results
- **Version control**: Consider separate branches for subsample analyses if using Git

---

## 📚 References for Subsample Analysis

- **Measurement invariance**: Vandenberg & Lance (2000). "A review and synthesis of the measurement invariance literature"
- **Context effects**: Meredith (1993). "Measurement invariance, factor analysis and factorial invariance"
- **Demographic heterogeneity**: Putnick & Bornstein (2016). "Measurement invariance conventions and reporting"
- **Sample size**: Wolf et al. (2013). "Sample size requirements for structural equation models"

---

## 💡 Practical Recommendations

### For Academic Contexts (Students):
1. Consider more exploratory approach given heterogeneity
2. May need context-specific items (e.g., "AI helps with coursework")
3. Focus on identifying subgroups within students (by major, tech experience)
4. Develop interventions that address variability in readiness

### For Organizational Contexts (Professionals):
1. Leverage better model fit to develop short form for workplace assessment
2. Establish organizational benchmarks and norms
3. Use for training needs assessment and ROI measurement
4. Implement as pre-post evaluation tool for AI adoption programs

---

**Status**: Configuration complete - Ready for subsample-specific analyses
**Next Steps**:
1. Choose subsample mode in Notebook 00
2. Re-run analysis pipeline
3. Compare results across contexts
4. Document context-specific findings
