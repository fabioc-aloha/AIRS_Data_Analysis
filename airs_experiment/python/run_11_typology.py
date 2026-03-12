#!/usr/bin/env python3
"""
AIRS Phase 11: Practitioner Typology Classification
Refactored from 11_Practitioner_Typology.ipynb

K-means cluster analysis for user typology based on AIRS-16 constructs.
Includes k=3 optimal solution, k=4 comparison, predictive validation,
and classification function for field deployment.
Outputs: results/phase11_practitioner_typology_results.json
"""

import json
import warnings
from pathlib import Path

import numpy as np
import pandas as pd
from scipy import stats as scipy_stats
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import silhouette_score
from sklearn.model_selection import cross_val_score
from sklearn.linear_model import LinearRegression

warnings.filterwarnings('ignore')

# ═══════════════════════════════════════════════════════════════════════════════
# CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════════════

AIRS16_CONSTRUCTS = ['PE', 'EE', 'SI', 'FC', 'HM', 'PV', 'HB', 'TR']
OUTCOME = 'BI'
SELECTED_K = 3
K_ALT = 4
RANDOM_STATE = 42


def main():
    print("=" * 90)
    print("PHASE 11: PRACTITIONER TYPOLOGY CLASSIFICATION")
    print("=" * 90)

    # ── Load Data ─────────────────────────────────────────────────────────
    df = pd.read_csv('data/AIRS_clean.csv')
    print(f"\nLoaded: {df.shape[0]} rows x {df.shape[1]} columns")

    # Compute construct scores (mean of 2 items each)
    item_map = {
        'PE': ['PE1', 'PE2'], 'EE': ['EE1', 'EE2'], 'SI': ['SI1', 'SI2'],
        'FC': ['FC1', 'FC2'], 'HM': ['HM1', 'HM2'], 'PV': ['PV1', 'PV2'],
        'HB': ['HB1', 'HB2'], 'TR': ['TR1', 'TR2']
    }
    for construct, items in item_map.items():
        df[construct] = df[items].mean(axis=1)

    # BI outcome
    bi_items = ['BI1', 'BI2', 'BI3', 'BI4']
    df['BI'] = df[bi_items].mean(axis=1)

    print(f"\nConstruct scores computed (N = {len(df)}):")
    print(df[AIRS16_CONSTRUCTS + ['BI']].describe().round(3).to_string())

    # ── Correlation Matrix ────────────────────────────────────────────────
    corr = df[AIRS16_CONSTRUCTS + ['BI']].corr()
    print(f"\nCorrelation with BI:")
    for c in AIRS16_CONSTRUCTS:
        print(f"  {c}: r = {corr.loc[c, 'BI']:.3f}")

    # ── Prepare Clustering ────────────────────────────────────────────────
    X = df[AIRS16_CONSTRUCTS].dropna()
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)

    pop_means = df[AIRS16_CONSTRUCTS].mean()
    pop_stds = df[AIRS16_CONSTRUCTS].std()

    # ── Silhouette Analysis (k=2 to 8) ───────────────────────────────────
    print("\n" + "=" * 90)
    print("SILHOUETTE ANALYSIS")
    print("=" * 90)

    sil_scores = {}
    for k in range(2, 9):
        km = KMeans(n_clusters=k, n_init=10, random_state=RANDOM_STATE)
        labels = km.fit_predict(X_scaled)
        sil = silhouette_score(X_scaled, labels)
        sil_scores[k] = sil
        marker = ' ←' if k == SELECTED_K else ''
        print(f"  k={k}: silhouette = {sil:.3f}{marker}")

    # ── k=3 Final Clustering ──────────────────────────────────────────────
    print(f"\n" + "=" * 90)
    print(f"FINAL CLUSTERING (k={SELECTED_K})")
    print("=" * 90)

    km_final = KMeans(n_clusters=SELECTED_K, n_init=10, random_state=RANDOM_STATE)
    df['Cluster'] = km_final.fit_predict(X_scaled)
    final_silhouette = silhouette_score(X_scaled, df['Cluster'])
    print(f"  Silhouette score: {final_silhouette:.3f}")

    # Cluster sizes
    sizes = df['Cluster'].value_counts().sort_index()
    for c, n in sizes.items():
        print(f"  Cluster {c}: n = {n} ({n / len(df) * 100:.1f}%)")

    # Cluster profiles (z-scores)
    cluster_means_z = df.groupby('Cluster')[AIRS16_CONSTRUCTS].mean()
    for c in AIRS16_CONSTRUCTS:
        cluster_means_z[c] = (cluster_means_z[c] - pop_means[c]) / pop_stds[c]

    cluster_means_raw = df.groupby('Cluster')[AIRS16_CONSTRUCTS].mean()

    print("\n  Z-scored cluster profiles:")
    print(cluster_means_z.round(3).to_string())

    # Cluster naming based on profile patterns
    CLUSTER_NAMES = {}
    for cluster_id in range(SELECTED_K):
        profile = cluster_means_z.loc[cluster_id]
        mean_z = profile.mean()
        if mean_z > 0.3:
            CLUSTER_NAMES[cluster_id] = 'AI Enthusiasts'
        elif mean_z < -0.3:
            CLUSTER_NAMES[cluster_id] = 'AI Skeptics'
        else:
            CLUSTER_NAMES[cluster_id] = 'Moderate Users'

    df['Typology'] = df['Cluster'].map(CLUSTER_NAMES)

    print("\n  Cluster names:")
    for cid, name in CLUSTER_NAMES.items():
        n = sizes[cid]
        bi_mean = df[df['Cluster'] == cid]['BI'].mean()
        print(f"  {cid}: {name} (n={n}, BI mean={bi_mean:.2f})")

    # ── k=4 Comparison ────────────────────────────────────────────────────
    print(f"\n" + "=" * 90)
    print(f"k={K_ALT} ALTERNATIVE COMPARISON")
    print("=" * 90)

    km_k4 = KMeans(n_clusters=K_ALT, n_init=10, random_state=RANDOM_STATE)
    k4_labels = km_k4.fit_predict(X_scaled)
    sil_k4 = silhouette_score(X_scaled, k4_labels)
    k4_sizes = pd.Series(k4_labels).value_counts().sort_index()

    print(f"  k=4 silhouette: {sil_k4:.3f} (k=3: {final_silhouette:.3f})")
    for c, n in k4_sizes.items():
        print(f"  Cluster {c}: n = {n} ({n / len(df) * 100:.1f}%)")

    # k=4 z-scored profiles
    df_k4 = df.copy()
    df_k4['K4_Cluster'] = k4_labels
    k4_means = df_k4.groupby('K4_Cluster')[AIRS16_CONSTRUCTS].mean()
    k4_means_z = k4_means.copy()
    for c in AIRS16_CONSTRUCTS:
        k4_means_z[c] = (k4_means[c] - pop_means[c]) / pop_stds[c]

    print("\n  k=4 z-scored profiles:")
    print(k4_means_z.round(3).to_string())

    k4_defensible = sil_k4 >= 0.25 and k4_sizes.min() >= 50
    print(f"\n  k=4 defensible: {k4_defensible} (sil≥0.25={sil_k4 >= 0.25}, min_n≥50={k4_sizes.min() >= 50})")

    # ── Predictive Validation ─────────────────────────────────────────────
    print(f"\n" + "=" * 90)
    print("PREDICTIVE VALIDATION")
    print("=" * 90)

    # ANOVA: BI by cluster
    groups = [df[df['Cluster'] == c]['BI'].values for c in range(SELECTED_K)]
    f_stat, p_value = scipy_stats.f_oneway(*groups)
    # Eta squared
    grand_mean = df['BI'].mean()
    ss_between = sum(len(g) * (g.mean() - grand_mean)**2 for g in groups)
    ss_total = sum((df['BI'] - grand_mean)**2)
    eta_squared = ss_between / ss_total

    effect_interp = 'large' if eta_squared > 0.14 else ('medium' if eta_squared > 0.06 else 'small')
    print(f"  ANOVA: F = {f_stat:.2f}, p = {p_value:.6f}")
    print(f"  η² = {eta_squared:.3f} ({effect_interp})")

    # Regression: AIRS-16 → BI
    X_reg = df[AIRS16_CONSTRUCTS]
    y_reg = df['BI']
    reg_model = LinearRegression()
    reg_model.fit(X_reg, y_reg)
    r2 = reg_model.score(X_reg, y_reg)

    # Cross-validated R²
    cv_scores = cross_val_score(LinearRegression(), X_reg, y_reg, cv=5, scoring='r2')
    print(f"  Regression R² = {r2:.3f}")
    print(f"  5-fold CV R² = {cv_scores.mean():.3f} (±{cv_scores.std():.3f})")

    # Cluster-based R²
    df['BI_pred_cluster'] = df['Cluster'].map(df.groupby('Cluster')['BI'].mean())
    ss_res_cluster = sum((df['BI'] - df['BI_pred_cluster'])**2)
    r2_cluster = 1 - ss_res_cluster / ss_total
    print(f"  Cluster-based R² = {r2_cluster:.3f}")

    # ── Population Parameters ─────────────────────────────────────────────
    POP_PARAMS = {
        'means': pop_means.to_dict(),
        'stds': pop_stds.to_dict()
    }

    # ── Store Centroids ───────────────────────────────────────────────────
    CENTROIDS = {}
    for cluster_id in range(SELECTED_K):
        mask = df['Cluster'] == cluster_id
        CENTROIDS[CLUSTER_NAMES[cluster_id]] = {
            'cluster_id': cluster_id,
            'z_scores': cluster_means_z.loc[cluster_id].to_dict(),
            'raw_means': cluster_means_raw.loc[cluster_id].to_dict(),
            'expected_BI': float(df.loc[mask, 'BI'].mean()),
            'n': int(mask.sum()),
            'pct': float(mask.sum() / len(df) * 100)
        }

    # ── Classification Function Validation ────────────────────────────────
    def classify_airs16_typology(scores_dict):
        """Classify a respondent using stored centroids."""
        z_scores = {c: (scores_dict[c] - POP_PARAMS['means'][c]) / POP_PARAMS['stds'][c]
                    for c in AIRS16_CONSTRUCTS}
        distances = {}
        for name, data in CENTROIDS.items():
            dist = np.sqrt(sum((z_scores[c] - data['z_scores'][c])**2 for c in AIRS16_CONSTRUCTS))
            distances[name] = dist
        nearest = min(distances, key=distances.get)
        min_dist = distances[nearest]
        return nearest, 1 / (1 + min_dist)

    # Validate: reclassify all respondents
    correct = 0
    for idx, row in df.iterrows():
        scores = {c: row[c] for c in AIRS16_CONSTRUCTS}
        predicted, conf = classify_airs16_typology(scores)
        if predicted == row['Typology']:
            correct += 1
    agreement = correct / len(df)
    print(f"\n  Classification validation: {agreement * 100:.1f}% agreement")

    # ── Success Criteria ──────────────────────────────────────────────────
    print(f"\n" + "=" * 90)
    print("SUCCESS CRITERIA")
    print("=" * 90)
    print(f"  Silhouette > 0.25: {'PASS' if final_silhouette > 0.25 else 'FAIL'} ({final_silhouette:.3f})")
    print(f"  BI η² > 0.14: {'PASS' if eta_squared > 0.14 else 'FAIL'} ({eta_squared:.3f})")
    print(f"  Regression R² > 0.40: {'PASS' if r2 > 0.40 else 'FAIL'} ({r2:.3f})")

    # ── Export ────────────────────────────────────────────────────────────
    print(f"\n" + "=" * 90)
    print("EXPORTING RESULTS")
    print("=" * 90)

    results = {
        'metadata': {
            'notebook': '11_Practitioner_Typology',
            'date': pd.Timestamp.now().isoformat(),
            'n_samples': len(df),
            'constructs_used': AIRS16_CONSTRUCTS,
            'outcome_variable': OUTCOME
        },
        'clustering': {
            'n_clusters': SELECTED_K,
            'silhouette_score': float(final_silhouette),
            'cluster_sizes': {int(k): int(v) for k, v in sizes.items()}
        },
        'k4_alternative': {
            'n_clusters': K_ALT,
            'silhouette_score': float(sil_k4),
            'cluster_sizes': {int(k): int(v) for k, v in k4_sizes.items()},
            'defensible': bool(k4_defensible),
            'centroids_z': k4_means_z.round(3).to_dict()
        },
        'validation': {
            'bi_anova_f': float(f_stat),
            'bi_anova_p': float(p_value),
            'bi_eta_squared': float(eta_squared),
            'regression_r2': float(r2),
            'regression_cv_r2': float(cv_scores.mean()),
            'cluster_r2': float(r2_cluster)
        },
        'population_parameters': POP_PARAMS,
        'centroids': CENTROIDS,
        'cluster_names': CLUSTER_NAMES
    }

    results_path = Path('results/phase11_practitioner_typology_results.json')
    results_path.parent.mkdir(parents=True, exist_ok=True)
    with open(results_path, 'w') as f:
        json.dump(results, f, indent=2, default=str)
    print(f"✓ {results_path}")

    # ── Final Summary ─────────────────────────────────────────────────────
    print(f"\n" + "=" * 90)
    print("✓ PHASE 11: PRACTITIONER TYPOLOGY COMPLETE")
    print("=" * 90)
    print(f"  k=3 silhouette: {final_silhouette:.3f}")
    print(f"  k=4 silhouette: {sil_k4:.3f} (defensible: {k4_defensible})")
    for name, data in CENTROIDS.items():
        print(f"  {name}: n={data['n']} ({data['pct']:.1f}%), BI={data['expected_BI']:.2f}")


if __name__ == '__main__':
    main()
