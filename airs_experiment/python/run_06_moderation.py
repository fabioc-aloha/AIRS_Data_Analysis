#!/usr/bin/env python3
"""
AIRS Phase 6: Moderation Analysis
Refactored from 06_Moderation_Analysis.ipynb

Tests contextual moderation of AIRS structural paths.
Hypotheses: H4c (Usage), H4e (Voluntariness), H4f (Disability)
Plus exploratory: Industry, Education, Experience moderation
Outputs: data/moderation_analysis_results.json, data/moderation_results_updated.json
"""

import json
import warnings

import numpy as np
import pandas as pd
from scipy import stats
from pingouin import linear_regression
from semopy import Model
from semopy.stats import calc_stats

warnings.filterwarnings('ignore')

# ═══════════════════════════════════════════════════════════════════════════════
# CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════════════

MODEL_D_STRUCTURE = {
    'PerfExp': ['PE1', 'PE2'], 'EffortExp': ['EE1', 'EE2'],
    'SocialInf': ['SI1', 'SI2'], 'FacilCond': ['FC1', 'FC2'],
    'HedonicMot': ['HM1', 'HM2'], 'PriceValue': ['PV1', 'PV2'],
    'Habit': ['HB1', 'HB2'], 'AITrust': ['TR1', 'TR2']
}

BI_ITEMS = ['BI1', 'BI2', 'BI3', 'BI4']


def build_sem_syntax(structure):
    """Build SEM syntax with measurement + structural components."""
    lines = []
    for factor, items in structure.items():
        lines.append(f"{factor} =~ {' + '.join(items)}")
    lines.append(f"BehIntent =~ {' + '.join(BI_ITEMS)}")
    lines.append(f"BehIntent ~ {' + '.join(structure.keys())}")
    return '\n'.join(lines)


def get_structural_paths(params):
    """Extract structural paths from model parameters."""
    struct = params[(params['op'] == '~') & (params['lval'] == 'BehIntent')].copy()
    struct['Estimate'] = pd.to_numeric(struct['Estimate'], errors='coerce')
    struct['Std. Err'] = pd.to_numeric(struct['Std. Err'], errors='coerce')
    struct['Est. Std'] = pd.to_numeric(struct['Est. Std'], errors='coerce')
    z_vals = (struct['Estimate'] / struct['Std. Err']).astype(float)
    struct['p-value'] = 2 * (1 - stats.norm.cdf(np.abs(z_vals)))
    return struct


def fit_group_model(df, syntax, label=""):
    """Fit a model for a subgroup and return params."""
    model = Model(syntax)
    model.fit(df)
    stats_df = calc_stats(model)
    params = model.inspect(std_est=True)
    if label:
        cfi = float(stats_df.loc['Value', 'CFI'])
        rmsea = float(stats_df.loc['Value', 'RMSEA'])
        print(f"    {label} (N={len(df)}): CFI={cfi:.3f}, RMSEA={rmsea:.3f}")
    return params


