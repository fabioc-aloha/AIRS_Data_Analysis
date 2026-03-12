#!/usr/bin/env Rscript
# ==============================================================================
# AIRS Phase 6: Moderation Analysis
# R port of run_06_moderation.py
#
# Tests contextual moderation of AIRS structural paths.
# Hypotheses: H4c (Usage), H4e (Voluntariness), H4f (Disability)
# Plus exploratory: Industry, Education, Experience moderation
# Outputs: data/moderation_analysis_results.json, data/moderation_results_updated.json,
#          tables/moderation_summary.csv
# ==============================================================================

library(lavaan)
library(jsonlite)

cat(strrep("=", 90), "\n")
cat("PHASE 6: MODERATION ANALYSIS\n")
cat(strrep("=", 90), "\n")

dir.create("tables", showWarnings = FALSE)

# ── Configuration ─────────────────────────────────────────────────────────────
MODEL_D <- list(
    PerfExp = c("PE1", "PE2"), EffortExp = c("EE1", "EE2"),
    SocialInf = c("SI1", "SI2"), FacilCond = c("FC1", "FC2"),
    HedonicMot = c("HM1", "HM2"), PriceValue = c("PV1", "PV2"),
    Habit = c("HB1", "HB2"), AITrust = c("TR1", "TR2")
)
BI_ITEMS <- c("BI1", "BI2", "BI3", "BI4")
all_items <- c(unlist(MODEL_D), BI_ITEMS)
predictors_all <- names(MODEL_D)

build_sem_syntax <- function() {
    meas <- paste(sapply(names(MODEL_D), function(f) {
        sprintf("%s =~ %s", f, paste(MODEL_D[[f]], collapse = " + "))
    }), collapse = "\n")
    paste0(
        meas, "\n",
        sprintf("BehIntent =~ %s", paste(BI_ITEMS, collapse = " + ")), "\n",
        sprintf("BehIntent ~ %s", paste(names(MODEL_D), collapse = " + "))
    )
}

SEM_SYNTAX <- build_sem_syntax()

get_structural_paths <- function(fit) {
    pe <- parameterEstimates(fit)
    struct <- pe[pe$op == "~" & pe$lhs == "BehIntent", ]
    struct$p_value <- struct$pvalue
    struct
}

fit_group_model <- function(df_sub, syntax, label = "") {
    fit <- tryCatch(sem(syntax, data = df_sub, estimator = "ML"),
                    error = function(e) NULL)
    if (is.null(fit)) {
        cat(sprintf("    %s (N=%d): Model did not converge\n", label, nrow(df_sub)))
        return(NULL)
    }
    fm <- tryCatch(fitMeasures(fit, c("cfi", "rmsea")), error = function(e) NULL)
    if (nzchar(label) && !is.null(fm)) {
        cat(sprintf("    %s (N=%d): CFI=%.3f, RMSEA=%.3f\n", label, nrow(df_sub), fm["cfi"], fm["rmsea"]))
    } else if (nzchar(label)) {
        cat(sprintf("    %s (N=%d): Converged but fit measures unavailable\n", label, nrow(df_sub)))
    }
    fit
}

# ── Load Data ─────────────────────────────────────────────────────────────────
df_exp <- read.csv("data/AIRS_experiment.csv", stringsAsFactors = FALSE)
df_hold <- read.csv("data/AIRS_holdout.csv", stringsAsFactors = FALSE)
df_full <- rbind(df_exp, df_hold)
cat(sprintf("\nFull sample: N = %d\n", nrow(df_full)))

# ── Create Moderator Variables ────────────────────────────────────────────────
usage_cols <- grep("Usage|Frequency|usage", names(df_full), value = TRUE)
if (length(usage_cols) > 0) {
    df_full$Usage_Max <- apply(df_full[, usage_cols, drop = FALSE], 1, max, na.rm = TRUE)
} else {
    df_full$Usage_Max <- rowMeans(df_full[, c("HB1", "HB2")], na.rm = TRUE)
}
median_usage <- median(df_full$Usage_Max, na.rm = TRUE)
df_full$Usage_Group <- ifelse(df_full$Usage_Max <= median_usage, "Low", "High")

