"""
EFA Item Reduction Analysis
============================
Run EFA on all three populations to identify items to drop based on:
1. Low communalities (<0.40)
2. High cross-loadings (>0.32 on multiple factors)
3. Items that don't load on expected factors

Author: Alex/Fabio
Date: 2025-11-27
"""

import pandas as pd
import numpy as np
import json
from pathlib import Path
from factor_analyzer import FactorAnalyzer, calculate_kmo, calculate_bartlett_sphericity
import warnings
warnings.filterwarnings('ignore')

# Configuration
RANDOM_SEED = 67
np.random.seed(RANDOM_SEED)

# Thresholds
COMM_THRESHOLD = 0.40  # Minimum communality
PRIMARY_LOADING = 0.50  # Minimum primary loading
CROSS_LOADING = 0.32    # Maximum acceptable cross-loading

print("="*80)
print("EFA ITEM REDUCTION ANALYSIS - ALL POPULATIONS")
print("="*80)

# Load metadata
with open('data/airs_28item_complete.json', 'r', encoding='utf-8') as f:
    item_metadata = json.load(f)

predictor_items = item_metadata['predictor_items']
constructs = item_metadata['constructs']
metadata = item_metadata['metadata']

print(f"\nAnalyzing {len(predictor_items)} predictor items across 3 populations")
print(f"Thresholds: Communality ≥ {COMM_THRESHOLD}, Primary ≥ {PRIMARY_LOADING}, Cross-loading ≤ {CROSS_LOADING}")

# Expected construct mapping for each item
item_to_construct = {item: metadata[item]['construct_abbr'] for item in predictor_items}

# Store results for all populations
all_results = {}

populations = ['academic', 'professional', 'leader']

for pop in populations:
    print(f"\n{'='*80}")
    print(f"POPULATION: {pop.upper()}")
    print(f"{'='*80}")
    
    # Load data
    df = pd.read_csv(f'airs_{pop}/data/AIRS_dev.csv')
    df_efa = df[predictor_items].copy()
    
    print(f"Sample size: N = {len(df_efa)}")
    print(f"Cases per item: {len(df_efa)/len(predictor_items):.1f}")
    
    # Check factorability
    kmo_all, kmo_per_item = calculate_kmo(df_efa)
    chi2, p_value = calculate_bartlett_sphericity(df_efa)
    
    print(f"\nFactorability:")
    print(f"  KMO: {kmo_all:.3f} {'✓' if kmo_all >= 0.60 else '⚠️'}")
    print(f"  Bartlett's p: {p_value:.2e} {'✓' if p_value < 0.05 else '⚠️'}")
    
    # Determine number of factors using parallel analysis
    fa_temp = FactorAnalyzer(n_factors=12, rotation=None, method='minres')
    fa_temp.fit(df_efa)
    eigenvalues = fa_temp.get_eigenvalues()[0]
    
    # Simple rule: eigenvalues > 1
    n_factors_kaiser = sum(eigenvalues > 1)
    print(f"\nFactor extraction:")
    print(f"  Eigenvalues > 1: {n_factors_kaiser} factors")
    print(f"  First 6 eigenvalues: {eigenvalues[:6].round(2)}")
    
    # Use 4 factors as a reasonable starting point for AIRS
    # (based on theoretical groupings: UTAUT core, AI-specific positive, AI-specific negative, etc.)
    n_factors = min(n_factors_kaiser, 6)  # Cap at 6 for interpretability
    if n_factors < 3:
        n_factors = 3  # Minimum 3 factors
    
    print(f"  Using {n_factors} factors for analysis")
    
    # Run EFA with promax rotation (oblique - allows correlated factors)
    efa = FactorAnalyzer(n_factors=n_factors, rotation='promax', method='minres')
    efa.fit(df_efa)
    
    # Get results
    loadings = pd.DataFrame(
        efa.loadings_,
        index=predictor_items,
        columns=[f'F{i+1}' for i in range(n_factors)]
    )
    
    communalities = pd.Series(efa.get_communalities(), index=predictor_items)
    
    # Analyze each item
    item_issues = []
    
    for item in predictor_items:
        item_loadings = loadings.loc[item].abs()
        primary_idx = item_loadings.idxmax()
        primary_loading = item_loadings[primary_idx]
        
        # Check for cross-loadings
        other_loadings = item_loadings.drop(primary_idx)
        max_cross = other_loadings.max()
        
        # Identify issues
        issues = []
        
        # 1. Low communality
        if communalities[item] < COMM_THRESHOLD:
            issues.append(f"Low comm ({communalities[item]:.2f})")
        
        # 2. Low primary loading
        if primary_loading < PRIMARY_LOADING:
            issues.append(f"Low primary ({primary_loading:.2f})")
        
        # 3. High cross-loading
        if max_cross >= CROSS_LOADING:
            cross_factor = other_loadings.idxmax()
            issues.append(f"Cross-load on {cross_factor} ({max_cross:.2f})")
        
        # 4. Check if expected construct matches primary factor (need to map)
        expected = item_to_construct[item]
        
        item_issues.append({
            'Item': item,
            'Construct': expected,
            'Communality': communalities[item],
            'Primary_Factor': primary_idx,
            'Primary_Loading': primary_loading,
            'Max_Cross': max_cross,
            'Issues': '; '.join(issues) if issues else 'OK',
            'Drop': len(issues) > 0
        })
    
    results_df = pd.DataFrame(item_issues)
    all_results[pop] = results_df
    
    # Print summary
    print(f"\n--- Item Quality Summary ---")
    drop_items = results_df[results_df['Drop'] == True]
    ok_items = results_df[results_df['Drop'] == False]
    
    print(f"✓ OK items: {len(ok_items)}")
    print(f"⚠️ Problematic items: {len(drop_items)}")
    
    if len(drop_items) > 0:
        print(f"\nItems with issues:")
        for _, row in drop_items.iterrows():
            print(f"  {row['Item']} ({row['Construct']}): {row['Issues']}")
    
    # Print factor loadings table
    print(f"\n--- Factor Loadings (sorted by primary factor) ---")
    loadings_display = loadings.copy()
    loadings_display['Comm'] = communalities
    loadings_display['Primary'] = loadings.abs().idxmax(axis=1)
    loadings_sorted = loadings_display.sort_values('Primary')
    print(loadings_sorted.round(3).to_string())

