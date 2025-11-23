<div align="center">
  <img src="assets/banner.svg" alt="AIRS Data Analysis Project" width="100%">
</div>

---

# **The AIRS Journey: From Theory to Validated Instrument**
## *A Narrative of Discovery, Decisions, and Insights*

<table width="100%">
<tr><td><strong>To</strong></td><td>Dr. Karina Kasztelnik (Dissertation Chair), Dr. Venkatesh (Research Mentor)</td></tr>
<tr><td><strong>From</strong></td><td>Fabio Correa</td></tr>
<tr><td><strong>Date</strong></td><td>November 23, 2025 (Week 24 of 32)</td></tr>
<tr><td><strong>Status</strong></td><td>⚠️ N=362 of target N=500 (Preliminary Results)</td></tr>
</table>

---

## 📖 **The Story So Far**

This is the story of how we built and validated the **AI Readiness Scale (AIRS)**—a journey that began with Dr. Venkatesh's UTAUT2 framework and evolved through data-driven discovery, tough methodological choices, and surprising insights about how people really feel about AI in the workplace.

### **Where We Started: The Theoretical Foundation**

We began with a simple but profound question: *What makes someone ready to adopt AI at work?*

Dr. Venkatesh's UTAUT2 framework (18,000+ citations) gave us eight proven predictors of technology adoption. But AI is different—it makes autonomous decisions, operates as a "black box," and raises ethical concerns that previous technologies didn't. So we extended UTAUT2 with four AI-specific constructs:

| **Construct Type** | **What We Measured** | **Why It Matters** |
|-------------------|---------------------|-------------------|
| **UTAUT2 Foundation (7)** | Performance Expectancy, Effort Expectancy, Social Influence, Facilitating Conditions, Hedonic Motivation, Price Value, Habit | Proven predictors across 20+ years of tech adoption research |
| **Voluntariness (1)** | Reintroduced from UTAUT 2003 | Enterprise AI often feels mandatory—affects autonomy & resistance |
| **AI Enablers (2)** | Trust in AI, Explainability | AI-specific facilitators addressing transparency and reliability concerns |
| **AI Barriers (2)** | Ethical Risk, AI Anxiety | AI-specific barriers addressing moral concerns and fear responses |

**The Research Question**: Can we create a **diagnostic instrument** that organizations can use to assess AI readiness *before* deployment—identifying specific gaps to address?

---

## 🔬 **Phase 1: The Factor Structure Surprise**

### **What We Expected vs. What We Found**

**Expected**: 12 separate factors (one per construct) based on our theoretical model.

**Found**: The data told a different story—**2 broad factors** emerged that cut across our theoretical constructs.

![Figure 1: Scree Plot - The Data Speaks](results/plots/efa_scree_plot_12item.png)
*The parallel analysis line (red) crosses the eigenvalues (blue) after 2 factors, clearly indicating a 2-factor solution.*

### **Decision Point #1: Trust the Theory or Trust the Data?**

This was our first major decision. We could have:
- **Option A**: Force 12 factors to match our theory (common in confirmatory research)
- **Option B**: Accept the 2-factor structure the data revealed (data-driven approach)

**We chose Option B.** Here's why:

| **Rationale** | **Evidence** |
|--------------|-------------|
| **Parsimony** | Simpler models are more practical for organizational use |
| **Empirical Support** | Parallel analysis definitively indicated 2 factors |
| **Theoretical Coherence** | The 2 factors made conceptual sense (see below) |
| **Generalizability** | Overfitted 12-factor models often fail in new samples |

### **What the Factors Mean**

![Figure 2: Factor Loadings Heatmap - Which Items Load Where](results/plots/efa_loadings_heatmap_12item.png)
*Darker green = stronger loading. Blue borders = primary loadings ≥0.50. Notice how items cluster into two distinct patterns.*

**Factor 1: Mixed Readiness (10 items)** - *The "Can I? Should I?" Factor*
- Combines UTAUT2 facilitators (PE, EE, SI, FC, HM, PV, HB) with trust and explainability
- Represents overall psychological readiness and organizational support
- **α=0.924** (excellent reliability)

