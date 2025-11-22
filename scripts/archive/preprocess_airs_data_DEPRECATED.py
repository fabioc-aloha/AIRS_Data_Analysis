"""
AIRS Data Preprocessing Pipeline
==================================
Converts raw Centiment survey data to clean analysis-ready dataset.

Input:  data/AIRS---AI-Readiness-Scale.csv (raw Centiment export)
Output: data/AIRS_clean.csv (analysis-ready dataset)

Processing Steps:
1. Load raw data (skip Centiment metadata rows)
2. Rename columns to construct/item codes
3. Filter for complete surveys only
4. Duration analysis and quality checks
5. IP geolocation (IP → US state codes)
6. Attention check filtering
7. Convert to numeric and validate ranges
8. Create analysis dataset with control variables
9. Save clean dataset

Quality Control Features:
- Survey completion filtering (only "complete" status included)
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
        """Step 1: Load raw Centiment export (skip metadata rows)"""
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
            self.data_raw.columns[6]: "Survey_Status",  # Survey completion status (e.g., "complete")
            self.data_raw.columns[8]: "Duration_seconds",
            self.data_raw.columns[9]: "IP_Address",
            self.data_raw.columns[11]: "Consent",
            self.data_raw.columns[12]: "Role",  # Respondent role (1-8 numeric codes)
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
    
    def filter_complete_surveys(self):
        """Step 3: Filter for complete surveys only"""
        print("\n--- Survey Completion Status ---")
        
        # Display completion status distribution
        status_counts = self.data_raw['Survey_Status'].value_counts(dropna=False)
        print(f"Survey status distribution:\n{status_counts}\n")
        
        # Filter for complete surveys
        initial_n = len(self.data_raw)
        self.data_raw = self.data_raw[self.data_raw['Survey_Status'] == 'complete'].copy()
        filtered_n = len(self.data_raw)
        removed_n = initial_n - filtered_n
        
        print(f"✓ Complete surveys: {filtered_n}")
        print(f"✗ Incomplete surveys removed: {removed_n} ({100*removed_n/initial_n:.1f}%)")
        
        return self
    
    def analyze_duration(self):
        """Step 4: Duration analysis and quality checks"""
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
        """Step 5: Convert IP addresses to US state codes using ipinfo.io"""
        print("\n--- IP Geolocation Processing ---")
        
        unique_ips = self.data_raw['IP_Address'].dropna().unique()
        print(f"Processing {len(unique_ips)} unique IP addresses...")
        print("Using ipinfo.io (50,000 requests/month free) with ip-api.com fallback")
        
        ip_to_region = {}
        for i, ip in enumerate(unique_ips):
            ip_to_region[ip] = self._get_location_from_ip(ip)
            
            # Rate limiting: Process in batches with progress updates
            if (i + 1) % 50 == 0:
                print(f"  Processed {i + 1}/{len(unique_ips)} IPs...")
                sleep(1)  # Brief pause to avoid overwhelming the API
        
        self.data_raw['Region'] = self.data_raw['IP_Address'].map(ip_to_region).fillna('Unknown')
        
        region_counts = self.data_raw['Region'].value_counts()
        unknown_count = (self.data_raw['Region'] == 'Unknown').sum()
        success_rate = ((len(self.data_raw) - unknown_count) / len(self.data_raw) * 100)
        
        print(f"✓ Geolocation complete: {len(region_counts)} unique regions")
        print(f"  Success rate: {success_rate:.1f}% ({len(self.data_raw) - unknown_count}/{len(self.data_raw)} IPs resolved)")
        print(f"\nTop 5 regions:")
        print(region_counts.head(5))
        
        return self
    
    @staticmethod
    def _get_location_from_ip(ip_address):
        """Helper: Convert IP to region using ipinfo.io (more reliable, 50k/month free)"""
        if pd.isna(ip_address) or ip_address == '':
            return 'Unknown'
        
        try:
            # Try ipinfo.io first (more reliable)
            response = requests.get(f'https://ipinfo.io/{ip_address}/json', timeout=5)
            if response.status_code == 200:
                data = response.json()
                country = data.get('country', '')
                
                if country == 'US':
                    # For US IPs, return state code
                    region = data.get('region', 'Unknown')
                    return region if region else 'Unknown'
                elif country:
                    # For non-US, return country code
                    return f"Non-US_{country}"
                    
            # Fallback to ip-api.com if ipinfo fails
            response = requests.get(f'http://ip-api.com/json/{ip_address}', timeout=5)
            if response.status_code == 200:
                data = response.json()
                if data.get('status') == 'success':
                    country_code = data.get('countryCode', '')
                    if country_code == 'US':
                        return data.get('region', 'Unknown')
                    elif country_code:
                        return f"Non-US_{country_code}"
                        
            return 'Unknown'
        except Exception as e:
            return 'Unknown'
    
    def filter_attention_check(self):
        """Step 6: Filter responses that failed attention check"""
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
        """Step 7: Convert Likert items to numeric"""
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
    
    def apply_demographic_labels(self):
        """Step 8: Apply human-readable labels to demographic variables"""
        print("\n--- Applying Demographic Labels ---")
        
        # Role labels (already numeric 1-8 in data)
        role_labels = {
            1: 'Student',
            2: 'Instructor/Teacher',
            3: 'Administrator',
            4: 'IT Professional',
            5: 'Researcher',
            6: 'Business Professional',
            7: 'Healthcare Professional',
            8: 'Other'
        }
        
        # Education labels
        education_labels = {
            1: 'High School',
            2: 'Some College',
            3: "Associate's Degree",
            4: "Bachelor's Degree",
            5: "Master's Degree",
            6: 'Doctoral Degree'
        }
        
        # Industry labels
        industry_labels = {
            1: 'Healthcare',
            2: 'Technology',
            3: 'Manufacturing',
            4: 'Retail',
            5: 'Finance',
            6: 'Government',
            7: 'Non-profit',
            8: 'Other',
            9: 'Education'
        }
        
        # Experience labels
        experience_labels = {
            1: 'Less than 1 year',
            2: '1-3 years',
            3: '4-6 years',
            4: '7-10 years',
            5: 'More than 10 years'
        }
        
        # Disability labels
        disability_labels = {
            1: 'Yes',
            2: 'No',
            3: 'Prefer not to say'
        }
        
        # Apply mappings
        self.data_clean['Role'] = self.data_clean['Role'].map(role_labels)
        self.data_clean['Education'] = self.data_clean['Education'].map(education_labels)
        self.data_clean['Industry'] = self.data_clean['Industry'].map(industry_labels)
        self.data_clean['Experience'] = self.data_clean['Experience'].map(experience_labels)
        self.data_clean['Disability'] = self.data_clean['Disability'].map(disability_labels)
        
        print("✓ Applied labels: Role, Education, Industry, Experience, Disability")
        print("✓ Demographic variables now use human-readable labels")
        
        return self
    
    def create_ai_adoption_groupings(self):
        """Step 9: Create AI tool adoption grouping variables"""
        print("\n--- AI Adoption Groupings ---")
        
        usage_cols = ['Usage_ChatGPT', 'Usage_MSCopilot', 'Usage_Gemini', 'Usage_Other']
        
        # 1. AI_Adoption: Binary indicator (0=never uses any tool, 1=uses at least one tool)
        def classify_ai_adoption(row):
            """Binary: 0 = never uses any AI tool, 1 = uses at least one AI tool"""
            # If ALL usage columns equal 1 (Never), then AI_Adoption = 0
            never_all = all(row[col] == 1 for col in usage_cols if pd.notna(row[col]))
            return 0 if never_all else 1
        
        self.data_clean['AI_Adoption'] = self.data_clean.apply(classify_ai_adoption, axis=1)
        
        # 2. AI_Adoption_Level: Categorical (None/Single/Multiple tool adoption)
        def classify_adoption_level(row):
            """Categorize as None, Single, or Multiple tool user"""
            # Count how many tools are used (usage > 1 means sometimes/often/always)
            tools_used = sum(row[col] > 1 for col in usage_cols if pd.notna(row[col]))
            
            if tools_used == 0:
                return 'None'
            elif tools_used == 1:
                return 'Single'
            else:
                return 'Multiple'
        
        self.data_clean['AI_Adoption_Level'] = self.data_clean.apply(classify_adoption_level, axis=1)
        
        # 3. Primary_Tool: Identify which tool is used most frequently
        def identify_primary_tool(row):
            """Identify the most frequently used AI tool"""
            if row['AI_Adoption'] == 0:
                return 'None'
            
            # Find tool with highest usage score
            tool_scores = {
                'ChatGPT': row['Usage_ChatGPT'],
                'MSCopilot': row['Usage_MSCopilot'],
                'Gemini': row['Usage_Gemini'],
                'Other': row['Usage_Other']
            }
            
            # Remove tools with usage = 1 (Never)
            active_tools = {k: v for k, v in tool_scores.items() if v > 1}
            
            if not active_tools:
                return 'None'
            
            # Return tool with highest usage
            return max(active_tools, key=active_tools.get)
        
        self.data_clean['Primary_Tool'] = self.data_clean.apply(identify_primary_tool, axis=1)
        
        # Report statistics
        adopters = (self.data_clean['AI_Adoption'] == 1).sum()
        non_adopters = (self.data_clean['AI_Adoption'] == 0).sum()
        
        print(f"✓ Created AI_Adoption: {adopters} adopters ({adopters/len(self.data_clean)*100:.1f}%), {non_adopters} non-adopters ({non_adopters/len(self.data_clean)*100:.1f}%)")
        print(f"✓ Created AI_Adoption_Level: {self.data_clean['AI_Adoption_Level'].value_counts().to_dict()}")
        print(f"✓ Created Primary_Tool: {self.data_clean['Primary_Tool'].value_counts().to_dict()}")
        
        return self
    
    def create_demographic_groupings(self):
        """Step 10: Create demographic grouping variables"""
        print("\n--- Demographic Groupings ---")
        
        # 1. Experience_Level: Career stage progression (5 levels)
        experience_mapping = {
            'Less than 1 year': 'Entry',
            '1-3 years': 'Early',
            '4-6 years': 'Mid',
            '7-10 years': 'Senior',
            'More than 10 years': 'Expert'
        }
        self.data_clean['Experience_Level'] = self.data_clean['Experience'].map(experience_mapping)
        
        # 2. Work_Context: Learning vs Teaching vs Professional context (3 categories)
        def classify_work_context(row):
            """Classify work context based on role"""
            if row['Role'] == 'Student':
                return 'Academic-Student'
            elif row['Role'] in ['Instructor/Teacher', 'Researcher']:
                return 'Academic-Faculty'
            else:
                return 'Professional'
        
        self.data_clean['Work_Context'] = self.data_clean.apply(classify_work_context, axis=1)
        
        # 3. Usage_Intensity: AI engagement level beyond binary adoption (4 levels)
        usage_cols = ['Usage_ChatGPT', 'Usage_MSCopilot', 'Usage_Gemini', 'Usage_Other']
        self.data_clean['Total_Usage_Score'] = self.data_clean[usage_cols].sum(axis=1)
        
        def classify_usage_intensity(score):
            """Categorize usage intensity from total usage score"""
            if score <= 4:  # All "Never" = 4
                return 'Non-User'
            elif score <= 8:  # Low usage
                return 'Low'
            elif score <= 12:  # Medium usage
                return 'Medium'
            else:  # High usage (13-20)
                return 'High'
        
        self.data_clean['Usage_Intensity'] = self.data_clean['Total_Usage_Score'].apply(classify_usage_intensity)
        
        # Report statistics
        print(f"✓ Created Experience_Level: {self.data_clean['Experience_Level'].value_counts().to_dict()}")
        print(f"✓ Created Work_Context: {self.data_clean['Work_Context'].value_counts().to_dict()}")
        print(f"✓ Created Usage_Intensity: {self.data_clean['Usage_Intensity'].value_counts().to_dict()}")
        
        return self
    
    def create_analysis_dataset(self):
        """Step 11: Create final analysis dataset"""
        print("\n--- Dataset Creation ---")
        
        likert_vars = [name for name in self.item_names if name != "ATT_CHECK"]
        
        analysis_vars = (
            ["Duration_minutes"] +  # Control variables (Region removed due to poor geolocation)
            likert_vars +  # 28 Likert items
            ["Role", "Education", "Industry", "Experience", "Disability"] +  # Demographics
            ["Usage_MSCopilot", "Usage_ChatGPT", "Usage_Gemini", "Usage_Other"] +  # Usage frequency
            ["AI_Adoption", "AI_Adoption_Level", "Primary_Tool"] +  # AI adoption groupings
            ["Experience_Level", "Work_Context", "Usage_Intensity", "Total_Usage_Score"]  # Demographic groupings
        )
        
        self.data_clean = self.data_clean[analysis_vars].copy()
        
        print(f"✓ Analysis dataset: {len(self.data_clean)} obs × {len(self.data_clean.columns)} vars")
        print("✓ Includes: Duration_minutes, 28 Likert items, demographics, usage")
        print("✓ Privacy: IP addresses and geolocation data excluded")
        
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
        
        # Duration in valid data
        print(f"\nDuration (valid responses):")
        print(f"  Mean: {self.data_clean['Duration_minutes'].mean():.1f} min")
        print(f"  Median: {self.data_clean['Duration_minutes'].median():.1f} min")
        
        # Role distribution
        print("\nRole Distribution (top 5):")
        print(self.data_clean['Role'].value_counts().head(5))
        
        print("\n✓ Data ready for psychometric analysis")
        print("="*70)
        return self
    
    def run_pipeline(self):
        """Execute full preprocessing pipeline"""
        (self
         .load_raw_data()
         .rename_columns()
         .filter_complete_surveys()
         .analyze_duration()
         # .geolocate_ips()  # Skipped: 67.6% IPs are private/VPN (unresolvable)
         .filter_attention_check()
         .convert_to_numeric()
         .apply_demographic_labels()
         .create_ai_adoption_groupings()
         .create_demographic_groupings()
         .create_analysis_dataset()
         .save_clean_data()
         .print_summary())
        
        return self.data_clean


def main():
    """Main execution function"""
    # Define paths relative to script location
    script_dir = Path(__file__).parent
    project_dir = script_dir.parent
    raw_path = project_dir / "data" / "AIRS---AI-Readiness-Scale.csv"
    clean_path = project_dir / "data" / "AIRS_clean.csv"
    
    # Run preprocessing pipeline
    preprocessor = AIRSPreprocessor(raw_path, clean_path)
    clean_data = preprocessor.run_pipeline()
    
    return clean_data


if __name__ == "__main__":
    main()
