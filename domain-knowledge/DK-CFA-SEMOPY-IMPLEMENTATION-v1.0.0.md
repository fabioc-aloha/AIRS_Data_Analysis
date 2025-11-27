# Domain Knowledge: CFA Implementation with semopy
**Version**: 1.0.0 UNNILNILNILIUM
**Domain**: Confirmatory Factor Analysis with Python semopy library
**Acquisition Date**: November 26, 2025
**Acquisition Method**: Hands-on implementation across three populations with iterative debugging

---

## Core Competency Summary

Mastery of confirmatory factor analysis (CFA) implementation using semopy for psychometric scale validation, including model specification, fit assessment, reliability calculation, and bootstrap estimation for small samples.

---

## Technical Knowledge

### Model Specification Syntax
```python
# CFA model with correlated factors
model_syntax = """
Facilitators =~ PE1 + PE2 + EE1 + EE2 + SI1 + SI2 + ...
Inhibitors =~ VO2 + ER1 + ER2 + AX2
Facilitators ~~ Inhibitors
"""
model = Model(model_syntax)
model.fit(data)
```

### Critical API Details (semopy 2.3.11)

**Standardized Estimates**:
```python
# Column name is 'Est. Std' NOT 'Std. Est'
estimates = model.inspect(std_est=True)
std_loading = estimates['Est. Std']
```

**Fit Statistics Structure**:
```python
from semopy import calc_stats
fit_stats = calc_stats(model)
# Stats are COLUMNS with 'Value' as index row
cfi = fit_stats['CFI'].iloc[0]  # NOT fit_stats.loc['CFI']
rmsea = fit_stats['RMSEA'].iloc[0]
```

**Loading Extraction**:
```python
# CFA uses lval=Item, rval=Factor
loadings = estimates[estimates['op'] == '~']
# lval contains item names, rval contains factor names
item_name = row['lval']
factor_name = row['rval']
```

**p-value Handling**:
```python
# Fixed parameters have '-' as p-value string
def get_significance(p):
    if isinstance(p, str) or pd.isna(p):
        return ''  # Fixed parameter
    elif p < 0.001:
        return '***'
    elif p < 0.01:
        return '**'
    elif p < 0.05:
        return '*'
    return ''
```

### Reliability Calculations

**Composite Reliability (CR)**:
```python
def composite_reliability(loadings):
    sum_loadings = loadings.sum()
    sum_loadings_sq = (loadings ** 2).sum()
    error_var = 1 - loadings ** 2
    sum_error = error_var.sum()
    CR = (sum_loadings ** 2) / (sum_loadings ** 2 + sum_error)
    return CR
```

**Average Variance Extracted (AVE)**:
```python
def average_variance_extracted(loadings):
    return (loadings ** 2).mean()
```

**Thresholds**:
- CR ≥ 0.70 (acceptable), ≥ 0.80 (good)
- AVE ≥ 0.50 (convergent validity)
- Discriminant validity: r² < min(AVE₁, AVE₂)

### Model Fit Interpretation

| Index | Good | Acceptable | Poor |
|-------|------|------------|------|
| CFI | ≥ 0.95 | ≥ 0.90 | < 0.90 |
| TLI | ≥ 0.95 | ≥ 0.90 | < 0.90 |
| RMSEA | ≤ 0.06 | ≤ 0.08 | > 0.08 |
| SRMR | ≤ 0.08 | ≤ 0.10 | > 0.10 |
| χ²/df | < 2.0 | < 3.0 | ≥ 3.0 |

### Bootstrap CFA for Small Samples

**When Required**: N < 100, especially N < 75

```python
n_bootstrap = 500
bootstrap_results = []

for i in range(n_bootstrap):
    boot_sample = data.sample(n=len(data), replace=True)
    boot_model = Model(model_syntax)
    try:
        boot_model.fit(boot_sample)
        boot_loadings = boot_model.inspect(std_est=True)
        bootstrap_results.append(boot_loadings)
    except:
        continue  # Skip failed iterations

# Calculate bootstrap CIs
loadings_array = np.array([r['Est. Std'] for r in bootstrap_results])
ci_lower = np.percentile(loadings_array, 2.5, axis=0)
ci_upper = np.percentile(loadings_array, 97.5, axis=0)
```

**Interpretation Caution**:
- Bootstrap with N < 60 shows high variability
- Focus on whether CI excludes zero rather than exact values
- Extreme SEs indicate factor instability

---

## Cross-Population Insights

### Consistent Findings (AIRS Study)

| Pattern | Full (N=255) | Professional (N=146) | Academic (N=59) |
|---------|--------------|----------------------|-----------------|
| 2-factor structure | ✓ | ✓ | ✓ |
| Facilitators reliable | CR=0.957 | CR=0.966 | CR=0.897 |
| Inhibitors problematic | CR=0.625 | CR=0.662 | CR=0.001 |
| Poor model fit | CFI=0.824 | CFI=0.866 | CFI=0.697 |

### Problem Items Across Populations
- **VO2** (voluntariness negative): λ < 0.20 consistently
- **AX2** (anxiety): λ < 0.25, often negative sign
- **SI2** (social influence): λ < 0.10 in Academic
- **ER1, ER2** (effort regulation): Unstable loadings

### Sample Size Guidelines
- N:parameter ratio ≥ 5:1 preferred, 10:1 ideal
- Minimum N = 100 for stable ML estimation
- N < 75: Use bootstrap or Bayesian estimation
- Academic sample (N=59) at limits - results exploratory

---

## Workflow Pattern: EFA → CFA Pipeline

1. **Split samples** (50/50 or 70/30 for small N)
2. **EFA on development sample** → Extract factor structure
3. **Save EFA solution** (JSON with items per factor)
4. **CFA on holdout sample** → Test hypothesized structure
5. **Assess fit and reliability** → Identify problem items
6. **Model optimization** → Remove weak items, test alternative models
7. **Final CFA** → Validate optimized model

---

## Embedded Synapse Network

### Connections
- [DK-PYTHON-STATISTICAL-ANALYSIS-v1.0.0.md] (0.95, extends, forward) - "CFA expertise builds on Python statistical analysis foundation"
- [DK-JUPYTER-PSYCHOMETRIC-WORKFLOWS-v1.0.0.md] (0.97, complements, bidirectional) - "CFA validation integrates with EFA→CFA→SEM pipeline"
- [DK-PSYCHOMETRIC-VALIDATION-v1.0.0.md] (0.98, implements, forward) - "CFA provides convergent and discriminant validity assessment"
- [DK-CFA-VALIDATION-EXCELLENCE-v1.0.0.md] (0.92, enhances, bidirectional) - "Technical implementation supports validation excellence"
- [bootstrap-learning.instructions.md] (0.85, demonstrates, forward) - "CFA mastery acquired through iterative debugging and hands-on learning"

### Activation Patterns
- **CFA model specification needed** → Apply semopy syntax patterns
- **Fit statistics extraction fails** → Check column vs index structure
- **Standardized loadings unavailable** → Use 'Est. Std' column name
- **Small sample CFA required** → Implement bootstrap estimation
- **Cross-population validation** → Apply consistent workflow per population

---

*Domain knowledge acquired through AIRS Phase 2 CFA implementation - November 26, 2025*
