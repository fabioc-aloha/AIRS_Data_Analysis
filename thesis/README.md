# DBA Thesis: Artificial Intelligence Readiness Scale (AIRS)

Bridging Academic Rigor with Business Impact

## Thesis Structure

```text
thesis/
├── chapters/
│   ├── 01_introduction.md          # Chapter 1: Introduction
│   ├── 02_literature_review.md     # Chapter 2: Literature Review
│   ├── 03_methodology.md           # Chapter 3: Research Methodology
│   ├── 04_results.md               # Chapter 4: Results
│   ├── 05_analysis_discussion.md   # Chapter 5: Analysis & Discussion
│   └── 06_conclusions.md           # Chapter 6: Conclusions & Recommendations
├── appendices.md                   # Combined appendices (A-H)
├── references/
│   ├── bibliography.bib            # BibTeX references (92 sources)
│   └── apa-7th-edition.csl         # APA 7 citation style
├── figures/                        # Mermaid-generated diagrams
├── tables/                         # Standalone table files
├── 00_title_abstract.md            # Title page, abstract, front matter
├── EXECUTIVE_SUMMARY.md            # Executive summary (standalone)
├── PRACTITIONER_BRIEF.md           # Practitioner brief (standalone)
├── THESIS_SUMMARY.md               # 5-page thesis summary (standalone)
├── PRESENTATION_SLIDES.md          # Committee presentation draft (standalone)
├── build-thesis.ps1                # Main thesis PDF builder
├── convert-to-pdf.ps1              # Standalone document converter
└── DRAFT 06.pdf                    # Current compiled thesis
```

## Study Overview

| Element | Description |
|---------|-------------|
| **Title** | Artificial Intelligence Readiness Scale: Extending UTAUT2 for Enterprise AI Adoption |
| **Author** | Fabio Correa, Doctoral Candidate |
| **Institution** | Touro University Worldwide |
| **Sample** | N = 523 (Student: 216, Professional: 184, Leader: 123) |
| **Methodology** | Split-sample EFA (n=261) → CFA (n=262) → SEM + Mixed methods |
| **Validated Model** | 8 factors, 16 items |
| **Model Fit** | CFI=.975, TLI=.960, RMSEA=.065, SRMR=.048 |
| **Variance Explained** | R² = .861 (86.1%) |

## Key Findings Summary

### Significant Predictors of AI Adoption Intention

| Predictor | Effect | Significance |
|-----------|--------|--------------|
| **Price Value** | β = .505 | p < .001 (Strongest) |
| **Hedonic Motivation** | β = .217 | p = .014 |
| **Social Influence** | β = .136 | p = .024 |
| AI Trust | β = .106 | p = .064 (Marginal) |

### Non-Significant Predictors

| Predictor | Effect | Note |
|-----------|--------|------|
| Performance Expectancy | β = -.028 | Departure from traditional UTAUT |
| Effort Expectancy | β = -.008 | AI usability may be baseline |
| Facilitating Conditions | β = .059 | Organizational support not differentiating |
| Habit | β = .023 | Not established for AI tools |

### Four User Segments Identified

| Segment | % | Characteristics |
|---------|---|-----------------|
| AI Enthusiasts | 16% | High trust, low anxiety, strong intention |
| Cautious Adopters | 30% | Moderate trust, evaluative stance |
| Moderate Users | 37% | Balanced profiles, pragmatic approach |
| Anxious Avoiders | 17% | Elevated anxiety, low intention |

## Document Status

| Component | Status |
|-----------|--------|
| Chapter 1: Introduction | ✅ Complete |
| Chapter 2: Literature Review | ✅ Complete |
| Chapter 3: Methodology | ✅ Complete |
| Chapter 4: Results | ✅ Complete |
| Chapter 5: Analysis & Discussion | ✅ Complete |
| Chapter 6: Conclusions | ✅ Complete |
| Appendices A-H | ✅ Complete (incl. Data Availability) |
| Bibliography | ✅ 92 references verified |
| Tables & Figures | ✅ Auto-numbered |
| IRB Documentation | ✅ Embedded |

## Build Scripts

| Script | Purpose |
|--------|---------|
| `build-thesis.ps1` | Build complete thesis PDF with Mermaid diagrams |
| `convert-to-pdf.ps1` | Convert standalone documents to PDF (APA 7 format) |

### Usage

```powershell
# Build main thesis
.\build-thesis.ps1

# Convert standalone documents
.\convert-to-pdf.ps1

# Convert specific file
.\convert-to-pdf.ps1 -File "THESIS_SUMMARY.md"
```

## Analysis Pipeline

All notebooks in `airs_experiment/` are complete:

| Notebook | Phase | Status |
|----------|-------|--------|
| NB00 | Sample Splitting (N=523 → 261/262) | ✅ |
| NB01 | Exploratory Factor Analysis | ✅ |
| NB02 | Confirmatory Factor Analysis | ✅ |
| NB03 | Measurement Invariance | ✅ |
| NB04 | Structural Model | ✅ |
| NB05 | Mediation Analysis | ✅ |
| NB06 | Moderation Analysis | ✅ |
| NB07 | Tool Usage Patterns | ✅ |
| NB08 | Qualitative Feedback | ✅ |
| NB09 | Comprehensive Review | ✅ |
| NB10 | Final Synthesis | ✅ |

---

Last updated: December 8, 2025
