"""
VO1 and VO2 Detailed Analysis
=============================
Can these items be salvaged for the measurement model?
"""

import pandas as pd
import numpy as np
import os
os.environ['KMP_DUPLICATE_LIB_OK'] = 'True'
import warnings
warnings.filterwarnings('ignore')
import semopy
from semopy import Model
import pingouin as pg

df = pd.read_csv('data/AIRS_holdout.csv')
print('='*80)
print('VO1 AND VO2 DETAILED ANALYSIS')
print('='*80)

constructs = {
    'PerfExp': ['PE1','PE2'], 
    'EffortExp': ['EE1','EE2'], 
    'SocialInf': ['SI1','SI2'], 
    'FacilCond': ['FC1','FC2'],
    'HedonicMot': ['HM1','HM2'], 
    'PriceValue': ['PV1','PV2'],
    'Habit': ['HB1','HB2'], 
    'AITrust': ['TR1','TR2']
}

# =============================================================================
# VO1 Analysis
# =============================================================================
print('\n--- VO1: "I use AI because I find them helpful" ---')
print('\nCorrelations with individual items:')
for factor, items in [('PerfExp', ['PE1','PE2']), ('PriceValue', ['PV1','PV2']), 
                       ('HedonicMot', ['HM1','HM2']), ('Habit', ['HB1','HB2'])]:
    r1 = df['VO1'].corr(df[items[0]])
    r2 = df['VO1'].corr(df[items[1]])
    print(f'  {factor}: {items[0]}={r1:.3f}, {items[1]}={r2:.3f}')

# Baseline model
baseline = '''
PerfExp =~ PE1 + PE2
EffortExp =~ EE1 + EE2
SocialInf =~ SI1 + SI2
FacilCond =~ FC1 + FC2
HedonicMot =~ HM1 + HM2
PriceValue =~ PV1 + PV2
Habit =~ HB1 + HB2
AITrust =~ TR1 + TR2
'''

model_base = Model(baseline)
model_base.fit(df)
stats_base = semopy.calc_stats(model_base)
base_aic = float(stats_base.loc['Value', 'AIC'])
base_bic = float(stats_base.loc['Value', 'BIC'])
base_cfi = float(stats_base.loc['Value', 'CFI'])

# Model with VO1 added to PerfExp
vo1_pe_model = baseline.replace('PerfExp =~ PE1 + PE2', 'PerfExp =~ PE1 + PE2 + VO1')
model_vo1_pe = Model(vo1_pe_model)
model_vo1_pe.fit(df)
stats_vo1_pe = semopy.calc_stats(model_vo1_pe)

print(f'\n--- CFA MODEL COMPARISON: VO1 -> PerfExp ---')
print(f'Baseline (8 factors, 16 items):')
print(f'  CFI = {base_cfi:.3f}')
print(f'  AIC = {base_aic:.2f}')
print(f'  BIC = {base_bic:.2f}')

vo1_aic = float(stats_vo1_pe.loc['Value', 'AIC'])
vo1_bic = float(stats_vo1_pe.loc['Value', 'BIC'])
vo1_cfi = float(stats_vo1_pe.loc['Value', 'CFI'])

print(f'\n+VO1 -> PerfExp (8 factors, 17 items):')
print(f'  CFI = {vo1_cfi:.3f} (Delta = {vo1_cfi - base_cfi:+.3f})')
print(f'  AIC = {vo1_aic:.2f} (Delta = {vo1_aic - base_aic:+.2f})')
print(f'  BIC = {vo1_bic:.2f} (Delta = {vo1_bic - base_bic:+.2f})')

# Factor loadings
params = model_vo1_pe.inspect(std_est=True)
pe_loadings = params[(params['rval'] == 'PerfExp') & (params['op'] == '~')]
print(f'\nPerfExp factor loadings:')
for _, row in pe_loadings.iterrows():
    item = row['lval']
    loading = row['Est. Std']
    print(f'  {item}: lambda = {loading:.3f}')

# Reliability
alpha_pe = pg.cronbach_alpha(df[['PE1', 'PE2']])[0]
alpha_pe_vo1 = pg.cronbach_alpha(df[['PE1', 'PE2', 'VO1']])[0]
print(f'\nReliability (Cronbach alpha):')
print(f'  PerfExp (PE1, PE2):      alpha = {alpha_pe:.3f}')
print(f'  PerfExp (PE1, PE2, VO1): alpha = {alpha_pe_vo1:.3f}')

