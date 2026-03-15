---
title: "AI Readiness, Neurodiversity, and Disability: Insights from the AIRS Study"
subtitle: "Evidence-Based Guidance for Accessible and Calibrated AI Adoption"
author: "Fabio Correa"
date: "2026-03-14"
---

## 🔎 Abstract

This article distills the **neurodiversity and disability insights** from the AI Readiness Scale (AIRS) dissertation study (N = 523). Although AIRS was not designed as a dedicated neurodiversity instrument, **68 participants (13%)** self-identified with a disability, enabling exploratory analysis. Two statistically significant effects emerged: **AI Anxiety** (Cohen's *d* = 0.36, *p* = .006) and **Hedonic Motivation** (*d* = 0.28, *p* = .030). All other readiness constructs trended in the same direction (lower readiness, higher anxiety), forming a consistent disadvantage profile. We propose design, training, and measurement adaptations to reduce anxiety-driven non-adoption and to build a more inclusive AI readiness framework.


## 1. Background and Rationale

- **Adoption-value gap:** 88% of knowledge workers used AI by 2025, but only ~5% of organizations reported measurable value (McKinsey 2025; BCG 2025; MIT Media Lab 2025).
- **Readiness heterogeneity:** The AIRS typology—**31% Enthusiasts, 47% Moderate Users, 22% Skeptics**—already showed the limits of one-size-fits-all adoption strategies.
- **Accessibility lens:** Accessibility barriers and negative prior experiences can manifest as elevated anxiety and suppressed enjoyment, potentially **misdiagnosed as resistance** rather than a design problem.
- **Measurement gap:** AI Anxiety was dropped from the final AIRS-16 due to low reliability (α = .30), yet showed the strongest disability signal, indicating a need to **redesign anxiety items** with neurodiversity-informed language.


## 2. Methods (Overview)

- **Sample:** N = 523 U.S. adults (216 Academic, 184 Professional, 123 Leaders), collected Oct–Nov 2025 via Centiment with topic-blinded recruitment.
- **Disability field:** Single binary item (Yes/No/Prefer not to answer). 68 reported a disability; 11 preferred not to answer.
- **Analysis:** Independent-samples *t* tests and Cohen's *d* effect sizes across the eight AIRS constructs and the dropped AI Anxiety item set. Moderation by disability status was exploratory.

> ⚠️ **Limitations:** Small subgroup (n = 68), binary disability measure (no condition-type differentiation), and cross-sectional design. Results are preliminary but directionally consistent and actionable.


## 3. Key Findings

### 3.1 Significant Effects

| Construct | Disability M (SD) | No Disability M (SD) | Cohen's *d* | *p* |
|---|---|---|---|---|
| **AI Anxiety** (dropped construct) | **2.89 (1.08)** | **2.48 (0.96)** | **0.36** | **.006** |
| **Hedonic Motivation** | **3.45 (0.98)** | **3.72 (0.92)** | **0.28** | **.030** |

- **AI Anxiety:** Elevated anxiety among disabled participants persisted despite the construct’s low reliability—implying the true effect may be stronger with better items.
- **Hedonic Motivation:** Disabled participants reported **less enjoyment** using AI tools, hinting at UX and accessibility issues that reduce the “fun to use” factor.

### 3.2 Consistent Directional Pattern (Non-Significant but Aligned)

All other constructs (Effort Expectancy, Performance Expectancy, Behavioral Intention, Facilitating Conditions, Trust, Social Influence) showed **lower scores for the disability group** (*d* = 0.12–0.24). While individually non-significant, the uniform direction indicates a **coherent disadvantage profile** rather than random noise.

### 3.3 Typology Intersection (Hypothesis)

The **22% Skeptics** segment likely over-represents disabled users, suggesting that at least part of the “resistance” segment may be **accessibility-driven** rather than purely attitudinal. This hypothesis will be tested with condition-specific sampling in AIRS-28.


## 4. Interpretation

- **“Anxiety” is rational when design fails.** Users encountering inaccessible interfaces, missing screen reader support, or opaque error handling develop justified caution. Elevated anxiety is a **signal to improve design**, not a user deficit.
- **Suppressed enjoyment = design debt.** Lower Hedonic Motivation implies that **engagement mechanics and interaction flows** may be less friendly to diverse cognitive styles or assistive tech workflows.
- **Measurement needs a redesign.** AI Anxiety items collapsed avoidance and approach coping, producing low reliability but still detecting a signal. This paradox shows that **properly designed items** could surface stronger, more reliable effects.


## 5. Recommendations

### 5.1 Product & UX (Immediate)
- **Accessibility-first UX audits** for AI workflows (screen reader/touch targets/keyboard navigation/contrast/captioning).
- **Transparent error handling** with plain-language explanations and retry paths.
- **Adjustable cognitive load** (toggle detail levels; chunked guidance; pace controls).
- **Optional scaffolding** (guided modes, tooltips, contextual hints) that can be disabled by power users.

### 5.2 Training & Change Management
- **Anxiety-informed training**: Gradual exposure, psychological safety framing, peer support, and exemplars from neurodivergent/disabled colleagues.
- **Segment-aware sequencing**: Start with low-risk tasks → demonstrate reliability → progress to complex workflows.
- **Accessibility champions**: Identify and empower employees to co-design improvements and act as co-trainers.

### 5.3 Measurement & Research (AIRS-28)
- **Redesign AI Anxiety items** with neurodiversity-informed language; separate dimensions (anticipatory, performance, accessibility, over-reliance concerns).
- **Condition-specific sampling**: Distinguish physical, sensory, cognitive, and neurodevelopmental conditions.
- **Moderation tests**: Evaluate whether accessibility features moderate anxiety effects and whether typology membership shifts with inclusive design.
- **Longitudinal tracking**: Assess whether improvements in accessibility reduce anxiety and increase Hedonic Motivation over time.


## 6. Limitations (Reiterated)
- **Small subgroup (n=68)** limits statistical power and precludes condition-level analysis; replication with larger, stratified samples is needed.
- **Binary measure** obscures diverse conditions and intersectional factors (e.g., ADHD + visual impairment).
- **Cross-sectional**: no causal claims; longitudinal data will test directionality and persistence.
- **Self-report**: Potential underreporting of disability status; 11 chose “Prefer not to answer.”


## 7. Future Work Plan
1. **AIRS-28**: Add 12+ items (3–4 per factor) + redesigned AI Anxiety scale with pilot cognitive interviews across neurodiverse participants.
2. **n > 600** target to properly test Trust (β≈.106) and disability moderation with adequate power.
3. **Longitudinal cohorts**: Baseline, 3, 6, and 12-month follow-ups to test whether reduced anxiety predicts increased adoption.
4. **Cross-cultural** sampling to test if accessibility effects differ across regulatory contexts (e.g., EU AI Act accessibility provisions).
5. **Experimental pilots**: RCTs comparing standard vs accessibility-enhanced AI onboarding; measure anxiety reduction and BI/usage uplift.


## 8. Practitioner Checklist
- [ ] Audit AI workflows for accessibility gaps; ship quick wins in <30 days.
- [ ] Add an **accessibility and anxiety** section to AI rollout playbooks.
- [ ] Implement **graduated autonomy** (human-in-the-loop defaults, adjustable AI control).
- [ ] Track **anxiety and enjoyment** alongside BI and usage in surveys.
- [ ] Involve **disabled and neurodivergent employees** in co-design and pilot testing.


## 9. Conclusion

The AIRS study shows that disability-linked AI Anxiety and reduced Hedonic Motivation are **observable, statistically significant signals**, even with imperfect measurement. These effects likely reflect **design and training gaps** rather than innate resistance. Inclusive design and anxiety-informed rollout practices can convert a “resistance” segment into a ready segment, improving overall adoption and value realization.

By elevating accessibility from a compliance checkbox to a **core adoption driver**, organizations can close both the adoption-value gap and the inclusion gap simultaneously.


## References (Selected)
- Blut, M. et al. (2022). *Meta-analysis of UTAUT2 predictors.*
- Kim, J. (2025). *Annihilation anxiety in AI adoption.*
- Frenkenberg, L. (2025). *Anticipatory anxiety and AI readiness.*
- McKinsey (2025). *Global AI Survey.*
- MIT Media Lab (2025). *Generative AI pilot outcomes.*
- AETHER (2025). *Calibrated AI Reliance (CAIR) and Context-Sensitive Reliance (CSR).*
