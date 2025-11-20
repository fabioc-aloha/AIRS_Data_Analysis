# AIRS CSV Data Analysis and Variable Mapping
# ============================================

# Read CSV file
data_file <- "c:/Development/AIRS_Data_Analysis/data/AIRS---AI-Readiness-Scale.csv"
cat("=== AIRS CSV Data Analysis ===\n\n")

# Read the data (skip first 2 rows which are metadata)
data <- read.csv(data_file, skip = 2, stringsAsFactors = FALSE)

cat("--- DATA SUMMARY ---\n")
cat("Total observations:", nrow(data), "\n")
cat("Total variables:", ncol(data), "\n\n")

# Display variable names
cat("--- VARIABLE NAMES ---\n")
var_names <- names(data)
for (i in seq_along(var_names)) {
  cat(sprintf("%2d. %s\n", i, var_names[i]))
}

# Identify the survey item columns (Q4-Q32 are the Likert items)
survey_items <- var_names[grep("^Q[0-9]+$", var_names)]
cat("\n--- SURVEY ITEMS (Likert Scale Questions) ---\n")
cat("Items:", paste(survey_items, collapse=", "), "\n\n")

# Extract Q4-Q32 (the actual scale items)
likert_items <- paste0("Q", 4:32)
cat("--- LIKERT SCALE ITEMS (Q4-Q32) ---\n")

# Create the variable mapping based on UTAUT2 + AIRS framework
mapping <- data.frame(
  Question = likert_items,
  New_Name = c(
    "PE1", "PE2",  # Q4-Q5: Performance Expectancy
    "EE1", "EE2",  # Q6-Q7: Effort Expectancy  
    "SI1", "SI2",  # Q8-Q9: Social Influence
    "FC1", "FC2",  # Q10-Q11: Facilitating Conditions
    "HM1", "HM2",  # Q12-Q13: Hedonic Motivation
    "PV1", "PV2",  # Q14-Q15: Price Value
    "HB1", "HB2",  # Q16-Q17: Habit
    "VO1", "VO2",  # Q18-Q19: Voluntariness
    "TR1", "TR2",  # Q20-Q21: Trust
    "EX1", "EX2",  # Q22-Q23: Explainability
    "ATT_CHECK",   # Q24: Attention check (EXCLUDE from analysis)
    "ER1", "ER2",  # Q25-Q26: Ethical Risk
    "AX1", "AX2",  # Q27-Q28: Anxiety
    "BI1", "BI2", "BI3", "BI4"  # Q29-Q32: Behavioral Intention (4 items)
  ),
  Construct = c(
    "Performance Expectancy", "Performance Expectancy",
    "Effort Expectancy", "Effort Expectancy",
    "Social Influence", "Social Influence",
    "Facilitating Conditions", "Facilitating Conditions",
    "Hedonic Motivation", "Hedonic Motivation",
    "Price Value", "Price Value",
    "Habit", "Habit",
    "Voluntariness", "Voluntariness",
    "Trust", "Trust",
    "Explainability", "Explainability",
    "ATTENTION CHECK - EXCLUDE",
    "Ethical Risk", "Ethical Risk",
    "Anxiety", "Anxiety",
    "Behavioral Intention", "Behavioral Intention", "Behavioral Intention", "Behavioral Intention"
  ),
  stringsAsFactors = FALSE
)

print(mapping, row.names = FALSE)

# Check data quality
cat("\n--- DATA QUALITY CHECKS ---\n")

# Check for missing data in Likert items
for (item in likert_items) {
  if (item %in% names(data)) {
    missing <- sum(is.na(data[[item]]) | data[[item]] == "")
    if (missing > 0) {
      cat(sprintf("%s: %d missing (%.1f%%)\n", item, missing, 100*missing/nrow(data)))
    }
  }
}

# Check value ranges for Likert items
cat("\n--- VALUE RANGES ---\n")
for (item in likert_items[1:5]) {  # Show first 5 as examples
  if (item %in% names(data)) {
    values <- na.omit(data[[item]])
    cat(sprintf("%s: Range %s to %s\n", item, min(values, na.rm=TRUE), max(values, na.rm=TRUE)))
  }
}

# Attention check validation (Q24 should be answered "2" = Disagree)
if ("Q24" %in% names(data)) {
  cat("\n--- ATTENTION CHECK (Q24) ---\n")
  q24_values <- table(data$Q24, useNA = "always")
  print(q24_values)
  failed <- sum(data$Q24 != 2, na.rm = TRUE)
  cat(sprintf("Failed attention check: %d respondents (%.1f%%)\n", 
              failed, 100*failed/nrow(data)))
}

# Demographics
cat("\n--- DEMOGRAPHIC VARIABLES ---\n")
demo_vars <- c("Q1", "Q2", "Q3", "Q37", "Q38", "Q39", "Q40")
for (v in demo_vars) {
  if (v %in% names(data)) {
    cat(sprintf("%s: Present\n", v))
  }
}

# Usage frequency (Q33-Q36)
cat("\n--- USAGE FREQUENCY VARIABLES ---\n")
usage_vars <- c("Q33", "Q34", "Q35", "Q36")
for (v in usage_vars) {
  if (v %in% names(data)) {
    cat(sprintf("%s: Present\n", v))
  }
}

# Save mapping to CSV
write.csv(mapping, "c:/Development/AIRS_Data_Analysis/variable_mapping.csv", row.names = FALSE)
cat("\n✓ Variable mapping saved to: c:/Development/AIRS_Data_Analysis/variable_mapping.csv\n")

cat("\n=== SUMMARY ===\n")
cat("✓ Data has", nrow(data), "complete responses\n")
cat("✓ Main analysis items: Q4-Q32 (29 items total)\n")
cat("✓ 12 constructs identified (including Voluntariness)\n")
cat("⚠ Q24 is attention check - exclude from analysis\n")
cat("✓ 4 BI items (outcome variable) instead of expected 2\n")
cat("✓ Usage frequency and demographics available\n\n")

cat("--- NEXT STEPS ---\n")
cat("1. Review variable_mapping.csv to confirm construct assignments\n")
cat("2. Consider excluding Voluntariness (VO) if not in original UTAUT2\n")
cat("3. Update AIRS_Analysis.Rmd to use these variable names\n")
cat("4. Run analysis with attention check filter (Q24 == 2)\n")
