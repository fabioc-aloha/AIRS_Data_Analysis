#!/usr/bin/env python3
"""
AIRS Phase 2: Confirmatory Factor Analysis (CFA)
Refactored from 02_CFA_Experiment.ipynb

Validates EFA-derived factor structure using independent holdout sample.
Method: semopy CFA | Fit criteria: CFI/TLI >= 0.95, RMSEA <= 0.08
Outputs: tables/cfa_summary.json, factor loadings, CR/AVE metrics
"""

import sys
import json
import warnings
from pathlib import Path

import numpy as np
import pandas as pd
import pingouin as pg
from semopy import Model
from semopy.stats import calc_stats

warnings.filterwarnings('ignore')

# ═══════════════════════════════════════════════════════════════════════════════
# CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════════════

POPULATION = "combined"

CONSTRUCT_NAME_MAP = {
    'Factor1': 'PerfExp', 'Factor2': 'EffortExp', 'Factor3': 'SocialInf',
    'Factor4': 'FacilCond', 'Factor5': 'HedonicMot', 'Factor6': 'PriceValue',
    'Factor7': 'Habit', 'Factor8': 'AITrust'
}

DROPPED_ITEMS = {
    'Voluntariness': ['VO1', 'VO2'],
    'Explainability': ['EX1', 'EX2'],
    'EthicalRisk': ['ER1', 'ER2'],
    'Anxiety': ['AX1', 'AX2']
}


def build_cfa_syntax(structure):
    """Build semopy CFA model syntax from factor structure dict."""
    lines = []
    for factor, items in structure.items():
        lines.append(f"{factor} =~ {' + '.join(items)}")
    return '\n'.join(lines)


def compute_srmr(model, df):
    """Manually compute SRMR from a fitted semopy model."""
    sigma = model.calc_sigma()[0]
    observed_cov = df.cov().values
    n_vars = observed_cov.shape[0]

    # Convert model-implied covariance to correlation
    d_sigma = np.sqrt(np.diag(sigma))
    sigma_corr = sigma / np.outer(d_sigma, d_sigma)

    # Convert observed covariance to correlation
    d_obs = np.sqrt(np.diag(observed_cov))
    obs_corr = observed_cov / np.outer(d_obs, d_obs)

    # SRMR = sqrt(mean of squared residual correlations in lower triangle)
    residuals = obs_corr - sigma_corr
    lower_tri = residuals[np.tril_indices(n_vars, k=-1)]
    srmr = np.sqrt(np.mean(lower_tri**2))
    return srmr


