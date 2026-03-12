#!/usr/bin/env python3
"""
Phase 8: Qualitative Feedback Analysis (RQ11-12)
Standalone script refactored from 08_Qualitative_Feedback.ipynb

Analyzes open-ended feedback for thematic content and group differences.
"""

import json
import re
import warnings
from collections import Counter
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from scipy.stats import chi2_contingency
import seaborn as sns

warnings.filterwarnings('ignore')

# ── Configuration ──────────────────────────────────────────────────────────────

MIN_RESPONSE_LENGTH = 10

THEME_KEYWORDS = {
    'Positive Experience': ['enjoy', 'love', 'great', 'helpful', 'useful', 'good',
                            'like', 'amazing', 'excellent', 'wonderful', 'beneficial'],
    'Concerns/Caution': ['concern', 'worry', 'careful', 'caution', 'risk',
                         'afraid', 'fear', 'dangerous'],
    'Accuracy/Reliability': ['accurate', 'accuracy', 'reliable', 'reliability',
                             'trust', 'correct', 'wrong', 'error', 'mistake', 'inaccurate'],
    'Learning/Education': ['learn', 'study', 'school', 'education', 'research',
                           'student', 'homework', 'class'],
    'Work/Productivity': ['work', 'job', 'task', 'productivity', 'efficient',
                          'time', 'fast', 'quick'],
    'Ethics/Privacy': ['ethic', 'privacy', 'data', 'security', 'moral',
                       'honest', 'integrity'],
    'Future/Potential': ['future', 'potential', 'evolving', 'improve', 'develop',
                         'growing', 'progress'],
    'Cost/Access': ['cost', 'free', 'pay', 'expensive', 'access', 'available',
                    'subscription'],
    'Job Replacement': ['replace', 'job', 'employment', 'automate', 'obsolete',
                        'take over'],
    'Human Element': ['human', 'people', 'personal', 'creative', 'think', 'critical'],
}


# ── Helpers ────────────────────────────────────────────────────────────────────

def classify_role_type(role_cat):
    if pd.isna(role_cat):
        return 'Professional'
    role_cat = str(role_cat)
    if role_cat in ('FT_Student', 'PT_Student'):
        return 'Academic'
    if role_cat in ('Manager', 'Executive'):
        return 'Leader'
    return 'Professional'


def identify_themes(text):
    """Return list of themes detected via keyword matching."""
    if pd.isna(text) or not isinstance(text, str):
        return []
    text_lower = text.lower()
    return [theme for theme, keywords in THEME_KEYWORDS.items()
            if any(kw in text_lower for kw in keywords)]


# ── Main ───────────────────────────────────────────────────────────────────────

