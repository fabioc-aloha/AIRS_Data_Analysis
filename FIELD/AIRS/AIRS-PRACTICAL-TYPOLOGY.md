# AIRS Practical Typology: Simplified Classification Framework

**Source**: AIRS Validation Study (N=523), December 2025
**White Paper Version**: 2.0

---

## Executive Summary

This document presents a practical classification framework for categorizing users based on their AI readiness. The **AIRS-16** (AI Readiness Scale) measures readiness across 8 constructs grounded in UTAUT2 theory, producing an **AIRS Score** that enables simple, actionable segmentation.

### Key Metrics

| Metric | Value | Interpretation |
|--------|-------|----------------|
| Classification Accuracy | 94.5% | Agreement with multivariate clustering |
| Effect Size (η²) | 0.666 | Large effect (Cohen, 1988) |
| AIRS-BI Correlation | r = 0.876 | Strong criterion validity |
| Variance Explained | 76.8% | AIRS Score predicts Behavioral Intention |

### The Three Typologies

| AIRS Score | Typology | Behavioral Profile |
|-----------|----------|-------------------|
| **≤ 20** | AI Skeptics | Low intention to adopt AI tools |
| **21-30** | Moderate Users | Selective, pragmatic AI engagement |
| **> 30** | AI Enthusiasts | High intention, proactive adoption |

---

## Why 20 and 30 Cut-Points?

### Empirical Derivation

The practical thresholds were derived from comparing simplified classification against multivariate k-means clustering on the 8 AIRS-16 constructs.

| Method | Accuracy vs K-Means | Misclassifications |
|--------|--------------------|--------------------|
| Optimized Cut-Point (21.1, 30.8) | 98.9% | 4-6 |
| **Practical Cut-Point (20, 30)** | **94.5%** | **24-29** |
| Decision Tree | 95.0% | 26 |

### Rationale for Rounding

| Consideration | Rationale |
|--------------|-----------|
| **Memorability** | Round numbers are easier for practitioners to remember |
| **Communication** | Simple thresholds enable consistent interpretation |
| **Minimal accuracy loss** | 94.5% vs 98.9% — only ~4% trade-off |
| **Preserved effect size** | η² = 0.666 vs 0.654 — actually slightly improved |
| **Boundary cases only** | All misclassifications occur within ±1.5 points of thresholds |

---

## Typology Profiles

### AI Skeptics (AIRS Score ≤20)

**Population**: ~17% of sample

| Dimension | Finding |
|-----------|---------|
| Behavioral Intention | Low (Mean BI ≈ 1.5-2.5) |
| Performance Expectancy | Low (-1.16σ) — Skeptical AI will help |
| Trust in AI | Low (-1.49σ) — Significant distrust |
| AI Anxiety | High (+0.76σ) — Strong concerns |

**Profile**: Cautious, risk-averse users who may lack confidence in AI capabilities or have concerns about trust and effort required. Will not adopt without significant intervention.

**Intervention Focus**:
- Address trust barriers directly
- Demonstrate low-effort entry points
- Provide social proof from trusted peers
- Human support and opt-out options
- Gradual exposure, not feature pushing

### Moderate Users (AIRS Score 21-30)

**Population**: ~67% of sample (largest segment)

| Dimension | Finding |
|-----------|---------|
| Behavioral Intention | Moderate (Mean BI ≈ 2.5-4.0) |
| Performance Expectancy | Average (+0.26σ) — Neutral on AI productivity |
| Trust in AI | Average (+0.01σ) — Neither trusting nor distrusting |
| AI Anxiety | Moderate (+0.42σ) — Some mild concerns |

**Profile**: Pragmatic adopters who see value but remain selective. They balance benefits against perceived costs and will follow the crowd. Could go either way.

**Intervention Focus**:
- Highlight specific, relevant use cases
- Address remaining barriers systematically
- Leverage existing habits and workflows
- Provide ROI calculators and case studies
- Show that peers are adopting (social proof)

### AI Enthusiasts (AIRS Score >30)

**Population**: ~16% of sample

| Dimension | Finding |
|-----------|---------|
| Behavioral Intention | High (Mean BI ≈ 4.0-5.0) |
| Performance Expectancy | High (+1.42σ) — Strong belief AI improves productivity |
| Trust in AI | High (+1.37σ) — Confident in AI reliability |
| AI Anxiety | Low (-0.86σ) — Comfortable with AI uncertainty |