# Cross-population summary
print("\n" + "="*80)
print("CROSS-POPULATION ITEM REDUCTION SUMMARY")
print("="*80)

# Find items that are problematic in multiple populations
item_drop_counts = {}
for item in predictor_items:
    count = sum(all_results[pop].loc[all_results[pop]['Item'] == item, 'Drop'].values[0] 
                for pop in populations)
    item_drop_counts[item] = count

# Items to definitely drop (problematic in 2+ populations)
definitely_drop = [item for item, count in item_drop_counts.items() if count >= 2]

# Items to possibly drop (problematic in 1 population)
possibly_drop = [item for item, count in item_drop_counts.items() if count == 1]

# Items that are fine everywhere
fine_items = [item for item, count in item_drop_counts.items() if count == 0]

print(f"\n✓ Items OK in all populations: {len(fine_items)}")
for item in fine_items:
    print(f"   {item} ({item_to_construct[item]})")

print(f"\n⚠️ Items problematic in 1 population: {len(possibly_drop)}")
for item in possibly_drop:
    pop_with_issue = [pop for pop in populations 
                      if all_results[pop].loc[all_results[pop]['Item'] == item, 'Drop'].values[0]]
    print(f"   {item} ({item_to_construct[item]}): {pop_with_issue}")

print(f"\n❌ Items problematic in 2+ populations (RECOMMEND DROP): {len(definitely_drop)}")
for item in definitely_drop:
    pops_with_issue = [pop for pop in populations 
                       if all_results[pop].loc[all_results[pop]['Item'] == item, 'Drop'].values[0]]
    print(f"   {item} ({item_to_construct[item]}): {pops_with_issue}")

# Construct-level impact
print(f"\n--- Impact by Construct ---")
for construct in sorted(set(item_to_construct.values())):
    construct_items = [i for i in predictor_items if item_to_construct[i] == construct]
    items_to_drop = [i for i in construct_items if i in definitely_drop]
    items_remaining = [i for i in construct_items if i not in definitely_drop]
    
    status = "✓" if len(items_remaining) >= 1 else "⚠️ NO ITEMS LEFT"
    print(f"  {construct}: {len(items_remaining)}/{len(construct_items)} items remain {status}")
    if items_to_drop:
        print(f"       Drop: {items_to_drop}")

# Final recommendation
print("\n" + "="*80)
print("RECOMMENDATION")
print("="*80)
print(f"\nDrop these items: {definitely_drop}")
print(f"Review these items: {possibly_drop}")
print(f"Remaining items: {len(fine_items) + len(possibly_drop)}")

# Save results
results_summary = {
    'definitely_drop': definitely_drop,
    'possibly_drop': possibly_drop,
    'fine_items': fine_items,
    'item_drop_counts': item_drop_counts,
    'populations': {
        pop: all_results[pop].to_dict('records')
        for pop in populations
    }
}

with open('results/efa_item_reduction_summary.json', 'w') as f:
    json.dump(results_summary, f, indent=2)

print(f"\nResults saved to: results/efa_item_reduction_summary.json")
