# Analysis Notebooks

This directory contains Jupyter and R Markdown notebooks for data analysis.

## 📊 Contents

### Primary Analysis
**`AIRS_Analysis_Python.ipynb`** - Complete psychometric validation workflow
- **Language**: Python 3.12.7
- **Dependencies**: See `../requirements.txt`
- **Cells**: 63 total
- **Lines**: 1487

#### Analysis Pipeline
1. Data loading & preprocessing
2. Exploratory data analysis (EDA)
3. Sample splitting for cross-validation
4. Kaiser-Meyer-Olkin (KMO) test
5. Bartlett's test of sphericity
6. Exploratory Factor Analysis (EFA)
7. Confirmatory Factor Analysis (CFA)
8. Reliability assessment (α, CR, AVE)
9. Convergent validity
10. Discriminant validity (HTMT, Fornell-Larcker)
11. Multicollinearity (VIF)
12. Structural Equation Modeling (SEM)
13. Model comparison
14. Complete references (16 papers)

#### Key Results
- **KMO**: 0.917 ("Marvelous")
- **CFI**: 0.933 ✓
- **TLI**: 0.923 ✓
- **RMSEA**: 0.065 ✓
- **SRMR**: 0.057 ✓

### Alternative Analysis
**`AIRS_Analysis.Rmd`** - R Markdown analysis (optional)
- **Language**: R
- **Output**: HTML report in `../docs/`

---

## 🚀 Running the Analysis

### Python Notebook
```bash
# Activate virtual environment
.\venv\Scripts\Activate.ps1  # Windows
source venv/bin/activate      # macOS/Linux

# Launch Jupyter
jupyter notebook notebooks/AIRS_Analysis_Python.ipynb
```

### R Markdown
```r
# Render to HTML
rmarkdown::render('notebooks/AIRS_Analysis.Rmd')
```

---

## 📝 Notes

- **Data Location**: `../data/AIRS_clean.csv`
- **Results Output**: `../results/`
- **Documentation**: `../docs/DATA_DICTIONARY.md`

**Important**: Always run from repository root to maintain correct relative paths.