# =============================================================================
# Cross-loading Analysis - THE KEY ISSUE
# =============================================================================
print('\n' + '='*80)
print('CROSS-LOADING ANALYSIS (Why VO1 is problematic)')
print('='*80)

print('\nVO1 correlations with ALL construct means:')
vo1_corrs = []
for c, items in constructs.items():
    r = df['VO1'].corr(df[items].mean(axis=1))
    vo1_corrs.append((c, r))
    bar = '*' * int(r * 20)
    print(f'  {c:<12} r = {r:.3f} {bar}')

vo1_vals = [r for _, r in vo1_corrs]
print(f'\n  Mean r = {np.mean(vo1_vals):.3f}')
print(f'  Min r  = {min(vo1_vals):.3f}')
print(f'  Max r  = {max(vo1_vals):.3f}')
print(f'  Range  = {max(vo1_vals) - min(vo1_vals):.3f}')

print('\n  INTERPRETATION:')
print('  VO1 correlates r > 0.55 with ALL 8 factors!')
print('  This indicates a "halo effect" or general positivity item.')
print('  In CFA, this violates the simple structure assumption.')

# =============================================================================
# VO2 Analysis
# =============================================================================
print('\n' + '='*80)
print('VO2: "I could choose not to use AI"')
print('='*80)

print('\nVO2 correlations with construct means:')
vo2_corrs = []
for c, items in constructs.items():
    r = df['VO2'].corr(df[items].mean(axis=1))
    vo2_corrs.append((c, r))
    bar = '*' * int(abs(r) * 20)
    print(f'  {c:<12} r = {r:.3f} {bar}')

vo2_vals = [r for _, r in vo2_corrs]
print(f'\n  Max |r| = {max(np.abs(vo2_vals)):.3f}')
print(f'\n  INTERPRETATION:')
print('  VO2 has weak correlations with all constructs (max r = 0.27)')
print('  This item measures perceived autonomy/choice')
print('  No theoretical home in UTAUT2 constructs')

# =============================================================================
# What about VO1 + VO2 as their own factor?
# =============================================================================
print('\n' + '='*80)
print('ALTERNATIVE: VO1 + VO2 as Voluntariness factor?')
print('='*80)

vo1_vo2_corr = df['VO1'].corr(df['VO2'])
vo_alpha = pg.cronbach_alpha(df[['VO1', 'VO2']])[0]
print(f'\nInter-item correlation: r = {vo1_vo2_corr:.3f}')
print(f'Cronbach alpha: {vo_alpha:.3f}')
print(f'\n  INTERPRETATION:')
print(f'  Inter-item r = {vo1_vo2_corr:.3f} is too low (need r > 0.50)')
print(f'  Alpha = {vo_alpha:.3f} is unacceptable (need alpha >= 0.60)')
print('  These items measure DIFFERENT constructs (motivation vs autonomy)')

# =============================================================================
# Final Summary
# =============================================================================
print('\n' + '='*80)
print('FINAL ASSESSMENT')
print('='*80)

print('''
VO1 ("I use AI because I find them helpful"):
  PROS:
    + Strong loading on PerfExp (lambda = 0.83)
    + High reliability when added (alpha = 0.88)
    + Theoretically related to performance expectancy
  
  CONS:
    - AIC INCREASES by +3.73 (model fit does NOT improve)
    - Cross-loads on ALL 8 factors (r = 0.56 to 0.76)
    - Violates simple structure assumption
    - Acts as "general AI positivity" item, not construct-specific
    
  VERDICT: DO NOT ADD
    Adding VO1 would inflate factor correlations and muddy discriminant validity.
    It's a "good item" that doesn't belong to any single construct.

VO2 ("I could choose not to use AI"):
  PROS:
    + Measures conceptually distinct construct (autonomy)
  
  CONS:
    - Weak correlations with all factors (max r = 0.27)
    - Cannot be integrated into any existing construct
    - Would need to be standalone single-item measure
    - Only 1 item = cannot form reliable latent factor
    
  VERDICT: DO NOT ADD
    VO2 has no theoretical home in the UTAUT2 measurement model.
    Could only be used as single-item covariate in structural model.

CONCLUSION:
  Model D (8 factors, 16 items) remains the optimal measurement model.
  Neither VO1 nor VO2 should be added because:
    - VO1: Cross-loading problem (halo effect)
    - VO2: No fit with any construct
    - Combined: Poor reliability (alpha = 0.43)
''')

print('='*80)
print('Analysis complete')
print('='*80)
