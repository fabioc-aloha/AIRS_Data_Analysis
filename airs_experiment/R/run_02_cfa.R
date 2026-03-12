#!/usr/bin/env Rscript
# =============================================================================
# AIRS Phase 2: Confirmatory Factor Analysis (CFA) — R port
# Mirrors: python/run_02_cfa.py
#
# Validates EFA-derived factor structure using independent holdout sample.
# Method: lavaan CFA | Fit criteria: CFI/TLI >= 0.95, RMSEA <= 0.08, SRMR <= 0.08
# Outputs: tables/cfa_summary.json, tables/cfa_factor_loadings.csv,
#          tables/cfa_factor_correlations.csv, tables/cfa_reliability.csv
# =============================================================================

library(lavaan)
library(semTools)
library(psych)
library(jsonlite)

cat(paste(rep("=", 90), collapse = ""), "\n")
cat("PHASE 2: CONFIRMATORY FACTOR ANALYSIS (CFA)\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

dir.create("tables", showWarnings = FALSE)

# =============================================================================
# LOAD DATA
# =============================================================================

df_holdout <- read.csv("data/AIRS_holdout.csv", stringsAsFactors = FALSE)
cat(sprintf("\nLoaded holdout data: %d rows x %d columns\n", nrow(df_holdout), ncol(df_holdout)))

config <- fromJSON("data/experiment_config.json")
efa_summary <- fromJSON("tables/efa_summary.json")

# =============================================================================
# BUILD CFA STRUCTURE FROM EFA RESULTS
# =============================================================================

CONSTRUCT_NAME_MAP <- c(
  PE = "PerfExp", EE = "EffortExp", SI = "SocialInf", FC = "FacilCond",
  HM = "HedonicMot", PV = "PriceValue", HB = "Habit", TR = "AITrust"
)

DROPPED_ITEMS <- list(
  Voluntariness = c("VO1", "VO2"),
  Explainability = c("EX1", "EX2"),
  EthicalRisk = c("ER1", "ER2"),
  Anxiety = c("AX1", "AX2")
)

# Get validated structure from EFA
factor_struct <- efa_summary$validated_factor_structure
CFA_STRUCTURE <- list()
for (abbr in names(factor_struct)) {
  mapped_name <- CONSTRUCT_NAME_MAP[abbr]
  if (!is.na(mapped_name)) {
    CFA_STRUCTURE[[mapped_name]] <- factor_struct[[abbr]]
  }
}

# Build lavaan syntax
cfa_syntax_parts <- sapply(names(CFA_STRUCTURE), function(factor) {
  items <- CFA_STRUCTURE[[factor]]
  sprintf("  %s =~ %s", factor, paste(items, collapse = " + "))
})
cfa_syntax <- paste(cfa_syntax_parts, collapse = "\n")

cat("\nCFA Model Syntax:\n")
cat(cfa_syntax, "\n\n")

n_factors <- length(CFA_STRUCTURE)
n_items   <- sum(sapply(CFA_STRUCTURE, length))
cat(sprintf("CFA Structure: %d factors, %d items\n", n_factors, n_items))
cat(sprintf("Dropped: %s\n\n",
            paste(names(DROPPED_ITEMS), collapse = ", ")))

# Collect all CFA items
all_cfa_items <- unlist(CFA_STRUCTURE, use.names = FALSE)

# =============================================================================
# FIT CFA MODEL
# =============================================================================

fit_cfa <- cfa(cfa_syntax, data = df_holdout, estimator = "ML")
cat(sprintf("Converged: %s\n", lavInspect(fit_cfa, "converged")))

# Fit indices
fit_measures <- fitMeasures(fit_cfa, c("chisq", "df", "pvalue",
                                        "cfi", "tli", "rmsea", "rmsea.ci.lower", "rmsea.ci.upper",
                                        "srmr", "aic", "bic"))

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("CFA FIT INDICES (Holdout Sample)\n")
cat(paste(rep("=", 90), collapse = ""), "\n")
cat(sprintf("  Chi-square = %.3f (df = %d, p = %.4f)\n",
            fit_measures["chisq"], fit_measures["df"], fit_measures["pvalue"]))
cat(sprintf("  CFI  = %.4f  %s\n", fit_measures["cfi"],
            ifelse(fit_measures["cfi"] >= 0.95, "[EXCELLENT]", ifelse(fit_measures["cfi"] >= 0.90, "[ACCEPTABLE]", "[POOR]"))))
cat(sprintf("  TLI  = %.4f  %s\n", fit_measures["tli"],
            ifelse(fit_measures["tli"] >= 0.95, "[EXCELLENT]", ifelse(fit_measures["tli"] >= 0.90, "[ACCEPTABLE]", "[POOR]"))))
cat(sprintf("  RMSEA = %.4f [%.4f, %.4f]  %s\n",
            fit_measures["rmsea"], fit_measures["rmsea.ci.lower"], fit_measures["rmsea.ci.upper"],
            ifelse(fit_measures["rmsea"] <= 0.06, "[EXCELLENT]", ifelse(fit_measures["rmsea"] <= 0.08, "[ACCEPTABLE]", "[POOR]"))))
cat(sprintf("  SRMR = %.4f  %s\n", fit_measures["srmr"],
            ifelse(fit_measures["srmr"] <= 0.08, "[EXCELLENT]", "[POOR]")))
cat(sprintf("  AIC  = %.2f\n", fit_measures["aic"]))
cat(sprintf("  BIC  = %.2f\n", fit_measures["bic"]))

# =============================================================================
# FACTOR LOADINGS
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("STANDARDIZED FACTOR LOADINGS\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

std_solution <- standardizedSolution(fit_cfa)
loadings_df <- std_solution[std_solution$op == "=~",
                             c("lhs", "rhs", "est.std", "se", "z", "pvalue")]
colnames(loadings_df) <- c("Factor", "Item", "Loading_Std", "SE", "z", "p")

for (i in seq_len(nrow(loadings_df))) {
  sig <- ifelse(loadings_df$p[i] < 0.001, "***",
                ifelse(loadings_df$p[i] < 0.01, "**",
                       ifelse(loadings_df$p[i] < 0.05, "*", "")))
  cat(sprintf("  %s -> %s: %.4f (SE=%.4f, z=%.3f) %s\n",
              loadings_df$Factor[i], loadings_df$Item[i],
              loadings_df$Loading_Std[i], loadings_df$SE[i],
              loadings_df$z[i], sig))
}

write.csv(loadings_df, "tables/cfa_factor_loadings.csv", row.names = FALSE)
cat("\nExported: tables/cfa_factor_loadings.csv\n")

# =============================================================================
# FACTOR CORRELATIONS
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("FACTOR CORRELATIONS\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

cor_lv <- lavInspect(fit_cfa, "cor.lv")
cat("\n")
print(round(cor_lv, 3))

write.csv(round(cor_lv, 4), "tables/cfa_factor_correlations.csv")
cat("\nExported: tables/cfa_factor_correlations.csv\n")

# Discriminant validity check
fnames <- rownames(cor_lv)
cat("\nDiscriminant validity (|r| >= .85):\n")
any_flagged <- FALSE
for (i in 1:(length(fnames) - 1)) {
  for (j in (i + 1):length(fnames)) {
    r <- cor_lv[i, j]
    if (abs(r) >= 0.85) {
      cat(sprintf("  WARNING: %s x %s: r = %.3f\n", fnames[i], fnames[j], r))
      any_flagged <- TRUE
    }
  }
}
if (!any_flagged) cat("  None — all |r| < .85\n")

# =============================================================================
# RELIABILITY: Composite Reliability (CR) & AVE
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("RELIABILITY: CR & AVE\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

reliability_df <- data.frame(
  Factor = character(), N_Items = integer(),
  CR = numeric(), AVE = numeric(), Alpha = numeric(),
  CR_Status = character(), AVE_Status = character(),
  stringsAsFactors = FALSE
)

for (factor in names(CFA_STRUCTURE)) {
  items <- CFA_STRUCTURE[[factor]]
  # Get standardized loadings for this factor
  factor_loadings <- loadings_df$Loading_Std[loadings_df$Factor == factor]

  # CR = (sum of loadings)^2 / ((sum of loadings)^2 + sum of error variances)
  sum_lambda <- sum(factor_loadings)
  sum_error  <- sum(1 - factor_loadings^2)
  cr <- sum_lambda^2 / (sum_lambda^2 + sum_error)

  # AVE = mean of squared loadings
  ave <- mean(factor_loadings^2)

  # Cronbach's alpha
  alpha_val <- psych::alpha(df_holdout[, items], check.keys = FALSE)$total$raw_alpha

  reliability_df <- rbind(reliability_df, data.frame(
    Factor = factor, N_Items = length(items),
    CR = cr, AVE = ave, Alpha = alpha_val,
    CR_Status = ifelse(cr >= 0.70, "OK", "LOW"),
    AVE_Status = ifelse(ave >= 0.50, "OK", "LOW"),
    stringsAsFactors = FALSE
  ))

  cat(sprintf("  %s: CR=%.3f %s, AVE=%.3f %s, Alpha=%.3f\n",
              factor, cr, ifelse(cr >= 0.70, "[OK]", "[LOW]"),
              ave, ifelse(ave >= 0.50, "[OK]", "[LOW]"),
              alpha_val))
}

write.csv(reliability_df, "tables/cfa_reliability.csv", row.names = FALSE)
cat("\nExported: tables/cfa_reliability.csv\n")

# =============================================================================
# FORNELL-LARCKER CRITERION
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("FORNELL-LARCKER CRITERION\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

ave_vals <- setNames(reliability_df$AVE, reliability_df$Factor)
violations <- 0
for (i in 1:(length(fnames) - 1)) {
  for (j in (i + 1):length(fnames)) {
    r <- cor_lv[i, j]
    r2_shared <- r^2
    ave_i <- ave_vals[fnames[i]]
    ave_j <- ave_vals[fnames[j]]
    pass <- (ave_i > r2_shared) & (ave_j > r2_shared)
    if (!pass) {
      cat(sprintf("  FAIL: %s x %s: r=%.3f, r2=%.3f, AVE(%s)=%.3f, AVE(%s)=%.3f\n",
                  fnames[i], fnames[j], r, r2_shared, fnames[i], ave_i, fnames[j], ave_j))
      violations <- violations + 1
    }
  }
}
if (violations == 0) {
  cat("  All pairs pass Fornell-Larcker criterion\n")
} else {
  cat(sprintf("\n  Total violations: %d\n", violations))
}

# =============================================================================
# HTMT RATIO (Henseler et al., 2015)
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("HETEROTRAIT-MONOTRAIT RATIO (HTMT)\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

# Item-level correlation matrix on holdout data
all_items <- unlist(CFA_STRUCTURE, use.names = FALSE)
item_cor <- cor(df_holdout[, all_items], use = "pairwise.complete.obs")

htmt_results <- data.frame(
  Factor_i = character(), Factor_j = character(),
  HTMT = numeric(), Status = character(),
  stringsAsFactors = FALSE
)

factor_names <- names(CFA_STRUCTURE)
for (i in 1:(length(factor_names) - 1)) {
  for (j in (i + 1):length(factor_names)) {
    items_i <- CFA_STRUCTURE[[factor_names[i]]]
    items_j <- CFA_STRUCTURE[[factor_names[j]]]

    # Heterotrait-heteromethod: correlations between items of different factors
    het_cors <- abs(item_cor[items_i, items_j])
    mean_het <- mean(het_cors)

    # Monotrait-heteromethod: correlations within each factor
    if (length(items_i) > 1) {
      mono_i_cors <- abs(item_cor[items_i, items_i])
      mono_i <- mean(mono_i_cors[upper.tri(mono_i_cors)])
    } else {
      mono_i <- 1
    }
    if (length(items_j) > 1) {
      mono_j_cors <- abs(item_cor[items_j, items_j])
      mono_j <- mean(mono_j_cors[upper.tri(mono_j_cors)])
    } else {
      mono_j <- 1
    }

    htmt_val <- mean_het / sqrt(mono_i * mono_j)
    status <- ifelse(htmt_val < 0.85, "OK", ifelse(htmt_val < 0.90, "MARGINAL", "FAIL"))

    htmt_results <- rbind(htmt_results, data.frame(
      Factor_i = factor_names[i], Factor_j = factor_names[j],
      HTMT = htmt_val, Status = status,
      stringsAsFactors = FALSE
    ))

    if (htmt_val >= 0.85) {
      cat(sprintf("  %s: %s x %s: HTMT = %.3f\n", status, factor_names[i], factor_names[j], htmt_val))
    }
  }
}

htmt_ok <- sum(htmt_results$Status == "OK")
htmt_fail <- sum(htmt_results$Status != "OK")
cat(sprintf("\n  Summary: %d pairs OK, %d pairs flagged (HTMT >= .85)\n", htmt_ok, htmt_fail))
write.csv(htmt_results, "tables/cfa_htmt.csv", row.names = FALSE)
cat("  Exported: tables/cfa_htmt.csv\n")

# =============================================================================
# ALSO FIT ON FULL SAMPLE
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("CFA ON FULL SAMPLE (for comparison)\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

df_full <- read.csv("data/AIRS_clean.csv", stringsAsFactors = FALSE)
fit_cfa_full <- cfa(cfa_syntax, data = df_full, estimator = "ML")
fm_full <- fitMeasures(fit_cfa_full, c("chisq", "df", "pvalue",
                                        "cfi", "tli", "rmsea", "srmr", "aic", "bic"))
cat(sprintf("  N = %d\n", nrow(df_full)))
cat(sprintf("  CFI = %.4f, TLI = %.4f, RMSEA = %.4f, SRMR = %.4f\n",
            fm_full["cfi"], fm_full["tli"], fm_full["rmsea"], fm_full["srmr"]))

# =============================================================================
# EXPORT SUMMARY JSON
# =============================================================================

cfa_summary <- list(
  analysis_date = format(Sys.time(), "%Y-%m-%dT%H:%M:%S"),
  population = config$population,
  holdout_n = nrow(df_holdout),
  full_n = nrow(df_full),
  n_factors = n_factors,
  n_items = n_items,
  dropped_constructs = names(DROPPED_ITEMS),
  cfa_structure = CFA_STRUCTURE,
  fit_indices_holdout = as.list(round(fit_measures, 6)),
  fit_indices_full = as.list(round(fm_full, 6)),
  factor_loadings = lapply(seq_len(nrow(loadings_df)), function(i) {
    list(factor = loadings_df$Factor[i], item = loadings_df$Item[i],
         loading = round(loadings_df$Loading_Std[i], 4),
         p = loadings_df$p[i])
  }),
  reliability = lapply(seq_len(nrow(reliability_df)), function(i) {
    list(factor = reliability_df$Factor[i],
         CR = round(reliability_df$CR[i], 4),
         AVE = round(reliability_df$AVE[i], 4),
         Alpha = round(reliability_df$Alpha[i], 4))
  }),
  fornell_larcker_violations = violations,
  htmt = lapply(seq_len(nrow(htmt_results)), function(i) {
    list(factor_i = htmt_results$Factor_i[i], factor_j = htmt_results$Factor_j[i],
         htmt = round(htmt_results$HTMT[i], 4), status = htmt_results$Status[i])
  }),
  htmt_violations = htmt_fail,
  factor_correlations = round(cor_lv, 4)
)

write_json(cfa_summary, "tables/cfa_summary.json", pretty = TRUE, auto_unbox = TRUE)
cat("\nExported: tables/cfa_summary.json\n")

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("PHASE 2 COMPLETE\n")
cat(paste(rep("=", 90), collapse = ""), "\n")
