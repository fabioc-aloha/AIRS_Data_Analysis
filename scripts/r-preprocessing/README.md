# R Preprocessing Scripts

This directory contains R scripts for initial data exploration and preprocessing.

## 📄 Scripts

### Setup & Environment
**`setup_environment.R`** - Configure R environment and install required packages
```r
# Installs and loads:
# - tidyverse
# - psych
# - lavaan
# - readr
# - haven (for SPSS files)
```

### Data Inspection
**`inspect_data.R`** - Initial data exploration
- Load raw survey data
- Examine structure and types
- Identify missing data patterns
- Generate summary statistics

**`analyze_csv_structure.R`** - Detailed structural analysis
- Column data types
- Value ranges
- Unique values per variable
- Data quality checks

### Data Processing
**`preprocess_data.R`** - Main preprocessing pipeline
- Variable renaming (descriptive → codes)
- Attention check validation
- Numeric conversion
- Missing data handling
- Export cleaned dataset

**`create_variable_mapping.R`** - Generate variable documentation
- Create mapping tables
- Document transformations
- Generate codebook

---

## 🔄 Workflow

Run scripts in this order:

```r
# 1. Setup environment
source('scripts/r-preprocessing/setup_environment.R')

# 2. Inspect raw data
source('scripts/r-preprocessing/inspect_data.R')

# 3. Analyze structure
source('scripts/r-preprocessing/analyze_csv_structure.R')

# 4. Preprocess data
source('scripts/r-preprocessing/preprocess_data.R')

# 5. Create documentation
source('scripts/r-preprocessing/create_variable_mapping.R')
```

---

## 📊 Input/Output

**Input**: `../../data/AIRS---AI-Readiness-Scale.csv` (raw data)

**Output**: `../../data/AIRS_clean.csv` (cleaned data)

**Note**: These scripts prepare data for the main Python analysis in `../../notebooks/AIRS_Analysis_Python.ipynb`

---

## 🔧 Dependencies

See `setup_environment.R` for complete package list. Core dependencies:
- `tidyverse` 2.0+
- `psych` 2.3+
- `haven` 2.5+
