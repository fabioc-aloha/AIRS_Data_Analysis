# Notebook 11: Practitioner Typology Classification

## Executive Summary

**Problem**: The original AIRS typology uses 6 constructs (PE, EE, TR, HB, AX, BI), but practitioners administering the validated AIRS-16 scale only have access to 8 constructs (PE, EE, SI, FC, HM, PV, HB, TR). Neither AX nor BI are available in practice.

**Solution**: Develop a new practitioner-focused typology using only AIRS-16 constructs that can **predict** Behavioral Intention (BI) without measuring it directly.

**Deliverable**: A diagnostic classification tool that takes AIRS-16 responses and outputs:
1. User typology assignment
2. Predicted BI level
3. Intervention recommendations

---

## Background

### Original Typology (Notebook 09)

| Cluster | n | % | Key Differentiators |
|---------|---|---|---------------------|
| AI Enthusiasts | 84 | 16% | High PE, TR, BI; Low AX |
| Cautious Adopters | 157 | 30% | High PE, EE; High AX |
| Moderate Users | 191 | 37% | Average all; Neutral BI |
| Anxious Avoiders | 91 | 17% | Low PE, TR, BI; High AX |

**Constructs Used**: PE, EE, TR, HB, AX, BI (6 total)

**Limitation**: AX and BI are not part of the validated AIRS-16 scale:
- **AX**: Dropped due to α = .301 (inadequate reliability)
- **BI**: Outcome variable, measured separately

### AIRS-16 Validated Scale

| Construct | Full Name | Items | Available? |
|-----------|-----------|-------|------------|
| PE | Performance Expectancy | PE1, PE2 | ✓ Yes |
| EE | Effort Expectancy | EE1, EE2 | ✓ Yes |
| SI | Social Influence | SI1, SI2 | ✓ Yes |
| FC | Facilitating Conditions | FC1, FC2 | ✓ Yes |
| HM | Hedonic Motivation | HM1, HM2 | ✓ Yes |
| PV | Price Value | PV1, PV2 | ✓ Yes |
| HB | Habit | HB1, HB2 | ✓ Yes |
| TR | Trust in AI | TR1, TR2 | ✓ Yes |

**Total**: 16 items across 8 constructs

---

## Research Questions

1. **RQ1**: Can we identify meaningful user typologies using only AIRS-16 constructs?
2. **RQ2**: Do these typologies differ significantly in their Behavioral Intention (BI)?
3. **RQ3**: How accurately can we predict BI from AIRS-16 construct profiles?
4. **RQ4**: What is the concordance between the new practitioner typology and the original research typology?

---

## Methodology

### Phase 1: Data Preparation & Exploratory Analysis

**Objective**: Understand the relationship between AIRS-16 constructs and BI

#### 1.1 Data Loading
```python
# Load AIRS_clean.csv (523 rows × 41 columns)
# Construct scores NOT pre-computed - must calculate from items
constructs_airs16 = ['PE', 'EE', 'SI', 'FC', 'HM', 'PV', 'HB', 'TR']
outcome = 'BI'

# Compute construct means (2 items each for AIRS-16, 4 items for BI)
for c in constructs_airs16:
    df[c] = df[[f'{c}1', f'{c}2']].mean(axis=1)
df['BI'] = df[['BI1', 'BI2', 'BI3', 'BI4']].mean(axis=1)
```

**Data Verified** (Dec 13, 2025):
- All 16 AIRS items present (PE1-2, EE1-2, SI1-2, FC1-2, HM1-2, PV1-2, HB1-2, TR1-2)
- All 4 BI items present (BI1-4)
- Data type: int64, Likert scale 1-5
- Missing values: None in construct items

#### 1.2 Correlation Analysis
- Pearson correlations: AIRS-16 constructs ↔ BI
- Identify strongest BI predictors
- Check for multicollinearity among predictors

#### 1.3 Descriptive Statistics
- Means, SDs, ranges for all 9 constructs
- Distribution shapes (normality check)
- Missing data assessment

**Expected Output**: Correlation heatmap, descriptive table

---

### Phase 2: Cluster Analysis (8-Construct Solution)

**Objective**: Derive new typology using AIRS-16 constructs only

