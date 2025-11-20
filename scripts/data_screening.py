"""
Data Screening and Quality Assessment Module

Performs comprehensive data quality checks for psychometric analysis:
- Missing data analysis
- Descriptive statistics
- Multivariate outlier detection (Mahalanobis distance)
- Factorability assessment (KMO, Bartlett's test)
- Control variable analysis

Author: Fabio Correa
Date: November 2025
"""

import pandas as pd
import numpy as np
from scipy import stats
from factor_analyzer import calculate_kmo, calculate_bartlett_sphericity


class DataScreener:
    """
    Comprehensive data screening for psychometric validation.
    
    Parameters
    ----------
    df : pd.DataFrame
        Clean dataset with Likert-scale items
    item_columns : list
        List of item column names to analyze
    constructs : dict, optional
        Dictionary mapping construct names to item lists
    """
    
    def __init__(self, df, item_columns, constructs=None):
        self.df = df
        self.item_columns = item_columns
        self.constructs = constructs or {}
        self.df_items = df[item_columns].copy()
        self.results = {}
        
    def check_missing_data(self, verbose=True):
        """
        Analyze missing data patterns.
        
        Returns
        -------
        dict
            Missing data summary with counts and percentages
        """
        missing_summary = self.df_items.isnull().sum()
        missing_pct = (self.df_items.isnull().sum() / len(self.df_items)) * 100
        
        result = {
            'total_obs': len(self.df_items),
            'total_vars': len(self.item_columns),
            'total_missing': missing_summary.sum(),
            'missing_by_var': missing_summary.to_dict(),
            'missing_pct_by_var': missing_pct.to_dict(),
            'has_missing': missing_summary.sum() > 0
        }
        
        if verbose:
            print("=== Missing Data Analysis ===\n")
            print(f"Total observations: {result['total_obs']}")
            print(f"Total variables: {result['total_vars']}")
            
            if result['total_missing'] == 0:
                print("\n✓ No missing data detected!")
            else:
                print(f"\nTotal missing values: {result['total_missing']}")
                missing_df = pd.DataFrame({
                    'Variable': missing_summary.index,
                    'Missing': missing_summary.values,
                    'Percentage': missing_pct.values
                })
                print(missing_df[missing_df['Missing'] > 0].to_string(index=False))
        
        self.results['missing_data'] = result
        return result
    
    def descriptive_statistics(self, expected_min=1, expected_max=5, verbose=True):
        """
        Calculate descriptive statistics and check data quality.
        
        Parameters
        ----------
        expected_min : float
            Expected minimum value (default: 1 for Likert scale)
        expected_max : float
            Expected maximum value (default: 5 for Likert scale)
        verbose : bool
            Print detailed output
            
        Returns
        -------
        pd.DataFrame
            Descriptive statistics including skewness and kurtosis
        """
        desc_stats = self.df_items.describe().T
        desc_stats['skew'] = self.df_items.skew()
        desc_stats['kurtosis'] = self.df_items.kurtosis()
        
        # Range checks
        actual_min = self.df_items.min().min()
        actual_max = self.df_items.max().max()
        in_range = (actual_min >= expected_min) and (actual_max <= expected_max)
        
        if verbose:
            print("=== Descriptive Statistics ===\n")
            print(desc_stats.to_string())
            print("\n" + "=" * 80)
            print(f"\nExpected range: {expected_min}-{expected_max}")
            print(f"Actual min: {actual_min:.0f}")
            print(f"Actual max: {actual_max:.0f}")
            print("✓ All values within expected range" if in_range else "⚠ Values outside expected range detected")
        
        self.results['descriptive_stats'] = {
            'stats': desc_stats,
            'expected_range': (expected_min, expected_max),
            'actual_range': (actual_min, actual_max),
            'in_range': in_range
        }
        
        return desc_stats
    
    def detect_outliers(self, alpha=0.001, verbose=True):
        """
        Detect multivariate outliers using Mahalanobis distance.
        
        Parameters
        ----------
        alpha : float
            Significance level for chi-square critical value (default: 0.001)
        verbose : bool
            Print detailed output
            
        Returns
        -------
        dict
            Outlier detection results with distances and outlier indices
        """
        # Calculate Mahalanobis distance
        mean = self.df_items.mean()
        cov = self.df_items.cov()
        inv_cov = np.linalg.pinv(cov)  # Pseudo-inverse for stability
        
        mahal_dist = []
        for i in range(len(self.df_items)):
            diff = self.df_items.iloc[i] - mean
            md = np.sqrt(diff @ inv_cov @ diff)
            mahal_dist.append(md)
        
        # Chi-square critical value
        df_chi = len(self.item_columns)
        chi2_critical = stats.chi2.ppf(1 - alpha, df_chi)
        
        # Identify outliers
        outliers = np.array(mahal_dist) > chi2_critical
        n_outliers = outliers.sum()
        outlier_indices = np.where(outliers)[0].tolist()
        
        if verbose:
            print("=== Multivariate Outlier Detection ===\n")
            print(f"Method: Mahalanobis Distance")
            print(f"Degrees of freedom: {df_chi}")
            print(f"Significance level (α): {alpha}")
            print(f"Chi-square critical value: {chi2_critical:.3f}")
            print(f"Maximum Mahalanobis distance: {max(mahal_dist):.3f}")
            print(f"\nOutliers detected: {n_outliers} ({n_outliers/len(self.df_items)*100:.1f}%)")
            
            if n_outliers > 0:
                print(f"⚠ {n_outliers} multivariate outliers detected")
                print("Note: Outliers retained for analysis (robust estimation)")
            else:
                print("✓ No significant multivariate outliers detected")
        
        result = {
            'mahalanobis_distances': mahal_dist,
            'chi2_critical': chi2_critical,
            'df': df_chi,
            'alpha': alpha,
            'n_outliers': n_outliers,
            'outlier_indices': outlier_indices,
            'outlier_pct': n_outliers / len(self.df_items) * 100
        }
        
        self.results['outliers'] = result
        return result
    
    def assess_factorability(self, verbose=True):
        """
        Assess data suitability for factor analysis.
        
        Tests:
        - Kaiser-Meyer-Olkin (KMO) test
        - Bartlett's test of sphericity
        
        Returns
        -------
        dict
            Factorability assessment results
        """
        # KMO test
        kmo_all, kmo_model = calculate_kmo(self.df_items)
        
        # Interpret KMO
        if kmo_model >= 0.90:
            kmo_interpretation = "Marvelous (0.90+) - Excellent"
        elif kmo_model >= 0.80:
            kmo_interpretation = "Meritorious (0.80-0.89) - Very good"
        elif kmo_model >= 0.70:
            kmo_interpretation = "Middling (0.70-0.79) - Adequate"
        elif kmo_model >= 0.60:
            kmo_interpretation = "Mediocre (0.60-0.69) - Acceptable"
        elif kmo_model >= 0.50:
            kmo_interpretation = "Miserable (0.50-0.59) - Poor but minimal"
        else:
            kmo_interpretation = "Unacceptable (<0.50) - Not suitable"
        
        # Bartlett's test
        chi2, p_value = calculate_bartlett_sphericity(self.df_items)
        
        # Overall suitability
        suitable = (kmo_model >= 0.60) and (p_value < 0.001)
        
        if verbose:
            print("=== Factorability Assessment ===\n")
            print("Kaiser-Meyer-Olkin (KMO) Test:")
            print("=" * 70)
            print(f"Overall KMO: {kmo_model:.3f}")
            print(f"Interpretation: {kmo_interpretation}")
            
            print("\n" + "=" * 70)
            print("Bartlett's Test of Sphericity:")
            print("=" * 70)
            print(f"Chi-square statistic: {chi2:.2f}")
            print(f"p-value: {p_value:.4e}")
            print(f"Interpretation: {'✓ Significant - Variables are correlated' if p_value < 0.001 else '⚠ Not significant'}")
            
            print("\n" + "=" * 70)
            print(f"✓ Data suitable for factor analysis" if suitable else "⚠ Data may not be suitable for factor analysis")
        
        result = {
            'kmo_per_item': kmo_all,
            'kmo_overall': kmo_model,
            'kmo_interpretation': kmo_interpretation,
            'bartlett_chi2': chi2,
            'bartlett_p': p_value,
            'bartlett_significant': p_value < 0.001,
            'suitable_for_fa': suitable
        }
        
        self.results['factorability'] = result
        return result
    
    def analyze_control_variables(self, control_vars, outcome_vars=None, verbose=True):
        """
        Analyze control variables for potential use in modeling.
        
        Parameters
        ----------
        control_vars : list
            List of control variable names (e.g., ['Region', 'Duration_minutes'])
        outcome_vars : list, optional
            List of outcome variable names to check correlations
        verbose : bool
            Print detailed output
            
        Returns
        -------
        dict
            Control variable analysis results
        """
        results = {}
        
        if verbose:
            print("=== Control Variables Analysis ===\n")
        
        for var in control_vars:
            if var not in self.df.columns:
                if verbose:
                    print(f"⚠ Variable '{var}' not found in dataset")
                continue
            
            var_data = self.df[var]
            var_results = {'variable': var}
            
            # Categorical variable
            if var_data.dtype == 'object' or var_data.nunique() < 20:
                counts = var_data.value_counts()
                var_results['type'] = 'categorical'
                var_results['n_categories'] = len(counts)
                var_results['distribution'] = counts.to_dict()
                
                if verbose:
                    print(f"--- {var} (Categorical) ---")
                    print(f"Categories: {len(counts)}")
                    print(f"Distribution:")
                    print(counts.head(10))
                    print(f"Categories with n ≥ 30: {(counts >= 30).sum()}")
                    print()
            
            # Continuous variable
            else:
                stats_summary = var_data.describe()
                var_results['type'] = 'continuous'
                var_results['mean'] = stats_summary['mean']
                var_results['median'] = stats_summary['50%']
                var_results['std'] = stats_summary['std']
                var_results['range'] = (stats_summary['min'], stats_summary['max'])
                
                if verbose:
                    print(f"--- {var} (Continuous) ---")
                    print(f"Mean: {stats_summary['mean']:.2f}")
                    print(f"Median: {stats_summary['50%']:.2f}")
                    print(f"SD: {stats_summary['std']:.2f}")
                    print(f"Range: {stats_summary['min']:.2f} - {stats_summary['max']:.2f}")
                
                # Check correlation with outcomes
                if outcome_vars:
                    correlations = {}
                    for outcome in outcome_vars:
                        if outcome in self.df.columns:
                            corr = self.df[[var, outcome]].corr().iloc[0, 1]
                            correlations[outcome] = corr
                    
                    var_results['correlations'] = correlations
                    
                    if verbose and correlations:
                        print(f"\nCorrelations with outcomes:")
                        for outcome, corr in correlations.items():
                            status = "⚠" if abs(corr) > 0.20 else "✓"
                            print(f"  {outcome}: r = {corr:.3f} {status}")
                
                if verbose:
                    print()
            
            results[var] = var_results
        
        self.results['control_variables'] = results
        return results
    
    def run_full_screening(self, alpha_outliers=0.001, control_vars=None, 
                          outcome_vars=None, expected_range=(1, 5)):
        """
        Run complete data screening workflow.
        
        Parameters
        ----------
        alpha_outliers : float
            Significance level for outlier detection
        control_vars : list, optional
            Control variables to analyze
        outcome_vars : list, optional
            Outcome variables for control variable correlations
        expected_range : tuple
            Expected (min, max) values for items
            
        Returns
        -------
        dict
            Complete screening results
        """
        print("=" * 80)
        print("COMPREHENSIVE DATA SCREENING")
        print("=" * 80)
        print()
        
        # Run all checks
        self.check_missing_data()
        print("\n" + "=" * 80 + "\n")
        
        self.descriptive_statistics(expected_range[0], expected_range[1])
        print("\n" + "=" * 80 + "\n")
        
        self.detect_outliers(alpha_outliers)
        print("\n" + "=" * 80 + "\n")
        
        self.assess_factorability()
        
        if control_vars:
            print("\n" + "=" * 80 + "\n")
            self.analyze_control_variables(control_vars, outcome_vars)
        
        print("\n" + "=" * 80)
        print("✓ Data screening complete")
        print("=" * 80)
        
        return self.results
    
    def export_results(self, output_dir):
        """
        Export screening results to CSV files.
        
        Parameters
        ----------
        output_dir : str or Path
            Directory to save results
        """
        from pathlib import Path
        output_dir = Path(output_dir)
        output_dir.mkdir(parents=True, exist_ok=True)
        
        # Descriptive statistics
        if 'descriptive_stats' in self.results:
            stats_df = self.results['descriptive_stats']['stats']
            stats_df.to_csv(output_dir / 'descriptive_statistics.csv')
        
        # Missing data
        if 'missing_data' in self.results:
            missing_df = pd.DataFrame({
                'Variable': list(self.results['missing_data']['missing_by_var'].keys()),
                'Missing': list(self.results['missing_data']['missing_by_var'].values()),
                'Percentage': list(self.results['missing_data']['missing_pct_by_var'].values())
            })
            missing_df.to_csv(output_dir / 'missing_data_summary.csv', index=False)
        
        # Factorability
        if 'factorability' in self.results:
            fact_df = pd.DataFrame({
                'Metric': ['KMO Overall', 'Bartlett Chi2', 'Bartlett p-value', 'Suitable for FA'],
                'Value': [
                    self.results['factorability']['kmo_overall'],
                    self.results['factorability']['bartlett_chi2'],
                    self.results['factorability']['bartlett_p'],
                    self.results['factorability']['suitable_for_fa']
                ]
            })
            fact_df.to_csv(output_dir / 'factorability_assessment.csv', index=False)
        
        print(f"✓ Screening results exported to {output_dir}")


