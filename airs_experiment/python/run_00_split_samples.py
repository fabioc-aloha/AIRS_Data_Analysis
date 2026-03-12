#!/usr/bin/env python3
"""
AIRS Phase 0: Create Split Samples
Refactored from 00_Create_Split_Samples.ipynb

Loads raw survey data, transforms columns, creates stratified EFA/CFA split.
Outputs: data/AIRS_clean.csv, data/AIRS_experiment.csv, data/AIRS_holdout.csv,
         data/experiment_config.json, data/airs_28item_complete.json,
         data/sample_characteristics.json, plots/sample_preparation_overview.png
"""

import json
import warnings
from datetime import datetime
from pathlib import Path

import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split

warnings.filterwarnings('ignore')

# ═══════════════════════════════════════════════════════════════════════════════
# CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════════════

HOLDOUT_RATIO = 0.50
RANDOM_SEED = 67

ITEMS = [
    ('PE1', 'Performance Expectancy', 'POSITIVE'), ('PE2', 'Performance Expectancy', 'POSITIVE'),
    ('EE1', 'Effort Expectancy', 'POSITIVE'),      ('EE2', 'Effort Expectancy', 'POSITIVE'),
    ('SI1', 'Social Influence', 'POSITIVE'),       ('SI2', 'Social Influence', 'POSITIVE'),
    ('FC1', 'Facilitating Conditions', 'POSITIVE'),('FC2', 'Facilitating Conditions', 'POSITIVE'),
    ('HM1', 'Hedonic Motivation', 'POSITIVE'),     ('HM2', 'Hedonic Motivation', 'POSITIVE'),
    ('PV1', 'Price Value', 'POSITIVE'),            ('PV2', 'Price Value', 'POSITIVE'),
    ('HB1', 'Habit', 'POSITIVE'),                  ('HB2', 'Habit', 'POSITIVE'),
    ('VO1', 'Voluntariness', 'POSITIVE'),          ('VO2', 'Voluntariness', 'POSITIVE'),
    ('TR1', 'Trust in AI', 'POSITIVE'),            ('TR2', 'Trust in AI', 'POSITIVE'),
    ('EX1', 'Explainability', 'POSITIVE'),         ('EX2', 'Explainability', 'POSITIVE'),
    ('ER1', 'Perceived Ethical Risk', 'NEGATIVE'), ('ER2', 'Perceived Ethical Risk', 'NEGATIVE'),
    ('AX1', 'AI Anxiety', 'NEGATIVE'),             ('AX2', 'AI Anxiety', 'NEGATIVE'),
    ('BI1', 'Behavioral Intention', 'POSITIVE'),   ('BI2', 'Behavioral Intention', 'POSITIVE'),
    ('BI3', 'Behavioral Intention', 'POSITIVE'),   ('BI4', 'Behavioral Intention', 'POSITIVE'),
]

LIKERT_ITEMS = [code for code, _, _ in ITEMS]
PREDICTOR_ITEMS = [code for code, name, _ in ITEMS if not code.startswith('BI')]
OUTCOME_ITEMS = [code for code, name, _ in ITEMS if code.startswith('BI')]

THEORETICAL_DOMAINS = {
    'UTAUT2_Core': ['PE', 'EE', 'SI', 'FC', 'HM', 'PV', 'HB'],
    'AI_Specific': ['VO', 'TR', 'EX', 'ER', 'AX'],
    'Outcome': ['BI']
}

