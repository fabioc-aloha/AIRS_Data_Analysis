#!/usr/bin/env python3
"""
AIRS Phase 1: Exploratory Factor Analysis (EFA)
Refactored from 01_EFA_Experiment.ipynb

MINRES extraction + Promax rotation on development sample.
Outputs: tables/efa_summary.json, tables/full_pattern_matrix.csv,
         tables/item_diagnostics.csv, tables/construct_diagnostics.csv,
         tables/factor_quality.csv, plots/phase1_*.png, plots/phase2_*.png
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
from factor_analyzer import FactorAnalyzer, calculate_kmo, calculate_bartlett_sphericity

os.environ['KMP_DUPLICATE_LIB_OK'] = 'True'
warnings.filterwarnings('ignore')

RANDOM_SEED = 67


# ═══════════════════════════════════════════════════════════════════════════════
# HELPERS
# ═══════════════════════════════════════════════════════════════════════════════

def cronbach_alpha(data):
    """Cronbach's alpha for a set of items."""
    n_items = data.shape[1]
    if n_items < 2:
        return np.nan
    item_vars = data.var(axis=0, ddof=1)
    total_var = data.sum(axis=1).var(ddof=1)
    return (n_items / (n_items - 1)) * (1 - item_vars.sum() / total_var)


def item_total_correlation(df, items):
    """Corrected item-total correlations."""
    results = {}
    total = df[items].sum(axis=1)
    for item in items:
        corrected_total = total - df[item]
        results[item] = df[item].corr(corrected_total)
    return results


def parallel_analysis(data, n_iterations=100, percentile=95):
    """Parallel analysis to determine number of factors."""
    n_obs, n_vars = data.shape
    random_eigenvalues = np.zeros((n_iterations, n_vars))
    for i in range(n_iterations):
        random_data = np.random.normal(size=(n_obs, n_vars))
        random_corr = np.corrcoef(random_data, rowvar=False)
        random_eigenvalues[i] = np.linalg.eigvalsh(random_corr)[::-1]
    return np.percentile(random_eigenvalues, percentile, axis=0)


