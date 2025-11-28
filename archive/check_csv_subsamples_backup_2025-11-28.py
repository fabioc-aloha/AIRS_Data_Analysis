import pandas as pd

# Check all three CSV files
files = ['data/AIRS_clean.csv', 'data/AIRS_clean_dev.csv', 'data/AIRS_clean_holdout.csv']

for file in files:
    df = pd.read_csv(file)
    print(f"\n{'='*70}")
    print(f"{file}")
    print(f"{'='*70}")
    print(f"Total N = {len(df)}")
    print(f"\nWork_Context distribution:")
    print(df['Work_Context'].value_counts())
    print(f"\nAI_Adoption distribution:")
    print(df['AI_Adoption'].value_counts())
