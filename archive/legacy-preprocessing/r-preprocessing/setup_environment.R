# AIRS Analysis - RStudio Environment Setup
# Run this script once to install all required packages
# =======================================================

cat("=== AIRS Analysis Environment Setup ===\n\n")

# Function to install packages if not already installed
install_if_missing <- function(packages) {
  new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
  if(length(new_packages) > 0) {
    cat("Installing:", paste(new_packages, collapse=", "), "\n")
    install.packages(new_packages, dependencies = TRUE)
  } else {
    cat("All packages already installed!\n")
  }
}

# Core packages required for AIRS analysis
required_packages <- c(
  # Data Import & Manipulation
  "haven",        # Read SPSS .sav files
  "tidyverse",    # Data manipulation (dplyr, ggplot2, etc.)
  
  # Psychometric Analysis
  "psych",        # EFA, reliability, descriptive stats
  "lavaan",       # CFA and SEM (gold standard)
  "semTools",     # Advanced SEM utilities (reliability, invariance)
  
  # Normality & Diagnostics
  "MVN",          # Multivariate normality tests
  "car",          # VIF and other diagnostics
  
  # Visualization
  "semPlot",      # Path diagrams for SEM models
  "corrplot",     # Correlation matrices
  "GGally",       # Advanced ggplot extensions
  
  # Reporting
  "knitr",        # R Markdown processing
  "rmarkdown",    # Knit to HTML/PDF/Word
  "kableExtra"    # Beautiful tables for reports
)

cat("\n--- Installing Required Packages ---\n")
install_if_missing(required_packages)

cat("\n--- Verifying Installation ---\n")
# Test loading each package
success <- TRUE
for(pkg in required_packages) {
  result <- tryCatch({
    library(pkg, character.only = TRUE, quietly = TRUE)
    cat("✓", pkg, "\n")
    TRUE
  }, error = function(e) {
    cat("✗", pkg, "- FAILED:", e$message, "\n")
    FALSE
  })
  if(!result) success <- FALSE
}

if(success) {
  cat("\n=== Setup Complete! ===\n")
  cat("All packages installed and verified.\n")
  cat("You can now open AIRS_Analysis.Rmd in RStudio and click 'Knit'.\n\n")
} else {
  cat("\n=== Setup Incomplete ===\n")
  cat("Some packages failed to install. Please check error messages above.\n")
  cat("You may need to install additional system dependencies.\n\n")
}

# Display R and RStudio information
cat("--- System Information ---\n")
cat("R Version:", R.version.string, "\n")
cat("Working Directory:", getwd(), "\n")
cat("\nRecommended: Set working directory to project root before running analysis.\n")
cat("In RStudio: Session > Set Working Directory > To Project Directory\n")
