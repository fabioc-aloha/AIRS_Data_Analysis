# Domain Knowledge: Jupyter Psychometric Analysis Workflows

**Version**: 1.0.0 UNNILNILNILIUM (Initial Mastery)
**Domain**: Python-based psychometric validation in Jupyter notebooks
**Status**: ✅ Mastery Achieved - November 20, 2025
**Foundation**: AIRS psychometric analysis project with complete EFA→CFA→SEM pipeline
**Research Backing**: 60+ academic sources spanning SEM methodology, measurement theory, technology acceptance

---

## 🎯 **Domain Overview**

This domain knowledge captures mastery of executing publication-ready psychometric validation analyses using Python libraries (semopy, factor_analyzer, pingouin) within Jupyter notebook environments. Bridges traditional SPSS psychometric training with modern Python statistical ecosystem.

### **Core Competencies**
1. **Jupyter Workflow Optimization**: Structured notebook architecture for reproducible psychometric research
2. **Python SEM Implementation**: semopy library mastery for CFA/SEM with proper API usage
3. **Factor Analysis Pipeline**: EFA→CFA progression with validation at each stage
4. **Academic Interpretation**: Publication-ready results sections with APA citations
5. **Multicollinearity Diagnostics**: VIF, HTMT, and suppression effect identification

---

## 📊 **Technical Implementation Framework**

### **1. Notebook Architecture Pattern**

**Optimal Cell Structure**:
```
[Markdown] Introduction & Research Questions
[Code] Environment Setup (imports, paths, data loading)
[Markdown] Data Screening Overview
[Code] Missing data, outliers, normality checks
[Markdown] EFA Section Header
[Code] Kaiser criterion, scree plot, parallel analysis
[Code] EFA rotation and loadings extraction
[Markdown] Reliability Analysis
[Code] Cronbach's alpha, omega calculations
[Markdown] CFA Section Header
[Code] CFA model specification and estimation
[Code] Model fit assessment (CFI, TLI, RMSEA, chi2/df)
[Markdown] SEM Hypothesis Testing
[Code] Structural model with path coefficients
[Code] R², effect sizes, moderation tests
[Markdown] Interpretation (with citations)
[Markdown] References (APA format)
```

**Rationale**: Interleaving markdown explanations with code maintains narrative flow while ensuring reproducibility. Enables direct conversion to dissertation chapters or journal manuscripts.

### **2. semopy API Mastery**

**Critical Implementation Details**:

```python
# ✅ CORRECT: Fit statistics extraction
fit_stats = semopy.calc_stats(model)
cfi = fit_stats.loc['Value', 'CFI']
tli = fit_stats.loc['Value', 'TLI']
rmsea = fit_stats.loc['Value', 'RMSEA']
chi2 = fit_stats.loc['Value', 'chi2']
df = fit_stats.loc['Value', 'DoF']

# ❌ INCORRECT: Old dictionary-style access
cfi = fit_stats['CFI'][0]  # KeyError!
```

**Available Fit Indices**: chi2, DoF, CFI, TLI, RMSEA, AIC, BIC
**NOT Available**: SRMR (use alternative libraries if needed)

**Model Comparison Pattern**:
```python
# Nested model comparison
model1 = semopy.Model(specification1)
results1 = model1.fit(data)
fit1 = semopy.calc_stats(model1)

model2 = semopy.Model(specification2)
results2 = model2.fit(data)
fit2 = semopy.calc_stats(model2)

# Delta calculations
delta_chi2 = fit2.loc['Value', 'chi2'] - fit1.loc['Value', 'chi2']
delta_df = fit2.loc['Value', 'DoF'] - fit1.loc['Value', 'DoF']
delta_aic = fit2.loc['Value', 'AIC'] - fit1.loc['Value', 'AIC']

# Statistical test
p_value = 1 - chi2.cdf(delta_chi2, delta_df)
```

### **3. Factor Analysis Pipeline**

**EFA Implementation**:
```python
from factor_analyzer import FactorAnalyzer
from factor_analyzer.factor_analyzer import calculate_bartlett_sphericity
from factor_analyzer.factor_analyzer import calculate_kmo

# Factorability tests
chi2, p = calculate_bartlett_sphericity(df)
kmo_all, kmo_model = calculate_kmo(df)

# Kaiser criterion for factor retention
fa_initial = FactorAnalyzer(n_factors=df.shape[1], rotation=None)
fa_initial.fit(df)
ev, v = fa_initial.get_eigenvalues()
n_factors = sum(ev > 1.0)

# EFA with rotation
fa = FactorAnalyzer(n_factors=n_factors, rotation='varimax')
fa.fit(df)
loadings = pd.DataFrame(
    fa.loadings_,
    index=df.columns,
    columns=[f'Factor{i+1}' for i in range(n_factors)]
)
```

