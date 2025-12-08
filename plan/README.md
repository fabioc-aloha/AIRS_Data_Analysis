# Planning Documents

This folder contains research planning and design documents for the AIRS (AI Readiness Scale) DBA dissertation project.

## Current Status

| Milestone | Status | Date |
|-----------|--------|------|
| Data Collection | ✅ Complete | N=523 |
| Analysis Pipeline | ✅ Complete | 11/11 notebooks |
| Thesis Chapters 3-4 | ✅ Complete | Dec 2025 |
| Thesis Chapters 1,2,5 | 🔶 In Progress | - |

## Contents

| Document | Description | Status |
|----------|-------------|--------|
| `ANALYSIS_PLAN_v2.md` | Master implementation guide with validated model | ✅ Current |
| `AIRS DBA Project Proposal v4.md` | Dissertation proposal with theoretical framework | Reference |
| `AIRS Survey Instrument v5.md` | Complete survey instrument with all items | Reference |
| `DATA_DICTIONARY.md` | Variable definitions and coding | Reference |
| `SUBSAMPLE_ANALYSIS_GUIDE.md` | Guide for subsample-specific analysis | Reference |
| `airs_24item_complete.json` | Original 24-item pool (pre-validation) | Archive |

## Validated Analysis Strategy

The final approach uses a **single validated model** with split-sample validation:

| Phase | Sample | Purpose |
|-------|--------|---------|
| EFA Development | n=261 (50%) | Factor exploration, model selection |
| CFA Holdout | n=262 (50%) | Cross-validation, model confirmation |
| Full SEM | N=523 | Structural model, hypothesis testing |
| Invariance | 3-group | Measurement equivalence across roles |

### Key Decisions Documented

1. **Model D selected**: 8 factors, 16 items (2 items per factor)
2. **Seed 67**: Reproducible random split
3. **Role grouping**: Academic (216) vs Professional+Leader (307) for SEM
4. **Experience moderation**: Novel finding (PE×Exp, HM×Exp significant)

See `ANALYSIS_PLAN_v2.md` for complete methodology and implementation details.
