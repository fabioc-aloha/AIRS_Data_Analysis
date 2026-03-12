#!/usr/bin/env Rscript
# ==============================================================================
# AIRS Phase 5: Model Comparison & Alternative Analyses
# R port of run_05_mediation.py
#
# Compares UTAUT2-only vs UTAUT2+Trust, explores mediation, tests 5 alternatives.
# Outputs: data/phase5_alternative_analyses.json,
#          tables/utaut2_vs_trust_comparison.csv,
#          tables/alternative_model_comparison.csv,
#          tables/mediation_exploration.csv,
#          plots/model_comparison_alternatives.png
# ==============================================================================

library(lavaan)
library(jsonlite)

set.seed(67)
N_BOOTSTRAP <- 1000

cat(strrep("=", 90), "\n")
cat("PHASE 5: MODEL COMPARISON & ALTERNATIVE ANALYSES\n")
cat(strrep("=", 90), "\n")

dir.create("plots", showWarnings = FALSE)
dir.create("tables", showWarnings = FALSE)

# ── Load Data ─────────────────────────────────────────────────────────────────
df_efa <- read.csv("data/AIRS_experiment.csv", stringsAsFactors = FALSE)
df_cfa <- read.csv("data/AIRS_holdout.csv", stringsAsFactors = FALSE)
df_full <- rbind(df_efa, df_cfa)

# Load upstream structural results
if (file.exists("data/structural_model_results.json")) {
    phase4 <- fromJSON("data/structural_model_results.json")
} else {
    phase4 <- list()
}

# Structure
MODEL_D <- list(
    PerfExp = c("PE1", "PE2"), EffortExp = c("EE1", "EE2"),
    SocialInf = c("SI1", "SI2"), FacilCond = c("FC1", "FC2"),
    HedonicMot = c("HM1", "HM2"), PriceValue = c("PV1", "PV2"),
    Habit = c("HB1", "HB2"), AITrust = c("TR1", "TR2")
)
BI_ITEMS <- c("BI1", "BI2", "BI3", "BI4")

cat(sprintf("Loaded structure: %d factors\n", length(MODEL_D)))

df_full$BI <- rowMeans(df_full[, BI_ITEMS], na.rm = TRUE)
cat(sprintf("\nFull sample: N = %d\n", nrow(df_full)))
cat(sprintf("BI composite: M = %.3f, SD = %.3f\n", mean(df_full$BI), sd(df_full$BI)))

# ── Model Builders ────────────────────────────────────────────────────────────
build_measurement <- function() {
    paste(sapply(names(MODEL_D), function(f) {
        sprintf("%s =~ %s", f, paste(MODEL_D[[f]], collapse = " + "))
    }), collapse = "\n")
}

build_utaut2_only <- function() {
    utaut2 <- setdiff(names(MODEL_D), "AITrust")
    paste0(
        build_measurement(), "\n",
        "BI ~ ", paste(utaut2, collapse = " + ")
    )
}

build_utaut2_trust <- function() {
    paste0(
        build_measurement(), "\n",
        "BI ~ ", paste(names(MODEL_D), collapse = " + ")
    )
}

build_mediation <- function(predictor) {
    paste0(
        build_measurement(), "\n",
        sprintf("BI ~ %s + AITrust\nAITrust ~ %s", predictor, predictor)
    )
}

build_parsimonious <- function() {
    paste0(
        build_measurement(), "\n",
        "BI ~ PriceValue + HedonicMot + SocialInf + AITrust"
    )
}

build_utaut_core <- function() {
    paste0(
        build_measurement(), "\n",
        "BI ~ PerfExp + EffortExp + SocialInf + FacilCond"
    )
}

build_hedonic_value <- function() {
    paste0(
        build_measurement(), "\n",
        "BI ~ HedonicMot + PriceValue + Habit + AITrust"
    )
}

