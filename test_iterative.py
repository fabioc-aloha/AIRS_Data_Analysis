import pandas as pd
import numpy as np
import json
from factor_analyzer import FactorAnalyzer

# Load data
with open('data/airs_24item_complete.json', 'r', encoding='utf-8') as f:
    airs_24item_export = json.load(f)

df_dev = pd.read_csv('data/AIRS_clean_dev.csv')
all_items = airs_24item_export['items']
df_24items = df_dev[all_items].copy()

best_n_factors = 2
min_items = 15
min_items_per_factor = 3

current_items = all_items.copy()
reduction_history = []

print("Starting iterative reduction...")
print(f"Initial: {len(current_items)} items\n")

while len(current_items) > min_items:
    # Fit model
    df_current = df_24items[current_items].copy()
    fa_current = FactorAnalyzer(n_factors=best_n_factors, rotation='promax', method='minres')
    fa_current.fit(df_current)
    
    # Get loadings
    loadings_current = pd.DataFrame(
        fa_current.loadings_,
        index=current_items,
        columns=[f'F{i+1}' for i in range(best_n_factors)]
    )
    
    loadings_current['Primary_Factor'] = loadings_current.abs().idxmax(axis=1)
    loadings_current['Max_Loading'] = loadings_current[[f'F{i+1}' for i in range(best_n_factors)]].abs().max(axis=1)
    
    # Count items per factor
    factor_counts_current = loadings_current['Primary_Factor'].value_counts()
    
    # Find weakest item
    candidates = []
    for item_name, row in loadings_current.iterrows():
        primary_factor = row['Primary_Factor']
        max_loading = row['Max_Loading']
        factor_count = factor_counts_current.get(primary_factor, 0)
        
        if factor_count > min_items_per_factor:
            candidates.append({
                'item': item_name,
                'factor': primary_factor,
                'loading': max_loading
            })
    
    if not candidates:
        break
    
    # Remove weakest
    candidates_df = pd.DataFrame(candidates).sort_values('loading')
    item_to_remove = candidates_df.iloc[0]['item']
    removal_loading = candidates_df.iloc[0]['loading']
    removal_factor = candidates_df.iloc[0]['factor']
    
    print(f"Iteration {len(reduction_history)+1}: Remove {item_to_remove} (λ={removal_loading:.3f}, {removal_factor})")
    print(f"  Factor counts before: {dict(factor_counts_current)}")
    
    current_items.remove(item_to_remove)

print(f"\n{'='*60}")
print(f"FINAL: {len(current_items)} items selected")
print(f"{'='*60}")
print(f"Items: {sorted(current_items)}")

# Check final loadings
df_final = df_24items[current_items].copy()
fa_final = FactorAnalyzer(n_factors=best_n_factors, rotation='promax', method='minres')
fa_final.fit(df_final)

loadings_final = pd.DataFrame(
    fa_final.loadings_,
    index=current_items,
    columns=['F1', 'F2']
)
loadings_final['Primary'] = loadings_final.abs().idxmax(axis=1)
loadings_final['Max'] = loadings_final[['F1', 'F2']].abs().max(axis=1)

print("\nFinal loadings by factor:")
for factor in ['F1', 'F2']:
    items_f = loadings_final[loadings_final['Primary'] == factor]
    print(f"\n{factor} ({len(items_f)} items):")
    for item in items_f.index:
        print(f"  {item}: F1={loadings_final.loc[item, 'F1']:6.3f}, F2={loadings_final.loc[item, 'F2']:6.3f}, Max={loadings_final.loc[item, 'Max']:.3f}")
