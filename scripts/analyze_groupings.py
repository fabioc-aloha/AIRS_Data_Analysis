"""Quick analysis of demographic patterns for grouping suggestions"""
import pandas as pd

df = pd.read_csv('data/AIRS_clean.csv')

print("=" * 60)
print("DEMOGRAPHIC DISTRIBUTIONS")
print("=" * 60)

print("\n1. ROLE:")
print(df['Role'].value_counts().sort_index())

print("\n2. EDUCATION:")
print(df['Education'].value_counts().sort_index())

print("\n3. EXPERIENCE:")
print(df['Experience'].value_counts().sort_index())

print("\n4. INDUSTRY (Top 10):")
print(df['Industry'].value_counts().head(10))

print("\n5. DISABILITY:")
print(df['Disability'].value_counts())

print("\n" + "=" * 60)
print("AI USAGE PATTERNS")
print("=" * 60)

for col in ['Usage_MSCopilot', 'Usage_ChatGPT', 'Usage_Gemini', 'Usage_Other']:
    print(f"\n{col}:")
    print(df[col].value_counts().sort_index())

print("\n" + "=" * 60)
print("POTENTIAL GROUPING OPPORTUNITIES")
print("=" * 60)

print("\n1. Experience Groups:")
exp_mapping = {
    'Less than 1 year': 'Entry',
    '1-3 years': 'Early',
    '4-6 years': 'Mid',
    '7-10 years': 'Senior',
    'More than 10 years': 'Expert'
}
df['Experience_Group'] = df['Experience'].map(exp_mapping)
print(df['Experience_Group'].value_counts().sort_index())

print("\n2. Education Level Groups:")
edu_mapping = {
    'High School': 'Secondary',
    'Some College': 'Undergraduate',
    "Associate's Degree": 'Undergraduate',
    "Bachelor's Degree": 'Undergraduate',
    "Master's Degree": 'Graduate',
    'Doctoral Degree': 'Graduate',
    'Professional Degree': 'Graduate'
}
df['Education_Level'] = df['Education'].map(edu_mapping)
print(df['Education_Level'].value_counts().sort_index())

print("\n3. Role Type Groups:")
role_mapping = {
    'Student': 'Learning',
    'Instructor/Teacher': 'Teaching',
    'IT Professional': 'Technical',
    'Administrator': 'Leadership',
    'Researcher': 'Research',
    'Other': 'Other'
}
df['Role_Type'] = df['Role'].map(role_mapping)
print(df['Role_Type'].value_counts().sort_index())

print("\n4. Industry Category Groups:")
industry_categories = {
    'Technology': 'Tech',
    'Education': 'Education',
    'Healthcare': 'Healthcare',
    'Finance': 'Business',
    'Retail': 'Business',
    'Manufacturing': 'Business',
    'Government': 'Public',
    'Non-Profit': 'Public',
}
df['Industry_Category'] = df['Industry'].map(industry_categories).fillna('Other')
print(df['Industry_Category'].value_counts().sort_values(ascending=False))

print("\n5. Combined Work Context:")
# Student vs Working professional vs Teaching
def classify_context(row):
    if row['Role'] == 'Student':
        return 'Academic-Student'
    elif row['Role'] in ['Instructor/Teacher', 'Researcher']:
        return 'Academic-Faculty'
    else:
        return 'Professional'

df['Work_Context'] = df.apply(classify_context, axis=1)
print(df['Work_Context'].value_counts())

print("\n" + "=" * 60)
print("AI USAGE INTENSITY PATTERNS")
print("=" * 60)

# Calculate total AI usage score (sum of all usage frequencies)
usage_cols = ['Usage_MSCopilot', 'Usage_ChatGPT', 'Usage_Gemini', 'Usage_Other']
df['Total_Usage_Score'] = df[usage_cols].sum(axis=1)
print("\nTotal Usage Score Distribution:")
print(df['Total_Usage_Score'].describe())

# Categorize usage intensity
def classify_intensity(score):
    if score <= 4:  # All "Never" = 4
        return 'Non-User'
    elif score <= 8:  # Low usage
        return 'Low'
    elif score <= 12:  # Medium usage
        return 'Medium'
    else:  # High usage
        return 'High'

df['Usage_Intensity'] = df['Total_Usage_Score'].apply(classify_intensity)
print("\nUsage Intensity Groups:")
print(df['Usage_Intensity'].value_counts().sort_index())

print("\n" + "=" * 60)
print("CROSS-TABULATIONS FOR INSIGHTS")
print("=" * 60)

print("\n1. AI Adoption by Role:")
print(pd.crosstab(df['Role'], df['AI_Adoption'], normalize='index') * 100)

print("\n2. AI Adoption by Education Level:")
print(pd.crosstab(df['Education_Level'], df['AI_Adoption'], normalize='index') * 100)

print("\n3. AI Adoption by Experience:")
print(pd.crosstab(df['Experience_Group'], df['AI_Adoption'], normalize='index') * 100)