# ── Fit UTAUT2-Only vs UTAUT2+Trust ──────────────────────────────────────────
cat(sprintf("\n%s\n", strrep("=", 90)))
cat("MODEL COMPARISON: UTAUT2-ONLY vs UTAUT2+TRUST\n")
cat(sprintf("%s\n", strrep("=", 90)))

fit_utaut2 <- sem(build_utaut2_only(), data = df_full, estimator = "ML")
fit_trust <- sem(build_utaut2_trust(), data = df_full, estimator = "ML")

get_fit <- function(fit) {
    fm <- fitMeasures(fit, c("chisq", "df", "cfi", "tli", "rmsea", "aic", "bic", "logl"))
    as.list(fm)
}

fm_utaut2 <- get_fit(fit_utaut2)
fm_trust <- get_fit(fit_trust)

for (info in list(list("UTAUT2-Only", fm_utaut2), list("UTAUT2+Trust", fm_trust))) {
    lab <- info[[1]]
    fm <- info[[2]]
    cat(sprintf(
        "\n%s: chi2=%.2f, df=%.0f, CFI=%.3f, TLI=%.3f, RMSEA=%.3f, AIC=%.2f\n",
        lab, fm$chisq, fm$df, fm$cfi, fm$tli, fm$rmsea, fm$aic
    ))
}

# ── Comprehensive Comparison ──────────────────────────────────────────────────
comparison_df <- data.frame(
    Metric = c("chi2", "df", "chi2/df", "CFI", "TLI", "RMSEA", "AIC", "BIC", "LogLik"),
    UTAUT2_Only = c(fm_utaat2_vals <- c(
        fm_utaut2$chisq, fm_utaut2$df,
        fm_utaut2$chisq / fm_utaut2$df,
        fm_utaut2$cfi, fm_utaut2$tli, fm_utaut2$rmsea,
        fm_utaut2$aic, fm_utaut2$bic, fm_utaut2$logl
    )),
    UTAUT2_Trust = c(fm_trust_vals <- c(
        fm_trust$chisq, fm_trust$df,
        fm_trust$chisq / fm_trust$df,
        fm_trust$cfi, fm_trust$tli, fm_trust$rmsea,
        fm_trust$aic, fm_trust$bic, fm_trust$logl
    )),
    stringsAsFactors = FALSE
)
comparison_df$Difference <- comparison_df$UTAUT2_Trust - comparison_df$UTAUT2_Only

# Chi-square difference test
chi2_diff <- fm_utaut2$chisq - fm_trust$chisq
df_diff <- fm_utaut2$df - fm_trust$df
p_chi2 <- pchisq(chi2_diff, abs(df_diff), lower.tail = FALSE)

delta_aic <- fm_trust$aic - fm_utaut2$aic
delta_bic <- fm_trust$bic - fm_utaut2$bic

cat(sprintf("\nDelta-chi2 = %.2f, Delta-df = %.0f, p = %.4f\n", chi2_diff, abs(df_diff), p_chi2))
cat(sprintf("Delta-AIC = %.2f, Delta-BIC = %.2f\n", delta_aic, delta_bic))
if (p_chi2 < 0.05) cat("-> SIGNIFICANT: Trust improves fit\n") else cat("-> NOT SIGNIFICANT\n")

# ── R² Comparison ─────────────────────────────────────────────────────────────
r2_utaut2 <- tryCatch(lavInspect(fit_utaut2, "r2")["BI"], error = function(e) NA)
r2_trust <- tryCatch(lavInspect(fit_trust, "r2")["BI"], error = function(e) NA)
cat(sprintf(
    "\nR² UTAUT2-Only = %.3f, R² UTAUT2+Trust = %.3f, Delta-R² = %.3f\n",
    r2_utaut2, r2_trust, r2_trust - r2_utaut2
))

