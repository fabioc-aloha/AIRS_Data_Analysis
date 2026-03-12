#!/usr/bin/env python3
"""
AIRS Phase 3: Measurement Invariance Testing
Refactored from 03_Measurement_Invariance.ipynb

Tests measurement equivalence across Academic vs Professional populations.
Outputs: data/invariance_results.json, tables/invariance_*.csv,
         plots/measurement_invariance_*.png
"""

import json
import os
import warnings
from pathlib import Path

import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats

import semopy
from semopy import Model
import pingouin as pg

os.environ['KMP_DUPLICATE_LIB_OK'] = 'True'
warnings.filterwarnings('ignore')

RANDOM_SEED = 67


def build_cfa_syntax(structure):
    """Build semopy CFA syntax from structure dict."""
    lines = []
    factors = list(structure.keys())
    for factor, items in structure.items():
        lines.append(f"{factor} =~ {' + '.join(items)}")
    for i, f1 in enumerate(factors):
        for f2 in factors[i+1:]:
            lines.append(f"{f1} ~~ {f2}")
    return '\n'.join(lines)


def fit_cfa_model(df, syntax, group_name):
    """Fit CFA and return fit statistics."""
    model = Model(syntax)
    model.fit(df)
    fit_stats = semopy.calc_stats(model)

    chi2 = float(fit_stats.loc['Value', 'chi2']) if 'chi2' in fit_stats.columns else np.nan
    df_val = float(fit_stats.loc['Value', 'DoF']) if 'DoF' in fit_stats.columns else np.nan
    cfi = float(fit_stats.loc['Value', 'CFI']) if 'CFI' in fit_stats.columns else np.nan
    tli = float(fit_stats.loc['Value', 'TLI']) if 'TLI' in fit_stats.columns else np.nan
    rmsea = float(fit_stats.loc['Value', 'RMSEA']) if 'RMSEA' in fit_stats.columns else np.nan
    aic = float(fit_stats.loc['Value', 'AIC']) if 'AIC' in fit_stats.columns else np.nan
    bic = float(fit_stats.loc['Value', 'BIC']) if 'BIC' in fit_stats.columns else np.nan

    print(f"\n{group_name} CFA (N={len(df)}): chi2({df_val:.0f})={chi2:.2f}, "
          f"CFI={cfi:.3f}, TLI={tli:.3f}, RMSEA={rmsea:.3f}")

    return {'model': model, 'chi2': chi2, 'df': df_val, 'cfi': cfi, 'tli': tli,
            'rmsea': rmsea, 'aic': aic, 'bic': bic, 'n': len(df)}


def extract_loadings(model, structure):
    """Extract standardized factor loadings."""
    params = model.inspect(std_est=True)
    loadings = params[params['op'] == '~'].copy()
    loading_dict = {}
    for _, row in loadings.iterrows():
        factor = row['rval']
        item = row['lval']
        est = row['Est. Std']
        loading_dict[(factor, item)] = float(est) if pd.notna(est) else np.nan
    return loading_dict


