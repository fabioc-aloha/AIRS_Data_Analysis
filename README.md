<div align="center">
  <img src="assets/banner.svg" alt="AIRS Data Analysis Project" width="100%">
</div>

---

[![Python](https://img.shields.io/badge/Python-3.12-blue.svg)](https://www.python.org/)
[![Analysis](https://img.shields.io/badge/Analysis-Complete-brightgreen.svg)]()
[![N](https://img.shields.io/badge/Sample-N%3D201-orange.svg)]()
[![License](https://img.shields.io/badge/License-See%20LICENSE.md-blue.svg)](LICENSE.md)

---

## 📊 Project Overview

This repository contains a comprehensive psychometric validation and structural equation modeling (SEM) analysis of the **Artificial Intelligence Readiness Score (AIRS)** survey instrument. The AIRS framework extends the UTAUT2 (Unified Theory of Acceptance and Use of Technology 2) model with AI-specific constructs to predict AI adoption readiness in organizational and educational settings.

### Research Questions

**RQ1**: What psychological, motivational, and contextual factors influence individual readiness to adopt AI technologies?

**RQ2**: To what extent do UTAUT2 constructs predict AI adoption readiness?

**RQ3**: How do AI-specific constructs (trust, explainability, ethical risk, anxiety) enhance predictive validity?

**RQ4**: How do contextual moderators influence predictor-outcome relationships?

### Key Findings

- **Sample**: N = 201 valid responses (4 excluded for attention check failure)
- **Final Instrument**: 28 items across 13 constructs
- **Model Comparison**: Model 1 (UTAUT2 core) outperforms Model 2 (AIRS extended)
- **Critical Discovery**: Three constructs show measurement issues (VO, ER, AX)

---

## 🎯 Theoretical Framework

### UTAUT2 Core Constructs (7)
- **PE**: Performance Expectancy
- **EE**: Effort Expectancy
- **SI**: Social Influence
- **FC**: Facilitating Conditions
- **HM**: Hedonic Motivation
- **PV**: Price Value
- **HB**: Habit

### Extensions (5)
- **VO**: Voluntariness ⚠️ *Mixed directionality*
- **TR**: Trust in AI
- **EX**: Explainability
- **ER**: Perceived Ethical Risk ⚠️ *Negatively valenced*
- **AX**: AI Anxiety ⚠️⚠️ *Internal inconsistency*

### Outcome Variable
- **BI**: Behavioral Intention (AI Adoption Readiness)

---

## 📁 Repository Structure

```
AIRS_Data_Analysis/
├── notebooks/                               # Analysis notebooks
│   ├── AIRS_Analysis_Python.ipynb          # Main Python analysis (63 cells)
│   ├── AIRS_Analysis.Rmd                   # R Markdown analysis
│   └── README.md                           # Notebook documentation
├── data/                                    # Survey data (git-ignored)
│   ├── AIRS---AI-Readiness-Scale.csv       # Original data (N=205)
│   ├── AIRS_clean.csv                       # Preprocessed data (N=201)
│   ├── AIRS---AI-Readiness-Scale.sav       # SPSS format
│   └── README.md                           # Data access information
├── docs/                                    # Documentation
│   ├── DATA_DICTIONARY.md                   # Complete variable definitions
│   ├── AIRS Survey Instrument v5.md        # Survey with item provenance
│   ├── AIRS DBA Project Proposal v4.md     # Theoretical framework
│   ├── NOTEBOOK_FACT_CHECK_AND_REVISIONS.md # Analysis audit trail
│   ├── AIRS_Analysis_Guide_Concise v13.html # HTML report output
│   └── README.md                           # Documentation guide
├── results/                                 # Analysis outputs
│   ├── tables/                              # Statistical tables (14 CSV files)
│   │   ├── efa_loadings.csv                # Factor analysis results
│   │   ├── reliability_analysis.csv         # α, CR, AVE values
│   │   ├── model_comparison.csv            # Model fit comparison
│   │   └── ...                             # Additional results tables
│   ├── models/                              # Saved model objects (git-ignored)
│   ├── plots/                               # Visualizations (git-ignored)
│   └── README.md                           # Results regeneration guide
├── scripts/                                 # Analysis scripts
│   ├── r-preprocessing/                     # R preprocessing pipeline
│   │   ├── setup_environment.R             # Package installation
│   │   ├── inspect_data.R                  # Data exploration
│   │   ├── preprocess_data.R               # Data cleaning
│   │   └── README.md                       # R scripts documentation
│   ├── cognitive-config.json               # Alex configuration
│   ├── neural-dream.ps1                    # Dream automation
│   └── README.md                           # Scripts documentation
├── assets/                                  # Visual assets
│   └── banner.svg                          # Repository banner
├── .github/                                 # GitHub & Alex architecture
│   ├── copilot-instructions.md             # AI assistant cognitive framework
│   ├── instructions/                        # Procedural memory (8 files)
│   └── prompts/                            # Episodic memory (12 files)
├── domain-knowledge/                        # Specialized expertise (20 files)
│   ├── DK-PYTHON-STATISTICAL-ANALYSIS-v1.0.0.md
│   ├── DK-SPSS-PSYCHOMETRIC-ANALYSIS-v1.0.0.md
│   └── ...                                 # Additional domain files
├── .gitignore                              # Git exclusion rules
├── .gitattributes                          # File handling configuration
├── requirements.txt                         # Python dependencies
├── CONTRIBUTING_AIRS.md                    # Contribution guidelines
├── LICENSE.md                              # License information
└── README.md                                # This file
```

---

## 🔬 Analysis Pipeline

The analysis follows a rigorous psychometric validation workflow:

### 1. Data Preparation & Quality Control
- Attention check validation (96% pass rate)
- Missing data assessment (<1% on any item)
- Sample split for cross-validation (EFA/CFA)

### 2. Exploratory Factor Analysis (EFA)
- **KMO Test**: 0.917 ("Marvelous" - Kaiser, 1974)
- **Bartlett's Test**: χ²(378) = 3447.74, p < .001
- **Method**: Principal Axis Factoring with Promax rotation
- **Factors**: 13 factors extracted, 28 items retained

### 3. Confirmatory Factor Analysis (CFA)
- **Estimator**: MLR (Maximum Likelihood with Robust standard errors)
- **Fit Indices** (Hu & Bentler, 1999):
  - CFI = 0.933 (≥0.90 ✓)
  - TLI = 0.923 (≥0.90 ✓)
  - RMSEA = 0.065 (≤0.08 ✓)
  - SRMR = 0.057 (≤0.08 ✓)

### 4. Reliability & Validity Assessment
- **Internal Consistency**: Cronbach's α, Composite Reliability (CR ≥ 0.70)
- **Convergent Validity**: Average Variance Extracted (AVE ≥ 0.50)
- **Discriminant Validity**: HTMT ratio (< 0.85)
- **Multicollinearity**: Variance Inflation Factor (VIF < 10)

### 5. Structural Equation Modeling (SEM)
- **Model 1**: UTAUT2 core → BI
- **Model 2**: UTAUT2 + AI-specific + VO → BI
- **Comparison**: ΔCFI, ΔRMSEA, AIC, BIC
- **Result**: Model 1 superior fit

---

## 📊 Key Statistical Results

### Measurement Model Fit
| Metric | Threshold | Result | Status |
|--------|-----------|--------|--------|
| CFI | ≥ 0.90 | 0.933 | ✓ Pass |
| TLI | ≥ 0.90 | 0.923 | ✓ Pass |
| RMSEA | ≤ 0.08 | 0.065 | ✓ Pass |
| SRMR | ≤ 0.08 | 0.057 | ✓ Pass |

### Reliability Analysis
- All UTAUT2 constructs: α > 0.70, CR > 0.70, AVE > 0.50
- Problematic constructs identified: VO, ER, AX (see below)

### Model Comparison
- **Model 1 (UTAUT2)**: Better fit, cleaner factor structure
- **Model 2 (AIRS Extended)**: Degraded fit due to measurement issues

---

## ⚠️ Critical Measurement Issues

### 1. Voluntariness (VO) - Mixed Construct
- **VO1**: Intrinsic motivation (autonomous choice)
- **VO2**: Freedom from coercion (lack of mandatory use)
- **Issue**: Different theoretical mechanisms, ambiguous relationship with BI

### 2. Perceived Ethical Risk (ER) - Negatively Valenced
- **ER1**: "I worry that AI tools could replace jobs"
- **ER2**: "I am concerned about privacy risks"
- **Issue**: Measures barriers, expected **negative** path to BI
- **Note**: NOT reverse-coded; higher scores = higher perceived risk

### 3. AI Anxiety (AX) - Internal Inconsistency ⚠️⚠️
- **AX1**: Tech-averse anxiety → **reduces** adoption (barrier)
- **AX2**: FOMO anxiety → **increases** adoption (motivator)
- **Issue**: Opposite mechanisms within same construct
- **Impact**: Likely explains Model 2's poor performance

### Scale Development Note
- **Item 40 Removed**: "Organizations manage AI risks responsibly (R)"
- Initial 49-item pool included reverse-coded ER item
- Removed during EFA/CFA validation
- **Final instrument has NO reverse-coded items**

---

## 🛠️ Technical Requirements

### Python Environment
```bash
Python 3.12.7
```

### Key Dependencies
```
pandas==2.2.3          # Data manipulation
numpy==2.1.2           # Numerical operations
semopy==2.3.13         # Structural equation modeling
factor-analyzer==0.5.1 # Exploratory factor analysis
pingouin==0.5.5        # Statistical tests
scikit-learn==1.5.2    # Machine learning utilities
matplotlib==3.9.2      # Plotting
seaborn==0.13.2        # Statistical visualization
jupyter==1.1.1         # Notebook interface
```

### Installation
```bash
# Clone repository
git clone https://github.com/fabioc-aloha/AIRS_Data_Analysis.git
cd AIRS_Data_Analysis

# Create virtual environment
python -m venv venv
.\venv\Scripts\Activate.ps1  # Windows PowerShell
source venv/bin/activate      # macOS/Linux

# Install dependencies
pip install -r requirements.txt

# Launch Jupyter
jupyter notebook notebooks/AIRS_Analysis_Python.ipynb
```

---

## 📖 Documentation Files

### Primary Documentation
- **`docs/DATA_DICTIONARY.md`**: Complete variable definitions, scales, measurement notes
- **`docs/AIRS Survey Instrument v5.md`**: Research questions, hypotheses, complete survey with item provenance
- **`docs/AIRS DBA Project Proposal v4.md`**: Theoretical framework, literature review, methodology

### Analysis Notebook
- **`notebooks/AIRS_Analysis_Python.ipynb`**: Complete analysis with 63 cells
  - Data loading & preprocessing
  - Exploratory data analysis
  - Sample splitting for EFA/CFA
  - KMO & Bartlett's tests
  - Exploratory Factor Analysis
  - Confirmatory Factor Analysis
  - Reliability & validity assessment
  - Structural equation modeling
  - Model comparison
  - Complete references (16 foundational papers)

---

## 📚 Key References

### Theoretical Foundation
- **Venkatesh et al. (2012)**: UTAUT2 framework - *MIS Quarterly, 36*(1), 157-178
- **Venkatesh et al. (2003)**: Original UTAUT - *MIS Quarterly, 27*(3), 425-478

### Measurement & Validation
- **Hu & Bentler (1999)**: Fit index cutoffs - *Psychological Methods, 4*(1), 1-24
- **Fornell & Larcker (1981)**: Convergent/discriminant validity - *Journal of Marketing Research, 18*(1), 39-50
- **Hair et al. (2010)**: Multivariate data analysis - Pearson, 7th edition

### AI-Specific Constructs
- **Langer et al. (2023)**: Trust in AI - *Academy of Management Annals, 17*(1), 47-81
- **Shin (2021)**: Explainability effects - *International Journal of Human-Computer Studies, 146*, 102551

### Statistical Methods
- **Kaiser (1974)**: KMO measure - *Educational and Psychological Measurement, 34*(1), 111-117
- **Henseler et al. (2015)**: HTMT criterion - *Journal of the Academy of Marketing Science, 43*(1), 115-135

**Complete Bibliography**: See final cell in `notebooks/AIRS_Analysis_Python.ipynb`

---

## 🎓 Academic Context

This analysis is part of a doctoral research project examining AI adoption readiness in enterprise environments. The study validates a comprehensive measurement instrument and tests competing theoretical models.

### Contributions
1. **Psychometric validation** of AIRS instrument (28 items, 13 constructs)
2. **Identification of measurement issues** in AI-specific constructs
3. **Model comparison** demonstrating UTAUT2 robustness
4. **Theoretical insights** on voluntariness, ethical risk, and AI anxiety

### Implications
- **For Research**: Demonstrates challenges in extending technology acceptance models to AI contexts
- **For Practice**: Identifies reliable predictors of AI adoption readiness
- **For Measurement**: Highlights need for careful AI anxiety and ethical risk conceptualization

---

## 🤝 Contributing

This is an academic research project. For questions or collaboration inquiries, please open an issue or contact the repository owner.

### Code of Conduct
See `CODE_OF_CONDUCT.md`

### Contributing Guidelines
See `CONTRIBUTING.md`

---

## 📄 License

See `LICENSE.md`

---

## 🔗 Related Resources

### Alex Cognitive Architecture
This project uses the **Alex cognitive architecture** for AI-assisted analysis:
- Meta-cognitive awareness protocols
- Bootstrap learning for domain expertise
- Automated neural maintenance
- See `.github/copilot-instructions.md` for details

### Domain Knowledge Files
Specialized expertise integrated:
- `DK-PYTHON-STATISTICAL-ANALYSIS-v1.0.0.md`: Python psychometric analysis mastery
- `DK-SPSS-PSYCHOMETRIC-ANALYSIS-v1.0.0.md`: Psychometric validation foundations
- `DK-DOCUMENTATION-EXCELLENCE-v1.1.0.md`: Documentation accuracy standards

---

## 📧 Contact

**Project Owner**: fabioc-aloha
**Repository**: [AIRS_Data_Analysis](https://github.com/fabioc-aloha/AIRS_Data_Analysis)

---

## 🏆 Acknowledgments

- Study participants (N = 201)
- UTAUT2 framework developers (Venkatesh et al., 2012)
- Open-source Python statistical computing community
- Alex cognitive architecture for AI-assisted research

---

**Last Updated**: November 2025
**Version**: 1.0
**Status**: Analysis Complete ✓
