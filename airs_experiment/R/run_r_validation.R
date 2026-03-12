#!/usr/bin/env Rscript
# =============================================================================
# R/lavaan Cross-Validation of AIRS CFA and Structural Models
# Purpose: Independently verify fit indices (especially SRMR) and bootstrap CIs
#          using the gold-standard lavaan package
# =============================================================================

library(lavaan)
library(semTools)

cat("=== AIRS R/lavaan Cross-Validation ===\n")
cat("lavaan version:", as.character(packageVersion("lavaan")), "\n")
cat("semTools version:", as.character(packageVersion("semTools")), "\n\n")

# --- Load data ---
df <- read.csv("data/AIRS_clean.csv")
cat("Full sample N =", nrow(df), "\n")

# --- Load exact holdout subsample (matches Python split) ---
df_cfa <- read.csv("data/AIRS_holdout.csv")
cat("CFA holdout subsample n =", nrow(df_cfa), "\n\n")

# --- Item columns ---
items <- c("PE1", "PE2", "EE1", "EE2", "SI1", "SI2", "FC1", "FC2",
           "HM1", "HM2", "PV1", "PV2", "HB1", "HB2", "TR1", "TR2",
           "BI1", "BI2", "BI3", "BI4")

cat("Item descriptives (full sample):\n")
print(round(sapply(df[items], function(x) c(mean=mean(x,na.rm=T), sd=sd(x,na.rm=T), min=min(x,na.rm=T), max=max(x,na.rm=T))), 3))
cat("\n")

# =============================================================================
# PART 1: CFA Measurement Model (8-factor, 16 items)
# =============================================================================
cat(paste(rep("=", 61), collapse=""), "\n")
cat("PART 1: CFA MEASUREMENT MODEL\n")
cat(paste(rep("=", 61), collapse=""), "\n\n")

cfa_model <- '
  PerfExp   =~ PE1 + PE2
  EffortExp =~ EE1 + EE2
  SocialInf =~ SI1 + SI2
  FacilCond =~ FC1 + FC2
  HedonicMot =~ HM1 + HM2
  PriceValue =~ PV1 + PV2
  Habit     =~ HB1 + HB2
  AITrust   =~ TR1 + TR2
'

# --- 1a: CFA on holdout sample (to match Python CFA exactly) ---
cat("--- CFA on HOLDOUT sample (n=262, matches Python) ---\n")
fit_cfa_hold <- cfa(cfa_model, data = df_cfa, estimator = "ML")
cat("Converged:", lavInspect(fit_cfa_hold, "converged"), "\n")

fs_hold <- fitMeasures(fit_cfa_hold, c("chisq", "df", "pvalue",
                                        "cfi", "tli", "rmsea", "rmsea.ci.lower", "rmsea.ci.upper",
                                        "srmr", "aic", "bic"))
cat("\nFit indices (holdout sample):\n")
print(round(fs_hold, 4))

# --- 1b: CFA on full sample ---
cat("\n--- CFA on FULL sample (N=523) ---\n")
fit_cfa_full <- cfa(cfa_model, data = df, estimator = "ML")
cat("Converged:", lavInspect(fit_cfa_full, "converged"), "\n")

fs_full <- fitMeasures(fit_cfa_full, c("chisq", "df", "pvalue",
                                        "cfi", "tli", "rmsea", "rmsea.ci.lower", "rmsea.ci.upper",
                                        "srmr", "aic", "bic"))
cat("\nFit indices (full sample):\n")
print(round(fs_full, 4))

# Factor correlations
cat("\nFactor correlation matrix (full sample):\n")
fc_full <- lavInspect(fit_cfa_full, "cor.lv")
print(round(fc_full, 3))

# Flag pairs >= .85
cat("\nDiscriminant validity check (|r| >= .85):\n")
fnames <- rownames(fc_full)
any_flagged <- FALSE
for (i in 1:(length(fnames)-1)) {
  for (j in (i+1):length(fnames)) {
    r <- fc_full[i,j]
    if (abs(r) >= 0.85) {
      cat(sprintf("  ⚠️  %s × %s: r = %.3f\n", fnames[i], fnames[j], r))
      any_flagged <- TRUE
    }
  }
}
if (!any_flagged) cat("  None — all |r| < .85\n")

