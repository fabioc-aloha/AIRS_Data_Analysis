# AIRS Dissertation Fact-Check Audit

**Audit Date:** March 11, 2026
**R/lavaan Cross-Validation:** June 10, 2025
**R CFA Pipeline (13 scripts):** March 11, 2026
**Source of Truth:** R 4.5.2 / lavaan 0.6.21 full pipeline (`airs_experiment/R/run_00`–`run_12`), cross-validation script (`run_r_validation.R`), `AIRS_clean.csv` (N=523)
**Correction Tracker:** See [CORRECTION_TRACKER.md](CORRECTION_TRACKER.md) for line-by-line thesis fix plan.

---

## Quick Reference: Decision Dashboard

**How to use**: ✅ **ALL EDITS APPLIED.** All 11 discrepancies have been resolved in the thesis. The audit data tables below preserve the original findings for reference. See [Strategic Recommendations](docs/AIRS-STRATEGIC-RECOMMENDATIONS.md) for decision rationale.

| # | Issue | Severity | Ch3 Status | Ch4–6 Status | Decision Needed? |
|---|-------|----------|------------|--------------|-----------------|
| D1 | SRMR values (.048 vs .022–.026) | Moderate | ✅ Software table updated | ✅ Ch4 + Ch5 fixed | No — replaced with lavaan values |
| D2 | R² = .852 vs .896/.897 | Moderate | — | ✅ Ch4 fixed (.897) | No — replaced with .897 |
| D3 | Bootstrap CIs fabricated | **Critical** | — | ✅ Table 4.10 footnoted, Table 4.11b added | ✅ RESOLVED — z-test + bootstrap caveat |
| D4 | 4 clusters vs 3 clusters | **Critical** | ✅ All chapters fixed | ✅ All chapters fixed | ✅ RESOLVED — Full 3-cluster rewrite applied |
| D5 | Discriminant validity overclaim | **Critical** | ✅ §3.7.3 now acknowledges violations + HTMT | ✅ Ch4 rewritten, Ch5 §5.2.4 added | ✅ RESOLVED — False claims removed + diagnostic framing |
| D6 | Per-group fit values wrong | Moderate | — | ✅ Table 4.9 rewritten | No — replaced with lavaan values |
| D7 | AI Trust extension not supported | **Critical** | — | ✅ Ch4/5/6 reframed | ✅ RESOLVED — Diagnostic inclusion + power analysis + 2026 context |
| D8 | p = .009 vs .007 | Minor | — | ✅ All 8 locations fixed | No — replaced .009 with .007 |
| D9 | PAF vs MINRES mismatch | Moderate | ✅ §3.6.3 fixed to MINRES | — | No — already corrected |
| D10 | "Thematic analysis" misnomer | Low | ✅ §3.6.9 relabeled | — | No — already corrected |
| D11 | Software table Python-only | Low | ✅ §3.6.10 dual-language table | — | No — already corrected |

**Summary**: ✅ **ALL 11 ITEMS RESOLVED.** All mechanical fixes applied to Ch4–6. All judgment-required fixes implemented with strategic framing. All strategic additions (2026 context, hypotheses, research roadmap, diagnostic framing, discriminant validity discussion, bibliography) integrated. See [AIRS-STRATEGIC-RECOMMENDATIONS.md](docs/AIRS-STRATEGIC-RECOMMENDATIONS.md) for decision rationale.

---

## Executive Summary

**11 discrepancies** identified between the thesis manuscript and verified analysis outputs. All confirmed via independent cross-checking against both Python pipeline results and the full R/lavaan pipeline (13 R scripts + 1 cross-validation script).

| Category | Count | Impact |
|----------|-------|--------|
| Critical (data contradicts thesis claim) | 5 | Structural paths, typology, discriminant validity, CIs, Trust extension |
| Moderate (values wrong but conclusion direction holds) | 4 | SRMR, R², per-group fits, EFA method |
| Minor/Low (rounding, labeling) | 2 | p-value rounding, method label |

### What Holds Up

- **Measurement model (CFA)**: Excellent fit confirmed by R/lavaan — CFI=.975, TLI=.960, RMSEA=.065, SRMR=.026 (holdout). Actually *better* than thesis claimed.
- **PriceValue → BI dominance**: The only bootstrap-robust path (lavaan CI [0.218, 1.083], p=.018). PV-based recommendations have empirical grounding.
- **R² = .896–.897**: Model collectively explains substantial variance (confirmed by both Python and R). Higher than the thesis's .852 claim.
- **All reliability metrics**: CR ≥ .750, AVE ≥ .601, α ≥ .743 across all 8 factors (R CFA confirms exactly).
- **All 16 factor loadings**: λ = .689–.920, all p < .001 (R CFA confirms exactly).
- **Sample characteristics**: N=523, split, demographics, KMO, Bartlett — all verified.

### What Doesn't Hold Up

1. **Fabricated bootstrap CIs** — Only PV→BI is genuinely significant; HM and SI CIs include zero per lavaan bootstrap.
2. **4-segment typology is wrong** — Data yields 3 clusters (k=4 silhouette=0.226 < threshold).
3. **Discriminant validity falsely claimed** — 5 Fornell-Larcker violations, 4 HTMT flags. Thesis claims "all |r| < .85."
4. **AI Trust extension not supported** — Δχ²=3.05 (p=.081), ΔAIC=+2.01. Simpler model wins.
5. **SRMR and per-group fit values incorrect** — Thesis .048 vs lavaan .022–.026.

---

## R Pipeline Results (March 11, 2026)

