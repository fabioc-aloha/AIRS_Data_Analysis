# AIRS Data Variable Mapping
# ============================
# Based on the SPSS file structure, here are the actual variable names

# Install/load required packages
if (!require("haven")) install.packages("haven")
if (!require("foreign")) install.packages("foreign")

cat("=== AIRS Variable Mapping Guide ===\n\n")

# Try different SPSS readers
data_file <- "c:/Development/AIRS_Data_Analysis/data/AIRS---AI-Readiness-Scale.sav"

cat("Attempting to read file with different methods...\n\n")

# Method 1: haven::read_sav
data <- NULL
method_used <- NULL

tryCatch({
  cat("Method 1: haven::read_sav()...\n")
  data <- haven::read_sav(data_file, encoding = NULL)
  method_used <- "haven::read_sav"
  cat("✓ Success with haven::read_sav\n\n")
}, error = function(e) {
  cat("✗ Failed:", e$message, "\n\n")
})

# Method 2: foreign::read.spss
if (is.null(data)) {
  tryCatch({
    cat("Method 2: foreign::read.spss()...\n")
    library(foreign)
    data <- read.spss(data_file, to.data.frame = TRUE, use.value.labels = FALSE)
    method_used <- "foreign::read.spss"
    cat("✓ Success with foreign::read.spss\n\n")
  }, error = function(e) {
    cat("✗ Failed:", e$message, "\n\n")
  })
}