# Heywood cases
cat("\nHeywood case check (|r| > 1.0):\n")
any_heywood <- FALSE
for (i in 1:(length(fnames)-1)) {
  for (j in (i+1):length(fnames)) {
    r <- fc_full[i,j]
    if (abs(r) > 1.0) {
      cat(sprintf("  🚨 HEYWOOD: %s × %s: r = %.3f\n", fnames[i], fnames[j], r))
      any_heywood <- TRUE
    }
  }
}
if (!any_heywood) cat("  None — no Heywood cases\n")

# Reliability
cat("\nReliability (Cronbach's alpha, full sample):\n")
factor_items <- list(
  PerfExp = c("PE1", "PE2"), EffortExp = c("EE1", "EE2"),
  SocialInf = c("SI1", "SI2"), FacilCond = c("FC1", "FC2"),
  HedonicMot = c("HM1", "HM2"), PriceValue = c("PV1", "PV2"),
  Habit = c("HB1", "HB2"), AITrust = c("TR1", "TR2")
)
for (fname in names(factor_items)) {
  itms <- factor_items[[fname]]
  alpha_val <- psych::alpha(df[itms], check.keys = FALSE)$total$raw_alpha
  cat(sprintf("  %s: α = %.3f\n", fname, alpha_val))
}

# Standardized loadings
cat("\nStandardized factor loadings (full sample):\n")
std_est <- standardizedSolution(fit_cfa_full)
loadings <- std_est[std_est$op == "=~", c("lhs", "rhs", "est.std", "pvalue")]
print(loadings)

# =============================================================================
# PART 2: STRUCTURAL MODEL (8 predictors → BI)
# =============================================================================
cat("\n")
cat(paste(rep("=", 61), collapse=""), "\n")
cat("PART 2: STRUCTURAL MODEL\n")
cat(paste(rep("=", 61), collapse=""), "\n\n")

sem_model <- '
  # Measurement model
  PerfExp   =~ PE1 + PE2
  EffortExp =~ EE1 + EE2
  SocialInf =~ SI1 + SI2
  FacilCond =~ FC1 + FC2
  HedonicMot =~ HM1 + HM2
  PriceValue =~ PV1 + PV2
  Habit     =~ HB1 + HB2
  AITrust   =~ TR1 + TR2
  BehIntent =~ BI1 + BI2 + BI3 + BI4

  # Structural paths
  BehIntent ~ PerfExp + EffortExp + SocialInf + FacilCond + HedonicMot + PriceValue + Habit + AITrust
'

cat("--- SEM on FULL sample (N=523) ---\n")
fit_sem <- sem(sem_model, data = df, estimator = "ML")
cat("Converged:", lavInspect(fit_sem, "converged"), "\n")

fs_sem <- fitMeasures(fit_sem, c("chisq", "df", "pvalue",
                                  "cfi", "tli", "rmsea", "rmsea.ci.lower", "rmsea.ci.upper",
                                  "srmr", "aic", "bic"))
cat("\nFit indices (structural model):\n")
print(round(fs_sem, 4))

# R-squared for BehIntent
r2 <- lavInspect(fit_sem, "rsquare")
cat("\nR² values:\n")
print(round(r2, 4))
cat(sprintf("\nR² (BehIntent latent) = %.4f\n", r2["BehIntent"]))

# Structural paths
cat("\nStructural path coefficients:\n")
std_sem <- standardizedSolution(fit_sem)
paths <- std_sem[std_sem$op == "~" & std_sem$lhs == "BehIntent",
                 c("lhs", "rhs", "est.std", "se", "z", "pvalue", "ci.lower", "ci.upper")]
print(paths)

# =============================================================================
# PART 3: BOOTSTRAP CONFIDENCE INTERVALS (1000 iterations)
# =============================================================================
cat("\n")
cat(paste(rep("=", 61), collapse=""), "\n")
cat("PART 3: BOOTSTRAP CIs (1000 iterations)\n")
cat(paste(rep("=", 61), collapse=""), "\n\n")

cat("Running bootstrap (this may take a few minutes)...\n")
fit_sem_boot <- sem(sem_model, data = df, estimator = "ML",
                    se = "bootstrap", bootstrap = 1000,
                    iseed = 42)

cat("Bootstrap completed.\n\n")
cat("Bootstrapped structural paths (percentile CIs):\n")
boot_params <- parameterEstimates(fit_sem_boot, boot.ci.type = "perc",
                                   standardized = TRUE)