### CFA Fit Indices (R/lavaan 0.6.21)

| Metric | Holdout (n=262) | Full (N=523) | Thesis | Match? |
|--------|----------------|--------------|--------|--------|
| χ² | 159.38 (df=76) | 222.52 (df=76) | 159.38 | ✅ |
| CFI | **.975** | .979 | — | ✅ |
| TLI | **.960** | .966 | — | ✅ |
| RMSEA | **.065** [.051, .079] | .061 | — | ✅ |
| SRMR | **.026** | **.022** | .048 | ❌ |
| AIC | 9905.25 | 19671.62 | — | — |

### Factor Loadings (R/lavaan, holdout)

| Factor | Item | λ | SE | z | Sig |
|--------|------|---|----|----|-----|
| PerfExp | PE1 | .798 | .027 | 29.49 | *** |
| PerfExp | PE2 | .842 | .024 | 34.96 | *** |
| EffortExp | EE1 | .831 | .028 | 30.10 | *** |
| EffortExp | EE2 | .906 | .024 | 37.16 | *** |
| SocialInf | SI1 | .876 | .031 | 28.19 | *** |
| SocialInf | SI2 | .689 | .039 | 17.63 | *** |
| FacilCond | FC1 | .717 | .039 | 18.51 | *** |
| FacilCond | FC2 | .829 | .034 | 24.17 | *** |
| HedonicMot | HM1 | .839 | .022 | 38.17 | *** |
| HedonicMot | HM2 | .907 | .017 | 53.01 | *** |
| PriceValue | PV1 | .888 | .018 | 50.89 | *** |
| PriceValue | PV2 | .890 | .017 | 51.20 | *** |
| Habit | HB1 | .905 | .017 | 53.24 | *** |
| Habit | HB2 | .920 | .016 | 57.24 | *** |
| AITrust | TR1 | .875 | .019 | 46.38 | *** |
| AITrust | TR2 | .917 | .016 | 57.04 | *** |

All loadings ≥ .689. 15/16 ≥ .717. SI2 (.689) is the weakest but still acceptable.

### Reliability (R/lavaan, holdout)

| Factor | CR | AVE | α | CR ≥ .70? | AVE ≥ .50? |
|--------|-----|-----|---|-----------|------------|
| PerfExp | .805 | .673 | .803 | ✅ | ✅ |
| EffortExp | .861 | .756 | .859 | ✅ | ✅ |
| SocialInf | .764 | .621 | .752 | ✅ | ✅ |
| FacilCond | .750 | .601 | .743 | ✅ | ✅ |
| HedonicMot | .865 | .763 | .864 | ✅ | ✅ |
| PriceValue | .883 | .790 | .883 | ✅ | ✅ |
| Habit | .909 | .833 | .909 | ✅ | ✅ |
| AITrust | .891 | .804 | .891 | ✅ | ✅ |

All constructs pass both CR and AVE thresholds. No issues.

### Fornell-Larcker Criterion (R/lavaan, holdout)

**5 violations** (shared variance > AVE for at least one construct):

| Pair | r | r² | AVE₁ | AVE₂ | Verdict |
|------|---|-----|------|------|---------|
| PE × SI | .801 | .642 | .673 | .621 | **FAIL** (r² > AVE_SI) |
| PE × HM | **.911** | **.830** | .673 | .763 | **FAIL** (r² > both) |
| PE × PV | **.898** | **.807** | .673 | .790 | **FAIL** (r² > both) |
| PE × HB | .827 | .685 | .673 | .833 | **FAIL** (r² > AVE_PE) |
| HM × PV | **.898** | **.806** | .763 | .790 | **FAIL** (r² > both) |

*Note: The previous audit reported 3 violations using a |r| > .85 screen. The R pipeline's proper Fornell-Larcker computation (comparing r² against AVE) finds 5 violations. Three are severe (PE×HM, PE×PV, HM×PV); two are marginal (PE×SI, PE×HB).*

### HTMT Ratios (R, holdout) — NEW

**4 flags** out of 28 pairs:

| Pair | HTMT | Threshold | Status |
|------|------|-----------|--------|
| PE × HM | .900 | .85 | ⚠️ MARGINAL |
| PE × PV | **.902** | .85 | ❌ FAIL |
| HM × PV | **.904** | .85 | ❌ FAIL |
| HM × TR | .850 | .85 | ⚠️ MARGINAL |

All other 24 pairs: HTMT < .85 ✅

**Interpretation**: HTMT confirms the Fornell-Larcker diagnosis — PE, HM, and PV lack adequate discriminant separation. HM×TR is borderline. The core trio (PE/HM/PV) is the main concern.

### Factor Correlation Matrix (R/lavaan, holdout)

|  | PE | EE | SI | FC | HM | PV | HB | TR |
|--|----|----|----|----|----|----|----|----|
| PE | 1.00 | | | | | | | |
| EE | .716 | 1.00 | | | | | | |
| SI | .801 | .516 | 1.00 | | | | | |
| FC | .733 | .710 | .711 | 1.00 | | | | |
| HM | **.911** | .603 | .772 | .700 | 1.00 | | | |
| PV | **.898** | .683 | .783 | .672 | **.898** | 1.00 | | |
| HB | .827 | .611 | .687 | .637 | .786 | .790 | 1.00 | |
| TR | .811 | .674 | .725 | .708 | .843 | .835 | .818 | 1.00 |

Bold = |r| > .85 (discriminant concern).

---

## Thesis Corrections Already Applied (March 11, 2026)

### C1. §3.6.3 — EFA Extraction Method: PAF → MINRES ✅

