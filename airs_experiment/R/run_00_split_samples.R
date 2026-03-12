#!/usr/bin/env Rscript
# =============================================================================
# AIRS Phase 0: Create Split Samples (R port)
# Mirrors: python/run_00_split_samples.py
#
# Loads raw survey data, transforms columns, creates stratified EFA/CFA split.
# Outputs: data/AIRS_clean.csv, data/AIRS_experiment.csv, data/AIRS_holdout.csv,
#          data/experiment_config.json, data/airs_28item_complete.json,
#          data/sample_characteristics.json, plots/sample_preparation_overview.png
# =============================================================================

library(jsonlite)
library(ggplot2)
library(caTools)

cat(paste(rep("=", 90), collapse = ""), "\n")
cat("PHASE 0: CREATE SPLIT SAMPLES\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

dir.create("data", showWarnings = FALSE)
dir.create("plots", showWarnings = FALSE)

# =============================================================================
# CONFIGURATION
# =============================================================================

HOLDOUT_RATIO <- 0.50
RANDOM_SEED <- 67

ITEMS <- data.frame(
    code = c(
        "PE1", "PE2", "EE1", "EE2", "SI1", "SI2", "FC1", "FC2",
        "HM1", "HM2", "PV1", "PV2", "HB1", "HB2", "VO1", "VO2",
        "TR1", "TR2", "EX1", "EX2", "ER1", "ER2", "AX1", "AX2",
        "BI1", "BI2", "BI3", "BI4"
    ),
    construct = c(
        rep("Performance Expectancy", 2), rep("Effort Expectancy", 2),
        rep("Social Influence", 2), rep("Facilitating Conditions", 2),
        rep("Hedonic Motivation", 2), rep("Price Value", 2),
        rep("Habit", 2), rep("Voluntariness", 2),
        rep("Trust in AI", 2), rep("Explainability", 2),
        rep("Perceived Ethical Risk", 2), rep("AI Anxiety", 2),
        rep("Behavioral Intention", 4)
    ),
    direction = c(
        rep("POSITIVE", 16), rep("POSITIVE", 2), rep("POSITIVE", 2),
        rep("NEGATIVE", 2), rep("NEGATIVE", 2), rep("POSITIVE", 4)
    ),
    stringsAsFactors = FALSE
)

LIKERT_ITEMS <- ITEMS$code
PREDICTOR_ITEMS <- ITEMS$code[!grepl("^BI", ITEMS$code)]
OUTCOME_ITEMS <- ITEMS$code[grepl("^BI", ITEMS$code)]
USAGE_ITEMS <- c("Usage_MSCopilot", "Usage_ChatGPT", "Usage_Gemini", "Usage_Other")

# Column mapping: original Qualtrics long names -> short codes
COLUMN_MAP <- c(
    "Duration (seconds)" = "Duration_seconds",
    "Performance Expectancy: How much do you agree with these statements about how AI tools help you get things done? | AI tools help me accomplish tasks more quickly" = "PE1",
    "Performance Expectancy: How much do you agree with these statements about how AI tools help you get things done? | Using AI improves the quality of my work or studies" = "PE2",
    "Effort Expectancy: How much do you agree with these statements about how easy AI tools are to learn and use? | Learning to use AI tools is easy for me" = "EE1",
    "Effort Expectancy: How much do you agree with these statements about how easy AI tools are to learn and use? | Interacting with AI tools is clear and understandable" = "EE2",
    "Social Influence: How much do you agree with these statements about the people around you and their views on using AI? | People whose opinions I value encourage me to use AI tools" = "SI1",
    "Social Influence: How much do you agree with these statements about the people around you and their views on using AI? | Leaders in my organization or school support the use of AI tools" = "SI2",
    "Facilitating Conditions: How much do you agree with these statements about the resources and support you have for using AI? | I have access to training or tutorials for the AI tools I use" = "FC1",
    "Facilitating Conditions: How much do you agree with these statements about the resources and support you have for using AI? | The AI tools I use are compatible with other tools or systems I use" = "FC2",
    "Hedonic Motivation (Perceived Enjoyment): How much do you agree with these statements about enjoyment when using AI tools? | Using AI tools is stimulating and engaging" = "HM1",
    "Hedonic Motivation (Perceived Enjoyment): How much do you agree with these statements about enjoyment when using AI tools? | AI tools make my work or studies more interesting" = "HM2",
    "Price Value: How much do you agree with these statements about whether using AI is worth your time and effort? | I get more value from AI tools than the effort they require" = "PV1",
    "Price Value: How much do you agree with these statements about whether using AI is worth your time and effort? | Using AI tools is worth the learning curve" = "PV2",
    "Habit: How much do you agree with these statements about your habits with AI tools? | Using AI tools has become a habit for me" = "HB1",
    "Habit: How much do you agree with these statements about your habits with AI tools? | I tend to rely on AI tools by default when I need help with tasks" = "HB2",
    "Voluntariness: How much do you agree with these statements about your freedom to choose whether or not to use AI tools? | I choose to use AI tools in my work because I find them helpful, not because I am required to" = "VO1",
    "Voluntariness: How much do you agree with these statements about your freedom to choose whether or not to use AI tools? | I could choose not to use AI tools in my work or studies if I preferred." = "VO2",
    "Trust in AI: How much do you agree with these statements about trusting AI tools? | I trust AI tools to provide reliable information" = "TR1",
    "Trust in AI: How much do you agree with these statements about trusting AI tools? | I trust the AI tools that are available to me" = "TR2",
    "Explainability: How much do you agree with these statements about understanding how AI tools make their recommendations? | I understand how the AI tools I use generate their outputs" = "EX1",
    "Explainability: How much do you agree with these statements about understanding how AI tools make their recommendations? | I prefer AI tools that explain their recommendations" = "EX2",
    "Perceived Ethical Risk: How much do you agree with these statements about possible risks of AI? | I worry that AI tools could replace jobs in my field" = "ER1",
    "Perceived Ethical Risk: How much do you agree with these statements about possible risks of AI? | I am concerned about privacy risks when using AI tools" = "ER2",
    "AI Anxiety: How much do you agree with these statements about feeling uneasy or anxious about AI? | I feel uneasy about the increasing use of AI" = "AX1",
    "AI Anxiety: How much do you agree with these statements about feeling uneasy or anxious about AI? | I worry that I may be left behind if I do not keep up with AI" = "AX2",
    "AI Adoption Readiness: How much do you agree with these statements about your readiness to use AI? | I am ready to use more AI tools in my work or studies" = "BI1",
    "AI Adoption Readiness: How much do you agree with these statements about your readiness to use AI? | I would recommend AI tools to others" = "BI2",
    "AI Adoption Readiness: How much do you agree with these statements about your readiness to use AI? | I see AI as an important part of my future" = "BI3",
    "AI Adoption Readiness: How much do you agree with these statements about your readiness to use AI? | I plan to increase my use of AI tools in the next six months" = "BI4",
    "Usage Frequency: How often do you use the following AI tools? | Microsoft 365 Copilot or Microsoft Copilot" = "Usage_MSCopilot",
    "Usage Frequency: How often do you use the following AI tools? | ChatGPT" = "Usage_ChatGPT",
    "Usage Frequency: How often do you use the following AI tools? | Google Gemini" = "Usage_Gemini",
    "Usage Frequency: How often do you use the following AI tools? | Other AI tools (for example, Claude, Perplexity, Grok)" = "Usage_Other",
    "What is your current status?" = "Role",
    "What is your highest level of education completed?" = "Education",
    "Which industry or field best describes your primary area of work or study?" = "Industry",
    "How many years of work or study experience do you have in your field?" = "Experience",
    "Do you identify as a person with a disability (for example, vision, mobility, neurodivergence)?" = "Disability",
    "Do you have any other feedback about your experiences with AI tools or reasons for using or not using AI?" = "Open_Feedback"
)

ROLE_MAP <- c(
    "Full time student" = "FT_Student",
    "Part time student" = "PT_Student",
    "Employed - individual contributor" = "IC",
    "Employed - manager" = "Manager",
    "Employed - executive or leader" = "Executive",
    "Freelancer or self employed" = "Freelancer",
    "Not currently employed" = "Unemployed",
    "Other" = "Other"
)

LIKERT_MAP <- c(
    "Strongly disagree" = 1, "Disagree" = 2, "Neutral" = 3,
    "Agree" = 4, "Strongly agree" = 5
)
USAGE_MAP <- c("Never" = 1, "Rarely" = 2, "Sometimes" = 3, "Often" = 4, "Daily" = 5)

cat(sprintf(
    "\nAIRS Scale: %d items (%d predictors + %d outcomes)\n",
    length(LIKERT_ITEMS), length(PREDICTOR_ITEMS), length(OUTCOME_ITEMS)
))
cat(sprintf(
    "Split: %d%% EFA / %d%% CFA\n",
    as.integer((1 - HOLDOUT_RATIO) * 100), as.integer(HOLDOUT_RATIO * 100)
))

# =============================================================================
# LOAD & TRANSFORM
# =============================================================================

df <- read.csv("../../data/AIRS---AI-Readiness-Scale-labels.csv",
    skip = 2, stringsAsFactors = FALSE, fileEncoding = "UTF-8",
    check.names = FALSE
)

# Rename columns
for (old_name in names(COLUMN_MAP)) {
    if (old_name %in% names(df)) {
        names(df)[names(df) == old_name] <- COLUMN_MAP[old_name]
    }
}

# Keep only mapped columns that exist
keep_cols <- intersect(unname(COLUMN_MAP), names(df))
df <- df[, keep_cols, drop = FALSE]

# Recode Likert items
for (col in LIKERT_ITEMS) {
    if (col %in% names(df)) {
        df[[col]] <- LIKERT_MAP[df[[col]]]
        df[[col]] <- as.integer(df[[col]])
    }
}

# Recode Usage items
for (col in USAGE_ITEMS) {
    if (col %in% names(df)) {
        df[[col]] <- USAGE_MAP[df[[col]]]
        df[[col]] <- as.integer(df[[col]])
    }
}

# Create derived columns
df$AI_Adoption <- as.integer(apply(df[, USAGE_ITEMS, drop = FALSE] > 1, 1, any))
df$Role_Category <- ROLE_MAP[df$Role]
if ("Duration_seconds" %in% names(df)) {
    df$Duration_minutes <- df$Duration_seconds / 60
    df$Duration_seconds <- NULL
}

write.csv(df, "data/AIRS_clean.csv", row.names = FALSE, fileEncoding = "UTF-8")
cat(sprintf("\nLoaded N=%d respondents\n", nrow(df)))
cat("Role distribution:\n")
print(table(df$Role_Category))

# =============================================================================
# STRATIFIED SPLIT (mirrors sklearn train_test_split with stratify)
# =============================================================================

set.seed(RANDOM_SEED)
# Use caTools::sample.split which performs stratified splitting
split_flag <- sample.split(df$AI_Adoption, SplitRatio = 1 - HOLDOUT_RATIO)
dev <- df[split_flag, ]
holdout <- df[!split_flag, ]

write.csv(dev, "data/AIRS_experiment.csv", row.names = FALSE, fileEncoding = "UTF-8")
write.csv(holdout, "data/AIRS_holdout.csv", row.names = FALSE, fileEncoding = "UTF-8")

cat(sprintf(
    "\nSplit complete: N=%d -> EFA N=%d, CFA N=%d\n",
    nrow(df), nrow(dev), nrow(holdout)
))
cat(sprintf(
    "Adoption balance: EFA=%.1f%%, CFA=%.1f%%\n",
    mean(dev$AI_Adoption) * 100, mean(holdout$AI_Adoption) * 100
))

# =============================================================================
# EXPORT METADATA
# =============================================================================

# Build construct groups
construct_groups <- list()
for (i in seq_len(nrow(ITEMS))) {
    abbr <- substr(ITEMS$code[i], 1, 2)
    construct_groups[[abbr]] <- c(construct_groups[[abbr]], ITEMS$code[i])
}

theoretical_domains <- list(
    UTAUT2_Core = c("PE", "EE", "SI", "FC", "HM", "PV", "HB"),
    AI_Specific = c("VO", "TR", "EX", "ER", "AX"),
    Outcome     = c("BI")
)

all_roles <- unique(na.omit(df$Role_Category))

config <- list(
    created = format(Sys.Date(), "%Y-%m-%d"),
    selected_roles = list("ALL"),
    roles_included = all_roles,
    population = "ALL",
    population_description = "All respondents (students + professionals) per approved dissertation proposal",
    n_total = nrow(df),
    n_efa = nrow(dev),
    n_cfa = nrow(holdout),
    holdout_ratio = HOLDOUT_RATIO,
    random_seed = RANDOM_SEED
)
write_json(config, "data/experiment_config.json", pretty = TRUE, auto_unbox = TRUE)

# Item metadata
item_metadata <- list()
for (i in seq_len(nrow(ITEMS))) {
    item_metadata[[ITEMS$code[i]]] <- list(
        construct = ITEMS$construct[i],
        construct_abbr = substr(ITEMS$code[i], 1, 2),
        direction = ITEMS$direction[i]
    )
}

metadata_export <- list(
    created = format(Sys.Date(), "%Y-%m-%d"),
    items = LIKERT_ITEMS,
    predictor_items = PREDICTOR_ITEMS,
    outcome_items = OUTCOME_ITEMS,
    constructs = construct_groups,
    theoretical_domains = theoretical_domains,
    metadata = item_metadata,
    positive_items = ITEMS$code[ITEMS$direction == "POSITIVE"],
    negative_items = ITEMS$code[ITEMS$direction == "NEGATIVE"]
)
write_json(metadata_export, "data/airs_28item_complete.json", pretty = TRUE, auto_unbox = TRUE)

cat("\nExported: experiment_config.json, airs_28item_complete.json\n")

# =============================================================================
# SAMPLE CHARACTERISTICS
# =============================================================================

role_dist <- table(df$Role_Category)
academic_roles <- c("FT_Student", "PT_Student")
n_academic <- sum(role_dist[names(role_dist) %in% academic_roles])
n_professional <- nrow(df) - n_academic
leader_roles <- c("Manager", "Executive")
n_leaders <- sum(role_dist[names(role_dist) %in% leader_roles])
n_prof_only <- n_professional - n_leaders

sample_characteristics <- list(
    total_n = nrow(df),
    efa_n = nrow(dev),
    cfa_n = nrow(holdout),
    efa_pct = round(nrow(dev) / nrow(df) * 100, 1),
    cfa_pct = round(nrow(holdout) / nrow(df) * 100, 1),
    two_group = list(
        academic = list(
            n = as.integer(n_academic),
            pct = round(n_academic / nrow(df) * 100, 1),
            ft_student = as.integer(role_dist["FT_Student"]),
            pt_student = as.integer(role_dist["PT_Student"])
        ),
        professional = list(
            n = as.integer(n_professional),
            pct = round(n_professional / nrow(df) * 100, 1)
        )
    ),
    three_group = list(
        student = list(
            n = as.integer(n_academic),
            pct = round(n_academic / nrow(df) * 100, 1)
        ),
        professional = list(
            n = as.integer(n_prof_only),
            pct = round(n_prof_only / nrow(df) * 100, 1),
            ic = as.integer(ifelse("IC" %in% names(role_dist), role_dist["IC"], 0)),
            freelancer = as.integer(ifelse("Freelancer" %in% names(role_dist), role_dist["Freelancer"], 0)),
            unemployed = as.integer(ifelse("Unemployed" %in% names(role_dist), role_dist["Unemployed"], 0)),
            other = as.integer(ifelse("Other" %in% names(role_dist), role_dist["Other"], 0))
        ),
        leader = list(
            n = as.integer(n_leaders),
            pct = round(n_leaders / nrow(df) * 100, 1),
            manager = as.integer(ifelse("Manager" %in% names(role_dist), role_dist["Manager"], 0)),
            executive = as.integer(ifelse("Executive" %in% names(role_dist), role_dist["Executive"], 0))
        )
    ),
    ai_adoption = list(
        overall_pct = round(mean(df$AI_Adoption) * 100, 1),
        efa_pct = round(mean(dev$AI_Adoption) * 100, 1),
        cfa_pct = round(mean(holdout$AI_Adoption) * 100, 1)
    ),
    cases_per_item = list(
        efa = round(nrow(dev) / length(PREDICTOR_ITEMS), 1),
        cfa = round(nrow(holdout) / length(PREDICTOR_ITEMS), 1)
    ),
    role_distribution = as.list(as.integer(role_dist))
)
names(sample_characteristics$role_distribution) <- names(role_dist)

write_json(sample_characteristics, "data/sample_characteristics.json",
    pretty = TRUE, auto_unbox = TRUE
)
cat("Exported: sample_characteristics.json\n")

# =============================================================================
# VISUALIZATION
# =============================================================================

png("plots/sample_preparation_overview.png", width = 1400, height = 1000, res = 150)
par(mfrow = c(2, 2), mar = c(5, 8, 3, 2))

# 1. Role distribution
role_sorted <- sort(role_dist)
barplot(role_sorted,
    horiz = TRUE, las = 1,
    col = rainbow(length(role_sorted)),
    main = sprintf("Role Distribution (N=%d)", nrow(df)),
    xlab = "Count"
)

# 2. Split sample
barplot(c(EFA = nrow(dev), CFA = nrow(holdout)),
    col = c("#2ecc71", "#3498db"), border = "black",
    main = sprintf("Split-Sample Design (50/50)"),
    ylab = "Sample Size"
)
text(c(0.7, 1.9), c(nrow(dev), nrow(holdout)) + 10,
    labels = sprintf("N=%d", c(nrow(dev), nrow(holdout))),
    font = 2, cex = 1.1
)

# 3. Adoption stratification
adoption_efa <- table(dev$AI_Adoption)
adoption_cfa <- table(holdout$AI_Adoption)
barplot(rbind(EFA = as.numeric(adoption_efa), CFA = as.numeric(adoption_cfa)),
    beside = TRUE, names.arg = c("Non-Adopters", "Adopters"),
    col = c("#2ecc71", "#3498db"), legend.text = c("EFA", "CFA"),
    main = "AI Adoption Stratification",
    ylab = "Count"
)

# 4. Population pie
pop_counts <- c(
    Academic = n_academic,
    Professional = n_professional
)
pie(pop_counts,
    labels = sprintf(
        "%s\n(N=%d, %.1f%%)", names(pop_counts), pop_counts,
        pop_counts / sum(pop_counts) * 100
    ),
    col = c("#9b59b6", "#e74c3c"),
    main = "Population Group Composition"
)

dev.off()
cat("Saved: plots/sample_preparation_overview.png\n")

# =============================================================================
# SUMMARY
# =============================================================================

sc <- sample_characteristics
cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("SAMPLE SUMMARY\n")
cat(paste(rep("=", 90), collapse = ""), "\n")
cat(sprintf("  Total N: %d\n", sc$total_n))
cat(sprintf("  EFA: n=%d (%.1f%%)\n", sc$efa_n, sc$efa_pct))
cat(sprintf("  CFA: n=%d (%.1f%%)\n", sc$cfa_n, sc$cfa_pct))
cat(sprintf("  Academic: n=%d (%.1f%%)\n", sc$two_group$academic$n, sc$two_group$academic$pct))
cat(sprintf("  Professional: n=%d (%.1f%%)\n", sc$two_group$professional$n, sc$two_group$professional$pct))
cat(sprintf("  Leaders: n=%d (%.1f%%)\n", sc$three_group$leader$n, sc$three_group$leader$pct))
cat(sprintf("  AI Adoption: %.1f%%\n", sc$ai_adoption$overall_pct))
cat(sprintf(
    "  Cases/Item: EFA=%.1f:1, CFA=%.1f:1\n",
    sc$cases_per_item$efa, sc$cases_per_item$cfa
))

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("PHASE 0 COMPLETE\n")
cat(paste(rep("=", 90), collapse = ""), "\n")
