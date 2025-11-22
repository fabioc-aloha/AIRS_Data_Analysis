"""
Psychometric Utilities for Reliability and Validity Assessment

Provides functions for calculating:
- Composite Reliability (CR)
- Average Variance Extracted (AVE)
- Fornell-Larcker criterion (discriminant validity)
- HTMT ratio (Heterotrait-Monotrait)
- Cronbach's Alpha
- McDonald's Omega

Author: Fabio Correa
Date: November 2025
"""

import pandas as pd
import numpy as np
from typing import Dict, List, Tuple


def calculate_composite_reliability(loadings: np.ndarray) -> float:
    """
    Calculate Composite Reliability (CR) for a construct.
    
    Formula: CR = (sum lambda)^2 / [(sum lambda)^2 + sum(1 - lambda^2)]
    where lambda = standardized factor loading
    
    Parameters
    ----------
    loadings : np.ndarray
        Array of standardized factor loadings
        
    Returns
    -------
    float
        Composite Reliability value
        
    References
    ----------
    Fornell, C., & Larcker, D. F. (1981). Evaluating structural equation 
    models with unobservable variables and measurement error. Journal of 
    Marketing Research, 18(1), 39-50.
    """
    sum_loadings = np.sum(loadings)
    sum_error_variance = np.sum(1 - loadings ** 2)
    cr = (sum_loadings ** 2) / ((sum_loadings ** 2) + sum_error_variance)
    return cr


def calculate_ave(loadings: np.ndarray) -> float:
    """
    Calculate Average Variance Extracted (AVE) for a construct.
    
    Formula: AVE = sum(lambda^2) / n
    where lambda = standardized factor loading, n = number of items
    
    Parameters
    ----------
    loadings : np.ndarray
        Array of standardized factor loadings
        
    Returns
    -------
    float
        Average Variance Extracted value
        
    References
    ----------
    Fornell, C., & Larcker, D. F. (1981). Evaluating structural equation 
    models with unobservable variables and measurement error. Journal of 
    Marketing Research, 18(1), 39-50.
    """
    sum_squared_loadings = np.sum(loadings ** 2)
    ave = sum_squared_loadings / len(loadings)
    return ave


def assess_convergent_validity(loadings_df: pd.DataFrame, 
                               construct_col: str = 'Construct',
                               loading_col: str = 'Loading',
                               cr_threshold: float = 0.70,
                               ave_threshold: float = 0.50) -> pd.DataFrame:
    """
    Assess convergent validity for all constructs using CR and AVE.
    
    Parameters
    ----------
    loadings_df : pd.DataFrame
        DataFrame with construct names and factor loadings
    construct_col : str
        Name of column containing construct names
    loading_col : str
        Name of column containing loading values
    cr_threshold : float
        Threshold for acceptable CR (default: 0.70)
    ave_threshold : float
        Threshold for acceptable AVE (default: 0.50)
        
    Returns
    -------
    pd.DataFrame
        Results with CR, AVE, and status indicators
    """
    results = []
    
    for construct in loadings_df[construct_col].unique():
        # Get loadings for this construct
        construct_loadings = loadings_df[
            loadings_df[construct_col] == construct
        ][loading_col].values
        
        # Calculate CR and AVE
        cr = calculate_composite_reliability(construct_loadings)
        ave = calculate_ave(construct_loadings)
        
        # Status indicators
        cr_status = "✓" if cr >= cr_threshold else "⚠" if cr >= 0.60 else "✗"
        ave_status = "✓" if ave >= ave_threshold else "⚠"
        
        results.append({
            'Construct': construct,
            'CR': cr,
            'AVE': ave,
            'CR_Status': cr_status,
            'AVE_Status': ave_status,
            'n_items': len(construct_loadings)
        })
    
    return pd.DataFrame(results)


