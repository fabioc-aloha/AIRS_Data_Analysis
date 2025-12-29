# AIRS-16: AI Readiness Scale — Final Validated Instrument

**Source**: Correa, F. (2025). *Artificial Intelligence Readiness Scale: Extending UTAUT2 for Enterprise AI Adoption*. Doctoral dissertation, Touro University Worldwide.

**Validation**: N=523, CFI=.975, TLI=.960, RMSEA=.065, R²=.852

---

## Instrument Overview

The AIRS-16 is a validated 16-item diagnostic instrument measuring 8 constructs grounded in UTAUT2 theory. It uses a 5-point Likert scale (1 = Strongly Disagree to 5 = Strongly Agree).

### Scoring Summary

| Component | Items | Score Range |
|-----------|-------|-------------|
| Each Construct | 2 items | 2-10 (sum) or 1-5 (mean) |
| AIRS Score | 16 items | 8-40 (sum of construct means) |
| Behavioral Intention (BI) | 4 items | 4-20 (outcome variable) |

---

## The 16 Items

### Performance Expectancy (PE)

| Item | Question Text |
|------|---------------|
| **PE1** | AI tools help me accomplish tasks more quickly. |
| **PE2** | Using AI improves the quality of my work or studies. |

### Effort Expectancy (EE)

| Item | Question Text |
|------|---------------|
| **EE1** | Learning to use AI tools is easy for me. |
| **EE2** | Interacting with AI tools is clear and understandable. |

### Social Influence (SI)

| Item | Question Text |
|------|---------------|
| **SI1** | People whose opinions I value encourage me to use AI tools. |
| **SI2** | Leaders in my organization or school support the use of AI tools. |

### Facilitating Conditions (FC)

| Item | Question Text |
|------|---------------|
| **FC1** | I have access to training or tutorials for the AI tools I use. |
| **FC2** | The AI tools I use are compatible with other tools or systems I use. |

### Hedonic Motivation (HM)

| Item | Question Text |
|------|---------------|
| **HM1** | Using AI tools is stimulating and engaging. |
| **HM2** | AI tools make my work or studies more interesting. |

### Price Value (PV) — **STRONGEST PREDICTOR (β=.505)**

| Item | Question Text |
|------|---------------|
| **PV1** | I get more value from AI tools than the effort they require. |
| **PV2** | Using AI tools is worth the learning curve. |

### Habit (HB)

| Item | Question Text |
|------|---------------|
| **HB1** | Using AI tools has become a habit for me. |
| **HB2** | I tend to rely on AI tools by default when I need help with tasks. |

### Trust in AI (TR)

| Item | Question Text |
|------|---------------|
| **TR1** | I trust AI tools to provide reliable information. |
| **TR2** | I trust the AI tools that are available to me. |

---

## Outcome Variable: Behavioral Intention (BI)

| Item | Question Text |
|------|---------------|
| **BI1** | I am ready to use more AI tools in my work or studies. |
| **BI2** | I would recommend AI tools to others. |
| **BI3** | I see AI as an important part of my future. |
| **BI4** | I plan to increase my use of AI tools in the next six months. |

---

## Scoring Algorithm

### Step 1: Calculate Construct Means

```python
# Each construct is the mean of its 2 items
PE = mean(PE1, PE2)  # Performance Expectancy
EE = mean(EE1, EE2)  # Effort Expectancy
SI = mean(SI1, SI2)  # Social Influence
FC = mean(FC1, FC2)  # Facilitating Conditions
HM = mean(HM1, HM2)  # Hedonic Motivation
PV = mean(PV1, PV2)  # Price Value
HB = mean(HB1, HB2)  # Habit
TR = mean(TR1, TR2)  # AI Trust
```

### Step 2: Calculate AIRS Score

```python
# Sum of all construct means (range: 8-40)
AIRS_Score = PE + EE + SI + FC + HM + PV + HB + TR
```

### Step 3: Classify Typology

```python
# Validated 20/30 cut-points (94.5% accuracy)
if AIRS_Score <= 20:
    typology = "AI Skeptic"
elif AIRS_Score <= 30:
    typology = "Moderate User"
else:
    typology = "AI Enthusiast"
```

### Step 4 (Optional): Calculate Behavioral Intention

```python
# Outcome variable (range: 1-5 as mean, or 4-20 as sum)
BI = mean(BI1, BI2, BI3, BI4)
```

---

## Construct Reliability

