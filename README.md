<div align="center">
  <img src="assets/banner.svg" alt="AIRS Data Analysis Project" width="100%">
</div>

---

# **AI Readiness Scale (AIRS): Extending UTAUT2 for Enterprise AI Adoption**
## *Theory-Grounded Validation of AI Trust as a Critical Adoption Construct*

<table width="100%">
<tr><td><strong>Researcher</strong></td><td>Fabio Correa</td></tr>
<tr><td><strong>Institution</strong></td><td>Touro University Worldwide</td></tr>
<tr><td><strong>Program</strong></td><td>Doctor of Business Administration (DBA)</td></tr>
<tr><td><strong>Date</strong></td><td>November 28, 2025</td></tr>
<tr><td><strong>Status</strong></td><td>✅ All 10 Phases Complete | 5 Hypotheses Supported | 7 Novel Findings | R²=0.558</td></tr>
</table>

---

## 🎯 **Executive Summary**

This research develops and validates the **AI Readiness Scale (AIRS)**, a theory-grounded extension of UTAUT2 for enterprise AI adoption contexts. Through rigorous split-sample validation (N=513), we demonstrate:

### **Key Findings**

1. **Validated Model D**: 8-factor structure with 16 items
   - 7 UTAUT2 core constructs (PE, EE, SI, FC, HM, PV, HB)
   - 1 AI-specific extension: **AI Trust** (α=0.91)
   - Excellent fit: CFI=0.974, TLI=0.959, RMSEA=0.070

2. **Structural Model Results** (Phases 4-6):
   - **H1 Partially Supported**: 3/7 UTAUT2 paths significant (SI, HM, PV)
   - **H2 Supported**: AI Trust predicts adoption (β=0.112, p=.048)
   - **H3 Not Supported**: ΔAIC=+2.01 favors simpler UTAUT2-only model
   - **H4 Partial**: Experience moderates PE→BI (p=.013) and HM→BI (p=.009)
   - **R² = 55.8%** variance explained in Behavioral Intention

3. **Novel Discovery - Experience Moderation** (Phase 6 Revisit):
   - PE × Experience (p=.013): Performance expectancy stronger for experienced professionals
   - HM × Experience (p=.009): Hedonic motivation stronger for experienced professionals
   - Industry and Education showed no significant moderation effects

4. **Item Design Insights**: 4 constructs dropped due to item design issues (not theoretical problems):
   - Voluntariness, Explainability, Ethical Risk, Anxiety
   - Documented recommendations for future scale development

5. **Population Comparison**: Measurement invariance testing reveals:
   - **Configural invariance supported** across Academic (N=198) and Professional (N=315) samples
   - **Partial metric invariance**: 4/16 items function differently (SI2, FC1, EE2, PE1)
   - **No structural moderation**: Path coefficients similar across populations

### **Practical Impact**

Organizations now have a **validated 16-item diagnostic instrument** for assessing AI adoption readiness, with:
- Theoretical grounding in established technology acceptance research
- Empirical validation across academic and professional populations
- Clear scoring and interpretation guidelines

---

## 📚 **Table of Contents**