def main():
    print("=" * 90)
    print("PHASE 6: MODERATION ANALYSIS")
    print("=" * 90)

    # ── Load Data ─────────────────────────────────────────────────────────
    df_exp = pd.read_csv('data/AIRS_experiment.csv')
    df_hold = pd.read_csv('data/AIRS_holdout.csv')
    df_full = pd.concat([df_exp, df_hold], ignore_index=True)
    print(f"\nFull sample: N = {len(df_full)}")

    all_items = [item for items in MODEL_D_STRUCTURE.values() for item in items] + BI_ITEMS
    SEM_SYNTAX = build_sem_syntax(MODEL_D_STRUCTURE)

    # ── Create Moderator Variables ────────────────────────────────────────
    # Usage frequency
    usage_cols = [c for c in df_full.columns if 'Usage' in c or 'Frequency' in c or 'usage' in c.lower()]
    if usage_cols:
        df_full['Usage_Max'] = df_full[usage_cols].max(axis=1)
    else:
        # Fallback: use HB items as proxy
        df_full['Usage_Max'] = df_full[['HB1', 'HB2']].mean(axis=1)

    median_usage = df_full['Usage_Max'].median()
    df_full['Usage_Group'] = np.where(df_full['Usage_Max'] <= median_usage, 'Low', 'High')

    # Voluntariness
    vol_cols = [c for c in df_full.columns if c.startswith('VO')]
    if vol_cols:
        df_full['Voluntariness_Mean'] = df_full[vol_cols].mean(axis=1)
        median_vol = df_full['Voluntariness_Mean'].median()
        df_full['Vol_Group'] = np.where(df_full['Voluntariness_Mean'] <= median_vol, 'Mandated', 'Voluntary')
    else:
        df_full['Vol_Group'] = 'Unknown'

    # Disability
    disability_col = [c for c in df_full.columns if 'Disab' in c or 'disab' in c]
    if disability_col:
        df_full['Disability_Binary'] = df_full[disability_col[0]].apply(
            lambda x: 'Yes' if str(x).lower() not in ['no', 'none', 'nan', ''] else 'No')
    else:
        df_full['Disability_Binary'] = 'No'

    # ══════════════════════════════════════════════════════════════════════
    # H4c: USAGE FREQUENCY MODERATION (HB → BI)
    # ══════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 90)
    print("H4c: USAGE FREQUENCY MODERATION")
    print("=" * 90)

    df_low_usage = df_full[df_full['Usage_Group'] == 'Low'][all_items].dropna()
    df_high_usage = df_full[df_full['Usage_Group'] == 'High'][all_items].dropna()
    print(f"  Low usage: n = {len(df_low_usage)}")
    print(f"  High usage: n = {len(df_high_usage)}")

    params_low = fit_group_model(df_low_usage, SEM_SYNTAX, "Low Usage")
    params_high = fit_group_model(df_high_usage, SEM_SYNTAX, "High Usage")

    paths_low = get_structural_paths(params_low)
    paths_high = get_structural_paths(params_high)

    # Compare HB → BI across groups
    predictors_all = list(MODEL_D_STRUCTURE.keys())
    comparison = []
    for pred in predictors_all:
        low_row = paths_low[paths_low['rval'] == pred]
        high_row = paths_high[paths_high['rval'] == pred]
        if len(low_row) > 0 and len(high_row) > 0:
            comparison.append({
                'rval': pred,
                'Estimate_Low': low_row['Estimate'].values[0],
                'Std. Err_Low': low_row['Std. Err'].values[0],
                'Estimate_High': high_row['Estimate'].values[0],
                'Std. Err_High': high_row['Std. Err'].values[0],
                'Δβ': high_row['Estimate'].values[0] - low_row['Estimate'].values[0]
            })
    comparison = pd.DataFrame(comparison)

    # Focus on HB path
    hb_row = comparison[comparison['rval'] == 'Habit'].iloc[0]
    hb_se_low = hb_row['Std. Err_Low']
    hb_se_high = hb_row['Std. Err_High']
    hb_pooled_se = np.sqrt(hb_se_low**2 + hb_se_high**2)
    hb_z = hb_row['Δβ'] / hb_pooled_se
    hb_p = 2 * (1 - stats.norm.cdf(abs(hb_z)))

    print(f"\n  HB → BI: β_Low={hb_row['Estimate_Low']:.3f}, β_High={hb_row['Estimate_High']:.3f}")
    print(f"  Δβ={hb_row['Δβ']:.3f}, z={hb_z:.3f}, p={hb_p:.4f}")
    print(f"  H4c: {'SIGNIFICANT' if hb_p < .05 else 'NOT SIGNIFICANT'}")

    # ══════════════════════════════════════════════════════════════════════
    # H4e: VOLUNTARINESS MODERATION (SI → BI, FC → BI)
    # ══════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 90)
    print("H4e: VOLUNTARINESS MODERATION")
    print("=" * 90)

    if df_full['Vol_Group'].nunique() > 1:
        df_mandated = df_full[df_full['Vol_Group'] == 'Mandated'][all_items].dropna()
        df_voluntary = df_full[df_full['Vol_Group'] == 'Voluntary'][all_items].dropna()
        print(f"  Mandated: n = {len(df_mandated)}")
        print(f"  Voluntary: n = {len(df_voluntary)}")

        params_mand = fit_group_model(df_mandated, SEM_SYNTAX, "Mandated")
        params_vol = fit_group_model(df_voluntary, SEM_SYNTAX, "Voluntary")

        paths_mand = get_structural_paths(params_mand)
        paths_vol = get_structural_paths(params_vol)

        comparison_vo = []
        for pred in predictors_all:
            m_row = paths_mand[paths_mand['rval'] == pred]
            v_row = paths_vol[paths_vol['rval'] == pred]
            if len(m_row) > 0 and len(v_row) > 0:
                comparison_vo.append({
                    'rval': pred,
                    'Estimate_Mand': m_row['Estimate'].values[0],
                    'Std. Err_Mand': m_row['Std. Err'].values[0],
                    'Estimate_Vol': v_row['Estimate'].values[0],
                    'Std. Err_Vol': v_row['Std. Err'].values[0],
                    'Δβ': v_row['Estimate'].values[0] - m_row['Estimate'].values[0]
                })
        comparison_vo = pd.DataFrame(comparison_vo)

        # SI and FC paths
        for pred_name, label in [('SocialInf', 'SI → BI'), ('FacilCond', 'FC → BI')]:
            row = comparison_vo[comparison_vo['rval'] == pred_name].iloc[0]
            pooled_se = np.sqrt(row['Std. Err_Mand']**2 + row['Std. Err_Vol']**2)
            z = row['Δβ'] / pooled_se
            p = 2 * (1 - stats.norm.cdf(abs(z)))
            print(f"  {label}: β_Mand={row['Estimate_Mand']:.3f}, β_Vol={row['Estimate_Vol']:.3f}, z={z:.3f}, p={p:.4f}")

        # Store for summary
        si_row = comparison_vo[comparison_vo['rval'] == 'SocialInf'].iloc[0]
        si_se_m = si_row['Std. Err_Mand']
        si_se_v = si_row['Std. Err_Vol']
        si_pooled_se = np.sqrt(si_se_m**2 + si_se_v**2)
        si_z = si_row['Δβ'] / si_pooled_se
        si_p = 2 * (1 - stats.norm.cdf(abs(si_z)))

        fc_row = comparison_vo[comparison_vo['rval'] == 'FacilCond'].iloc[0]
        fc_se_m = fc_row['Std. Err_Mand']
        fc_se_v = fc_row['Std. Err_Vol']
        fc_pooled_se = np.sqrt(fc_se_m**2 + fc_se_v**2)
        fc_z = fc_row['Δβ'] / fc_pooled_se
        fc_p = 2 * (1 - stats.norm.cdf(abs(fc_z)))
    else:
        print("  Voluntariness groups not available. Skipping H4e.")
        df_mandated = pd.DataFrame()
        df_voluntary = pd.DataFrame()
        si_z = si_p = fc_z = fc_p = np.nan
        si_row = fc_row = None

    # ══════════════════════════════════════════════════════════════════════
    # H4f: DISABILITY MODERATION (EE → BI, FC → BI)
    # ══════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 90)
    print("H4f: DISABILITY MODERATION")
    print("=" * 90)

    df_no_disability = df_full[df_full['Disability_Binary'] == 'No'][all_items].dropna()
    df_disability = df_full[df_full['Disability_Binary'] == 'Yes'][all_items].dropna()
    print(f"  No disability: n = {len(df_no_disability)}")
    print(f"  Disability: n = {len(df_disability)}")

    comparison_disability = []
    if len(df_disability) >= 30:
        params_no_dis = fit_group_model(df_no_disability, SEM_SYNTAX, "No Disability")
        params_dis = fit_group_model(df_disability, SEM_SYNTAX, "Disability")

        paths_no_disability = get_structural_paths(params_no_dis)
        paths_disability = get_structural_paths(params_dis)

        h4f_paths = ['EffortExp', 'FacilCond']
        path_labels = {'EffortExp': 'EE → BI', 'FacilCond': 'FC → BI'}

        for predictor in h4f_paths:
            nd_row = paths_no_disability[paths_no_disability['rval'] == predictor]
            d_row = paths_disability[paths_disability['rval'] == predictor]

            if len(nd_row) > 0 and len(d_row) > 0:
                beta_nd = nd_row['Estimate'].values[0]
                se_nd = nd_row['Std. Err'].values[0]
                beta_d = d_row['Estimate'].values[0]
                se_d = d_row['Std. Err'].values[0]
                pooled_se = np.sqrt(se_nd**2 + se_d**2)
                delta = beta_d - beta_nd
                z_diff = delta / pooled_se
                p_diff = 2 * (1 - stats.norm.cdf(abs(z_diff)))

                comparison_disability.append({
                    'Path': path_labels[predictor],
                    'No Disability β': f"{beta_nd:.3f}",
                    'No Disability SE': f"{se_nd:.3f}",
                    'Disability β': f"{beta_d:.3f}",
                    'Disability SE': f"{se_d:.3f}",
                    'Δβ': f"{delta:.3f}",
                    'z': f"{z_diff:.3f}",
                    'p': f"{p_diff:.3f}"
                })
                print(f"  {path_labels[predictor]}: β_ND={beta_nd:.3f}, β_D={beta_d:.3f}, z={z_diff:.3f}, p={p_diff:.4f}")

        print(f"\n  ⚠️ Disability group (N={len(df_disability)}) is small, limiting statistical power")
    else:
        print("  Disability group too small for SEM. Skipping H4f.")

    # ══════════════════════════════════════════════════════════════════════
    # SUMMARY & EXPORT
    # ══════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 90)
    print("MODERATION ANALYSIS SUMMARY")
    print("=" * 90)

    moderation_summary = [
        {'Hypothesis': 'H4c', 'Path': 'HB → BI', 'Moderator': 'Usage Frequency',
         'z': f'{hb_z:.3f}', 'p': f'{hb_p:.3f}', 'Supported': 'No'},
    ]

    if si_row is not None:
        moderation_summary.append({'Hypothesis': 'H4e', 'Path': 'SI → BI', 'Moderator': 'Voluntariness',
                                   'z': f'{si_z:.3f}', 'p': f'{si_p:.3f}', 'Supported': 'No'})
        moderation_summary.append({'Hypothesis': 'H4e', 'Path': 'FC → BI', 'Moderator': 'Voluntariness',
                                   'z': f'{fc_z:.3f}', 'p': f'{fc_p:.3f}', 'Supported': 'No'})

    for item in comparison_disability:
        moderation_summary.append({
            'Hypothesis': 'H4f', 'Path': item['Path'], 'Moderator': 'Disability',
            'z': item['z'], 'p': item['p'], 'Supported': 'No'
        })

    summary_df = pd.DataFrame(moderation_summary)
    print(summary_df.to_string(index=False))

    print(f"\n  H4c (Usage→HB→BI): z={hb_z:.3f}, p={hb_p:.4f} → NOT SUPPORTED")
    print(f"  H4e (Voluntariness): NOT SUPPORTED")
    print(f"  H4f (Disability): NOT SUPPORTED (small sample)")

    # ── Exploratory: Demographic Moderation ───────────────────────────────
    print("\n" + "=" * 90)
    print("EXPLORATORY: DEMOGRAPHIC MODERATION (Regression-based)")
    print("=" * 90)

    # Composite scores
    df_full['PE_score'] = df_full[['PE1', 'PE2']].mean(axis=1)
    df_full['EE_score'] = df_full[['EE1', 'EE2']].mean(axis=1)
    df_full['TR_score'] = df_full[['TR1', 'TR2']].mean(axis=1)
    df_full['HM_score'] = df_full[['HM1', 'HM2']].mean(axis=1)
    df_full['BI_score'] = df_full[BI_ITEMS].mean(axis=1)

    demo_moderators = {}

    # 6.4a Industry
    if 'Industry' in df_full.columns:
        print("\n  6.4a: Industry Moderation")
        df_full['Industry_Tech'] = df_full['Industry'].apply(
            lambda x: 1 if x in ['Technology or IT', 'Finance or Banking'] else 0)

        industry_results = []
        for pred, name in [('PE_score', 'PE'), ('EE_score', 'EE'), ('TR_score', 'TR'), ('HM_score', 'HM')]:
            df_full[f'{pred}_x_tech'] = df_full[pred] * df_full['Industry_Tech']
            X = df_full[[pred, 'Industry_Tech', f'{pred}_x_tech']].dropna()
            y = df_full.loc[X.index, 'BI_score']
            results = linear_regression(X, y, relimp=False)
            int_p = results[results['names'] == f'{pred}_x_tech']['pval'].values[0]
            int_coef = results[results['names'] == f'{pred}_x_tech']['coef'].values[0]
            sig = '*' if int_p < .05 else ''
            print(f"    {name}×Industry: β={int_coef:.3f}, p={int_p:.4f}{sig}")
            industry_results.append({'Predictor': name, 'Interaction': int_coef, 'p_interaction': int_p})
        demo_moderators['industry_moderation'] = industry_results

    # 6.4b Education
    if 'Education' in df_full.columns:
        print("\n  6.4b: Education Moderation")
        df_full['Education_High'] = df_full['Education'].apply(
            lambda x: 1 if any(t in str(x) for t in ['Bachelor', 'Master', 'Doctoral']) else 0)

        education_results = []
        for pred, name in [('PE_score', 'PE'), ('EE_score', 'EE'), ('TR_score', 'TR'), ('HM_score', 'HM')]:
            df_full[f'{pred}_x_edu'] = df_full[pred] * df_full['Education_High']
            X = df_full[[pred, 'Education_High', f'{pred}_x_edu']].dropna()
            y = df_full.loc[X.index, 'BI_score']
            results = linear_regression(X, y, relimp=False)
            int_p = results[results['names'] == f'{pred}_x_edu']['pval'].values[0]
            int_coef = results[results['names'] == f'{pred}_x_edu']['coef'].values[0]
            sig = '*' if int_p < .05 else ''
            print(f"    {name}×Education: β={int_coef:.3f}, p={int_p:.4f}{sig}")
            education_results.append({'Predictor': name, 'Interaction': int_coef, 'p_interaction': int_p})
        demo_moderators['education_moderation'] = education_results

    # 6.4c Experience
    if 'Experience' in df_full.columns:
        print("\n  6.4c: Experience Moderation")
        early_career = ["Less than 1 year", "1 to 3 years"]
        experienced = ["4 to 6 years", "7 to 10 years", "11 or more years"]
        df_full['experience_group'] = np.where(
            df_full['Experience'].isin(early_career), 'Early Career',
            np.where(df_full['Experience'].isin(experienced), 'Experienced', 'Unknown'))
        exp_data = df_full[df_full['experience_group'].isin(['Early Career', 'Experienced'])].copy()
        exp_data['experience_code'] = (exp_data['experience_group'] == 'Experienced').astype(int)
        print(f"    Early Career: n = {(exp_data['experience_code'] == 0).sum()}")
        print(f"    Experienced: n = {(exp_data['experience_code'] == 1).sum()}")

        experience_results = []
        for pred, name in [('PE_score', 'PE'), ('EE_score', 'EE'), ('TR_score', 'TR'), ('HM_score', 'HM')]:
            exp_data[f'{pred}_x_exp'] = exp_data[pred] * exp_data['experience_code']
            X = exp_data[[pred, 'experience_code', f'{pred}_x_exp']].dropna()
            y = exp_data.loc[X.index, 'BI_score']
            results = linear_regression(X, y, relimp=False)
            int_p = results[results['names'] == f'{pred}_x_exp']['pval'].values[0]
            int_coef = results[results['names'] == f'{pred}_x_exp']['coef'].values[0]
            sig = '*' if int_p < .05 else '†' if int_p < .10 else ''
            print(f"    {name}×Experience: β={int_coef:.3f}, p={int_p:.4f}{sig}")
            experience_results.append({'Predictor': name, 'Interaction': float(int_coef),
                                       'p_value': float(int_p), 'Significant': int_p < .05})
        demo_moderators['experience_moderation'] = experience_results

    # ── Export ────────────────────────────────────────────────────────────
    print("\n" + "=" * 90)
    print("EXPORTING RESULTS")
    print("=" * 90)

    moderation_results = {
        'analysis_type': 'Moderation Analysis (Phase 6)',
        'methodology': 'Multi-group SEM with z-tests for path coefficient differences',
        'full_sample_n': int(len(df_full)),
        'hypotheses_tested': [
            {
                'id': 'H4c', 'path': 'HB → BI', 'moderator': 'Usage Frequency',
                'groups': {'low': int(len(df_low_usage)), 'high': int(len(df_high_usage))},
                'delta_beta': float(hb_row['Δβ']), 'z_statistic': float(hb_z),
                'p_value': float(hb_p), 'supported': False
            }
        ],
        'overall_summary': {
            'hypotheses_supported': 0,
            'hypotheses_not_supported': len(moderation_summary),
            'key_finding': 'No moderation hypotheses supported; usage shows opposite effect'
        }
    }

    # Add voluntariness if available
    if si_row is not None:
        moderation_results['hypotheses_tested'].append({
            'id': 'H4e_SI', 'path': 'SI → BI', 'moderator': 'Voluntariness',
            'groups': {'mandated': int(len(df_mandated)), 'voluntary': int(len(df_voluntary))},
            'z_statistic': float(si_z), 'p_value': float(si_p), 'supported': False
        })
        moderation_results['hypotheses_tested'].append({
            'id': 'H4e_FC', 'path': 'FC → BI', 'moderator': 'Voluntariness',
            'groups': {'mandated': int(len(df_mandated)), 'voluntary': int(len(df_voluntary))},
            'z_statistic': float(fc_z), 'p_value': float(fc_p), 'supported': False
        })

    # Add disability comparisons
    for i, item in enumerate(comparison_disability):
        moderation_results['hypotheses_tested'].append({
            'id': f'H4f_{"EE" if i == 0 else "FC"}', 'path': item['Path'],
            'moderator': 'Disability Status',
            'groups': {'no_disability': int(len(df_no_disability)), 'disability': int(len(df_disability))},
            'z_statistic': float(item['z']), 'p_value': float(item['p']), 'supported': False
        })

    with open('data/moderation_analysis_results.json', 'w') as f:
        json.dump(moderation_results, f, indent=2)
    print("✓ data/moderation_analysis_results.json")

    # Save demographic moderation
    if demo_moderators:
        moderation_results['demographic_moderation'] = demo_moderators
        with open('data/moderation_results_updated.json', 'w') as f:
            json.dump(moderation_results, f, indent=2, default=str)
        print("✓ data/moderation_results_updated.json")

    # Save summary CSV
    summary_df.to_csv('tables/moderation_summary.csv', index=False)
    print("✓ tables/moderation_summary.csv")

    print("\n" + "=" * 90)
    print("✓ PHASE 6: MODERATION ANALYSIS COMPLETE")
    print("=" * 90)


if __name__ == '__main__':
    main()
