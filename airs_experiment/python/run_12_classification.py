#!/usr/bin/env python3
"""
Phase 12: Simplified Classification System
Standalone script refactored from 12_Simplified_Classification.ipynb

Three classification methods:
  Method 1 — Cut-point classification (ARI sum-based)
  Method 2 — Decision tree (max_depth=3)
  Method 3 — Simplified top-3 constructs
Plus practitioner guide with classify_airs16_simple().
"""

import json
import warnings
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from scipy import optimize, stats
from sklearn.cluster import KMeans
from sklearn.metrics import accuracy_score, confusion_matrix, classification_report
from sklearn.model_selection import cross_val_score
from sklearn.preprocessing import StandardScaler
from sklearn.tree import DecisionTreeClassifier, plot_tree, export_text
from sklearn.linear_model import LinearRegression
import seaborn as sns

warnings.filterwarnings('ignore')

# ── Configuration ──────────────────────────────────────────────────────────────

AIRS16_CONSTRUCTS = ['PE', 'EE', 'SI', 'FC', 'HM', 'PV', 'HB', 'TR']
CONSTRUCT_ITEMS = {
    'PE': ['PE1', 'PE2'], 'EE': ['EE1', 'EE2'], 'SI': ['SI1', 'SI2'],
    'FC': ['FC1', 'FC2'], 'HM': ['HM1', 'HM2'], 'PV': ['PV1', 'PV2'],
    'HB': ['HB1', 'HB2'], 'TR': ['TR1', 'TR2'],
}
BI_ITEMS = ['BI1', 'BI2', 'BI3', 'BI4']
CLUSTER_NAMES = {0: 'Moderate Users', 1: 'AI Skeptics', 2: 'AI Enthusiasts'}


# ── Helpers ────────────────────────────────────────────────────────────────────

def classify_by_cutpoints(ari, low_cut, high_cut):
    if ari <= low_cut:
        return 'AI Skeptics'
    if ari >= high_cut:
        return 'AI Enthusiasts'
    return 'Moderate Users'


def classify_airs16_simple(pe, ee, si, fc, hm, pv, hb, tr,
                           low_threshold=21.13, high_threshold=30.75):
    """Practitioner-facing classification function."""
    ari = pe + ee + si + fc + hm + pv + hb + tr
    if ari <= low_threshold:
        return 'AI Skeptics', ari
    if ari >= high_threshold:
        return 'AI Enthusiasts', ari
    return 'Moderate Users', ari


# ── Main ───────────────────────────────────────────────────────────────────────