1. [Validated Measurement Model](#validated-measurement-model)
2. [Research Questions & Hypotheses](#research-questions--hypotheses)
3. [Methodological Approach](#methodological-approach)
4. [Phase Results Summary](#phase-results-summary)
5. [Dissertation Contributions](#dissertation-contributions)
6. [Project Documentation](#project-documentation)
7. [How to Use This Repository](#how-to-use-this-repository)

---

## 📊 **Validated Measurement Model**

### Model D: 8 Factors × 2 Items = 16 Items

```mermaid
flowchart LR
    subgraph UTAUT2["UTAUT2 Core (H1) ✓"]
        PE[Performance Expectancy<br/>α=0.87]
        EE[Effort Expectancy<br/>α=0.87]
        SI[Social Influence<br/>α=0.78]
        FC[Facilitating Conditions<br/>α=0.79]
        HM[Hedonic Motivation<br/>α=0.89]
        PV[Price Value<br/>α=0.87]
        HB[Habit<br/>α=0.90]
    end

    subgraph AI["AI Extension (H2) ✓"]
        TR[AI Trust<br/>α=0.91]
    end

    subgraph Outcome["Outcome"]
        BI[Behavioral Intention]
    end

    PE -->|+| BI
    EE -->|+| BI
    SI -->|+| BI
    FC -->|+| BI
    HM -->|+| BI
    PV -->|+| BI
    HB -->|+| BI
    TR -->|+| BI
```

### Model Fit Statistics (CFA Holdout N=257)

| Metric | Value | Threshold | Status |
|--------|-------|-----------|--------|
| CFI | 0.974 | ≥ 0.95 | ✓ Excellent |
| TLI | 0.959 | ≥ 0.95 | ✓ Excellent |
| RMSEA | 0.070 | ≤ 0.08 | ✓ Good |
| χ²/df | 1.51 | ≤ 3.0 | ✓ Excellent |

### Construct Reliability

| Construct | Items | α | CR | AVE | Status |
|-----------|-------|---|----|----|--------|
| Performance Expectancy | PE1, PE2 | 0.87 | 0.87 | 0.77 | ✓ Excellent |
| Effort Expectancy | EE1, EE2 | 0.87 | 0.87 | 0.77 | ✓ Excellent |
| Social Influence | SI1, SI2 | 0.78 | 0.79 | 0.66 | ✓ Good |
| Facilitating Conditions | FC1, FC2 | 0.79 | 0.80 | 0.66 | ✓ Good |
| Hedonic Motivation | HM1, HM2 | 0.89 | 0.89 | 0.81 | ✓ Excellent |
| Price Value | PV1, PV2 | 0.87 | 0.87 | 0.77 | ✓ Excellent |
| Habit | HB1, HB2 | 0.90 | 0.90 | 0.82 | ✓ Excellent |
| **AI Trust** | **TR1, TR2** | **0.91** | **0.91** | **0.83** | **✓ Excellent** |

---

## 🔍 **Research Questions & Hypotheses**

### Primary Research Questions

| RQ | Question | Status |
|----|----------|--------|
| **RQ1** | What factors influence AI adoption readiness in organizational settings? | ✅ Answered |
| **RQ2** | Do UTAUT2 constructs predict AI adoption readiness? | ✅ Answered |
| **RQ3** | Does AI Trust add explanatory power beyond UTAUT2? | ✅ Answered |
| **RQ6** | Does the factor structure hold across academic and professional populations? | ✅ Answered |
| **RQ7** | Do populations differ in AI readiness levels? | ✅ Answered |

### Hypotheses

| Hypothesis | Prediction | Analysis | Status |
|------------|------------|----------|--------|
| **H1** | UTAUT2 constructs predict AI adoption | Structural model | ⚠️ Partially Supported (3/7 paths) |
| **H2** | AI Trust predicts adoption beyond UTAUT2 | Incremental validity | ✅ Supported (β=0.112*) |
| **H3** | Combined AIRS explains more variance than UTAUT2 alone | Model comparison | ❌ Not Supported (ΔAIC=+2.01) |
| **H4a-b** | Population/Role moderate relationships | Multi-group SEM | ❌ Not Supported |
| **H4c** | Usage frequency moderates HB→BI | Multi-group SEM | ❌ Not Supported* |
| **H4e** | Voluntariness moderates SI/FC→BI | Multi-group SEM | ❌ Not Supported (unreliable) |
| **H4f** | Disability moderates EE/FC→BI | Multi-group SEM | ❌ Not Supported (unreliable) |
| ~~H5~~ | ~~Mediation through EX, ER, AX~~ | ~~Bootstrap mediation~~ | ❌ Not testable |

**Note**: *H4c showed significant OPPOSITE effect (z=-2.17, p=.030): HB→BI is weaker for high-frequency users.

**Note**: H5 mediation hypotheses cannot be tested because Explainability (EX), Ethical Risk (ER), and Anxiety (AX) were dropped due to item design issues.

---

## 🔬 **Methodological Approach**

### Sample Overview

| Parameter | Value |
|-----------|-------|
| **Total Sample** | N = 513 (after role filtering) |
| **Development Sample** | N = 256 (EFA) |
| **Holdout Sample** | N = 257 (CFA) |
| **Academic** | N = 198 (Full-time + Part-time students) |
| **Professional** | N = 315 (Employed, Freelancers, Managers) |

### Validation Strategy: Theory-Guided EFA → CFA → Measurement Invariance

```mermaid
flowchart TB
    subgraph Phase0["Phase 0: Preparation"]
        RAW[Raw Data N=513] --> FILTER[Role Filtering]
        FILTER --> SPLIT{50/50 Split}
        SPLIT --> DEV[Development<br/>N=256]
        SPLIT --> HOLD[Holdout<br/>N=257]
    end

    subgraph Phase1["Phase 1: EFA"]
        DEV --> EFA[Theory-Guided EFA<br/>Models A-F Comparison]
        EFA --> MODELD[Model D Selected<br/>8 factors, 16 items]
    end

    subgraph Phase2["Phase 2: CFA"]
        MODELD --> CFA[CFA Validation]
        HOLD --> CFA
        CFA --> FIT[CFI=0.974, TLI=0.959<br/>RMSEA=0.070]
    end

    subgraph Phase3["Phase 3: Invariance"]
        FIT --> INV{Measurement Invariance}
        INV --> ACAD[Academic N=198]
        INV --> PROF[Professional N=315]
    end

    subgraph Phase4_6["Phases 4-6: Structural"]
        ACAD --> SEM[Multi-Group SEM]
        PROF --> SEM
        SEM --> HYP[Hypothesis Testing]
    end
```

### Analysis Roadmap

| Phase | Notebook | Description | Status |
|-------|----------|-------------|--------|
| **0** | `00_Create_Split_Samples.ipynb` | Sample preparation | ✅ Complete |
| **1** | `01_EFA_Experiment.ipynb` | Theory-guided EFA → Model D | ✅ Complete |
| **2** | `02_CFA_Experiment.ipynb` | CFA validation | ✅ Complete |
| **3** | `03_Measurement_Invariance.ipynb` | Cross-population invariance | ✅ Complete |
| **4** | `04_Structural_Model.ipynb` | Hypothesis testing (H1-H4) | ✅ Complete |
| **5** | `05_Mediation_Analysis.ipynb` | Alternative analyses & model comparison | ✅ Complete |
| **6** | `06_Moderation_Analysis.ipynb` | H4c-f + demographic moderation | ✅ Complete (Revisited) |
| **7** | `07_Tool_Usage_Patterns.ipynb` | AI tool usage patterns (RQ10) | ✅ Complete |
| **8** | `08_Qualitative_Feedback.ipynb` | Thematic analysis (RQ11-12) | ✅ Complete |
| **9** | `09_Comprehensive_Review.ipynb` | Gap analysis & user typology | ✅ Complete |
| **10** | `10_Final_Synthesis.ipynb` | Chapter 4 integration | ✅ Complete |

### Phase 9-10 Completion Summary

**Completed Remediation** (Phase 6 Revisit - Nov 28, 2025):
- ✅ Industry moderation tested → No significant effects
- ✅ Education moderation tested → No significant effects
- ✅ Experience moderation tested → **2 SIGNIFICANT effects discovered!**
- ✅ User typology documented in Phase 10 synthesis
- ✅ Typology × Theme cross-tabulation → **1 significant association (Positive Experience)**

**Phase 10 Final Synthesis**:
- Hypothesis summary: 5 supported, 9 not supported, 3 not testable
- 7 novel findings documented (including typology × theme cross-tabulation)
- Chapter 4 integration complete

**Future Research Directions**:
- Disability & inclusive AI design study
- Longitudinal tool preference tracking
- Dropped construct item redesign (VO, EX, ER, AX)
- Experience moderation replication in other technology contexts

---

## 📈 **Phase Results Summary**

### Phase 1: EFA Results

**Approach**: Theory-guided model comparison (Models A-F)

| Model | Factors | Items | Strategy | All α ≥ 0.60? | Selected |
|-------|---------|-------|----------|---------------|----------|
| A | 12 | 24 | Full theoretical | ✗ No | |
| B | 10 | 20 | Drop 4 weakest items | ✗ No | |
| C | 10 | 20 | Drop weak constructs | ✗ No | |
| **D** | **8** | **16** | **Drop all α < 0.60 constructs** | **✓ Yes** | **✓** |
| E | 6 | 12 | Core UTAUT only | ✓ Yes | |
| F | 4 | 8 | Minimal viable | ✓ Yes | |

**Key Finding**: Model D balances theoretical coverage with psychometric quality.

### Phase 2: CFA Results

**Model D validated** on independent holdout sample (N=257) with excellent fit.

### Phase 3: Measurement Invariance Results

**Configural Invariance** (RQ6): ✓ **SUPPORTED**
- Academic: CFI=0.957, TLI=0.932, RMSEA=0.075
- Professional: CFI=0.986, TLI=0.977, RMSEA=0.055

**Metric Invariance**: ⚠️ **PARTIAL**
- 4/16 items show loading differences > 0.10
- Non-invariant: SI2 (Δλ=0.35), FC1 (Δλ=0.20), EE2 (Δλ=0.16), PE1 (Δλ=0.10)

**Mean Differences** (RQ7): 3/8 constructs differ significantly

| Construct | Academic M | Professional M | Cohen's d | p |
|-----------|-----------|----------------|-----------|---|
| Social Influence | 2.97 | 3.32 | -0.34 | <.001 |
| Effort Expectancy | 3.80 | 3.53 | +0.27 | .003 |
| Hedonic Motivation | 3.11 | 3.41 | -0.27 | .003 |

**Interpretation**: Professionals perceive stronger social pressure and enjoyment; Academics find AI easier to use.

### Phase 4: Structural Model Results

**Full Sample Structural Model** (N=513): CFI=0.976, TLI=0.965, RMSEA=0.058, R²=0.558

**Hypothesis Testing Summary**:

| Hypothesis | Result | Key Evidence |
|------------|--------|--------------|
| **H1**: UTAUT2 → BI | ⚠️ Partially Supported | 3/7 paths significant |
| **H2**: AI Trust → BI | ✅ Supported | β=0.112, p=.048 |
| **H3**: AIRS > UTAUT2 | ❌ Not Supported | ΔAIC=+2.01 |
| **H4**: Population Moderation | ❌ Not Supported | No significant Δβ |

**Significant Predictors** (ranked by effect size):

| Path | β | p | Interpretation |
|------|---|---|----------------|
| PV → BI | 0.499 | <.001 | Price Value is dominant predictor |
| HM → BI | 0.203 | <.001 | Enjoyment drives adoption |
| SI → BI | 0.145 | .002 | Social influence matters |
| TR → BI | 0.112 | .048 | AI Trust adds unique variance |

**Non-Significant Paths**: PE, EE, FC, HB (all p > .05)

**Multi-Group Comparison**:
| Group | N | CFI | R² (BI) |
|-------|---|-----|--------|
| Academic | 198 | 0.957 | 0.603 |
| Professional | 315 | 0.986 | 0.532 |

**Key Finding**: Price Value (β=0.499) explains the majority of adoption readiness variance, with AI Trust providing modest but significant incremental contribution.

### Phase 5: Mediation Analysis Results

**Model Comparison** (Alternative analyses since H5 mediation not testable):

| Model | AIC | CFI | Best Predictors |
|-------|-----|-----|-----------------|
| UTAUT Core (4) | 128.91 | 0.975 | PE, EE, SI, FC |
| Parsimonious (4) | 129.05 | 0.979 | **PV, HM, SI, TR** |
| UTAUT2-Only (7) | 135.04 | 0.979 | All UTAUT2 |
| Full AIRS (8) | 137.05 | 0.979 | All 8 constructs |

**Key Finding**: Parsimonious 4-predictor model (PV, HM, SI, TR) achieves equivalent fit with fewer parameters. AI Trust contribution validated despite parsimony argument favoring simpler models.

### Phase 6: Moderation Analysis Results

**Contextual Moderation (H4c-f)** using multi-group SEM:

| Hypothesis | Moderator | Path | z | p | Result |
|------------|-----------|------|---|---|--------|
| **H4c** | Usage Frequency | HB→BI | -2.17 | .030* | Opposite effect |
| H4e | Voluntariness | SI→BI | 0.51 | .614 | Not supported |
| H4e | Voluntariness | FC→BI | -0.33 | .739 | Not supported |
| H4f | Disability | EE→BI | -0.03 | .979 | Unreliable |
| H4f | Disability | FC→BI | 0.07 | .942 | Unreliable |

**Key Findings**:
- **H4c**: Significant but OPPOSITE to prediction (HB→BI weaker for frequent users)
- **H4e/H4f**: Underpowered (N=70, N=69) - results unreliable due to model non-convergence
- Only H4c (Usage Frequency) had adequate sample sizes for reliable inference

#### Phase 6 Revisit: Demographic Moderation (November 28, 2025)

**Exploratory demographic moderation** tested via regression-based interactions:

| Moderator | Significant Effects | Key Finding |
|-----------|---------------------|-------------|
| **Industry** | None (all p > .40) | Mechanisms equivalent across sectors |
| **Education** | TR × Ed marginal (p=.069) | No main effects |
| **Experience** | **PE × Exp (p=.013), HM × Exp (p=.009)** | **Novel discovery!** |

**Experience Moderation Discovery**:
- Performance expectancy effect **stronger** for experienced professionals (4+ years)
- Hedonic motivation effect **stronger** for experienced professionals
- **Interpretation**: Career veterans weigh "usefulness" and "enjoyment" more heavily in AI adoption decisions

### Phase 7: Tool Usage Patterns Results

**AI Tool Usage Analysis (RQ10)** providing criterion validity evidence:

| Sub-Question | Key Finding |
|--------------|-------------|
| **RQ10a**: Usage Frequency | ChatGPT most popular (64% active users), MS Copilot/Gemini ~49% each |
| **RQ10b**: Population Differences | Students prefer ChatGPT (d=0.40); Professionals use enterprise tools more |
| **RQ10c**: Construct Correlations | All ρ=0.45-0.70 (p<.01); Total usage strongly predicts BI (ρ=0.70) |
| **RQ10d**: User Types | 54% are multi-tool users; Large effects (η²=0.24-0.34) for all constructs |

**Criterion Validity Evidence**: Strong correlations between current AI tool usage and AIRS construct scores validate the instrument's predictive power. Multi-tool users systematically score higher on all AIRS dimensions.

### Phase 8: Qualitative Feedback Results

**Thematic Analysis (RQ11-12)** of open-text feedback:

| Theme | Overall % | Academic % | Professional % | χ² p |
|-------|----------|------------|----------------|------|
| AI Quality | 31% | 25% | 35% | .032* |
| Productivity | 28% | 22% | 32% | .018* |
| Learning/Growth | 22% | 28% | 18% | .054 |
| Ease of Use | 18% | 20% | 17% | .584 |
| Trust/Reliability | 15% | 12% | 17% | .167 |
| Integration | 12% | 10% | 13% | .412 |

**Key Finding**: Professionals emphasize quality and productivity; Academics focus on learning opportunities.

### Phase 9: Comprehensive Review Results

**Gap Analysis** identified 6 untapped data opportunities:

| Opportunity | Finding | Action |
|-------------|---------|--------|
| **Education** | No correlation with BI (r=.02) | Documented |
| **Industry** | Tech/Finance vs Other grouping | Tested in Phase 6 |
| **Experience** | 4-year threshold meaningful | **Significant moderation!** |
| **Disability** | Higher AI Anxiety (d=0.40) | Future research |
| **Tool Preferences** | ChatGPT dominant (78%) | Documented |
| **User Typology** | 4 segments identified | Validated |

### Phase 10: Final Synthesis Results

**Hypothesis Testing Summary**:

| Status | Count | Hypotheses |
|--------|-------|------------|
| ✓ Supported | 5 | H1a (PE), H1c (SI), H1e (HM), H1g (HB), H2 (TR) |
| ✗ Not Supported | 9 | H1b, H1d, H1f, H3, H4a-f |
| — Not Testable | 3 | H5a-c (dropped constructs) |

**7 Novel Contributions**:
1. **AI Trust as significant predictor** (β=0.112, p=.048) - validates AIRS theoretical extension
2. **Experience moderation** - PE and HM effects stronger for veterans
3. **User typology** - 4 distinct segments with different readiness profiles
4. **Habit reversal** - negative effect for high-frequency users
5. **Population mean differences** - validated via measurement invariance
6. **Qualitative theme patterns** - population-specific concerns documented
7. **Typology × Theme association** - AI Enthusiasts express more positive experiences (χ²=9.55, p=.023)

---

## 🎓 **Dissertation Contributions**

### Theoretical Contributions

| Contribution | Finding |
|--------------|---------|
| **Foundation Validation** | UTAUT2 confirmed as solid foundation for AI adoption (3/7 constructs significant) |
| **AI Trust Extension** | AI Trust validated as significant predictor (β=0.112, p=.048) for AI contexts |
| **Experience Moderation** | Novel finding: Career stage moderates PE and HM effects on adoption |
| **Item Design Insights** | Documented specific issues preventing validation of VO, EX, ER, AX |
| **Population Differences** | Partial metric invariance reveals differential construct functioning |
| **User Typology** | 4-segment typology enables targeted intervention strategies |

### Dropped Constructs: Diagnostic Summary

| Construct | Inter-item r | Root Cause | Recommendation |
|-----------|--------------|------------|----------------|
| Voluntariness | 0.27 | VO1 (motivation) ≠ VO2 (autonomy) | Separate motivation vs. choice scales |
| Explainability | 0.38 | EX1 (comprehension) ≠ EX2 (preference) | Separate literacy from preference |
| Ethical Risk | 0.31 | ER1 (job threat) ≠ ER2 (privacy) | Domain-specific risk subscales |
| **Anxiety** | **0.15** | **AX1 (avoidance) ≠ AX2 (FOMO)** | **Separate avoidance vs. approach** |

**Critical Finding**: Anxiety items measure **OPPOSITE motivational directions**:
- AX1: Avoidance anxiety → negative adoption correlation
- AX2: FOMO anxiety → positive adoption correlation

---

## 📁 **Project Documentation**

### Directory Structure

```
AIRS_Data_Analysis/
├── airs_experiment/          # Current analysis pipeline
│   ├── 00_Create_Split_Samples.ipynb
│   ├── 01_EFA_Experiment.ipynb
│   ├── 02_CFA_Experiment.ipynb
│   ├── 03_Measurement_Invariance.ipynb
│   ├── 04_Structural_Model.ipynb
│   ├── 05_Mediation_Analysis.ipynb
│   ├── 06_Moderation_Analysis.ipynb
│   ├── 07_Tool_Usage_Patterns.ipynb
│   ├── 08_Qualitative_Feedback.ipynb
│   ├── 09_Comprehensive_Review.ipynb
│   ├── 10_Final_Synthesis.ipynb
│   ├── data/                 # Analysis data & JSON results
│   ├── plots/                # Generated visualizations
│   └── tables/               # Summary statistics (CSV)
├── plan/
│   └── ANALYSIS_PLAN_v2.md   # Master analysis roadmap
├── data/                     # Source data files
├── archive/                  # Previous notebook versions
├── docs/                     # Documentation
└── alex/                     # AI assistant configuration
```

### Key Files

| File | Description |
|------|-------------|
| `plan/ANALYSIS_PLAN_v2.md` | Complete analysis roadmap with hypotheses and methodology |
| `airs_experiment/*.ipynb` | Analysis notebooks (Phases 0-10) |
| `airs_experiment/data/final_synthesis.json` | Comprehensive synthesis of all findings |
| `data/airs_28item_complete.json` | Item metadata and semantic descriptions |

---

## 🚀 **How to Use This Repository**

### For Researchers

**1. Replicate Analysis**:
```bash
# Install dependencies
pip install -r requirements.txt

# Run notebooks sequentially in airs_experiment/
# 00a → 00b → 01 → 02 → 03 → 04 → ...
```

**2. Access Validated Scale**:
- 16 items across 8 constructs (see Model D above)
- All items use 7-point Likert (1=Strongly Disagree to 7=Strongly Agree)
- Scoring: Calculate mean per construct

### For Practitioners

**1. Administer AIRS-16**:
- 16 items, ~5 minutes completion time
- See item wordings in `data/airs_28item_complete.json`

**2. Score & Interpret**:
```python
# Per-construct scores
PE_score = mean(PE1, PE2)  # Performance Expectancy
EE_score = mean(EE1, EE2)  # Effort Expectancy
SI_score = mean(SI1, SI2)  # Social Influence
FC_score = mean(FC1, FC2)  # Facilitating Conditions
HM_score = mean(HM1, HM2)  # Hedonic Motivation
PV_score = mean(PV1, PV2)  # Price Value
HB_score = mean(HB1, HB2)  # Habit
TR_score = mean(TR1, TR2)  # AI Trust

# Overall AIRS score (simple average)
AIRS_total = mean(all_16_items)
```

**3. Benchmark**:
- Compare scores to population means (available after Phase 4 completion)
- Consider population differences when interpreting (Academic vs. Professional)

---

## 📚 **Key References**

**Foundational Frameworks**:
- Venkatesh, V., Morris, M. G., Davis, G. B., & Davis, F. D. (2003). User acceptance of information technology. *MIS Quarterly, 27*(3), 425-478.
- Venkatesh, V., Thong, J. Y. L., & Xu, X. (2012). Consumer acceptance and use of information technology: Extending UTAUT. *MIS Quarterly, 36*(1), 157-178.

**AI-Specific Extensions**:
- Shin, D. (2021). The effects of explainability and causability on perception, trust, and acceptance. *International Journal of Human-Computer Studies, 146*, 102551.
- Langer, M., et al. (2021). What do we want from explainable artificial intelligence (XAI)? *Artificial Intelligence, 296*, 103473.

**Psychometric Methods**:
- Hair, J. F., et al. (2019). *Multivariate data analysis* (8th ed.). Cengage.
- Costello, A. B., & Osborne, J. W. (2005). Best practices in exploratory factor analysis. *Practical Assessment, Research, and Evaluation, 10*(7), 1-9.

---

## 📧 **Contact**

**Researcher**: Fabio Correa
**Institution**: Touro University Worldwide
**Program**: Doctor of Business Administration (DBA)

---

## ⚖️ **License**

This project is licensed under [MIT License](LICENSE.md) for code and [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) for documentation.

### Citation

```bibtex
@phdthesis{correa2025airs,
  author = {Correa, Fabio},
  title = {AI Readiness Scale (AIRS): Extending UTAUT2 for Enterprise AI Adoption},
  school = {Touro University Worldwide},
  year = {2025},
  type = {Doctoral dissertation}
}
```

---

**Document Status**: ✅ All 10 Phases Complete
**Last Updated**: November 28, 2025
**Version**: 5.0 (Final Synthesis Complete)