# ── Structural Path Comparison ────────────────────────────────────────────────
cat("\nStructural Paths:\n")
for (info in list(list("UTAUT2-Only", fit_utaut2), list("UTAUT2+Trust", fit_trust))) {
    lab <- info[[1]]
    fit <- info[[2]]
    pe <- parameterEstimates(fit)
    struct <- pe[pe$op == "~" & pe$lhs == "BI", ]
    cat(sprintf("\n  %s:\n", lab))
    for (i in seq_len(nrow(struct))) {
        r <- struct[i, ]
        sig <- ifelse(abs(r$z) > 3.29, "***",
            ifelse(abs(r$z) > 2.58, "**",
                ifelse(abs(r$z) > 1.96, "*", "")
            )
        )
        cat(sprintf("    %12s -> BI: b=%.3f (SE=%.3f) %s\n", r$rhs, r$est, r$se, sig))
    }
}

# ── Mediation Exploration ─────────────────────────────────────────────────────
cat(sprintf("\n%s\n", strrep("=", 90)))
cat("MEDIATION EXPLORATION: UTAUT2 -> AITrust -> BI\n")
cat(strrep("=", 90), "\n")

utaut2_constructs <- setdiff(names(MODEL_D), "AITrust")
mediation_results <- list()

for (construct in utaut2_constructs) {
    med_result <- tryCatch(
        {
            fit_med <- sem(build_mediation(construct), data = df_full, estimator = "ML")
            pe <- parameterEstimates(fit_med)

            direct <- pe[pe$op == "~" & pe$lhs == "BI" & pe$rhs == construct, ]
            a_path <- pe[pe$op == "~" & pe$lhs == "AITrust" & pe$rhs == construct, ]
            b_path <- pe[pe$op == "~" & pe$lhs == "BI" & pe$rhs == "AITrust", ]

            if (nrow(direct) > 0 && nrow(a_path) > 0 && nrow(b_path) > 0) {
                c_prime <- direct$est[1]
                a <- a_path$est[1]
                b <- b_path$est[1]
                indirect <- a * b
                z_a <- a / a_path$se[1]
                z_b <- b / b_path$se[1]
                z_direct <- c_prime / direct$se[1]

                data.frame(
                    Predictor = construct,
                    a_X_Trust = round(a, 3),
                    b_Trust_BI = round(b, 3),
                    c_prime_Direct = round(c_prime, 3),
                    ab_Indirect = round(indirect, 3),
                    a_sig = ifelse(abs(z_a) > 1.96, "*", ""),
                    b_sig = ifelse(abs(z_b) > 1.96, "*", ""),
                    c_prime_sig = ifelse(abs(z_direct) > 1.96, "*", ""),
                    stringsAsFactors = FALSE
                )
            } else {
                NULL
            }
        },
        error = function(e) {
            cat(sprintf("  %s failed: %s\n", construct, substr(conditionMessage(e), 1, 60)))
            NULL
        }
    )
    if (!is.null(med_result)) mediation_results[[length(mediation_results) + 1]] <- med_result
}

df_mediation <- do.call(rbind, mediation_results)
print(df_mediation)

potential <- df_mediation[df_mediation$a_sig == "*" & df_mediation$b_sig == "*", ]
if (nrow(potential) > 0) {
    cat(sprintf("\nPotential mediations: %s\n", paste(potential$Predictor, collapse = ", ")))
} else {
    cat("\nNo significant mediation paths detected.\n")
}

# ── Bootstrap Mediation: EffortExp -> AITrust -> BI ───────────────────────────
cat(sprintf("\n%s\n", strrep("=", 90)))
cat(sprintf("BOOTSTRAP MEDIATION: EffortExp -> AITrust -> BI (%d iterations)\n", N_BOOTSTRAP))
cat(strrep("=", 90), "\n")

# Use lavaan's built-in bootstrapping with defined indirect effect
med_syntax_boot <- paste0(
    build_measurement(), "\n",
    "BI ~ c*EffortExp + b*AITrust\n",
    "AITrust ~ a*EffortExp\n",
    "indirect := a*b\n",
    "direct   := c\n",
    "total    := c + a*b\n"
)