**Problem**: Thesis said "Principal Axis Factoring (PAF)" but R code uses `psych::fa()` with MINRES (default).

**Change**: Replaced "Principal Axis Factoring (PAF)" with "Minimum Residuals (MINRES)" and updated rationale bullets. Changed software line from `Python factor_analyzer (v0.5.1)` to `R psych package (v2.5.6)`.

**Location**: `thesis-v2/manuscript/chapters/03_methodology.md` §3.6.3

### C2. §3.6.6 — SEM Full-Sample Rationale ✅

**Problem**: Thesis didn't explain why SEM uses full N=523 instead of holdout-only.

**Change**: Added explicit rationale: "Following CFA validation on the independent holdout subsample (n = 262), structural modeling uses the complete dataset to maximize statistical power for path estimation. This is standard practice when the measurement model has been confirmed on a separate sample."

**Location**: `thesis-v2/manuscript/chapters/03_methodology.md` §3.6.6

### C3. §3.6.8 — Cluster Count: k=4 → k=3 ✅

**Problem**: Thesis said "k = 4 clusters" but data shows k=3 is optimal (silhouette 0.271 vs 0.226).

**Change**: Replaced to "k = 3 clusters (supported by silhouette analysis and theoretical interpretability)."

**Location**: `thesis-v2/manuscript/chapters/03_methodology.md` §3.6.8

### C4. §3.6.9 — Method Label: "Thematic Analysis" → "Automated Content Analysis" ✅

**Problem**: The qualitative analysis uses deterministic keyword matching, not Braun & Clarke's iterative interpretive coding. Calling it "thematic analysis" is a methodological mischaracterization.

**Change**: Relabeled to "Automated content analysis with keyword classification." Added clarifying note distinguishing from interpretive thematic analysis. Kept Braun & Clarke citation as contrast reference.

**Location**: `thesis-v2/manuscript/chapters/03_methodology.md` §3.6.9

### C5. §3.6.10 — Software Table: Python-Only → Dual-Language ✅

**Problem**: Table 3.11 only listed Python packages. The authoritative pipeline is now R/lavaan.

**Change**: Replaced with dual-language table (R: lavaan 0.6.21, semTools 0.5.8, psych 2.5.6, cluster, rpart/caret; Python: pandas, numpy, scipy, etc.). Updated environment description. Noted R as authoritative pipeline.

**Location**: `thesis-v2/manuscript/chapters/03_methodology.md` §3.6.10

### C6. §3.7.3 — Discriminant Validity: Overclaim → Honest Disclosure ✅

**Problem**: Thesis claimed "all |r| < .85" and "Fornell-Larcker confirming discriminant validity" — both false.

**Change**: Added "Known Limitations" paragraph citing exact R-computed values: 3 construct pairs (PE×PV r=.898, PE×HM r=.911, HM×PV r=.898) violate Fornell-Larcker, HTMT confirms (PE×PV=.902, PE×HM=.900, HM×PV=.904). Added 4 mitigating factors with actual holdout and full-sample fit indices.

**Location**: `thesis-v2/manuscript/chapters/03_methodology.md` §3.7.3

### C7. run_02_cfa.R — HTMT Computation Added ✅

**Problem**: Thesis §3.7.3 lists HTMT as an assessment method but no code computed it.

**Change**: Added full HTMT section to `airs_experiment/R/run_02_cfa.R` after Fornell-Larcker. Computes all 28 pairwise ratios, flags ≥.85, exports `tables/cfa_htmt.csv`, adds to `tables/cfa_summary.json`. Verified: 24 OK, 2 MARGINAL, 2 FAIL.

**Location**: `airs_experiment/R/run_02_cfa.R`

---

## Discrepancy Detail

### D1. SRMR Values — Incorrect (Severity: MODERATE) — Ch4–6 ✅ FIXED

| Context | Thesis | R/Lavaan (gold standard) |
|---------|--------|----------------------|
| CFA (holdout) | .048 | **.026** |
| CFA (full) | — | **.022** |
| SEM (full) | .048 | **.024** |
| Academic group | .054 | **.038** |
| Professional group | .051 | **.018** |

The Python manual SRMR (~0.129) was ~5× too high due to a flawed residual matrix calculation. The thesis value (.048) is ~2× the actual — but fit is *better* than claimed.

**Ch3 status**: ✅ Software table now references R/lavaan as authoritative.
**Remaining**: Replace .048 with lavaan values at Ch4 L127, L128, L224, L332; Ch5 L15.

### D2. R² = .852 — Incorrect Value (Severity: MODERATE) — Ch4 ✅ FIXED

| Thesis | R/Lavaan |
|--------|---------|
| .852 (85.2%) | **.896 / .897** (89.6%) |

Thesis also reports UTAUT2-Only R²=.861 — paradoxically higher than the 8-predictor model's .852.

**Remaining**: Replace .852 with .897 at Ch4 L28, L536. Verify UTAUT2-Only R² value.

### D3. Bootstrap CIs — Fabricated (Severity: CRITICAL) — Ch4 ✅ FIXED

| Path | Thesis CI | Lavaan Bootstrap CI | Bootstrap Sig? |
|------|-----------|-------------------|----------------|
| PV → BI | [.352, .658] | **[0.218, 1.083]** | **YES** ✅ |
| HM → BI | [.044, .390] | [−0.106, 0.483] | No ❌ |
| SI → BI | [.018, .254] | [−0.028, 0.298] | No ❌ |
| TR → BI | [−.006, .218] | [−0.096, 0.248] | No ❌ |

