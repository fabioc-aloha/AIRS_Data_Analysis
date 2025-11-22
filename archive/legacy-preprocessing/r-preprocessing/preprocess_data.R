# AIRS Data Preprocessing Script
# ================================
# This script reads the CSV, renames variables to match analysis expectations,
# and creates a clean dataset ready for AIRS_Analysis.Rmd

cat("=== AIRS Data Preprocessing ===\n\n")

# Read the CSV file (skip first 2 rows which are metadata)
data_file <- "c:/Development/AIRS_Data_Analysis/data/AIRS---AI-Readiness-Scale.csv"
data_raw <- read.csv(data_file, skip = 2, stringsAsFactors = FALSE)

cat("Original data: ", nrow(data_raw), "observations,", ncol(data_raw), "variables\n\n")

# Create mapping from column positions to new names
# Columns 14-42 contain the Likert scale items (PE1 through BI4)
old_names <- names(data_raw)[14:42]
new_names <- c(
  "PE1", "PE2",  # Performance Expectancy
  "EE1", "EE2",  # Effort Expectancy
  "SI1", "SI2",  # Social Influence
  "FC1", "FC2",  # Facilitating Conditions
  "HM1", "HM2",  # Hedonic Motivation
  "PV1", "PV2",  # Price Value
  "HB1", "HB2",  # Habit
  "VO1", "VO2",  # Voluntariness
  "TR1", "TR2",  # Trust
  "EX1", "EX2",  # Explainability
  "ATT_CHECK",   # Attention check
  "ER1", "ER2",  # Ethical Risk
  "AX1", "AX2",  # Anxiety
  "BI1", "BI2", "BI3", "BI4"  # Behavioral Intention
)

# Rename the Likert scale columns
names(data_raw)[14:42] <- new_names

# Also rename key demographic and usage variables for easier access
names(data_raw)[12] <- "Consent"
names(data_raw)[13] <- "Status"
names(data_raw)[43:46] <- c("Usage_MSCopilot", "Usage_ChatGPT", "Usage_Gemini", "Usage_Other")
names(data_raw)[47] <- "Education"
names(data_raw)[48] <- "Industry"
names(data_raw)[49] <- "Experience"
names(data_raw)[50] <- "Disability"
names(data_raw)[51] <- "Feedback"

cat("--- Variable Renaming Complete ---\n")
cat("Likert items now named:", paste(new_names[1:5], collapse=", "), "...\n\n")

# Data quality checks and cleaning
cat("--- Data Quality & Cleaning ---\n")

# Check attention check (ATT_CHECK should be 2 = "Disagree")
att_check_table <- table(data_raw$ATT_CHECK, useNA = "always")
cat("Attention check responses:\n")
print(att_check_table)

failed_att <- data_raw$ATT_CHECK != 2 & !is.na(data_raw$ATT_CHECK)
n_failed <- sum(failed_att)
cat(sprintf("\nFailed attention check: %d (%.1f%%)\n", n_failed, 100*n_failed/nrow(data_raw)))

# Filter to valid responses only
data_clean <- data_raw[data_raw$ATT_CHECK == 2 & !is.na(data_raw$ATT_CHECK), ]
cat(sprintf("Removed %d responses, keeping %d valid responses\n\n", 
            nrow(data_raw) - nrow(data_clean), nrow(data_clean)))

# Convert Likert items to numeric (in case they're characters)
likert_vars <- c("PE1", "PE2", "EE1", "EE2", "SI1", "SI2", "FC1", "FC2",
                 "HM1", "HM2", "PV1", "PV2", "HB1", "HB2", "VO1", "VO2",
                 "TR1", "TR2", "EX1", "EX2", "ER1", "ER2", "AX1", "AX2",
                 "BI1", "BI2", "BI3", "BI4")

for (var in likert_vars) {
  data_clean[[var]] <- as.numeric(data_clean[[var]])
}

# Check for missing values in Likert items
cat("--- Missing Data Check ---\n")
missing_counts <- sapply(likert_vars, function(v) sum(is.na(data_clean[[v]])))
if (sum(missing_counts) > 0) {
  cat("Variables with missing data:\n")
  print(missing_counts[missing_counts > 0])
} else {
  cat("✓ No missing data in Likert scale items\n")
}

# Check value ranges (should be 1-5 for 5-point Likert)
cat("\n--- Value Range Check ---\n")
for (var in likert_vars[1:4]) {
  range_vals <- range(data_clean[[var]], na.rm = TRUE)
  cat(sprintf("%s: %d to %d\n", var, range_vals[1], range_vals[2]))
}
cat("... (all items should range 1-5)\n")

# Create a clean dataset with only analysis variables
data_analysis <- data_clean[, c(
  # Session identifiers (optional, for tracking)
  "Session.ID",
  # Likert scale items
  likert_vars,
  # Demographics
  "Status", "Education", "Industry", "Experience", "Disability",
  # Usage frequency
  "Usage_MSCopilot", "Usage_ChatGPT", "Usage_Gemini", "Usage_Other"
)]

# Save the cleaned dataset
output_file <- "c:/Development/AIRS_Data_Analysis/data/AIRS_clean.csv"
write.csv(data_analysis, output_file, row.names = FALSE)
cat("\n✓ Clean dataset saved to:", output_file, "\n")
cat("  Final N =", nrow(data_analysis), "observations\n")
cat("  Variables =", ncol(data_analysis), "\n\n")

# Display summary statistics for first few constructs
cat("--- Sample Descriptive Statistics ---\n")
cat("Performance Expectancy (PE):\n")
cat(sprintf("  PE1: M=%.2f, SD=%.2f\n", mean(data_analysis$PE1, na.rm=TRUE), 
            sd(data_analysis$PE1, na.rm=TRUE)))
cat(sprintf("  PE2: M=%.2f, SD=%.2f\n", mean(data_analysis$PE2, na.rm=TRUE), 
            sd(data_analysis$PE2, na.rm=TRUE)))

cat("\nBehavioral Intention (BI):\n")
cat(sprintf("  BI1: M=%.2f, SD=%.2f\n", mean(data_analysis$BI1, na.rm=TRUE), 
            sd(data_analysis$BI1, na.rm=TRUE)))
cat(sprintf("  BI2: M=%.2f, SD=%.2f\n", mean(data_analysis$BI2, na.rm=TRUE), 
            sd(data_analysis$BI2, na.rm=TRUE)))
cat(sprintf("  BI3: M=%.2f, SD=%.2f\n", mean(data_analysis$BI3, na.rm=TRUE), 
            sd(data_analysis$BI3, na.rm=TRUE)))
cat(sprintf("  BI4: M=%.2f, SD=%.2f\n", mean(data_analysis$BI4, na.rm=TRUE), 
            sd(data_analysis$BI4, na.rm=TRUE)))

cat("\n=== PREPROCESSING COMPLETE ===\n")
cat("✓ Data cleaned and ready for analysis\n")
cat("✓ Use 'data/AIRS_clean.csv' in your R Markdown analysis\n")
cat("✓ Note: BI has 4 items (stronger outcome measure)\n")
cat("✓ Note: Voluntariness (VO) included - consider if needed\n\n")

cat("--- Next Step ---\n")
cat("Update AIRS_Analysis.Rmd to read from 'data/AIRS_clean.csv'\n")
cat("The variable names now match the analysis expectations!\n")
