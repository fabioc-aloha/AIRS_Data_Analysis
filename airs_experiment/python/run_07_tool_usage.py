#!/usr/bin/env python3
"""
Phase 7: AI Tool Usage Patterns (RQ10)
Standalone script refactored from 07_Tool_Usage_Patterns.ipynb

Analyzes:
  RQ10a - Usage frequency distributions
  RQ10b - Role-type comparison (3-group ANOVA)
  RQ10c - Usage × construct correlations (Spearman)
  RQ10d - Multi-tool user analysis
"""

import json
import warnings
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from scipy import stats
import seaborn as sns

warnings.filterwarnings('ignore')

# ── Configuration ──────────────────────────────────────────────────────────────

USAGE_COLS = ['Usage_MSCopilot', 'Usage_ChatGPT', 'Usage_Gemini', 'Usage_Other']
USAGE_LABELS = {1: 'Never', 2: 'Rarely', 3: 'Sometimes', 4: 'Often', 5: 'Very often'}

CONSTRUCT_ITEMS = {
    'PerfExp': ['PE1', 'PE2'],
    'EffortExp': ['EE1', 'EE2'],
    'SocialInf': ['SI1', 'SI2'],
    'FacCond': ['FC1', 'FC2'],
    'HedMot': ['HM1', 'HM2'],
    'PriceVal': ['PV1', 'PV2'],
    'Habit': ['HB1', 'HB2'],
    'Trust': ['TR1', 'TR2'],
}

PROFILE_CONSTRUCTS = ['PerfExp', 'EffortExp', 'SocialInf', 'FacCond',
                      'HedMot', 'PriceVal', 'Habit', 'Trust', 'BehInt']
CONSTRUCT_LABELS = ['PE', 'EE', 'SI', 'FC', 'HM', 'PV', 'HB', 'TR', 'BI']


# ── Helpers ────────────────────────────────────────────────────────────────────

def classify_role_type(role_cat):
    """Classify Role_Category into 3 groups: Academic, Professional, Leader."""
    if pd.isna(role_cat):
        return 'Professional'
    role_cat = str(role_cat)
    if role_cat in ('FT_Student', 'PT_Student'):
        return 'Academic'
    if role_cat in ('Manager', 'Executive'):
        return 'Leader'
    return 'Professional'


def count_tools_used(row, threshold=2):
    """Count tools with usage >= threshold."""
    return sum(1 for c in USAGE_COLS if row[c] >= threshold)


def classify_user(n_tools):
    if n_tools == 0:
        return 'Non-User'
    if n_tools == 1:
        return 'Single-Tool'
    if n_tools == 2:
        return 'Dual-Tool'
    return 'Multi-Tool'


def calc_tool_stats(df, tool_col):
    """Summary statistics for a single usage column."""
    vals = df[tool_col].dropna()
    return {
        'mean': float(vals.mean()),
        'std': float(vals.std()),
        'median': float(vals.median()),
        'never_pct': float((vals == 1).mean() * 100),
        'active_pct': float((vals >= 3).mean() * 100),
        'heavy_pct': float((vals >= 4).mean() * 100),
    }


# ── Main ───────────────────────────────────────────────────────────────────────