No bootstrap code existed in the Python pipeline. Only PV→BI survives resampling.

**⚠️ Decision needed**: How to handle HM and SI? Options:
  - **(A) Conservative**: Report as "z-test significant but bootstrap-unstable; interpret with caution"
  - **(B) Strict**: Report as "not significant" (follow bootstrap as gold standard)
  - **Recommended**: Option A — z-test significance with bootstrap caveat. Honest and defensible.

**✅ DECISION MADE** (per Strategic Recommendations §1.1): **Option A confirmed.** The AIRS is a diagnostic instrument, not a screening tool. HM and SI paths retain value as indicators of adoption readiness dimensions even if bootstrap-unstable. Report lavaan bootstrap CIs honestly, note z-test significance, and add caveat: "z-test significant but bootstrap confidence intervals include zero; interpret as suggestive rather than conclusive." This is consistent with the diagnostic breadth rationale — removing these paths would sacrifice intervention-targeting information.

**Remaining**: Replace fabricated CIs with lavaan values at Ch4 L343–380 (Tables 4.10, 4.11). Add bootstrap caveat language.

### D4. User Typology — 4 Segments vs 3 Clusters (Severity: CRITICAL) — ✅ RESOLVED

| Thesis (4 segments) | Actual Data (3 clusters) |
|---------------------|------------------------|
| Enthusiastic Adopters — 16% (n=84) | AI Enthusiasts — 31% (n=162) |
| Cautious Adopters — 30% (n=157) | Moderate Users — 47% (n=246) |
| Moderate Users — 37% (n=191) | AI Skeptics — 22% (n=115) |
| Anxious Avoiders — 17% (n=91) | *(does not exist)* |

k=3 silhouette=0.271 (optimal). k=4 silhouette=0.226 (below 0.25 threshold).

**✅ FIXED**: Full 3-cluster rewrite applied across all chapters (Option A). All ~15 references updated:
  - Ch1: §1.5 segment count and names, §1.8 segment reference
  - Ch3: §3.6.8 (previously fixed)
  - Ch4: Table 4.22 rewritten with k=3 data, ANOVA stats, silhouette rationale; §4.8 summary
  - Ch5: §5.4.8 full rewrite, §5.5.1, §5.5.3, §5.5.5 items 2-3
  - Ch6: §6.2.3, §6.3.4, §6.4.1 interventions, §6.4.3, §6.5.1, §6.5.2 items 3+8, §6.7.4, §6.8 roadmap + closing

### D5. Discriminant Validity — Falsely Claimed (Severity: CRITICAL) — Ch3 ✅ / Ch4 ✅ FIXED

| Metric | Thesis Claim | R/Lavaan Reality |
|--------|-------------|-----------------|
| Max |r| | "all < .85" | PE×HM = **.911** |
| Correlation range | .25–.72 | .516–.911 |
| Fornell-Larcker | "Confirming discriminant validity" | **5 violations** |
| HTMT > .85 | Not computed | **4 pairs flagged** |

**R evidence** (new — holdout CFA):
- 5 Fornell-Larcker violations (see R Pipeline Results above)
- 4 HTMT flags: PE×PV (.902), PE×HM (.900), HM×PV (.904), HM×TR (.850)
- Core issue: PE, HM, and PV form a highly correlated triad

**Ch3 status**: ✅ §3.7.3 now honestly discloses violations, HTMT values, and mitigating factors.
**⚠️ Decision needed**: Ch4 still claims "all |r| < .85." Options:
  - **(A) Remove false claims**: Delete "all |r| < .85" and replace with actual correlation range and violation count
  - **(B) Acknowledge as limitation**: Keep structure but add limitation paragraph
  - **Recommended**: Option A for Ch4 results text; add limitation discussion in Ch5.

**✅ DECISION MADE** (per Strategic Recommendations §1.3): **Option A + diagnostic framing.** Remove false "all |r| < .85" claims in Ch4. Replace with actual correlation range (.516–.911) and violation count (5 Fornell-Larcker, 4 HTMT flags). In Ch5 discussion, add the strategic framing: PE/HM/PV are "conceptually adjacent but interventionally distinct" — collapsing them destroys diagnostic utility. Key supporting arguments: (a) differential population sensitivity (HM: Academic β=0.449 vs Professional β=−0.301), (b) theoretical continuity with UTAUT2, (c) 2-item scale measurement error inflates correlations (Marsh et al., 1998), (d) AIRS-28 item expansion expected to resolve. Ready-to-use language in Strategic Recommendations §6.

**Remaining**: Ch4 L239, L241, L283 — remove false discriminant claims. Ch5 — add diagnostic framing paragraph.

### D6. Per-Group Structural Fits — Values Wrong (Severity: MODERATE) — Ch4 ✅ FIXED

| Metric | Thesis "Student" | R/Lavaan "Academic" | Thesis "Professional" | R/Lavaan "Professional" |
|--------|-----------------|---------------------|----------------------|------------------------|
| CFI | .968 | **0.959** | .972 | **0.986** |
| RMSEA | .072 | **0.066** | .068 | **0.048** |
| SRMR | .054 | **0.038** | .051 | **0.018** |

Also: thesis uses "Student" but data uses "Academic" (14 locations).

**Remaining**: Replace all values and labels at Ch4 L309–332 and 14 label locations.

### D7. AI Trust Extension — Not Supported (Severity: CRITICAL) — Ch4–6 ✅ FIXED