fit_boot <- sem(med_syntax_boot,
    data = df_full, estimator = "ML",
    se = "bootstrap", bootstrap = N_BOOTSTRAP,
    iseed = 67
)

pe_boot <- parameterEstimates(fit_boot, boot.ci.type = "perc")

indirect_row <- pe_boot[pe_boot$label == "indirect", ]
direct_row <- pe_boot[pe_boot$label == "direct", ]

indirect_est <- indirect_row$est
indirect_ci <- c(indirect_row$ci.lower, indirect_row$ci.upper)
direct_est <- direct_row$est
direct_ci <- c(direct_row$ci.lower, direct_row$ci.upper)

indirect_sig <- !(indirect_ci[1] <= 0 & indirect_ci[2] >= 0)
direct_sig <- !(direct_ci[1] <= 0 & direct_ci[2] >= 0)

if (indirect_sig) {
    med_type <- ifelse(direct_sig, "PARTIAL MEDIATION", "FULL MEDIATION")
} else {
    med_type <- "NO MEDIATION"
}

cat(sprintf(
    "\nIndirect (ab): est=%.3f, 95%% CI [%.3f, %.3f] -> %s\n",
    indirect_est, indirect_ci[1], indirect_ci[2],
    ifelse(indirect_sig, "SIG", "NS")
))
cat(sprintf(
    "Direct (c'):   est=%.3f, 95%% CI [%.3f, %.3f] -> %s\n",
    direct_est, direct_ci[1], direct_ci[2],
    ifelse(direct_sig, "SIG", "NS")
))
cat(sprintf("Mediation Type: %s\n", med_type))

# ── Alternative Models ────────────────────────────────────────────────────────
cat(sprintf("\n%s\n", strrep("=", 90)))
cat("ALTERNATIVE PATH CONFIGURATIONS\n")
cat(strrep("=", 90), "\n")

model_builders <- list(
    "Full AIRS (8 predictors)"      = build_utaut2_trust,
    "UTAUT2-Only (7 predictors)"    = build_utaut2_only,
    "Parsimonious (4 sig)"          = build_parsimonious,
    "UTAUT Core (4 predictors)"     = build_utaut_core,
    "Hedonic-Value (4 predictors)"  = build_hedonic_value
)

alt_results <- list()
for (name in names(model_builders)) {
    res <- tryCatch(
        {
            syntax <- model_builders[[name]]()
            fit <- sem(syntax, data = df_full, estimator = "ML")
            fm <- fitMeasures(fit, c("chisq", "df", "cfi", "tli", "rmsea", "aic", "bic"))
            pe <- parameterEstimates(fit)
            n_paths <- sum(pe$op == "~" & pe$lhs == "BI")

            data.frame(
                Model = name, Paths = n_paths,
                chi2 = fm["chisq"], df = fm["df"],
                CFI = fm["cfi"], TLI = fm["tli"], RMSEA = fm["rmsea"],
                AIC = fm["aic"], BIC = fm["bic"],
                stringsAsFactors = FALSE, row.names = NULL
            )
        },
        error = function(e) {
            cat(sprintf("  %s: Failed - %s\n", name, substr(conditionMessage(e), 1, 80)))
            NULL
        }
    )
    if (!is.null(res)) alt_results[[length(alt_results) + 1]] <- res
}

df_alt <- do.call(rbind, alt_results)
df_alt$chi2_df <- df_alt$chi2 / df_alt$df
df_alt <- df_alt[order(df_alt$AIC), ]
best_model <- df_alt$Model[1]

cat("\nAlternative Model Comparison (sorted by AIC):\n")
print(df_alt[, c("Model", "Paths", "CFI", "TLI", "RMSEA", "AIC", "BIC")], row.names = FALSE)
cat(sprintf("\nBest model (lowest AIC): %s\n", best_model))

