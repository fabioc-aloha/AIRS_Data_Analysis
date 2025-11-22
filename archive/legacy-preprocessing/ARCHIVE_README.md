# Legacy Preprocessing Scripts Archive

**Archived**: November 22, 2025  
**Reason**: Superseded by Jupyter notebook workflows in `airs/` and `notebooks/` directories

---

## 📦 Archived Contents

### Python Preprocessing Scripts
- `analyze_groupings.py` - Group-level analysis utilities
- `check_grouping_vars.py` - Grouping variable validation
- `data_screening.py` - Data quality screening
- `psychometric_utils.py` - Psychometric calculation utilities

### R Preprocessing Scripts (`r-preprocessing/`)
- `analyze_csv_structure.R` - CSV structure inspection
- `create_variable_mapping.R` - Variable mapping utilities
- `inspect_data.R` - Data exploration
- `preprocess_data.R` - Main preprocessing pipeline
- `setup_environment.R` - R environment configuration
- `README.md` - Original R preprocessing documentation

### Documentation
- `DATA_PROCESSING_README.md` - Legacy data processing guide

---

## 🔄 Current Workflow

**All preprocessing and analysis now handled through**:

### Primary Analysis Pipeline
- `airs/01_EFA_Construct_Balanced_12_Item.ipynb` - Factor analysis and scale development
- `notebooks/AIRS_Data_Exploration.ipynb` - Data exploration
- `notebooks/AIRS_Item_Level_Analysis.ipynb` - Item-level psychometrics
- `notebooks/Construct_Reliability_Validation.ipynb` - Reliability analysis

### Active Scripts (Still in `scripts/`)
- `neural-dream.ps1` - Alex cognitive architecture maintenance
- `validate-synapses.ps1` - Synaptic network validation
- `init-dream.ps1` - Dream protocol initialization
- `cognitive-config.json` - Alex configuration
- `cognitive-config-template.json` - Generic configuration template
- `README.md` - Neural dream system documentation

---

## 📝 Notes

These scripts were used during initial data preprocessing phases but have been replaced by:

1. **Jupyter Notebooks**: Interactive analysis with better reproducibility and documentation
2. **Modular Analysis**: Separate notebooks for EFA, CFA, reliability, validation
3. **Python Libraries**: factor-analyzer, semopy, pingouin for psychometric analysis

Legacy scripts preserved for historical reference but are no longer actively maintained.

---

**Restoration**: If needed, these scripts can be restored from git history or this archive directory.