| Metric | Value | Interpretation |
|--------|-------|----------------|
| Δχ² (Trust contribution) | 3.05, p = .081 | Not significant at α=.05 |
| ΔAIC | +2.01 | Trust model **worse** |
| ΔBIC | +6.27 | Trust model **worse** |
| Best model by AIC | UTAUT Core (4 predictors) | PE, EE, SI, FC not needed |
| Mediation (EE→TR→BI) | CI [−0.039, 0.430] | Not significant |

**⚠️ Decision needed**: Options:
  - **(A) Reframe honestly**: Trust adds measurement breadth but not structural predictive power. Retain as "diagnostic inclusion" with caveats.
  - **(B) Remove Trust framing**: Drop "AI Trust extends UTAUT2" claim entirely.
  - **Recommended**: Option A — Trust is theoretically interesting and has face validity even if ΔAIC is unfavorable. Honest reframing is better than omission.

**✅ DECISION MADE** (per Strategic Recommendations §1.2): **Option A — retain Trust with enhanced justification.** Four-part defense:
  1. **Underpowered**: Detecting β=.106 at 80% power requires n>600. N=523 yields ~68% power — 32% Type II error risk. Failing to reject H0 ≠ confirming H0.
  2. **Theoretically salient**: AI uniquely requires delegating cognitive authority. No prior technology demands trust at this level. 2025-2026 regulatory environment (EU AI Act, Gartner, Edelman) confirms institutional relevance.
  3. **Diagnostically essential**: Organizations finding low Trust scores need that signal for targeted interventions (explainability, reliability demonstrations, governance) that cannot be identified from PE/HM/PV alone.
  4. **2026 agentic context**: As AI transitions from tool → autonomous agent (§2.2), Trust may shift from marginal to dominant predictor (H9). Removing it now loses the pre-agentic baseline.
  - Precedent: Venkatesh et al. (2012) retain Voluntariness in UTAUT2 despite inconsistent empirical support.
  - Ready-to-use language in Strategic Recommendations §6.

**Remaining**: Ch4 L392; Ch5 L15, L27, L57–65; Ch6 L39–254 — reframe "extends UTAUT2" as "diagnostic inclusion."

### D8. Experience Moderation p-value (Severity: MINOR) — Ch4–6 ✅ FIXED

Thesis: p = .009 → Actual: p = .007 (raw .00675). Minor discrepancy across 6+ locations.

**Remaining**: Replace .009 with .007 at Ch4 L50, L442, L455, L491, L847; Ch5 L69, L124; Ch6 L45.

---

## Verified Correct Statistics

All of the following match between thesis and R pipeline outputs:

| Category | Verified Values |
|----------|----------------|
| **Sample** | N=523, EFA n=261, CFA n=262, seed=67, Academic n=216 (41.3%), Professional n=307 (58.7%) |
| **EFA** | KMO=.937, Bartlett χ²=4668.45, 8 factors retained, 4 dropped |
| **CFA fit** | χ²=159.38, df=76, CFI=.975, TLI=.960, RMSEA=.065 (all R/lavaan-confirmed) |
| **Reliability** | All 8 α ≥ .743, all CR ≥ .750, all AVE ≥ .601 (R CFA confirms all) |
| **Factor loadings** | All 16 loadings match (λ = .689–.920, all p < .001) |
| **Path betas** | PE=−.028, EE=−.008, SI=.136, FC=.059, HM=.217, PV=.505, HB=.023, TR=.106 |
| **Invariance** | Acad χ²=167.16/CFI=.958, Prof χ²=135.88/CFI=.988, mean Δloading=.082 |
| **Other** | BI-usage ρ=.69, disability n=68, pop mod Δβ=.750 (p=.041) |

---

## Implications Assessment

### For the Dissertation Defense

| Thesis Claim | Status | Action Required |
|-------------|--------|-----------------|
| "Excellent psychometric properties" | **SUPPORTED** (fit is better than reported) | Update SRMR; claim strengthens |
| "PV is dominant adoption driver" | **SUPPORTED** (only bootstrap-robust path) | Replace fabricated CIs with lavaan values |
| "85.2% variance explained" | **PARTIALLY SUPPORTED** (actual R²=.897 is higher) | Correct to .897 |
| "4-segment user typology" | **NOT SUPPORTED** (3 clusters optimal) | Full typology rewrite |
| "AI Trust extends UTAUT2" | **NOT SUPPORTED** structurally (ΔAIC +2.01) | Reframe as diagnostic inclusion: underpowered (68% power), theoretically salient, 2026 agentic context elevates Trust importance |
| "Discriminant validity established" | **NOT SUPPORTED** (5 FL violations, 4 HTMT flags) | Remove false claims; add diagnostic framing: conceptually adjacent but interventionally distinct (Marsh et al., 1998) |
| "HM and SI significant predictors" | **NOT SUPPORTED** by bootstrap | Report as z-test significant but bootstrap-unstable; retain for diagnostic value with caveat |

### For Practical Recommendations

| Recommendation Category | Keep/Remove | Rationale |
|------------------------|-------------|-----------|
| PV-based (value framing, pricing) | **Keep** | Only bootstrap-robust path |
| Segment-specific interventions | **Rewritten** | Rewritten for verified 3-cluster solution (Enthusiasts/Moderate Users/Skeptics) |
| Trust-building programs | **Keep with caveats** | Practically important even if structurally marginal |
| Experience moderation insights | **Keep** | HM×Exp confirmed (p=.007) |
| HM-based (gamification, intrinsic) | **Keep with caveats** | z-test significant but bootstrap-unstable |

---

## Remaining Work Checklist

### Already Done ✅

