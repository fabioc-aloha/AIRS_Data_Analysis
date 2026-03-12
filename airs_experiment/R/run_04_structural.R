#!/usr/bin/env Rscript
# =============================================================================
# AIRS Phase 4: Structural Equation Modeling — R port
# Mirrors: python/run_04_structural.py
#
# SEM with 8 predictors -> BehIntent, bootstrap CIs, model comparison (H3),
# multi-group structural analysis, hypothesis summary.
# Outputs: data/structural_model_results.json,
#          tables/structural_paths_full_sample.csv,
#          tables/structural_paths_group_comparison.csv
# =============================================================================

library(lavaan)
library(semTools)
library(jsonlite)

cat(paste(rep("=", 90), collapse = ""), "\n")
cat("PHASE 4: STRUCTURAL EQUATION MODELING\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

dir.create("tables", showWarnings = FALSE)

N_BOOTSTRAP <- 1000

# =============================================================================
# MODEL SYNTAX
# =============================================================================

sem_model <- "
  # Measurement model
  PerfExp    =~ PE1 + PE2
  EffortExp  =~ EE1 + EE2
  SocialInf  =~ SI1 + SI2
  FacilCond  =~ FC1 + FC2
  HedonicMot =~ HM1 + HM2
  PriceValue =~ PV1 + PV2
  Habit      =~ HB1 + HB2
  AITrust    =~ TR1 + TR2
  BehIntent  =~ BI1 + BI2 + BI3 + BI4

  # Structural paths (8 predictors -> BI)
  BehIntent ~ PerfExp + EffortExp + SocialInf + FacilCond + HedonicMot + PriceValue + Habit + AITrust
"

sem_utaut2 <- "
  # Measurement model (no Trust)
  PerfExp    =~ PE1 + PE2
  EffortExp  =~ EE1 + EE2
  SocialInf  =~ SI1 + SI2
  FacilCond  =~ FC1 + FC2
  HedonicMot =~ HM1 + HM2
  PriceValue =~ PV1 + PV2
  Habit      =~ HB1 + HB2
  BehIntent  =~ BI1 + BI2 + BI3 + BI4

  # Structural paths (7 predictors -> BI, no Trust)
  BehIntent ~ PerfExp + EffortExp + SocialInf + FacilCond + HedonicMot + PriceValue + Habit
"

# =============================================================================
# LOAD DATA
# =============================================================================

df <- read.csv("data/AIRS_clean.csv", stringsAsFactors = FALSE)
cat(sprintf("\nFull sample N = %d\n", nrow(df)))

# Create population grouping
df$Population <- ifelse(df$Role_Category %in% c("FT_Student", "PT_Student"),
    "Academic", "Professional"
)

# =============================================================================
# FULL SAMPLE SEM
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("FULL SAMPLE SEM (AIRS: 8 predictors -> BehIntent)\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

fit_sem <- sem(sem_model, data = df, estimator = "ML")
cat(sprintf("Converged: %s\n", lavInspect(fit_sem, "converged")))

fm_sem <- fitMeasures(fit_sem, c(
    "chisq", "df", "pvalue",
    "cfi", "tli", "rmsea", "rmsea.ci.lower", "rmsea.ci.upper",
    "srmr", "aic", "bic"
))

cat(sprintf("\nFit indices:\n"))
cat(sprintf(
    "  Chi-square = %.3f (df = %d, p = %.4f)\n",
    fm_sem["chisq"], fm_sem["df"], fm_sem["pvalue"]
))
cat(sprintf("  CFI  = %.4f\n", fm_sem["cfi"]))
cat(sprintf("  TLI  = %.4f\n", fm_sem["tli"]))
cat(sprintf(
    "  RMSEA = %.4f [%.4f, %.4f]\n",
    fm_sem["rmsea"], fm_sem["rmsea.ci.lower"], fm_sem["rmsea.ci.upper"]
))
cat(sprintf("  SRMR = %.4f\n", fm_sem["srmr"]))

# R-squared
r2 <- lavInspect(fit_sem, "rsquare")
cat(sprintf("\nR-squared (BehIntent) = %.4f\n", r2["BehIntent"]))

# Structural paths
std_sem <- standardizedSolution(fit_sem)
paths <- std_sem[
    std_sem$op == "~" & std_sem$lhs == "BehIntent",
    c("lhs", "rhs", "est.std", "se", "z", "pvalue")
]
colnames(paths) <- c("Outcome", "Predictor", "Beta_Std", "SE", "z", "p")

cat("\nStructural Path Coefficients:\n")
cat(sprintf("  %-12s %8s %8s %8s %10s %s\n", "Predictor", "Beta", "SE", "z", "p", "Sig"))
cat(paste(rep("-", 60), collapse = ""), "\n")

hypothesis_map <- c(
    PerfExp = "H1a", EffortExp = "H1b", SocialInf = "H1c",
    FacilCond = "H1d", HedonicMot = "H1e", PriceValue = "H1f",
    Habit = "H1g", AITrust = "H2"
)

for (i in seq_len(nrow(paths))) {
    pred <- paths$Predictor[i]
    sig <- ifelse(paths$p[i] < 0.001, "***",
        ifelse(paths$p[i] < 0.01, "**",
            ifelse(paths$p[i] < 0.05, "*", "ns")
        )
    )
    hyp <- hypothesis_map[pred]
    support <- ifelse(paths$p[i] < 0.05, "Supported", "Not Supported")
    cat(sprintf(
        "  %-12s %8.4f %8.4f %8.3f %10.4f %s [%s: %s]\n",
        pred, paths$Beta_Std[i], paths$SE[i], paths$z[i], paths$p[i],
        sig, hyp, support
    ))
}

# Export path table
path_export <- paths
path_export$Hypothesis <- hypothesis_map[paths$Predictor]
path_export$Support <- ifelse(paths$p < 0.05, "Supported", "Not Supported")
path_export$Sig <- ifelse(paths$p < 0.001, "***",
    ifelse(paths$p < 0.01, "**",
        ifelse(paths$p < 0.05, "*", "ns")
    )
)
write.csv(path_export, "tables/structural_paths_full_sample.csv", row.names = FALSE)
cat("\nExported: tables/structural_paths_full_sample.csv\n")

# =============================================================================
# BOOTSTRAP CONFIDENCE INTERVALS
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat(sprintf("BOOTSTRAP CIs (%d iterations)\n", N_BOOTSTRAP))
cat(paste(rep("=", 90), collapse = ""), "\n")

cat("Running bootstrap (this may take a few minutes)...\n")
fit_sem_boot <- sem(sem_model,
    data = df, estimator = "ML",
    se = "bootstrap", bootstrap = N_BOOTSTRAP,
    iseed = 42
)
cat("Bootstrap completed.\n\n")

boot_params <- parameterEstimates(fit_sem_boot,
    boot.ci.type = "perc",
    standardized = TRUE
)
boot_paths <- boot_params[
    boot_params$op == "~" & boot_params$lhs == "BehIntent",
    c("lhs", "rhs", "est", "se", "ci.lower", "ci.upper", "pvalue", "std.all")
]

cat("Bootstrapped structural paths:\n")
bootstrap_ci_results <- list()
for (i in seq_len(nrow(boot_paths))) {
    rhs <- boot_paths$rhs[i]
    lo <- boot_paths$ci.lower[i]
    hi <- boot_paths$ci.upper[i]
    sig_flag <- (lo > 0 | hi < 0)
    sig_text <- ifelse(sig_flag, "SIGNIFICANT", "NOT significant (CI includes zero)")
    cat(sprintf("  %s -> BehIntent: [%.3f, %.3f] — %s\n", rhs, lo, hi, sig_text))
    bootstrap_ci_results[[rhs]] <- list(
        ci_lower = lo, ci_upper = hi,
        significant = sig_flag,
        unstd_est = boot_paths$est[i],
        std_est = boot_paths$std.all[i]
    )
}

# =============================================================================
# H3: MODEL COMPARISON (UTAUT2 vs AIRS)
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("H3: MODEL COMPARISON (UTAUT2-Only vs AIRS)\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

fit_utaut2 <- sem(sem_utaut2, data = df, estimator = "ML")
fm_utaut2 <- fitMeasures(fit_utaut2, c("chisq", "df", "cfi", "tli", "rmsea", "srmr", "aic", "bic"))

cat("\nUTAUT2-Only (7 predictors):\n")
cat(sprintf(
    "  CFI = %.4f, RMSEA = %.4f, SRMR = %.4f, AIC = %.2f\n",
    fm_utaut2["cfi"], fm_utaut2["rmsea"], fm_utaut2["srmr"], fm_utaut2["aic"]
))

cat("\nAIRS (8 predictors):\n")
cat(sprintf(
    "  CFI = %.4f, RMSEA = %.4f, SRMR = %.4f, AIC = %.2f\n",
    fm_sem["cfi"], fm_sem["rmsea"], fm_sem["srmr"], fm_sem["aic"]
))

delta_aic <- as.numeric(fm_sem["aic"] - fm_utaut2["aic"])
delta_bic <- as.numeric(fm_sem["bic"] - fm_utaut2["bic"])
cat(sprintf("\n  Delta_AIC = %.2f (negative = AIRS is better)\n", delta_aic))
cat(sprintf("  Delta_BIC = %.2f (negative = AIRS is better)\n", delta_bic))

h3_supported <- delta_aic < -2
cat(sprintf(
    "\n  H3 (Incremental validity of Trust): %s\n",
    ifelse(h3_supported, "SUPPORTED", "NOT SUPPORTED")
))

# =============================================================================
# MULTI-GROUP SEM (Academic vs Professional)
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("MULTI-GROUP SEM (Academic vs Professional)\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

path_comparison <- data.frame(
    Predictor = character(),
    Beta_Academic = numeric(), p_Academic = numeric(),
    Beta_Professional = numeric(), p_Professional = numeric(),
    stringsAsFactors = FALSE
)

for (grp in c("Academic", "Professional")) {
    df_grp <- df[df$Population == grp, ]
    cat(sprintf("\n--- %s (n=%d) ---\n", grp, nrow(df_grp)))

    fit_grp <- tryCatch(
        {
            sem(sem_model, data = df_grp, estimator = "ML")
        },
        error = function(e) {
            cat("  ERROR:", e$message, "\n")
            NULL
        }
    )

    if (!is.null(fit_grp) && lavInspect(fit_grp, "converged")) {
        fm_grp <- fitMeasures(fit_grp, c("cfi", "rmsea", "srmr"))
        r2_grp <- lavInspect(fit_grp, "rsquare")
        cat(sprintf(
            "  CFI = %.4f, RMSEA = %.4f, SRMR = %.4f\n",
            fm_grp["cfi"], fm_grp["rmsea"], fm_grp["srmr"]
        ))
        cat(sprintf("  R-squared (BehIntent) = %.4f\n", r2_grp["BehIntent"]))

        std_grp <- standardizedSolution(fit_grp)
        paths_grp <- std_grp[
            std_grp$op == "~" & std_grp$lhs == "BehIntent",
            c("rhs", "est.std", "pvalue")
        ]

        for (j in seq_len(nrow(paths_grp))) {
            pred <- paths_grp$rhs[j]
            if (grp == "Academic") {
                path_comparison <- rbind(path_comparison, data.frame(
                    Predictor = pred,
                    Beta_Academic = paths_grp$est.std[j],
                    p_Academic = paths_grp$pvalue[j],
                    Beta_Professional = NA_real_,
                    p_Professional = NA_real_,
                    stringsAsFactors = FALSE
                ))
            } else {
                idx <- which(path_comparison$Predictor == pred)
                if (length(idx) > 0) {
                    path_comparison$Beta_Professional[idx] <- paths_grp$est.std[j]
                    path_comparison$p_Professional[idx] <- paths_grp$pvalue[j]
                }
            }
        }
    }
}

cat("\nPath Comparison:\n")
print(round(path_comparison[, -1], 4))
write.csv(path_comparison, "tables/structural_paths_group_comparison.csv", row.names = FALSE)
cat("\nExported: tables/structural_paths_group_comparison.csv\n")

# =============================================================================
# HYPOTHESIS SUMMARY
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("HYPOTHESIS SUMMARY\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

n_sig_utaut2 <- sum(paths$p[paths$Predictor != "AITrust"] < 0.05)
tr_row <- paths[paths$Predictor == "AITrust", ]
trust_sig <- tr_row$p < 0.05
n_moderation <- sum(!is.na(path_comparison$Beta_Academic) &
    !is.na(path_comparison$Beta_Professional) &
    ((path_comparison$p_Academic < 0.05) != (path_comparison$p_Professional < 0.05)))

cat(sprintf("  H1: %d/7 UTAUT2 paths significant\n", n_sig_utaut2))
cat(sprintf(
    "  H2: AITrust significant = %s (beta=%.4f, p=%.4f)\n",
    trust_sig, tr_row$Beta_Std, tr_row$p
))
cat(sprintf(
    "  H3: Incremental validity = %s (Delta_AIC=%.2f)\n",
    ifelse(h3_supported, "SUPPORTED", "NOT"), delta_aic
))
cat(sprintf("  H4: %d paths differ between groups\n", n_moderation))

# =============================================================================
# EXPORT RESULTS JSON
# =============================================================================

path_coefficients <- lapply(seq_len(nrow(path_export)), function(i) {
    pred <- path_export$Predictor[i]
    entry <- list(
        predictor = pred,
        beta_std = round(path_export$Beta_Std[i], 4),
        p = path_export$p[i],
        hypothesis = path_export$Hypothesis[i],
        support = path_export$Support[i]
    )
    if (pred %in% names(bootstrap_ci_results)) {
        entry$ci_lower <- bootstrap_ci_results[[pred]]$ci_lower
        entry$ci_upper <- bootstrap_ci_results[[pred]]$ci_upper
        entry$ci_significant <- bootstrap_ci_results[[pred]]$significant
    }
    entry
})

structural_summary <- list(
    analysis_date = format(Sys.time(), "%Y-%m-%dT%H:%M:%S"),
    full_sample_n = nrow(df),
    full_sample_fit = list(
        chi2 = round(as.numeric(fm_sem["chisq"]), 3),
        df = as.integer(fm_sem["df"]),
        cfi = round(as.numeric(fm_sem["cfi"]), 4),
        tli = round(as.numeric(fm_sem["tli"]), 4),
        rmsea = round(as.numeric(fm_sem["rmsea"]), 4),
        srmr = round(as.numeric(fm_sem["srmr"]), 4),
        r_squared_BehIntent = round(as.numeric(r2["BehIntent"]), 4),
        aic = round(as.numeric(fm_sem["aic"]), 2),
        bic = round(as.numeric(fm_sem["bic"]), 2)
    ),
    path_coefficients = path_coefficients,
    bootstrap = list(
        n_iterations = N_BOOTSTRAP,
        results = bootstrap_ci_results
    ),
    hypothesis_results = list(
        H1_supported_paths = n_sig_utaut2,
        H1_total_paths = 7L,
        H2_trust_significant = as.logical(trust_sig),
        H2_trust_beta = round(as.numeric(tr_row$Beta_Std), 4),
        H2_trust_p = as.numeric(tr_row$p),
        H3_incremental_validity = h3_supported,
        H3_delta_aic = round(delta_aic, 2),
        H4_moderation_effects = n_moderation
    ),
    model_comparison = list(
        utaut2_aic = round(as.numeric(fm_utaut2["aic"]), 2),
        airs_aic = round(as.numeric(fm_sem["aic"]), 2),
        delta_aic = round(delta_aic, 2),
        delta_bic = round(delta_bic, 2)
    )
)

write_json(structural_summary, "data/structural_model_results.json",
    pretty = TRUE, auto_unbox = TRUE
)
cat("\nExported: data/structural_model_results.json\n")

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("PHASE 4 COMPLETE\n")
cat(paste(rep("=", 90), collapse = ""), "\n")
