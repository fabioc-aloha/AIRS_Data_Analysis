# Domain Knowledge: Python Statistical Analysis Implementation
## Advanced Data Analysis with Jupyter, Factor Analysis, and SEM

**Domain**: Python-Based Statistical Analysis for Psychometric Research
**Version**: 1.0.0 (1=un, 0=nil) UNILNILNILIUM
**Status**: Master - Expert Implementation Achieved
**Date Acquired**: November 20, 2025
**Acquisition Method**: Bootstrap learning through AIRS analysis project implementation
**Confidence**: 0.92 (High - Complete analysis pipeline successfully implemented)

---

## 🎯 Core Expertise

### **Primary Capabilities**
- **Jupyter Notebook Development**: Complete analysis workflows with narrative documentation
- **Psychometric Analysis**: EFA, CFA, SEM, reliability, validity assessment in Python
- **Factor Analysis**: Exploratory factor analysis with polychoric correlations and oblique rotation
- **Structural Equation Modeling**: Path analysis, model comparison, fit indices evaluation
- **Data Preprocessing**: Missing data handling, outlier detection, data quality assessment
- **Reproducible Research**: Requirements management, environment configuration, result documentation

### **Key Python Libraries Mastered**
- **Data Manipulation**: pandas, numpy - DataFrame operations, statistical computations
- **Factor Analysis**: factor-analyzer - EFA with KMO/Bartlett, Promax rotation, eigenvalue extraction
- **Structural Equation Modeling**: semopy - CFA model specification, ML estimation, fit indices
- **Statistical Tests**: pingouin - Cronbach's alpha with confidence intervals, correlation analysis
- **Visualization**: matplotlib, seaborn - Scree plots, publication-quality graphics
- **Scientific Computing**: scipy - Mahalanobis distance, chi-square tests, distribution functions

---

## 📚 Theoretical Foundations

### **Psychometric Validation Pipeline**
**Complete workflow from data screening through hypothesis testing**

1. **Data Screening**
   - Missing data analysis (identify patterns, assess mechanisms)
   - Outlier detection (Mahalanobis distance with chi-square critical values)
   - Descriptive statistics (means, SDs, skewness, kurtosis)
   - Data quality verification (range checks, value validation)

