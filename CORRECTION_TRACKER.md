# AIRS Thesis Correction Tracker

**Created:** March 11, 2026
**Source:** [FACT_CHECK_AUDIT.md](FACT_CHECK_AUDIT.md) — all findings independently verified
**Goal:** Correct all discrepancies between thesis manuscript and verified analysis data

---

## Progress Summary

| Status | Count |
|--------|-------|
| ⬜ Not started | 31 |
| 🔄 In progress | 0 |
| ✅ Complete | 0 |
| **Total fixes** | **31** |

---

## Fix Priority Guide

| Priority | Criteria | Items |
|----------|----------|-------|
| **P0 — Must fix** | Data contradicts thesis claim; affects conclusions | D3 (CIs), D4 (typology), D5 (discriminant validity), D7 (Trust framing) |
| **P1 — Should fix** | Values wrong but conclusion direction holds | D1 (SRMR), D2 (R²), D6 (per-group fits + labels) |
| **P2 — Nice to fix** | Cosmetic; no impact on conclusions | D8 (p-value rounding) |

**Recommended order:** P0 items first (they affect the narrative), then P1 (numeric corrections), then P2.

---

## D3 — Bootstrap Confidence Intervals (P0 CRITICAL)

The thesis CIs were fabricated (no bootstrap code existed). Replace with lavaan bootstrap values. This changes multiple hypothesis conclusions.

### Thesis corrections needed:

| # | Status | File | Line(s) | Current | Correct | Notes |
|---|--------|------|---------|---------|---------|-------|
| 1 | ⬜ | 04_results.md | ~343 | "95% confidence intervals" text implies bootstrapped CIs | Add explicit note: "Bootstrap CIs computed via R/lavaan (1000 iterations)" | Method transparency |
| 2 | ⬜ | 04_results.md | ~354–370 | Table 4.10 CI column: PV [.352, .658], HM [.044, .390], SI [.018, .254] | PV **[0.218, 1.083]**, HM [−0.106, 0.483], SI [−0.028, 0.298] | HM and SI become NS |
| 3 | ⬜ | 04_results.md | ~376–390 | Table 4.11 CI column: TR [−.006, .218], others as listed | TR [−0.096, 0.248], PE [−0.499, 0.341], EE [−0.217, 0.131], FC [−0.117, 0.306], HB [−0.087, 0.139] | All remain NS |
| 4 | ⬜ | 05_analysis_discussion.md | §5.3.2 | Theoretical discussion of HM as significant predictor | **Reframe**: HM shows nominal z-test significance (p=.014) but bootstrap CI includes zero. Discuss as suggestive, not confirmed | Major narrative change |
| 5 | ⬜ | 05_analysis_discussion.md | §5.3.3 | Theoretical discussion of SI as significant predictor | **Reframe**: SI shows nominal z-test significance (p=.024) but bootstrap CI includes zero. Discuss as suggestive, not confirmed | Major narrative change |
| 6 | ⬜ | 04_results.md | Hypothesis support summary | H1f (HM→BI): "Supported", H1c (SI→BI): "Supported" | Change both to "Partially supported (z-test significant; bootstrap CI includes zero)" | Affects hypothesis table |

### Downstream implications:
- Ch 5 HM and SI discussions need caveats about bootstrap instability
- Ch 6 recommendations based on HM and SI need softening (retain as suggestive, not definitive)
- PV-based recommendations remain fully supported — **no changes needed** for PV claims

---

## D4 — User Typology: 4 Segments → 3 Clusters (P0 CRITICAL)

The thesis describes 4 segments that don't exist in the data. Every reference must be corrected to the verified 3-cluster solution.

**Correct values:** AI Enthusiasts 31% (n=162), Moderate Users 47% (n=246), AI Skeptics 22% (n=115)

