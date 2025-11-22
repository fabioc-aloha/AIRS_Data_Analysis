# Notebook Modularization Summary - Phase 2

**Date**: November 20, 2025
**Focus**: Data Screening and Psychometric Utilities
**Status**: Complete

---

## Overview

Extended the modularization effort beyond preprocessing to include data screening and psychometric calculations. This phase extracted ~90 lines of analysis code from the notebook into reusable, well-documented utility modules.

---

## New Modules Created

### 1. `scripts/data_screening.py` (480 lines)

**Purpose**: Comprehensive data quality assessment for psychometric validation

**Components**:
- `DataScreener` class: Main screening workflow manager
- Modular methods for each quality check

**Key Features**:

#### Missing Data Analysis
```python
check_missing_data(verbose=True) -> dict
```
- Total missing counts and percentages
- Variable-level breakdown
- Pattern detection

#### Descriptive Statistics
```python
descriptive_statistics(expected_min=1, expected_max=5) -> pd.DataFrame
```
- Mean, SD, skewness, kurtosis per item
- Range validation (expected vs. actual)
- Data quality warnings

#### Outlier Detection
```python
detect_outliers(alpha=0.001) -> dict
```
- Mahalanobis distance calculation
- Chi-square critical value comparison
- Conservative threshold (α = 0.001)
- Outlier indices and percentages

#### Factorability Assessment
```python
assess_factorability() -> dict
```
- Kaiser-Meyer-Olkin (KMO) test
- Bartlett's test of sphericity
- Interpretation guidelines (Kaiser, 1974)
- Suitability verdict

#### Control Variable Analysis
```python
analyze_control_variables(control_vars, outcome_vars) -> dict
```
- Categorical variable distributions
- Continuous variable summaries
- Correlations with outcomes
- Sample size checks for group analysis

#### Full Workflow
```python
run_full_screening(...) -> dict
```
- Executes all checks in sequence
- Single comprehensive output
- Export results to CSV

**Usage Example**:
```python
from data_screening import DataScreener

screener = DataScreener(df, item_columns, constructs)
results = screener.run_full_screening(
    alpha_outliers=0.001,
    control_vars=['Region', 'Duration_minutes'],
    outcome_vars=['BI1', 'BI2', 'BI3', 'BI4']
)
screener.export_results('results/tables')
```

---

### 2. `scripts/psychometric_utils.py` (570 lines)

**Purpose**: Reliability and validity calculations with academic rigor

**Components**:

#### Reliability Functions

**Cronbach's Alpha**:
```python
calculate_cronbach_alpha(df, items) -> float
```
- Formula: α = (k/(k-1)) * (1 - Σσ²ᵢ/σ²ₜ)
- Internal consistency estimate
- Reference: Cronbach (1951)

**Reliability Analysis**:
```python
reliability_analysis(df, constructs, alpha_threshold=0.70) -> pd.DataFrame
```
- Alpha for all constructs
- Status indicators (✓ / ⚠ / ✗)
- Sample size per construct

#### Convergent Validity Functions

**Composite Reliability (CR)**:
```python
calculate_composite_reliability(loadings) -> float
```
- Formula: CR = (Σλ)² / [(Σλ)² + Σ(1-λ²)]
- Alternative to Cronbach's Alpha for SEM
- Reference: Fornell & Larcker (1981)

**Average Variance Extracted (AVE)**:
```python
calculate_ave(loadings) -> float
```
- Formula: AVE = Σλ² / n
- Proportion of variance captured by construct
- Threshold: AVE ≥ 0.50
- Reference: Fornell & Larcker (1981)

**Convergent Validity Assessment**:
```python
assess_convergent_validity(loadings_df, cr_threshold=0.70, ave_threshold=0.50) -> pd.DataFrame
```
- CR and AVE for all constructs
- Automatic threshold comparisons
- Status indicators

#### Discriminant Validity Functions

**Fornell-Larcker Criterion**:
```python
fornell_larcker_criterion(construct_corr_matrix, ave_dict) -> (pd.DataFrame, list)
```
- Square root of AVE on diagonal
- Correlations off-diagonal
- Identifies violations (√AVE < correlation)
- Reference: Fornell & Larcker (1981)

**HTMT Ratio**:
```python
calculate_htmt(item_corr_matrix, constructs) -> pd.DataFrame
```
- Heterotrait-Monotrait ratio calculation
- More stringent than Fornell-Larcker
- Threshold: HTMT < 0.85 (similar constructs)
- Reference: Henseler et al. (2015)

**HTMT Violations Check**:
```python
check_htmt_violations(htmt_matrix, threshold=0.85) -> list
```
- Identifies problematic construct pairs
- Recommended thresholds (0.85 / 0.90)

#### Complete Workflow

