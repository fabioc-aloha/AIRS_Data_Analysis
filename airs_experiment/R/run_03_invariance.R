#!/usr/bin/env Rscript
# =============================================================================
# AIRS Phase 3: Measurement Invariance Testing — R port
# Mirrors: python/run_03_invariance.py
#
# Academic vs Professional groups: configural, metric, scalar invariance.
# Method: lavaan multi-group CFA with semTools measEq.syntax
# Outputs: data/invariance_results.json, tables/invariance_*.csv
# =============================================================================

library(lavaan)
library(semTools)
library(psych)
library(jsonlite)

cat(paste(rep("=", 90), collapse = ""), "\n")
cat("PHASE 3: MEASUREMENT INVARIANCE TESTING\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

dir.create("tables", showWarnings = FALSE)

# =============================================================================
# LOAD DATA
# =============================================================================

df <- read.csv("data/AIRS_clean.csv", stringsAsFactors = FALSE)
cfa_summary <- fromJSON("tables/cfa_summary.json")

cat(sprintf("\nFull sample N = %d\n", nrow(df)))

# Create population grouping
df$Population <- ifelse(df$Role_Category %in% c("FT_Student", "PT_Student"),
    "Academic", "Professional"
)
cat("Group sizes:\n")
print(table(df$Population))

# =============================================================================
# CFA MODEL SYNTAX (8-factor, 16 items)
# =============================================================================

cfa_model <- "
  PerfExp   =~ PE1 + PE2
  EffortExp =~ EE1 + EE2
  SocialInf =~ SI1 + SI2
  FacilCond =~ FC1 + FC2
  HedonicMot =~ HM1 + HM2
  PriceValue =~ PV1 + PV2
  Habit     =~ HB1 + HB2
  AITrust   =~ TR1 + TR2
"

# =============================================================================
# SEPARATE GROUP CFAs
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("SEPARATE GROUP CFA MODELS\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

for (grp in c("Academic", "Professional")) {
    df_grp <- df[df$Population == grp, ]
    cat(sprintf("\n--- %s (n=%d) ---\n", grp, nrow(df_grp)))

    fit_grp <- tryCatch(
        {
            cfa(cfa_model, data = df_grp, estimator = "ML")
        },
        error = function(e) {
            cat("  ERROR:", e$message, "\n")
            NULL
        }
    )

    if (!is.null(fit_grp) && lavInspect(fit_grp, "converged")) {
        fm <- fitMeasures(fit_grp, c("chisq", "df", "cfi", "tli", "rmsea", "srmr"))
        cat(sprintf(
            "  CFI = %.4f, TLI = %.4f, RMSEA = %.4f, SRMR = %.4f\n",
            fm["cfi"], fm["tli"], fm["rmsea"], fm["srmr"]
        ))

        # Reliability per group
        factor_items <- list(
            PerfExp = c("PE1", "PE2"), EffortExp = c("EE1", "EE2"),
            SocialInf = c("SI1", "SI2"), FacilCond = c("FC1", "FC2"),
            HedonicMot = c("HM1", "HM2"), PriceValue = c("PV1", "PV2"),
            Habit = c("HB1", "HB2"), AITrust = c("TR1", "TR2")
        )
        cat("  Reliability (alpha):\n")
        for (fname in names(factor_items)) {
            itms <- factor_items[[fname]]
            alpha_val <- psych::alpha(df_grp[itms], check.keys = FALSE)$total$raw_alpha
            cat(sprintf("    %s: %.3f\n", fname, alpha_val))
        }
    } else {
        cat("  Model did not converge.\n")
    }
}

# =============================================================================
# MULTI-GROUP INVARIANCE TESTING
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("MULTI-GROUP INVARIANCE TESTING\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

# Configural invariance (same structure, all parameters free)
fit_configural <- cfa(cfa_model, data = df, group = "Population", estimator = "ML")
fm_config <- fitMeasures(fit_configural, c("chisq", "df", "cfi", "tli", "rmsea", "srmr", "aic", "bic"))

cat("\n--- Configural Invariance ---\n")
cat(sprintf(
    "  CFI = %.4f, RMSEA = %.4f, SRMR = %.4f\n",
    fm_config["cfi"], fm_config["rmsea"], fm_config["srmr"]
))

# Metric invariance (loadings constrained equal)
fit_metric <- cfa(cfa_model,
    data = df, group = "Population",
    group.equal = "loadings", estimator = "ML"
)
fm_metric <- fitMeasures(fit_metric, c("chisq", "df", "cfi", "tli", "rmsea", "srmr", "aic", "bic"))

cat("\n--- Metric Invariance ---\n")
cat(sprintf(
    "  CFI = %.4f, RMSEA = %.4f, SRMR = %.4f\n",
    fm_metric["cfi"], fm_metric["rmsea"], fm_metric["srmr"]
))

# Scalar invariance (loadings + intercepts constrained)
fit_scalar <- cfa(cfa_model,
    data = df, group = "Population",
    group.equal = c("loadings", "intercepts"), estimator = "ML"
)
fm_scalar <- fitMeasures(fit_scalar, c("chisq", "df", "cfi", "tli", "rmsea", "srmr", "aic", "bic"))

cat("\n--- Scalar Invariance ---\n")
cat(sprintf(
    "  CFI = %.4f, RMSEA = %.4f, SRMR = %.4f\n",
    fm_scalar["cfi"], fm_scalar["rmsea"], fm_scalar["srmr"]
))

# =============================================================================
# CHI-SQUARE DIFFERENCE TESTS
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("MODEL COMPARISON (Chi-Square Difference Tests)\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

# Configural vs Metric
diff_cm <- anova(fit_configural, fit_metric)
cat("\nConfigural vs Metric:\n")
print(diff_cm)
delta_cfi_cm <- fm_config["cfi"] - fm_metric["cfi"]
cat(sprintf(
    "  Delta_CFI = %.4f %s\n", delta_cfi_cm,
    ifelse(abs(delta_cfi_cm) <= 0.01, "[INVARIANCE SUPPORTED]", "[INVARIANCE NOT SUPPORTED]")
))

# Metric vs Scalar
diff_ms <- anova(fit_metric, fit_scalar)
cat("\nMetric vs Scalar:\n")
print(diff_ms)
delta_cfi_ms <- fm_metric["cfi"] - fm_scalar["cfi"]
cat(sprintf(
    "  Delta_CFI = %.4f %s\n", delta_cfi_ms,
    ifelse(abs(delta_cfi_ms) <= 0.01, "[INVARIANCE SUPPORTED]", "[INVARIANCE NOT SUPPORTED]")
))

# =============================================================================
# LOADING COMPARISON ACROSS GROUPS
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("LOADING COMPARISON (Configural Model)\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

# Extract per-group standardized loadings from configural model
std_config <- standardizedSolution(fit_configural)
loadings_config <- std_config[
    std_config$op == "=~",
    c("lhs", "rhs", "est.std", "group")
]

# Group labels
grp_labels <- lavInspect(fit_configural, "group.label")

loading_comparison <- data.frame(
    Factor = character(), Item = character(),
    Loading_G1 = numeric(), Loading_G2 = numeric(),
    Diff = numeric(), stringsAsFactors = FALSE
)

for (fac in unique(loadings_config$lhs)) {
    for (itm in unique(loadings_config$rhs[loadings_config$lhs == fac])) {
        l1 <- loadings_config$est.std[loadings_config$lhs == fac &
            loadings_config$rhs == itm &
            loadings_config$group == 1]
        l2 <- loadings_config$est.std[loadings_config$lhs == fac &
            loadings_config$rhs == itm &
            loadings_config$group == 2]
        if (length(l1) > 0 && length(l2) > 0) {
            loading_comparison <- rbind(loading_comparison, data.frame(
                Factor = fac, Item = itm,
                Loading_G1 = l1, Loading_G2 = l2,
                Diff = abs(l1 - l2), stringsAsFactors = FALSE
            ))
        }
    }
}

colnames(loading_comparison)[3:4] <- paste0("Loading_", grp_labels)
cat("\n")
num_lc <- sapply(loading_comparison, is.numeric)
print(cbind(loading_comparison[, !num_lc, drop = FALSE], round(loading_comparison[, num_lc, drop = FALSE], 4)))

write.csv(loading_comparison, "tables/invariance_loading_comparison.csv", row.names = FALSE)
cat("\nExported: tables/invariance_loading_comparison.csv\n")

# =============================================================================
# GROUP MEAN COMPARISONS (Cohen's d)
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("GROUP MEAN COMPARISONS (Cohen's d)\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

factor_items <- list(
    PerfExp = c("PE1", "PE2"), EffortExp = c("EE1", "EE2"),
    SocialInf = c("SI1", "SI2"), FacilCond = c("FC1", "FC2"),
    HedonicMot = c("HM1", "HM2"), PriceValue = c("PV1", "PV2"),
    Habit = c("HB1", "HB2"), AITrust = c("TR1", "TR2")
)

df_acad <- df[df$Population == "Academic", ]
df_prof <- df[df$Population == "Professional", ]

mean_comparison <- data.frame(
    Factor = character(), Mean_Academic = numeric(), SD_Academic = numeric(),
    Mean_Professional = numeric(), SD_Professional = numeric(),
    Cohens_d = numeric(), t_value = numeric(), p_value = numeric(),
    stringsAsFactors = FALSE
)

for (fname in names(factor_items)) {
    items <- factor_items[[fname]]
    score_acad <- rowMeans(df_acad[, items])
    score_prof <- rowMeans(df_prof[, items])

    t_result <- t.test(score_acad, score_prof)
    # Cohen's d
    pooled_sd <- sqrt(((length(score_acad) - 1) * sd(score_acad)^2 +
        (length(score_prof) - 1) * sd(score_prof)^2) /
        (length(score_acad) + length(score_prof) - 2))
    d <- (mean(score_acad) - mean(score_prof)) / pooled_sd

    mean_comparison <- rbind(mean_comparison, data.frame(
        Factor = fname,
        Mean_Academic = mean(score_acad), SD_Academic = sd(score_acad),
        Mean_Professional = mean(score_prof), SD_Professional = sd(score_prof),
        Cohens_d = d,
        t_value = t_result$statistic,
        p_value = t_result$p.value,
        stringsAsFactors = FALSE
    ))

    effect <- ifelse(abs(d) >= 0.80, "LARGE",
        ifelse(abs(d) >= 0.50, "MEDIUM",
            ifelse(abs(d) >= 0.20, "SMALL", "NEGLIGIBLE")
        )
    )
    sig <- ifelse(t_result$p.value < 0.05, "*", "")
    cat(sprintf(
        "  %s: Acad=%.2f, Prof=%.2f, d=%.3f [%s] %s\n",
        fname, mean(score_acad), mean(score_prof), d, effect, sig
    ))
}

write.csv(mean_comparison, "tables/invariance_mean_comparison.csv", row.names = FALSE)
cat("\nExported: tables/invariance_mean_comparison.csv\n")

# =============================================================================
# EXPORT RESULTS JSON
# =============================================================================

invariance_results <- list(
    analysis_date = format(Sys.time(), "%Y-%m-%dT%H:%M:%S"),
    n_total = nrow(df),
    n_academic = nrow(df_acad),
    n_professional = nrow(df_prof),
    configural = as.list(round(fm_config, 6)),
    metric = as.list(round(fm_metric, 6)),
    scalar = as.list(round(fm_scalar, 6)),
    delta_cfi_configural_metric = round(as.numeric(delta_cfi_cm), 4),
    delta_cfi_metric_scalar = round(as.numeric(delta_cfi_ms), 4),
    metric_invariance_supported = abs(as.numeric(delta_cfi_cm)) <= 0.01,
    scalar_invariance_supported = abs(as.numeric(delta_cfi_ms)) <= 0.01,
    mean_comparisons = lapply(seq_len(nrow(mean_comparison)), function(i) {
        as.list(mean_comparison[i, ])
    })
)

write_json(invariance_results, "data/invariance_results.json",
    pretty = TRUE, auto_unbox = TRUE
)
cat("\nExported: data/invariance_results.json\n")

# =============================================================================
# INVARIANCE SUMMARY TABLE
# =============================================================================

invariance_table <- data.frame(
    Model = c("Configural", "Metric", "Scalar"),
    chi2 = c(fm_config["chisq"], fm_metric["chisq"], fm_scalar["chisq"]),
    df = c(fm_config["df"], fm_metric["df"], fm_scalar["df"]),
    CFI = c(fm_config["cfi"], fm_metric["cfi"], fm_scalar["cfi"]),
    RMSEA = c(fm_config["rmsea"], fm_metric["rmsea"], fm_scalar["rmsea"]),
    SRMR = c(fm_config["srmr"], fm_metric["srmr"], fm_scalar["srmr"]),
    stringsAsFactors = FALSE
)
invariance_table$Delta_CFI <- c(
    NA,
    as.numeric(delta_cfi_cm),
    as.numeric(delta_cfi_ms)
)
invariance_table$Supported <- c(
    TRUE,
    abs(as.numeric(delta_cfi_cm)) <= 0.01,
    abs(as.numeric(delta_cfi_ms)) <= 0.01
)

write.csv(invariance_table, "tables/invariance_summary.csv", row.names = FALSE)

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("INVARIANCE SUMMARY\n")
cat(paste(rep("=", 90), collapse = ""), "\n")
num_it <- sapply(invariance_table[, -8], is.numeric)
print(cbind(invariance_table[, -8][, !num_it, drop = FALSE], round(invariance_table[, -8][, num_it, drop = FALSE], 4)))

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("PHASE 3 COMPLETE\n")
cat(paste(rep("=", 90), collapse = ""), "\n")