boot_paths <- boot_params[boot_params$op == "~" & boot_params$lhs == "BehIntent",
                          c("lhs", "rhs", "est", "se", "ci.lower", "ci.upper", "pvalue", "std.all")]
print(boot_paths)

cat("\nBootstrap CI interpretation:\n")
for (i in 1:nrow(boot_paths)) {
  rhs <- boot_paths$rhs[i]
  lo <- boot_paths$ci.lower[i]
  hi <- boot_paths$ci.upper[i]
  sig <- ifelse(lo > 0 | hi < 0, "SIGNIFICANT", "NOT significant (CI includes zero)")
  cat(sprintf("  %s → BehIntent: [%.3f, %.3f] — %s\n", rhs, lo, hi, sig))
}

# =============================================================================
# PART 4: UTAUT2-ONLY vs AIRS (Trust) MODEL COMPARISON
# =============================================================================
cat("\n")
cat(paste(rep("=", 61), collapse=""), "\n")
cat("PART 4: MODEL COMPARISON (UTAUT2 vs AIRS)\n")
cat(paste(rep("=", 61), collapse=""), "\n\n")

sem_utaut2 <- '
  # Measurement model
  PerfExp   =~ PE1 + PE2
  EffortExp =~ EE1 + EE2
  SocialInf =~ SI1 + SI2
  FacilCond =~ FC1 + FC2
  HedonicMot =~ HM1 + HM2
  PriceValue =~ PV1 + PV2
  Habit     =~ HB1 + HB2
  BehIntent =~ BI1 + BI2 + BI3 + BI4

  # Structural paths (no Trust)
  BehIntent ~ PerfExp + EffortExp + SocialInf + FacilCond + HedonicMot + PriceValue + Habit
'

fit_utaut2 <- sem(sem_utaut2, data = df, estimator = "ML")

fs_utaut2 <- fitMeasures(fit_utaut2, c("chisq", "df", "cfi", "tli", "rmsea", "srmr", "aic", "bic"))
cat("UTAUT2-Only (7 predictors):\n")
print(round(fs_utaut2, 4))

cat("\nFull AIRS (8 predictors):\n")
print(round(fs_sem, 4))

cat(sprintf("\n  ΔAIC = %.2f (positive = AIRS is worse)\n", fs_sem["aic"] - fs_utaut2["aic"]))
cat(sprintf("  ΔBIC = %.2f (positive = AIRS is worse)\n", fs_sem["bic"] - fs_utaut2["bic"]))

# Chi-square difference test (AIRS is nested in a broader sense)
cat("\n  Chi-square diff test:\n")
cat(sprintf("  Δχ² = %.3f, Δdf = %d\n",
    fs_sem["chisq"] - fs_utaut2["chisq"],
    fs_sem["df"] - fs_utaut2["df"]))

# =============================================================================
# PART 5: MULTI-GROUP (Academic vs Professional)
# =============================================================================
cat("\n")
cat(paste(rep("=", 61), collapse=""), "\n")
cat("PART 5: MULTI-GROUP ANALYSIS\n")
cat(paste(rep("=", 61), collapse=""), "\n\n")

# Determine group variable
if ("Role_Category" %in% names(df)) {
  # Create Academic vs Professional grouping
  df$Population <- ifelse(df$Role_Category %in% c("FT_Student", "PT_Student"),
                          "Academic", "Professional")
} else if ("Population" %in% names(df)) {
  df$Population <- df$Population
} else {
  cat("WARNING: Cannot determine population grouping variable\n")
}

cat("Group sizes:\n")
print(table(df$Population))

# Per-group SEM
for (grp in c("Academic", "Professional")) {
  df_grp <- df[df$Population == grp, ]
  cat(sprintf("\n--- %s (n=%d) ---\n", grp, nrow(df_grp)))
  fit_grp <- tryCatch({
    sem(sem_model, data = df_grp, estimator = "ML")
  }, error = function(e) { cat("  ERROR:", e$message, "\n"); NULL })

  if (!is.null(fit_grp) && lavInspect(fit_grp, "converged")) {
    fs_grp <- fitMeasures(fit_grp, c("chisq", "df", "cfi", "tli", "rmsea", "srmr"))
    print(round(fs_grp, 4))
    r2_grp <- lavInspect(fit_grp, "rsquare")
    cat(sprintf("  R² (BehIntent) = %.4f\n", r2_grp["BehIntent"]))
  } else {
    cat("  Model did not converge.\n")
  }
}