# Convenience function
def screen_data(df, item_columns, constructs=None, **kwargs):
    """
    Convenience function for quick data screening.
    
    Parameters
    ----------
    df : pd.DataFrame
        Clean dataset
    item_columns : list
        List of item column names
    constructs : dict, optional
        Construct-to-items mapping
    **kwargs : additional arguments for run_full_screening()
    
    Returns
    -------
    DataScreener
        Screening object with results
    """
    screener = DataScreener(df, item_columns, constructs)
    screener.run_full_screening(**kwargs)
    return screener


if __name__ == "__main__":
    # Example usage
    import sys
    from pathlib import Path
    
    # Add parent directory to path
    sys.path.append(str(Path(__file__).parent))
    
    print("Data Screening Module")
    print("=" * 70)
    print("Usage:")
    print()
    print("from data_screening import DataScreener, screen_data")
    print()
    print("# Quick screening")
    print("screener = screen_data(df, item_columns)")
    print()
    print("# Detailed screening with control variables")
    print("screener = DataScreener(df, item_columns, constructs)")
    print("results = screener.run_full_screening(")
    print("    control_vars=['Region', 'Duration_minutes'],")
    print("    outcome_vars=['BI1', 'BI2', 'BI3', 'BI4']")
    print(")")
    print("screener.export_results('results/tables')")