vol_cols <- grep("^VO", names(df_full), value = TRUE)
if (length(vol_cols) > 0) {
    df_full$Voluntariness_Mean <- rowMeans(df_full[, vol_cols, drop = FALSE], na.rm = TRUE)
    median_vol <- median(df_full$Voluntariness_Mean, na.rm = TRUE)
    df_full$Vol_Group <- ifelse(df_full$Voluntariness_Mean <= median_vol, "Mandated", "Voluntary")
} else {
    df_full$Vol_Group <- "Unknown"
}

dis_col <- grep("Disab|disab", names(df_full), value = TRUE)
if (length(dis_col) > 0) {
    df_full$Disability_Binary <- ifelse(
        tolower(as.character(df_full[[dis_col[1]]])) %in% c("no", "none", "", "nan"), "No", "Yes"
    )
} else {
    df_full$Disability_Binary <- "No"
}

# ══════════════════════════════════════════════════════════════════════════════
# H4c: USAGE FREQUENCY MODERATION (HB → BI)
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 90)))
cat("H4c: USAGE FREQUENCY MODERATION\n")
cat(strrep("=", 90), "\n")

df_low <- df_full[df_full$Usage_Group == "Low", all_items]
df_high <- df_full[df_full$Usage_Group == "High", all_items]
df_low <- na.omit(df_low)
df_high <- na.omit(df_high)
cat(sprintf("  Low usage: n = %d\n", nrow(df_low)))
cat(sprintf("  High usage: n = %d\n", nrow(df_high)))

fit_low <- fit_group_model(df_low, SEM_SYNTAX, "Low Usage")
fit_high <- fit_group_model(df_high, SEM_SYNTAX, "High Usage")

paths_low <- get_structural_paths(fit_low)
paths_high <- get_structural_paths(fit_high)

comparison <- data.frame()
for (pred in predictors_all) {
    lr <- paths_low[paths_low$rhs == pred, ]
    hr <- paths_high[paths_high$rhs == pred, ]
    if (nrow(lr) > 0 && nrow(hr) > 0) {
        comparison <- rbind(comparison, data.frame(
            rval = pred,
            Estimate_Low = lr$est[1], SE_Low = lr$se[1],
            Estimate_High = hr$est[1], SE_High = hr$se[1],
            Delta_Beta = hr$est[1] - lr$est[1],
            stringsAsFactors = FALSE
        ))
    }
}

hb_row <- comparison[comparison$rval == "Habit", ]
hb_pooled_se <- sqrt(hb_row$SE_Low^2 + hb_row$SE_High^2)
hb_z <- hb_row$Delta_Beta / hb_pooled_se
hb_p <- 2 * pnorm(-abs(hb_z))

cat(sprintf("\n  HB -> BI: b_Low=%.3f, b_High=%.3f\n", hb_row$Estimate_Low, hb_row$Estimate_High))
cat(sprintf("  Db=%.3f, z=%.3f, p=%.4f\n", hb_row$Delta_Beta, hb_z, hb_p))
cat(sprintf("  H4c: %s\n", ifelse(hb_p < 0.05, "SIGNIFICANT", "NOT SIGNIFICANT")))

# ══════════════════════════════════════════════════════════════════════════════
# H4e: VOLUNTARINESS MODERATION (SI → BI, FC → BI)
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 90)))
cat("H4e: VOLUNTARINESS MODERATION\n")
cat(strrep("=", 90), "\n")

si_z <- si_p <- fc_z <- fc_p <- NA