def fornell_larcker_criterion(construct_corr_matrix: pd.DataFrame,
                              ave_dict: Dict[str, float]) -> Tuple[pd.DataFrame, List[str]]:
    """
    Apply Fornell-Larcker criterion for discriminant validity.
    
    Discriminant validity is established when the square root of AVE
    for each construct is greater than its correlations with other constructs.
    
    Parameters
    ----------
    construct_corr_matrix : pd.DataFrame
        Correlation matrix between constructs
    ave_dict : dict
        Dictionary mapping construct names to AVE values
        
    Returns
    -------
    pd.DataFrame
        Matrix with √AVE on diagonal, correlations off-diagonal
    list
        List of discriminant validity violations (if any)
        
    References
    ----------
    Fornell, C., & Larcker, D. F. (1981). Evaluating structural equation 
    models with unobservable variables and measurement error. Journal of 
    Marketing Research, 18(1), 39-50.
    """
    # Create Fornell-Larcker matrix
    fl_matrix = construct_corr_matrix.copy()
    
    # Replace diagonal with √AVE
    for construct in fl_matrix.index:
        if construct in ave_dict:
            fl_matrix.loc[construct, construct] = np.sqrt(ave_dict[construct])
    
    # Check for violations
    violations = []
    constructs = fl_matrix.index.tolist()
    
    for i, construct1 in enumerate(constructs):
        sqrt_ave1 = fl_matrix.loc[construct1, construct1]
        for construct2 in constructs[i+1:]:
            correlation = abs(construct_corr_matrix.loc[construct1, construct2])
            sqrt_ave2 = fl_matrix.loc[construct2, construct2]
            
            if correlation > sqrt_ave1 or correlation > sqrt_ave2:
                violations.append(f"{construct1}-{construct2}: r = {correlation:.3f}")
    
    return fl_matrix, violations


def calculate_htmt(item_corr_matrix: pd.DataFrame,
                  constructs: Dict[str, List[str]]) -> pd.DataFrame:
    """
    Calculate Heterotrait-Monotrait (HTMT) ratio of correlations.
    
    HTMT is the ratio of the average heterotrait-heteromethod correlations
    to the average monotrait-heteromethod correlations.
    
    Parameters
    ----------
    item_corr_matrix : pd.DataFrame
        Item-level correlation matrix
    constructs : dict
        Dictionary mapping construct names to item lists
        
    Returns
    -------
    pd.DataFrame
        HTMT matrix (values < 0.85 indicate discriminant validity)
        
    References
    ----------
    Henseler, J., Ringle, C. M., & Sarstedt, M. (2015). A new criterion 
    for assessing discriminant validity in variance-based structural 
    equation modeling. Journal of the Academy of Marketing Science, 
    43(1), 115-135.
    """
    construct_names = list(constructs.keys())
    n_constructs = len(construct_names)
    htmt_matrix = pd.DataFrame(
        np.eye(n_constructs),
        index=construct_names,
        columns=construct_names
    )
    
    for i, construct1 in enumerate(construct_names):
        items1 = constructs[construct1]
        
        for j, construct2 in enumerate(construct_names):
            if i >= j:
                continue
                
            items2 = constructs[construct2]
            
            # Heterotrait-heteromethod correlations (between different constructs)
            hetero_corrs = []
            for item1 in items1:
                for item2 in items2:
                    if item1 in item_corr_matrix.index and item2 in item_corr_matrix.columns:
                        hetero_corrs.append(abs(item_corr_matrix.loc[item1, item2]))
            
            # Monotrait-heteromethod correlations (within same construct)
            mono_corrs1 = []
            for k1 in range(len(items1)):
                for k2 in range(k1 + 1, len(items1)):
                    item1, item2 = items1[k1], items1[k2]
                    if item1 in item_corr_matrix.index and item2 in item_corr_matrix.columns:
                        mono_corrs1.append(abs(item_corr_matrix.loc[item1, item2]))
            
            mono_corrs2 = []
            for k1 in range(len(items2)):
                for k2 in range(k1 + 1, len(items2)):
                    item1, item2 = items2[k1], items2[k2]
                    if item1 in item_corr_matrix.index and item2 in item_corr_matrix.columns:
                        mono_corrs2.append(abs(item_corr_matrix.loc[item1, item2]))
            
            # Calculate HTMT
            if hetero_corrs and mono_corrs1 and mono_corrs2:
                avg_hetero = np.mean(hetero_corrs)
                avg_mono = np.mean(mono_corrs1 + mono_corrs2)
                htmt = avg_hetero / avg_mono if avg_mono > 0 else np.nan
                
                htmt_matrix.loc[construct1, construct2] = htmt
                htmt_matrix.loc[construct2, construct1] = htmt
    
    return htmt_matrix


