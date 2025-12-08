<div align="center">
  <img src="assets/banner.svg" alt="AIRS Data Analysis Project" width="100%">
</div>

---

# AI Readiness Scale (AIRS): Development and Validation in Higher Education

**Extending UTAUT2 with AI-Specific Constructs for Technology Adoption Research**

| | |
|---|---|
| **Researcher** | Fabio Correa |
| **Institution** | Touro University Worldwide |
| **Program** | Doctor of Business Administration (DBA) |
| **Updated** | December 7, 2025 |

---

## Project Status

| Component | Status | Progress |
|-----------|--------|----------|
| **Analysis Pipeline** | ✅ Complete | 11/11 notebooks verified |
| **Thesis Chapter 3** | ✅ Complete | Methodology (~3,800 words) |
| **Thesis Chapter 4** | ✅ Complete | Results (~3,200 words) |
| **Summary Tables** | ✅ Complete | 9 publication-ready tables |
| **Bibliography** | ✅ Complete | 60+ references |
| **Research Sources** | ✅ Complete | 8 documents (industry + academic) |
| **Thesis Chapters 1, 2, 5** | 🔶 In Progress | Outlines complete |

---

## DBA Thesis Positioning

This research bridges **academic rigor** with **business impact**:

| Academic Contribution | Business Contribution |
|-----------------------|-----------------------|
| Extends UTAUT2 with AI-specific constructs | 16-item diagnostic tool for AI readiness |
| Rigorous EFA→CFA→SEM validation | Intervention targeting for 4 user segments |
| Novel moderator discovery (Experience) | Tailored training by experience level |
| Cross-population validation | Leaders as AI champions (d=0.74-1.14) |
| Empirical gap closure | Links to McKinsey/BCG adoption-value gap |

---

## Executive Summary

This research develops and validates the **AI Readiness Scale (AIRS)**, a psychometrically sound instrument extending UTAUT2 for AI tool adoption in higher education. Through rigorous split-sample validation (N=523), we demonstrate:

### Key Findings

| Finding | Evidence |
|---------|----------|
| **Validated 8-factor model** | 16 items, CFI=.975, TLI=.960, RMSEA=.065 |
| **Performance Expectancy dominates** | β=.505 (p<.001), strongest predictor |
| **Experience moderates adoption** | PE×Exp (p=.013), HM×Exp (p=.009) |
| **Four user typologies identified** | Enthusiasts 16%, Cautious 30%, Moderate 37%, Anxious 17% |
| **Disability-anxiety link discovered** | d=0.36 (p=.006) |
| **Leaders dominate tool usage** | d=0.74-1.14 across all AI tools |
| **Model explains 85.7% variance** | R²=.857 in Behavioral Intention |

### Practical Impact

Organizations now have a **validated 16-item diagnostic instrument** for assessing AI adoption readiness with:
- Theoretical grounding in UTAUT2 framework
- Empirical validation across academic and professional populations
- Four distinct user segments for targeted intervention design

---

## Sample Overview

| Parameter | Value |
|-----------|-------|
| **Full Sample** | N = 523 |
| **EFA Development** | n = 261 (50%) |
| **CFA Holdout** | n = 262 (50%) |
| **Random Seed** | 67 |

### Role Distribution

| Role | n | % |
|------|---|---|
| Academic | 216 | 41.3% |
| Professional Services | 184 | 35.2% |
| Leadership/Management | 123 | 23.5% |

---

## Validated Measurement Model

### Model D: 8 Factors, 16 Items

```mermaid
flowchart LR
    subgraph UTAUT2["UTAUT2 Core"]
        PE[Performance Expectancy]
        EE[Effort Expectancy]
        SI[Social Influence]
        FC[Facilitating Conditions]
        HM[Hedonic Motivation]
    end

    subgraph Extensions["AI Extensions"]
        TR[Trust]
        AX[Anxiety]
    end

    subgraph Outcome["Outcome"]
        BI[Behavioral Intention]
    end

    PE -->|β=.505***| BI
    EE -->|β=.089| BI
    SI -->|β=.136*| BI
    FC -->|β=.074| BI
    HM -->|β=.217***| BI
    TR -->|β=.106†| BI
    AX -->|β=-.152**| BI
```

### Model Fit (CFA Holdout, n=262)

| Index | Value | Threshold | Interpretation |
|-------|-------|-----------|----------------|
| CFI | .975 | ≥.95 | Excellent |
| TLI | .960 | ≥.95 | Excellent |
| RMSEA | .065 | ≤.08 | Good |
| SRMR | .048 | ≤.08 | Excellent |

### Reliability

| Factor | α | CR | AVE |
|--------|---|-----|-----|
| Performance Expectancy | .85 | .86 | .76 |
| Effort Expectancy | .81 | .82 | .70 |
| Social Influence | .79 | .80 | .67 |
| Facilitating Conditions | .76 | .77 | .63 |
| Hedonic Motivation | .84 | .85 | .74 |
| Trust | .80 | .81 | .68 |
| Anxiety | .86 | .87 | .77 |
| Behavioral Intention | .91 | .92 | .85 |

---

## Hypothesis Testing Results

| ID | Hypothesis | Result | Evidence |
|----|------------|--------|----------|
| H1a | PE → BI (+) | ✅ Supported | β=.505, p<.001 |
| H1b | EE → BI (+) | ❌ Not Supported | β=.089, p=.126 |
| H1c | SI → BI (+) | ✅ Supported | β=.136, p=.013 |
| H1d | FC → BI (+) | ❌ Not Supported | β=.074, p=.170 |
| H1e | HM → BI (+) | ✅ Supported | β=.217, p<.001 |
| H1f | TR → BI (+) | ❌ Marginal | β=.106, p=.064 |
| H1g | AX → BI (−) | ✅ Supported | β=-.152, p=.002 |
| H2 | Experience moderates | ⚠️ Partial | PE, HM only |
| H3 | Role moderates paths | ❌ Not Supported | No Δβ significant |
| H4 | BI predicts usage | ✅ Supported | ρ=.70, p<.001 |
| H5 | Role differs in usage | ✅ Supported | L > P > A |