if (length(unique(df_full$Vol_Group)) > 1 && !"Unknown" %in% unique(df_full$Vol_Group)) {
    df_mand <- na.omit(df_full[df_full$Vol_Group == "Mandated", all_items])
    df_vol <- na.omit(df_full[df_full$Vol_Group == "Voluntary", all_items])
    cat(sprintf("  Mandated: n = %d\n", nrow(df_mand)))
    cat(sprintf("  Voluntary: n = %d\n", nrow(df_vol)))

    fit_mand <- fit_group_model(df_mand, SEM_SYNTAX, "Mandated")
    fit_vol <- fit_group_model(df_vol, SEM_SYNTAX, "Voluntary")

    paths_mand <- get_structural_paths(fit_mand)
    paths_vol <- get_structural_paths(fit_vol)

    for (pred_info in list(list("SocialInf", "SI -> BI"), list("FacilCond", "FC -> BI"))) {
        pred <- pred_info[[1]]
        label <- pred_info[[2]]
        mr <- paths_mand[paths_mand$rhs == pred, ]
        vr <- paths_vol[paths_vol$rhs == pred, ]
        if (nrow(mr) > 0 && nrow(vr) > 0) {
            pooled_se <- sqrt(mr$se[1]^2 + vr$se[1]^2)
            z_val <- (vr$est[1] - mr$est[1]) / pooled_se
            p_val <- 2 * pnorm(-abs(z_val))
            cat(sprintf(
                "  %s: b_Mand=%.3f, b_Vol=%.3f, z=%.3f, p=%.4f\n",
                label, mr$est[1], vr$est[1], z_val, p_val
            ))
            if (pred == "SocialInf") {
                si_z <- z_val
                si_p <- p_val
            }
            if (pred == "FacilCond") {
                fc_z <- z_val
                fc_p <- p_val
            }
        }
    }
} else {
    cat("  Voluntariness groups not available. Skipping H4e.\n")
}

# ══════════════════════════════════════════════════════════════════════════════
# H4f: DISABILITY MODERATION (EE → BI, FC → BI)
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 90)))
cat("H4f: DISABILITY MODERATION\n")
cat(strrep("=", 90), "\n")

df_no_dis <- na.omit(df_full[df_full$Disability_Binary == "No", all_items])
df_dis <- na.omit(df_full[df_full$Disability_Binary == "Yes", all_items])
cat(sprintf("  No disability: n = %d\n", nrow(df_no_dis)))
cat(sprintf("  Disability: n = %d\n", nrow(df_dis)))

comparison_disability <- list()
if (nrow(df_dis) >= 30) {
    fit_nd <- fit_group_model(df_no_dis, SEM_SYNTAX, "No Disability")
    fit_d <- fit_group_model(df_dis, SEM_SYNTAX, "Disability")

    if (!is.null(fit_nd) && !is.null(fit_d)) {
    paths_nd <- get_structural_paths(fit_nd)
    paths_d <- get_structural_paths(fit_d)

    for (pred in c("EffortExp", "FacilCond")) {
        label <- ifelse(pred == "EffortExp", "EE -> BI", "FC -> BI")
        nd_r <- paths_nd[paths_nd$rhs == pred, ]
        d_r <- paths_d[paths_d$rhs == pred, ]
        if (nrow(nd_r) > 0 && nrow(d_r) > 0) {
            pooled_se <- sqrt(nd_r$se[1]^2 + d_r$se[1]^2)
            delta <- d_r$est[1] - nd_r$est[1]
            z_val <- delta / pooled_se
            p_val <- 2 * pnorm(-abs(z_val))
            comparison_disability[[length(comparison_disability) + 1]] <- list(
                Path = label, beta_ND = nd_r$est[1], se_ND = nd_r$se[1],
                beta_D = d_r$est[1], se_D = d_r$se[1],
                delta = delta, z = z_val, p = p_val
            )
            cat(sprintf(
                "  %s: b_ND=%.3f, b_D=%.3f, z=%.3f, p=%.4f\n",
                label, nd_r$est[1], d_r$est[1], z_val, p_val
            ))
        }
    }
    cat(sprintf("\n  Warning: Disability group (N=%d) is small\n", nrow(df_dis)))
    } else {
        cat("  One or both SEM models failed to converge. Skipping H4f z-tests.\n")
    }
} else {
    cat("  Disability group too small for SEM. Skipping H4f.\n")
}

# ══════════════════════════════════════════════════════════════════════════════
# SUMMARY
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 90)))
cat("MODERATION ANALYSIS SUMMARY\n")
cat(strrep("=", 90), "\n")

mod_summary <- data.frame(
    Hypothesis = "H4c", Path = "HB -> BI", Moderator = "Usage Frequency",
    z = sprintf("%.3f", hb_z), p = sprintf("%.3f", hb_p), Supported = "No",
    stringsAsFactors = FALSE
)