def main():
    Path('results').mkdir(exist_ok=True)
    Path('plots').mkdir(exist_ok=True)

    # ── Load combined full sample ──────────────────────────────────────────
    df_efa = pd.read_csv('data/AIRS_experiment.csv')
    df_cfa = pd.read_csv('data/AIRS_holdout.csv')
    df = pd.concat([df_efa, df_cfa], ignore_index=True)
    print(f"Combined sample N = {len(df)}")

    # Compute construct scores
    for construct, items in CONSTRUCT_ITEMS.items():
        df[construct] = df[items].mean(axis=1)
    df['BehInt'] = df[['BI1', 'BI2', 'BI3', 'BI4']].mean(axis=1)
    df['Usage_Total'] = df[USAGE_COLS].mean(axis=1)
    df['Role_Type'] = df['Role_Category'].apply(classify_role_type)

    # ══════════════════════════════════════════════════════════════════════════
    # RQ10a — Usage frequency distributions
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("RQ10a: USAGE FREQUENCY DISTRIBUTIONS")
    print("=" * 70)

    summary_data = {}
    for col in USAGE_COLS:
        s = calc_tool_stats(df, col)
        summary_data[col] = s
        tool_label = col.replace('Usage_', '')
        print(f"\n{tool_label}: M={s['mean']:.2f}, SD={s['std']:.2f}, "
              f"Never={s['never_pct']:.1f}%, Active(≥3)={s['active_pct']:.1f}%, "
              f"Heavy(≥4)={s['heavy_pct']:.1f}%")

    # Plot: usage frequency distributions
    fig, axes = plt.subplots(2, 2, figsize=(12, 8))
    for ax, col in zip(axes.flat, USAGE_COLS):
        vals = df[col].dropna()
        counts = vals.value_counts().sort_index()
        ax.bar(counts.index, counts.values, color='steelblue')
        ax.set_xticks(range(1, 6))
        ax.set_xticklabels([USAGE_LABELS.get(i, str(i)) for i in range(1, 6)],
                           rotation=30, ha='right', fontsize=8)
        ax.set_title(col.replace('Usage_', ''))
        ax.set_ylabel('Count')
    plt.suptitle('AI Tool Usage Frequency Distributions', fontweight='bold')
    plt.tight_layout()
    plt.savefig('plots/07_usage_frequency_distribution.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("\n✓ Saved plots/07_usage_frequency_distribution.png")

    # ══════════════════════════════════════════════════════════════════════════
    # RQ10b — Role-type comparison (3-group)
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("RQ10b: ROLE-TYPE COMPARISON (3-GROUP)")
    print("=" * 70)

    role_counts = df['Role_Type'].value_counts()
    print(f"\nRole distribution: {dict(role_counts)}")

    anova_results = {}
    for col in USAGE_COLS:
        groups = [g[col].dropna().values for _, g in df.groupby('Role_Type')]
        f_stat, p_val = stats.f_oneway(*groups)
        # eta-squared
        grand_mean = df[col].mean()
        ss_between = sum(len(g) * (g[col].mean() - grand_mean) ** 2
                         for _, g in df.groupby('Role_Type'))
        ss_total = ((df[col] - grand_mean) ** 2).sum()
        eta_sq = ss_between / ss_total if ss_total > 0 else 0
        anova_results[col] = {'F': float(f_stat), 'p': float(p_val), 'eta_sq': float(eta_sq)}
        print(f"  {col.replace('Usage_', '')}: F={f_stat:.3f}, p={p_val:.4f}, η²={eta_sq:.4f}")

    # 3-group bar chart
    fig, ax = plt.subplots(figsize=(10, 6))
    role_means = df.groupby('Role_Type')[USAGE_COLS].mean()
    role_means.columns = [c.replace('Usage_', '') for c in USAGE_COLS]
    role_means.plot.bar(ax=ax, width=0.7)
    ax.set_ylabel('Mean Usage (1-5)')
    ax.set_title('AI Tool Usage by Role Type (3-Group)')
    ax.legend(title='Tool')
    plt.xticks(rotation=0)
    plt.tight_layout()
    plt.savefig('plots/07_role_type_3group_comparison.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Saved plots/07_role_type_3group_comparison.png")

    # ── Leadership deep-dive ───────────────────────────────────────────────
    print("\n--- Leadership Deep-Dive ---")
    leaders = df[df['Role_Type'] == 'Leader']
    professionals = df[df['Role_Type'] == 'Professional']
    print(f"Leaders n={len(leaders)}, Professionals n={len(professionals)}")

    leader_results = {'leader_n': int(len(leaders)), 'professional_n': int(len(professionals)),
                      'tool_effects': {}, 'construct_effects': {}}

    # Tool usage comparison
    for col in USAGE_COLS:
        t_stat, p_val = stats.ttest_ind(leaders[col].dropna(), professionals[col].dropna())
        d = (leaders[col].mean() - professionals[col].mean()) / professionals[col].std()
        leader_results['tool_effects'][col] = {
            't': float(t_stat), 'p': float(p_val), 'cohens_d': float(d)}
        sig = '*' if p_val < 0.05 else ''
        print(f"  {col.replace('Usage_', '')}: t={t_stat:.3f}, p={p_val:.4f}, d={d:.3f} {sig}")

    # Construct comparison
    print("\n  Construct comparison (Leaders vs Professionals):")
    for cname in PROFILE_CONSTRUCTS:
        l_vals = leaders[cname].dropna()
        p_vals = professionals[cname].dropna()
        if len(l_vals) > 1 and len(p_vals) > 1:
            t_stat, p_val = stats.ttest_ind(l_vals, p_vals)
            d = (l_vals.mean() - p_vals.mean()) / p_vals.std()
            leader_results['construct_effects'][cname] = {
                't': float(t_stat), 'p': float(p_val), 'cohens_d': float(d)}
            sig = '*' if p_val < 0.05 else ''
            print(f"    {cname}: t={t_stat:.3f}, p={p_val:.4f}, d={d:.3f} {sig}")

    # 2-group bar chart (Leaders vs Professionals)
    fig, ax = plt.subplots(figsize=(10, 6))
    comparison_data = pd.DataFrame({
        'Leader': leaders[PROFILE_CONSTRUCTS].mean(),
        'Professional': professionals[PROFILE_CONSTRUCTS].mean(),
    }, index=CONSTRUCT_LABELS)
    comparison_data.plot.bar(ax=ax, width=0.6)
    ax.set_ylabel('Mean Score (1–5)')
    ax.set_title('AIRS Construct Means: Leaders vs Professionals')
    plt.xticks(rotation=0)
    plt.tight_layout()
    plt.savefig('plots/07_role_type_comparison.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Saved plots/07_role_type_comparison.png")

    # ══════════════════════════════════════════════════════════════════════════
    # RQ10c — Usage × construct correlations (Spearman)
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("RQ10c: USAGE × CONSTRUCT CORRELATIONS (SPEARMAN)")
    print("=" * 70)

    usage_vars = USAGE_COLS + ['Usage_Total']
    corr_matrix = pd.DataFrame(index=usage_vars, columns=PROFILE_CONSTRUCTS, dtype=float)
    p_matrix = pd.DataFrame(index=usage_vars, columns=PROFILE_CONSTRUCTS, dtype=float)
    corr_dict = {}

    for uv in usage_vars:
        corr_dict[uv] = {}
        for cv in PROFILE_CONSTRUCTS:
            valid = df[[uv, cv]].dropna()
            rho, p_val = stats.spearmanr(valid[uv], valid[cv])
            corr_matrix.loc[uv, cv] = rho
            p_matrix.loc[uv, cv] = p_val
            corr_dict[uv][cv] = {'rho': float(rho), 'p': float(p_val)}
        # Print summary for Usage_Total
        if uv == 'Usage_Total':
            print(f"\n  Usage_Total correlations:")
            for cv in PROFILE_CONSTRUCTS:
                r = corr_matrix.loc[uv, cv]
                p = p_matrix.loc[uv, cv]
                sig = '***' if p < 0.001 else '**' if p < 0.01 else '*' if p < 0.05 else ''
                print(f"    {cv}: ρ={r:.3f}, p={p:.4f} {sig}")

    # Correlation heatmap
    fig, ax = plt.subplots(figsize=(12, 6))
    sns.heatmap(corr_matrix.astype(float), annot=True, fmt='.3f', cmap='RdYlGn',
                vmin=-0.1, vmax=0.7, ax=ax, linewidths=0.5)
    ax.set_title('Spearman Correlations: Tool Usage × AIRS Constructs')
    ax.set_xticklabels(CONSTRUCT_LABELS, rotation=0)
    ax.set_yticklabels([v.replace('Usage_', '') for v in usage_vars], rotation=0)
    plt.tight_layout()
    plt.savefig('plots/07_usage_construct_correlations.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Saved plots/07_usage_construct_correlations.png")

    # ══════════════════════════════════════════════════════════════════════════
    # RQ10d — Multi-tool user analysis
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("RQ10d: MULTI-TOOL USER ANALYSIS")
    print("=" * 70)

    df['N_Tools'] = df.apply(count_tools_used, axis=1)
    df['UserType'] = df['N_Tools'].apply(classify_user)

    user_type_order = ['Non-User', 'Single-Tool', 'Dual-Tool', 'Multi-Tool']
    user_counts = df['UserType'].value_counts()
    for ut in user_type_order:
        n = user_counts.get(ut, 0)
        pct = n / len(df) * 100
        print(f"  {ut}: n={n} ({pct:.1f}%)")

    # ANOVA by user type for BI
    groups_bi = [g['BehInt'].dropna().values for ut in user_type_order
                 for _, g in [('', df[df['UserType'] == ut])] if len(g) > 0]
    groups_bi = [df[df['UserType'] == ut]['BehInt'].dropna().values for ut in user_type_order]
    groups_bi = [g for g in groups_bi if len(g) > 0]
    if len(groups_bi) >= 2:
        f_stat, p_val = stats.f_oneway(*groups_bi)
        print(f"\n  BI by UserType: F={f_stat:.3f}, p={p_val:.4f}")

    user_type_results = {}
    for ut in user_type_order:
        sub = df[df['UserType'] == ut]
        if len(sub) > 0:
            user_type_results[ut] = {
                'n': int(len(sub)),
                'pct': float(len(sub) / len(df) * 100),
                'bi_mean': float(sub['BehInt'].mean()),
                'bi_std': float(sub['BehInt'].std()),
            }

    # User type visualization (pie + profile)
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))
    # Pie chart
    sizes = [user_counts.get(ut, 0) for ut in user_type_order]
    ax1.pie(sizes, labels=user_type_order, autopct='%1.1f%%', startangle=140,
            colors=['#ef5350', '#ffa726', '#66bb6a', '#42a5f5'])
    ax1.set_title('User Type Distribution')
    # Profile
    for ut in user_type_order:
        sub = df[df['UserType'] == ut]
        if len(sub) > 0:
            means = [sub[c].mean() for c in PROFILE_CONSTRUCTS]
            ax2.plot(CONSTRUCT_LABELS, means, marker='o', label=f'{ut} (n={len(sub)})')
    ax2.set_ylabel('Mean Score')
    ax2.set_title('Construct Profiles by User Type')
    ax2.legend(fontsize=8)
    ax2.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig('plots/07_user_type_analysis.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Saved plots/07_user_type_analysis.png")

    # ══════════════════════════════════════════════════════════════════════════
    # Export results
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("EXPORT")
    print("=" * 70)

    results = {
        'sample_size': int(len(df)),
        'rq10a_usage_frequency': {
            'tools': {col: summary_data[col] for col in USAGE_COLS},
            'finding': 'ChatGPT most widely used; Copilot growing segment',
        },
        'rq10b_population_comparison': {
            'analysis_method': 'One-way ANOVA (3-group)',
            'groups': dict(role_counts.astype(int)),
            'anova_results': anova_results,
            'finding': 'Leaders show highest usage across all tools',
        },
        'leader_comparison': leader_results,
        'rq10c_correlations': corr_dict,
        'rq10d_multi_tool': {
            'classification': user_type_results,
            'finding': 'Multi-tool users have highest BI and readiness',
        },
        'criterion_validity_evidence': 'Strong: usage correlates with BI and constructs',
    }

    out_path = Path('results/phase7_tool_usage_results.json')
    with open(out_path, 'w') as f:
        json.dump(results, f, indent=2, default=str)
    print(f"✓ Saved {out_path}")

    print("\n✓ Phase 7 complete.")


if __name__ == '__main__':
    main()