def main():
    Path('results').mkdir(exist_ok=True)
    Path('plots').mkdir(exist_ok=True)

    # Load combined full sample
    df_efa = pd.read_csv('data/AIRS_experiment.csv')
    df_cfa = pd.read_csv('data/AIRS_holdout.csv')
    df = pd.concat([df_efa, df_cfa], ignore_index=True)
    print(f"Combined sample N = {len(df)}")

    # ── Filter to substantive responses ────────────────────────────────────
    df['Role_Type'] = df['Role_Category'].apply(classify_role_type)
    df_feedback = df[df['Open_Feedback'].notna()].copy()
    df_feedback['feedback_text'] = df_feedback['Open_Feedback'].astype(str).str.strip()
    df_substantive = df_feedback[df_feedback['feedback_text'].str.len() >= MIN_RESPONSE_LENGTH].copy()

    print(f"Responses with feedback: {len(df_feedback)}")
    print(f"Substantive (≥{MIN_RESPONSE_LENGTH} chars): {len(df_substantive)}")

    # Response statistics
    df_substantive['response_length'] = df_substantive['feedback_text'].str.len()
    df_substantive['word_count'] = df_substantive['feedback_text'].str.split().str.len()
    print(f"Mean length: {df_substantive['response_length'].mean():.0f} chars, "
          f"{df_substantive['word_count'].mean():.1f} words")

    # ── Theme detection ────────────────────────────────────────────────────
    print("\n" + "=" * 70)
    print("THEME ANALYSIS")
    print("=" * 70)

    df_substantive['themes'] = df_substantive['feedback_text'].apply(identify_themes)
    theme_counter = Counter()
    for themes in df_substantive['themes']:
        theme_counter.update(themes)

    n_sub = len(df_substantive)
    theme_freq = {}
    print(f"\nTheme frequencies (N={n_sub}):")
    for theme, count in theme_counter.most_common():
        pct = count / n_sub * 100
        theme_freq[theme] = {'count': count, 'pct': round(pct, 1)}
        print(f"  {theme}: {count} ({pct:.1f}%)")

    # Exemplar quotes (top 5 themes, up to 3 each)
    exemplars = {}
    for theme, _ in theme_counter.most_common(5):
        mask = df_substantive['themes'].apply(lambda t: theme in t)
        samples = df_substantive.loc[mask, 'feedback_text'].head(3).tolist()
        exemplars[theme] = samples
        print(f"\n  Exemplars – {theme}:")
        for s in samples:
            print(f"    \"{s[:120]}{'...' if len(s) > 120 else ''}\"")

    # Theme distribution plot
    themes_sorted = sorted(theme_freq.items(), key=lambda x: x[1]['count'], reverse=True)
    fig, ax = plt.subplots(figsize=(10, 6))
    names = [t[0] for t in themes_sorted]
    counts = [t[1]['count'] for t in themes_sorted]
    ax.barh(names[::-1], counts[::-1], color='steelblue')
    ax.set_xlabel('Number of Responses')
    ax.set_title(f'Qualitative Theme Distribution (N={n_sub})')
    for i, (n, c) in enumerate(zip(names[::-1], counts[::-1])):
        ax.text(c + 1, i, f'{c}', va='center', fontsize=9)
    plt.tight_layout()
    plt.savefig('plots/08_theme_distribution.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("\n✓ Saved plots/08_theme_distribution.png")

    # ── 3-group chi-square comparison ──────────────────────────────────────
    print("\n" + "=" * 70)
    print("3-GROUP CHI-SQUARE: ROLE TYPE × THEME")
    print("=" * 70)

    group_results = {}
    for theme in THEME_KEYWORDS:
        df_substantive[f'has_{theme}'] = df_substantive['themes'].apply(lambda t: theme in t)
        contingency = pd.crosstab(df_substantive['Role_Type'], df_substantive[f'has_{theme}'])
        if contingency.shape[1] == 2:
            chi2, p, dof, expected = chi2_contingency(contingency)
            n_obs = contingency.values.sum()
            min_dim = min(contingency.shape) - 1
            cramers_v = np.sqrt(chi2 / (n_obs * min_dim)) if n_obs * min_dim > 0 else 0
            group_results[theme] = {
                'chi2': float(chi2), 'p': float(p), 'dof': int(dof),
                'cramers_v': float(cramers_v),
                'significant': bool(p < 0.05),
            }
            sig = '*' if p < 0.05 else ''
            print(f"  {theme}: χ²={chi2:.2f}, p={p:.3f}, V={cramers_v:.3f} {sig}")

    # Role × theme comparison plot
    fig, ax = plt.subplots(figsize=(12, 6))
    roles = df_substantive['Role_Type'].unique()
    theme_names = list(THEME_KEYWORDS.keys())
    x = np.arange(len(theme_names))
    width = 0.25
    for i, role in enumerate(sorted(roles)):
        sub = df_substantive[df_substantive['Role_Type'] == role]
        pcts = []
        for theme in theme_names:
            mask = sub['themes'].apply(lambda t: theme in t)
            pcts.append(mask.mean() * 100)
        ax.bar(x + i * width, pcts, width, label=role)
    ax.set_xticks(x + width)
    ax.set_xticklabels(theme_names, rotation=45, ha='right', fontsize=8)
    ax.set_ylabel('% Mentioning Theme')
    ax.set_title('Qualitative Theme Prevalence by Role Type')
    ax.legend()
    plt.tight_layout()
    plt.savefig('plots/08_role_type_theme_comparison.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Saved plots/08_role_type_theme_comparison.png")

    # ── Export ─────────────────────────────────────────────────────────────
    print("\n" + "=" * 70)
    print("EXPORT")
    print("=" * 70)

    results = {
        'sample': {
            'total_n': int(len(df)),
            'feedback_responses': int(len(df_feedback)),
            'substantive_responses': int(n_sub),
            'response_rate_percent': round(len(df_feedback) / len(df) * 100, 1),
        },
        'theme_keywords': {k: v for k, v in THEME_KEYWORDS.items()},
        'rq11_themes': {
            'n_themes': len(THEME_KEYWORDS),
            'theme_frequencies': {k: v['pct'] for k, v in theme_freq.items()},
        },
        'rq12_group_comparison': group_results,
        'key_findings': {
            'most_common_theme': theme_counter.most_common(1)[0][0] if theme_counter else 'N/A',
            'significant_differences': [t for t, r in group_results.items() if r['significant']],
        },
    }

    out_path = Path('results/phase8_qualitative_results.json')
    with open(out_path, 'w') as f:
        json.dump(results, f, indent=2, default=str)
    print(f"✓ Saved {out_path}")

    print("\n✓ Phase 8 complete.")


if __name__ == '__main__':
    main()