**CFA Implementation**:
```python
# Model specification (semopy syntax)
cfa_model = """
# Measurement model
PE =~ PE1 + PE2 + PE3
EE =~ EE1 + EE2 + EE3
SI =~ SI1 + SI2 + SI3
FC =~ FC1 + FC2 + FC3
HM =~ HM1 + HM2 + HM3
PV =~ PV1 + PV2 + PV3
HT =~ HT1 + HT2 + HT3
BI =~ BI1 + BI2 + BI3
"""

model = semopy.Model(cfa_model)
results = model.fit(df)
fit_stats = semopy.calc_stats(model)

# Fit criteria (Hu & Bentler, 1999)
acceptable_fit = (
    fit_stats.loc['Value', 'CFI'] >= 0.90 and
    fit_stats.loc['Value', 'TLI'] >= 0.90 and
    fit_stats.loc['Value', 'RMSEA'] <= 0.08
)
```

### **4. Multicollinearity Diagnostics**

**VIF Calculation**:
```python
from statsmodels.stats.outliers_influence import variance_inflation_factor

vif_data = []
for i, col in enumerate(predictors):
    vif = variance_inflation_factor(construct_scores[predictors].values, i)
    vif_data.append({'Construct': col, 'VIF': vif})

vif_df = pd.DataFrame(vif_data)

# Thresholds (Hair et al., 2019)
# VIF < 3: Minimal concern
# VIF 3-5: Moderate multicollinearity
# VIF > 5: Severe multicollinearity (consider remediation)
```

**HTMT Assessment** (Henseler et al., 2015):
```python
# Calculate HTMT matrix for discriminant validity
htmt_matrix = pd.DataFrame(index=constructs, columns=constructs)

for c1 in constructs:
    for c2 in constructs:
        if c1 != c2:
            # Between-construct correlations
            between_corr = item_corr.loc[items[c1], items[c2]].abs().mean()
            # Within-construct correlations
            within_c1 = item_corr.loc[items[c1], items[c1]].abs().mean()
            within_c2 = item_corr.loc[items[c2], items[c2]].abs().mean()
            # HTMT ratio
            htmt = between_corr / np.sqrt(within_c1 * within_c2)
            htmt_matrix.loc[c1, c2] = htmt

# Threshold: HTMT < 0.85 (conservative) or < 0.90 (liberal)
```

### **5. Academic Interpretation Integration**

**Citation Management Pattern**:
- **In-text citations**: Use APA format `(Author et al., Year)` immediately after claims
- **References section**: Separate markdown cell at notebook end with full bibliographic entries
- **Citation density**: 2-4 citations per paragraph for methodological claims, 1-2 for results interpretation
- **Source hierarchy**: Prioritize (1) methodology texts, (2) meta-analyses, (3) seminal papers, (4) recent empirical studies

**Interpretation Structure**:
```markdown
### Research Question Findings

**RQ1: UTAUT2 Predictive Power**

The UTAUT2 model demonstrated exceptional explanatory power (R²=90.8%),
consistent with meta-analytic evidence supporting its robustness across
contexts (Dwivedi et al., 2019; Venkatesh et al., 2012). Model fit exceeded
recommended thresholds (CFI=0.970, TLI=0.958, RMSEA=0.045; Hu & Bentler,
1999), validating the measurement model.

However, only one predictor (Hedonic Motivation, β=0.89, p<0.001) achieved
statistical significance in the structural model despite strong bivariate
correlations (mean |r|=0.737). This paradox reflects severe multicollinearity
(mean VIF=12.8), where overlapping variance suppresses individual path
coefficients (Grewal et al., 2004; MacKinnon et al., 2000)...
```

---

## 🔬 **Methodological Insights from AIRS Project**

### **The Parsimony Paradox**

**Discovery**: Simpler UTAUT2 model (7 predictors) outperformed complex AIRS model (11 predictors) despite both achieving high R².

**Explanation** (Burnham & Anderson, 2004; Preacher, 2006):
- **Parsimony Principle**: Models penalized for unnecessary complexity via AIC/BIC
- **Multicollinearity Masking**: High intercorrelations create redundant variance, inflating standard errors
- **Incremental Validity Failure**: AIRS additions didn't explain variance beyond UTAUT2
- **Practical Implication**: More constructs ≠ better model if they measure overlapping concepts