def main():
    Path('results').mkdir(exist_ok=True)
    Path('plots').mkdir(exist_ok=True)

    # ── Load data ──────────────────────────────────────────────────────────
    df = pd.read_csv('data/AIRS_clean.csv')
    print(f"Loaded AIRS_clean.csv: N={len(df)}")

    # Load NB11 results
    nb11_path = Path('results/phase11_practitioner_typology_results.json')
    nb11 = {}
    if nb11_path.exists():
        with open(nb11_path) as f:
            nb11 = json.load(f)
        print(f"✓ Loaded NB11 results: {nb11_path}")
    else:
        print("⚠ NB11 results not found; will compute from scratch")

    # Compute construct scores
    for name, items in CONSTRUCT_ITEMS.items():
        df[name] = df[items].mean(axis=1)
    df['BI'] = df[[c for c in BI_ITEMS if c in df.columns]].mean(axis=1)

    # ── Recreate K-means k=3 as ground truth ───────────────────────────────
    print("\n" + "=" * 70)
    print("RECREATING K-MEANS k=3 GROUND TRUTH")
    print("=" * 70)

    X = df[AIRS16_CONSTRUCTS].dropna()
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)
    kmeans = KMeans(n_clusters=3, random_state=67, n_init=10)
    labels = kmeans.fit_predict(X_scaled)
    df.loc[X.index, 'Cluster'] = labels

    # Map cluster labels to names
    cluster_bi_means = df.loc[X.index].groupby('Cluster')['BI'].mean()
    sorted_clusters = cluster_bi_means.sort_values()
    name_map = {}
    name_map[sorted_clusters.index[0]] = 'AI Skeptics'
    name_map[sorted_clusters.index[1]] = 'Moderate Users'
    name_map[sorted_clusters.index[2]] = 'AI Enthusiasts'
    df['ClusterName'] = df['Cluster'].map(name_map)

    for cname in ['AI Skeptics', 'Moderate Users', 'AI Enthusiasts']:
        n = (df['ClusterName'] == cname).sum()
        bi = df[df['ClusterName'] == cname]['BI'].mean()
        print(f"  {cname}: n={n}, BI mean={bi:.3f}")

    # ── Compute BI statistics needed across methods ────────────────────────
    grand_mean = df['BI'].mean()
    ss_total = ((df['BI'] - grand_mean) ** 2).sum()

    # NB11 eta for comparison
    nb11_eta = None
    if nb11:
        nb11_eta = nb11.get('cluster_validation', {}).get('eta_squared')
        if nb11_eta is None:
            nb11_eta = nb11.get('eta_squared')
    if nb11_eta is not None:
        print(f"\n  NB11 η² = {nb11_eta:.4f}")

    # ══════════════════════════════════════════════════════════════════════════
    # Method 1: Cut-Point Classification
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("METHOD 1: CUT-POINT CLASSIFICATION")
    print("=" * 70)

    df['ARI_Sum'] = df[AIRS16_CONSTRUCTS].sum(axis=1)

    # Weighted ARI
    reg = LinearRegression()
    X_reg = df[AIRS16_CONSTRUCTS].dropna()
    y_reg = df.loc[X_reg.index, 'BI']
    reg.fit(X_reg, y_reg)
    weights = np.maximum(reg.coef_, 0)
    weights = weights / weights.sum() if weights.sum() > 0 else np.ones(len(AIRS16_CONSTRUCTS)) / len(AIRS16_CONSTRUCTS)
    df['ARI_Weighted'] = (df[AIRS16_CONSTRUCTS].values * weights).sum(axis=1)

    # BI correlation
    ari_bi_corr, ari_bi_p = stats.pearsonr(df['ARI_Sum'].dropna(), df.loc[df['ARI_Sum'].notna(), 'BI'])
    print(f"  ARI_Sum × BI: r={ari_bi_corr:.3f}, p={ari_bi_p:.4f}")

    # Tertile cuts
    p33 = df['ARI_Sum'].quantile(0.333)
    p67 = df['ARI_Sum'].quantile(0.667)
    print(f"  Tertile cuts: p33={p33:.2f}, p67={p67:.2f}")

    # Optimize cuts
    def objective(cuts):
        low, high = sorted(cuts)
        preds = df['ARI_Sum'].apply(lambda x: classify_by_cutpoints(x, low, high))
        return 1 - accuracy_score(df['ClusterName'], preds)

    result = optimize.minimize(objective, [p33, p67], method='Nelder-Mead')
    opt_low, opt_high = sorted(result.x)
    print(f"  Optimized cuts: {opt_low:.2f}, {opt_high:.2f}")

    # Practical thresholds
    practical_low, practical_high = 20.0, 30.0
    df['CutPoint_Pred'] = df['ARI_Sum'].apply(lambda x: classify_by_cutpoints(x, practical_low, practical_high))
    cut_acc = accuracy_score(df['ClusterName'], df['CutPoint_Pred'])
    print(f"  Practical cuts (20/30): accuracy={cut_acc:.3f}")

    # Eta-squared for cut-point
    cut_groups = df.groupby('CutPoint_Pred')['BI']
    ss_between_cut = sum(len(g) * (g.mean() - grand_mean) ** 2 for _, g in cut_groups)
    eta_sq_cut = ss_between_cut / ss_total if ss_total > 0 else 0
    print(f"  Cut-point η² = {eta_sq_cut:.4f}")

    # ARI × BI scatter
    fig, ax = plt.subplots(figsize=(10, 6))
    for cname in ['AI Skeptics', 'Moderate Users', 'AI Enthusiasts']:
        mask = df['ClusterName'] == cname
        ax.scatter(df.loc[mask, 'ARI_Sum'], df.loc[mask, 'BI'], alpha=0.4, s=20, label=cname)
    ax.axvline(x=practical_low, color='red', linestyle='--', label=f'Low cut={practical_low}')
    ax.axvline(x=practical_high, color='green', linestyle='--', label=f'High cut={practical_high}')
    ax.set_xlabel('ARI Sum Score')
    ax.set_ylabel('Behavioral Intention')
    ax.set_title('ARI Sum vs BI with K-means Ground Truth')
    ax.legend(fontsize=8)
    plt.tight_layout()
    plt.savefig('plots/12_00_ari_bi_correlation.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Saved plots/12_00_ari_bi_correlation.png")

    # Cut-point classification plot
    fig, ax = plt.subplots(figsize=(10, 6))
    for cname in ['AI Skeptics', 'Moderate Users', 'AI Enthusiasts']:
        mask = df['CutPoint_Pred'] == cname
        ax.scatter(df.loc[mask, 'ARI_Sum'], df.loc[mask, 'BI'], alpha=0.4, s=20, label=cname)
    ax.axvline(x=practical_low, color='red', linestyle='--')
    ax.axvline(x=practical_high, color='green', linestyle='--')
    ax.set_xlabel('ARI Sum Score')
    ax.set_ylabel('Behavioral Intention')
    ax.set_title(f'Cut-Point Classification (Accuracy={cut_acc:.1%})')
    ax.legend(fontsize=8)
    plt.tight_layout()
    plt.savefig('plots/12_01_cutpoint_classification.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Saved plots/12_01_cutpoint_classification.png")

    # Cut-point with BI prediction
    fig, ax = plt.subplots(figsize=(10, 6))
    bi_lookup = {}
    for cname in ['AI Skeptics', 'Moderate Users', 'AI Enthusiasts']:
        mask = df['ClusterName'] == cname
        bi_lookup[cname] = float(df.loc[mask, 'BI'].mean())
    df['BI_Predicted'] = df['CutPoint_Pred'].map(bi_lookup)
    ax.scatter(df['BI'], df['BI_Predicted'], alpha=0.3, s=15)
    ax.plot([1, 5], [1, 5], 'r--', linewidth=1)
    ax.set_xlabel('Actual BI')
    ax.set_ylabel('Predicted BI (from cluster mean)')
    ax.set_title('Cut-Point BI Prediction')
    plt.tight_layout()
    plt.savefig('plots/12_01b_cutpoint_with_bi.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Saved plots/12_01b_cutpoint_with_bi.png")

    # ══════════════════════════════════════════════════════════════════════════
    # Method 2: Decision Tree
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("METHOD 2: DECISION TREE")
    print("=" * 70)

    X_tree = df[AIRS16_CONSTRUCTS].dropna()
    y_tree = df.loc[X_tree.index, 'ClusterName']
    dt = DecisionTreeClassifier(max_depth=3, min_samples_leaf=20, random_state=67)
    dt.fit(X_tree, y_tree)

    tree_acc = dt.score(X_tree, y_tree)
    cv_scores = cross_val_score(dt, X_tree, y_tree, cv=5)
    print(f"  Training accuracy: {tree_acc:.3f}")
    print(f"  5-fold CV: {cv_scores.mean():.3f} ± {cv_scores.std():.3f}")

    # Feature importance
    feat_imp = pd.Series(dt.feature_importances_, index=AIRS16_CONSTRUCTS).sort_values(ascending=False)
    key_constructs = feat_imp[feat_imp > 0.1].index.tolist()
    print(f"  Key constructs (importance>0.1): {key_constructs}")

    # Decision rules
    rules_text = export_text(dt, feature_names=AIRS16_CONSTRUCTS, max_depth=3)
    print(f"\n  Decision Rules:\n{rules_text}")

    # Eta-squared for decision tree
    df['Tree_Pred'] = dt.predict(df[AIRS16_CONSTRUCTS].fillna(df[AIRS16_CONSTRUCTS].mean()))
    tree_groups = df.groupby('Tree_Pred')['BI']
    ss_between_tree = sum(len(g) * (g.mean() - grand_mean) ** 2 for _, g in tree_groups)
    eta_sq_tree = ss_between_tree / ss_total if ss_total > 0 else 0
    print(f"  Decision tree η² = {eta_sq_tree:.4f}")

    # Tree visualization
    fig, ax = plt.subplots(figsize=(16, 8))
    plot_tree(dt, feature_names=AIRS16_CONSTRUCTS,
              class_names=['AI Enthusiasts', 'AI Skeptics', 'Moderate Users'],
              filled=True, rounded=True, ax=ax, fontsize=8)
    ax.set_title('Decision Tree Classification (max_depth=3)')
    plt.tight_layout()
    plt.savefig('plots/12_02_decision_tree.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Saved plots/12_02_decision_tree.png")

    # ══════════════════════════════════════════════════════════════════════════
    # Method 3: Simplified (Top-3 Constructs)
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("METHOD 3: SIMPLIFIED (TOP-3 CONSTRUCTS)")
    print("=" * 70)

    # Combined ranking from tree importance + regression weights + BI correlations
    tree_rank = feat_imp.rank(ascending=False)
    reg_rank = pd.Series(weights, index=AIRS16_CONSTRUCTS).rank(ascending=False)
    corr_rank = pd.Series(
        {c: abs(stats.pearsonr(df[c].dropna(), df.loc[df[c].notna(), 'BI'])[0])
         for c in AIRS16_CONSTRUCTS}
    ).rank(ascending=False)
    avg_rank = (tree_rank + reg_rank + corr_rank) / 3
    top_constructs = avg_rank.nsmallest(3).index.tolist()
    print(f"  Top 3 constructs: {top_constructs}")

    df['ARI_Simple'] = df[top_constructs].sum(axis=1)

    # Optimize cuts for simplified
    def objective_simple(cuts):
        low, high = sorted(cuts)
        preds = df['ARI_Simple'].apply(lambda x: classify_by_cutpoints(x, low, high))
        return 1 - accuracy_score(df['ClusterName'], preds)

    sp33 = df['ARI_Simple'].quantile(0.333)
    sp67 = df['ARI_Simple'].quantile(0.667)
    result_simple = optimize.minimize(objective_simple, [sp33, sp67], method='Nelder-Mead')
    simp_low, simp_high = sorted(result_simple.x)
    df['Simple_Pred'] = df['ARI_Simple'].apply(lambda x: classify_by_cutpoints(x, simp_low, simp_high))
    simple_acc = accuracy_score(df['ClusterName'], df['Simple_Pred'])
    print(f"  Simplified cuts: {simp_low:.2f}, {simp_high:.2f}")
    print(f"  Simplified accuracy: {simple_acc:.3f}")

    # Eta-squared for simplified
    simple_groups = df.groupby('Simple_Pred')['BI']
    ss_between_simple = sum(len(g) * (g.mean() - grand_mean) ** 2 for _, g in simple_groups)
    eta_sq_simple = ss_between_simple / ss_total if ss_total > 0 else 0
    print(f"  Simplified η² = {eta_sq_simple:.4f}")

    # ══════════════════════════════════════════════════════════════════════════
    # Method Comparison
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("METHOD COMPARISON")
    print("=" * 70)

    comparison = pd.DataFrame({
        'Method': ['K-means (ground truth)', 'Cut-Point (8 constructs)',
                   'Decision Tree', 'Simplified (3 constructs)'],
        'Accuracy': [1.0, cut_acc, tree_acc, simple_acc],
        'Eta_Sq': [float(nb11_eta) if nb11_eta else np.nan, eta_sq_cut, eta_sq_tree, eta_sq_simple],
        'Constructs': [8, 8, len(key_constructs), 3],
        'Complexity': ['High', 'Low', 'Medium', 'Very Low'],
    })
    print(comparison.to_string(index=False))

    # Comparison plot
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))
    methods = comparison['Method']
    x = np.arange(len(methods))
    ax1.bar(x, comparison['Accuracy'], color=['#2e7d32', '#1976d2', '#f57c00', '#9c27b0'])
    ax1.set_xticks(x)
    ax1.set_xticklabels(methods, rotation=30, ha='right', fontsize=8)
    ax1.set_ylabel('Accuracy')
    ax1.set_title('Classification Accuracy')
    ax1.set_ylim(0, 1.1)

    eta_vals = comparison['Eta_Sq'].fillna(0)
    ax2.bar(x, eta_vals, color=['#2e7d32', '#1976d2', '#f57c00', '#9c27b0'])
    ax2.set_xticks(x)
    ax2.set_xticklabels(methods, rotation=30, ha='right', fontsize=8)
    ax2.set_ylabel('η²')
    ax2.set_title('Effect Size (η²)')
    plt.tight_layout()
    plt.savefig('plots/12_03_method_comparison.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Saved plots/12_03_method_comparison.png")

    # Confusion matrices
    fig, axes = plt.subplots(1, 3, figsize=(18, 5))
    for ax, (pred_col, title) in zip(axes, [
        ('CutPoint_Pred', 'Cut-Point'), ('Tree_Pred', 'Decision Tree'), ('Simple_Pred', 'Simplified')
    ]):
        labels_order = ['AI Skeptics', 'Moderate Users', 'AI Enthusiasts']
        cm = confusion_matrix(df['ClusterName'], df[pred_col], labels=labels_order)
        sns.heatmap(cm, annot=True, fmt='d', ax=ax, cmap='Blues',
                    xticklabels=labels_order, yticklabels=labels_order)
        ax.set_title(title)
        ax.set_xlabel('Predicted')
        ax.set_ylabel('Actual')
    plt.tight_layout()
    plt.savefig('plots/12_04_confusion_matrices.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Saved plots/12_04_confusion_matrices.png")

    # ══════════════════════════════════════════════════════════════════════════
    # Practitioner Guide
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("PRACTITIONER GUIDE: classify_airs16_simple()")
    print("=" * 70)

    test_cases = [
        (4.5, 4.0, 3.5, 4.0, 4.5, 4.0, 4.0, 4.5),
        (2.0, 2.5, 2.0, 2.5, 1.5, 2.0, 1.5, 2.0),
        (3.5, 3.0, 3.0, 3.5, 3.0, 3.5, 3.0, 3.5),
    ]
    for tc in test_cases:
        result, ari = classify_airs16_simple(*tc)
        print(f"  Input means: {tc} → ARI={ari:.2f} → {result}")

    # ══════════════════════════════════════════════════════════════════════════
    # Export
    # ══════════════════════════════════════════════════════════════════════════
    print("\n" + "=" * 70)
    print("EXPORT")
    print("=" * 70)

    output = {
        'metadata': {
            'n': int(len(df)),
            'constructs': AIRS16_CONSTRUCTS,
            'ground_truth': 'K-means k=3',
        },
        'cutpoint_method': {
            'ari_bi_correlation': float(ari_bi_corr),
            'practical_thresholds': {'low': practical_low, 'high': practical_high},
            'optimized_thresholds': {'low': float(opt_low), 'high': float(opt_high)},
            'accuracy': float(cut_acc),
            'eta_squared': float(eta_sq_cut),
        },
        'decision_tree_method': {
            'max_depth': 3,
            'training_accuracy': float(tree_acc),
            'cv_mean': float(cv_scores.mean()),
            'cv_std': float(cv_scores.std()),
            'key_constructs': key_constructs,
            'feature_importance': {k: float(v) for k, v in feat_imp.items()},
            'eta_squared': float(eta_sq_tree),
        },
        'simplified_method': {
            'top_constructs': top_constructs,
            'thresholds': {'low': float(simp_low), 'high': float(simp_high)},
            'accuracy': float(simple_acc),
            'eta_squared': float(eta_sq_simple),
        },
        'recommendation': 'Cut-point method (8 constructs, practical 20/30) offers best balance of accuracy and simplicity',
        'bi_lookup': bi_lookup,
    }

    out_path = Path('results/phase12_simplified_classification_results.json')
    with open(out_path, 'w') as f:
        json.dump(output, f, indent=2, default=str)
    print(f"✓ Saved {out_path}")

    print("\n✓ Phase 12 complete.")


if __name__ == '__main__':
    main()