**Factor 2: Risk/Anxiety (2 items)** - *The "What Could Go Wrong?" Factor*
- Ethical concerns and fear responses
- Represents barriers that must be overcome
- **α=0.691** (adequate reliability for 2-item scale)

### **Key Insight #1: AI Readiness Is Two-Dimensional**

> *People don't evaluate AI adoption on 12 separate dimensions. They ask two simpler questions: (1) "Am I ready and supported?" and (2) "What are the risks?" This has profound implications for intervention design.*

---

## 🛡️ **Phase 2: The Validation Gauntlet**

### **Decision Point #2: How Do We Prove This Isn't Just Overfitting?**

Finding a factor structure in one sample is easy. Proving it replicates in a *new* sample is hard. We implemented a rigorous split-sample design:

| **Sample** | **N** | **Purpose** | **Methods** |
|-----------|------|------------|------------|
| **Development** | 181 | Discover structure | EFA, reliability, item selection |
| **Holdout** | 181 | Independent validation | CFA, fit assessment |
| **Full Sample** | 362 | Invariance testing | Multi-group CFA |

**Why This Matters**: Most studies use the same data for discovery *and* validation, inflating fit statistics. Our approach provides true independent confirmation.

![Figure 3: Sample Split Stratification Validation](results/plots/sample_split_stratification.png)
*Four-panel validation proving our split-sample strategy: (1) Work Context balanced across samples, (2) AI Adoption balanced across samples, (3) Both samples exceed N≥150 threshold, (4) Chi-square tests confirm independence (p>0.05). This rigorous stratification ensures equivalent samples for discovery and validation.*

### **The CFA Results: Does the Model Hold?**

![Figure 4: CFA Factor Loadings & Reliability](results/plots/cfa_figure1_loadings_reliability.png)
*All standardized loadings ≥0.519 (adequate) with most >0.80 (excellent). Reliability metrics exceed recommended thresholds.*

![Figure 5: Model Fit & Discriminant Validity](results/plots/cfa_figure2_model_fit_validity.png)
*CFI=0.952 (excellent), RMSEA=0.080 (acceptable). HTMT ratios <0.85 confirm factors are distinct.*

### **Psychometric Quality Assessment**

| **Metric** | **Factor 1: Readiness** | **Factor 2: Risk/Anxiety** | **Benchmark** | **Status** |
|-----------|------------------------|---------------------------|--------------|-----------|
| **Cronbach's α** | 0.924 | 0.691 | ≥0.70 | ✅ F1 Excellent / ✅ F2 Adequate |
| **Composite Reliability** | 0.923 | 0.765 | ≥0.70 | ✅ Both Exceed |
| **AVE** | 0.554 | 0.640 | ≥0.50 | ✅ Both Exceed |
| **CFI** | 0.952 | — | ≥0.90 | ✅ Excellent |
| **RMSEA** | 0.080 | — | ≤0.08 | ✅ Acceptable |

### **Key Insight #2: Strong Evidence from Independent Validation**

> *The 2-factor structure isn't just a statistical artifact—it replicates in an independent sample with excellent psychometric properties. This gives us confidence to proceed to hypothesis testing.*

---

## 🌍 **Phase 3: The Invariance Challenge**

### **The Question**: Does AIRS Work the Same Way for Everyone?

We needed to test whether our scale measures AI readiness consistently across different groups:
- Students vs. professionals
- Low vs. high AI usage
- Non-adopters vs. adopters

**Why This Matters for Your Research, Dr. Kasztelnik**: If the scale doesn't show measurement invariance, we can't meaningfully compare groups—our moderation hypotheses (H4a-H4e) would be testing artifacts, not real differences.

### **Decision Point #3: Three Levels of Invariance**

| **Invariance Level** | **What It Tests** | **Our Result** | **Implication** |
|---------------------|------------------|----------------|----------------|
| **Configural** | Same factor structure across groups | ✅ **SUPPORTED** (CFI 0.922-0.946) | Constructs exist in all groups |
| **Metric** | Same factor loadings across groups | ❌ **NOT SUPPORTED** (ΔCFI > 0.01) | Items weighted differently by group |
| **Scalar** | Same item intercepts across groups | ❌ **NOT SUPPORTED** (ΔCFI > 0.01) | Different baseline response patterns |