#### 2.1 Data Preparation
```python
# Select AIRS-16 constructs only (not BI)
X = df[['PE', 'EE', 'SI', 'FC', 'HM', 'PV', 'HB', 'TR']]

# Standardize using StandardScaler
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)
```

#### 2.2 Optimal Cluster Determination
- **Elbow Method**: Plot inertia vs. k (k = 2-8)
- **Silhouette Analysis**: Calculate silhouette scores for each k
- **Gap Statistic** (optional): Compare to null reference distribution

```python
# Test k = 2 to 8
for k in range(2, 9):
    kmeans = KMeans(n_clusters=k, random_state=67, n_init=10)
    labels = kmeans.fit_predict(X_scaled)
    silhouette = silhouette_score(X_scaled, labels)
```

#### 2.3 Cluster Profiling
- Calculate cluster centroids (standardized z-scores)
- Calculate cluster means (raw scores)
- Name clusters based on dominant characteristics

#### 2.4 External Validation with BI
- Calculate mean BI for each cluster
- ANOVA: Test if clusters differ on BI (F-test)
- Effect size: η² (eta-squared)

**Expected Output**:
- Optimal k determination plots
- Cluster profiles table
- BI by cluster comparison

---

### Phase 3: Predictive Modeling

**Objective**: Validate that AIRS-16 profiles can predict BI

#### 3.1 Regression Analysis
```python
# Multiple regression: AIRS-16 → BI
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import cross_val_score

model = LinearRegression()
X = df[constructs_airs16]
y = df['BI']
scores = cross_val_score(model, X, y, cv=5, scoring='r2')
```

**Metrics**:
- R² (variance explained)
- Adjusted R²
- RMSE (Root Mean Square Error)
- Cross-validated R²

#### 3.2 Feature Importance
- Standardized beta coefficients
- Relative importance of each construct
- Identify "diagnostic" constructs

#### 3.3 Cluster-Based BI Prediction
- Use cluster membership to predict BI
- Compare: Regression R² vs. Cluster-based R²
- Assess which approach is more practical

**Expected Output**:
- Regression coefficients table
- Feature importance plot
- Prediction accuracy comparison

---

### Phase 4: Diagnostic Tool Development

**Objective**: Create practical classification tool for practitioners

#### 4.1 Centroid Calculation
```python
# Store centroids for each cluster
centroids = {}
for cluster_name, cluster_id in cluster_mapping.items():
    mask = df['Cluster'] == cluster_id
    centroids[cluster_name] = {
        'z_scores': cluster_means_z.loc[cluster_id].values,
        'raw_means': cluster_means_raw.loc[cluster_id].values,
        'expected_BI': df.loc[mask, 'BI'].mean(),
        'n': mask.sum()
    }
```

#### 4.2 Classification Function
```python
def classify_airs16_typology(pe, ee, si, fc, hm, pv, hb, tr):
    """
    Classify respondent using AIRS-16 constructs.

    Returns:
        - typology: Cluster name
        - predicted_BI: Expected BI based on cluster
        - confidence: Distance-based confidence score
        - recommendations: Intervention suggestions
    """
    # Standardize inputs
    # Calculate Euclidean distance to each centroid
    # Return nearest cluster + predicted BI
```

#### 4.3 Decision Rules (Heuristic Version)
- Simple if-then rules for quick classification
- Based on threshold cutoffs
- Trade-off: Simplicity vs. accuracy

#### 4.4 Population Parameters
```python
# Store for practitioners
POP_MEANS = {
    'PE': 3.48, 'EE': 3.72, 'SI': X.XX, 'FC': X.XX,
    'HM': X.XX, 'PV': X.XX, 'HB': 3.06, 'TR': 3.26
}
POP_SDS = {
    'PE': 1.15, 'EE': 0.97, 'SI': X.XX, 'FC': X.XX,
    'HM': X.XX, 'PV': X.XX, 'HB': 1.20, 'TR': 1.09
}
```

**Expected Output**:
- Centroid table (z-scores and raw)
- Python classification function
- Decision rules flowchart
- Population parameters table

---

### Phase 5: Comparison with Original Typology

**Objective**: Assess concordance and trade-offs