def main():
    np.random.seed(RANDOM_SEED)

    print("=" * 90)
    print("PHASE 1: EXPLORATORY FACTOR ANALYSIS (EFA)")
    print("=" * 90)

    Path('plots').mkdir(exist_ok=True)
    Path('tables').mkdir(exist_ok=True)

    sns.set_style("whitegrid")

    # ── Load Data ─────────────────────────────────────────────────────────
    df_full = pd.read_csv('data/AIRS_experiment.csv')
    with open('data/experiment_config.json', 'r') as f:
        exp_config = json.load(f)
    with open('../data/airs_28item_complete.json', 'r', encoding='utf-8') as f:
        item_metadata = json.load(f)

    ALL_PREDICTOR_ITEMS = item_metadata['predictor_items']
    outcome_items = item_metadata['outcome_items']
    metadata = item_metadata['metadata']

    ALL_PREDICTOR_CONSTRUCTS = {}
    for item in ALL_PREDICTOR_ITEMS:
        construct = item[:-1]
        ALL_PREDICTOR_CONSTRUCTS.setdefault(construct, []).append(item)

    print(f"\nEFA Sample: N = {len(df_full)}")
    print(f"Predictor items: {len(ALL_PREDICTOR_ITEMS)}")
    print(f"Constructs: {len(ALL_PREDICTOR_CONSTRUCTS)}")

    df_all_items = df_full[ALL_PREDICTOR_ITEMS].copy()

    # ── Descriptive Statistics ────────────────────────────────────────────
    desc_stats = df_all_items.describe().T
    desc_stats['skew'] = df_all_items.skew()
    desc_stats['kurtosis'] = df_all_items.kurtosis()
    desc_stats['construct'] = [metadata[item]['construct_abbr'] for item in desc_stats.index]

    print("\nDESCRIPTIVE STATISTICS (24 predictors)")
    print("-" * 80)
    print(desc_stats[['construct', 'mean', 'std', 'min', 'max', 'skew', 'kurtosis']].round(3).to_string())

    skew_issues = desc_stats[abs(desc_stats['skew']) > 1.0]
    kurt_issues = desc_stats[abs(desc_stats['kurtosis']) > 3.0]
    if len(skew_issues) > 0:
        print(f"\nItems with |skewness| > 1.0: {list(skew_issues.index)}")
    if len(kurt_issues) > 0:
        print(f"Items with |kurtosis| > 3.0: {list(kurt_issues.index)}")

    # ── Within-Construct Reliability ──────────────────────────────────────
    construct_diagnostics = []

    print("\n" + "=" * 90)
    print("WITHIN-CONSTRUCT RELIABILITY")
    print("=" * 90)

    for construct, items in ALL_PREDICTOR_CONSTRUCTS.items():
        construct_name = metadata[items[0]]['construct']
        construct_df = df_all_items[items]
        r = construct_df.corr().iloc[0, 1]
        alpha = cronbach_alpha(construct_df)
        itc = item_total_correlation(df_all_items, items)

        if alpha >= 0.70:
            status = "Good"
        elif alpha >= 0.60:
            status = "Marginal"
        else:
            status = "Poor"

        construct_diagnostics.append({
            'Construct': construct,
            'Name': construct_name,
            'Items': ', '.join(items),
            'r_inter': r,
            'Alpha': alpha,
            'ITC_1': itc[items[0]],
            'ITC_2': itc[items[1]],
            'Status': status
        })

        print(f"\n{construct} ({construct_name}):")
        print(f"  Inter-item r = {r:.3f}, Alpha = {alpha:.3f} [{status}]")

    diagnostics_df = pd.DataFrame(construct_diagnostics)

    good = len(diagnostics_df[diagnostics_df['Alpha'] >= 0.70])
    marginal = len(diagnostics_df[(diagnostics_df['Alpha'] >= 0.60) & (diagnostics_df['Alpha'] < 0.70)])
    poor = len(diagnostics_df[diagnostics_df['Alpha'] < 0.60])
    print(f"\nGood (alpha >= .70): {good}/12, Marginal: {marginal}/12, Poor: {poor}/12")

    # ── Within-Construct Heatmap ──────────────────────────────────────────
    fig, axes = plt.subplots(3, 4, figsize=(16, 12))
    axes = axes.flatten()
    for idx, (construct, items) in enumerate(ALL_PREDICTOR_CONSTRUCTS.items()):
        ax = axes[idx]
        corr = df_all_items[items].corr()
        alpha_val = diagnostics_df[diagnostics_df['Construct'] == construct]['Alpha'].values[0]
        status = diagnostics_df[diagnostics_df['Construct'] == construct]['Status'].values[0]
        color = 'darkgreen' if status == 'Good' else ('goldenrod' if status == 'Marginal' else 'darkred')
        sns.heatmap(corr, annot=True, fmt='.2f', cmap='RdYlGn', center=0.5,
                    vmin=0, vmax=1, ax=ax, cbar=False, xticklabels=items, yticklabels=items)
        ax.set_title(f"{construct} (a={alpha_val:.2f})", fontsize=10, color=color, fontweight='bold')
    plt.suptitle('Within-Construct Inter-Item Correlations', fontsize=14, y=1.02)
    plt.tight_layout()
    plt.savefig('plots/phase1_within_construct_correlations.png', dpi=150, bbox_inches='tight')
    plt.close()
    print("\nSaved: plots/phase1_within_construct_correlations.png")

    # ── Item Diagnostics ──────────────────────────────────────────────────
    item_diagnostics = []
    for item in ALL_PREDICTOR_ITEMS:
        construct = metadata[item]['construct_abbr']
        direction = metadata[item]['direction']
        construct_items = ALL_PREDICTOR_CONSTRUCTS[construct]
        itc_dict = item_total_correlation(df_all_items, construct_items)
        mean_val = df_all_items[item].mean()
        std_val = df_all_items[item].std()
        skew_val = df_all_items[item].skew()
        kurt_val = df_all_items[item].kurtosis()
        issues = []
        if abs(skew_val) > 1.0:
            issues.append('SKEW')
        if abs(kurt_val) > 3.0:
            issues.append('KURT')
        if itc_dict[item] < 0.30:
            issues.append('LOW_ITC')
        item_diagnostics.append({
            'Item': item, 'Construct': construct, 'Direction': direction,
            'Mean': mean_val, 'SD': std_val, 'Skew': skew_val,
            'Kurt': kurt_val, 'ITC': itc_dict[item],
            'Issues': ', '.join(issues) if issues else 'OK'
        })
    item_diag_df = pd.DataFrame(item_diagnostics)

    problem_items = item_diag_df[item_diag_df['Issues'] != 'OK']
    if len(problem_items) > 0:
        print(f"\nItems with issues ({len(problem_items)}):")
        for _, row in problem_items.iterrows():
            print(f"  {row['Item']} ({row['Construct']}): {row['Issues']}")

    # ── KMO & Bartlett's ─────────────────────────────────────────────────
    kmo_all, kmo_model = calculate_kmo(df_all_items)
    chi_square, p_value = calculate_bartlett_sphericity(df_all_items)

    if kmo_model >= 0.90:
        kmo_interpretation = "Marvelous"
    elif kmo_model >= 0.80:
        kmo_interpretation = "Meritorious"
    elif kmo_model >= 0.70:
        kmo_interpretation = "Middling"
    elif kmo_model >= 0.60:
        kmo_interpretation = "Mediocre"
    elif kmo_model >= 0.50:
        kmo_interpretation = "Miserable"
    else:
        kmo_interpretation = "Unacceptable"

    print(f"\n{'=' * 90}")
    print("FACTORABILITY")
    print(f"{'=' * 90}")
    print(f"KMO = {kmo_model:.3f} ({kmo_interpretation})")
    print(f"Bartlett's chi2 = {chi_square:.2f}, p = {p_value:.2e}")

    # ── Communalities ────────────────────────────────────────────────────
    fa_comm = FactorAnalyzer(n_factors=6, rotation='promax', method='minres')
    fa_comm.fit(df_all_items)
    communalities = pd.Series(fa_comm.get_communalities(), index=ALL_PREDICTOR_ITEMS)

    comm_df = pd.DataFrame({
        'Item': ALL_PREDICTOR_ITEMS,
        'Communality': communalities.values,
        'Construct': [metadata[item]['construct_abbr'] for item in ALL_PREDICTOR_ITEMS]
    }).sort_values('Item', ascending=False)

    fig, ax = plt.subplots(figsize=(10, 10))
    colors = ['darkred' if c < 0.30 else 'goldenrod' if c < 0.40 else 'darkgreen'
              for c in comm_df['Communality']]
    ax.barh(range(len(comm_df)), comm_df['Communality'], color=colors, edgecolor='black', alpha=0.8)
    ax.set_yticks(range(len(comm_df)))
    ax.set_yticklabels([f"{row['Item']} ({row['Construct']})" for _, row in comm_df.iterrows()])
    ax.axvline(x=0.40, color='green', linestyle='--', linewidth=2, label='Good (>=0.40)')
    ax.axvline(x=0.30, color='red', linestyle='--', linewidth=2, label='Minimum (>=0.30)')
    ax.set_xlabel('Communality', fontsize=12)
    ax.set_title('Item Communalities (6-Factor Solution)', fontsize=14)
    ax.legend(loc='lower right')
    ax.set_xlim(0, 1)
    ax.grid(axis='x', alpha=0.3)
    plt.tight_layout()
    plt.savefig('plots/phase1_communalities.png', dpi=150, bbox_inches='tight')
    plt.close()
    print("Saved: plots/phase1_communalities.png")

    # ── Parallel Analysis & Eigenvalues ──────────────────────────────────
    predictor_items = ALL_PREDICTOR_ITEMS.copy()
    predictor_constructs = ALL_PREDICTOR_CONSTRUCTS.copy()
    df_efa = df_full[predictor_items].copy()

    fa_eigen = FactorAnalyzer(rotation=None, n_factors=len(predictor_items))
    fa_eigen.fit(df_efa)
    ev, _ = fa_eigen.get_eigenvalues()
    random_ev = parallel_analysis(df_efa.values)

    n_factors_kaiser = int(sum(ev > 1))
    n_factors_pa = int(sum(ev > random_ev))

    print(f"\n{'=' * 90}")
    print("FACTOR EXTRACTION CRITERIA")
    print(f"{'=' * 90}")
    print(f"Kaiser criterion (lambda > 1): {n_factors_kaiser} factors")
    print(f"Parallel analysis: {n_factors_pa} factors")

    # Scree plot
    fig, ax = plt.subplots(figsize=(12, 6))
    x = range(1, len(ev) + 1)
    ax.plot(x, ev, 'bo-', linewidth=2, markersize=8, label='Actual Eigenvalues')
    ax.plot(x, random_ev, 'r--', linewidth=2, label='Parallel Analysis (95th pctile)')
    ax.axhline(y=1, color='gray', linestyle=':', label='Kaiser Criterion')
    ax.set_xlabel('Factor Number')
    ax.set_ylabel('Eigenvalue')
    ax.set_title('Scree Plot with Parallel Analysis')
    ax.legend()
    ax.set_xticks(range(1, len(ev) + 1))
    ax.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig('plots/phase2_scree_plot.png', dpi=150, bbox_inches='tight')
    plt.close()
    print("Saved: plots/phase2_scree_plot.png")

    # ── Full 12-Factor EFA ───────────────────────────────────────────────
    n_factors_max = min(12, len(predictor_items))
    efa_full = FactorAnalyzer(n_factors=n_factors_max, rotation='promax', method='minres')
    efa_full.fit(df_efa)

    var_full = efa_full.get_factor_variance()
    eigenvalues_full = var_full[0]
    prop_var_full = var_full[1]
    cum_var_full = var_full[2]

    print(f"\n{'=' * 90}")
    print(f"FULL {n_factors_max}-FACTOR SOLUTION (MINRES + Promax)")
    print(f"{'=' * 90}")
    print(f"{'Factor':<8} {'SS Loading':<12} {'% Var':<10} {'Cum %':<10}")
    print("-" * 40)
    for i in range(n_factors_max):
        print(f"F{i+1:<7} {eigenvalues_full[i]:<12.3f} {prop_var_full[i]*100:<10.1f} {cum_var_full[i]*100:<10.1f}")
    print(f"\nTotal variance explained: {cum_var_full[-1]*100:.1f}%")

    # ── Pattern Matrix ───────────────────────────────────────────────────
    factor_cols = [f'F{i+1}' for i in range(n_factors_max)]
    loadings_full = pd.DataFrame(
        efa_full.loadings_, index=predictor_items, columns=factor_cols
    )
    loadings_full['Construct'] = [metadata[item]['construct_abbr'] for item in loadings_full.index]

    print("\nPATTERN MATRIX (loadings >= 0.32 shown)")
    print("-" * 90)
    for item in predictor_items:
        row = loadings_full.loc[item, factor_cols]
        sig = row[row.abs() >= 0.32]
        if len(sig) > 0:
            loads = ", ".join([f"{f}={v:+.3f}" for f, v in sig.items()])
        else:
            loads = "(no loading >= .32)"
        print(f"  {item:4s} ({metadata[item]['construct_abbr']:2s}): {loads}")

    # ── Factor Quality ───────────────────────────────────────────────────
    factor_quality = []
    for i in range(n_factors_max):
        factor_name = f'F{i+1}'
        abs_loadings = loadings_full[factor_name].abs()
        strong_items = loadings_full[abs_loadings >= 0.50].index.tolist()
        cross_loading_issues = []
        for item in strong_items:
            other_factors = [f for f in factor_cols if f != factor_name]
            other_max = loadings_full.loc[item, other_factors].abs().max()
            if other_max >= 0.32:
                cross_loading_issues.append(item)
        constructs = list(set(metadata[item]['construct_abbr'] for item in strong_items))
        if len(strong_items) >= 2 and len(cross_loading_issues) == 0:
            quality = "RETAIN (clean)"
        elif len(strong_items) >= 2:
            quality = "RETAIN (cross-loading)"
        elif len(strong_items) == 1:
            quality = "CONSIDER"
        else:
            quality = "SKIP"
        factor_quality.append({
            'Factor': factor_name,
            'Eigenvalue': eigenvalues_full[i],
            'Strong_Items': len(strong_items),
            'Cross_Loadings': len(cross_loading_issues),
            'Constructs': constructs,
            'Quality': quality
        })
    quality_df = pd.DataFrame(factor_quality)

    print(f"\n{'=' * 90}")
    print("FACTOR QUALITY SUMMARY")
    print(f"{'=' * 90}")
    for _, row in quality_df.iterrows():
        print(f"  {row['Factor']}: lambda={row['Eigenvalue']:.2f}, "
              f"strong={row['Strong_Items']}, cross={row['Cross_Loadings']} -> {row['Quality']}")

    # ── Cross-Loading Analysis ────────────────────────────────────────────
    cross_loading_threshold = 0.32
    cross_loaders = []
    for item in predictor_items:
        item_loadings = loadings_full.loc[item, factor_cols].abs()
        significant = item_loadings[item_loadings >= cross_loading_threshold]
        if len(significant) > 1:
            primary = item_loadings.idxmax()
            secondary_factors = [f for f in significant.index if f != primary]
            cross_loaders.append({
                'Item': item,
                'Construct': metadata[item]['construct_abbr'],
                'Primary': primary,
                'Primary_Loading': float(loadings_full.loc[item, primary]),
                'Cross_Factors': ', '.join([f"{f}({loadings_full.loc[item, f]:+.2f})" for f in secondary_factors])
            })
    cross_df = pd.DataFrame(cross_loaders) if cross_loaders else pd.DataFrame()

    # Cross-loading bar chart
    items_sorted = sorted(predictor_items, key=lambda x: (metadata[x]['construct_abbr'], x))
    primary_loads = [loadings_full.loc[item, factor_cols].abs().max() for item in items_sorted]
    secondary_loads = [sorted(loadings_full.loc[item, factor_cols].abs(), reverse=True)[1]
                       for item in items_sorted]
    cross_items = set(cross_df['Item']) if len(cross_df) > 0 else set()
    colors = ['#2ecc71' if item not in cross_items else '#f39c12' for item in items_sorted]

    fig, ax = plt.subplots(figsize=(14, 6))
    xpos = np.arange(len(items_sorted))
    ax.bar(xpos, primary_loads, color=colors, edgecolor='black', alpha=0.8, label='Primary loading')
    ax.bar(xpos, secondary_loads, color='lightgray', edgecolor='black', alpha=0.5, label='Secondary loading')
    ax.axhline(y=cross_loading_threshold, color='red', linestyle='--', lw=2, label=f'Threshold ({cross_loading_threshold})')
    ax.set_xticks(xpos)
    ax.set_xticklabels([f"{item}\n({metadata[item]['construct_abbr']})" for item in items_sorted],
                       rotation=45, ha='right', fontsize=8)
    ax.set_ylabel('Absolute Loading')
    ax.set_title('Cross-Loading Analysis')
    ax.set_ylim(0, 1)
    ax.legend(loc='upper right')
    ax.grid(axis='y', alpha=0.3)
    plt.tight_layout()
    plt.savefig('plots/phase2_cross_loadings.png', dpi=150, bbox_inches='tight')
    plt.close()
    print(f"\nSaved: plots/phase2_cross_loadings.png")
    print(f"Clean items: {len(predictor_items) - len(cross_df)}/{len(predictor_items)}")
    print(f"Cross-loaders: {len(cross_df)}/{len(predictor_items)}")

    # ── Export ────────────────────────────────────────────────────────────
    print(f"\n{'=' * 90}")
    print("EXPORTING EFA RESULTS")
    print(f"{'=' * 90}")

    loadings_full.to_csv('tables/full_pattern_matrix.csv')
    print("  tables/full_pattern_matrix.csv")

    item_diag_df.to_csv('tables/item_diagnostics.csv', index=False)
    print("  tables/item_diagnostics.csv")

    diagnostics_df.to_csv('tables/construct_diagnostics.csv', index=False)
    print("  tables/construct_diagnostics.csv")

    quality_df.to_csv('tables/factor_quality.csv', index=False)
    print("  tables/factor_quality.csv")

    # Validated factor structure (alpha >= .70 only)
    good_constructs = diagnostics_df[diagnostics_df['Alpha'] >= 0.70]['Construct'].tolist()
    validated_factor_structure = {
        construct: items for construct, items in predictor_constructs.items()
        if construct in good_constructs
    }

    efa_summary = {
        'population': exp_config.get('population', 'ALL'),
        'n_observations': len(df_full),
        'n_items': len(predictor_items),
        'n_constructs': len(predictor_constructs),
        'kmo': float(kmo_model),
        'kmo_interpretation': kmo_interpretation,
        'bartlett_chi2': float(chi_square),
        'bartlett_p': float(p_value),
        'n_factors_kaiser': n_factors_kaiser,
        'n_factors_parallel': n_factors_pa,
        'variance_explained_12factors': float(cum_var_full[-1]),
        'constructs_good_reliability': good_constructs,
        'constructs_marginal_reliability': diagnostics_df[
            (diagnostics_df['Alpha'] >= 0.60) & (diagnostics_df['Alpha'] < 0.70)
        ]['Construct'].tolist(),
        'constructs_poor_reliability': diagnostics_df[
            diagnostics_df['Alpha'] < 0.60
        ]['Construct'].tolist(),
        'validated_factor_structure': validated_factor_structure,
        'all_factor_structure': {k: list(v) for k, v in predictor_constructs.items()},
        'reliability_coefficients': {
            row['Construct']: round(row['Alpha'], 3)
            for _, row in diagnostics_df.iterrows()
        }
    }
    with open('tables/efa_summary.json', 'w') as f:
        json.dump(efa_summary, f, indent=2, default=str)
    print("  tables/efa_summary.json")

    print(f"\nValidated structure ({len(validated_factor_structure)} factors):")
    for factor, fitems in validated_factor_structure.items():
        alpha = diagnostics_df[diagnostics_df['Construct'] == factor]['Alpha'].values[0]
        print(f"  {factor}: {fitems} (alpha = {alpha:.2f})")

    # ── Summary ──────────────────────────────────────────────────────────
    print(f"\n{'=' * 90}")
    print("EFA SUMMARY")
    print(f"{'=' * 90}")
    print(f"  N = {len(df_full)}, Items = {len(predictor_items)}, Constructs = {len(predictor_constructs)}")
    print(f"  KMO = {kmo_model:.3f} ({kmo_interpretation})")
    print(f"  Bartlett chi2 = {chi_square:.2f}, p = {p_value:.2e}")
    print(f"  Kaiser: {n_factors_kaiser} factors, Parallel Analysis: {n_factors_pa} factors")
    print(f"  Variance explained (12 factors): {cum_var_full[-1]*100:.1f}%")
    print(f"  Good alpha: {good}/12, Marginal: {marginal}/12, Poor: {poor}/12")
    print(f"  Poor constructs: {diagnostics_df[diagnostics_df['Alpha'] < 0.60]['Construct'].tolist()}")

    print(f"\n{'=' * 90}")
    print("PHASE 1 COMPLETE")
    print(f"{'=' * 90}")


if __name__ == '__main__':
    main()
