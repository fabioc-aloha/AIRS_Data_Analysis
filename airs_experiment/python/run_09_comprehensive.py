#!/usr/bin/env python3
"""
Phase 9: Comprehensive Review — Gap Analysis
Standalone script refactored from 09_Comprehensive_Review.ipynb

Analyzes 6 research gaps:
  Gap 1 — Education level (ANOVA)
  Gap 2 — Industry sector (ANOVA)
  Gap 3 — Professional experience (Spearman)
  Gap 4 — Disability accommodations (t-tests)
  Gap 5 — Tool preferences (ChatGPT vs Copilot)
  Gap 6 — User typology (K-means k=4)
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
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
import seaborn as sns

warnings.filterwarnings('ignore')

# ── Configuration ──────────────────────────────────────────────────────────────

USAGE_COLS = ['Usage_MSCopilot', 'Usage_ChatGPT', 'Usage_Gemini', 'Usage_Other']

# All 13 original constructs (including those later dropped)
CONSTRUCT_DEFS = {
    'PE': ['PE1', 'PE2'], 'EE': ['EE1', 'EE2'], 'SI': ['SI1', 'SI2'],
    'FC': ['FC1', 'FC2'], 'HM': ['HM1', 'HM2'], 'PV': ['PV1', 'PV2'],
    'HB': ['HB1', 'HB2'], 'VO': ['VO1', 'VO2'], 'TR': ['TR1', 'TR2'],
    'EX': ['EX1', 'EX2'], 'ER': ['ER1', 'ER2'], 'AX': ['AX1', 'AX2'],
}
BI_ITEMS = ['BI1', 'BI2', 'BI3', 'BI4']


# ── Main ───────────────────────────────────────────────────────────────────────

def main():
    Path('results').mkdir(exist_ok=True)
    Path('plots').mkdir(exist_ok=True)

    # ── Load data (full clean sample, NOT combined EFA+CFA) ────────────────
    df = pd.read_csv('data/AIRS_clean.csv')
    print(f"Loaded AIRS_clean.csv: N={len(df)}")

    # Compute construct scores
    for name, items in CONSTRUCT_DEFS.items():
        cols = [c for c in items if c in df.columns]
        if cols:
            df[name] = df[cols].mean(axis=1)
    df['BI'] = df[[c for c in BI_ITEMS if c in df.columns]].mean(axis=1)
    df['Total_Usage'] = df[[c for c in USAGE_COLS if c in df.columns]].mean(axis=1)
    print("Computed 13 construct scores + BI + Total_Usage")

    gap_results = {}

    # ══════════════════════════════════════════════════════════════════════════
    # Gap 1 — Education Level
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("GAP 1: EDUCATION LEVEL")
    print("=" * 70)

    edu_col = 'Education'
    if edu_col in df.columns:
        edu_order_map = {}
        for val in df[edu_col].dropna().unique():
            v = str(val).lower()
            if 'high' in v or 'hs' in v:
                edu_order_map[val] = 1
            elif 'some college' in v or 'associate' in v:
                edu_order_map[val] = 2
            elif 'bachelor' in v:
                edu_order_map[val] = 3
            elif 'master' in v:
                edu_order_map[val] = 4
            elif 'doctor' in v or 'phd' in v:
                edu_order_map[val] = 5
            else:
                edu_order_map[val] = 2  # default

        groups = {k: g for k, g in df.groupby(edu_col) if len(g) >= 5}
        if len(groups) >= 2:
            group_vals = [g['BI'].dropna().values for g in groups.values()]
            f_stat, p_val = stats.f_oneway(*group_vals)
            grand_mean = df['BI'].mean()
            ss_between = sum(len(g) * (g['BI'].mean() - grand_mean) ** 2 for g in groups.values())
            ss_total = ((df['BI'] - grand_mean) ** 2).sum()
            eta_sq = ss_between / ss_total if ss_total > 0 else 0

            gap_results['gap1_education'] = {
                'title': 'Education Level × BI',
                'method': 'One-way ANOVA',
                'F': float(f_stat), 'p': float(p_val), 'eta_sq': float(eta_sq),
                'n_groups': len(groups),
                'group_ns': {str(k): len(g) for k, g in groups.items()},
                'finding': f'F={f_stat:.3f}, p={p_val:.4f}, η²={eta_sq:.4f}',
            }
            print(f"  F={f_stat:.3f}, p={p_val:.4f}, η²={eta_sq:.4f}")
            for k, g in groups.items():
                print(f"    {k}: n={len(g)}, M={g['BI'].mean():.3f}")

        # Education plot
        fig, ax = plt.subplots(figsize=(10, 6))
        edu_means = df.groupby(edu_col)['BI'].agg(['mean', 'std', 'count'])
        edu_means = edu_means[edu_means['count'] >= 5].sort_index()
        ax.bar(range(len(edu_means)), edu_means['mean'], yerr=edu_means['std'],
               capsize=5, color='steelblue')
        ax.set_xticks(range(len(edu_means)))
        ax.set_xticklabels(edu_means.index, rotation=30, ha='right', fontsize=8)
        ax.set_ylabel('Mean BI')
        ax.set_title('Behavioral Intention by Education Level')
        plt.tight_layout()
        plt.savefig('plots/09_education_comparison.png', dpi=300, bbox_inches='tight')
        plt.close()
        print("  ✓ Saved plots/09_education_comparison.png")

    # ══════════════════════════════════════════════════════════════════════════
    # Gap 2 — Industry Sector
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("GAP 2: INDUSTRY SECTOR")
    print("=" * 70)

    industry_col = 'Industry'
    if industry_col in df.columns:
        groups = {k: g for k, g in df.groupby(industry_col) if len(g) >= 5}
        if len(groups) >= 2:
            group_vals = [g['BI'].dropna().values for g in groups.values()]
            f_stat, p_val = stats.f_oneway(*group_vals)
            grand_mean = df['BI'].mean()
            ss_between = sum(len(g) * (g['BI'].mean() - grand_mean) ** 2 for g in groups.values())
            ss_total = ((df['BI'] - grand_mean) ** 2).sum()
            eta_sq = ss_between / ss_total if ss_total > 0 else 0

            # top / lowest
            ind_means = {k: g['BI'].mean() for k, g in groups.items()}
            sorted_ind = sorted(ind_means.items(), key=lambda x: x[1], reverse=True)
            top_industry = sorted_ind[0][0]
            low_industry = sorted_ind[-1][0]

            gap_results['gap2_industry'] = {
                'title': 'Industry Sector × BI',
                'method': 'One-way ANOVA',
                'F': float(f_stat), 'p': float(p_val), 'eta_sq': float(eta_sq),
                'n_groups': len(groups),
                'top_industry': str(top_industry),
                'lowest_industry': str(low_industry),
                'finding': f'F={f_stat:.3f}, p={p_val:.4f}, η²={eta_sq:.4f}',
            }
            print(f"  F={f_stat:.3f}, p={p_val:.4f}, η²={eta_sq:.4f}")
            print(f"  Top: {top_industry}, Lowest: {low_industry}")

        # Industry plot
        fig, ax = plt.subplots(figsize=(12, 6))
        ind_means_df = df.groupby(industry_col)['BI'].agg(['mean', 'std', 'count'])
        ind_means_df = ind_means_df[ind_means_df['count'] >= 5].sort_values('mean', ascending=True)
        ax.barh(range(len(ind_means_df)), ind_means_df['mean'], xerr=ind_means_df['std'],
                capsize=3, color='steelblue')
        ax.set_yticks(range(len(ind_means_df)))
        ax.set_yticklabels(ind_means_df.index, fontsize=8)
        ax.set_xlabel('Mean BI')
        ax.set_title('Behavioral Intention by Industry Sector')
        plt.tight_layout()
        plt.savefig('plots/09_industry_comparison.png', dpi=300, bbox_inches='tight')
        plt.close()
        print("  ✓ Saved plots/09_industry_comparison.png")

    # ══════════════════════════════════════════════════════════════════════════
    # Gap 3 — Professional Experience
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("GAP 3: PROFESSIONAL EXPERIENCE")
    print("=" * 70)

    exp_col = 'Experience'
    if exp_col in df.columns:
        exp_order = ['Less than 1 year', '1 to 3 years', '4 to 6 years', '7 to 10 years', '11 or more years']
        exp_numeric = {v: i + 1 for i, v in enumerate(exp_order)}
        df['Experience_Numeric'] = df[exp_col].map(exp_numeric)

        valid = df[['Experience_Numeric', 'BI']].dropna()
        if len(valid) > 10:
            rho, p_val = stats.spearmanr(valid['Experience_Numeric'], valid['BI'])
            # Peak experience
            exp_means = df.groupby(exp_col)['BI'].mean()
            peak = exp_means.idxmax() if len(exp_means) > 0 else 'N/A'

            gap_results['gap3_experience'] = {
                'title': 'Professional Experience × BI',
                'method': 'Spearman correlation',
                'rho': float(rho), 'p': float(p_val),
                'peak_experience': str(peak),
                'finding': f'ρ={rho:.3f}, p={p_val:.4f}',
            }
            print(f"  Spearman ρ={rho:.3f}, p={p_val:.4f}")
            print(f"  Peak experience: {peak}")

        # Experience plot
        fig, ax = plt.subplots(figsize=(10, 6))
        present = [e for e in exp_order if e in df[exp_col].values]
        means = [df[df[exp_col] == e]['BI'].mean() for e in present]
        ax.plot(range(len(present)), means, 'o-', color='steelblue', markersize=8)
        ax.set_xticks(range(len(present)))
        ax.set_xticklabels(present, rotation=30, ha='right', fontsize=8)
        ax.set_ylabel('Mean BI')
        ax.set_title('Behavioral Intention by Professional Experience')
        ax.grid(True, alpha=0.3)
        plt.tight_layout()
        plt.savefig('plots/09_experience_effect.png', dpi=300, bbox_inches='tight')
        plt.close()
        print("  ✓ Saved plots/09_experience_effect.png")

    # ══════════════════════════════════════════════════════════════════════════
    # Gap 4 — Disability Accommodations
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("GAP 4: DISABILITY ACCOMMODATIONS")
    print("=" * 70)

    dis_col = 'Disability'
    if dis_col in df.columns:
        df_yes = df[df[dis_col] == 'Yes']
        df_no = df[df[dis_col] == 'No']
        print(f"  Yes: n={len(df_yes)}, No: n={len(df_no)}")

        test_constructs = ['BI', 'Total_Usage', 'PE', 'EE', 'AX', 'TR', 'EX']
        disability_results = {}
        for c in test_constructs:
            if c in df.columns:
                y = df_yes[c].dropna()
                n = df_no[c].dropna()
                if len(y) > 1 and len(n) > 1:
                    t_stat, p_val = stats.ttest_ind(y, n)
                    d = (y.mean() - n.mean()) / n.std() if n.std() > 0 else 0
                    disability_results[c] = {
                        't': float(t_stat), 'p': float(p_val), 'd': float(d),
                        'yes_mean': float(y.mean()), 'no_mean': float(n.mean()),
                    }
                    sig = '*' if p_val < 0.05 else ''
                    print(f"  {c}: t={t_stat:.3f}, p={p_val:.4f}, d={d:.3f} {sig}")

        gap_results['gap4_disability'] = {
            'title': 'Disability × Constructs',
            'method': 'Independent-samples t-test',
            'yes_n': int(len(df_yes)), 'no_n': int(len(df_no)),
            'results': disability_results,
            'finding': 'AX higher in disability group' if 'AX' in disability_results and disability_results['AX']['p'] < 0.05 else 'No significant differences',
        }

        # Disability plot
        fig, ax = plt.subplots(figsize=(10, 6))
        plot_constructs = [c for c in test_constructs if c in disability_results]
        x = np.arange(len(plot_constructs))
        y_means = [disability_results[c]['yes_mean'] for c in plot_constructs]
        n_means = [disability_results[c]['no_mean'] for c in plot_constructs]
        ax.bar(x - 0.15, y_means, 0.3, label='Disability: Yes')
        ax.bar(x + 0.15, n_means, 0.3, label='Disability: No')
        ax.set_xticks(x)
        ax.set_xticklabels(plot_constructs)
        ax.set_ylabel('Mean Score')
        ax.set_title('Construct Means by Disability Status')
        ax.legend()
        plt.tight_layout()
        plt.savefig('plots/09_disability_comparison.png', dpi=300, bbox_inches='tight')
        plt.close()
        print("  ✓ Saved plots/09_disability_comparison.png")

    # ══════════════════════════════════════════════════════════════════════════
    # Gap 5 — Tool Preferences
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("GAP 5: TOOL PREFERENCES")
    print("=" * 70)

    usage_present = [c for c in USAGE_COLS if c in df.columns]
    if usage_present:
        df['Primary_Tool'] = df[usage_present].idxmax(axis=1)
        tool_counts = df['Primary_Tool'].value_counts()
        print("Primary tool distribution:")
        for tool, n in tool_counts.items():
            print(f"  {tool}: n={n} ({n/len(df)*100:.1f}%)")

        # ChatGPT vs Copilot comparison
        chatgpt_users = df[df['Primary_Tool'] == 'Usage_ChatGPT']
        copilot_users = df[df['Primary_Tool'] == 'Usage_MSCopilot']
        compare_constructs = ['PE', 'EE', 'SI', 'FC', 'HM', 'PV', 'HB', 'TR', 'BI', 'Total_Usage']
        tool_comparison = {}
        print(f"\n  ChatGPT n={len(chatgpt_users)} vs Copilot n={len(copilot_users)}")
        for c in compare_constructs:
            if c in df.columns:
                cg = chatgpt_users[c].dropna()
                cp = copilot_users[c].dropna()
                if len(cg) > 1 and len(cp) > 1:
                    t_stat, p_val = stats.ttest_ind(cg, cp)
                    tool_comparison[c] = {
                        't': float(t_stat), 'p': float(p_val),
                        'chatgpt_mean': float(cg.mean()),
                        'copilot_mean': float(cp.mean()),
                    }
                    sig = '*' if p_val < 0.05 else ''
                    print(f"    {c}: t={t_stat:.3f}, p={p_val:.4f} {sig}")

        gap_results['gap5_tool_preferences'] = {
            'title': 'Primary Tool × Constructs',
            'method': 'Independent-samples t-test (ChatGPT vs Copilot)',
            'distribution': {str(k): int(v) for k, v in tool_counts.items()},
            'comparison': tool_comparison,
        }

        # Tool profile plot
        fig, ax = plt.subplots(figsize=(10, 6))
        plot_c = [c for c in compare_constructs if c in tool_comparison]
        cg_vals = [tool_comparison[c]['chatgpt_mean'] for c in plot_c]
        cp_vals = [tool_comparison[c]['copilot_mean'] for c in plot_c]
        x = np.arange(len(plot_c))
        ax.plot(x, cg_vals, 'o-', label=f'ChatGPT (n={len(chatgpt_users)})')
        ax.plot(x, cp_vals, 's-', label=f'Copilot (n={len(copilot_users)})')
        ax.set_xticks(x)
        ax.set_xticklabels(plot_c)
        ax.set_ylabel('Mean Score')
        ax.set_title('Construct Profiles: ChatGPT vs Copilot Primary Users')
        ax.legend()
        ax.grid(True, alpha=0.3)
        plt.tight_layout()
        plt.savefig('plots/09_tool_profiles.png', dpi=300, bbox_inches='tight')
        plt.close()
        print("  ✓ Saved plots/09_tool_profiles.png")

    # ══════════════════════════════════════════════════════════════════════════
    # Gap 6 — User Typology (K-means k=4)
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("GAP 6: USER TYPOLOGY (K-MEANS k=4)")
    print("=" * 70)

    cluster_vars = ['PE', 'EE', 'TR', 'HB', 'AX', 'BI']
    available_cv = [c for c in cluster_vars if c in df.columns]
    X = df[available_cv].dropna()
    print(f"  Clustering on {available_cv}, n={len(X)}")

    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)
    kmeans = KMeans(n_clusters=4, random_state=67, n_init=10)
    labels = kmeans.fit_predict(X_scaled)
    df.loc[X.index, 'Cluster'] = labels

    # Name clusters dynamically
    cluster_profiles = df.loc[X.index].groupby('Cluster')[available_cv].mean()
    cluster_names = {}
    for c in range(4):
        bi_val = cluster_profiles.loc[c, 'BI'] if 'BI' in cluster_profiles.columns else 3
        ax_val = cluster_profiles.loc[c, 'AX'] if 'AX' in cluster_profiles.columns else 3
        if bi_val > 3.5 and ax_val < 3.5:
            cluster_names[c] = 'Confident Adopters'
        elif bi_val > 3.5 and ax_val >= 3.5:
            cluster_names[c] = 'Anxious Enthusiasts'
        elif bi_val <= 3.5 and ax_val < 3.5:
            cluster_names[c] = 'Indifferent Users'
        else:
            cluster_names[c] = 'Anxious Avoiders'

    df['ClusterName'] = df['Cluster'].map(cluster_names)
    print("\n  Cluster profiles:")
    for c in range(4):
        n = (df['Cluster'] == c).sum()
        name = cluster_names[c]
        profile = cluster_profiles.loc[c]
        print(f"    {name} (n={n}):")
        for v in available_cv:
            print(f"      {v}: {profile[v]:.3f}")

    gap_results['gap6_user_typology'] = {
        'title': 'K-means User Typology (k=4)',
        'method': 'K-means clustering',
        'n_clusters': 4,
        'cluster_vars': available_cv,
        'clusters': {cluster_names[c]: {
            'n': int((df['Cluster'] == c).sum()),
            'profile': {v: float(cluster_profiles.loc[c, v]) for v in available_cv},
        } for c in range(4)},
    }

    # Typology plot
    fig, ax = plt.subplots(figsize=(10, 6))
    for c in range(4):
        name = cluster_names[c]
        n = (df['Cluster'] == c).sum()
        means = [cluster_profiles.loc[c, v] for v in available_cv]
        ax.plot(available_cv, means, 'o-', label=f'{name} (n={n})')
    ax.set_ylabel('Mean Score')
    ax.set_title('User Typology Profiles (K-means k=4)')
    ax.legend(fontsize=8)
    ax.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig('plots/09_user_typology.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("  ✓ Saved plots/09_user_typology.png")

    # ══════════════════════════════════════════════════════════════════════════
    # Export
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("EXPORT")
    print("=" * 70)

    output = {
        'metadata': {
            'n': int(len(df)),
            'source': 'AIRS_clean.csv',
            'constructs': list(CONSTRUCT_DEFS.keys()) + ['BI', 'Total_Usage'],
        },
        **gap_results,
        'files_generated': [
            'plots/09_education_comparison.png',
            'plots/09_industry_comparison.png',
            'plots/09_experience_effect.png',
            'plots/09_disability_comparison.png',
            'plots/09_tool_profiles.png',
            'plots/09_user_typology.png',
        ],
    }

    out_path = Path('results/phase9_comprehensive_review_results.json')
    with open(out_path, 'w') as f:
        json.dump(output, f, indent=2, default=str)
    print(f"✓ Saved {out_path}")

    print("\n✓ Phase 9 complete.")


if __name__ == '__main__':
    main()
