"""Check available grouping variables for H4 moderation analysis"""
import pandas as pd
import os

# Load data
data_path = os.path.join("..", "data", "AIRS_clean.csv")
df = pd.read_csv(data_path)

print("=== Available Columns ===")
print(df.columns.tolist())

print("\n=== Sample Size ===")
print(f"Total N = {len(df)}")

print("\n=== Role Distribution ===")
if 'Role' in df.columns:
    print(df['Role'].value_counts())
    print(f"Minimum group size: {df['Role'].value_counts().min()}")
else:
    print("⚠️ Role column not found")

print("\n=== Business Unit Distribution ===")
if 'Business_Unit' in df.columns:
    print(df['Business_Unit'].value_counts())
    print(f"Minimum group size: {df['Business_Unit'].value_counts().min()}")
else:
    print("⚠️ Business_Unit column not found")

print("\n=== Usage Variables ===")
usage_cols = [c for c in df.columns if 'Usage' in c]
print(f"Usage columns: {usage_cols}")
if usage_cols:
    print("\nUsage descriptive statistics:")
    print(df[usage_cols].describe())
    
    # Create usage composite
    df['Usage_Composite'] = df[usage_cols].mean(axis=1)
    print(f"\nUsage Composite: M = {df['Usage_Composite'].mean():.2f}, SD = {df['Usage_Composite'].std():.2f}")
    
    # Create usage groups
    df['Usage_Group'] = pd.cut(df['Usage_Composite'], 
                                bins=[0, 2.0, 3.0, 6], 
                                labels=['Low', 'Medium', 'High'])
    print("\nUsage Group Distribution:")
    print(df['Usage_Group'].value_counts())
    print(f"Minimum group size: {df['Usage_Group'].value_counts().min()}")

print("\n=== Multi-Group SEM Feasibility ===")
print("Recommended minimum group size: n ≥ 50 per group for SEM")
print("Recommended ratio: smallest/largest < 5:1 for balanced comparison")