# =============================================================================
# PART 6: DISCRIMINANT VALIDITY (AVE vs shared variance)
# =============================================================================
cat("\n")
cat(paste(rep("=", 61), collapse=""), "\n")
cat("PART 6: AVE-BASED DISCRIMINANT VALIDITY (Fornell-Larcker)\n")
cat(paste(rep("=", 61), collapse=""), "\n\n")

# Compute AVE from standardized loadings
ave_vals <- sapply(names(factor_items), function(f) {
  # Get standardized loadings for this factor
  lam <- std_est[std_est$op == "=~" & std_est$lhs == f, "est.std"]
  mean(lam^2)
})
cat("AVE values:\n")
print(round(ave_vals, 3))

cat("\nFornell-Larcker criterion check (√AVE > |r|):\n")
cat("(Shared variance should be less than AVE of both constructs)\n\n")
violations <- 0
for (i in 1:(length(fnames)-1)) {
  for (j in (i+1):length(fnames)) {
    r <- fc_full[i,j]
    r2_shared <- r^2
    ave_i <- ave_vals[fnames[i]]
    ave_j <- ave_vals[fnames[j]]
    pass <- (ave_i > r2_shared) & (ave_j > r2_shared)
    if (!pass) {
      cat(sprintf("  ❌ %s × %s: r=%.3f, r²=%.3f, AVE(%s)=%.3f, AVE(%s)=%.3f\n",
          fnames[i], fnames[j], r, r2_shared, fnames[i], ave_i, fnames[j], ave_j))
      violations <- violations + 1
    }
  }
}
if (violations == 0) {
  cat("  ✅ All pairs pass Fornell-Larcker criterion\n")
} else {
  cat(sprintf("\n  Total violations: %d\n", violations))
}

# =============================================================================
# SUMMARY
# =============================================================================
cat("\n")
cat(paste(rep("=", 61), collapse=""), "\n")
cat("SUMMARY: KEY METRICS COMPARISON\n")
cat(paste(rep("=", 61), collapse=""), "\n\n")

cat(sprintf("CFA SRMR (lavaan, full sample):       %.4f\n", fs_full["srmr"]))
cat(sprintf("SEM SRMR (lavaan, full sample):       %.4f\n", fs_sem["srmr"]))
cat(sprintf("CFA CFI:                              %.4f\n", fs_full["cfi"]))
cat(sprintf("SEM CFI:                              %.4f\n", fs_sem["cfi"]))
cat(sprintf("CFA RMSEA:                            %.4f\n", fs_full["rmsea"]))
cat(sprintf("SEM RMSEA:                            %.4f\n", fs_sem["rmsea"]))
cat(sprintf("SEM R² (BehIntent):                   %.4f\n", r2["BehIntent"]))
cat(sprintf("ΔAIC (AIRS vs UTAUT2):                %.2f\n", fs_sem["aic"] - fs_utaut2["aic"]))

cat("\nComparison with Python (semopy) results:\n")
cat("  Python CFA SRMR (manual):    0.1293\n")
cat("  Python SEM SRMR (manual):    0.1140\n")
cat("  Python CFA CFI:              0.975\n")
cat("  Python SEM CFI:              0.975\n")
cat("  Python SEM R²:               0.896\n")
cat("  Thesis claimed SRMR:         0.048\n")

cat("\n=== Cross-validation complete ===\n")

# Save results to JSON
results <- list(
  lavaan_version = as.character(packageVersion("lavaan")),
  sample_size = nrow(df),
  cfa_full_sample = as.list(round(fs_full, 6)),
  sem_full_sample = as.list(round(fs_sem, 6)),
  sem_r_squared = as.list(round(r2, 6)),
  factor_correlations = round(fc_full, 6),
  ave_values = round(ave_vals, 6),
  bootstrap_paths = boot_paths[, c("rhs", "est", "ci.lower", "ci.upper", "pvalue", "std.all")],
  model_comparison = list(
    utaut2_aic = round(fs_utaut2["aic"], 2),
    airs_aic = round(fs_sem["aic"], 2),
    delta_aic = round(fs_sem["aic"] - fs_utaut2["aic"], 2)
  )
)
jsonlite::write_json(results, "results/r_lavaan_validation.json", pretty = TRUE, auto_unbox = TRUE)
cat("Results saved to results/r_lavaan_validation.json\n")