#### 5.1 Cross-Tabulation
```python
# Compare original 6-construct clusters with new 8-construct clusters
pd.crosstab(df['Original_Cluster'], df['New_Cluster'],
            margins=True, normalize='index')
```

#### 5.2 Concordance Metrics
- **Cohen's Kappa**: Agreement beyond chance
- **Adjusted Rand Index**: Clustering similarity
- **Percentage Agreement**: Simple overlap

#### 5.3 Trade-off Analysis
| Aspect | Original (6-construct) | Practitioner (8-construct) |
|--------|------------------------|---------------------------|
| Constructs | PE, EE, TR, HB, AX, BI | PE, EE, SI, FC, HM, PV, HB, TR |
| BI Required | Yes (as clustering var) | No (predicted) |
| AX Required | Yes | No |
| Practical Use | Research only | Field deployment |
| Precision | Higher | Lower (but sufficient) |

**Expected Output**:
- Cross-tabulation matrix
- Concordance statistics
- Trade-off summary table

---

## Expected Deliverables

### Tables
1. **Table 11.1**: Correlation Matrix (AIRS-16 + BI)
2. **Table 11.2**: Cluster Determination Metrics (k=2-8)
3. **Table 11.3**: Practitioner Typology Profiles (8-construct centroids)
4. **Table 11.4**: BI by Cluster (means, SDs, ANOVA results)
5. **Table 11.5**: Regression Coefficients (AIRS-16 → BI)
6. **Table 11.6**: Classification Method Comparison
7. **Table 11.7**: Cross-tabulation (Original vs. Practitioner Typology)

### Figures
1. **Figure 11.1**: Correlation Heatmap (AIRS-16 + BI)
2. **Figure 11.2**: Elbow Plot + Silhouette Scores
3. **Figure 11.3**: Cluster Profiles (8-construct bar chart)
4. **Figure 11.4**: BI Distribution by Cluster (boxplot)
5. **Figure 11.5**: Feature Importance (regression coefficients)
6. **Figure 11.6**: Classification Decision Flowchart (Mermaid)
7. **Figure 11.7**: Sankey Diagram (Original → Practitioner cluster flow)

### Code Artifacts
1. `classify_airs16_typology()` - Main classification function
2. `predict_bi_from_cluster()` - BI prediction based on cluster
3. `quick_screen_typology()` - Decision rule-based screening
4. Population parameters (means, SDs, centroids)

### Export Files
- `results/phase11_practitioner_typology_results.json`
- `tables/Table_11.X_*.md` (all tables in markdown)
- `plots/11_*.png` (all figures)

---

## Success Criteria

| Metric | Target | Rationale | Citation |
|--------|--------|-----------|----------|
| Silhouette Score | > 0.25 | Scores near +1 indicate good separation; 0 indicates boundary overlap; negative indicates misassignment | Rousseeuw (1987); scikit-learn documentation |
| BI ANOVA F-test | p < .001 | Clusters differ significantly on outcome | Standard inferential threshold |
| BI η² (effect size) | > 0.14 | Large effect per Cohen's conventions (η²: .01=small, .06=medium, .14=large) | Cohen (1988) |
| Regression R² | > 0.40 | Meaningful prediction; η² for regression: .02=small, .13=medium, .26=large | Cohen (1988); Murphy & Myors (2004) |
| Concordance (Kappa) | > 0.40 | Moderate agreement; Landis & Koch: .41-.60=moderate, .61-.80=substantial | Landis & Koch (1977); Fleiss (1981) |

**Note on Kappa Interpretation**: Landis & Koch (1977) thresholds (.41-.60=moderate) are widely cited but considered arbitrary. Fleiss (1981) suggests κ > .75 = excellent, .40-.75 = fair to good, < .40 = poor. Context matters more than rigid cutoffs (Bakeman et al., 1997).

---

## Notebook Structure

