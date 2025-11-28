import json

with open('data/airs_16item_selection.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

print("=== ALL 16 ITEMS FACTOR LOADINGS ===\n")
items_sorted = sorted(data['factor_loadings'].items(), 
                     key=lambda x: (x[1]['primary_factor'], -x[1]['max_loading']))

for item, info in items_sorted:
    f1 = info['factor1_loading']
    f2 = info['factor2_loading']
    primary = info['primary_factor']
    max_load = info['max_loading']
    print(f"{item:4s}: F1={f1:6.3f}, F2={f2:6.3f} | Primary={primary}, Max={max_load:.3f}")

print("\n=== ER1 SPECIFIC DETAILS ===")
er1 = data['factor_loadings']['ER1']
print(f"F1 loading: {er1['factor1_loading']:.3f}")
print(f"F2 loading: {er1['factor2_loading']:.3f}")
print(f"Primary factor: {er1['primary_factor']}")
print(f"Max loading: {er1['max_loading']:.3f}")