![Figure 6: Invariance Testing Decision Matrix](results/plots/invariance_decision_matrix.png)
*Configural invariance established, but metric/scalar invariance failed. This fundamentally changes our analytical approach.*

![Figure 7: Comprehensive Invariance Dashboard](results/plots/invariance_comprehensive_dashboard.png)
*CFI comparison shows >0.01 drops when constraining loadings (metric) and intercepts (scalar), indicating non-invariance.*

### **The Surprise Discovery: Constructs Function Differently Across Contexts**

This wasn't a failure—it was a **theoretically meaningful finding**. But which items were driving the non-invariance?

![Figure 8: Item-Level Loading Differences Across Groups](results/plots/invariance_loading_differences.png)
*Visual evidence of metric non-invariance: EX1 (Explainability), VO1 (Voluntariness), SI1 (Social Influence), and FC1 (Facilitating Conditions) show substantial loading differences (Δλ > 0.15) across Role, Usage, and Adoption groups. Color intensity indicates magnitude of difference—darker colors reveal items that function fundamentally differently by context.*
- A professional weighing "Explainability" (λ=0.830) far more heavily than a student (λ=0.349) isn't measurement error
- It reflects **real contextual differences**: professionals face accountability pressures that students don't
- High AI users perceive "Voluntariness" differently (λ=0.642) than novices (λ=1.116)—experience reduces perceived coercion
- Social influence operates differently in academic vs. professional settings

**Key Loading Differences**:
```
EX1 (Explainability):    Students 0.349 vs. Professionals 0.830 (Δλ=0.481)
VO1 (Voluntariness):     High Usage 0.642 vs. Low Usage 1.116 (Δλ=0.474)
SI1 (Social Influence):  Students 0.705 vs. Professionals 0.983 (Δλ=0.278)
FC1 (Facilitating Cond): Students 0.440 vs. Professionals 0.825 (Δλ=0.385)
```

### **Key Insight #3: Context Shapes AI Readiness in Fundamental Ways**

> *The failure of metric invariance isn't a psychometric flaw—it's a substantive finding. AI readiness isn't just about individual differences; it's about how organizational contexts fundamentally shape what matters for adoption. This requires us to use separate-group models for moderation testing (H4).*

### **Decision Point #4: How Do We Proceed with H4?**

| **Original Plan** | **Revised Plan** | **Rationale** |
|------------------|------------------|--------------|
| Multi-group SEM with equality constraints | Separate structural models per group | Can't constrain parameters that aren't equivalent |
| Test moderation via interaction terms | Compare path coefficients across groups | More appropriate for non-invariant measures |
| Report pooled effects | Report context-specific effects | Honors the contextual nature of AI readiness |

---

## 🎯 **The Road Ahead: From Measurement to Prediction**

### **Our Validated Instrument**

After three phases of rigorous testing, we now have a **12-item, 2-factor AI Readiness Scale** with:
- ✅ Empirically-derived structure (data-driven factor discovery)
- ✅ Independent replication (split-sample validation)
- ✅ Strong psychometric properties (α=0.924 for F1, adequate reliability for F2)
- ✅ Configural invariance across contexts (constructs exist universally)
- ⚠️ Context-dependent weighting (metric non-invariance signals meaningful differences)



---

## 📊 **Key Insights Summary: What We Learned**

| **Phase** | **Discovery** | **Decision Impact** | **Status** |
|-----------|--------------|-------------------|-----------|
| **Phase 1** | Data reveals 2 factors, not 12 | Trust empirical structure over theoretical expectations | ✅ Structure validated |
| **Phase 2** | Strong psychometric properties in independent sample | Proceed with confidence to hypothesis testing | ✅ Measurement confirmed |
| **Phase 3** | Metric non-invariance across contexts | Use separate-group models; frame H4 as exploratory | ✅ Approach revised |



---


---

## 🚀 **What's Next: The Hypothesis Testing Journey**