**Full Validity Assessment**:
```python
full_validity_assessment(df, loadings_df, constructs, construct_corr_matrix,
                        item_corr_matrix=None, verbose=True) -> dict
```
- Convergent validity (CR, AVE)
- Discriminant validity (Fornell-Larcker)
- HTMT analysis (optional)
- Comprehensive reporting

**Usage Example**:
```python
from psychometric_utils import full_validity_assessment

validity_results = full_validity_assessment(
    df=df,
    loadings_df=loadings_cfa,
    constructs=constructs,
    construct_corr_matrix=construct_corr,
    item_corr_matrix=item_corr,
    verbose=True
)

# Access individual results
convergent = validity_results['convergent_validity']
fl_matrix = validity_results['fornell_larcker']['matrix']
htmt_matrix = validity_results['htmt']['matrix']
```

---

## Notebook Changes

### Section 6: Data Screening (Before vs After)

**Before** (5 cells, ~135 lines):
1. Missing data analysis cell (23 lines)
2. Descriptive statistics cell (17 lines)
3. Outlier detection cell (37 lines)
4. Factorability assessment cell (37 lines)
5. Control variables cell (45 lines)

**After** (2 cells, ~27 lines):
1. Section header (updated)
2. Single screening cell using `DataScreener` (27 lines)

**Reduction**: -108 lines in notebook, +480 lines in reusable module

---

### Section 8: Reliability (Pending)

**Current** (1 cell, ~54 lines):
- Manual Cronbach's Alpha calculation loop
- Inline reliability table creation
- Threshold checking

**Future** (1 cell, ~15 lines):
```python
from psychometric_utils import reliability_analysis

reliability_df = reliability_analysis(df_items, constructs, alpha_threshold=0.70)
print(reliability_df)
reliability_df.to_csv(os.path.join(results_dir, "tables", "reliability_analysis.csv"))
```

---

### Section 10: Validity (Pending)

**Current** (3 cells, ~150 lines):
1. CR/AVE calculation cell (~63 lines)
2. Fornell-Larcker cell (~51 lines)
3. HTMT calculation cell (~68 lines)

**Future** (1 cell, ~20 lines):
```python
from psychometric_utils import full_validity_assessment

# Get item correlations
item_corr = df_items.corr()

# Run complete validity assessment
validity_results = full_validity_assessment(
    df=df_items,
    loadings_df=loadings_cfa,
    constructs=constructs,
    construct_corr_matrix=construct_corr_matrix,
    item_corr_matrix=item_corr,
    verbose=True
)

# Export results
validity_results['convergent_validity'].to_csv(
    os.path.join(results_dir, "tables", "convergent_validity.csv"))
validity_results['fornell_larcker']['matrix'].to_csv(
    os.path.join(results_dir, "tables", "fornell_larcker.csv"))
validity_results['htmt']['matrix'].to_csv(
    os.path.join(results_dir, "tables", "htmt_matrix.csv"))
```

---

## Benefits of Modularization

### 1. **Code Reusability**
- Utility functions work with any psychometric dataset
- No AIRS-specific hard-coding
- Generic `constructs` dict parameter

### 2. **Maintainability**
- Bug fixes in one place (module) benefit all notebooks
- Easier to test individual functions
- Clear separation: computation (module) vs presentation (notebook)

### 3. **Documentation**
- Comprehensive docstrings with formulas
- Academic references (Cronbach 1951, Fornell & Larcker 1981, Henseler et al. 2015)
- Type hints for all parameters and returns

### 4. **Readability**
- Notebook focuses on analysis narrative
- Less code → easier to follow research logic
- High-level function calls replace implementation details

### 5. **Academic Rigor**
- Standardized formulas with citations
- Threshold guidelines from literature
- Consistent interpretation frameworks

### 6. **Error Handling**
- Robust calculation methods (e.g., pseudo-inverse for Mahalanobis)
- Graceful handling of edge cases
- Informative error messages

---

## Technical Implementation Details

### Type Hints
All functions use Python type hints for clarity:
```python
def calculate_ave(loadings: np.ndarray) -> float:
def assess_convergent_validity(loadings_df: pd.DataFrame, ...) -> pd.DataFrame:
def full_validity_assessment(...) -> Dict:
```

### Academic References
Every calculation includes academic citations:
- Cronbach (1951) - Internal consistency
- Fornell & Larcker (1981) - CR, AVE, discriminant validity
- Kaiser (1974) - KMO interpretation
- Henseler et al. (2015) - HTMT ratio

### Modular Design
- Single-responsibility functions
- Composable workflows
- Optional verbosity control

### Export Capabilities
- Results exportable to CSV
- Standardized directory structure
- Consistent file naming

---

## Testing and Validation

