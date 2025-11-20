"""
AIRS Data Preprocessing Pipeline
==================================
Converts raw Qualtrics survey data to clean analysis-ready dataset.

Input:  data/AIRS---AI-Readiness-Scale.csv (raw Qualtrics export)
Output: data/AIRS_clean.csv (analysis-ready dataset)

Processing Steps:
1. Load raw data (skip Qualtrics metadata rows)
2. Rename columns to construct/item codes
3. Duration analysis and quality checks
4. IP geolocation (IP → US state codes)
5. Attention check filtering
6. Convert to numeric and validate ranges
7. Create analysis dataset with control variables
8. Save clean dataset

Quality Control Features:
- Attention check filtering (Item: "Disagree with this statement")
- Speeder detection (< 3 minutes completion)
- Duration outlier flagging (> 60 minutes)
- IP geolocation for regional analysis
- Privacy protection (IP addresses not saved)

Author: Fabio Costa
Date: 2025-06-07
"""

import pandas as pd
import numpy as np
import requests
from time import sleep
from pathlib import Path


class AIRSPreprocessor:
    """AIRS data preprocessing pipeline"""
    
    def __init__(self, raw_data_path, clean_data_path):
        self.raw_data_path = Path(raw_data_path)
        self.clean_data_path = Path(clean_data_path)
        self.data_raw = None
        self.data_clean = None
        
        # Define item names for standardized renaming
        self.item_names = [
            "PE1", "PE2",      # Performance Expectancy
            "EE1", "EE2",      # Effort Expectancy
            "SI1", "SI2",      # Social Influence
            "FC1", "FC2",      # Facilitating Conditions
            "HM1", "HM2",      # Hedonic Motivation
            "PV1", "PV2",      # Price Value
            "HB1", "HB2",      # Habit
            "VO1", "VO2",      # Voluntariness
            "TR1", "TR2",      # Trust
            "EX1", "EX2",      # Explainability
            "ATT_CHECK",       # Attention check
            "ER1", "ER2",      # Ethical Risk
            "AX1", "AX2",      # Anxiety
            "BI1", "BI2", "BI3", "BI4"  # Behavioral Intention
        ]
        
    def load_raw_data(self):
        """Step 1: Load raw Qualtrics export (skip metadata rows)"""
        print("=== AIRS Data Preprocessing ===\n")
        self.data_raw = pd.read_csv(self.raw_data_path, skiprows=2)
        print(f"✓ Raw data loaded: {self.data_raw.shape[0]} observations × {self.data_raw.shape[1]} variables")
        return self
    
    def rename_columns(self):
        """Step 2: Rename columns to standardized format"""
        # Rename Likert items (columns 13-41)
        self.data_raw.columns.values[13:42] = self.item_names
        
        # Rename key columns
        self.data_raw.rename(columns={
            self.data_raw.columns[8]: "Duration_seconds",
            self.data_raw.columns[9]: "IP_Address",
            self.data_raw.columns[11]: "Consent",
            self.data_raw.columns[12]: "Status",
            self.data_raw.columns[42]: "Usage_MSCopilot",
            self.data_raw.columns[43]: "Usage_ChatGPT",
            self.data_raw.columns[44]: "Usage_Gemini",
            self.data_raw.columns[45]: "Usage_Other",
            self.data_raw.columns[46]: "Education",
            self.data_raw.columns[47]: "Industry",
            self.data_raw.columns[48]: "Experience",
            self.data_raw.columns[49]: "Disability",
            self.data_raw.columns[50]: "Feedback"
        }, inplace=True)
        
        print("✓ Variable renaming complete")
        return self
    
    def analyze_duration(self):
        """Step 3: Duration analysis and quality checks"""
        print("\n--- Survey Duration Analysis ---")
        self.data_raw['Duration_seconds'] = pd.to_numeric(self.data_raw['Duration_seconds'], errors='coerce')
        self.data_raw['Duration_minutes'] = self.data_raw['Duration_seconds'] / 60
        
        stats = self.data_raw['Duration_minutes'].describe()
        print(f"Duration (minutes) statistics:")
        print(f"  Mean: {stats['mean']:.1f} min | Median: {stats['50%']:.1f} min")
        print(f"  Range: {stats['min']:.1f} - {stats['max']:.1f} min")
        
        # Quality flags
        speeders = (self.data_raw['Duration_minutes'] < 3).sum()
        outliers = (self.data_raw['Duration_minutes'] > 60).sum()
        print(f"\n⚠ Quality Flags:")
        print(f"  Speeders (< 3 min): {speeders} ({100*speeders/len(self.data_raw):.1f}%)")
        print(f"  Outliers (> 60 min): {outliers} ({100*outliers/len(self.data_raw):.1f}%)")
        
        return self
    
    def geolocate_ips(self):
        """Step 4: Convert IP addresses to US state codes"""
        print("\n--- IP Geolocation Processing ---")
        
        unique_ips = self.data_raw['IP_Address'].dropna().unique()
        print(f"Processing {len(unique_ips)} unique IP addresses...")
        
        ip_to_region = {}
        for i, ip in enumerate(unique_ips):
            ip_to_region[ip] = self._get_location_from_ip(ip)
            
            # Rate limiting: ip-api.com allows 45 requests/minute
            if (i + 1) % 40 == 0:
                print(f"  Processed {i + 1}/{len(unique_ips)} IPs (pausing for rate limit)...")
                sleep(2)
        
        self.data_raw['Region'] = self.data_raw['IP_Address'].map(ip_to_region).fillna('Unknown')
        
        region_counts = self.data_raw['Region'].value_counts()
        print(f"✓ Geolocation complete: {len(region_counts)} unique regions")
        print(f"\nTop 5 regions:")
        print(region_counts.head(5))
        
        return self
    
    @staticmethod
    def _get_location_from_ip(ip_address):
        """Helper: Convert IP to region using ip-api.com"""
        if pd.isna(ip_address) or ip_address == '':
            return 'Unknown'
        
        try:
            response = requests.get(f'http://ip-api.com/json/{ip_address}', timeout=5)
            if response.status_code == 200:
                data = response.json()
                if data.get('status') == 'success' and data.get('countryCode') == 'US':
                    return data.get('region', 'Unknown')
                elif data.get('status') == 'success':
                    return f"Non-US_{data.get('countryCode', 'Unknown')}"
            return 'Unknown'
        except Exception:
            return 'Unknown'
    
    def filter_attention_check(self):
        """Step 5: Filter responses that failed attention check"""
        print("\n--- Attention Check Analysis ---")
        att_counts = self.data_raw['ATT_CHECK'].value_counts(dropna=False)
        print(f"Attention check distribution:\n{att_counts}\n")
        
        # Keep only correct responses (ATT_CHECK == 2 = "Disagree")
        valid = self.data_raw['ATT_CHECK'] == 2
        n_failed = (~valid).sum()
        
        self.data_clean = self.data_raw[valid].copy()
        
        print(f"Failed: {n_failed} ({100*n_failed/len(self.data_raw):.1f}%)")
        print(f"✓ Valid responses: {len(self.data_clean)}")
        
        return self
    
    def convert_to_numeric(self):
        """Step 6: Convert Likert items to numeric"""
        likert_vars = [name for name in self.item_names if name != "ATT_CHECK"]
        
        for var in likert_vars:
            self.data_clean[var] = pd.to_numeric(self.data_clean[var], errors='coerce')
        
        print(f"\n✓ Converted {len(likert_vars)} Likert items to numeric")
        
        # Check for missing values
        missing = self.data_clean[likert_vars].isnull().sum()
        if missing.sum() > 0:
            print("\n⚠ Variables with missing data:")
            print(missing[missing > 0])
        else:
            print("✓ No missing data in Likert items")
        
        return self
    
    def create_analysis_dataset(self):
        """Step 7: Create final analysis dataset"""
        print("\n--- Dataset Creation ---")
        
        likert_vars = [name for name in self.item_names if name != "ATT_CHECK"]
        
        analysis_vars = (
            ["Region", "Duration_minutes"] +  # Control variables
            likert_vars +  # 28 Likert items
            ["Status", "Education", "Industry", "Experience", "Disability"] +  # Demographics
            ["Usage_MSCopilot", "Usage_ChatGPT", "Usage_Gemini", "Usage_Other"]  # Usage
        )
        
        self.data_clean = self.data_clean[analysis_vars].copy()
        
        # Rename Status to Role for clarity
        self.data_clean.rename(columns={"Status": "Role"}, inplace=True)
        
        print(f"✓ Analysis dataset: {len(self.data_clean)} obs × {len(self.data_clean.columns)} vars")
        print("✓ Includes: Region, Duration_minutes, 28 Likert items, demographics, usage")
        print("✓ Privacy: IP addresses excluded")
        
        return self
    
    def save_clean_data(self):
        """Step 8: Save clean dataset"""
        self.data_clean.to_csv(self.clean_data_path, index=False)
        print(f"\n✓ Clean dataset saved: {self.clean_data_path.absolute()}")
        print(f"  N = {len(self.data_clean)} | Variables = {len(self.data_clean.columns)}")
        return self
    
    def print_summary(self):
        """Step 9: Print preprocessing summary"""
        print("\n" + "="*70)
        print("✅ PREPROCESSING COMPLETE")
        print("="*70)
        
        # Sample statistics
        print("\nSample Statistics (first 2 constructs):")
        print(f"  PE1: M={self.data_clean['PE1'].mean():.2f}, SD={self.data_clean['PE1'].std():.2f}")
        print(f"  PE2: M={self.data_clean['PE2'].mean():.2f}, SD={self.data_clean['PE2'].std():.2f}")
        
        # Region distribution
        print("\nRegion Distribution (top 5):")
        print(self.data_clean['Region'].value_counts().head(5))
        
        # Duration in valid data
        print(f"\nDuration (valid responses):")
        print(f"  Mean: {self.data_clean['Duration_minutes'].mean():.1f} min")
        print(f"  Median: {self.data_clean['Duration_minutes'].median():.1f} min")
        
        print("\n✓ Data ready for psychometric analysis")
        print("="*70)
        return self
    
    def run_pipeline(self):
        """Execute full preprocessing pipeline"""
        (self
         .load_raw_data()
         .rename_columns()
         .analyze_duration()
         .geolocate_ips()
         .filter_attention_check()
         .convert_to_numeric()
         .create_analysis_dataset()
         .save_clean_data()
         .print_summary())
        
        return self.data_clean


def main():
    """Main execution function"""
    # Define paths
    raw_path = "../data/AIRS---AI-Readiness-Scale.csv"
    clean_path = "../data/AIRS_clean.csv"
    
    # Run preprocessing pipeline
    preprocessor = AIRSPreprocessor(raw_path, clean_path)
    clean_data = preprocessor.run_pipeline()
    
    return clean_data


if __name__ == "__main__":
    main()
