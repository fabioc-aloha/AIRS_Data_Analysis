# DBA Thesis: Artificial Intelligence Readiness Scale (AIRS)

Bridging Academic Rigor with Business Impact

## Thesis Structure

```text
thesis/
├── chapters/
│   ├── 01_introduction.md          # Chapter 1: Introduction
│   ├── 02_literature_review.md     # Chapter 2: Literature Review
│   ├── 03_methodology.md           # Chapter 3: Research Methodology ✅
│   ├── 04_results.md               # Chapter 4: Results & Analysis ✅
│   └── 05_discussion.md            # Chapter 5: Discussion & Conclusions
├── appendices/
│   ├── A_survey_instrument.md      # Full AIRS questionnaire
│   ├── B_statistical_outputs.md    # Detailed statistical tables
│   ├── C_qualitative_codebook.md   # Qualitative analysis codebook
│   └── D_supplementary_analyses.md # Additional analyses
├── figures/
│   └── (exported from airs_experiment/plots/)
├── tables/
│   ├── Table_4.1_Sample_Demographics.md
│   ├── Table_4.2_Model_Fit_Indices.md
│   ├── Table_4.3_Reliability_Validity.md
│   ├── Table_4.4_Hypothesis_Testing.md
│   ├── Table_4.5_Tool_Adoption_Patterns.md
│   ├── Table_4.6_User_Typology.md
│   ├── Table_4.7_Qualitative_Themes.md
│   ├── Table_4.8_Demographic_Effects.md
│   └── Table_4.9_Summary_of_Findings.md
├── references/
│   └── bibliography.bib            # BibTeX references (60+ sources)
├── TODO.md                         # Prioritized task list
└── README.md                       # This file
```

## Study Overview

| Element | Description |
|---------|-------------|
| **Title** | Artificial Intelligence Readiness Scale: Extending Model for Enterprise AI Adoption |
| **Sample** | N = 523 (Student: 216, Professional: 184, Leader: 123) |
| **Methodology** | Split-sample EFA (n=261) → CFA (n=262) → SEM + Mixed methods |
| **Validated Model** | 8 factors, 16 items (Model D) |
| **Model Fit** | CFI=.975, TLI=.960, RMSEA=.065 |

## Key Findings Summary

### Supported Hypotheses

| ID | Hypothesis | Evidence |
|----|------------|----------|
| H1c | Social Influence → BI | β=.136, p=.024 |
| H1e | Hedonic Motivation → BI | β=.217, p=.014 |
| H1f | Price Value → BI | β=.505, p<.001 ⭐ **Strongest** |
| H4 | Population moderates HM | Δβ=-0.750, p=.041 |

### Marginal Support

- **H2**: AI Trust → BI (β=.106, p=.064)

### Not Supported

- **H1a**: Performance Expectancy → BI (β=-.028, p=.791)
- **H1b**: Effort Expectancy → BI (β=-.008, p=.875)
- **H1d**: Facilitating Conditions → BI (β=.059, p=.338)
- **H1g**: Habit → BI (β=.023, p=.631)
- **H3**: AIRS > UTAUT2 (ΔAIC=+2.01, not supported)

### Novel Contributions

| Contribution | Academic Value | Business Value |
|--------------|----------------|----------------|
| PV dominance (β=.505) | Unexpected departure from PE-dominant UTAUT | Lead with cost-benefit messaging |
| PE non-significant | Novel finding for AI context | Utility may be baseline expectation |
| Population moderation | Academics vs Professional differences | Tailored messaging by role |
| Experience moderation | HM×Exp discovery | Experienced users weight enjoyment more |

## Document Status

| Chapter | Status | Word Count |
|---------|--------|------------|
| Chapter 1: Introduction | 🔲 Outline complete | ~2,500 target |
| Chapter 2: Literature Review | 🔲 Outline complete | ~5,000-8,000 target |
| Chapter 3: Methodology | ✅ **Complete** | ~3,800 words |
| Chapter 4: Results | ✅ **Complete** | ~3,200 words |
| Chapter 5: Discussion | 🔶 Partial draft | ~3,000 target |
| Tables 4.1-4.9 | ✅ **Complete** | 9 tables |
| Bibliography | ✅ **Complete** | 60+ references |

## Research Sources

Supporting research documents in `research/` folder:

| Document | Type | Pages |
|----------|------|-------|
| AIRS Literature Review | Theoretical foundation | 169 lines |
| Bridging AI Adoption Gap 2023-2025 | Industry benchmarks | 585 lines |
| Blut et al. (2022) UTAUT Meta-Analysis | Academic validation | 84 pages |
| Venkatesh (2021) AI-UTAUT Agenda | AI-specific research | 21 pages |

## Analysis Pipeline

| Notebook | Phase | Status |
|----------|-------|--------|
| NB00 | Data Preparation (N=523 → 261/262) | ✅ Complete |
| NB01 | Exploratory Factor Analysis (Model D) | ✅ Complete |
| NB02 | Confirmatory Factor Analysis | ✅ Complete |
| NB03 | Measurement Invariance | ✅ Complete |
| NB04 | Structural Model (H1-H4) | ✅ Complete |
| NB05 | Mediation Analysis | ✅ Complete |
| NB06 | Moderation Analysis (Experience effects) | ✅ Complete |
| NB07 | Tool Usage Patterns | ✅ Complete |
| NB08 | Qualitative Feedback | ✅ Complete |
| NB09 | Comprehensive Review | ✅ Complete |
| NB10 | Final Synthesis | ✅ Complete |

---

Last updated: December 8, 2025
