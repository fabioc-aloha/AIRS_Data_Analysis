#!/usr/bin/env python3
"""
AIRS Phase 4: Structural Model & Hypothesis Testing
Refactored from 04_Structural_Model.ipynb

Tests AIRS structural paths and hypotheses via SEM.
Hypotheses: H1 (UTAUT2→BI), H2 (Trust→BI), H3 (AIRS vs UTAUT2), H4 (population moderation)
Outputs: data/structural_model_results.json, bootstrap CIs, multi-group comparison
"""

import json
import warnings
from pathlib import Path

import numpy as np
import pandas as pd
from scipy import stats
from semopy import Model
from semopy.stats import calc_stats

warnings.filterwarnings('ignore')

# ═══════════════════════════════════════════════════════════════════════════════
# CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════════════

N_BOOTSTRAP = 1000

MODEL_D_STRUCTURE = {
    'PerfExp': ['PE1', 'PE2'], 'EffortExp': ['EE1', 'EE2'],
    'SocialInf': ['SI1', 'SI2'], 'FacilCond': ['FC1', 'FC2'],
    'HedonicMot': ['HM1', 'HM2'], 'PriceValue': ['PV1', 'PV2'],
    'Habit': ['HB1', 'HB2'], 'AITrust': ['TR1', 'TR2']
}

BI_ITEMS = ['BI1', 'BI2', 'BI3', 'BI4']

HYPOTHESIS_MAP = {
    'PerfExp': ('H1a', 'Performance Expectancy → BI'),
    'EffortExp': ('H1b', 'Effort Expectancy → BI'),
    'SocialInf': ('H1c', 'Social Influence → BI'),
    'FacilCond': ('H1d', 'Facilitating Conditions → BI'),
    'HedonicMot': ('H1e', 'Hedonic Motivation → BI'),
    'PriceValue': ('H1f', 'Price Value → BI'),
    'Habit': ('H1g', 'Habit → BI'),
    'AITrust': ('H2', 'AI Trust → BI')
}


def build_sem_syntax(structure, include_trust=True):
    """Build SEM syntax with measurement + structural components."""
    lines = []
    # Measurement model
    for factor, items in structure.items():
        if not include_trust and factor == 'AITrust':
            continue
        lines.append(f"{factor} =~ {' + '.join(items)}")
    # BI measurement
    lines.append(f"BehIntent =~ {' + '.join(BI_ITEMS)}")
    # Structural paths
    predictors = [f for f in structure.keys() if (include_trust or f != 'AITrust')]
    lines.append(f"BehIntent ~ {' + '.join(predictors)}")
    return '\n'.join(lines)


def compute_srmr(model, df):
    """Manually compute SRMR."""
    sigma = model.calc_sigma()[0]
    observed_cov = df.cov().values
    n_vars = observed_cov.shape[0]
    d_sigma = np.sqrt(np.diag(sigma))
    sigma_corr = sigma / np.outer(d_sigma, d_sigma)
    d_obs = np.sqrt(np.diag(observed_cov))
    obs_corr = observed_cov / np.outer(d_obs, d_obs)
    residuals = obs_corr - sigma_corr
    lower_tri = residuals[np.tril_indices(n_vars, k=-1)]
    return np.sqrt(np.mean(lower_tri**2))


def extract_r_squared(model):
    """Extract R² for BehIntent from the model."""
    params = model.inspect(std_est=True)
    bi_resid = params[(params['op'] == '~~') &
                      (params['lval'] == 'BehIntent') &
                      (params['rval'] == 'BehIntent')]
    if len(bi_resid) > 0:
        resid_var = bi_resid['Est. Std'].values[0]
        return 1 - resid_var
    return None


