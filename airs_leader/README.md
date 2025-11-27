# AIRS Leader Sample Analysis

Analysis of the AIRS (AI Readiness Scale) for the **Leader** population (Managers + Executives).

## Population Definition

**Leader** = Respondents with employment status:
- Manager
- Executive

This population represents those in leadership positions who may have decision-making authority over AI adoption.

## Sample Sizes

| Dataset | N | Use |
|---------|---|-----|
| Development | 91 | EFA, model development |
| Holdout | 39 | CFA cross-validation |
| **Total** | **130** | |

## Analysis Notebooks

| Notebook | Purpose | Status |
|----------|---------|--------|
| `01_EFA_Leader_Sample.ipynb` | Exploratory Factor Analysis | Ready |
| `02_CFA_Leader_Sample.ipynb` | Confirmatory Factor Analysis | Pending |

## Notes

⚠️ **Sample Size Consideration**: With N=91 for development and 24 predictor items, the sample-to-item ratio is approximately 3.8:1. This is below the recommended 5:1 minimum for EFA. Results should be interpreted with caution and may require:

1. **Item reduction** based on EFA results
2. **Bootstrap estimation** in CFA for robust standard errors
3. **Cross-validation** with Academic/Professional samples

## Output Directories

- `data/` - Processed data files (dev/holdout splits)
- `plots/` - Visualization outputs
- `tables/` - Analysis tables and matrices