---

## Analysis Pipeline

All notebooks in `airs_experiment/` are complete and verified:

| Phase | Notebook | Purpose | Status |
|-------|----------|---------|--------|
| 0 | `00_Create_Split_Samples` | Sample preparation | ✅ |
| 1 | `01_EFA_Experiment` | Factor exploration | ✅ |
| 2 | `02_CFA_Experiment` | Model validation | ✅ |
| 3 | `03_Measurement_Invariance` | Group equivalence | ✅ |
| 4 | `04_Structural_Model` | Hypothesis testing | ✅ |
| 5 | `05_Mediation_Analysis` | Indirect effects | ✅ |
| 6 | `06_Moderation_Analysis` | Interaction effects | ✅ |
| 7 | `07_Tool_Usage_Patterns` | Behavioral validation | ✅ |
| 8 | `08_Qualitative_Feedback` | Thematic analysis | ✅ |
| 9 | `09_Comprehensive_Review` | Gap analysis | ✅ |
| 10 | `10_Final_Synthesis` | Integration | ✅ |

---

## Repository Structure

```
AIRS_Data_Analysis/
├── airs_experiment/          # Analysis notebooks and outputs
│   ├── data/                 # Processed datasets
│   ├── plots/                # Generated visualizations
│   ├── results/              # JSON output files
│   └── tables/               # CSV summary tables
├── thesis/                   # DBA thesis documentation
│   ├── chapters/             # Chapter drafts (1-5)
│   ├── tables/               # Publication-ready tables (9)
│   ├── figures/              # Exported figures
│   ├── references/           # Bibliography (60+ refs)
│   └── TODO.md               # Prioritized task list
├── research/                 # Literature and industry sources
│   ├── AIRS literatyre review.md        # Theoretical foundation
│   ├── Bridging the AI Adoption Gap...  # Industry benchmarks (585 lines)
│   ├── Meta-Analysis of UTAUT...        # Blut et al. 2022 (84 pages)
│   └── Venkatesh_AOR_2021.md            # AI-UTAUT research agenda
├── plan/                     # Analysis planning documents
├── data/                     # Raw data files
├── docs/                     # Additional documentation
└── scripts/                  # Utility scripts
```

---

## Thesis Documentation

### Completed

| Document | Location | Words |
|----------|----------|-------|
| Chapter 3: Methodology | `thesis/chapters/03_methodology.md` | ~3,800 |
| Chapter 4: Results | `thesis/chapters/04_results.md` | ~3,200 |
| Tables 4.1-4.9 | `thesis/tables/` | 9 tables |
| Bibliography | `thesis/references/bibliography.bib` | 60+ refs |

### In Progress

| Document | Status |
|----------|--------|
| Chapter 1: Introduction | Outline complete |
| Chapter 2: Literature Review | Outline complete |
| Chapter 5: Discussion | Partial draft |

See `thesis/TODO.md` for detailed task list.

---

## Quick Start

### Requirements

```bash
pip install -r requirements.txt
```

Key dependencies: pandas, numpy, scipy, factor_analyzer, semopy, pingouin, scikit-learn, matplotlib, seaborn

### Run Analysis

```bash
# Navigate to experiment folder
cd airs_experiment

# Run notebooks sequentially
# 00 → 01 → 02 → ... → 10
```

### Use the AIRS-16 Scale

The validated 16-item scale measures 8 constructs:

```python
# Calculate construct scores (mean of 2 items each)
PE = mean(PE1, PE2)  # Performance Expectancy
EE = mean(EE1, EE2)  # Effort Expectancy
SI = mean(SI1, SI2)  # Social Influence
FC = mean(FC1, FC2)  # Facilitating Conditions
HM = mean(HM1, HM2)  # Hedonic Motivation
TR = mean(TR1, TR2)  # Trust
AX = mean(AX1, AX2)  # Anxiety (reverse-scored)
BI = mean(BI1, BI2)  # Behavioral Intention
```

---

## Key References

**Technology Acceptance**
- Venkatesh, V., et al. (2003). User acceptance of information technology. *MIS Quarterly, 27*(3), 425-478.
- Venkatesh, V., et al. (2012). Consumer acceptance and use of information technology: Extending UTAUT. *MIS Quarterly, 36*(1), 157-178.

**Scale Development**
- DeVellis, R. F., & Thorpe, C. T. (2021). *Scale development: Theory and applications* (5th ed.). Sage.
- Hair, J. F., et al. (2019). *Multivariate data analysis* (8th ed.). Cengage.

**AI Adoption**
- Shin, D. (2021). The effects of explainability and causability on perception, trust, and acceptance. *IJHCS, 146*, 102551.

Full bibliography: `thesis/references/bibliography.bib`

---

## Citation

```bibtex
@phdthesis{correa2025airs,
  author = {Correa, Fabio},
  title = {AI Readiness Scale (AIRS): Development and Validation in Higher Education},
  school = {Touro University Worldwide},
  year = {2025},
  type = {Doctoral dissertation}
}
```

---

## License

Code: [MIT License](LICENSE.md)
Documentation: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

---

**Last Updated**: December 7, 2025
**Version**: 6.0 (Thesis Documentation Phase)