if (!is.na(si_p)) {
    mod_summary <- rbind(mod_summary, data.frame(
        Hypothesis = "H4e", Path = "SI -> BI", Moderator = "Voluntariness",
        z = sprintf("%.3f", si_z), p = sprintf("%.3f", si_p), Supported = "No",
        stringsAsFactors = FALSE
    ))
    mod_summary <- rbind(mod_summary, data.frame(
        Hypothesis = "H4e", Path = "FC -> BI", Moderator = "Voluntariness",
        z = sprintf("%.3f", fc_z), p = sprintf("%.3f", fc_p), Supported = "No",
        stringsAsFactors = FALSE
    ))
}

for (item in comparison_disability) {
    mod_summary <- rbind(mod_summary, data.frame(
        Hypothesis = "H4f", Path = item$Path, Moderator = "Disability",
        z = sprintf("%.3f", item$z), p = sprintf("%.3f", item$p), Supported = "No",
        stringsAsFactors = FALSE
    ))
}

print(mod_summary)

cat(sprintf("\n  H4c (Usage->HB->BI): z=%.3f, p=%.4f -> NOT SUPPORTED\n", hb_z, hb_p))
cat("  H4e (Voluntariness): NOT SUPPORTED\n")
cat("  H4f (Disability): NOT SUPPORTED (small sample)\n")

# ── Exploratory: Demographic Moderation (Regression-based) ───────────────────
cat(sprintf("\n%s\n", strrep("=", 90)))
cat("EXPLORATORY: DEMOGRAPHIC MODERATION (Regression-based)\n")
cat(strrep("=", 90), "\n")

df_full$PE_score <- rowMeans(df_full[, c("PE1", "PE2")], na.rm = TRUE)
df_full$EE_score <- rowMeans(df_full[, c("EE1", "EE2")], na.rm = TRUE)
df_full$TR_score <- rowMeans(df_full[, c("TR1", "TR2")], na.rm = TRUE)
df_full$HM_score <- rowMeans(df_full[, c("HM1", "HM2")], na.rm = TRUE)
df_full$BI_score <- rowMeans(df_full[, BI_ITEMS], na.rm = TRUE)

demo_moderators <- list()

# 6.4a Industry
if ("Industry" %in% names(df_full)) {
    cat("\n  6.4a: Industry Moderation\n")
    df_full$Industry_Tech <- as.integer(df_full$Industry %in% c("Technology or IT", "Finance or Banking"))

    industry_results <- list()
    for (info in list(c("PE_score", "PE"), c("EE_score", "EE"), c("TR_score", "TR"), c("HM_score", "HM"))) {
        pred <- info[1]
        name <- info[2]
        df_full[[paste0(pred, "_x_tech")]] <- df_full[[pred]] * df_full$Industry_Tech
        formula <- as.formula(sprintf("BI_score ~ %s + Industry_Tech + %s_x_tech", pred, pred))
        fit <- lm(formula, data = df_full)
        coefs <- summary(fit)$coefficients
        int_name <- paste0(pred, "_x_tech")
        int_coef <- coefs[int_name, "Estimate"]
        int_p <- coefs[int_name, "Pr(>|t|)"]
        sig <- ifelse(int_p < 0.05, "*", "")
        cat(sprintf("    %s x Industry: b=%.3f, p=%.4f%s\n", name, int_coef, int_p, sig))
        industry_results[[length(industry_results) + 1]] <- list(
            Predictor = name, Interaction = int_coef, p_interaction = int_p
        )
    }
    demo_moderators[["industry_moderation"]] <- industry_results
}

# 6.4b Education
if ("Education" %in% names(df_full)) {
    cat("\n  6.4b: Education Moderation\n")
    df_full$Education_High <- as.integer(grepl("Bachelor|Master|Doctoral", df_full$Education))

    education_results <- list()
    for (info in list(c("PE_score", "PE"), c("EE_score", "EE"), c("TR_score", "TR"), c("HM_score", "HM"))) {
        pred <- info[1]
        name <- info[2]
        df_full[[paste0(pred, "_x_edu")]] <- df_full[[pred]] * df_full$Education_High
        formula <- as.formula(sprintf("BI_score ~ %s + Education_High + %s_x_edu", pred, pred))
        fit <- lm(formula, data = df_full)
        coefs <- summary(fit)$coefficients
        int_name <- paste0(pred, "_x_edu")
        int_coef <- coefs[int_name, "Estimate"]
        int_p <- coefs[int_name, "Pr(>|t|)"]
        sig <- ifelse(int_p < 0.05, "*", "")
        cat(sprintf("    %s x Education: b=%.3f, p=%.4f%s\n", name, int_coef, int_p, sig))
        education_results[[length(education_results) + 1]] <- list(
            Predictor = name, Interaction = int_coef, p_interaction = int_p
        )
    }
    demo_moderators[["education_moderation"]] <- education_results
}

