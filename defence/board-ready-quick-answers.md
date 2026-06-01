---
title: "Board-Ready Quick Answers (AIRS Dissertation)"
author: "Fabio Correa"
date: "2026"
---

> **Purpose**: Fast answers to likely board questions about data, methods, findings, validation, limitations, and productization.

## Data, Ethics, Sampling

- **N = 523** (US adults), **Centiment** topic-blinded recruitment; **Oct–Nov 2025** (3-week window).
- **Split-sample**: EFA n=261, CFA n=262, **seed=67**.
- **Roles**: Academic 41.3% (n=216), Professional 35.2% (n=184), Leaders 23.5% (n=123).
- **Disability**: 13% (n=68), 11 preferred not to answer. IRB-ready; no PII stored beyond survey responses.

## Psychometrics (Holdout, lavaan 0.6.21)

- **Fit**: CFI = .975, TLI = .960, RMSEA = .065, SRMR = .026. Full sample: CFI = .979, TLI = .966, RMSEA = .061, SRMR = .022.
- **KMO** = .937; **Bartlett χ²** = 4,668.45, p < .001; no Mahalanobis outliers.
- **Reliability (α / CR / AVE)**: PE .803/.804/.673; EE .859/.861/.756; SI .752/.763/.621; FC .743/.750/.601; HM .864/.865/.763; PV .883/.883/.790; HB .909/.909/.833; TR .891/.891/.804.
- **Discriminant**: HTMT flags (PE×PV .902, PE×HM .900, HM×PV .904, HM×TR .850) due to 2-item scales; addressed via diagnostic framing and AIRS-28 plan.

## Structural Findings

- **R² (BI) = .897** (explained variance).
- **Dominant predictor**: **Price Value β = .505** (p < .001). HM β = .217 (p=.014), SI β = .136 (p=.024) — *z-test significant but bootstrap-unstable*.
- **Trust**: β = .106 (p = .064); **ΔAIC = +2.01** vs UTAUT2-only (AIC 148.58 vs 150.59). Power analysis: **n > ~600** needed for 80% power; current **n=523 ≈68% power**.
- **Mediation**: NA in AIRS-16 (planned for AIRS-28).

## Moderation & Invariance

- **HM×Experience** β = .136, **p = .007** (experienced users weigh enjoyment more). PE×Experience β = .112, p=.055 (marginal).
- **Population moderation**: Academic HM β = **0.449** vs Professional HM β = **−0.301**, **p = .041**; other paths NS.
- **Measurement invariance**: Configural achieved; partial metric (mean Δλ = .082; max Δλ = .326 for SI).

## BI ↔ Usage Validation

- **Spearman ρ = .69** (p < .001) between BI and actual AI usage.
- Tool-specific: **ChatGPT ρ=.57; MS Copilot ρ=.54; Gemini ρ=.52**.
- Usage ANOVA: F(2,520) = 18.42 / 22.15 / 15.87 (p < .001); **Leaders > Professionals > Academics**. Copilot Cohen’s d (Leaders vs Prof) = **1.14**.

## Typology

- **k=3 solution**: **Enthusiasts 31%, Moderate Users 47%, Skeptics 22%**; **silhouette = .271** (k=4 = .226).
- ANOVA: **F(2,520) = 503.47**, **η² = .659**.
- **Classifier accuracy = 94.5%** (phase11/phase12); **cut-point model accuracy = 91.4%**; decision tree CV accuracy = 80.1%.
- Mean BI: Enthusiasts 4.23; Skeptics 1.71.

## Corrections & Audit Highlights

- **SRMR discrepancy fixed**: Python manual SRMR (~.129) replaced with lavaan **SRMR = .026 (CFA)** / **.024 (SEM)**; thesis corrected.
- **Fabricated bootstrap CIs corrected**: PV CI [0.218, 1.083] survives; HM [−0.107, 0.483], SI [−0.028, 0.298] fail bootstrap; Tables 4.10/4.11 updated.
- **Construct drops**: Voluntariness α=.41, Explainability α=.58, Ethical Risk α=.55, AI Anxiety α=.30 (dropped due to reliability; slated for AIRS-28 redesign).
- **Decision Dashboard (`airs_archive/editorial-workflow/FACT_CHECK_AUDIT.md`)**: D1–D11 all resolved (k=3 clusters adopted, SRMR fixed, R² corrected, CI fabrication fixed, discriminant validity claims corrected, Trust claims reframed, p=.009 → .007 fixed, “student” → “academic” label fixed).

## Disability & Neurodiversity Insights

- **AI Anxiety** *d* = **0.36**, p = .006 (only significant construct), **Hedonic Motivation** *d* = **0.28**, p = .030. All other constructs trend lower (d=0.12–0.24) for disability group.
- Implication: Anxiety likely reflects design/accessibility issues; HM gap indicates suppressed enjoyment. Redesign anxiety items for AIRS-28; add accessibility-informed UX and training.

## AIRS Enterprise (Productization)

- **Validated metrics**: AIRS Score **r = .876** (cutpoint), **typology classifier = 94.5%**, **cut-point classifier = 91.4%**.
- **Stack/security**: Next.js 16.1, React 19, Prisma + PostgreSQL, Azure App Service Premium (P2v3) with VNet + Managed Identity, Microsoft Entra ID auth, Azure OpenAI GPT-4o-mini (streaming SSE), SFI-aligned.
- **Interventions**: TRANSFORM (Skeptics), REDESIGN (Moderate Users), AMPLIFY (Enthusiasts) mapped to PV/HM/SI/TR findings.
- **Longitudinal plan**: T1–T4 (3/6/12 months), norms for 8+ populations, org-level dashboards, pre/post effect sizes.