| # | Status | File | Line(s) | Current | Correct | Notes |
|---|--------|------|---------|---------|---------|-------|
| 7 | ⬜ | 01_introduction.md | ~104 | "AI Enthusiasts [16%], Cautious Adopters [30%], Moderate Users [37%], and Anxious Avoiders [17%]" | "AI Enthusiasts [31%], Moderate Users [47%], and AI Skeptics [22%]" | |
| 8 | ⬜ | 01_introduction.md | ~146 | "four distinct user segments" | "three distinct user segments" | |
| 9 | ⬜ | 04_results.md | ~700–703 | Table 4.22: 4 rows with wrong names/sizes/percentages | Replace with 3 rows: Enthusiasts 162/31%, Moderate 246/47%, Skeptics 115/22% | |
| 10 | ⬜ | 04_results.md | ~871 | "(Enthusiasts, Cautious Adopters, Moderate Users, Anxious Avoiders)" | "(AI Enthusiasts, Moderate Users, AI Skeptics)" | |
| 11 | ⬜ | 05_analysis_discussion.md | ~136 | "four-segment typology" | "three-cluster typology" | |
| 12 | ⬜ | 05_analysis_discussion.md | ~138–141 | 4 segment descriptions with wrong names/percentages | 3 cluster descriptions with correct values | |
| 13 | ⬜ | 05_analysis_discussion.md | ~145 | "Four-segment user typology" (figure caption) | "Three-cluster user typology" | |
| 14 | ⬜ | 05_analysis_discussion.md | ~161–185 | "four-segment" refs, "Anxious Avoider" discussion | Remove Anxious Avoider content; rewrite for 3-cluster solution | Substantial rewrite |
| 15 | ⬜ | 06_conclusions.md | ~47 | "Four distinct adoption segments" | "Three distinct adoption clusters" | |
| 16 | ⬜ | 06_conclusions.md | ~69–135 | Multiple "four-segment" refs, "Anxious Avoider" recommendations | Rewrite for 3-cluster solution | Substantial rewrite |
| 17 | ⬜ | 06_conclusions.md | ~222 | "Enthusiastic Adopters, Pragmatic Evaluators, Cautious Traditionalists, Anxious Avoiders" | "AI Enthusiasts, Moderate Users, AI Skeptics" | Uses a THIRD set of wrong names |
| 18 | ⬜ | 06_conclusions.md | ~230–233 | 4 segment-specific intervention recommendations | Rewrite for 3 clusters: Enthusiasts→champion, Moderate→targeted engagement, Skeptics→barrier reduction | |
| 19 | ⬜ | 06_conclusions.md | ~254 | "four-segment typology" | "three-cluster typology" | |

### Downstream implications:
- The "Anxious Avoider" segment and all pedagogy recommendations built on it must be removed
- Skeptics (22%) need new recommendations (different from "Anxious Avoiders" — skepticism ≠ anxiety)
- k=4 silhouette (0.226) should be reported and explained as below the 0.25 defensibility threshold

---

## D5 — Discriminant Validity (P0 CRITICAL)

The thesis falsely claims discriminant validity. Must acknowledge 3 Fornell-Larcker violations.

| # | Status | File | Line(s) | Current | Correct | Notes |
|---|--------|------|---------|---------|---------|-------|
| 20 | ⬜ | 04_results.md | ~239 | "correlations ranged from r = .25...to r = .72...all \|r\| < .85" | "correlations ranged from r = .57...to r = .92. Three pairs exceeded the .85 threshold: PE×PV (.919), HM×PV (.903), PE×HM (.879)" | |
| 21 | ⬜ | 04_results.md | ~241 | "All correlations fall below the .85 threshold" | Remove or replace with violation acknowledgment | |
| 22 | ⬜ | 04_results.md | ~283 | "confirming discriminant validity" via Fornell-Larcker | "Three Fornell-Larcker violations were identified (PE×HM, PE×PV, HM×PV), suggesting these constructs may share substantial conceptual overlap" | |
| 23 | ⬜ | 05_analysis_discussion.md | Add new | No discussion of DV violations | Add limitations paragraph: PE, HM, PV share a "perceived value" meta-construct. Discuss implications for separate path interpretation | |
| 24 | ⬜ | 06_conclusions.md | Limitations | Not listed as limitation | Add to limitations: "Three factor pairs (PE×PV, HM×PV, PE×HM) violated the Fornell-Larcker criterion, suggesting these constructs may not be empirically distinct" | |

---

## D7 — AI Trust Extension Framing (P0 CRITICAL)

Trust does not significantly improve model fit; simpler UTAUT Core is preferred by AIC. The thesis must disclose this.

| # | Status | File | Line(s) | Current | Correct | Notes |
|---|--------|------|---------|---------|---------|-------|
| 25 | ⬜ | 04_results.md | ~392 | Trust retained for "diagnostic capability" | Add: "Model comparison showed the Trust extension did not significantly improve fit (Δχ²=3.05, p=.081, ΔAIC=+2.01). The simpler UTAUT Core model was preferred by information criteria." | |
| 26 | ⬜ | 05_analysis_discussion.md | §5.3.3 | Trust as theoretical contribution | **Reframe**: Trust has measurement value (high α=.905, AVE=.827) but not structural value. The extension is psychometrically sound but does not improve prediction of BI | |
| 27 | ⬜ | 06_conclusions.md | ~57 | "extends UTAUT2 with AI-specific constructs" | Qualify: "The study extends UTAUT2 measurement to include AI Trust, though model comparison indicates the structural extension does not significantly improve prediction (ΔAIC=+2.01)" | |

---

## D1 — SRMR Values (P1)