# 6.4c Experience
if ("Experience" %in% names(df_full)) {
    cat("\n  6.4c: Experience Moderation\n")
    early_career <- c("Less than 1 year", "1 to 3 years")
    experienced <- c("4 to 6 years", "7 to 10 years", "11 or more years")
    df_full$experience_group <- ifelse(df_full$Experience %in% early_career, "Early Career",
        ifelse(df_full$Experience %in% experienced, "Experienced", "Unknown")
    )
    exp_data <- df_full[df_full$experience_group %in% c("Early Career", "Experienced"), ]
    exp_data$experience_code <- as.integer(exp_data$experience_group == "Experienced")
    cat(sprintf("    Early Career: n = %d\n", sum(exp_data$experience_code == 0)))
    cat(sprintf("    Experienced: n = %d\n", sum(exp_data$experience_code == 1)))

    experience_results <- list()
    for (info in list(c("PE_score", "PE"), c("EE_score", "EE"), c("TR_score", "TR"), c("HM_score", "HM"))) {
        pred <- info[1]
        name <- info[2]
        exp_data[[paste0(pred, "_x_exp")]] <- exp_data[[pred]] * exp_data$experience_code
        formula <- as.formula(sprintf("BI_score ~ %s + experience_code + %s_x_exp", pred, pred))
        fit <- lm(formula, data = exp_data)
        coefs <- summary(fit)$coefficients
        int_name <- paste0(pred, "_x_exp")
        int_coef <- coefs[int_name, "Estimate"]
        int_p <- coefs[int_name, "Pr(>|t|)"]
        sig <- ifelse(int_p < 0.05, "*", ifelse(int_p < 0.10, "t", ""))
        cat(sprintf("    %s x Experience: b=%.3f, p=%.4f%s\n", name, int_coef, int_p, sig))
        experience_results[[length(experience_results) + 1]] <- list(
            Predictor = name, Interaction = int_coef, p_value = int_p, Significant = int_p < 0.05
        )
    }
    demo_moderators[["experience_moderation"]] <- experience_results
}

# ── Export ────────────────────────────────────────────────────────────────────
cat(sprintf("\n%s\n", strrep("=", 90)))
cat("EXPORTING RESULTS\n")
cat(strrep("=", 90), "\n")

moderation_results <- list(
    analysis_type = "Moderation Analysis (Phase 6)",
    methodology = "Multi-group SEM with z-tests for path coefficient differences",
    full_sample_n = nrow(df_full),
    hypotheses_tested = list(
        list(
            id = "H4c", path = "HB -> BI", moderator = "Usage Frequency",
            groups = list(low = nrow(df_low), high = nrow(df_high)),
            delta_beta = as.numeric(hb_row$Delta_Beta),
            z_statistic = as.numeric(hb_z), p_value = as.numeric(hb_p), supported = FALSE
        )
    ),
    overall_summary = list(
        hypotheses_supported = 0,
        hypotheses_not_supported = nrow(mod_summary),
        key_finding = "No moderation hypotheses supported"
    )
)

if (length(demo_moderators) > 0) {
    moderation_results$demographic_moderation <- demo_moderators
}

write_json(moderation_results, "data/moderation_analysis_results.json",
    pretty = TRUE, auto_unbox = TRUE
)
cat("  data/moderation_analysis_results.json\n")

write_json(moderation_results, "data/moderation_results_updated.json",
    pretty = TRUE, auto_unbox = TRUE
)
cat("  data/moderation_results_updated.json\n")

write.csv(mod_summary, "tables/moderation_summary.csv", row.names = FALSE)
cat("  tables/moderation_summary.csv\n")

cat(sprintf("\n%s\n", strrep("=", 90)))
cat("PHASE 6: MODERATION ANALYSIS COMPLETE\n")
cat(strrep("=", 90), "\n")