COLUMN_MAP = {
    'Duration (seconds)': 'Duration_seconds',
    'Performance Expectancy: How much do you agree with these statements about how AI tools help you get things done? | AI tools help me accomplish tasks more quickly': 'PE1',
    'Performance Expectancy: How much do you agree with these statements about how AI tools help you get things done? | Using AI improves the quality of my work or studies': 'PE2',
    'Effort Expectancy: How much do you agree with these statements about how easy AI tools are to learn and use? | Learning to use AI tools is easy for me': 'EE1',
    'Effort Expectancy: How much do you agree with these statements about how easy AI tools are to learn and use? | Interacting with AI tools is clear and understandable': 'EE2',
    'Social Influence: How much do you agree with these statements about the people around you and their views on using AI? | People whose opinions I value encourage me to use AI tools': 'SI1',
    'Social Influence: How much do you agree with these statements about the people around you and their views on using AI? | Leaders in my organization or school support the use of AI tools': 'SI2',
    'Facilitating Conditions: How much do you agree with these statements about the resources and support you have for using AI? | I have access to training or tutorials for the AI tools I use': 'FC1',
    'Facilitating Conditions: How much do you agree with these statements about the resources and support you have for using AI? | The AI tools I use are compatible with other tools or systems I use': 'FC2',
    'Hedonic Motivation (Perceived Enjoyment): How much do you agree with these statements about enjoyment when using AI tools? | Using AI tools is stimulating and engaging': 'HM1',
    'Hedonic Motivation (Perceived Enjoyment): How much do you agree with these statements about enjoyment when using AI tools? | AI tools make my work or studies more interesting': 'HM2',
    'Price Value: How much do you agree with these statements about whether using AI is worth your time and effort? | I get more value from AI tools than the effort they require': 'PV1',
    'Price Value: How much do you agree with these statements about whether using AI is worth your time and effort? | Using AI tools is worth the learning curve': 'PV2',
    'Habit: How much do you agree with these statements about your habits with AI tools? | Using AI tools has become a habit for me': 'HB1',
    'Habit: How much do you agree with these statements about your habits with AI tools? | I tend to rely on AI tools by default when I need help with tasks': 'HB2',
    'Voluntariness: How much do you agree with these statements about your freedom to choose whether or not to use AI tools? | I choose to use AI tools in my work because I find them helpful, not because I am required to': 'VO1',
    'Voluntariness: How much do you agree with these statements about your freedom to choose whether or not to use AI tools? | I could choose not to use AI tools in my work or studies if I preferred.': 'VO2',
    'Trust in AI: How much do you agree with these statements about trusting AI tools? | I trust AI tools to provide reliable information': 'TR1',
    'Trust in AI: How much do you agree with these statements about trusting AI tools? | I trust the AI tools that are available to me': 'TR2',
    'Explainability: How much do you agree with these statements about understanding how AI tools make their recommendations? | I understand how the AI tools I use generate their outputs': 'EX1',
    'Explainability: How much do you agree with these statements about understanding how AI tools make their recommendations? | I prefer AI tools that explain their recommendations': 'EX2',
    'Perceived Ethical Risk: How much do you agree with these statements about possible risks of AI? | I worry that AI tools could replace jobs in my field': 'ER1',
    'Perceived Ethical Risk: How much do you agree with these statements about possible risks of AI? | I am concerned about privacy risks when using AI tools': 'ER2',
    'AI Anxiety: How much do you agree with these statements about feeling uneasy or anxious about AI? | I feel uneasy about the increasing use of AI': 'AX1',
    'AI Anxiety: How much do you agree with these statements about feeling uneasy or anxious about AI? | I worry that I may be left behind if I do not keep up with AI': 'AX2',
    'AI Adoption Readiness: How much do you agree with these statements about your readiness to use AI? | I am ready to use more AI tools in my work or studies': 'BI1',
    'AI Adoption Readiness: How much do you agree with these statements about your readiness to use AI? | I would recommend AI tools to others': 'BI2',
    'AI Adoption Readiness: How much do you agree with these statements about your readiness to use AI? | I see AI as an important part of my future': 'BI3',
    'AI Adoption Readiness: How much do you agree with these statements about your readiness to use AI? | I plan to increase my use of AI tools in the next six months': 'BI4',
    'Usage Frequency: How often do you use the following AI tools? | Microsoft 365 Copilot or Microsoft Copilot': 'Usage_MSCopilot',
    'Usage Frequency: How often do you use the following AI tools? | ChatGPT': 'Usage_ChatGPT',
    'Usage Frequency: How often do you use the following AI tools? | Google Gemini': 'Usage_Gemini',
    'Usage Frequency: How often do you use the following AI tools? | Other AI tools (for example, Claude, Perplexity, Grok)': 'Usage_Other',
    'What is your current status?': 'Role',
    'What is your highest level of education completed?': 'Education',
    'Which industry or field best describes your primary area of work or study?': 'Industry',
    'How many years of work or study experience do you have in your field?': 'Experience',
    'Do you identify as a person with a disability (for example, vision, mobility, neurodivergence)?': 'Disability',
    'Do you have any other feedback about your experiences with AI tools or reasons for using or not using AI?': 'Open_Feedback'
}