def check_htmt_violations(htmt_matrix: pd.DataFrame, 
                         threshold: float = 0.85) -> List[Tuple[str, str, float]]:
    """
    Check for HTMT violations indicating discriminant validity issues.
    
    Parameters
    ----------
    htmt_matrix : pd.DataFrame
        HTMT ratio matrix
    threshold : float
        Threshold for acceptable HTMT (default: 0.85 for conceptually similar,
        0.90 for conceptually distinct constructs)
        
    Returns
    -------
    list of tuples
        List of (construct1, construct2, htmt_value) violations
        
    References
    ----------
    Henseler et al. (2015) recommend:
    - HTMT < 0.85 for conceptually similar constructs
    - HTMT < 0.90 for conceptually distinct constructs
    """
    violations = []
    constructs = htmt_matrix.index.tolist()
    
    for i, construct1 in enumerate(constructs):
        for construct2 in constructs[i+1:]:
            htmt_value = htmt_matrix.loc[construct1, construct2]
            if htmt_value > threshold:
                violations.append((construct1, construct2, htmt_value))
    
    return violations


def calculate_cronbach_alpha(df: pd.DataFrame, items: List[str]) -> float:
    """
    Calculate Cronbach's Alpha for a set of items.
    
    Formula: alpha = (k/(k-1)) * (1 - sum(var_i)/var_total)
    where k = number of items, var_i = item variance, var_total = total variance
    
    Parameters
    ----------
    df : pd.DataFrame
        Data containing the items
    items : list
        List of item column names
        
    Returns
    -------
    float
        Cronbach's Alpha value
        
    References
    ----------
    Cronbach, L. J. (1951). Coefficient alpha and the internal structure 
    of tests. Psychometrika, 16(3), 297-334.
    """
    item_data = df[items].values
    n_items = len(items)
    
    # Item variances
    item_variances = np.var(item_data, axis=0, ddof=1)
    
    # Total score variance
    total_scores = np.sum(item_data, axis=1)
    total_variance = np.var(total_scores, ddof=1)
    
    # Cronbach's Alpha
    alpha = (n_items / (n_items - 1)) * (1 - np.sum(item_variances) / total_variance)
    
    return alpha


def reliability_analysis(df: pd.DataFrame, 
                        constructs: Dict[str, List[str]],
                        alpha_threshold: float = 0.70) -> pd.DataFrame:
    """
    Perform reliability analysis for all constructs.
    
    Parameters
    ----------
    df : pd.DataFrame
        Data containing the items
    constructs : dict
        Dictionary mapping construct names to item lists
    alpha_threshold : float
        Threshold for acceptable reliability (default: 0.70)
        
    Returns
    -------
    pd.DataFrame
        Reliability results with Cronbach's Alpha for each construct
    """
    results = []
    
    for construct, items in constructs.items():
        alpha = calculate_cronbach_alpha(df, items)
        status = "✓" if alpha >= alpha_threshold else "⚠" if alpha >= 0.60 else "✗"
        
        results.append({
            'Construct': construct,
            'Alpha': alpha,
            'n_items': len(items),
            'Status': status
        })
    
    return pd.DataFrame(results)