Replace thesis SRMR=.048 with lavaan gold-standard values.

| # | Status | File | Line(s) | Current | Correct | Notes |
|---|--------|------|---------|---------|---------|-------|
| 28 | ⬜ | 04_results.md | ~127–128 | SRMR = .048 (EFA comparison table) | .026 (or note: lavaan-computed) | |
| 29 | ⬜ | 04_results.md | ~224 | SRMR = .048 (CFA fit table) | **.026** (holdout) | Fit is actually *better* |
| 30 | ⬜ | 04_results.md | ~332 | Per-group SRMR: .054 / .051 | Academic **.038**, Professional **.018** | |
| 31 | ⬜ | 05_analysis_discussion.md | ~15 | "SRMR = .048" | "SRMR = .026" | |

---

## D2 — R² Value (P1)

| # | Status | File | Line(s) | Current | Correct | Notes |
|---|--------|------|---------|---------|---------|-------|
| 32 | ⬜ | 04_results.md | ~28 | "R² = .852 (8-factor model)" / "85.2%" | "R² = .896" / "89.6%" | Lavaan: .897 |
| 33 | ⬜ | 04_results.md | ~536 | Table 4.16: .852 / 85.2% | .896 / 89.6% | Also: thesis .861 for 7-predictor should be checked |

---

## D6 — Per-Group Fit Values and "Student" Label (P1)

| # | Status | File | Line(s) | Current | Correct | Notes |
|---|--------|------|---------|---------|---------|-------|
| 34 | ⬜ | 04_results.md | ~329 | CFI: .968 / .972 | Academic: **.959**, Professional: **.986** | |
| 35 | ⬜ | 04_results.md | ~330 | RMSEA: .072 / .068 | Academic: **.066**, Professional: **.048** | |
| 36 | ⬜ | 04_results.md | ~327 | "Student" column header | "Academic" | |
| 37 | ⬜ | 04_results.md | 14 locations | "Student" used inconsistently for Academic group | Standardize to "Academic" throughout (L309, L315, L327, L465, L473, L493, L656, L777, L785, L798, L867, L883) | Batch find-replace |

---

## D8 — Experience Moderation p-value (P2)

| # | Status | File | Line(s) | Current | Correct | Notes |
|---|--------|------|---------|---------|---------|-------|
| 38 | ⬜ | 04_results.md | L50, L442, L455, L491, L847 | p = .009 | p = .007 | 5 locations; L865 already says .007 |
| 39 | ⬜ | 05_analysis_discussion.md | L69, L124 | p = .009 | p = .007 | |
| 40 | ⬜ | 06_conclusions.md | L45 | p = .009 | p = .007 | |

---

## Suggested New Content (Not Corrections — Additions)

These are not errors to fix but disclosures the thesis should include:

| # | Status | File | Section | Content to Add |
|---|--------|------|---------|----------------|
| A1 | ⬜ | 04_results.md | After Table 4.10 | Note: "Bootstrap CIs computed via R/lavaan 0.6.20 (1000 iterations, percentile method). Z-test p-values and bootstrap CIs may diverge under multicollinearity." |
| A2 | ⬜ | 04_results.md | §4.7 Typology | Report silhouette analysis: k=3 (0.271) chosen over k=4 (0.226, below 0.25 threshold) |
| A3 | ⬜ | 05_analysis_discussion.md | §5.2 | Paragraph on z-test vs bootstrap divergence: explain multicollinearity inflates z-stats while bootstrap accounts for parameter instability |
| A4 | ⬜ | 06_conclusions.md | Limitations | Add: (1) discriminant validity violations, (2) bootstrap instability of HM/SI paths, (3) Trust extension not significant by model comparison |
| A5 | ⬜ | 03_methodology.md | Analysis section | Disclose R/lavaan cross-validation as methodological triangulation |

---

## Verification Checklist

After all corrections are applied, verify:

- [ ] All SRMR values reference lavaan (not Python manual calculation)
- [ ] R² = .896 (not .852) everywhere
- [ ] All CIs match lavaan bootstrap output
- [ ] No references to "Cautious Adopters" or "Anxious Avoiders" remain
- [ ] All segment counts/percentages match k=3 solution
- [ ] Discriminant validity section acknowledges 3 FL violations
- [ ] Trust is framed as measurement (not structural) contribution
- [ ] "Student" → "Academic" standardized throughout
- [ ] p = .009 → .007 for experience moderation
- [ ] Rebuild thesis PDF and verify no orphaned references
- [ ] Run `thesis-v2/build.ps1` clean build

---

*Tracker created from verified audit findings. See [FACT_CHECK_AUDIT.md](FACT_CHECK_AUDIT.md) for evidence and data sources.*