Now that we have a validated measurement instrument, we can finally test the theoretical predictions that motivated this research. Here's the roadmap:

### **Phase 4-7 Preview: Testing Our Hypotheses** (⏭️ Starting Now)

| **Research Question** | **Hypotheses** | **Method** | **What Success Looks Like** |
|---------------------|---------------|-----------|---------------------------|
| **RQ2**: Do UTAUT2 constructs predict AI adoption? | H1: UTAUT2 constructs → BI | Structural model | R²≥0.30, significant paths |
| **RQ3**: Does AIRS add value beyond UTAUT2? | H2: AI constructs → BI<br>H3: ΔR²≥0.10 | Nested model comparison | Significant ΔR², improved fit |
| **RQ4**: What are the psychological mechanisms? | H5a-c: Trust/Anxiety mediation | Bootstrap CIs (5000) | Significant indirect effects |
| **RQ5**: Does context matter? | H4a-e: Moderation effects | Separate-group models | Different path coefficients |

### **The Story We're About to Tell**

**Act I (Phase 4)**: Does the extended UTAUT2 framework work?
- Test whether our 12 constructs predict behavioral intention
- Compare baseline UTAUT2 vs. full AIRS model
- **Stakes**: If ΔR²<0.10, AI-specific constructs don't add value

**Act II (Phase 5)**: How does explainability increase adoption?
- Test trust as mediator between explainability and intention
- Test anxiety as mediator between ethical risk and intention
- **Stakes**: Reveals psychological mechanisms for intervention design

**Act III (Phase 6)**: Why does context shape readiness differently?
- Compare path coefficients across students/professionals
- Explore why explainability matters more to professionals
- **Stakes**: Informs context-specific deployment strategies

### **Expected Contributions**

| **Contribution Type** | **What This Research Adds** |
|----------------------|---------------------------|
| **Theoretical** | Validates AI-specific constructs as meaningful UTAUT2 extensions; reveals 2-factor empirical structure |
| **Methodological** | Demonstrates split-sample rigor; construct-balanced design; data-driven factor determination |
| **Practical** | 12-item diagnostic tool (50% shorter than preliminary version); identifies specific intervention targets |

---

## 📂 **Technical Documentation**

### **Analysis Notebooks** (airs/ directory)

| **Notebook** | **Purpose** | **Status** | **Key Output** |
|-------------|-----------|-----------|---------------|
| `00_Create_Split_Samples.ipynb` | Stratified split creation | ✅ Complete | Dev (N=181), Holdout (N=181) |
| `01_EFA_Construct_Balanced_12_Item.ipynb` | Factor discovery | ✅ Complete | 2-factor structure, α=0.845 |
| `02_CFA_Measurement_Model.ipynb` | Independent validation | ✅ Complete | CFI=0.952, RMSEA=0.080 |
| `03_Measurement_Invariance.ipynb` | Context testing | ✅ Complete | Configural ✓, Metric ✗ |
| `04_Structural_Model_*.ipynb` | Hypothesis testing H1-H3 | ⏭️ Next | Path coefficients, R² |
| `05_Mediation_Analysis.ipynb` | H5 mediation | ⏳ Pending | Indirect effects |
| `06_Moderation_Analysis.ipynb` | H4 separate-group | ⏳ Pending | Context-specific paths |


---

## 💡 **Practical Implications: What Organizations Can Do With AIRS**

### **The Dual-Purpose Design**

Our 12-item scale serves two distinct functions:

| **Purpose** | **How It Works** | **Use Case** |
|------------|-----------------|-------------|
| **Diagnostic** | 12 constructs reveal specific gaps | *"Our team scores low on Trust (TR2) but high on Performance Expectancy (PE2)"* → Implement transparency initiatives |
| **Predictive** | 2 factors predict adoption likelihood | *"Overall Readiness high, Risk/Anxiety low"* → Proceed with deployment |

### **Decision Support for Deployment**

**Scenario 1: High Facilitators, Low Barriers** (Ideal)
- Deploy AI widely
- Focus on sustaining positive perceptions
- Monitor for emerging concerns