def main():
    np.random.seed(RANDOM_SEED)

    print("=" * 90)
    print("PHASE 3: MEASUREMENT INVARIANCE TESTING")
    print("=" * 90)

    Path('plots').mkdir(exist_ok=True)
    Path('tables').mkdir(exist_ok=True)
    sns.set_style('whitegrid')

    # ── Load Data ─────────────────────────────────────────────────────────
    df_efa = pd.read_csv('data/AIRS_experiment.csv')
    df_cfa = pd.read_csv('data/AIRS_holdout.csv')
    df_full = pd.concat([df_efa, df_cfa], ignore_index=True)
    print(f"\nFull sample: N = {len(df_full)}")

    # ── Load Model Structure ──────────────────────────────────────────────
    try:
        with open('tables/cfa_summary.json', 'r') as f:
            cfa_results = json.load(f)
        MODEL_D_STRUCTURE = cfa_results['factor_structure']
        cfa_reliability = {item['Factor']: item['Alpha'] for item in cfa_results.get('reliability', [])}
        print(f"Loaded CFA structure: {len(MODEL_D_STRUCTURE)} factors")
    except FileNotFoundError:
        MODEL_D_STRUCTURE = {
            'PerfExp': ['PE1', 'PE2'], 'EffortExp': ['EE1', 'EE2'],
            'SocialInf': ['SI1', 'SI2'], 'FacilCond': ['FC1', 'FC2'],
            'HedonicMot': ['HM1', 'HM2'], 'PriceValue': ['PV1', 'PV2'],
            'Habit': ['HB1', 'HB2'], 'AITrust': ['TR1', 'TR2'],
        }
        cfa_reliability = {}
        print("Using hardcoded fallback structure (8 factors)")

    MODEL_D_ITEMS = [item for items in MODEL_D_STRUCTURE.values() for item in items]

    for factor, items in MODEL_D_STRUCTURE.items():
        alpha_str = f" (a={cfa_reliability[factor]:.2f})" if factor in cfa_reliability else ""
        print(f"  {factor}: {items}{alpha_str}")

    # ── Create Groups ─────────────────────────────────────────────────────
    academic_roles = ['Full time student', 'Part time student']
    df_full['Population'] = df_full['Role'].apply(
        lambda x: 'Academic' if x in academic_roles else 'Professional'
    )
    df_academic = df_full[df_full['Population'] == 'Academic'].copy()
    df_professional = df_full[df_full['Population'] == 'Professional'].copy()

    print(f"\nAcademic: N = {len(df_academic)} ({len(df_academic)/len(df_full)*100:.1f}%)")
    print(f"Professional: N = {len(df_professional)} ({len(df_professional)/len(df_full)*100:.1f}%)")

    # ── Baseline CFAs ─────────────────────────────────────────────────────
    MODEL_SYNTAX = build_cfa_syntax(MODEL_D_STRUCTURE)
    print(f"\n{'=' * 90}")
    print("BASELINE CFA (Separate Groups)")
    print(f"{'=' * 90}")

    academic_fit = fit_cfa_model(df_academic[MODEL_D_ITEMS], MODEL_SYNTAX, "Academic")
    professional_fit = fit_cfa_model(df_professional[MODEL_D_ITEMS], MODEL_SYNTAX, "Professional")

    # ── Configural Invariance ─────────────────────────────────────────────
    configural_pass = (
        academic_fit['cfi'] >= 0.90 and professional_fit['cfi'] >= 0.90 and
        academic_fit['rmsea'] <= 0.08 and professional_fit['rmsea'] <= 0.08
    )
    print(f"\nConfigural Invariance: {'SUPPORTED' if configural_pass else 'QUESTIONABLE'}")

    # ── Extract Loadings ──────────────────────────────────────────────────
    academic_loadings = extract_loadings(academic_fit['model'], MODEL_D_STRUCTURE)
    professional_loadings = extract_loadings(professional_fit['model'], MODEL_D_STRUCTURE)

    loading_comparison = []
    for factor, items in MODEL_D_STRUCTURE.items():
        for item in items:
            acad_load = academic_loadings.get((factor, item), np.nan)
            prof_load = professional_loadings.get((factor, item), np.nan)
            diff = abs(acad_load - prof_load) if not np.isnan(acad_load) and not np.isnan(prof_load) else np.nan
            loading_comparison.append({
                'Factor': factor, 'Item': item,
                'Academic_Lambda': acad_load, 'Professional_Lambda': prof_load,
                'Difference': diff
            })
    loading_df = pd.DataFrame(loading_comparison)

    print(f"\n{'=' * 90}")
    print("FACTOR LOADINGS BY GROUP")
    print(f"{'=' * 90}")
    print(loading_df.to_string(index=False, float_format=lambda x: f"{x:.3f}"))

    # ── Metric Invariance ─────────────────────────────────────────────────
    mean_diff = loading_df['Difference'].mean()
    max_diff = loading_df['Difference'].max()
    items_over_threshold = int((loading_df['Difference'] > 0.10).sum())
    metric_pass = max_diff < 0.15 and items_over_threshold <= 2

    print(f"\n{'=' * 90}")
    print("METRIC INVARIANCE")
    print(f"{'=' * 90}")
    print(f"Mean |Delta-lambda| = {mean_diff:.3f}")
    print(f"Max  |Delta-lambda| = {max_diff:.3f}")
    print(f"Items > 0.10 threshold: {items_over_threshold}/{len(loading_df)}")
    print(f"{'SUPPORTED' if metric_pass else 'PARTIAL INVARIANCE'}")

    # ── Loading Plots ─────────────────────────────────────────────────────
    fig, axes = plt.subplots(1, 2, figsize=(14, 6))

    ax1 = axes[0]
    x = np.arange(len(loading_df))
    width = 0.35
    ax1.bar(x - width/2, loading_df['Academic_Lambda'], width, label='Academic', color='steelblue', alpha=0.8)
    ax1.bar(x + width/2, loading_df['Professional_Lambda'], width, label='Professional', color='coral', alpha=0.8)
    ax1.set_xticks(x)
    ax1.set_xticklabels(loading_df['Item'], rotation=45, ha='right')
    ax1.set_ylabel('Standardized Loading')
    ax1.set_title('Factor Loadings by Population')
    ax1.legend()
    ax1.axhline(y=0.70, color='green', linestyle='--', alpha=0.5)
    ax1.axhline(y=0.50, color='orange', linestyle='--', alpha=0.5)
    ax1.set_ylim(0, 1.0)

    ax2 = axes[1]
    colors = ['red' if d > 0.10 else 'green' for d in loading_df['Difference']]
    ax2.scatter(loading_df['Academic_Lambda'], loading_df['Professional_Lambda'], c=colors, s=100, alpha=0.7)
    ax2.plot([0, 1], [0, 1], 'k--', alpha=0.5)
    for i, row in loading_df.iterrows():
        ax2.annotate(row['Item'], (row['Academic_Lambda'], row['Professional_Lambda']),
                     fontsize=8, alpha=0.7, xytext=(3, 3), textcoords='offset points')
    ax2.set_xlabel('Academic Loading')
    ax2.set_ylabel('Professional Loading')
    ax2.set_title('Loading Agreement')
    ax2.set_xlim(0.4, 1.0)
    ax2.set_ylim(0.4, 1.0)

    plt.tight_layout()
    plt.savefig('plots/measurement_invariance_loadings.png', dpi=150, bbox_inches='tight')
    plt.close()
    print("\nSaved: plots/measurement_invariance_loadings.png")

    # ── Reliability by Group ──────────────────────────────────────────────
    def calc_reliability(df, structure):
        results = []
        for factor, items in structure.items():
            alpha = pg.cronbach_alpha(df[items])[0]
            results.append({'Factor': factor, 'Alpha': alpha})
        return pd.DataFrame(results)

    acad_rel = calc_reliability(df_academic, MODEL_D_STRUCTURE)
    prof_rel = calc_reliability(df_professional, MODEL_D_STRUCTURE)
    reliability_comparison = acad_rel.merge(prof_rel, on='Factor', suffixes=('_Academic', '_Professional'))
    reliability_comparison['Difference'] = abs(
        reliability_comparison['Alpha_Academic'] - reliability_comparison['Alpha_Professional']
    )

    print(f"\n{'=' * 90}")
    print("RELIABILITY BY GROUP")
    print(f"{'=' * 90}")
    print(reliability_comparison.to_string(index=False, float_format=lambda x: f"{x:.3f}"))

    # ── Mean Comparisons ──────────────────────────────────────────────────
    mean_comparison = []
    for factor, items in MODEL_D_STRUCTURE.items():
        acad_scores = df_academic[items].mean(axis=1)
        prof_scores = df_professional[items].mean(axis=1)
        t_stat, p_value = stats.ttest_ind(acad_scores, prof_scores)
        pooled_std = np.sqrt(((len(acad_scores)-1)*acad_scores.std()**2 +
                              (len(prof_scores)-1)*prof_scores.std()**2) /
                             (len(acad_scores) + len(prof_scores) - 2))
        cohens_d = (acad_scores.mean() - prof_scores.mean()) / pooled_std if pooled_std > 0 else 0

        if abs(cohens_d) < 0.20: effect = "negligible"
        elif abs(cohens_d) < 0.50: effect = "small"
        elif abs(cohens_d) < 0.80: effect = "medium"
        else: effect = "large"

        mean_comparison.append({
            'Factor': factor,
            'M_Academic': acad_scores.mean(), 'SD_Academic': acad_scores.std(),
            'M_Professional': prof_scores.mean(), 'SD_Professional': prof_scores.std(),
            't': t_stat, 'p': p_value, "Cohen's d": cohens_d, 'Effect': effect,
            'Sig': '***' if p_value < 0.001 else '**' if p_value < 0.01 else '*' if p_value < 0.05 else ''
        })
    mean_df = pd.DataFrame(mean_comparison)

    n_sig_means = int((mean_df['p'] < 0.05).sum())
    n_medium_large = int((mean_df["Cohen's d"].abs() >= 0.50).sum())

    print(f"\n{'=' * 90}")
    print("MEAN COMPARISONS: ACADEMIC VS PROFESSIONAL")
    print(f"{'=' * 90}")
    print(mean_df[['Factor', 'M_Academic', 'SD_Academic', 'M_Professional', 'SD_Professional',
                    't', 'p', "Cohen's d", 'Effect', 'Sig']]
          .to_string(index=False, float_format=lambda x: f"{x:.3f}" if isinstance(x, float) else x))
    print(f"\nSignificant diffs: {n_sig_means}/{len(mean_df)}, Medium/Large effects: {n_medium_large}/{len(mean_df)}")

    # ── Mean Difference Plots ─────────────────────────────────────────────
    fig, axes = plt.subplots(1, 2, figsize=(14, 6))

    ax1 = axes[0]
    x = np.arange(len(mean_df))
    width = 0.35
    ax1.bar(x - width/2, mean_df['M_Academic'], width,
            yerr=mean_df['SD_Academic']/np.sqrt(len(df_academic)),
            label='Academic', color='steelblue', alpha=0.8, capsize=3)
    ax1.bar(x + width/2, mean_df['M_Professional'], width,
            yerr=mean_df['SD_Professional']/np.sqrt(len(df_professional)),
            label='Professional', color='coral', alpha=0.8, capsize=3)
    for i, row in mean_df.iterrows():
        if row['Sig']:
            max_y = max(row['M_Academic'], row['M_Professional']) + 0.3
            ax1.text(i, max_y, row['Sig'], ha='center', fontsize=12, fontweight='bold')
    ax1.set_xticks(x)
    ax1.set_xticklabels(mean_df['Factor'], rotation=45, ha='right')
    ax1.set_ylabel('Mean Score (1-5)')
    ax1.set_title('Construct Means by Population')
    ax1.legend()
    ax1.set_ylim(1, 5.5)

    ax2 = axes[1]
    colors = ['steelblue' if d > 0 else 'coral' for d in mean_df["Cohen's d"]]
    ax2.barh(mean_df['Factor'], mean_df["Cohen's d"], color=colors, alpha=0.8)
    ax2.axvline(x=0.20, color='gray', linestyle='--', alpha=0.5)
    ax2.axvline(x=-0.20, color='gray', linestyle='--', alpha=0.5)
    ax2.axvline(x=0, color='black', linewidth=1)
    ax2.set_xlabel("Cohen's d")
    ax2.set_title('Effect Sizes for Group Differences')
    ax2.set_xlim(-1.0, 1.0)

    plt.tight_layout()
    plt.savefig('plots/measurement_invariance_means.png', dpi=150, bbox_inches='tight')
    plt.close()
    print("Saved: plots/measurement_invariance_means.png")

    # ── Export ────────────────────────────────────────────────────────────
    loading_df.to_csv('tables/invariance_loadings.csv', index=False)
    reliability_comparison.to_csv('tables/invariance_reliability.csv', index=False)
    mean_df.to_csv('tables/invariance_means.csv', index=False)

    invariance_summary = {
        'analysis_date': pd.Timestamp.now().isoformat(),
        'n_academic': len(df_academic),
        'n_professional': len(df_professional),
        'academic_fit': {
            'chi2': float(academic_fit['chi2']), 'df': float(academic_fit['df']),
            'cfi': float(academic_fit['cfi']), 'tli': float(academic_fit['tli']),
            'rmsea': float(academic_fit['rmsea'])
        },
        'professional_fit': {
            'chi2': float(professional_fit['chi2']), 'df': float(professional_fit['df']),
            'cfi': float(professional_fit['cfi']), 'tli': float(professional_fit['tli']),
            'rmsea': float(professional_fit['rmsea'])
        },
        'configural_invariance': bool(configural_pass),
        'metric_invariance': bool(metric_pass),
        'mean_loading_diff': float(mean_diff),
        'max_loading_diff': float(max_diff),
        'n_sig_mean_diffs': n_sig_means,
        'n_medium_large_effects': n_medium_large
    }
    with open('data/invariance_results.json', 'w') as f:
        json.dump(invariance_summary, f, indent=2, default=str)

    print("\nExported: tables/invariance_*.csv, data/invariance_results.json")

    print(f"\n{'=' * 90}")
    print("PHASE 3 COMPLETE")
    print(f"{'=' * 90}")


if __name__ == '__main__':
    main()