**Statistical Evidence**:
- UTAUT2 AIC: Lower (better parsimony)
- AIRS AIC: Higher (complexity penalty)
- ΔR² (AIRS - UTAUT2): 3.7 percentage points (marginal gain for 4 additional constructs)
- ΔAIC: Favors UTAUT2 by >10 points (substantial evidence per Burnham & Anderson)

### **Multicollinearity vs. Suppression Effects**

**Distinction** (MacKinnon et al., 2000; Tzelgov & Henik, 1991):

**Multicollinearity**:
- High correlations among predictors (r > 0.70)
- Inflated standard errors → reduced statistical power
- Unstable coefficients sensitive to small data changes
- **Solution**: Ridge regression, PLS-SEM, or conceptual model refinement

**Suppression**:
- Predictor becomes more significant when covariates added
- Sign reversal or magnitude increase in β
- Shared variance with covariates "suppresses" irrelevant variance
- **Interpretation**: Valid phenomenon, not a problem requiring "fixing"

**AIRS Case**: Classic multicollinearity (VIF > 5 for all predictors), NOT suppression

### **Discriminant Validity Assessment Evolution**

**Historical Approach** (Fornell & Larcker, 1981):
- Compare √AVE to construct correlations
- **Problem**: Low sensitivity, misses validity issues (Rönkkö & Cho, 2022)

**Modern Best Practice** (Henseler et al., 2015):
- **HTMT (Heterotrait-Monotrait Ratio)**: More rigorous test
- **Threshold**: HTMT < 0.85 (conservative) or < 0.90 (liberal)
- **Interpretation**: Ratio of between-trait to within-trait correlations
- **AIRS Finding**: Some HTMT > 0.90 (PE-EE, FC-SI), indicating discriminant validity concerns

---

## 🎓 **Integration with Existing Knowledge Domains**

### **Synapse Connections**

**[DK-PYTHON-STATISTICAL-ANALYSIS-v1.0.0.md]** (0.99, extends, bidirectional):
- This domain extends Python statistical analysis from univariate methods to full psychometric pipelines
- Adds semopy SEM capability to existing factor_analyzer and pingouin expertise
- Jupyter workflow patterns applicable to both statistical and psychometric analyses

**[DK-SPSS-PSYCHOMETRIC-ANALYSIS-v1.0.0.md]** (0.97, translates, forward):
- Translates SPSS-taught psychometric concepts (EFA, CFA, SEM, reliability) to Python implementation
- Bridges GUI-based SPSS workflow to code-based reproducible research
- Maintains methodological rigor while gaining Python ecosystem advantages (version control, automation, integration)

**[DK-DOCUMENTATION-EXCELLENCE-v1.1.0.md]** (0.94, applies, forward):
- Applied documentation excellence principles to create publication-ready notebook
- Structured interpretation sections with comprehensive academic citations
- Interleaved narrative and code for maximum clarity and reproducibility

**[bootstrap-learning.instructions.md]** (0.91, validates, bidirectional):
- Successfully acquired complex psychometric methodology through conversational learning
- Demonstrates bootstrap learning effectiveness for highly technical statistical domains
- Validates protocol for learning specialized analysis techniques through partnership

**[DK-CONSCIOUSNESS-EVOLUTION-v0.9.0.md]** (0.88, informs, analogical):
- Trust-explainability mediation findings connect to human-AI collaboration themes
- Hedonic motivation as primary driver suggests AI adoption parallels consumer technology patterns
- Parsimony paradox reflects broader cognitive principle: simpler explanations often superior

---

## 🛠️ **Practical Workflow Recommendations**

### **Pre-Analysis Checklist**
- [ ] Install required packages: `semopy`, `factor_analyzer`, `pingouin`, `statsmodels`, `scipy`
- [ ] Structure notebook with clear section headers (markdown cells)
- [ ] Load data with explicit path management (`pathlib.Path`)
- [ ] Document sample characteristics (N, demographics) in opening cells
- [ ] Set visualization style consistently (`sns.set_style()`, `plt.rcParams`)

### **Analysis Sequence**
1. **Data Screening** (15-20% of notebook): Missing data, outliers, normality, linearity
2. **Descriptive Statistics** (10-15%): Means, SDs, correlations with visualizations
3. **EFA** (15-20%): Factor retention, rotation, loadings interpretation
4. **Reliability** (5-10%): Cronbach's alpha, omega, item-total correlations
5. **CFA** (15-20%): Measurement model validation, fit assessment
6. **SEM** (20-25%): Structural paths, R², moderation/mediation tests
7. **Interpretation** (10-15%): Narrative results with citations
8. **References** (5%): Full APA bibliography