def full_validity_assessment(df: pd.DataFrame,
                            loadings_df: pd.DataFrame,
                            constructs: Dict[str, List[str]],
                            construct_corr_matrix: pd.DataFrame,
                            item_corr_matrix: pd.DataFrame = None,
                            verbose: bool = True) -> Dict:
    """
    Perform complete validity assessment (convergent and discriminant).
    
    Parameters
    ----------
    df : pd.DataFrame
        Data containing the items
    loadings_df : pd.DataFrame
        CFA loadings with 'Construct' and 'Loading' columns
    constructs : dict
        Dictionary mapping construct names to item lists
    construct_corr_matrix : pd.DataFrame
        Construct-level correlation matrix
    item_corr_matrix : pd.DataFrame, optional
        Item-level correlation matrix for HTMT calculation
    verbose : bool
        Print detailed output
        
    Returns
    -------
    dict
        Complete validity assessment results
    """
    results = {}
    
    if verbose:
        print("=" * 80)
        print("COMPREHENSIVE VALIDITY ASSESSMENT")
        print("=" * 80)
        print()
    
    # Convergent validity
    if verbose:
        print("=== Convergent Validity (CR and AVE) ===\n")
    
    convergent = assess_convergent_validity(loadings_df)
    results['convergent_validity'] = convergent
    
    if verbose:
        print(convergent.to_string(index=False))
        acceptable_cr = sum(convergent['CR'] >= 0.70)
        acceptable_ave = sum(convergent['AVE'] >= 0.50)
        print(f"\nConstructs with CR ≥ 0.70: {acceptable_cr}/{len(convergent)}")
        print(f"Constructs with AVE ≥ 0.50: {acceptable_ave}/{len(convergent)}")
        print()
    
    # Discriminant validity (Fornell-Larcker)
    if verbose:
        print("\n" + "=" * 80)
        print("=== Discriminant Validity (Fornell-Larcker) ===\n")
    
    ave_dict = dict(zip(convergent['Construct'], convergent['AVE']))
    fl_matrix, fl_violations = fornell_larcker_criterion(construct_corr_matrix, ave_dict)
    results['fornell_larcker'] = {
        'matrix': fl_matrix,
        'violations': fl_violations
    }
    
    if verbose:
        print(fl_matrix.round(3).to_string())
        if fl_violations:
            print(f"\n⚠ Discriminant validity issues:")
            for v in fl_violations:
                print(f"  {v}")
        else:
            print("\n✓ Discriminant validity established")
        print()
    
    # HTMT (if item correlations provided)
    if item_corr_matrix is not None:
        if verbose:
            print("\n" + "=" * 80)
            print("=== HTMT Ratio ===\n")
        
        htmt_matrix = calculate_htmt(item_corr_matrix, constructs)
        htmt_violations = check_htmt_violations(htmt_matrix)
        results['htmt'] = {
            'matrix': htmt_matrix,
            'violations': htmt_violations
        }
        
        if verbose:
            print(htmt_matrix.round(3).to_string())
            if htmt_violations:
                print(f"\n⚠ HTMT violations (> 0.85):")
                for c1, c2, val in htmt_violations:
                    print(f"  {c1}-{c2}: {val:.3f}")
            else:
                print("\n✓ All HTMT values < 0.85")
            print()
    
    if verbose:
        print("=" * 80)
        print("✓ Validity assessment complete")
        print("=" * 80)
    
    return results


if __name__ == "__main__":
    print("Psychometric Utilities Module")
    print("=" * 70)
    print("Available functions:")
    print()
    print("Reliability:")
    print("  - calculate_cronbach_alpha(df, items)")
    print("  - reliability_analysis(df, constructs)")
    print()
    print("Convergent Validity:")
    print("  - calculate_composite_reliability(loadings)")
    print("  - calculate_ave(loadings)")
    print("  - assess_convergent_validity(loadings_df)")
    print()
    print("Discriminant Validity:")
    print("  - fornell_larcker_criterion(corr_matrix, ave_dict)")
    print("  - calculate_htmt(item_corr_matrix, constructs)")
    print("  - check_htmt_violations(htmt_matrix, threshold)")
    print()
    print("Complete Assessment:")
    print("  - full_validity_assessment(df, loadings_df, constructs, ...)")