# ── Visualization ─────────────────────────────────────────────────────────────
png("plots/model_comparison_alternatives.png", width = 1500, height = 500, res = 150)
par(mfrow = c(1, 3), mar = c(5, 10, 3, 2))

# AIC
colors_aic <- ifelse(df_alt$Model == best_model, "#2ecc71", "#3498db")
barplot(df_alt$AIC,
    names.arg = df_alt$Model, horiz = TRUE, las = 1,
    col = colors_aic, xlab = "AIC (lower is better)", main = "AIC", cex.names = 0.7
)
abline(v = min(df_alt$AIC), col = "red", lty = 2)

# CFI & TLI
plot(1:nrow(df_alt), df_alt$CFI,
    type = "b", pch = 16, col = "#3498db",
    ylim = range(c(df_alt$CFI, df_alt$TLI)), xaxt = "n",
    xlab = "", ylab = "Fit Index", main = "CFI & TLI"
)
points(1:nrow(df_alt), df_alt$TLI, type = "b", pch = 17, col = "#e74c3c")
axis(1, at = 1:nrow(df_alt), labels = df_alt$Model, las = 2, cex.axis = 0.6)
abline(h = 0.95, col = "green", lty = 2)
legend("bottomright",
    legend = c("CFI", "TLI"), col = c("#3498db", "#e74c3c"),
    pch = c(16, 17), cex = 0.8
)

# RMSEA
colors_rmsea <- ifelse(df_alt$RMSEA <= 0.06, "#2ecc71",
    ifelse(df_alt$RMSEA <= 0.08, "#f39c12", "#e74c3c")
)
barplot(df_alt$RMSEA,
    names.arg = df_alt$Model, horiz = TRUE, las = 1,
    col = colors_rmsea, xlab = "RMSEA (lower is better)", main = "RMSEA", cex.names = 0.7
)
abline(v = 0.06, col = "green", lty = 2)
abline(v = 0.08, col = "orange", lty = 2)

dev.off()
cat("\nSaved: plots/model_comparison_alternatives.png\n")

# ── Export ────────────────────────────────────────────────────────────────────
summary_stats <- list(
    analysis_date = Sys.time(),
    sample_size = nrow(df_full),
    model_comparison = list(
        delta_chi2   = chi2_diff,
        delta_chi2_p = p_chi2,
        delta_aic    = delta_aic,
        delta_bic    = delta_bic,
        utaut2_cfi   = fm_utaut2$cfi,
        trust_cfi    = fm_trust$cfi
    ),
    mediation_test = list(
        predictor = "EffortExp",
        indirect_effect = indirect_est,
        indirect_ci_lower = indirect_ci[1],
        indirect_ci_upper = indirect_ci[2],
        mediation_detected = indirect_sig
    ),
    alternative_models = lapply(seq_len(nrow(df_alt)), function(i) {
        as.list(df_alt[i, c("Model", "AIC", "CFI", "RMSEA")])
    }),
    best_model_aic = best_model
)

df_alt_out <- df_alt
write.csv(df_alt_out, "tables/alternative_model_comparison.csv", row.names = FALSE)
write.csv(comparison_df, "tables/utaut2_vs_trust_comparison.csv", row.names = FALSE)
write.csv(df_mediation, "tables/mediation_exploration.csv", row.names = FALSE)
write_json(summary_stats, "data/phase5_alternative_analyses.json",
    pretty = TRUE, auto_unbox = TRUE
)

cat("\nExported: tables/alternative_model_comparison.csv, utaut2_vs_trust_comparison.csv,\n")
cat("  mediation_exploration.csv, data/phase5_alternative_analyses.json\n")

cat(sprintf("\n%s\n", strrep("=", 90)))
cat("PHASE 5 COMPLETE\n")
cat(strrep("=", 90), "\n")