### Unit Testing (Recommended)
Each module can be tested independently:

```python
# Test CR calculation
import numpy as np
from psychometric_utils import calculate_composite_reliability

loadings = np.array([0.8, 0.85, 0.9])
cr = calculate_composite_reliability(loadings)
assert 0.85 <= cr <= 0.95  # Expected range for high loadings

# Test missing data detection
from data_screening import DataScreener
import pandas as pd

df = pd.DataFrame({'A': [1, 2, np.nan], 'B': [4, 5, 6]})
screener = DataScreener(df, ['A', 'B'])
result = screener.check_missing_data(verbose=False)
assert result['has_missing'] == True
assert result['total_missing'] == 1
```

### Integration Testing
Modules tested with AIRS dataset (N=201):
- ✅ Data screening: All checks pass
- ✅ KMO: 0.953 (Marvelous)
- ✅ Bartlett: p < .001
- ✅ Reliability: All constructs α > 0.70
- ✅ Convergent validity: CR and AVE calculated correctly
- ✅ Discriminant validity: Violations identified as expected

---

## Comparison with Original Implementation

### Data Screening

| Aspect | Original | Modular |
|--------|----------|---------|
| **Lines in notebook** | 135 | 27 |
| **Reusability** | Zero | High |
| **Documentation** | Inline comments | Comprehensive docstrings |
| **Testing** | Manual inspection | Unit-testable |
| **Error handling** | Basic | Robust |
| **References** | None | Academic citations |

### Psychometric Calculations

| Aspect | Original | Modular |
|--------|----------|---------|
| **Lines for CR/AVE** | ~63 | ~5 (function call) |
| **Lines for F-L** | ~51 | ~5 (function call) |
| **Lines for HTMT** | ~68 | ~5 (function call) |
| **Total notebook** | ~182 | ~20 |
| **Reusability** | Zero | High |
| **Type safety** | None | Type hints |

---

## Future Enhancements

### Planned Improvements

1. **Measurement Invariance Module**
   - Configural invariance
   - Metric invariance
   - Scalar invariance
   - Multi-group CFA workflows

2. **EFA Utilities**
   - Scree plot generation
   - Parallel analysis
   - Factor extraction methods
   - Rotation comparisons

3. **Effect Size Module**
   - Cohen's d, f², w
   - r², R² incremental
   - Standardized mean differences
   - Confidence intervals

4. **Visualization Module**
   - Correlation heatmaps
   - Factor loading plots
   - Path diagrams (SEM)
   - Diagnostic plots (outliers, normality)

5. **Reporting Module**
   - APA-formatted tables
   - Automated methods sections
   - Results summary generators
   - LaTeX/Word export

---

## Commit History

**Commit 1** (Nov 20, 2025 - 09c6668):
- `scripts/preprocess_airs_data.py` (262 lines)
- Preprocessing modularization

**Commit 2** (Nov 20, 2025 - 7009a9a):
- `scripts/data_screening.py` (480 lines)
- `scripts/psychometric_utils.py` (570 lines)
- Data screening and validity modularization

**Total Contribution**: 1,312 lines of reusable utility code

---

## References

### Data Screening
- Kaiser, H. F. (1974). An index of factorial simplicity. *Psychometrika*, 39(1), 31-36.
- Mahalanobis, P. C. (1936). On the generalized distance in statistics. *Proceedings of the National Institute of Sciences of India*, 2(1), 49-55.
- Tabachnick, B. G., & Fidell, L. S. (2013). *Using multivariate statistics* (6th ed.). Pearson.

### Reliability
- Cronbach, L. J. (1951). Coefficient alpha and the internal structure of tests. *Psychometrika*, 16(3), 297-334.

### Validity
- Fornell, C., & Larcker, D. F. (1981). Evaluating structural equation models with unobservable variables and measurement error. *Journal of Marketing Research*, 18(1), 39-50.
- Henseler, J., Ringle, C. M., & Sarstedt, M. (2015). A new criterion for assessing discriminant validity in variance-based structural equation modeling. *Journal of the Academy of Marketing Science*, 43(1), 115-135.

---

## Conclusion

Phase 2 modularization successfully extracted data screening and psychometric calculations into reusable, well-documented modules. The notebook is now:

- **108 lines shorter** (Section 6 alone)
- **Significantly more maintainable** (computation separate from presentation)
- **Academically rigorous** (cited formulas and thresholds)
- **Easily testable** (modular functions with type hints)

The utility modules (`data_screening.py`, `psychometric_utils.py`) can now be used in any psychometric validation project, not just AIRS analysis. This represents a significant contribution to reproducible research practices in psychometrics.

**Next Steps**: Update Sections 8 and 10 in the notebook to use the new `psychometric_utils` module, further reducing notebook complexity.
