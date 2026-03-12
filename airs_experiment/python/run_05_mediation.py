#!/usr/bin/env python3
"""
AIRS Phase 5: Model Comparison & Alternative Analyses
Refactored from 05_Mediation_Analysis.ipynb

Compares UTAUT2-only vs UTAUT2+Trust, explores mediation, tests 5 alternatives.
Outputs: data/phase5_alternative_analyses.json, tables/utaut2_vs_trust_comparison.csv,
         tables/alternative_model_comparison.csv, tables/mediation_exploration.csv,
         plots/model_comparison_alternatives.png
"""

import json
import os
import sys
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

os.environ['KMP_DUPLICATE_LIB_OK'] = 'True'
warnings.filterwarnings('ignore')

RANDOM_SEED = 67
N_BOOTSTRAP = 1000


def main():
    np.random.seed(RANDOM_SEED)

    print("=" * 90)
    print("PHASE 5: MODEL COMPARISON & ALTERNATIVE ANALYSES")
    print("=" * 90)

    Path('plots').mkdir(exist_ok=True)
    Path('tables').mkdir(exist_ok=True)
    sns.set_style('whitegrid')

    # ── Load Data ─────────────────────────────────────────────────────────
    df_efa = pd.read_csv('data/AIRS_experiment.csv')
    df_cfa = pd.read_csv('data/AIRS_holdout.csv')
    df_full = pd.concat([df_efa, df_cfa], ignore_index=True)

    with open('data/structural_model_results.json', 'r') as f:
        phase4_results = json.load(f)

    # ── Load Structure ──────────────────────────────────────────────────
    # Always use long-name mapping matching run_04 structural model
    MODEL_D_STRUCTURE = {
        'PerfExp': ['PE1', 'PE2'], 'EffortExp': ['EE1', 'EE2'],
        'SocialInf': ['SI1', 'SI2'], 'FacilCond': ['FC1', 'FC2'],
        'HedonicMot': ['HM1', 'HM2'], 'PriceValue': ['PV1', 'PV2'],
        'Habit': ['HB1', 'HB2'], 'AITrust': ['TR1', 'TR2'],
    }
    print(f"Loaded structure: {len(MODEL_D_STRUCTURE)} factors")

    BI_ITEMS = ['BI1', 'BI2', 'BI3', 'BI4']
    df_full['BI'] = df_full[BI_ITEMS].mean(axis=1)

    print(f"\nFull sample: N = {len(df_full)}")
    print(f"BI composite: M = {df_full['BI'].mean():.3f}, SD = {df_full['BI'].std():.3f}")

    # ── Model Builders ────────────────────────────────────────────────────
    def build_measurement_model():
        lines = []
        for construct, items in MODEL_D_STRUCTURE.items():
            lines.append(f"{construct} =~ {' + '.join(items)}")
        return '\n'.join(lines)

    def build_utaut2_only_model():
        utaut2 = ['PerfExp', 'EffortExp', 'SocialInf', 'FacilCond',
                   'HedonicMot', 'PriceValue', 'Habit']
        return build_measurement_model() + '\nBI ~ ' + ' + '.join(utaut2)

    def build_utaut2_trust_model():
        all_c = ['PerfExp', 'EffortExp', 'SocialInf', 'FacilCond',
                  'HedonicMot', 'PriceValue', 'Habit', 'AITrust']
        return build_measurement_model() + '\nBI ~ ' + ' + '.join(all_c)

    def build_mediation_model(predictor):
        syntax = build_measurement_model()
        return syntax + f'\nBI ~ {predictor} + AITrust\nAITrust ~ {predictor}'

    def build_parsimonious_model():
        return build_measurement_model() + '\nBI ~ PriceValue + HedonicMot + SocialInf + AITrust'

    def build_utaut_core_model():
        return build_measurement_model() + '\nBI ~ PerfExp + EffortExp + SocialInf + FacilCond'

    def build_hedonic_value_model():
        return build_measurement_model() + '\nBI ~ HedonicMot + PriceValue + Habit + AITrust'

    # ── Fit UTAUT2-Only ──────────────────────────────────────────────────
    print(f"\n{'=' * 90}")
    print("MODEL COMPARISON: UTAUT2-ONLY vs UTAUT2+TRUST")
    print(f"{'=' * 90}")

    model_utaut2 = Model(build_utaut2_only_model())
    model_utaut2.fit(df_full)
    stats_utaut2 = semopy.calc_stats(model_utaut2)

    model_trust = Model(build_utaut2_trust_model())
    model_trust.fit(df_full)
    stats_trust = semopy.calc_stats(model_trust)

    for label, st in [('UTAUT2-Only', stats_utaut2), ('UTAUT2+Trust', stats_trust)]:
        print(f"\n{label}: chi2={st['chi2'].values[0]:.2f}, df={st['DoF'].values[0]:.0f}, "
              f"CFI={st['CFI'].values[0]:.3f}, TLI={st['TLI'].values[0]:.3f}, "
              f"RMSEA={st['RMSEA'].values[0]:.3f}, AIC={st['AIC'].values[0]:.2f}")

    # ── Comprehensive Comparison ──────────────────────────────────────────
    comparison_data = {
        'Metric': ['chi2', 'df', 'chi2/df', 'CFI', 'TLI', 'RMSEA', 'AIC', 'BIC', 'LogLik'],
        'UTAUT2-Only': [
            stats_utaut2['chi2'].values[0], stats_utaut2['DoF'].values[0],
            stats_utaut2['chi2'].values[0] / stats_utaut2['DoF'].values[0],
            stats_utaut2['CFI'].values[0], stats_utaut2['TLI'].values[0],
            stats_utaut2['RMSEA'].values[0], stats_utaut2['AIC'].values[0],
            stats_utaut2['BIC'].values[0], stats_utaut2['LogLik'].values[0],
        ],
        'UTAUT2+Trust': [
            stats_trust['chi2'].values[0], stats_trust['DoF'].values[0],
            stats_trust['chi2'].values[0] / stats_trust['DoF'].values[0],
            stats_trust['CFI'].values[0], stats_trust['TLI'].values[0],
            stats_trust['RMSEA'].values[0], stats_trust['AIC'].values[0],
            stats_trust['BIC'].values[0], stats_trust['LogLik'].values[0],
        ]
    }
    df_comparison = pd.DataFrame(comparison_data)
    df_comparison['Difference'] = df_comparison['UTAUT2+Trust'] - df_comparison['UTAUT2-Only']

    # Chi-square difference test
    chi2_diff = float(stats_utaut2['chi2'].values[0] - stats_trust['chi2'].values[0])
    df_diff = float(stats_utaut2['DoF'].values[0] - stats_trust['DoF'].values[0])
    p_value_chi2 = 1 - stats.chi2.cdf(chi2_diff, abs(df_diff))

    delta_aic = float(stats_trust['AIC'].values[0] - stats_utaut2['AIC'].values[0])
    delta_bic = float(stats_trust['BIC'].values[0] - stats_utaut2['BIC'].values[0])

    print(f"\nDelta-chi2 = {chi2_diff:.2f}, Delta-df = {abs(df_diff):.0f}, p = {p_value_chi2:.4f}")
    print(f"Delta-AIC = {delta_aic:.2f}, Delta-BIC = {delta_bic:.2f}")
    if p_value_chi2 < 0.05:
        print("-> SIGNIFICANT: Trust improves fit")
    else:
        print("-> NOT SIGNIFICANT: Trust does not significantly improve fit")

    # ── R² Comparison ─────────────────────────────────────────────────────
    params_utaut2 = model_utaut2.inspect()
    params_trust = model_trust.inspect()
    struct_utaut2 = params_utaut2[(params_utaut2['op'] == '~') & (params_utaut2['lval'] == 'BI')]
    struct_trust = params_trust[(params_trust['op'] == '~') & (params_trust['lval'] == 'BI')]

    print(f"\nStructural Paths:")
    for label, sparams in [('UTAUT2-Only', struct_utaut2), ('UTAUT2+Trust', struct_trust)]:
        print(f"\n  {label}:")
        for _, row in sparams.iterrows():
            se = row['Std. Err']
            z = row['Estimate'] / se if se > 0 else 0
            sig = '***' if abs(z) > 3.29 else '**' if abs(z) > 2.58 else '*' if abs(z) > 1.96 else ''
            print(f"    {row['rval']:12} -> BI: b={row['Estimate']:.3f} (SE={se:.3f}) {sig}")

    # R² via predict_factors
    try:
        latent_utaut2 = model_utaut2.predict_factors(df_full)
        pred_utaut2 = (struct_utaut2.set_index('rval')['Estimate'] * latent_utaut2[struct_utaut2['rval'].tolist()]).sum(axis=1)
        r2_utaut2 = float(1 - (df_full['BI'] - pred_utaut2).var() / df_full['BI'].var())

        latent_trust = model_trust.predict_factors(df_full)
        pred_trust = (struct_trust.set_index('rval')['Estimate'] * latent_trust[struct_trust['rval'].tolist()]).sum(axis=1)
        r2_trust = float(1 - (df_full['BI'] - pred_trust).var() / df_full['BI'].var())

        print(f"\nR² UTAUT2-Only = {r2_utaut2:.3f}, R² UTAUT2+Trust = {r2_trust:.3f}, Delta-R² = {r2_trust - r2_utaut2:.3f}")
    except Exception as e:
        r2_utaut2 = r2_trust = np.nan
        print(f"\nR² computation failed: {e}")

    # ── Mediation Exploration ─────────────────────────────────────────────
    print(f"\n{'=' * 90}")
    print("MEDIATION EXPLORATION: UTAUT2 -> AITrust -> BI")
    print(f"{'=' * 90}")

    utaut2_constructs = ['PerfExp', 'EffortExp', 'SocialInf', 'FacilCond',
                         'HedonicMot', 'PriceValue', 'Habit']
    mediation_results = []

    for construct in utaut2_constructs:
        try:
            model = Model(build_mediation_model(construct))
            model.fit(df_full)
            params = model.inspect()

            direct = params[(params['op'] == '~') & (params['lval'] == 'BI') & (params['rval'] == construct)]
            a_path = params[(params['op'] == '~') & (params['lval'] == 'AITrust') & (params['rval'] == construct)]
            b_path = params[(params['op'] == '~') & (params['lval'] == 'BI') & (params['rval'] == 'AITrust')]

            if len(direct) > 0 and len(a_path) > 0 and len(b_path) > 0:
                c_prime = float(direct['Estimate'].values[0])
                a = float(a_path['Estimate'].values[0])
                b = float(b_path['Estimate'].values[0])
                indirect = a * b
                z_a = a / float(a_path['Std. Err'].values[0])
                z_b = b / float(b_path['Std. Err'].values[0])
                z_direct = c_prime / float(direct['Std. Err'].values[0])

                mediation_results.append({
                    'Predictor': construct,
                    'a (X->Trust)': a, 'b (Trust->BI)': b,
                    'c_prime (Direct)': c_prime, 'ab (Indirect)': indirect,
                    'a sig': '*' if abs(z_a) > 1.96 else '',
                    'b sig': '*' if abs(z_b) > 1.96 else '',
                    'c_prime sig': '*' if abs(z_direct) > 1.96 else ''
                })
        except Exception as e:
            print(f"  {construct} failed: {str(e)[:60]}")

    df_mediation = pd.DataFrame(mediation_results)
    print(df_mediation.round(3).to_string(index=False))

    potential = df_mediation[(df_mediation['a sig'] == '*') & (df_mediation['b sig'] == '*')]
    if len(potential) > 0:
        print(f"\nPotential mediations: {potential['Predictor'].tolist()}")
    else:
        print("\nNo significant mediation paths detected.")

    # ── Bootstrap Mediation ───────────────────────────────────────────────
    print(f"\n{'=' * 90}")
    print(f"BOOTSTRAP MEDIATION: EffortExp -> AITrust -> BI ({N_BOOTSTRAP} iterations)")
    print(f"{'=' * 90}")

    bootstrap_indirect = []
    bootstrap_direct = []
    np.random.seed(RANDOM_SEED)

    for i in range(N_BOOTSTRAP):
        sample = df_full.sample(n=len(df_full), replace=True)
        try:
            model = Model(build_mediation_model('EffortExp'))
            model.fit(sample)
            params = model.inspect()
            a_path = params[(params['op'] == '~') & (params['lval'] == 'AITrust') & (params['rval'] == 'EffortExp')]
            b_path = params[(params['op'] == '~') & (params['lval'] == 'BI') & (params['rval'] == 'AITrust')]
            direct = params[(params['op'] == '~') & (params['lval'] == 'BI') & (params['rval'] == 'EffortExp')]
            if len(a_path) > 0 and len(b_path) > 0 and len(direct) > 0:
                a = float(a_path['Estimate'].values[0])
                b = float(b_path['Estimate'].values[0])
                c_prime = float(direct['Estimate'].values[0])
                bootstrap_indirect.append(a * b)
                bootstrap_direct.append(c_prime)
        except:
            pass
        if (i + 1) % 200 == 0:
            print(f"  {i+1}/{N_BOOTSTRAP} done...", flush=True)

    indirect_ci = np.percentile(bootstrap_indirect, [2.5, 97.5])
    direct_ci = np.percentile(bootstrap_direct, [2.5, 97.5])

    indirect_sig = indirect_ci[0] > 0 or indirect_ci[1] < 0
    direct_sig = direct_ci[0] > 0 or direct_ci[1] < 0

    if indirect_sig:
        med_type = "PARTIAL MEDIATION" if direct_sig else "FULL MEDIATION"
    else:
        med_type = "NO MEDIATION"

    print(f"\nIndirect (ab): M={np.mean(bootstrap_indirect):.3f}, 95% CI [{indirect_ci[0]:.3f}, {indirect_ci[1]:.3f}] -> {'SIG' if indirect_sig else 'NS'}")
    print(f"Direct (c'):   M={np.mean(bootstrap_direct):.3f}, 95% CI [{direct_ci[0]:.3f}, {direct_ci[1]:.3f}] -> {'SIG' if direct_sig else 'NS'}")
    print(f"Mediation Type: {med_type}")

    # ── Alternative Models ────────────────────────────────────────────────
    print(f"\n{'=' * 90}")
    print("ALTERNATIVE PATH CONFIGURATIONS")
    print(f"{'=' * 90}")

    models_to_test = {
        'Full AIRS (8 predictors)': build_utaut2_trust_model,
        'UTAUT2-Only (7 predictors)': build_utaut2_only_model,
        'Parsimonious (4 sig predictors)': build_parsimonious_model,
        'UTAUT Core (4 predictors)': build_utaut_core_model,
        'Hedonic-Value (4 predictors)': build_hedonic_value_model,
    }

    alt_results = []
    for name, builder in models_to_test.items():
        try:
            model = Model(builder())
            model.fit(df_full)
            st = semopy.calc_stats(model)
            params = model.inspect()
            n_paths = len(params[(params['op'] == '~') & (params['lval'] == 'BI')])
            alt_results.append({
                'Model': name, 'Paths': n_paths,
                'chi2': float(st['chi2'].values[0]), 'df': float(st['DoF'].values[0]),
                'CFI': float(st['CFI'].values[0]), 'TLI': float(st['TLI'].values[0]),
                'RMSEA': float(st['RMSEA'].values[0]),
                'AIC': float(st['AIC'].values[0]), 'BIC': float(st['BIC'].values[0]),
            })
        except Exception as e:
            print(f"  {name}: Failed - {str(e)[:80]}")

    df_alt = pd.DataFrame(alt_results)
    df_alt['chi2/df'] = df_alt['chi2'] / df_alt['df']
    df_alt_sorted = df_alt.sort_values('AIC')
    best_model = df_alt_sorted.iloc[0]['Model']

    print("\nAlternative Model Comparison (sorted by AIC):")
    print(df_alt_sorted[['Model', 'Paths', 'CFI', 'TLI', 'RMSEA', 'AIC', 'BIC']].round(3).to_string(index=False))
    print(f"\nBest model (lowest AIC): {best_model}")

    # ── Visualization ─────────────────────────────────────────────────────
    fig, axes = plt.subplots(1, 3, figsize=(15, 5))

    ax1 = axes[0]
    colors = ['#2ecc71' if m == best_model else '#3498db' for m in df_alt_sorted['Model']]
    ax1.barh(df_alt_sorted['Model'], df_alt_sorted['AIC'], color=colors)
    ax1.set_xlabel('AIC (lower is better)')
    ax1.set_title('AIC')
    ax1.axvline(x=df_alt_sorted['AIC'].min(), color='red', linestyle='--', alpha=0.5)

    ax2 = axes[1]
    x = np.arange(len(df_alt_sorted))
    width = 0.35
    ax2.barh(x - width/2, df_alt_sorted['CFI'], width, label='CFI', color='#3498db')
    ax2.barh(x + width/2, df_alt_sorted['TLI'], width, label='TLI', color='#e74c3c')
    ax2.set_yticks(x)
    ax2.set_yticklabels(df_alt_sorted['Model'])
    ax2.set_xlabel('Fit Index')
    ax2.set_title('CFI & TLI')
    ax2.axvline(x=0.95, color='green', linestyle='--', alpha=0.5)
    ax2.legend(loc='lower right')

    ax3 = axes[2]
    colors = ['#2ecc71' if r <= 0.06 else '#f39c12' if r <= 0.08 else '#e74c3c'
              for r in df_alt_sorted['RMSEA']]
    ax3.barh(df_alt_sorted['Model'], df_alt_sorted['RMSEA'], color=colors)
    ax3.set_xlabel('RMSEA (lower is better)')
    ax3.set_title('RMSEA')
    ax3.axvline(x=0.06, color='green', linestyle='--', alpha=0.5)
    ax3.axvline(x=0.08, color='orange', linestyle='--', alpha=0.5)

    plt.tight_layout()
    plt.savefig('plots/model_comparison_alternatives.png', dpi=150, bbox_inches='tight')
    plt.close()
    print("\nSaved: plots/model_comparison_alternatives.png")

    # ── Export ────────────────────────────────────────────────────────────
    summary_stats = {
        'analysis_date': pd.Timestamp.now().isoformat(),
        'sample_size': len(df_full),
        'model_comparison': {
            'delta_chi2': chi2_diff,
            'delta_chi2_p': p_value_chi2,
            'delta_aic': delta_aic,
            'delta_bic': delta_bic,
            'utaut2_cfi': float(stats_utaut2['CFI'].values[0]),
            'trust_cfi': float(stats_trust['CFI'].values[0]),
        },
        'mediation_test': {
            'predictor': 'EffortExp',
            'indirect_effect': float(np.mean(bootstrap_indirect)),
            'indirect_ci_lower': float(indirect_ci[0]),
            'indirect_ci_upper': float(indirect_ci[1]),
            'mediation_detected': bool(indirect_sig),
        },
        'alternative_models': df_alt_sorted[['Model', 'AIC', 'CFI', 'RMSEA']].to_dict('records'),
        'best_model_aic': best_model,
    }

    df_alt_sorted.to_csv('tables/alternative_model_comparison.csv', index=False)
    df_comparison.to_csv('tables/utaut2_vs_trust_comparison.csv', index=False)
    df_mediation.to_csv('tables/mediation_exploration.csv', index=False)
    with open('data/phase5_alternative_analyses.json', 'w') as f:
        json.dump(summary_stats, f, indent=2, default=str)

    print("\nExported: tables/alternative_model_comparison.csv, utaut2_vs_trust_comparison.csv,")
    print("  mediation_exploration.csv, data/phase5_alternative_analyses.json")

    print(f"\n{'=' * 90}")
    print("PHASE 5 COMPLETE")
    print(f"{'=' * 90}")


if __name__ == '__main__':
    main()