# If still failed, provide manual mapping based on error message
if (is.null(data)) {
  cat("=== AUTOMATIC READING FAILED ===\n")
  cat("However, I can see the variable structure from the error message!\n\n")
  
  cat("--- OBSERVED VARIABLE MAPPING ---\n")
  cat("Based on the error, your actual variables are:\n\n")
  
  # Variables extracted from error message
  variables <- c(
    "Q4_AI_tools_help_me_accomplish_tasks_more_quickly",
    "Q5_Using_AI_improves_the_quality_of_my_work_or_studies",
    "Q6_Learning_to_use_AI_tools_is_easy_for_me",
    "Q7_Interacting_with_AI_tools_is_clear_and_understandable",
    "Q8_People_whose_opinions_I_value_encourage_me_to_use_AI_tools",
    "Q9_Leaders_in_my_organization_or_school_support_the_use_of_AI_tools",
    "Q10_I_have_access_to_training_or_tutorials_for_the_AI_tools_I_use",
    "Q11_The_AI_tools_I_use_are_compatible_with_other_tools_or_systems_I_use",
    "Q12_Using_AI_tools_is_stimulating_and_engaging",
    "Q13_AI_tools_make_my_work_or_studies_more_interesting",
    "Q14_I_get_more_value_from_AI_tools_than_the_effort_they_require",
    "Q15_Using_AI_tools_is_worth_the_learning_curve",
    "Q16_Using_AI_tools_has_become_a_habit_for_me",
    "Q17_I_tend_to_rely_on_AI_tools_by_default_when_I_need_help_with_tasks",
    "Q18_I_choose_to_use_AI_tools_in_my_work_because_I_find_them_helpful",
    "Q19_I_could_choose_not_to_use_AI_tools_in_my_work_or_studies_if_I_preferred",
    "Q20_I_trust_AI_tools_to_provide_reliable_information",
    "Q21_I_trust_the_AI_tools_that_are_available_to_me",
    "Q22_I_understand_how_the_AI_tools_I_use_generate_their_outputs",
    "Q23_I_prefer_AI_tools_that_explain_their_recommendations",
    "Q24_To_show_that_you_are_paying_attention_please_select_Disagree", # Attention check
    "Q25_I_worry_that_AI_tools_could_replace_jobs_in_my_field",
    "Q26_I_am_concerned_about_privacy_risks_when_using_AI_tools",
    "Q27_I_feel_uneasy_about_the_increasing_use_of_AI",
    "Q28_I_worry_that_I_may_be_left_behind_if_I_do_not_keep_up_with_AI",
    "Q29_I_am_ready_to_use_more_AI_tools_in_my_work_or_studies",
    "Q30_I_would_recommend_AI_tools_to_others"
  )
  
  # Create mapping based on UTAUT2 + AIRS constructs
  mapping <- data.frame(
    Original_Variable = c(
      "Q4_AI_tools_help_me_accomplish_tasks_more_quickly",
      "Q5_Using_AI_improves_the_quality_of_my_work_or_studies",
      "Q6_Learning_to_use_AI_tools_is_easy_for_me",
      "Q7_Interacting_with_AI_tools_is_clear_and_understandable",
      "Q8_People_whose_opinions_I_value_encourage_me_to_use_AI_tools",
      "Q9_Leaders_in_my_organization_or_school_support_the_use_of_AI_tools",
      "Q10_I_have_access_to_training_or_tutorials_for_the_AI_tools_I_use",
      "Q11_The_AI_tools_I_use_are_compatible_with_other_tools_or_systems_I_use",
      "Q12_Using_AI_tools_is_stimulating_and_engaging",
      "Q13_AI_tools_make_my_work_or_studies_more_interesting",
      "Q14_I_get_more_value_from_AI_tools_than_the_effort_they_require",
      "Q15_Using_AI_tools_is_worth_the_learning_curve",
      "Q16_Using_AI_tools_has_become_a_habit_for_me",
      "Q17_I_tend_to_rely_on_AI_tools_by_default_when_I_need_help_with_tasks",
      "Q18_I_choose_to_use_AI_tools_in_my_work_because_I_find_them_helpful",
      "Q19_I_could_choose_not_to_use_AI_tools_in_my_work_or_studies_if_I_preferred",
      "Q20_I_trust_AI_tools_to_provide_reliable_information",
      "Q21_I_trust_the_AI_tools_that_are_available_to_me",
      "Q22_I_understand_how_the_AI_tools_I_use_generate_their_outputs",
      "Q23_I_prefer_AI_tools_that_explain_their_recommendations",
      "Q25_I_worry_that_AI_tools_could_replace_jobs_in_my_field",
      "Q26_I_am_concerned_about_privacy_risks_when_using_AI_tools",
      "Q27_I_feel_uneasy_about_the_increasing_use_of_AI",
      "Q28_I_worry_that_I_may_be_left_behind_if_I_do_not_keep_up_with_AI",
      "Q29_I_am_ready_to_use_more_AI_tools_in_my_work_or_studies",
      "Q30_I_would_recommend_AI_tools_to_others"
    ),
    New_Variable = c(
      "PE1", "PE2",  # Performance Expectancy
      "EE1", "EE2",  # Effort Expectancy
      "SI1", "SI2",  # Social Influence
      "FC1", "FC2",  # Facilitating Conditions
      "HM1", "HM2",  # Hedonic Motivation
      "PV1", "PV2",  # Price Value
      "HB1", "HB2",  # Habit
      "VO1", "VO2",  # Voluntariness (maps to HB or separate)
      "TR1", "TR2",  # Trust
      "EX1", "EX2",  # Explainability
      "ER1", "ER2",  # Ethical Risk
      "AX1", "AX2",  # Anxiety
      "BI1", "BI2"   # Behavioral Intention
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
      "Ethical Risk", "Ethical Risk",
      "Anxiety", "Anxiety",
      "Behavioral Intention", "Behavioral Intention"
    ),
    stringsAsFactors = FALSE
  )
  
  print(mapping, row.names = FALSE)
  
  # Save mapping
# Save mapping to CSV
write.csv(mapping, "c:/Development/AIRS_Data_Analysis/variable_mapping.csv", row.names = FALSE)
cat("\n✓ Variable mapping saved to: c:/Development/AIRS_Data_Analysis/variable_mapping.csv\n\n")  cat("--- NEXT STEPS ---\n")
  cat("1. Review the mapping above - adjust construct assignments if needed\n")
  cat("2. Note: Q24 is an attention check item (excluded from analysis)\n")
  cat("3. Try exporting your SPSS file to CSV format in SPSS\n")
  cat("4. Or we can create a preprocessing script using the CSV export\n\n")
  
  cat("--- ALTERNATIVE: Export from SPSS ---\n")
  cat("In SPSS: File > Save As > CSV (*.csv)\n")
  cat("Then we can read it with: read.csv('your_file.csv')\n")
  
} else {
  # Successfully read data
  cat("=== DATA SUCCESSFULLY LOADED ===\n")
  cat("Method used:", method_used, "\n")
  cat("Observations:", nrow(data), "\n")
  cat("Variables:", ncol(data), "\n\n")
  
  cat("--- VARIABLE NAMES ---\n")
  print(names(data))
}