| Construct | Cronbach's α | CR | AVE |
|-----------|-------------|-----|-----|
| Performance Expectancy (PE) | .803 | .804 | .673 |
| Effort Expectancy (EE) | .859 | .861 | .756 |
| Social Influence (SI) | .752 | .763 | .621 |
| Facilitating Conditions (FC) | .743 | .750 | .601 |
| Hedonic Motivation (HM) | .864 | .865 | .763 |
| Price Value (PV) | .883 | .883 | .790 |
| Habit (HB) | .909 | .909 | .833 |
| Trust in AI (TR) | .891 | .891 | .804 |

*All constructs exceed minimum thresholds: α ≥ .70, CR ≥ .70, AVE ≥ .50*

---

## Structural Model Results

### Significant Predictors of Behavioral Intention

| Construct | β | p | 95% CI | Result |
|-----------|---|---|--------|--------|
| **Price Value (PV)** | **.505** | **<.001** | [.352, .658] | ✅ STRONGEST |
| **Hedonic Motivation (HM)** | **.217** | **.014** | [.044, .390] | ✅ Supported |
| **Social Influence (SI)** | **.136** | **.024** | [.018, .254] | ✅ Supported |
| Trust in AI (TR) | .106 | .064 | [-.006, .218] | ⚠️ Marginal |

### Non-Significant Predictors

| Construct | β | p | Result |
|-----------|---|---|--------|
| Performance Expectancy (PE) | -.028 | .791 | ❌ Not significant |
| Effort Expectancy (EE) | -.008 | .875 | ❌ Not significant |
| Facilitating Conditions (FC) | .059 | .338 | ❌ Not significant |
| Habit (HB) | .023 | .631 | ❌ Not significant |

**Key Finding**: Traditional UTAUT2 predictors (PE, EE, FC, HB) do NOT predict AI adoption. Value perception (PV), enjoyment (HM), and social influence (SI) are what actually matter.

---

## Practitioner Typology

### Classification Thresholds (94.5% Accuracy)

| AIRS Score | Typology | % Sample | Mean BI | Profile |
|-----------|----------|----------|---------|---------|
| ≤ 20 | **AI Skeptics** | 17% | 1.5-2.5 | Low intention, cautious, trust barriers |
| 21-30 | **Moderate Users** | 67% | 2.5-4.0 | Pragmatic, selective engagement |
| > 30 | **AI Enthusiasts** | 16% | 4.0-5.0 | High intention, proactive adoption |

### Intervention Strategies by Typology

| Typology | Primary Barriers | Intervention Focus |
|----------|------------------|-------------------|
| **AI Skeptics** | Low trust, high anxiety, value unclear | Trust-building, low-effort demos, social proof |
| **Moderate Users** | Value uncertainty, inertia | Clear use cases, ROI evidence, peer testimonials |
| **AI Enthusiasts** | Under-utilization | Advanced features, leadership roles, peer mentoring |

---

## Constructs Excluded During Validation

These constructs were administered but removed due to poor reliability (α < .70):

| Construct | Cronbach's α | Reason |
|-----------|-------------|--------|
| Voluntariness (VO) | .406 | Unacceptable reliability |
| Explainability (EX) | .582 | Poor reliability |
| Perceived Ethical Risk (ER) | .546 | Poor reliability |
| AI Anxiety (AX) | .301 | Unacceptable reliability |

---

## Administration Guidelines

### Format
- Online survey (web or mobile)
- Self-administered
- Anonymous responses recommended

### Time
- 16 items: ~3-5 minutes
- With demographics: ~8-10 minutes

### Response Scale
```
1 = Strongly Disagree
2 = Disagree
3 = Neutral
4 = Agree
5 = Strongly Agree
```

### Question Order
Randomize items within each construct to reduce order effects. Present constructs in the order listed above.

---

## Citation

```bibtex
@phdthesis{correa2025airs,
  author = {Correa, Fabio},
  title = {Artificial Intelligence Readiness Scale: Extending UTAUT2 for Enterprise AI Adoption},
  school = {Touro University Worldwide},
  year = {2025},
  type = {Doctoral dissertation},
  url = {https://github.com/fabioc-aloha/AIRS_Data_Analysis}
}
```

---

## License

The AIRS-16 instrument is available for:
- **Academic research**: Free with attribution
- **Commercial use**: Contact author for licensing

**Contact**: Fabio Correa | fabio@correax.com
