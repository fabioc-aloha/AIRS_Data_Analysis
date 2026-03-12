#!/usr/bin/env python3
"""
Phase 10: Final Synthesis
Standalone script refactored from 10_Final_Synthesis.ipynb

Loads ALL upstream JSON results and produces:
  - Hypothesis support summary
  - Model fit summary table
  - Construct reliability table
  - Novel findings summary
  - Cross-tabulation: User Typology × Qualitative Themes
  - Hypothesis summary visualization
  - Structural path coefficients visualization
  - Final synthesis JSON export
"""

import json
import warnings
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from matplotlib.patches import Patch
from scipy.stats import chi2_contingency
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
import seaborn as sns

warnings.filterwarnings('ignore')


# ── Helpers ────────────────────────────────────────────────────────────────────

def safe_fmt(val, fmt='.3f'):
    """Safely format a numeric value."""
    try:
        return f'{float(val):{fmt}}'
    except (TypeError, ValueError):
        return str(val) if val is not None else 'N/A'


def load_json(path):
    """Load JSON or return empty dict."""
    p = Path(path)
    if p.exists():
        with open(p) as f:
            return json.load(f)
    return {}


# ── Main ───────────────────────────────────────────────────────────────────────

def main():
    Path('results').mkdir(exist_ok=True)
    Path('plots').mkdir(exist_ok=True)
    Path('tables').mkdir(exist_ok=True)
    Path('data').mkdir(exist_ok=True)

    # ══════════════════════════════════════════════════════════════════════════
    # Load all upstream results
    # ══════════════════════════════════════════════════════════════════════════
    print("=" * 80)
    print("LOADING UPSTREAM RESULTS")
    print("=" * 80)

    results = {}
    load_map = {
        'sample': 'data/sample_characteristics.json',
        'efa': 'tables/efa_summary.json',
        'cfa': 'tables/cfa_summary.json',
        'invariance': 'data/invariance_results.json',
        'structural': 'data/structural_model_results.json',
        'mediation': 'data/phase5_alternative_analyses.json',
        'tool_usage': 'results/phase7_tool_usage_results.json',
        'qualitative': 'results/phase8_qualitative_results.json',
        'comprehensive': 'results/phase9_comprehensive_review_results.json',
    }
    # Moderation: try updated first, then original
    mod_path = Path('data/moderation_results_updated.json')
    if not mod_path.exists():
        mod_path = Path('data/moderation_analysis_results.json')
    load_map['moderation'] = str(mod_path)

    for key, path in load_map.items():
        data = load_json(path)
        results[key] = data
        status = '✓' if data else '✗'
        print(f"  {status} {key}: {path}")

    # ══════════════════════════════════════════════════════════════════════════
    # Section 1: Sample Description
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 80)
    print("SAMPLE DESCRIPTION")
    print("=" * 80)

    samp = results.get('sample', {})
    print(f"  Total N: {samp.get('total_n', 'N/A')}")
    print(f"  EFA N: {samp.get('efa_n', 'N/A')}")
    print(f"  CFA N: {samp.get('cfa_n', 'N/A')}")

    # ══════════════════════════════════════════════════════════════════════════
    # Section 2: Hypothesis Testing Summary
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 80)
    print("HYPOTHESIS TESTING SUMMARY")
    print("=" * 80)

    struct = results.get('structural', {})
    path_coefficients = struct.get('path_coefficients', [])
    hr = struct.get('hypothesis_results', {})

    h1_mapping = {
        'PerfExp': 'H1a', 'EffortExp': 'H1b', 'SocialInf': 'H1c', 'FacilCond': 'H1d',
        'HedonicMot': 'H1e', 'PriceValue': 'H1f', 'Habit': 'H1g',
    }
    hypothesis_map = {
        'PerfExp': 'Performance Expectancy',
        'EffortExp': 'Effort Expectancy',
        'SocialInf': 'Social Influence',
        'FacilCond': 'Facilitating Conditions',
        'HedonicMot': 'Hedonic Motivation',
        'PriceValue': 'Price Value',
        'Habit': 'Habit',
        'AITrust': 'AI Trust',
    }

    # H1 paths
    h1_supported = 0
    h1_total = 0
    print("\nH1: UTAUT2 predictors → BI")
    for p in path_coefficients:
        pred = p.get('predictor', '')
        if pred in h1_mapping:
            h1_total += 1
            beta = p.get('beta_std', 0)
            pval = p.get('p', 1)
            supported = pval < 0.05 and beta > 0
            if supported:
                h1_supported += 1
            status = 'SUPPORTED' if supported else 'Not supported'
            print(f"  {h1_mapping[pred]} ({pred}): β={beta:.3f}, p={pval:.4f} → {status}")

    # H2: AI Trust
    h2_beta = hr.get('H2_trust_beta', None)
    h2_p = hr.get('H2_trust_p', None)
    if h2_beta is None:
        for p in path_coefficients:
            if p.get('predictor') == 'AITrust':
                h2_beta = p.get('beta_std', 0)
                h2_p = p.get('p', 1)
    h2_marginal = h2_p < 0.10 if h2_p is not None else False
    print(f"\nH2: AI Trust → BI: β={safe_fmt(h2_beta)}, p={safe_fmt(h2_p)} → "
          f"{'MARGINAL' if h2_marginal else 'Not supported'}")

    # H3: Incremental validity
    h3 = hr.get('H3_incremental_validity', False)
    print(f"\nH3: Incremental validity: {'SUPPORTED' if h3 else 'Not supported'}")

    # H4: Moderation
    mod = results.get('moderation', {})
    print("\nH4: Moderation effects")
    h4_effects = 0
    if 'experience_moderation' in mod:
        for item in mod['experience_moderation']:
            sig = str(item.get('Significant', 'False')).lower() == 'true'
            if sig:
                h4_effects += 1
            pred = item.get('Predictor', '')
            p_val = item.get('p_value', 1)
            print(f"  Experience × {pred}: p={p_val:.4f} → {'SIGNIFICANT' if sig else 'NS'}")

    # H5: Dropped constructs
    print("\nH5: Dropped constructs (VO, EX, ER → not testable)")

    # ══════════════════════════════════════════════════════════════════════════
    # Section 3: Model Fit Summary
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 80)
    print("MODEL FIT SUMMARY")
    print("=" * 80)

    cfa = results.get('cfa', {})
    fit = cfa.get('fit_indices', {})
    print(f"  CFA: CFI={safe_fmt(fit.get('cfi'))}, TLI={safe_fmt(fit.get('tli'))}, "
          f"RMSEA={safe_fmt(fit.get('rmsea'))}, SRMR={safe_fmt(fit.get('srmr'))}")

    inv = results.get('invariance', {})
    if inv:
        inv_fit = inv.get('fit_indices', inv.get('full_sample_fit', {}))
        print(f"  Invariance: CFI={safe_fmt(inv_fit.get('cfi'))}, "
              f"RMSEA={safe_fmt(inv_fit.get('rmsea'))}")

    struct_fit = struct.get('full_sample_fit', {})
    print(f"  Structural: CFI={safe_fmt(struct_fit.get('cfi'))}, "
          f"RMSEA={safe_fmt(struct_fit.get('rmsea'))}, R²={safe_fmt(struct.get('r_squared'))}")

    # ══════════════════════════════════════════════════════════════════════════
    # Section 4: Reliability Summary
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 80)
    print("CONSTRUCT RELIABILITY")
    print("=" * 80)

    factor_name_map = {
        'PerfExp': 'PE', 'EffortExp': 'EE', 'SocialInf': 'SI', 'FacilCond': 'FC',
        'HedonicMot': 'HM', 'PriceValue': 'PV', 'Habit': 'HB', 'AITrust': 'TR',
        'FacCond': 'FC', 'HedMot': 'HM', 'PriceVal': 'PV', 'Trust': 'TR',
    }

    # CFA reliability
    cfa_rel = cfa.get('reliability', {})
    if isinstance(cfa_rel, list):
        cfa_rel = {factor_name_map.get(r.get('factor', ''), r.get('factor', '')): r
                   for r in cfa_rel}
    elif isinstance(cfa_rel, dict):
        cfa_rel = {factor_name_map.get(k, k): v for k, v in cfa_rel.items()}

    # EFA reliability
    efa = results.get('efa', {})
    efa_rel = efa.get('reliability_coefficients', {})

    for factor in ['PE', 'EE', 'SI', 'FC', 'HM', 'PV', 'HB', 'TR']:
        cfa_entry = cfa_rel.get(factor, {})
        if isinstance(cfa_entry, dict):
            cr = cfa_entry.get('composite_reliability', cfa_entry.get('alpha', 'N/A'))
            ave = cfa_entry.get('ave', 'N/A')
        else:
            cr, ave = 'N/A', 'N/A'
        efa_alpha = efa_rel.get(factor, 'N/A')
        print(f"  {factor}: CR={safe_fmt(cr)}, AVE={safe_fmt(ave)}, EFA α={safe_fmt(efa_alpha)}")

    # Dropped constructs
    print("\n  Dropped constructs:")
    for dropped in ['VO', 'EX', 'ER', 'AX']:
        alpha = efa_rel.get(dropped, 'N/A')
        print(f"    {dropped}: α={safe_fmt(alpha)} (below .60 threshold)")

    # ══════════════════════════════════════════════════════════════════════════
    # Section 5: Novel Findings
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 80)
    print("NOVEL FINDINGS")
    print("=" * 80)

    # Price Value as strongest predictor
    strongest_beta = 0
    strongest_name = ''
    for p in path_coefficients:
        if p.get('p', 1) < 0.05 and p.get('beta_std', 0) > strongest_beta:
            strongest_beta = p['beta_std']
            strongest_name = hypothesis_map.get(p['predictor'], p['predictor'])
    if strongest_name:
        print(f"  1. {strongest_name} as strongest predictor (β={strongest_beta:.3f})")

    # Experience moderation
    if 'experience_moderation' in mod:
        sig_exp = [item for item in mod['experience_moderation']
                   if str(item.get('Significant', 'False')).lower() == 'true']
        if sig_exp:
            print(f"  2. Experience moderates {len(sig_exp)} path(s)")

    # Disability finding
    comp = results.get('comprehensive', {})
    if 'gap4_disability' in comp:
        print(f"  3. Disability gap: {comp['gap4_disability'].get('finding', 'See NB09')}")

    # ══════════════════════════════════════════════════════════════════════════
    # Section 6: Exploratory Findings (Phase 7-9)
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 80)
    print("EXPLORATORY FINDINGS (Phases 7-9)")
    print("=" * 80)

    tu = results.get('tool_usage', {})
    if tu:
        print(f"\n  Tool Usage (N={tu.get('sample_size', 'N/A')})")
        if 'leader_comparison' in tu:
            lc = tu['leader_comparison']
            print(f"    Leaders: n={lc.get('leader_n', 'N/A')}")

    qual = results.get('qualitative', {})
    if qual and 'sample' in qual:
        s = qual['sample']
        print(f"\n  Qualitative: {s.get('substantive_responses', 'N/A')} substantive responses")

    if comp:
        gaps = [k for k in comp if k.startswith('gap')]
        print(f"\n  Comprehensive Review: {len(gaps)} gaps analyzed")

    # ══════════════════════════════════════════════════════════════════════════
    # Section 7: Export Final Synthesis JSON
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 80)
    print("EXPORTING FINAL SYNTHESIS")
    print("=" * 80)

    synthesis = {
        'study_overview': {
            'purpose': 'Develop and validate AIRS instrument',
            'theoretical_base': 'UTAUT2 + AI Trust extension',
            'sample_size': cfa.get('n_observations', 523),
            'validated_model': f"Model D: {cfa.get('n_factors', 8)} factors, {cfa.get('n_items', 16)} items",
        },
        'hypothesis_summary': {
            'H1_supported': h1_supported,
            'H1_total': h1_total,
            'H2_trust_beta': float(h2_beta) if h2_beta is not None else None,
            'H2_trust_p': float(h2_p) if h2_p is not None else None,
            'H2_marginal': h2_marginal,
            'H3_incremental_validity': h3,
            'H4_moderation_effects': h4_effects,
        },
        'phase_results': {},
    }

    if cfa:
        synthesis['phase_results']['cfa'] = {
            'fit_indices': fit, 'n_observations': cfa.get('n_observations'),
            'reliability': cfa.get('reliability', {}),
        }
    if struct:
        synthesis['phase_results']['structural'] = {
            'full_sample_n': struct.get('full_sample_n'),
            'full_sample_fit': struct_fit,
            'hypothesis_results': hr,
        }
    if inv:
        synthesis['phase_results']['invariance'] = inv
    if mod:
        synthesis['phase_results']['moderation'] = {
            'demographic_moderation_summary': mod.get('demographic_moderation_summary', {}),
            'experience_moderation': mod.get('experience_moderation', []),
        }
    if tu:
        synthesis['phase_results']['tool_usage'] = {
            'sample_size': tu.get('sample_size'),
            'leader_comparison': tu.get('leader_comparison', {}),
            'criterion_validity': tu.get('criterion_validity_evidence', ''),
        }
    if qual:
        synthesis['phase_results']['qualitative'] = {
            'sample': qual.get('sample', {}),
            'key_findings': qual.get('key_findings', {}),
            'rq11_themes': qual.get('rq11_themes', {}),
        }
    if comp:
        synthesis['phase_results']['comprehensive'] = comp

    with open('data/final_synthesis.json', 'w') as f:
        json.dump(synthesis, f, indent=2, default=str)
    print("✓ Saved data/final_synthesis.json")

    # ══════════════════════════════════════════════════════════════════════════
    # Section 8: Hypothesis Summary Visualization
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 80)
    print("VISUALIZATIONS")
    print("=" * 80)

    hs = synthesis['hypothesis_summary']
    h1_sup = hs['H1_supported']
    h1_not = hs['H1_total'] - h1_sup
    h2_marg = 1 if hs['H2_marginal'] else 0
    h2_not = 0 if h2_marg else 1
    h3_not = 1
    h4_sig = hs['H4_moderation_effects']
    h4_not = 5 - h4_sig
    h5_not_testable = 3

    categories = ['H1\n(UTAUT2)', 'H2\n(AI Trust)', 'H3\n(Differences)',
                  'H4\n(Moderation)', 'H5\n(Mediation)']
    supported = [h1_sup, 0, 0, h4_sig, 0]
    marginal = [0, h2_marg, 0, 0, 0]
    not_supported = [h1_not, h2_not, h3_not, h4_not, 0]
    not_testable = [0, 0, 0, 0, h5_not_testable]

    fig, ax = plt.subplots(figsize=(12, 6))
    x = np.arange(len(categories))
    width = 0.2
    ax.bar(x - 1.5 * width, supported, width, label='Supported', color='#2e7d32')
    ax.bar(x - 0.5 * width, marginal, width, label='Marginal', color='#f57c00')
    ax.bar(x + 0.5 * width, not_supported, width, label='Not Supported', color='#c62828')
    ax.bar(x + 1.5 * width, not_testable, width, label='Not Testable', color='#757575')
    ax.set_ylabel('Number of Hypotheses')
    ax.set_title('Hypothesis Testing Summary by Category')
    ax.set_xticks(x)
    ax.set_xticklabels(categories)
    ax.legend(loc='upper right')
    ax.set_ylim(0, 8)
    for bars in ax.containers:
        for bar in bars:
            h = bar.get_height()
            if h > 0:
                ax.annotate(f'{int(h)}', xy=(bar.get_x() + bar.get_width() / 2, h),
                            xytext=(0, 3), textcoords='offset points',
                            ha='center', va='bottom', fontsize=9, fontweight='bold')
    plt.tight_layout()
    plt.savefig('plots/hypothesis_summary.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Saved plots/hypothesis_summary.png")

    # Structural path coefficients
    predictor_labels = {
        'PerfExp': 'Perf. Expect.', 'EffortExp': 'Effort Exp.', 'SocialInf': 'Social Inf.',
        'FacilCond': 'Fac. Cond.', 'HedonicMot': 'Hedonic Mot.', 'PriceValue': 'Price Value',
        'Habit': 'Habit', 'AITrust': 'AI Trust',
    }
    hyp_map = {**h1_mapping, 'AITrust': 'H2'}

    path_data = []
    for p in path_coefficients:
        pred = p.get('predictor', '')
        beta = p.get('beta_std', 0)
        pval = p.get('p', 1)
        path_data.append((predictor_labels.get(pred, pred), beta, pval, hyp_map.get(pred, '')))
    path_data.sort(key=lambda x: x[1], reverse=True)

    if path_data:
        fig, ax = plt.subplots(figsize=(10, 7))
        labels_list = [d[0] for d in path_data]
        betas = [d[1] for d in path_data]
        pvals_list = [d[2] for d in path_data]
        hyps = [d[3] for d in path_data]
        colors = ['#2e7d32' if p < 0.05 else '#f57c00' if p < 0.10 else '#c62828' for p in pvals_list]

        y_pos = np.arange(len(labels_list))
        ax.barh(y_pos, betas, color=colors, height=0.7)
        ax.set_yticks(y_pos)
        ax.set_yticklabels([f'{h}: {l}' for h, l in zip(hyps, labels_list)])
        ax.set_xlabel('Standardized β')
        ax.set_title('Structural Path Coefficients → Behavioral Intention')
        ax.axvline(x=0, color='black', linewidth=0.8)
        for i, (b, p) in enumerate(zip(betas, pvals_list)):
            sig = '***' if p < 0.001 else '**' if p < 0.01 else '*' if p < 0.05 else '†' if p < 0.10 else ''
            offset = 0.02 if b >= 0 else -0.02
            ha = 'left' if b >= 0 else 'right'
            ax.annotate(f'β={b:.3f}{sig}', xy=(b + offset, i), ha=ha, va='center', fontsize=9)
        legend_elements = [
            Patch(facecolor='#2e7d32', label='Significant (p<.05)'),
            Patch(facecolor='#f57c00', label='Marginal (p<.10)'),
            Patch(facecolor='#c62828', label='Non-significant'),
        ]
        ax.legend(handles=legend_elements, loc='lower right', fontsize=9)
        plt.tight_layout()
        plt.savefig('plots/structural_paths.png', dpi=300, bbox_inches='tight')
        plt.close()
        print("✓ Saved plots/structural_paths.png")

    # ══════════════════════════════════════════════════════════════════════════
    # Section 9: Cross-tabulation — User Typology × Qualitative Themes
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 80)
    print("CROSS-TABULATION: USER TYPOLOGY × QUALITATIVE THEMES")
    print("=" * 80)

    df_efa = pd.read_csv('data/AIRS_experiment.csv')
    df_cfa = pd.read_csv('data/AIRS_holdout.csv')
    df_full = pd.concat([df_efa, df_cfa], ignore_index=True)
    print(f"Combined sample N = {len(df_full)}")

    construct_items = {
        'PerfExp': ['PE1', 'PE2'], 'EffortExp': ['EE1', 'EE2'],
        'SocialInf': ['SI1', 'SI2'], 'FacilCond': ['FC1', 'FC2'],
        'HedonicMot': ['HM1', 'HM2'], 'PriceVal': ['PV1', 'PV2'],
        'Habit': ['HB1', 'HB2'], 'AITrust': ['TR1', 'TR2'],
    }
    for name, items in construct_items.items():
        df_full[name] = df_full[items].mean(axis=1)
    if 'AX1' in df_full.columns and 'AX2' in df_full.columns:
        df_full['AI_Anxiety'] = df_full[['AX1', 'AX2']].mean(axis=1)

    cluster_vars = ['PerfExp', 'EffortExp', 'SocialInf', 'FacilCond',
                    'HedonicMot', 'PriceVal', 'Habit', 'AITrust', 'AI_Adoption']
    available_cv = [c for c in cluster_vars if c in df_full.columns]
    X = df_full[available_cv].dropna()
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)
    kmeans = KMeans(n_clusters=4, random_state=67, n_init=10)
    df_full.loc[X.index, 'Cluster'] = kmeans.fit_predict(X_scaled)

    cluster_profiles = df_full.loc[X.index].groupby('Cluster')[available_cv].mean()
    cluster_names = {}
    for c in range(4):
        avg_readiness = cluster_profiles.loc[c, [v for v in available_cv if v != 'AI_Adoption']].mean()
        if avg_readiness > 4.0:
            cluster_names[c] = 'AI Enthusiasts'
        elif avg_readiness > 3.0:
            cluster_names[c] = 'Cautious Adopters'
        elif avg_readiness > 2.0:
            cluster_names[c] = 'Moderate Users'
        else:
            cluster_names[c] = 'Skeptical Users'

    df_full['UserType'] = df_full['Cluster'].map(cluster_names)

    THEME_KEYWORDS = {
        'Positive Experience': ['enjoy', 'love', 'great', 'helpful', 'useful', 'good',
                                'like', 'amazing', 'excellent', 'wonderful', 'beneficial'],
        'Concerns/Caution': ['concern', 'worry', 'careful', 'caution', 'risk',
                             'afraid', 'fear', 'dangerous'],
        'Accuracy/Reliability': ['accurate', 'accuracy', 'reliable', 'reliability',
                                 'trust', 'correct', 'wrong', 'error', 'mistake', 'inaccurate'],
        'Learning/Education': ['learn', 'study', 'school', 'education', 'research',
                               'student', 'homework', 'class'],
        'Work/Productivity': ['work', 'job', 'task', 'productivity', 'efficient',
                              'time', 'fast', 'quick'],
        'Ethics/Privacy': ['ethic', 'privacy', 'data', 'security', 'moral',
                           'honest', 'integrity'],
    }

    def detect_themes(text):
        if pd.isna(text) or not isinstance(text, str) or len(str(text).strip()) < 10:
            return []
        text_lower = text.lower()
        return [t for t, kws in THEME_KEYWORDS.items() if any(kw in text_lower for kw in kws)]

    df_full['Themes'] = df_full['Open_Feedback'].apply(detect_themes)
    df_full['HasThemes'] = df_full['Themes'].apply(lambda x: len(x) > 0)

    df_themed = df_full[df_full['UserType'].notna() & df_full['HasThemes']].copy()
    print(f"Themed responses: {len(df_themed)}")

    crosstab_results = []
    unique_types = sorted(df_themed['UserType'].dropna().unique())
    for theme in THEME_KEYWORDS:
        df_themed[f'Has_{theme}'] = df_themed['Themes'].apply(lambda t: theme in t)
        contingency = pd.crosstab(df_themed['UserType'], df_themed[f'Has_{theme}'])
        if contingency.shape[1] == 2:
            chi2, p, dof, expected = chi2_contingency(contingency)
            pcts = df_themed.groupby('UserType')[f'Has_{theme}'].mean() * 100
            row = {'Theme': theme, 'Chi2': float(chi2), 'p_value': float(p),
                   'Significant': 'Yes' if p < 0.05 else 'No'}
            for ut in unique_types:
                row[f'{ut}_%'] = float(pcts.get(ut, 0))
            crosstab_results.append(row)
            sig = '*' if p < 0.05 else ''
            print(f"  {theme}: χ²={chi2:.2f}, p={p:.3f} {sig}")

    df_crosstab = pd.DataFrame(crosstab_results)
    if len(df_crosstab) > 0:
        df_crosstab.to_csv('tables/10_typology_theme_crosstab.csv', index=False)
        print("✓ Saved tables/10_typology_theme_crosstab.csv")

    # Heatmap
    pct_cols = [c for c in df_crosstab.columns if c.endswith('_%')]
    if len(df_crosstab) > 0 and pct_cols:
        heatmap_data = df_crosstab.set_index('Theme')[pct_cols]
        heatmap_data.columns = [c.replace('_%', '') for c in pct_cols]

        fig, ax = plt.subplots(figsize=(10, 6))
        im = ax.imshow(heatmap_data.values, cmap='YlOrRd', aspect='auto')
        ax.set_xticks(range(len(heatmap_data.columns)))
        ax.set_xticklabels(heatmap_data.columns, rotation=45, ha='right')
        ax.set_yticks(range(len(heatmap_data.index)))
        ax.set_yticklabels(heatmap_data.index)
        plt.colorbar(im, ax=ax, label='Theme Prevalence (%)')
        for i in range(len(heatmap_data.index)):
            for j in range(len(heatmap_data.columns)):
                val = heatmap_data.values[i, j]
                color = 'white' if val > 30 else 'black'
                ax.text(j, i, f'{val:.0f}%', ha='center', va='center', color=color, fontsize=9)
        ax.set_title('Qualitative Theme Prevalence by User Typology')
        plt.tight_layout()
        plt.savefig('plots/10_typology_theme_crosstab.png', dpi=300, bbox_inches='tight')
        plt.close()
        print("✓ Saved plots/10_typology_theme_crosstab.png")

    # Update synthesis with cross-tab
    significant_themes = df_crosstab[df_crosstab['Significant'] == 'Yes'] if len(df_crosstab) > 0 else pd.DataFrame()
    synthesis['crosstab_analysis'] = {
        'n_themed_responses': int(len(df_themed)),
        'themes_analyzed': list(THEME_KEYWORDS.keys()),
        'significant_associations': int(len(significant_themes)),
    }
    with open('data/final_synthesis.json', 'w') as f:
        json.dump(synthesis, f, indent=2, default=str)
    print("✓ Updated data/final_synthesis.json")

    print("\n✓ Phase 10 complete.")


if __name__ == '__main__':
    main()