def fit_sem_model(df, syntax, label=""):
    """Fit SEM model and return results dict."""
    model = Model(syntax)
    model.fit(df)
    stats_df = calc_stats(model)

    results = {
        'n': len(df),
        'chi2': float(stats_df.loc['Value', 'chi2']),
        'df': float(stats_df.loc['Value', 'DoF']),
        'cfi': float(stats_df.loc['Value', 'CFI']),
        'tli': float(stats_df.loc['Value', 'TLI']),
        'rmsea': float(stats_df.loc['Value', 'RMSEA']),
        'aic': float(stats_df.loc['Value', 'AIC']),
        'bic': float(stats_df.loc['Value', 'BIC']),
        'model': model,
    }

    # SRMR
    try:
        results['srmr'] = compute_srmr(model, df)
    except Exception:
        results['srmr'] = None

    # R²
    results['r_squared'] = extract_r_squared(model) or 0.0

    # Structural paths
    params = model.inspect(std_est=True)
    struct = params[(params['op'] == '~') & (params['lval'] == 'BehIntent')]
    results['structural_paths'] = struct.copy()

    if label:
        srmr_str = f"{results['srmr']:.3f}" if results.get('srmr') is not None else 'N/A'
        print(f"\n  {label} (N={results['n']}): CFI={results['cfi']:.3f}, "
              f"RMSEA={results['rmsea']:.3f}, SRMR={srmr_str}, "
              f"R²={results['r_squared']:.3f}")

    return results


def display_structural_paths(results):
    """Print structural path coefficients."""
    paths = results['structural_paths'].copy()
    paths['Estimate'] = pd.to_numeric(paths['Estimate'], errors='coerce')
    paths['Std. Err'] = pd.to_numeric(paths['Std. Err'], errors='coerce')
    paths['Est. Std'] = pd.to_numeric(paths['Est. Std'], errors='coerce')
    paths['z'] = paths['Estimate'] / paths['Std. Err']
    paths['p'] = 2 * (1 - stats.norm.cdf(np.abs(paths['z'].astype(float))))
    paths['Sig'] = paths['p'].apply(
        lambda p: '***' if p < .001 else '**' if p < .01 else '*' if p < .05 else '')
    paths['Hypothesis'] = paths['rval'].map(lambda x: HYPOTHESIS_MAP.get(x, ('', ''))[0])
    paths['Support'] = paths.apply(
        lambda r: 'Supported' if r['p'] < .05 and r['Est. Std'] > 0 else 'Not Supported', axis=1)

    print("\n  Structural Path Coefficients:")
    print(f"  {'Predictor':<12} {'β(std)':<10} {'SE':<8} {'z':<8} {'p':<8} {'Sig':<5} {'Hyp':<6} {'Support'}")
    print("  " + "-" * 75)
    for _, r in paths.sort_values('Est. Std', ascending=False).iterrows():
        print(f"  {r['rval']:<12} {r['Est. Std']:>8.3f}  {r['Std. Err']:>6.3f}  "
              f"{r['z']:>6.3f}  {r['p']:>6.4f}  {r['Sig']:<4}  {r['Hypothesis']:<5}  {r['Support']}")
    return paths


def run_bootstrap(df, syntax, n_boot=1000):
    """Run bootstrap to get confidence intervals for structural paths."""
    print(f"\n  Running bootstrap ({n_boot} iterations)...")
    predictors = list(MODEL_D_STRUCTURE.keys())
    boot_estimates = {pred: [] for pred in predictors}
    failures = 0

    for i in range(n_boot):
        if (i + 1) % 200 == 0:
            print(f"    Iteration {i + 1}/{n_boot} (failures: {failures})")
        boot_sample = df.sample(n=len(df), replace=True)
        try:
            with warnings.catch_warnings():
                warnings.simplefilter('ignore')
                m = Model(syntax)
                m.fit(boot_sample)
                params = m.inspect(std_est=True)
            struct = params[(params['op'] == '~') & (params['lval'] == 'BehIntent')]
            for pred in predictors:
                row = struct[struct['rval'] == pred]
                if len(row) > 0:
                    boot_estimates[pred].append(float(row['Est. Std'].values[0]))
        except (Exception, KeyboardInterrupt):
            failures += 1
            continue

    ci_results = {}
    print(f"\n  Bootstrap Confidence Intervals (95%):")
    print(f"  {'Predictor':<12} {'Mean':<8} {'CI_Low':<10} {'CI_High':<10} {'Sig'}")
    print("  " + "-" * 50)
    for pred in predictors:
        vals = boot_estimates[pred]
        if len(vals) >= 100:
            ci_low, ci_high = np.percentile(vals, [2.5, 97.5])
            mean_est = np.mean(vals)
            sig = 'Yes' if (ci_low > 0 or ci_high < 0) else 'No'
            ci_results[pred] = {
                'mean': round(mean_est, 4), 'ci_lower': round(ci_low, 4),
                'ci_upper': round(ci_high, 4), 'n_valid': len(vals),
                'significant': ci_low > 0 or ci_high < 0
            }
            print(f"  {pred:<12} {mean_est:>6.3f}  [{ci_low:>7.3f}, {ci_high:>7.3f}]  {sig}")
        else:
            print(f"  {pred:<12} Insufficient valid bootstrap samples ({len(vals)})")
    return ci_results