def main():
    print("=" * 90)
    print("PHASE 2: CONFIRMATORY FACTOR ANALYSIS (CFA)")
    print("=" * 90)

    # ── Load Data ─────────────────────────────────────────────────────────
    df_full = pd.read_csv('data/AIRS_holdout.csv')
    print(f"\nLoaded holdout data: {df_full.shape[0]} rows x {df_full.shape[1]} columns")

    with open('data/experiment_config.json', 'r') as f:
        config = json.load(f)

    # ── Load EFA Results ──────────────────────────────────────────────────
    with open('tables/efa_summary.json', 'r') as f:
        efa_summary = json.load(f)

    # Build CFA structure from EFA results
    CFA_STRUCTURE = {}
    factor_struct = efa_summary.get('validated_factor_structure', {})
    for factor_name, items in factor_struct.items():
        mapped = CONSTRUCT_NAME_MAP.get(factor_name, factor_name)
        CFA_STRUCTURE[mapped] = items

    print(f"\nCFA Factor Structure ({len(CFA_STRUCTURE)} factors):")
    for factor, items in CFA_STRUCTURE.items():
        print(f"  {factor}: {items}")

    # ── Load Item Metadata ────────────────────────────────────────────────
    metadata = {}
    item_json_path = Path('../data/airs_28item_complete.json')
    if item_json_path.exists():
        with open(item_json_path, 'r') as f:
            item_data = json.load(f)
        items_raw = item_data.get('items', [])
        if isinstance(items_raw, list) and len(items_raw) > 0 and isinstance(items_raw[0], dict):
            for item in items_raw:
                metadata[item['item_id']] = item

    # ── Prepare CFA Data ─────────────────────────────────────────────────
    all_cfa_items = [item for items in CFA_STRUCTURE.values() for item in items]
    df_cfa = df_full[all_cfa_items].copy()
    print(f"\nCFA data prepared: {df_cfa.shape[0]} observations x {df_cfa.shape[1]} items")

    # ── Build & Fit CFA Model ─────────────────────────────────────────────
    model_syntax = build_cfa_syntax(CFA_STRUCTURE)
    print(f"\nCFA Model Syntax:\n{model_syntax}\n")

    cfa_model = Model(model_syntax)
    cfa_model.fit(df_cfa)
    fit_success = True

    # ── Fit Statistics ────────────────────────────────────────────────────
    stats_df = calc_stats(cfa_model)

    chi2 = stats_df.loc['Value', 'chi2'] if 'chi2' in stats_df.columns else None
    df_val = stats_df.loc['Value', 'DoF'] if 'DoF' in stats_df.columns else None
    cfi = stats_df.loc['Value', 'CFI'] if 'CFI' in stats_df.columns else None
    tli = stats_df.loc['Value', 'TLI'] if 'TLI' in stats_df.columns else None
    rmsea = stats_df.loc['Value', 'RMSEA'] if 'RMSEA' in stats_df.columns else None
    aic = stats_df.loc['Value', 'AIC'] if 'AIC' in stats_df.columns else None
    bic = stats_df.loc['Value', 'BIC'] if 'BIC' in stats_df.columns else None

    print("=" * 90)
    print("CFA FIT STATISTICS")
    print("=" * 90)

    fit_items = [
        ('χ²', chi2, None, None),
        ('df', df_val, None, None),
        ('CFI', cfi, 0.95, 'higher'),
        ('TLI', tli, 0.95, 'higher'),
        ('RMSEA', rmsea, 0.08, 'lower'),
        ('AIC', aic, None, None),
        ('BIC', bic, None, None),
    ]
    for name, val, threshold, direction in fit_items:
        if val is not None:
            status = ''
            if threshold:
                if direction == 'higher':
                    status = ' ✓' if val >= threshold else ' ⚠️'
                else:
                    status = ' ✓' if val <= threshold else ' ⚠️'
            print(f"  {name}: {val:.3f}{status}")

    # ── SRMR (Manual) ────────────────────────────────────────────────────
    srmr_value = compute_srmr(cfa_model, df_cfa)
    srmr_status = '✓' if srmr_value <= 0.08 else '⚠️'
    print(f"  SRMR: {srmr_value:.4f} {srmr_status}")

    # ── Factor Loadings ───────────────────────────────────────────────────
    params = cfa_model.inspect(std_est=True)
    loadings = params[params['op'] == '~']
    loading_records = []
    for _, row in loadings.iterrows():
        loading_records.append({
            'Factor': row['lval'],
            'Item': row['rval'],
            'Loading': row['Est. Std'],
            'SE': row['Std. Err'],
        })
    loading_df = pd.DataFrame(loading_records)

    print("\n" + "=" * 90)
    print("FACTOR LOADINGS (Standardized)")
    print("=" * 90)
    for factor in sorted(CFA_STRUCTURE.keys()):
        print(f"\n  {factor}:")
        frows = loading_df[loading_df['Factor'] == factor]
        for _, r in frows.iterrows():
            quality = '✓' if r['Loading'] >= 0.70 else ('○' if r['Loading'] >= 0.50 else '⚠️')
            print(f"    {r['Item']}: {r['Loading']:.3f} (SE={r['SE']:.3f}) {quality}")

    # Loading quality summary
    excellent = len(loading_df[loading_df['Loading'] >= 0.70])
    strong = len(loading_df[(loading_df['Loading'] >= 0.50) & (loading_df['Loading'] < 0.70)])
    acceptable = len(loading_df[(loading_df['Loading'] >= 0.40) & (loading_df['Loading'] < 0.50)])
    weak = len(loading_df[loading_df['Loading'] < 0.40])
    print(f"\n  Summary: Excellent(≥.70)={excellent}, Strong(.50-.70)={strong}, Acceptable(.40-.50)={acceptable}, Weak(<.40)={weak}")

    # ── Factor Correlations ───────────────────────────────────────────────
    factors = sorted(CFA_STRUCTURE.keys())
    cov_params = params[(params['op'] == '~~') & (params['lval'] != params['rval'])]

    corr_matrix = pd.DataFrame(1.0, index=factors, columns=factors)
    for _, row in cov_params.iterrows():
        if row['lval'] in factors and row['rval'] in factors:
            corr_matrix.loc[row['lval'], row['rval']] = row['Est. Std']
            corr_matrix.loc[row['rval'], row['lval']] = row['Est. Std']

    print("\n" + "=" * 90)
    print("FACTOR CORRELATIONS")
    print("=" * 90)
    print(corr_matrix.round(3).to_string())

    # Check for high correlations and Heywood cases
    off_diag = corr_matrix.values[np.triu_indices(len(factors), k=1)]
    high_corrs = []
    heywood_cases = []

    for i in range(len(factors)):
        for j in range(i + 1, len(factors)):
            val = corr_matrix.iloc[i, j]
            pair = f"{factors[i]}×{factors[j]}"
            if abs(val) > 0.85:
                high_corrs.append({'pair': pair, 'r': val})
                print(f"  ⚠️ HIGH CORRELATION: {pair} = {val:.3f}")
            if abs(val) > 1.0:
                heywood_cases.append({'pair': pair, 'r': val})
                print(f"  🚨 HEYWOOD CASE: {pair} = {val:.3f}")

    if not high_corrs:
        print("  ✓ No problematically high factor correlations detected")

    # ── Reliability ───────────────────────────────────────────────────────
    reliability_results = []
    for factor, items in CFA_STRUCTURE.items():
        item_data = df_cfa[items].dropna()
        alpha_result = pg.cronbach_alpha(item_data)
        alpha = alpha_result[0]

        # Factor loadings for this factor
        factor_loadings = loading_df[loading_df['Factor'] == factor]['Loading'].values

        # Composite Reliability
        sum_loadings = np.sum(factor_loadings)
        sum_error_var = np.sum(1 - factor_loadings**2)
        cr = sum_loadings**2 / (sum_loadings**2 + sum_error_var)

        # Average Variance Extracted
        ave = np.mean(factor_loadings**2)

        reliability_results.append({
            'Factor': factor,
            'N_Items': len(items),
            'Alpha': alpha,
            'CR': cr,
            'AVE': ave
        })

    reliability_df = pd.DataFrame(reliability_results)

    print("\n" + "=" * 90)
    print("RELIABILITY SUMMARY")
    print("=" * 90)
    print(reliability_df[['Factor', 'N_Items', 'Alpha', 'CR', 'AVE']].round(3).to_string(index=False))

    good_alpha = len(reliability_df[reliability_df['Alpha'] >= 0.70])
    good_cr = len(reliability_df[reliability_df['CR'] >= 0.70])
    good_ave = len(reliability_df[reliability_df['AVE'] >= 0.50])
    total = len(reliability_df)
    print(f"\n  Good α (≥.70): {good_alpha}/{total}")
    print(f"  Good CR (≥.70): {good_cr}/{total}")
    print(f"  Good AVE (≥.50): {good_ave}/{total}")

    # ── Dropped Items Evaluation ──────────────────────────────────────────
    print("\n" + "=" * 90)
    print("DROPPED ITEMS RELIABILITY EVALUATION")
    print("=" * 90)

    dropped_reliability = []
    for construct, items in DROPPED_ITEMS.items():
        if all(item in df_full.columns for item in items):
            item_data = df_full[items].dropna()
            alpha_result = pg.cronbach_alpha(item_data)
            alpha = alpha_result[0]
            inter_corr = item_data.corr().iloc[0, 1]
            status = '✓ Acceptable' if alpha >= 0.60 else '✗ Poor'
            dropped_reliability.append({
                'Construct': construct, 'Items': ', '.join(items),
                'N_Items': len(items), 'Alpha': alpha,
                'Inter_Item_r': inter_corr, 'Status': status
            })

    dropped_df = pd.DataFrame(dropped_reliability)
    print(dropped_df.to_string(index=False))

    # ── Export Results ────────────────────────────────────────────────────
    print("\n" + "=" * 90)
    print("EXPORTING RESULTS")
    print("=" * 90)

    loading_df.to_csv('tables/cfa_factor_loadings.csv', index=False)
    print("✓ tables/cfa_factor_loadings.csv")

    reliability_df.to_csv('tables/cfa_reliability.csv', index=False)
    print("✓ tables/cfa_reliability.csv")

    if len(CFA_STRUCTURE) >= 2:
        corr_matrix.to_csv('tables/cfa_factor_correlations.csv')
        print("✓ tables/cfa_factor_correlations.csv")

    cfa_summary = {
        'population': POPULATION,
        'n_observations': len(df_cfa),
        'n_factors': len(CFA_STRUCTURE),
        'n_items': sum(len(items) for items in CFA_STRUCTURE.values()),
        'factor_structure': CFA_STRUCTURE,
        'fit_indices': {
            'chi2': float(chi2) if chi2 else None,
            'df': int(df_val) if df_val else None,
            'CFI': float(cfi) if cfi else None,
            'TLI': float(tli) if tli else None,
            'RMSEA': float(rmsea) if rmsea else None,
            'SRMR': float(srmr_value) if srmr_value is not None else None,
            'AIC': float(aic) if aic else None,
            'BIC': float(bic) if bic else None
        },
        'factor_correlation_diagnostics': {
            'correlation_range': [float(min(off_diag)), float(max(off_diag))],
            'n_pairs_above_85': len(high_corrs),
            'n_heywood_cases': len(heywood_cases),
            'heywood_pairs': heywood_cases,
            'high_correlation_pairs': high_corrs
        } if len(CFA_STRUCTURE) >= 2 else None,
        'reliability': reliability_df[['Factor', 'Alpha', 'CR', 'AVE']].to_dict('records')
    }

    with open('tables/cfa_summary.json', 'w') as f:
        json.dump(cfa_summary, f, indent=2)
    print("✓ tables/cfa_summary.json")

    # ── Final Summary ─────────────────────────────────────────────────────
    print("\n" + "=" * 90)
    print("CFA ANALYSIS COMPLETE")
    print("=" * 90)
    print(f"  Sample: {POPULATION.title()} (N = {len(df_cfa)})")
    print(f"  Factors: {len(CFA_STRUCTURE)}, Items: {sum(len(i) for i in CFA_STRUCTURE.values())}")
    print(f"  CFI = {cfi:.3f}, TLI = {tli:.3f}, RMSEA = {rmsea:.3f}, SRMR = {srmr_value:.4f}")
    print(f"  Heywood cases: {len(heywood_cases)}")
    if heywood_cases:
        for h in heywood_cases:
            print(f"    {h['pair']} = {h['r']:.3f}")


if __name__ == '__main__':
    main()