**Profile**: Early adopters with strong positive attitudes across all readiness dimensions. High engagement, low barriers. Already sold on AI.

**Intervention Focus**:
- Provide advanced capabilities and features
- Create leadership opportunities
- Assign peer mentoring roles
- Early access programs and beta testing
- Platform to share success stories

---

## Segment Distribution

| Segment | n | Share | Key Driver | Primary Barrier | Effort Required |
|---------|---|-------|------------|-----------------|-----------------|
| **Enthusiasts** | 84 | 16% | Already sold | None | Low (maintain) |
| **Cautious** | 157 | 30% | Proof of value | Anxiety + uncertainty | Medium |
| **Moderate** | 191 | 37% | Social proof | Inertia | Medium |
| **Anxious** | 91 | 17% | Nothing yet | Deep distrust | High |

**Note**: The 4-segment model (from k-means clustering) maps to the 3-typology model:
- AI Enthusiasts = Enthusiasts (16%)
- Moderate Users = Cautious (30%) + Moderate (37%) = 67%
- AI Skeptics = Anxious Avoiders (17%)

---

## Implementation Guide

### For Researchers

```python
# AIRS Score calculation
AIRS_Score = PE + EE + SI + FC + HM + PV + HB + TR

# Classification function
def classify_typology(airs_score):
    if airs_score <= 20:
        return "AI Skeptic"
    elif airs_score <= 30:
        return "Moderate User"
    else:
        return "AI Enthusiast"
```

### For Practitioners (Self-Assessment)

1. Complete the 16-item AIRS questionnaire
2. Calculate construct means (mean of 2 items each)
3. Sum all 8 construct means to get AIRS Score (range: 8-40)
4. Compare AIRS Score to thresholds:
   - **20 or below**: AI Skeptic profile
   - **21 to 30**: Moderate User profile
   - **Above 30**: AI Enthusiast profile

### Reporting Standards

When reporting AIRS typology results:
- Specify classification method: "Practical cut-point (20/30)"
- Report sample distribution across types
- Include mean BI by typology for validation
- Acknowledge boundary case limitations (±1.5 points of thresholds)

---

## Validation Evidence

### Classification Accuracy

| Method | Accuracy vs K-Means | Notes |
|--------|---------------------|-------|
| Optimized Cut-Point (21.1, 30.8) | 98.9% | Maximum possible |
| **Practical Cut-Point (20, 30)** | **94.5-95.4%** | Recommended |
| Decision Tree | 95.0% | Similar accuracy |

### Effect Size Comparison (η² for Behavioral Intention)

| Method | η² | Interpretation |
|--------|-----|----------------|
| NB11 K-Means (8 constructs) | 0.659 | Large |
| Optimized Cut-Point | 0.654 | Large |
| **Practical Cut-Point (20/30)** | **0.666** | **Large** |

The practical thresholds explain **66.6% of variance** in Behavioral Intention — equivalent to or better than complex multivariate methods.

### Criterion Validity

- **AIRS-BI Correlation**: r = 0.876 (p < .001)
- **R²**: 0.768 (76.8% of BI variance explained by AIRS Score alone)
- **Interpretation**: Strong correlation (r > 0.70) indicates excellent criterion validity

---

## Strategic Resource Allocation

Based on the typology distribution:

| Segment | % Market | Movability | Investment Priority |
|---------|----------|------------|---------------------|
| **AI Enthusiasts** | 16% | Already converted | Low (maintain engagement) |
| **Cautious + Moderate** | 67% | High — most movable | **HIGH PRIORITY** |
| **AI Skeptics** | 17% | Difficult | Low-Medium (high effort, uncertain returns) |

**Key Insight**: The Cautious Adopters (30%) and Moderate Users (37%) represent 67% of the market and are most movable. Focus resources here for maximum ROI.

---

## Citation

```bibtex
@techreport{correa2025typology,
  author = {Correa, Fabio},
  title = {AIRS Practical Typology: A Simplified Classification Framework for AI Readiness},
  year = {2025},
  type = {White Paper},
  institution = {AIRS Research},
  note = {Based on AIRS Validation Study (N = 523)}
}
```

---

**Full Research Data**: [github.com/fabioc-aloha/AIRS_Data_Analysis](https://github.com/fabioc-aloha/AIRS_Data_Analysis)

*© 2025 AIRS Research. This document may be shared for educational and research purposes with attribution.*