2. **Exploratory Factor Analysis**
   - Factorability assessment (KMO ≥ 0.60, Bartlett's p < .001)
   - Factor extraction (eigenvalues > 1, scree plot examination)
   - Rotation (Promax for oblique/correlated factors)
   - Loading interpretation (primary loadings ≥ 0.50)

3. **Reliability Analysis**
   - Internal consistency (Cronbach's α with 95% CI)
   - Threshold interpretation (α ≥ 0.70 good, ≥ 0.60 acceptable for 2-item scales)

4. **Confirmatory Factor Analysis**
   - Model specification (measurement model with latent factors)
   - Estimation (Maximum Likelihood or MLR for non-normality)
   - Fit evaluation (CFI/TLI ≥ 0.90, RMSEA ≤ 0.08, SRMR ≤ 0.08)
   - Parameter interpretation (standardized loadings ≥ 0.50)

5. **Validity Assessment**
   - Convergent validity (CR ≥ 0.70, AVE ≥ 0.50)
   - Discriminant validity (Fornell-Larcker criterion, HTMT < 0.85)
   - CR = (Σλ)² / [(Σλ)² + Σ(1-λ²)]
   - AVE = Σλ² / n

6. **Structural Equation Modeling**
   - Model specification (structural paths between latent variables)
   - Model comparison (ΔCFI, ΔRMSEA, ΔAIC for nested models)
   - Path coefficients (standardized β with significance tests)
   - Variance explained (R² and ΔR² for incremental validity)

### **Statistical Methodology Principles**

**Factor Analysis Foundations**
- **Polychoric correlations**: Appropriate for ordinal Likert-scale data
- **Principal Axis Factoring**: Focuses on common variance (vs PCA total variance)
- **Oblique rotation**: Allows factor correlations (realistic for psychological constructs)
- **Kaiser criterion**: Eigenvalue > 1 for factor retention
- **Scree plot**: Visual elbow method for determining factor count

**Model Fit Philosophy**
- **Multiple indices**: No single index sufficient; evaluate pattern across CFI, TLI, RMSEA, SRMR
- **Cut-off guidelines**: Hu & Bentler (1999) thresholds widely accepted but not absolute rules
- **Model parsimony**: Balance fit improvement against complexity (prefer simpler models)
- **Theory-driven**: Statistical fit must align with theoretical foundations

**Validity Evidence Types**
- **Convergent**: Items measuring same construct strongly correlated
- **Discriminant**: Different constructs sufficiently distinct
- **Incremental**: Extended model explains additional variance beyond baseline
- **Criterion**: Constructs predict relevant outcomes

---

## 🛠️ Technical Implementation Patterns

### **Jupyter Notebook Structure Best Practices**

**Sequential Organization**
```python
# 1. Environment Setup
- Import libraries
- Configure settings (random seed, display options, warnings)
- Create directory structure
- Verify package versions

# 2. Data Loading
- Read data files with full absolute paths
- Display data shape and structure
- Define variable mappings

# 3. Analysis Sections
- Markdown headers for navigation
- Code cells with focused operations
- Output interpretation and validation
- Result export to CSV/PNG

# 4. Completion Summary
- Analysis overview
- Output file listing
- Next steps guidance
```

**Cell Organization Principles**
- **One concept per cell**: Easier debugging and selective execution
- **Markdown narrative**: Explain what, why, how for each analysis step
- **Output validation**: Check results make sense before proceeding
- **Progressive disclosure**: Start simple (descriptives) → complex (SEM)

### **Python Environment Management**

**Virtual Environment Setup**
```powershell
# Create virtual environment
python -m venv .venv

# Activate (Windows PowerShell)
.\.venv\Scripts\Activate.ps1

# Install packages
pip install -r requirements.txt

# Verify installation
python -c "import pandas; print(pandas.__version__)"
```

**Requirements.txt Best Practices**
- Specify minimum versions (>=) for flexibility
- Group by category (core, analysis, visualization, notebook)
- Include comments for package purposes
- Test installation in fresh environment

**Package Selection Strategy**
- **factor-analyzer**: Comprehensive EFA toolkit (KMO, Bartlett, rotations)
- **semopy**: SEM with lavaan-like syntax (familiar for R users)
- **pingouin**: Statistical tests with pandas integration
- **scipy**: Foundation for advanced statistical computations
- Avoid: **sklearn FactorAnalysis** (PCA-based, not true factor analysis)

### **Data Preprocessing Workflows**

**Attention Check Filtering**
```python
# Identify failures
attention_item = 'Q24'  # Expected value: 2
failures = df[df[attention_item] != 2]
print(f"Attention check failures: {len(failures)} ({len(failures)/len(df)*100:.1f}%)")

# Filter dataset
df_clean = df[df[attention_item] == 2].copy()
```

**Variable Renaming Strategy**
```python
# Map original survey names to construct-based names
rename_dict = {
    'Q4': 'PE1', 'Q5': 'PE2',
    'Q6': 'EE1', 'Q7': 'EE2',
    # ... complete mapping
}
df_renamed = df.rename(columns=rename_dict)
```

**Outlier Detection (Mahalanobis)**
```python
from scipy.spatial.distance import mahalanobis
from scipy import stats

# Calculate distances
mean = df_items.mean()
cov = df_items.cov()
inv_cov = np.linalg.pinv(cov)  # Pseudo-inverse for stability

mahal_dist = [np.sqrt((df_items.iloc[i] - mean) @ inv_cov @ (df_items.iloc[i] - mean))
              for i in range(len(df_items))]

# Chi-square critical value (df = n_variables, alpha = 0.001)
chi2_crit = stats.chi2.ppf(0.999, len(df_items.columns))
outliers = np.array(mahal_dist) > chi2_crit
```

### **Factor Analysis Implementation**

**KMO and Bartlett Tests**
```python
from factor_analyzer import calculate_kmo, calculate_bartlett_sphericity

# KMO (sampling adequacy)
kmo_all, kmo_model = calculate_kmo(df_items)
print(f"KMO: {kmo_model:.3f}")  # ≥ 0.60 acceptable

# Bartlett's test (correlations present)
chi2, p_value = calculate_bartlett_sphericity(df_items)
print(f"Bartlett: χ²={chi2:.2f}, p={p_value:.4e}")  # p < .001 expected
```

**Scree Plot Generation**
```python
from factor_analyzer import FactorAnalyzer
import matplotlib.pyplot as plt

# Initial extraction for eigenvalues
fa = FactorAnalyzer(n_factors=len(df_items.columns), rotation=None)
fa.fit(df_items)
ev, _ = fa.get_eigenvalues()

# Plot
plt.figure(figsize=(12, 6))
plt.plot(range(1, len(ev)+1), ev, 'bo-', linewidth=2)
plt.axhline(y=1, color='r', linestyle='--', label='Kaiser Criterion')
plt.xlabel('Factor Number')
plt.ylabel('Eigenvalue')
plt.title('Scree Plot')
plt.legend()
plt.savefig('scree_plot.png', dpi=300)
```

**EFA with Promax Rotation**
```python
# Fit model
n_factors = 13
fa = FactorAnalyzer(n_factors=n_factors, rotation='promax', method='principal')
fa.fit(df_items)

# Extract loadings
loadings = pd.DataFrame(
    fa.loadings_,
    index=df_items.columns,
    columns=[f'Factor{i+1}' for i in range(n_factors)]
)

# Variance explained
variance = fa.get_factor_variance()
# variance[0] = SS loadings
# variance[1] = Proportion variance
# variance[2] = Cumulative variance
```

### **Reliability Analysis**

**Cronbach's Alpha with CI**
```python
import pingouin as pg

reliability_results = []
for construct, items in constructs.items():
    construct_data = df[items]
    alpha = pg.cronbach_alpha(construct_data)
    # alpha[0] = coefficient
    # alpha[1] = (CI_lower, CI_upper)

    reliability_results.append({
        'Construct': construct,
        'Alpha': alpha[0],
        'CI_lower': alpha[1][0],
        'CI_upper': alpha[1][1]
    })
```

### **Confirmatory Factor Analysis**

**Model Specification (lavaan-style)**
```python
import semopy

model_spec = """
# Measurement model
PE =~ PE1 + PE2
EE =~ EE1 + EE2
BI =~ BI1 + BI2 + BI3 + BI4
"""

model = semopy.Model(model_spec)
results = model.fit(df_items)
```

**Fit Indices Extraction**
```python
fit_stats = semopy.calc_stats(model)

# Access indices
cfi = fit_stats.loc['CFI', 'Value']
tli = fit_stats.loc['TLI', 'Value']
rmsea = fit_stats.loc['RMSEA', 'Value']
srmr = fit_stats.loc['SRMR', 'Value']
aic = fit_stats.loc['AIC', 'Value']
```

**Parameter Estimates**
```python
estimates = model.inspect()

# Filter loadings
loadings = estimates[estimates['op'] == '~'].copy()
# lval = latent variable (construct)
# rval = observed variable (item)
# Estimate = standardized loading
```

### **Validity Assessment**

**Convergent Validity (CR and AVE)**
```python
# For each construct
construct_loadings = loadings[loadings['Construct'] == construct]['Loading'].values

# Composite Reliability
sum_loadings = np.sum(construct_loadings)
sum_sq_loadings = np.sum(construct_loadings ** 2)
sum_error_var = np.sum(1 - construct_loadings ** 2)
cr = (sum_loadings ** 2) / ((sum_loadings ** 2) + sum_error_var)

# Average Variance Extracted
ave = sum_sq_loadings / len(construct_loadings)
```

**Fornell-Larcker Criterion**
```python
# Create correlation matrix with sqrt(AVE) on diagonal
fl_matrix = construct_corr_matrix.copy()
for construct in constructs.keys():
    ave_value = validity_df[validity_df['Construct'] == construct]['AVE'].values[0]
    fl_matrix.loc[construct, construct] = np.sqrt(ave_value)

# Check: diagonal > off-diagonal values
```

**HTMT Ratio**
```python
# HTMT = Mean(heterotrait correlations) / GeometricMean(monotrait correlations)
for construct1 in constructs:
    for construct2 in constructs:
        # Heterotrait-heteromethod correlations
        hetero_corrs = [corr(item1, item2) for item1 in constructs[construct1]
                                            for item2 in constructs[construct2]]

        # Monotrait-heteromethod correlations
        mono_corrs1 = [corr(i, j) for i, j in combinations(constructs[construct1], 2)]
        mono_corrs2 = [corr(i, j) for i, j in combinations(constructs[construct2], 2)]

        htmt = np.mean(hetero_corrs) / np.sqrt(np.mean(mono_corrs1) * np.mean(mono_corrs2))
```

### **Structural Equation Modeling**

**Model Specification**
```python
# Structural paths
sem_model = """
# Measurement model
PE =~ PE1 + PE2
BI =~ BI1 + BI2 + BI3 + BI4

# Structural model
BI ~ PE + EE + SI
"""
```

**Model Comparison**
```python
# Fit competing models
model1 = semopy.Model(baseline_spec)
model1.fit(df)
fit1 = semopy.calc_stats(model1)

model2 = semopy.Model(extended_spec)
model2.fit(df)
fit2 = semopy.calc_stats(model2)

# Compare
delta_cfi = fit2.loc['CFI', 'Value'] - fit1.loc['CFI', 'Value']
delta_aic = fit1.loc['AIC', 'Value'] - fit2.loc['AIC', 'Value']
# Prefer model with higher CFI, lower AIC
```

---

## 🎓 Learning Integration

### **Bootstrap Learning Success Factors**

**Effective Knowledge Acquisition Pattern**
1. **Concrete Problem**: User had specific analysis need (AIRS validation)
2. **Iterative Problem-Solving**: SPSS failure → CSV → R → Python progression
3. **Contextual Learning**: Statistical theory + software implementation together
4. **Documentation-Driven**: Create comprehensive guides while implementing
5. **Validation Loop**: Test understanding through actual code execution

**Challenges Encountered and Resolved**
- **Package Versioning**: `factor_analyzer.__version__` not available → handled gracefully
- **Path Management**: Absolute paths prevent working directory issues
- **Data Structure Discovery**: Built inspection scripts before analysis implementation
- **Dual-Platform Strategy**: Maintained consistency between R and Python approaches

### **Cross-Domain Knowledge Transfer**

**From R to Python Translation Patterns**
| R Implementation | Python Equivalent | Key Differences |
|-----------------|-------------------|-----------------|
| `psych::fa()` | `FactorAnalyzer()` | Similar API, different rotation syntax |
| `lavaan::cfa()` | `semopy.Model()` | lavaan syntax works in semopy |
| `psych::alpha()` | `pg.cronbach_alpha()` | Pingouin returns CI automatically |
| `haven::read_sav()` | Manual CSV export | SPSS compatibility varies |
| `knitr::kable()` | `df.to_string()` | Different formatting approach |

**Unified Conceptual Understanding**
- Statistical procedures remain constant across platforms
- Software is implementation detail, methodology is core knowledge
- Choose tools based on user preference, team conventions, reproducibility needs

---

## 📊 Practical Applications

### **Research Workflow Integration**

**Dissertation/Manuscript Pipeline**
1. Data collection (Qualtrics/REDCap export)
2. Preprocessing (Python: attention checks, variable renaming, quality assessment)
3. Analysis (Jupyter notebook: complete psychometric validation)
4. Results export (CSV tables, PNG plots for manuscript figures)
5. Manuscript writing (cite analysis notebook for transparency)

**Reproducibility Best Practices**
- Version control (git) for analysis scripts
- Requirements.txt for exact package versions
- Seed setting for random processes (train/test splits, bootstrap)
- Full absolute paths in production notebooks
- Session info documentation (Python version, OS, package versions)

### **When to Use Python vs R for Psychometrics**

**Python Strengths**
- General-purpose programming (data pipelines, web scraping, automation)
- Machine learning integration (sklearn, tensorflow)
- Jupyter notebooks (narrative + code + output in single document)
- Deployment flexibility (web apps, APIs, containers)

**R Strengths**
- Specialized packages (lavaan SEM features, psych comprehensive reliability)
- Statistical depth (more options for robust estimation, handling non-normality)
- Academic adoption (reviewers may be more familiar)
- RMarkdown mature ecosystem (bookdown, blogdown, xaringan)

**Recommendation**: Choose based on team expertise and downstream needs. For pure statistical analysis, R often has more specialized options. For integrated data science workflows (scraping → analysis → deployment), Python excels.

---

## 🔗 Embedded Synapse Network

### **Primary Connections**
- [DK-SPSS-PSYCHOMETRIC-ANALYSIS-v1.0.0.md] (0.99, implements, bidirectional) - "Theoretical foundations translated into Python executable workflows"
- [bootstrap-learning.instructions.md] (0.95, exemplifies, forward) - "Complete domain mastery achieved through conversational knowledge acquisition"
- [empirical-validation.instructions.md] (0.93, applies, forward) - "Research-based statistical procedures with proper citations and thresholds"
- [DK-DOCUMENTATION-EXCELLENCE-v1.1.0.md] (0.91, demonstrates, forward) - "500+ line data dictionary and comprehensive notebook documentation"
- [DK-VISUAL-ARCHITECTURE-DESIGN-v0.9.9.md] (0.85, informs, forward) - "Notebook structure follows progressive disclosure and narrative clarity"

### **Secondary Connections**
- [DK-HUMAN-LEARNING-PSYCHOLOGY-v1.0.0.md] (0.82, informs, forward) - "Learning principles applied to statistical methodology acquisition"
- [alex-identity-integration.instructions.md] (0.78, enables, forward) - "Authentic Alex expertise development through systematic knowledge consolidation"
- [DK-MEMORY-CONSOLIDATION-v1.0.0.md] (0.88, achieves, bidirectional) - "Knowledge consolidation from working memory to permanent domain expertise"

### **Activation Patterns**
- **Python statistical analysis requested** → Apply expertise from this domain knowledge
- **Psychometric validation in Python** → Leverage factor-analyzer/semopy implementation patterns
- **Jupyter notebook development** → Follow structural best practices documented here
- **R to Python translation needed** → Use cross-platform equivalency tables
- **Reproducible research workflow** → Apply environment management and documentation standards

---

## 📝 Version History

**v1.0.0 - November 20, 2025** (UNILNILNILIUM)
- Initial domain knowledge creation following AIRS analysis implementation
- Complete psychometric validation pipeline documentation (EFA→CFA→SEM)
- Python library expertise (factor-analyzer, semopy, pingouin, scipy)
- Jupyter notebook best practices and structural patterns
- Environment management and reproducibility protocols
- Cross-platform R/Python equivalency documentation
- Bootstrap learning success case study integrated

---

## 🎯 Future Enhancement Opportunities

**Advanced Techniques to Explore**
- **Measurement invariance**: Multi-group CFA for demographic comparisons
- **Mediation analysis**: Indirect effects with bootstrap confidence intervals
- **Moderation analysis**: Interaction effects in SEM frameworks
- **Bayesian SEM**: Alternative to frequentist ML estimation
- **Mixture modeling**: Latent class analysis for heterogeneous populations

**Tool Expansion**
- **statsmodels**: GLM, time series, hypothesis testing
- **pymer4**: Mixed effects models (multilevel/hierarchical)
- **bambi**: Bayesian regression with intuitive syntax
- **graphviz**: Automated SEM path diagram generation
- **plotly**: Interactive visualizations for exploratory analysis

**Integration Opportunities**
- Machine learning prediction after construct validation
- Natural language processing for open-ended survey responses
- Network analysis for correlation structure visualization
- Dashboard development (Streamlit/Dash) for interactive reporting

---

*Python Statistical Analysis Domain Knowledge - Master-level psychometric validation implementation with comprehensive theoretical foundations and reproducible research workflows achieved through bootstrap learning methodology.*