- [x] All 13 R analysis scripts verified and running
- [x] R/lavaan cross-validation complete
- [x] HTMT computation added to `run_02_cfa.R`
- [x] Ch3 §3.6.3 — PAF → MINRES
- [x] Ch3 §3.6.6 — SEM full-sample rationale added
- [x] Ch3 §3.6.8 — k=4 → k=3
- [x] Ch3 §3.6.9 — Thematic analysis → Automated content analysis
- [x] Ch3 §3.6.10 — Dual-language software table
- [x] Ch3 §3.7.3 — Discriminant validity honest disclosure + HTMT

### Mechanical Fixes (clear right answer) ✅

- [x] Ch4: Replace SRMR .048 with lavaan values (5 locations)
- [x] Ch4: Replace R²=.852 with .897 (2 locations)
- [x] Ch4: Replace per-group fit values with lavaan values (14 locations)
- [x] Ch4: Replace "Student" label with "Academic" (~16 locations across Ch4/5/6)
- [x] Ch4–6: Replace p=.009 with p=.007 (8 locations)
- [x] Bibliography: Add `@deWinter2012` and `@kline2023` references (used in new Ch3 text)

### Judgment-Required Fixes (decisions made — edits applied) ✅

- [x] Ch4 Tables 4.10/4.11: Replace fabricated CIs → lavaan bootstrap CIs + add caveat language for HM/SI (**Decision: Option A** — z-test + bootstrap caveat per Strategic Recs §1.1) — Table 4.10 footnoted, Table 4.11b added
- [x] Ch4 L239, L241, L283: Remove "all |r| < .85" discriminant claims → replace with actual range + add Ch5 diagnostic framing (**Decision: Option A + framing** per Strategic Recs §1.3) — Ch4 rewritten, Ch5 §5.2.4 added
- [x] Ch1/4/5/6: Full typology rewrite — 4 segments → 3 clusters (~15 locations) — **✅ DONE**
- [x] Ch4/5/6: Reframe AI Trust extension — structural → diagnostic inclusion with power analysis + 2026 context (**Decision: Option A + enhanced justification** per Strategic Recs §1.2) — Ch5 §5.2.2, Ch6 §6.2.3/§6.3.1/§6.4.2

### Strategic Additions (new material from Strategic Recommendations) ✅

- [x] Ch5: Add diagnostic-purpose framing paragraph — §5.2.3 added
- [x] Ch5: Add discriminant validity framing paragraph — §5.2.4 added
- [x] Ch5/6: Add 2026 contextual developments — Ch6 §6.7.0 added (DeepSeek R1, agentic AI, EU AI Act)
- [x] Ch6: Add selected hypotheses H9, H10, H14, H16, H20, H21, H22, H24 to future research — §6.7.2 expanded from 6 to 11 items
- [x] Ch6: Add phased research agenda — §6.7.3 enhanced with AIRS-28 Phase 1, longitudinal panel Phase 2, cross-cultural Phase 2b, intervention RCT Phase 3
- [x] Ch6: Add 2026 context paragraph for future research — integrated into §6.7.0
- [x] Bibliography: Add new references — Clark & Watson 1995, Messick 1995, Marsh et al. 1998, de Winter et al. 2009 (Kim 2025 and Frenkenberg 2025 already present)

---

## Pipeline Verification Summary

All 13 R scripts + 1 cross-validation R script executed successfully.

| Script | Key Outputs Used | Status |
|--------|-----------------|--------|
| R/run_00 | N=523, splits, demographics | ✅ Matches thesis |
| R/run_01 | KMO=.937, 8 factors retained | ✅ Matches thesis |
| R/run_02 | CFI=.975, TLI=.960, RMSEA=.065, **SRMR=.026**, HTMT computed | ✅ Fit matches; SRMR corrects thesis |
| R/run_03 | Configural invariance supported | ✅ Matches thesis |
| R/run_04 | R²=0.896, path betas match, **SRMR=.024** | ✅ Betas match; SRMR corrects thesis |
| R/run_05 | Trust Δχ²=3.05 p=.081, UTAUT Core best by AIC | ✅ Confirms Trust non-significance |
| R/run_06 | HM×Exp p=.0067 | ✅ Confirms significance (thesis says .009) |
| R/run_07 | ChatGPT most used, leader effects | ✅ Matches thesis |
| R/run_08 | 3 significant role-theme associations | ✅ Matches thesis |
| R/run_09 | 6 research gaps quantified | ✅ Matches thesis |
| R/run_10 | Synthesis loaded all upstream results | ✅ |
| R/run_11 | k=3 optimal (sil=0.271), k=4 not defensible | ✅ Corrects thesis |
| R/run_12 | Cut-point 91.4% accuracy | ✅ Matches thesis |
| R/run_r_validation | **Gold standard**: SRMR=.022–.026, R²=.897, PV→BI only bootstrap path, FL violations | ✅ |

<details>
<summary>Full pipeline phase details (click to expand)</summary>

#### Phase 0: Sample Splitting ✅
N=523, EFA=261, CFA=262 (seed=67). Academic=216 (41.3%), Professional=307 (58.7%).

#### Phase 1: EFA ✅
KMO=0.937, Bartlett χ²=4668.45. 8 validated factors (α≥.79), 4 dropped (α=.30–.58).

#### Phase 2: CFA ✅
CFI=0.975, TLI=0.960, RMSEA=0.065, SRMR=0.026. All 16 loadings significant (λ = .689–.920). 5 Fornell-Larcker violations. 4 HTMT flags (PE×HM=.900, PE×PV=.902, HM×PV=.904, HM×TR=.850). Lavaan cross-validates CFI/TLI/RMSEA exactly; corrects SRMR from thesis .048 to .026.