ROLE_MAP = {
    'Full time student': 'FT_Student',
    'Part time student': 'PT_Student',
    'Employed - individual contributor': 'IC',
    'Employed - manager': 'Manager',
    'Employed - executive or leader': 'Executive',
    'Freelancer or self employed': 'Freelancer',
    'Not currently employed': 'Unemployed',
    'Other': 'Other'
}
LIKERT_MAP = {'Strongly disagree': 1, 'Disagree': 2, 'Neutral': 3, 'Agree': 4, 'Strongly agree': 5}
USAGE_MAP = {'Never': 1, 'Rarely': 2, 'Sometimes': 3, 'Often': 4, 'Daily': 5}
USAGE_ITEMS = ['Usage_MSCopilot', 'Usage_ChatGPT', 'Usage_Gemini', 'Usage_Other']


def main():
    print("=" * 90)
    print("PHASE 0: CREATE SPLIT SAMPLES")
    print("=" * 90)

    Path('data').mkdir(exist_ok=True)
    Path('plots').mkdir(exist_ok=True)

    print(f"\nAIRS Scale: {len(LIKERT_ITEMS)} items ({len(PREDICTOR_ITEMS)} predictors + {len(OUTCOME_ITEMS)} outcomes)")
    print(f"Split: {int((1-HOLDOUT_RATIO)*100)}% EFA / {int(HOLDOUT_RATIO*100)}% CFA")

    # ── Load & Transform ──────────────────────────────────────────────────
    df = pd.read_csv('../data/AIRS---AI-Readiness-Scale-labels.csv', skiprows=2, encoding='utf-8')
    df = df.rename(columns=COLUMN_MAP)
    df = df[[c for c in COLUMN_MAP.values() if c in df.columns]].copy()

    for col in LIKERT_ITEMS:
        if col in df.columns:
            df[col] = df[col].map(LIKERT_MAP)
    for col in USAGE_ITEMS:
        if col in df.columns:
            df[col] = df[col].map(USAGE_MAP)

    df['AI_Adoption'] = ((df[USAGE_ITEMS] > 1).any(axis=1)).astype(int)
    df['Role_Category'] = df['Role'].map(ROLE_MAP)
    if 'Duration_seconds' in df.columns:
        df['Duration_minutes'] = df['Duration_seconds'] / 60
        df = df.drop('Duration_seconds', axis=1)

    df.to_csv('data/AIRS_clean.csv', index=False, encoding='utf-8')
    print(f"\nLoaded N={len(df)} respondents")
    print(f"Role distribution:\n{df['Role_Category'].value_counts().to_string()}")

    # ── Stratified Split ──────────────────────────────────────────────────
    dev, holdout = train_test_split(
        df, test_size=HOLDOUT_RATIO, stratify=df['AI_Adoption'], random_state=RANDOM_SEED
    )
    dev.to_csv('data/AIRS_experiment.csv', index=False, encoding='utf-8')
    holdout.to_csv('data/AIRS_holdout.csv', index=False, encoding='utf-8')

    print(f"\nSplit complete: N={len(df)} -> EFA N={len(dev)}, CFA N={len(holdout)}")
    print(f"Adoption balance: EFA={dev['AI_Adoption'].mean()*100:.1f}%, CFA={holdout['AI_Adoption'].mean()*100:.1f}%")

    # ── Export Metadata ───────────────────────────────────────────────────
    construct_groups = {}
    for code, construct, _ in ITEMS:
        construct_groups.setdefault(code[:2], []).append(code)

    all_roles = df['Role_Category'].dropna().unique().tolist()

    config = {
        'created': datetime.now().strftime('%Y-%m-%d'),
        'selected_roles': ['ALL'],
        'roles_included': all_roles,
        'population': 'ALL',
        'population_description': 'All respondents (students + professionals) per approved dissertation proposal',
        'n_total': len(df),
        'n_efa': len(dev),
        'n_cfa': len(holdout),
        'holdout_ratio': HOLDOUT_RATIO,
        'random_seed': RANDOM_SEED,
    }
    with open('data/experiment_config.json', 'w') as f:
        json.dump(config, f, indent=2)

    metadata_export = {
        'created': datetime.now().strftime('%Y-%m-%d'),
        'items': LIKERT_ITEMS,
        'predictor_items': PREDICTOR_ITEMS,
        'outcome_items': OUTCOME_ITEMS,
        'constructs': construct_groups,
        'theoretical_domains': THEORETICAL_DOMAINS,
        'metadata': {c: {'construct': n, 'construct_abbr': c[:2], 'direction': d} for c, n, d in ITEMS},
        'positive_items': [c for c, _, d in ITEMS if d == 'POSITIVE'],
        'negative_items': [c for c, _, d in ITEMS if d == 'NEGATIVE'],
    }
    with open('data/airs_28item_complete.json', 'w') as f:
        json.dump(metadata_export, f, indent=2)

    print("\nExported: experiment_config.json, airs_28item_complete.json")

    # ── Sample Characteristics ────────────────────────────────────────────
    role_dist = df['Role_Category'].value_counts()
    academic_roles_list = ['FT_Student', 'PT_Student']
    n_academic = sum(role_dist.get(r, 0) for r in academic_roles_list)
    n_professional = len(df) - n_academic
    leader_roles = ['Manager', 'Executive']
    n_leaders = sum(role_dist.get(r, 0) for r in leader_roles)
    n_prof_only = n_professional - n_leaders

    sample_characteristics = {
        'total_n': int(len(df)),
        'efa_n': int(len(dev)),
        'cfa_n': int(len(holdout)),
        'efa_pct': round(len(dev)/len(df)*100, 1),
        'cfa_pct': round(len(holdout)/len(df)*100, 1),
        'two_group': {
            'academic': {
                'n': int(n_academic), 'pct': round(n_academic/len(df)*100, 1),
                'ft_student': int(role_dist.get('FT_Student', 0)),
                'pt_student': int(role_dist.get('PT_Student', 0))
            },
            'professional': {
                'n': int(n_professional), 'pct': round(n_professional/len(df)*100, 1)
            }
        },
        'three_group': {
            'student': {'n': int(n_academic), 'pct': round(n_academic/len(df)*100, 1)},
            'professional': {
                'n': int(n_prof_only), 'pct': round(n_prof_only/len(df)*100, 1),
                'ic': int(role_dist.get('IC', 0)),
                'freelancer': int(role_dist.get('Freelancer', 0)),
                'unemployed': int(role_dist.get('Unemployed', 0)),
                'other': int(role_dist.get('Other', 0))
            },
            'leader': {
                'n': int(n_leaders), 'pct': round(n_leaders/len(df)*100, 1),
                'manager': int(role_dist.get('Manager', 0)),
                'executive': int(role_dist.get('Executive', 0))
            }
        },
        'ai_adoption': {
            'overall_pct': round(df['AI_Adoption'].mean() * 100, 1),
            'efa_pct': round(dev['AI_Adoption'].mean() * 100, 1),
            'cfa_pct': round(holdout['AI_Adoption'].mean() * 100, 1)
        },
        'cases_per_item': {
            'efa': round(len(dev)/len(PREDICTOR_ITEMS), 1),
            'cfa': round(len(holdout)/len(PREDICTOR_ITEMS), 1)
        },
        'role_distribution': {k: int(v) for k, v in role_dist.items()}
    }
    with open('data/sample_characteristics.json', 'w') as f:
        json.dump(sample_characteristics, f, indent=2)
    print("Exported: sample_characteristics.json")

    # ── Visualization ─────────────────────────────────────────────────────
    sns.set_style("whitegrid")
    fig, axes = plt.subplots(2, 2, figsize=(14, 10))

    role_counts = df['Role_Category'].value_counts()
    colors = sns.color_palette("husl", len(role_counts))
    axes[0, 0].barh(role_counts.index, role_counts.values, color=colors)
    axes[0, 0].set_xlabel('Count')
    axes[0, 0].set_title(f'Role Distribution (N={len(df)})')
    for i, v in enumerate(role_counts.values):
        axes[0, 0].text(v + 2, i, f'{v} ({v/len(df)*100:.1f}%)', va='center', fontsize=9)

    split_data = pd.DataFrame({'Sample': ['EFA (Development)', 'CFA (Holdout)'], 'N': [len(dev), len(holdout)]})
    bars = axes[0, 1].bar(split_data['Sample'], split_data['N'], color=['#2ecc71', '#3498db'], edgecolor='black')
    axes[0, 1].set_ylabel('Sample Size')
    axes[0, 1].set_title(f'Split-Sample Design ({int((1-HOLDOUT_RATIO)*100)}/{int(HOLDOUT_RATIO*100)})')
    for bar, n in zip(bars, split_data['N']):
        axes[0, 1].text(bar.get_x() + bar.get_width()/2, bar.get_height() + 3, f'N={n}', ha='center', fontsize=11, fontweight='bold')

    adoption_efa = dev['AI_Adoption'].value_counts().sort_index()
    adoption_cfa = holdout['AI_Adoption'].value_counts().sort_index()
    x = np.arange(2)
    width = 0.35
    axes[1, 0].bar(x - width/2, [adoption_efa.get(0, 0), adoption_efa.get(1, 0)], width, label='EFA', color='#2ecc71')
    axes[1, 0].bar(x + width/2, [adoption_cfa.get(0, 0), adoption_cfa.get(1, 0)], width, label='CFA', color='#3498db')
    axes[1, 0].set_xticks(x)
    axes[1, 0].set_xticklabels(['Non-Adopters', 'Adopters'])
    axes[1, 0].set_ylabel('Count')
    axes[1, 0].set_title('AI Adoption Stratification (Balance Check)')
    axes[1, 0].legend()

    academic_roles = ['FT_Student', 'PT_Student']
    pop_groups = {
        'Academic': academic_roles,
        'Professional': [r for r in df['Role_Category'].dropna().unique() if r not in academic_roles]
    }
    pop_counts = {g: df[df['Role_Category'].isin(roles)].shape[0] for g, roles in pop_groups.items()}
    axes[1, 1].pie(pop_counts.values(),
                   labels=[f"{k}\n(N={v})" for k, v in pop_counts.items()],
                   autopct='%1.1f%%', colors=['#9b59b6', '#e74c3c'], startangle=90)
    axes[1, 1].set_title('Population Group Composition\n(Academic = FT+PT Students)')

    plt.tight_layout()
    plt.savefig('plots/sample_preparation_overview.png', dpi=150, bbox_inches='tight')
    plt.close()
    print("Saved: plots/sample_preparation_overview.png")

    # ── APA Summary ───────────────────────────────────────────────────────
    sc = sample_characteristics
    print("\n" + "=" * 90)
    print("SAMPLE SUMMARY")
    print("=" * 90)
    print(f"  Total N: {sc['total_n']}")
    print(f"  EFA: n={sc['efa_n']} ({sc['efa_pct']}%)")
    print(f"  CFA: n={sc['cfa_n']} ({sc['cfa_pct']}%)")
    print(f"  Academic: n={sc['two_group']['academic']['n']} ({sc['two_group']['academic']['pct']}%)")
    print(f"  Professional: n={sc['two_group']['professional']['n']} ({sc['two_group']['professional']['pct']}%)")
    print(f"  Leaders: n={sc['three_group']['leader']['n']} ({sc['three_group']['leader']['pct']}%)")
    print(f"  AI Adoption: {sc['ai_adoption']['overall_pct']}%")
    print(f"  Cases/Item: EFA={sc['cases_per_item']['efa']}:1, CFA={sc['cases_per_item']['cfa']}:1")

    print("\n" + "=" * 90)
    print("PHASE 0 COMPLETE")
    print("=" * 90)


if __name__ == '__main__':
    main()