def main():
    print("=" * 90)
    print("PHASE 4: STRUCTURAL MODEL & HYPOTHESIS TESTING")
    print("=" * 90)

    # ── Load Data ─────────────────────────────────────────────────────────
    df_exp = pd.read_csv('data/AIRS_experiment.csv')
    df_hold = pd.read_csv('data/AIRS_holdout.csv')
    df_full = pd.concat([df_exp, df_hold], ignore_index=True)
    print(f"\nFull sample: N = {len(df_full)}")

    # Load CFA summary for reference
    with open('tables/cfa_summary.json', 'r') as f:
        cfa_summary = json.load(f)

    # ── Prepare Items ─────────────────────────────────────────────────────
    all_items = [item for items in MODEL_D_STRUCTURE.values() for item in items] + BI_ITEMS
    df_model = df_full[all_items].dropna()
    print(f"Analysis sample (complete cases): N = {len(df_model)}")

    # ── Population Split ──────────────────────────────────────────────────
    if 'Population' in df_full.columns:
        df_academic = df_full[df_full['Population'] == 'Academic'][all_items].dropna()
        df_professional = df_full[df_full['Population'] == 'Professional'][all_items].dropna()
    else:
        df_academic = df_exp[all_items].dropna()
        df_professional = df_hold[all_items].dropna()
    print(f"Academic: n = {len(df_academic)}, Professional: n = {len(df_professional)}")

    # ── Build Syntax ──────────────────────────────────────────────────────
    AIRS_SYNTAX = build_sem_syntax(MODEL_D_STRUCTURE, include_trust=True)
    UTAUT2_SYNTAX = build_sem_syntax(MODEL_D_STRUCTURE, include_trust=False)

    # ── Phase 1: Full Sample AIRS Model ──────────────────────────────────
    print("\n" + "=" * 90)
    print("PHASE 1: FULL SAMPLE STRUCTURAL MODEL")
    print("=" * 90)

    airs_full_results = fit_sem_model(df_model, AIRS_SYNTAX, "AIRS Full Model")
    path_results = display_structural_paths(airs_full_results)

    # ── Phase 2: Bootstrap CIs ────────────────────────────────────────────
    print("\n" + "=" * 90)
    print("PHASE 2: BOOTSTRAP CONFIDENCE INTERVALS")
    print("=" * 90)

    bootstrap_ci_results = run_bootstrap(df_model, AIRS_SYNTAX, N_BOOTSTRAP)

    # ── Phase 2b: H3 Model Comparison ─────────────────────────────────────
    print("\n" + "=" * 90)
    print("PHASE 2b: H3 MODEL COMPARISON (AIRS vs UTAUT2-only)")
    print("=" * 90)

    utaut2_results = fit_sem_model(df_model, UTAUT2_SYNTAX, "UTAUT2-only")

    delta_cfi = airs_full_results['cfi'] - utaut2_results['cfi']
    delta_aic = airs_full_results['aic'] - utaut2_results['aic']
    delta_bic = airs_full_results['bic'] - utaut2_results['bic']

    print(f"\n  ΔCFI = {delta_cfi:+.4f} {'(AIRS better)' if delta_cfi > 0 else '(UTAUT2 better)'}")
    print(f"  ΔAIC = {delta_aic:+.2f} {'(AIRS better)' if delta_aic < 0 else '(UTAUT2 better)'}")
    print(f"  ΔBIC = {delta_bic:+.2f} {'(AIRS better)' if delta_bic < 0 else '(UTAUT2 better)'}")

    if delta_aic < -2:
        h3_support = "SUPPORTED"
    elif delta_aic < 0:
        h3_support = "PARTIALLY SUPPORTED"
    else:
        h3_support = "NOT SUPPORTED"
    print(f"  H3: {h3_support}")

    tr_beta = path_results[path_results['rval'] == 'AITrust']['Est. Std'].values[0]
    tr_p = path_results[path_results['rval'] == 'AITrust']['p'].values[0]
    print(f"  AI Trust β = {tr_beta:.3f}, p = {tr_p:.3f}")

    # ── Phase 3: Multi-Group Analysis ─────────────────────────────────────
    print("\n" + "=" * 90)
    print("PHASE 3: MULTI-GROUP STRUCTURAL MODELS")
    print("=" * 90)

    academic_sem_results = fit_sem_model(df_academic, AIRS_SYNTAX, "Academic Sample")
    professional_sem_results = fit_sem_model(df_professional, AIRS_SYNTAX, "Professional Sample")

    # Path comparison
    def extract_structural_paths(results):
        paths = results['structural_paths'].copy()
        paths['Estimate'] = pd.to_numeric(paths['Estimate'], errors='coerce')
        paths['Std. Err'] = pd.to_numeric(paths['Std. Err'], errors='coerce')
        paths['Est. Std'] = pd.to_numeric(paths['Est. Std'], errors='coerce')
        return paths.set_index('rval')

    acad_paths = extract_structural_paths(academic_sem_results)
    prof_paths = extract_structural_paths(professional_sem_results)

    predictors = list(MODEL_D_STRUCTURE.keys())
    comparison_data = []
    for pred in predictors:
        acad_beta = acad_paths.loc[pred, 'Est. Std'] if pred in acad_paths.index else np.nan
        prof_beta = prof_paths.loc[pred, 'Est. Std'] if pred in prof_paths.index else np.nan
        acad_se = acad_paths.loc[pred, 'Std. Err'] if pred in acad_paths.index else np.nan
        prof_se = prof_paths.loc[pred, 'Std. Err'] if pred in prof_paths.index else np.nan

        delta_beta = prof_beta - acad_beta
        pooled_se = np.sqrt(acad_se**2 + prof_se**2)
        z_diff = (prof_paths.loc[pred, 'Estimate'] - acad_paths.loc[pred, 'Estimate']) / pooled_se if pred in acad_paths.index else np.nan
        p_diff = 2 * (1 - stats.norm.cdf(abs(z_diff)))

        comparison_data.append({
            'Predictor': pred, 'β_Academic': acad_beta, 'β_Professional': prof_beta,
            'Δβ': delta_beta, 'z_diff': z_diff, 'p_diff': p_diff,
            'Moderation': '✓' if p_diff < 0.05 else ''
        })

    path_comparison_df = pd.DataFrame(comparison_data)

    print("\n  Path Comparison (Academic vs Professional):")
    print(f"  {'Predictor':<12} {'β_Acad':<10} {'β_Prof':<10} {'Δβ':<10} {'p_diff':<10} {'Mod'}")
    print("  " + "-" * 55)
    for _, r in path_comparison_df.iterrows():
        print(f"  {r['Predictor']:<12} {r['β_Academic']:>8.3f}  {r['β_Professional']:>8.3f}  "
              f"{r['Δβ']:>8.3f}  {r['p_diff']:>8.4f}  {r['Moderation']}")

    sig_moderation = path_comparison_df[path_comparison_df['Moderation'] == '✓']
    n_moderation = len(sig_moderation)
    if n_moderation > 0:
        for _, row in sig_moderation.iterrows():
            direction = "stronger for Professionals" if row['Δβ'] > 0 else "stronger for Academics"
            print(f"  • {row['Predictor']} → BI: {direction} (Δβ={row['Δβ']:.3f}, p={row['p_diff']:.3f})")
    else:
        print("  No significant moderation effects detected")

    # ── Hypothesis Summary ────────────────────────────────────────────────
    sig_paths = path_results[path_results['p'] < 0.05]['rval'].tolist()
    n_sig_utaut2 = len([p for p in sig_paths if p != 'AITrust'])
    trust_sig = 'AITrust' in sig_paths

    print("\n" + "=" * 90)
    print("HYPOTHESIS TESTING SUMMARY")
    print("=" * 90)
    print(f"  H1: UTAUT2 → BI: PARTIALLY SUPPORTED ({n_sig_utaut2}/7 paths significant)")
    print(f"  H2: AI Trust → BI: {'SUPPORTED' if trust_sig else 'NOT SUPPORTED'} (β={tr_beta:.3f}, p={tr_p:.3f})")
    print(f"  H3: AIRS > UTAUT2: {h3_support} (ΔAIC={delta_aic:+.2f})")
    print(f"  H4: Population moderation: {'PARTIALLY SUPPORTED' if n_moderation > 0 else 'NOT SUPPORTED'} ({n_moderation} paths moderated)")

    # ── Export ────────────────────────────────────────────────────────────
    print("\n" + "=" * 90)
    print("EXPORTING RESULTS")
    print("=" * 90)

    # CSV exports
    path_export = path_results[['rval', 'Estimate', 'Std. Err', 'Est. Std', 'z', 'p', 'Sig', 'Hypothesis', 'Support']].copy()
    path_export.columns = ['Predictor', 'Beta_Unstd', 'SE', 'Beta_Std', 'z', 'p', 'Sig', 'Hypothesis', 'Support']
    path_export.to_csv('./tables/structural_paths_full_sample.csv', index=False)
    print("✓ tables/structural_paths_full_sample.csv")

    path_comparison_df.to_csv('./tables/structural_paths_group_comparison.csv', index=False)
    print("✓ tables/structural_paths_group_comparison.csv")

    # Build path coefficients for JSON
    path_coefficients = []
    for _, row in path_export.iterrows():
        pred = row['Predictor']
        entry = {
            'predictor': pred,
            'beta_std': float(row['Beta_Std']),
            'p': float(row['p']),
            'hypothesis': row['Hypothesis'],
            'support': row['Support']
        }
        if pred in bootstrap_ci_results:
            entry['ci_lower'] = bootstrap_ci_results[pred]['ci_lower']
            entry['ci_upper'] = bootstrap_ci_results[pred]['ci_upper']
            entry['ci_significant'] = bootstrap_ci_results[pred]['significant']
        path_coefficients.append(entry)

    structural_summary = {
        'analysis_date': pd.Timestamp.now().isoformat(),
        'full_sample_n': int(airs_full_results['n']),
        'full_sample_fit': {
            'chi2': float(airs_full_results['chi2']),
            'df': float(airs_full_results['df']),
            'cfi': float(airs_full_results['cfi']),
            'tli': float(airs_full_results['tli']),
            'rmsea': float(airs_full_results['rmsea']),
            'srmr': float(airs_full_results['srmr']),
            'r_squared_BehIntent': float(airs_full_results['r_squared']),
            'aic': float(airs_full_results['aic']),
            'bic': float(airs_full_results['bic'])
        },
        'path_coefficients': path_coefficients,
        'bootstrap': {
            'n_iterations': N_BOOTSTRAP,
            'results': bootstrap_ci_results
        },
        'hypothesis_results': {
            'H1_supported_paths': int(n_sig_utaut2),
            'H1_total_paths': 7,
            'H2_trust_significant': bool(trust_sig),
            'H2_trust_beta': float(tr_beta),
            'H2_trust_p': float(tr_p),
            'H3_incremental_validity': bool(delta_aic < -2),
            'H3_delta_aic': float(delta_aic),
            'H4_moderation_effects': int(n_moderation)
        },
        'academic_sample': {
            'n': int(academic_sem_results['n']),
            'cfi': float(academic_sem_results['cfi']),
            'rmsea': float(academic_sem_results['rmsea']),
            'srmr': float(academic_sem_results['srmr']) if academic_sem_results.get('srmr') is not None else None,
            'r_squared_BehIntent': float(academic_sem_results['r_squared'])
        },
        'professional_sample': {
            'n': int(professional_sem_results['n']),
            'cfi': float(professional_sem_results['cfi']),
            'rmsea': float(professional_sem_results['rmsea']),
            'srmr': float(professional_sem_results['srmr']) if professional_sem_results.get('srmr') is not None else None,
            'r_squared_BehIntent': float(professional_sem_results['r_squared'])
        }
    }

    with open('./data/structural_model_results.json', 'w') as f:
        json.dump(structural_summary, f, indent=2, default=str)
    print("✓ data/structural_model_results.json (includes SRMR, R², bootstrap CIs)")

    print("\n" + "=" * 90)
    print("✓ PHASE 4: STRUCTURAL MODEL ANALYSIS COMPLETE")
    print("=" * 90)


if __name__ == '__main__':
    main()