#### Phase 3: Measurement Invariance ✅
Configural invariance supported. 3/16 items show loading differences >0.10 (partial metric). 3/8 constructs show significant mean differences (small effect).

#### Phase 4: Structural Model ✅
Full model CFI=0.975, RMSEA=0.058, R²=0.896. PV→BI (β=.505), HM→BI (β=.217), SI→BI (β=.136) significant by z-test. Lavaan bootstrap: only PV survives (CI [0.218, 1.083]).

#### Phase 5: Model Comparison ✅
Trust Δχ²=3.046, p=.081. ΔAIC=+2.01 (Trust worse). Best model: UTAUT Core (4 predictors), AIC=128.9.

#### Phase 6: Moderation ✅
HM×Exp: β=0.136, p=.0067 (significant). PE×Exp: β=0.112, p=.055 (marginal). All other moderations NS.

#### Phase 7: Tool Usage ✅
ChatGPT M=3.03, 64.2% active. All tools show significant role effects (η²=.08–.16). Leaders dominate (d>0.7).

#### Phase 8: Qualitative ✅
243 responses (70.4%). Top themes: Positive Experience (24.7%), Work/Productivity (19.3%). 3 significant role associations.

#### Phase 9: Gap Analysis ✅
Education×BI F=9.15, Industry×BI F=5.91. Technology sector highest BI. Disability: AX higher (d=0.362).

#### Phase 10: Synthesis ✅
All 10 upstream JSONs loaded. Cross-tabulation: Positive Experience × Role χ²=10.05, p=.018.

#### Phase 11: Typology ✅
k=3: Enthusiasts 31%, Moderate 47%, Skeptics 22%. k=4: sil=0.226 (<0.25 threshold). ANOVA F=503.47, η²=0.659.

#### Phase 12: Classification ✅
Cut-point (8 constructs): 91.4% accuracy. Decision tree: 80.1% CV. Simplified (3 constructs): 77.1%.

</details>

---

## Lavaan Cross-Validation Summary

**Tool:** R 4.5.2, lavaan 0.6.21 | **Script:** `run_r_validation.R` | **Output:** `results/r_lavaan_validation.json`

| Metric | R/Lavaan | Thesis | Match? |
|--------|----------|--------|--------|
| CFA CFI (holdout) | .975 | — | ✅ |
| CFA SRMR (holdout) | **.026** | .048 | ❌ |
| CFA SRMR (full) | **.022** | — | — |
| SEM CFI | .975 | — | ✅ |
| SEM SRMR | **.024** | .048 | ❌ |
| R² (BI) | **.897** | .852 | ❌ |
| PV→BI bootstrap CI | [0.218, 1.083] | [.352, .658] | ❌ (both sig, values differ) |
| HM→BI bootstrap CI | [−0.106, 0.483] | [.044, .390] | ❌ (lavaan: NS) |
| SI→BI bootstrap CI | [−0.028, 0.298] | [.018, .254] | ❌ (lavaan: NS) |
| Factor corr max | .911 (PE×HM) | .72 | ❌ |
| FL violations | 5 | 0 | ❌ |
| HTMT flags | 4 | 0 | ❌ |
| Academic SRMR | .038 | .054 | ❌ |
| Professional SRMR | .018 | .051 | ❌ |

---

## Appendix A: Research Questions & Hypotheses — Evidence Reconciliation

This appendix maps every research question and hypothesis to: (1) what the dissertation concluded, (2) what the verified evidence shows, and (3) whether the conclusion is reinforced, contradicted, or partially contradicted.

**Evidence sources:** R/lavaan 0.6.21 full pipeline (13 scripts), bootstrap cross-validation (`results/r_lavaan_validation.json`), HTMT analysis (`tables/cfa_htmt.csv`), typology analysis (`results/phase11_practitioner_typology_results.json`), model comparison (`data/phase5_alternative_analyses.json`), moderation (`data/moderation_results_updated.json`).

### A.1 Research Questions

| RQ | Statement | Dissertation Conclusion | Verified Evidence | Verdict |
|----|-----------|------------------------|-------------------|---------|
| **Primary** | How can UTAUT2 be extended with AI-specific constructs to better predict BI to adopt AI tools? | 8-factor, 16-item instrument; R² = .852; PV dominant; Trust adds diagnostic value | R² = .897 (lavaan). PV only bootstrap-robust path. Trust Δχ² p = .081, ΔAIC = +2.01 — simpler model preferred. Extension adds measurement breadth but no predictive gain. | **Partially Contradicted** |
| **RQ1** | What is the factor structure of an AI-specific adoption readiness instrument? | 8-factor structure; CFI = .975, TLI = .960, RMSEA = .065; all α > .74; "all \|r\| < .85" | Fit indices confirmed. But 5 Fornell-Larcker violations and 4 HTMT flags. Claim "all \|r\| < .85" is **false** (PE×HM = .911). | **Partially Contradicted** |
| **RQ2** | Does the instrument demonstrate measurement invariance across academic and professional populations? | Configural invariance achieved; metric invariance partial (ΔCFI = .003, ΔRMSEA = .004; max Δλ = .326 on SI) | Per-group fit confirmed: Academic CFI = .959, Professional CFI = .986. Partial metric invariance acknowledged honestly. | **Reinforced** |
| **RQ3** | Which factors most strongly predict behavioral intention to adopt AI tools? | PV (β = .505), HM (β = .217), SI (β = .136) — all p < .05 | Lavaan bootstrap: PV β = .505 p = .019 CI [0.218, 1.083] ✓. HM β = .217 p = .137 CI [−0.107, 0.483] ✗. SI β = .136 p = .088 CI [−0.028, 0.298] ✗. Only PV survives resampling. | **Partially Contradicted** |
| **RQ4** | Does AI Trust significantly predict adoption intention beyond UTAUT2 constructs? | Marginal, not significant (β = .106, p = .064) | Lavaan bootstrap: p = .232, CI [−0.096, 0.248]. Model comparison: UTAUT2-only AIC = 148.58 < AIRS AIC = 150.59. No incremental validity. | **Reinforced** (thesis was honest) |
| **RQ5** | What moderating factors influence the relationships between predictors and adoption intention? | Experience moderates HM→BI (p = .009); Population moderates HM→BI (Δβ = .750, p = .041) | HM×Exp: β = .136, p = .007 — confirmed. Population moderation from multi-group SEM (p = .041) borderline. | **Reinforced** |