## Limitations & Future Work

- Cross-sectional, self-report BI; US-only; binary disability measure; 2-item constructs; AI Anxiety reliability low.
- **AIRS-28**: 3–4 items/construct + redesigned Anxiety/Explainability/Ethical Risk; **n > 600** replication for Trust power; longitudinal and cross-cultural invariance tests; RCTs for interventions; CAIR/CSR (calibrated reliance) integration.

## Data Lineage

- **Scripts**: `airs_experiment/R/run_00`–`run_12`, `run_r_validation.R`.
- **Artifacts**: `airs_experiment/tables/cfa_htmt.csv`, `airs_experiment/tables/cfa_summary.json`, `airs_experiment/results/r_lavaan_validation.json`, `phase11_practitioner_typology_results.json`, `phase12_classification_results.json`, `phase5_alternative_analyses.json`.
- **Thesis build**: `thesis-v2/build.ps1` (Pandoc + XeLaTeX + Mermaid CLI). Decision Dashboard in `airs_archive/editorial-workflow/FACT_CHECK_AUDIT.md` confirms all discrepancies resolved.

## Additional Commonly Asked Topics

### 1) IRB / Ethics / Privacy

- Topic-blinded recruitment; informed consent included. Minimal PII (demographics only). Data stored without direct identifiers; raw exports anonymized. IRB-ready; SOC2-aligned controls on AIRS Enterprise.

### 2) Sample Representativeness & Bias

- U.S.-only Centiment panel (blinded). Checks: balanced role distribution, disability representation (13%), no significant non-response bias detected. Limitation acknowledged; cross-cultural replication planned.

### 3) Model Robustness & Reproducibility

- Scripts versioned in repo; `renv`/`packrat` lockfiles for R environment and `requirements.txt` for Python. Seed=67 for splits; lavaan 0.6.21; R 4.5.2; Next.js/React versions listed. Re-runs reproduce metrics (CI corrections validated).

### 4) Statistical Power

- Trust effect β=.106 requires n>~600 for 80% power; current n=523 ~68%. Other effects (PV β=.505, HM β=.217, SI β=.136) have ample power. Reported in summary and future work.

### 5) Generalizability

- Short answer: U.S. knowledge workers; limited cultural transferability. Planned: cross-cultural invariance testing (EU, APAC), sector-specific norms (healthcare/finance/education/tech), and language adaptations via AIRS Enterprise.

### 6) Appropriate Reliance (CAIR/CSR)

- Adoption vs over-reliance addressed conceptually (AETHER CAIR/CSR; Alex Finch “Calibrated Confidence”). Future RCTs will add reliance calibration measures; not in current SEM.

### 7) Governance & Compliance Questions

- AIRS Enterprise: SFI controls, VNet, Managed Identity, Entra ID, audit logging. No production PII storage beyond session context; supports DSR (data subject request) workflows.
- No regulated data processed in the study; future enterprise deployments to follow org-specific DPA/BAA as needed.

### 8) Qualitative Data Handling

- 243 open-ended responses (46.5% response rate). Automated content analysis with human review; themes: Positive Experience (24.7%), Work/Productivity (19.3%), Human Element & Learning/Education (13.6% each), Accuracy/Reliability (10.7%). Role moderation noted; used to enrich interpretation.

### 9) EFA/CFA Model Selection

- EFA models A–D; Model D (8 factors, 16 items) selected based on fit (CFI .975, TLI .960, RMSEA .065, SRMR .026), theoretical coherence, and reliability. Dropped constructs due to α < .60.

### 10) SRMR / CI Corrections (Audit Trail)

- Python manual SRMR bug identified (SRMR ~.129). Lavaan SRMR = .026 (CFA) / .024 (SEM). Bootstrap CIs added; fabricated CIs removed; documented in `airs_archive/editorial-workflow/FACT_CHECK_AUDIT.md` D1–D3.

### 11) Operationalization & Licensing

- AIRS instrument available for research under standard academic license; enterprise usage via AIRS Enterprise SaaS. Typology models and cut-point logic implemented server-side.

### 12) Change Management / Interventions

- Mapped to PV/HM/SI/Trust findings. Segment frameworks (TRANSFORM/REDESIGN/AMPLIFY). Embeddable into org playbooks. Upcoming RCTs planned for validation.

### 13) Accessibility & Neurodiversity Follow-up

- AI Anxiety and HM effects (d=.36, .28) highlight accessibility gaps. AIRS-28 to include redesigned anxiety/explainability/ethical risk items. Accessibility-first UX audits recommended; anxiety-informed training protocols in development.

### 14) Toolchain & Build

- Thesis build: `thesis-v2/build.ps1` (Pandoc/XeLaTeX/Mermaid); ensures citations, diagrams, and tables reproduce. AIRS Enterprise built using Next.js/React/Prisma/PostgreSQL/Azure OpenAI.

### 15) Future Metrics & Benchmarks

- Planned norms for 8+ populations (N=300–500 each), longitudinal tracking (T1–T4), predictive validity tests, cross-industry benchmarks, and “AIRS Score bands” (emerging/developing/proficient/advanced).

*Use this extended cheat sheet for board and leadership Q&A; the main executive summary remains concise and shareable.*
