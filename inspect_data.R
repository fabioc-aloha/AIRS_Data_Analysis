# AIRS Data Inspection Script
# ============================
# This script reads the SPSS .sav file and displays all metadata
# to help you map actual variable names to the analysis requirements

# File path (using CSV version)
data_file <- "c:/Development/AIRS_Data_Analysis/data/AIRS---AI-Readiness-Scale.csv"

cat("=== AIRS Data File Inspection ===\n\n")

# Check if file exists
if (!file.exists(data_file)) {
  cat("ERROR: Data file not found at:", data_file, "\n")
  cat("Current working directory:", getwd(), "\n")
  cat("Please ensure the data file exists or update the path.\n")
  stop("Data file not found")
}

# Read the CSV file
cat("Reading CSV file...\n")
data <- read.csv(data_file, stringsAsFactors = FALSE)

cat("\n--- FILE SUMMARY ---\n")
cat("Number of observations:", nrow(data), "\n")
cat("Number of variables:", ncol(data), "\n\n")

# Display all variable names
cat("--- ALL VARIABLE NAMES ---\n")
var_names <- names(data)
for (i in seq_along(var_names)) {
  cat(sprintf("%2d. %s\n", i, var_names[i]))
}

# Display variable labels and value labels
cat("\n\n--- VARIABLE DETAILS (Name, Label, Type, Values) ---\n")
cat(strrep("=", 80), "\n\n")

for (var_name in var_names) {
  cat("Variable:", var_name, "\n")
  
  # Variable label
  var_label <- attr(data[[var_name]], "label")
  if (!is.null(var_label)) {
    cat("  Label:", var_label, "\n")
  }
  
  # Variable type
  cat("  Type:", class(data[[var_name]])[1], "\n")
  
  # Value labels (for categorical/ordinal variables)
  val_labels <- attr(data[[var_name]], "labels")
  if (!is.null(val_labels) && length(val_labels) > 0) {
    cat("  Value Labels:\n")
    for (j in seq_along(val_labels)) {
      cat(sprintf("    %s = %s\n", val_labels[j], names(val_labels)[j]))
    }
  }
  
  # Sample values (first 5 non-missing)
  sample_vals <- head(na.omit(data[[var_name]]), 5)
  if (length(sample_vals) > 0) {
    cat("  Sample values:", paste(sample_vals, collapse=", "), "\n")
  }
  
  # Missing data count
  missing_count <- sum(is.na(data[[var_name]]))
  if (missing_count > 0) {
    cat("  Missing:", missing_count, "(", 
        round(100*missing_count/nrow(data), 1), "%)\n")
  }
  
  cat("\n")
}

cat(strrep("=", 80), "\n")

# Expected constructs for AIRS analysis
cat("\n--- EXPECTED CONSTRUCTS FOR ANALYSIS ---\n")
cat("The analysis expects 12 constructs with 2-4 items each:\n\n")

expected_constructs <- data.frame(
  Construct = c("PE", "EE", "SI", "FC", "HM", "PV", "HB", 
                "TR", "EX", "ER", "AX", "BI"),
  Name = c("Performance Expectancy", "Effort Expectancy", 
           "Social Influence", "Facilitating Conditions",
           "Hedonic Motivation", "Price Value", "Habit",
           "Trust", "Explainability", "Ethical Risk",
           "Anxiety", "Behavioral Intention (AI Adoption)"),
  Items = c(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 4),
  stringsAsFactors = FALSE
)

print(expected_constructs, row.names = FALSE)

cat("\n--- NEXT STEPS ---\n")
cat("1. Compare the variable names above with the expected constructs\n")
cat("2. Create a mapping file to rename variables for the analysis\n")
cat("3. Run: source('create_variable_mapping.R') to generate mapping code\n\n")

# Save variable info to CSV for easy reference
var_info <- data.frame(
  Position = seq_along(var_names),
  Variable_Name = var_names,
  Variable_Label = sapply(var_names, function(v) {
    label <- attr(data[[v]], "label")
    if (is.null(label)) "" else label
  }),
  Type = sapply(var_names, function(v) class(data[[v]])[1]),
  N_Missing = sapply(var_names, function(v) sum(is.na(data[[v]]))),
  stringsAsFactors = FALSE
)

output_file <- "c:/Development/AIRS_Data_Analysis/data_variable_info.csv"
write.csv(var_info, output_file, row.names = FALSE)
cat("Variable information saved to:", output_file, "\n")
cat("Open this file in Excel to help create your variable mapping.\n")