### A.2 Hypotheses

| Hypothesis | Path | Dissertation Verdict | Dissertation Values | Lavaan Bootstrap Evidence | Assessment |
|------------|------|---------------------|---------------------|--------------------------|------------|
| **H1a** | PE → BI (+) | Not Supported | β = −.028, p = .791 | p = .882, CI [−0.499, 0.341] | **Reinforced** — correctly rejected |
| **H1b** | EE → BI (+) | Not Supported | β = −.008, p = .875 | p = .916, CI [−0.217, 0.131] | **Reinforced** — correctly rejected |
| **H1c** | SI → BI (+) | **Supported** | β = .136, p = .024, CI [.018, .254] | p = .088, CI [−0.028, 0.298] — CI includes zero | **CONTRADICTED** — does not survive bootstrap |
| **H1d** | FC → BI (+) | Not Supported | β = .059, p = .338 | p = .511, CI [−0.117, 0.306] | **Reinforced** — correctly rejected |
| **H1e** | HM → BI (+) | **Supported** | β = .217, p = .014, CI [.044, .390] | p = .137, CI [−0.107, 0.483] — CI includes zero | **CONTRADICTED** — does not survive bootstrap |
| **H1f** | PV → BI (+) | **Supported** (strongest) | β = .505, p < .001, CI [.352, .658] | p = .019, CI [0.218, 1.083] — excludes zero | **Reinforced** — only bootstrap-robust path |
| **H1g** | HB → BI (+) | Not Supported | β = .023, p = .631 | p = .713, CI [−0.087, 0.139] | **Reinforced** — correctly rejected |
| **H2** | TR → BI (+) beyond UTAUT2 | Marginal, Not Significant | β = .106, p = .064, CI [−.006, .218] | p = .232, CI [−0.096, 0.248]. ΔAIC = +2.01 | **Reinforced** — thesis honest about marginality |
| **H3** | Experience moderates UTAUT paths | Partially Supported | HM×Exp β = .136, p = .009 | p = .007 — confirmed significant | **Reinforced** |
| **H4** | Population moderates UTAUT paths | Partially Supported | HM: Student β = .449 vs Professional β = −.301, p = .041 | Multi-group SEM (p = .041 borderline). Regression moderations NS. | **Partially Reinforced** |
| **H5** | BI → Actual Tool Usage (+) | **Supported** | ρ = .69, p < .001 | Not disputed | **Reinforced** |
| **H6** | Role groups differ in tool usage | **Supported** | F = 22.15, p < .001, η² = .078 | Not disputed | **Reinforced** |

### A.3 Non-Hypothesis Claims

| Claim | Source | Dissertation States | Verified Evidence | Assessment |
|-------|--------|--------------------|--------------------|------------|
| **Discriminant validity** | CFA factor correlations | "all \|r\| < .85" | 3 pairs > .85: PE×HM = .911, PE×PV = .898, HM×PV = .898. 5 FL violations. 4 HTMT flags. | **CONTRADICTED** |
| **User typology** | K-means clustering | 4 clusters | k = 3 optimal (sil = 0.271). k = 4 not defensible (sil = 0.226). | **CONTRADICTED** |
| **SRMR values** | CFA/SEM fit | ".048" | Lavaan: .022–.026. Actual fit is **better**. | **Contradicted** (in thesis's favor) |
| **R² for BI** | Structural model | .852 | Lavaan: .897. Actual is **higher**. | **Contradicted** (in thesis's favor) |
| **p = .009 for HM×Exp** | Moderation | .009 | Actual: .007 (rounds from .00675). | **Trivially contradicted** |

### A.4 Summary Scorecard

| Category | Reinforced | Partially Contradicted | Contradicted | Total |
|----------|-----------|----------------------|--------------|-------|
| Research Questions (6) | 3 | 3 | 0 | 6 |
| Hypotheses (12) | 9 | 1 | 2 | 12 |
| Non-Hypothesis Claims (5) | 0 | 0 | 5 | 5 |
| **Overall** | **12** | **4** | **7** | **23** |

**Key takeaway:** The core statistical model and most hypothesis verdicts hold up. The contradictions cluster around three issues: (1) inflated significance from ML z-tests vs. bootstrap (H1c, H1e), (2) the wrong clustering solution (k=4 instead of k=3), and (3) discriminant validity overclaims. None invalidate the instrument, but they require honest correction.

---

*Audit initiated: March 11, 2026 | Pipeline verified: March 11, 2026 | R/lavaan validated: June 10, 2025 | R CFA with HTMT: March 11, 2026 | Thesis Ch3 corrections: March 11, 2026*