```
11_Practitioner_Typology.ipynb
├── 1. Setup & Data Loading
├── 2. Exploratory Analysis
│   ├── 2.1 Descriptive Statistics
│   ├── 2.2 Correlation Analysis
│   └── 2.3 BI Predictor Identification
├── 3. Cluster Analysis
│   ├── 3.1 Optimal k Determination
│   ├── 3.2 K-Means Clustering (k=4)
│   ├── 3.3 Cluster Profiling
│   └── 3.4 Cluster Naming
├── 4. Predictive Validation
│   ├── 4.1 BI by Cluster (ANOVA)
│   ├── 4.2 Regression Analysis
│   └── 4.3 Cross-Validation
├── 5. Diagnostic Tool Development
│   ├── 5.1 Centroid Calculation
│   ├── 5.2 Classification Function
│   ├── 5.3 Decision Rules
│   └── 5.4 BI Prediction Function
├── 6. Comparison with Original Typology
│   ├── 6.1 Cross-Tabulation
│   ├── 6.2 Concordance Analysis
│   └── 6.3 Trade-off Summary
├── 7. Results Export
└── 8. Summary & Recommendations
```

---

## Dependencies

```python
# Core
import pandas as pd
import numpy as np

# Visualization
import matplotlib.pyplot as plt
import seaborn as sns

# Machine Learning
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import silhouette_score, silhouette_samples
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import cross_val_score

# Statistics
from scipy import stats
from scipy.stats import f_oneway

# Clustering Comparison
from sklearn.metrics import adjusted_rand_score, cohen_kappa_score
```

---

## Timeline Estimate

| Phase | Cells | Estimated Time |
|-------|-------|----------------|
| Phase 1: Exploratory | 3-4 | 15 min |
| Phase 2: Clustering | 4-5 | 20 min |
| Phase 3: Prediction | 3-4 | 15 min |
| Phase 4: Tool Dev | 4-5 | 20 min |
| Phase 5: Comparison | 3-4 | 15 min |
| Export & Summary | 2-3 | 10 min |
| **Total** | ~20-25 | ~1.5 hours |

---

## Next Steps

1. ✅ Plan document created
2. ✅ Data format verified (Dec 13, 2025)
3. ✅ Notebook 11 skeleton created
4. ⬜ Execute Phase 1 (Exploratory)
5. ⬜ Execute Phase 2 (Clustering)
6. ⬜ Execute Phase 3 (Prediction)
7. ⬜ Execute Phase 4 (Tool Development)
8. ⬜ Execute Phase 5 (Comparison)
9. ⬜ Export results and update documentation

---

## Scholarly References

### Clustering Methodology

- **Cohen, J. (1988)**. *Statistical power analysis for the behavioral sciences* (2nd ed.). Lawrence Erlbaum Associates. [Effect size conventions: η² .01=small, .06=medium, .14=large]
- **Rousseeuw, P. J. (1987)**. Silhouettes: A graphical aid to the interpretation and validation of cluster analysis. *Journal of Computational and Applied Mathematics*, 20, 53-65.
- **scikit-learn documentation**. Selecting the number of clusters with silhouette analysis on KMeans clustering. [Silhouette scores range -1 to +1; near +1 = well-separated]

### Agreement Metrics

- **Landis, J. R., & Koch, G. G. (1977)**. The measurement of observer agreement for categorical data. *Biometrics*, 33(1), 159-174. [κ interpretation: <0=poor, .01-.20=slight, .21-.40=fair, .41-.60=moderate, .61-.80=substantial, .81-1.0=almost perfect]
- **Fleiss, J. L. (1981)**. *Statistical methods for rates and proportions* (2nd ed.). Wiley. [κ: >.75=excellent, .40-.75=fair-good, <.40=poor]
- **Bakeman, R., Quera, V., McArthur, D., & Robinson, B. F. (1997)**. Detecting sequential patterns and determining their reliability with fallible observers. *Psychological Methods*, 2(4), 357-370. [No universal κ threshold; context-dependent]

### Effect Sizes

- **Murphy, K. R., & Myors, B. (2004)**. *Statistical power analysis: A simple and general model for traditional and modern hypothesis tests* (2nd ed.). Lawrence Erlbaum. [Alternative η² thresholds]
- **MRC CBU Cambridge (2021)**. Rules of thumb on magnitudes of effect sizes. [η² for ANOVA: .01=small, .06=medium, .14=large]

---

*Plan created: December 13, 2025*
*Fact-checked: December 13, 2025*
*Source: AIRS Research Project*