### **Common Pitfalls & Solutions**

| **Pitfall** | **Solution** | **Reference** |
|------------|-------------|---------------|
| Using `fit_stats['CFI'][0]` in semopy | Use `.loc['Value', 'CFI']` notation | semopy documentation |
| Expecting SRMR from semopy | Use alternative package (lavaan R) or omit | Package limitations |
| Not checking multicollinearity | Always compute VIF before interpreting paths | Hair et al. (2019) |
| Interpreting non-significant paths as "no effect" | Check bivariate correlations and VIF | Grewal et al. (2004) |
| Over-interpreting high R² with non-sig predictors | Identify suppression or multicollinearity | MacKinnon et al. (2000) |
| Using only Fornell-Larcker for discriminant validity | Supplement with HTMT assessment | Henseler et al. (2015) |
| No citations in interpretation sections | Add 2-4 citations per paragraph | APA standards |

### **Performance Optimization**
- **Large datasets**: Use `semopy` GPU acceleration if available
- **Complex models**: Start simple (measurement model only), then add structural paths
- **Convergence issues**: Check identification (df > 0), scale indicators properly, try different starting values
- **Reproducibility**: Set random seeds for bootstrap/permutation tests (`np.random.seed()`)

---

## 📚 **Key References**

**Methodology Foundations**:
- Kline, R. B. (2016). *Principles and practice of structural equation modeling* (4th ed.). Guilford Press.
- Byrne, B. M. (2016). *Structural equation modeling with AMOS* (3rd ed.). Routledge.
- Hair, J. F., et al. (2019). When to use and how to report the results of PLS-SEM. *European Business Review*, *31*(1), 2-24.

**Multicollinearity & Validity**:
- Grewal, R., et al. (2004). Multicollinearity and measurement error in structural equation models. *Marketing Science*, *23*(4), 519-529.
- Henseler, J., et al. (2015). A new criterion for assessing discriminant validity in variance-based structural equation modeling. *JAMS*, *43*(1), 115-135.
- Rönkkö, M., & Cho, E. (2022). An updated guideline for assessing discriminant validity. *Organizational Research Methods*, *25*(1), 6-14.

**Statistical Theory**:
- MacKinnon, D. P., et al. (2000). Equivalence of the mediation, confounding and suppression effect. *Prevention Science*, *1*(4), 173-181.
- Burnham, K. P., & Anderson, D. R. (2004). Multimodel inference: Understanding AIC and BIC in model selection. *Sociological Methods & Research*, *33*(2), 261-304.

**Technology Acceptance Context**:
- Venkatesh, V., et al. (2012). Consumer acceptance and use of information technology: Extending UTAUT. *MIS Quarterly*, *36*(1), 157-178.
- Dwivedi, Y. K., et al. (2019). Re-examining UTAUT: Towards a revised theoretical model. *Information Systems Frontiers*, *21*(3), 719-734.

---

## 🔄 **Version History**

**1.0.0 UNNILNILNILIUM** (November 20, 2025) - Initial Mastery:
- Documented complete EFA→CFA→SEM pipeline in Python/Jupyter
- Established semopy API best practices from AIRS project debugging
- Integrated academic interpretation protocols with 60+ citations
- Created cross-domain connections to existing Python and SPSS knowledge
- Codified parsimony paradox and multicollinearity diagnostic insights

---

## Embedded Synapse Network

- [DK-PYTHON-STATISTICAL-ANALYSIS-v1.0.0.md] (0.95, implements, bidirectional) - "Python statistical tools applied in Jupyter psychometric workflows"
- [DK-CFA-SEMOPY-IMPLEMENTATION-v1.0.0.md] (0.94, extends, forward) - "CFA implementation builds on Jupyter workflow patterns"
- [DK-NOTEBOOK-REFACTORING-v1.0.0.md] (0.92, receives-from, reverse) - "Refactoring methodology improves psychometric notebook quality"
- [meditation-session-2025-11-27-efa-cherry-pick-workflow.prompt.md] (0.90, extends, forward) - "Cherry-pick workflow adds decision point architecture to EFA stage"
- [DK-PSYCHOMETRIC-VALIDATION-v1.0.0.md] (0.89, shares-patterns, bidirectional) - "Validation criteria applied within Jupyter workflow stages"
- [DK-SPSS-PSYCHOMETRIC-ANALYSIS-v1.0.0.md] (0.85, translates, bidirectional) - "SPSS foundations translated to Python/Jupyter implementation"

---

*Domain knowledge established through AIRS psychometric analysis project - translating SPSS foundations to Python mastery with publication-ready Jupyter workflows*
