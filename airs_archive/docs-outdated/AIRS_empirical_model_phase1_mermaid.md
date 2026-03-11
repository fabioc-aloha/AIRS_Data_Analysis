# AIRS Empirical Model (Phase 1 Findings) - Mermaid Diagram

## 2-Factor Structure from Exploratory Factor Analysis
**N=159 • R² = 0.811 • Cronbach's α = 0.897 • 96.3% efficiency vs. 24-item model**

```mermaid
graph LR
    %% Styling
    classDef facilitatorBox fill:#d1fae5,stroke:#059669,stroke-width:3px,color:#065f46
    classDef barrierBox fill:#fecaca,stroke:#dc2626,stroke-width:3px,color:#991b1b
    classDef outcomeBox fill:#bfdbfe,stroke:#1e40af,stroke-width:4px,color:#1e3a8a
    classDef moderatorBox fill:#f1f5f9,stroke:#94a3b8,stroke-width:2px,color:#475569
    classDef unexpectedBox fill:#fed7aa,stroke:#f59e0b,stroke-width:2px,color:#92400e

    %% Moderators (Left)
    subgraph MOD["Contextual Moderators"]
        M1["Role<br/>(Student/Faculty/Professional)"]
        M2["AI Usage Frequency<br/>(Exposure level)"]
        M3["Voluntariness<br/>(Discretionary vs. mandated)"]
        M1 --- M2 --- M3
    end

    %% Factor 1: Mixed Orientation (Center-Top)
    subgraph F1["Factor 1: Mixed Orientation (10 items, loadings 0.62-0.91)"]
        PE1["Performance Expectancy (PE1) 0.81"]
        EE2["Effort Expectancy (EE2) 0.74"]
        SI2["Social Influence (SI2) 0.62"]
        FC1["Facilitating Conditions (FC1) 0.66"]
        HM1["Hedonic Motivation (HM1) 0.83"]
        PV2["Price Value (PV2) 0.91"]
        HB2["Habit (HB2) 0.77"]
        VO1["Voluntariness (VO1)† 0.84"]
        TR1["Trust in AI (TR1) 0.79"]
        EX1["Explainability (EX1)* 0.66"]
        PE1 --- EE2 --- SI2 --- FC1 --- HM1 --- PV2 --- HB2 --- VO1 --- TR1 --- EX1
    end

    %% Factor 2: Risk/Anxiety (Center-Bottom)
    subgraph F2["Factor 2: Risk/Anxiety (2 items, loadings 0.64-0.75)"]
        ER1["Perceived Ethical Risk (ER1) 0.75"]
        AX2["AI-Related Anxiety (AX2) 0.64"]
        ER1 --- AX2
    end

    %% Outcome (Right)
    BI["<b>Behavioral Intention /<br/>AI Readiness</b><br/><br/>R² = 0.811<br/>(96.3% of 24-item model power)"]

    %% Relationships
    MOD -.->|"moderates"| F1
    MOD -.->|"moderates"| F2
    F1 -->|"+ enables"| BI
    F2 -->|"− inhibits"| BI
    F1 -.->|"r = 0.17<br/>(weak positive)"| F2

    %% Apply styles
    class PE1,EE2,SI2,FC1,HM1,PV2,HB2,VO1,TR1,EX1 facilitatorBox
    class ER1,AX2 barrierBox
    class BI outcomeBox
    class M1,M2,M3 moderatorBox

    %% Hide internal connections
    linkStyle 0,1,2,3,4,5,6,7,8,9,10,11,12 stroke:none
```

---

## Key Findings

### Empirical Structure
**12 theoretical constructs converge into 2 empirical dimensions:**
- **Factor 1 (Mixed Orientation)**: 10 items with loadings 0.62-0.91 (PE1, EE2, SI2, FC1, HM1, PV2, HB2, VO1, TR1, EX1)
- **Factor 2 (Risk/Anxiety)**: 2 items with loadings 0.64-0.75 (ER1, AX2)

### Statistical Performance
- **Variance Explained**: 58.1% total (F1: 49.4%, F2: 8.7%)
- **Internal Consistency**: Cronbach's α = 0.897 (excellent)
- **Predictive Validity**: R² = 0.811 (strong)
- **Measurement Efficiency**: 96.3% of 24-item model power with 50% fewer items
- **Inter-factor Correlation**: r = 0.17 (weak positive, supporting discriminant validity)

### Practical Implications
- **Diagnostic granularity preserved**: 12 items allow targeted organizational interventions
- **Predictive parsimony achieved**: 2-factor structure provides parsimonious predictive model
- **Dual utility**: Organizations can assess specific gaps while using simplified model for prediction

### Unexpected Finding
**†Voluntariness (VO1)** serves dual role as both factor item and contextual moderator

**\*Explainability (EX1)** loaded on Factor 1 (0.66) alongside other UTAUT2 and enabler constructs, contrary to initial theoretical expectation of loading with barriers. This suggests perceived AI transparency functions as a readiness facilitator rather than a friction point in this sample.

---

## Phase 2 Next Steps
- Confirmatory Factor Analysis (CFA) on independent holdout sample (N=159)
- Validate 2-factor measurement model
- Investigate Explainability unexpected loading
- Test measurement invariance across role and usage frequency groups