**Scenario 2: Mixed Facilitators, High Barriers** (Common)
- Address specific barriers first (e.g., ethical concerns via governance)
- Phase deployment with early adopters
- Use success stories to build trust

**Scenario 3: Low Facilitators, High Barriers** (High Risk)
- Delay deployment pending readiness interventions
- Invest in training, infrastructure, change management
- Address psychological barriers through communication

### **Efficiency Achievement**

| **Metric** | **24-Item Preliminary** | **12-Item AIRS** | **Gain** |
|-----------|------------------------|------------------|----------|
| **Items** | 24 | 12 | 50% reduction |
| **Time** | ~10 minutes | ~5 minutes | 50% faster |
| **R² (BI)** | 0.842 | 0.811 | 96.3% retained |
| **Diagnostic Coverage** | 12 constructs | 12 constructs | 100% maintained |

---

## 📚 **Key References**

**Foundational Works**:
- **Venkatesh et al. (2012)**: UTAUT2 framework (18,000+ citations)
- **Hu & Bentler (1999)**: Model fit criteria (CFI, RMSEA thresholds)
- **Hair et al. (2010)**: SEM best practices
- **Chen (2007)**: Measurement invariance thresholds
- **Langer et al. (2023)**: Trust in AI model
- **Shin (2021)**: Explainability effects

*Complete bibliography (40+ sources) in `docs/AIRS DBA Project Proposal v4.md`*

---

## 📚 **Documentation**

**Analysis Files**: `airs/ANALYSIS_PLAN.md` | `airs/CONSISTENCY_CHECK.md`
**Theory & Methods**: `docs/AIRS DBA Project Proposal v4.md` | `docs/DATA_DICTIONARY.md`
**Notebooks**: `airs/00-03_*.ipynb` (Phases 1-3 complete)
**Archive**: `archive/notebooks_exploratory/` (N=281 exploratory phase)
---

## 🔮 **Future Research Directions**

### **Immediate Next Steps** (Weeks 25-32)

| **Week** | **Phase** | **Deliverable** |
|---------|----------|----------------|
| 25-26 | Phase 4: Structural Models | H1-H3 hypothesis tests, nested model comparison |
| 27-28 | Phase 5: Mediation | Trust/anxiety pathways with bootstrap CIs |
| 29-30 | Phase 6: Moderation | Separate-group models, context-specific effects |
| 31-32 | Phase 7: Integration | Dissertation Chapter 4 draft |

### **Broader Research Agenda**

**Cross-Context Validation**
- Healthcare AI (diagnostic tools, treatment recommendations)
- Autonomous systems (self-driving vehicles, drones)
- Creative AI (content generation, design assistance)
- Educational AI (personalized tutoring, assessment)

**Longitudinal Tracking**
- How does readiness change as AI becomes ubiquitous?
- Do early barriers (anxiety, ethical concerns) diminish over time?
- Can AIRS predict long-term adoption sustainability?

**Intervention Validation**
- Test whether addressing low-scoring constructs improves adoption
- Compare intervention effectiveness across contexts
- Measure ROI of readiness assessment vs. blind deployment

---

## 📬 **Contact & Collaboration**

**Student**: Fabio Correa
**Email**: fcorrea@student.touro.edu
**Institution**: Touro University Worldwide
**Program**: Doctor of Business Administration (DBA)
**Chair**: Dr. Karina Kasztelnik
**Mentor**: Dr. Venkatesh

**Repository**: [github.com/fabioc-aloha/AIRS_Data_Analysis](https://github.com/fabioc-aloha/AIRS_Data_Analysis)

---

## 🙏 **Acknowledgments**

This research stands on the shoulders of giants:

- **Dr. Venkatesh**: For the UTAUT2 framework that anchors this work
- **Study Participants (N=362)**: Knowledge workers who shared their AI experiences
- **Dr. Karina Kasztelnik**: For guidance navigating the dissertation journey
- **Committee Members**: Dr. Jerome Jones, Dr. Donna Day for their oversight
- **Open-Source Community**: Python developers enabling reproducible science

---

**Last Updated**: November 23, 2025 | **Status**: Week 24 of 32 | **Progress**: Phases 1-3 Complete ✅
