#!/usr/bin/env Rscript
# ==============================================================================
# AIRS Phase 10: Final Synthesis
# R port of run_10_synthesis.py
#
# Loads ALL upstream JSON results and produces:
#   - Hypothesis support summary
#   - Model fit summary table
#   - Construct reliability table
#   - Novel findings summary
#   - Cross-tabulation: User Typology x Qualitative Themes
#   - Hypothesis summary & structural path visualizations
#   - Final synthesis JSON export
# Outputs: data/final_synthesis.json, tables/10_typology_theme_crosstab.csv, 3 plots
# ==============================================================================

library(jsonlite)

cat(strrep("=", 90), "\n")
cat("PHASE 10: FINAL SYNTHESIS\n")
cat(strrep("=", 90), "\n")

dir.create("results", showWarnings = FALSE)
dir.create("plots", showWarnings = FALSE)
dir.create("tables", showWarnings = FALSE)
dir.create("data", showWarnings = FALSE)

safe_fmt <- function(val, fmt = "%.3f") {
    if (is.null(val) || is.na(val)) {
        return("N/A")
    }
    sprintf(fmt, as.numeric(val))
}

load_json <- function(path) {
    if (file.exists(path)) fromJSON(path, simplifyVector = FALSE) else list()
}

# ══════════════════════════════════════════════════════════════════════════════
# Load all upstream results
# ══════════════════════════════════════════════════════════════════════════════
cat(strrep("=", 80), "\n")
cat("LOADING UPSTREAM RESULTS\n")
cat(strrep("=", 80), "\n")

load_map <- list(
    sample = "data/sample_characteristics.json",
    efa = "tables/efa_summary.json",
    cfa = "tables/cfa_summary.json",
    invariance = "data/invariance_results.json",
    structural = "data/structural_model_results.json",
    mediation = "data/phase5_alternative_analyses.json",
    tool_usage = "results/phase7_tool_usage_results.json",
    qualitative = "results/phase8_qualitative_results.json",
    comprehensive = "results/phase9_comprehensive_review_results.json"
)
mod_path <- if (file.exists("data/moderation_results_updated.json")) {
    "data/moderation_results_updated.json"
} else {
    "data/moderation_analysis_results.json"
}
load_map$moderation <- mod_path

results <- list()
for (key in names(load_map)) {
    data <- load_json(load_map[[key]])
    results[[key]] <- data
    status <- if (length(data) > 0) "OK" else "MISSING"
    cat(sprintf("  [%s] %s: %s\n", status, key, load_map[[key]]))
}

# ══════════════════════════════════════════════════════════════════════════════
# Section 1: Sample Description
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 80)))
cat("SAMPLE DESCRIPTION\n")
cat(strrep("=", 80), "\n")

samp <- results$sample
cat(sprintf("  Total N: %s\n", samp$total_n %||% "N/A"))
cat(sprintf("  EFA N: %s\n", samp$efa_n %||% "N/A"))
cat(sprintf("  CFA N: %s\n", samp$cfa_n %||% "N/A"))

# ══════════════════════════════════════════════════════════════════════════════
# Section 2: Hypothesis Testing Summary
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 80)))
cat("HYPOTHESIS TESTING SUMMARY\n")
cat(strrep("=", 80), "\n")

struct <- results$structural
path_coefficients <- struct$path_coefficients %||% list()
hr <- struct$hypothesis_results %||% list()

h1_mapping <- list(
    PerfExp = "H1a", EffortExp = "H1b", SocialInf = "H1c", FacilCond = "H1d",
    HedonicMot = "H1e", PriceValue = "H1f", Habit = "H1g"
)

h1_supported <- 0
h1_total <- 0
cat("\nH1: UTAUT2 predictors -> BI\n")
for (p in path_coefficients) {
    pred <- p$predictor %||% ""
    if (pred %in% names(h1_mapping)) {
        h1_total <- h1_total + 1
        beta <- p$beta_std %||% 0
        pval <- p$p %||% 1
        supported <- pval < 0.05 && beta > 0
        if (supported) h1_supported <- h1_supported + 1
        status <- ifelse(supported, "SUPPORTED", "Not supported")
        cat(sprintf("  %s (%s): beta=%.3f, p=%.4f -> %s\n", h1_mapping[[pred]], pred, beta, pval, status))
    }
}

# H2
h2_beta <- hr$H2_trust_beta
h2_p <- hr$H2_trust_p
if (is.null(h2_beta)) {
    for (p in path_coefficients) {
        if ((p$predictor %||% "") == "AITrust") {
            h2_beta <- p$beta_std %||% 0
            h2_p <- p$p %||% 1
        }
    }
}
h2_marginal <- if (!is.null(h2_p)) h2_p < 0.10 else FALSE
cat(sprintf(
    "\nH2: AI Trust -> BI: beta=%s, p=%s -> %s\n",
    safe_fmt(h2_beta), safe_fmt(h2_p),
    ifelse(h2_marginal, "MARGINAL", "Not supported")
))

# H3
h3 <- hr$H3_incremental_validity %||% FALSE
cat(sprintf("\nH3: Incremental validity: %s\n", ifelse(h3, "SUPPORTED", "Not supported")))

# H4
mod <- results$moderation
cat("\nH4: Moderation effects\n")
h4_effects <- 0
if (!is.null(mod$experience_moderation)) {
    for (item in mod$experience_moderation) {
        sig <- tolower(as.character(item$Significant %||% "False")) == "true"
        if (sig) h4_effects <- h4_effects + 1
        cat(sprintf(
            "  Experience x %s: p=%.4f -> %s\n",
            item$Predictor %||% "", item$p_value %||% 1, ifelse(sig, "SIGNIFICANT", "NS")
        ))
    }
}

cat("\nH5: Dropped constructs (VO, EX, ER -> not testable)\n")

# ══════════════════════════════════════════════════════════════════════════════
# Section 3: Model Fit Summary
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 80)))
cat("MODEL FIT SUMMARY\n")
cat(strrep("=", 80), "\n")

cfa <- results$cfa
fit <- cfa$fit_indices %||% list()
cat(sprintf(
    "  CFA: CFI=%s, TLI=%s, RMSEA=%s, SRMR=%s\n",
    safe_fmt(fit$cfi), safe_fmt(fit$tli), safe_fmt(fit$rmsea), safe_fmt(fit$srmr)
))

struct_fit <- struct$full_sample_fit %||% list()
cat(sprintf(
    "  Structural: CFI=%s, RMSEA=%s, R2=%s\n",
    safe_fmt(struct_fit$cfi), safe_fmt(struct_fit$rmsea), safe_fmt(struct$r_squared)
))

# ══════════════════════════════════════════════════════════════════════════════
# Section 4: Reliability Summary
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 80)))
cat("CONSTRUCT RELIABILITY\n")
cat(strrep("=", 80), "\n")

factor_name_map <- list(
    PerfExp = "PE", EffortExp = "EE", SocialInf = "SI", FacilCond = "FC",
    FacCond = "FC", HedonicMot = "HM", HedMot = "HM",
    PriceValue = "PV", PriceVal = "PV", Habit = "HB",
    AITrust = "TR", Trust = "TR"
)

cfa_rel <- cfa$reliability %||% list()
efa <- results$efa
efa_rel <- efa$reliability_coefficients %||% list()

for (factor in c("PE", "EE", "SI", "FC", "HM", "PV", "HB", "TR")) {
    cr_val <- "N/A"
    ave_val <- "N/A"
    efa_alpha <- "N/A"
    # Try to find in CFA reliability
    for (nm in names(cfa_rel)) {
        mapped <- factor_name_map[[nm]]
        if (!is.null(mapped) && mapped == factor) {
            entry <- cfa_rel[[nm]]
            if (is.list(entry)) {
                cr_val <- safe_fmt(entry$composite_reliability %||% entry$alpha)
                ave_val <- safe_fmt(entry$ave)
            }
        }
    }
    if (!is.null(efa_rel[[factor]])) efa_alpha <- safe_fmt(efa_rel[[factor]])
    cat(sprintf("  %s: CR=%s, AVE=%s, EFA alpha=%s\n", factor, cr_val, ave_val, efa_alpha))
}

# ══════════════════════════════════════════════════════════════════════════════
# Section 5: Novel Findings
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 80)))
cat("NOVEL FINDINGS\n")
cat(strrep("=", 80), "\n")

strongest_beta <- 0
strongest_name <- ""
hypothesis_map <- list(
    PerfExp = "Performance Expectancy", EffortExp = "Effort Expectancy",
    SocialInf = "Social Influence", FacilCond = "Facilitating Conditions",
    HedonicMot = "Hedonic Motivation", PriceValue = "Price Value",
    Habit = "Habit", AITrust = "AI Trust"
)
for (p in path_coefficients) {
    if ((p$p %||% 1) < 0.05 && (p$beta_std %||% 0) > strongest_beta) {
        strongest_beta <- p$beta_std
        strongest_name <- hypothesis_map[[p$predictor]] %||% p$predictor
    }
}
if (nchar(strongest_name) > 0) {
    cat(sprintf("  1. %s as strongest predictor (beta=%.3f)\n", strongest_name, strongest_beta))
}

# ══════════════════════════════════════════════════════════════════════════════
# Section 7: Export Final Synthesis JSON
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 80)))
cat("EXPORTING FINAL SYNTHESIS\n")
cat(strrep("=", 80), "\n")

synthesis <- list(
    study_overview = list(
        purpose = "Develop and validate AIRS instrument",
        theoretical_base = "UTAUT2 + AI Trust extension",
        sample_size = cfa$n_observations %||% 523,
        validated_model = sprintf(
            "Model D: %s factors, %s items",
            cfa$n_factors %||% 8, cfa$n_items %||% 16
        )
    ),
    hypothesis_summary = list(
        H1_supported = h1_supported, H1_total = h1_total,
        H2_trust_beta = h2_beta, H2_trust_p = h2_p, H2_marginal = h2_marginal,
        H3_incremental_validity = h3, H4_moderation_effects = h4_effects
    ),
    phase_results = list()
)

if (length(cfa) > 0) {
    synthesis$phase_results$cfa <- list(
        fit_indices = fit, n_observations = cfa$n_observations,
        reliability = cfa$reliability
    )
}
if (length(struct) > 0) {
    synthesis$phase_results$structural <- list(
        full_sample_n = struct$full_sample_n,
        full_sample_fit = struct_fit,
        hypothesis_results = hr
    )
}

write_json(synthesis, "data/final_synthesis.json", pretty = TRUE, auto_unbox = TRUE)
cat("Saved data/final_synthesis.json\n")

# ══════════════════════════════════════════════════════════════════════════════
# Section 8: Hypothesis Summary Visualization
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 80)))
cat("VISUALIZATIONS\n")
cat(strrep("=", 80), "\n")

hs <- synthesis$hypothesis_summary
h1_sup <- hs$H1_supported
h1_not <- hs$H1_total - h1_sup
h2_marg <- ifelse(hs$H2_marginal, 1, 0)
h2_not <- 1 - h2_marg
h4_sig <- hs$H4_moderation_effects
h4_not <- 5 - h4_sig

png("plots/hypothesis_summary.png", width = 1200, height = 600, res = 150)
categories <- c("H1\n(UTAUT2)", "H2\n(AI Trust)", "H3\n(Differences)", "H4\n(Moderation)", "H5\n(Mediation)")
barplot_data <- rbind(
    Supported = c(h1_sup, 0, 0, h4_sig, 0),
    Marginal = c(0, h2_marg, 0, 0, 0),
    `Not Supported` = c(h1_not, h2_not, 1, h4_not, 0),
    `Not Testable` = c(0, 0, 0, 0, 3)
)
colnames(barplot_data) <- categories
barplot(barplot_data,
    beside = TRUE,
    col = c("#2e7d32", "#f57c00", "#c62828", "#757575"),
    ylab = "Number of Hypotheses",
    main = "Hypothesis Testing Summary by Category",
    legend.text = TRUE, args.legend = list(x = "topright", cex = 0.8)
)
dev.off()
cat("Saved plots/hypothesis_summary.png\n")

# Structural path coefficients
hyp_map <- c(h1_mapping, list(AITrust = "H2"))
predictor_labels <- list(
    PerfExp = "Perf. Expect.", EffortExp = "Effort Exp.",
    SocialInf = "Social Inf.", FacilCond = "Fac. Cond.",
    HedonicMot = "Hedonic Mot.", PriceValue = "Price Value",
    Habit = "Habit", AITrust = "AI Trust"
)

if (length(path_coefficients) > 0) {
    path_data <- data.frame(
        label = sapply(path_coefficients, function(p) predictor_labels[[p$predictor]] %||% p$predictor),
        beta = sapply(path_coefficients, function(p) p$beta_std %||% 0),
        pval = sapply(path_coefficients, function(p) p$p %||% 1),
        hyp = sapply(path_coefficients, function(p) hyp_map[[p$predictor]] %||% ""),
        stringsAsFactors = FALSE
    )
    path_data <- path_data[order(path_data$beta, decreasing = TRUE), ]

    png("plots/structural_paths.png", width = 1000, height = 700, res = 150)
    par(mar = c(5, 12, 3, 6))
    cols <- ifelse(path_data$pval < 0.05, "#2e7d32",
        ifelse(path_data$pval < 0.10, "#f57c00", "#c62828")
    )
    bp <- barplot(rev(path_data$beta),
        horiz = TRUE,
        names.arg = rev(paste0(path_data$hyp, ": ", path_data$label)),
        col = rev(cols), las = 1, cex.names = 0.8,
        xlab = "Standardized beta",
        main = "Structural Path Coefficients -> Behavioral Intention"
    )
    abline(v = 0, lwd = 0.8)
    # Annotate
    for (i in seq_along(path_data$beta)) {
        b <- rev(path_data$beta)[i]
        p <- rev(path_data$pval)[i]
        sig <- ifelse(p < 0.001, "***", ifelse(p < 0.01, "**", ifelse(p < 0.05, "*",
            ifelse(p < 0.10, "+", "")
        )))
        text(b + 0.02 * sign(b), bp[i], sprintf("%.3f%s", b, sig), cex = 0.7, adj = ifelse(b >= 0, 0, 1))
    }
    legend("bottomright",
        legend = c("p<.05", "p<.10", "NS"),
        fill = c("#2e7d32", "#f57c00", "#c62828"), cex = 0.8
    )
    dev.off()
    cat("Saved plots/structural_paths.png\n")
}

# ══════════════════════════════════════════════════════════════════════════════
# Section 9: Cross-tabulation — User Typology x Qualitative Themes
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 80)))
cat("CROSS-TABULATION: USER TYPOLOGY x QUALITATIVE THEMES\n")
cat(strrep("=", 80), "\n")

df_efa <- read.csv("data/AIRS_experiment.csv", stringsAsFactors = FALSE)
df_cfa <- read.csv("data/AIRS_holdout.csv", stringsAsFactors = FALSE)
df_full <- rbind(df_efa, df_cfa)
cat(sprintf("Combined sample N = %d\n", nrow(df_full)))

construct_items <- list(
    PerfExp    = c("PE1", "PE2"), EffortExp = c("EE1", "EE2"),
    SocialInf  = c("SI1", "SI2"), FacilCond = c("FC1", "FC2"),
    HedonicMot = c("HM1", "HM2"), PriceVal  = c("PV1", "PV2"),
    Habit      = c("HB1", "HB2"), AITrust   = c("TR1", "TR2")
)
for (nm in names(construct_items)) {
    cols <- intersect(construct_items[[nm]], names(df_full))
    if (length(cols) > 0) df_full[[nm]] <- rowMeans(df_full[, cols, drop = FALSE], na.rm = TRUE)
}
if (all(c("AX1", "AX2") %in% names(df_full))) {
    df_full$AI_Anxiety <- rowMeans(df_full[, c("AX1", "AX2")], na.rm = TRUE)
}

cluster_vars2 <- c("PerfExp", "EffortExp", "SocialInf", "FacilCond", "HedonicMot", "PriceVal", "Habit", "AITrust")
available_cv2 <- intersect(cluster_vars2, names(df_full))
X2 <- df_full[complete.cases(df_full[, available_cv2]), available_cv2]
X2_scaled <- scale(X2)
set.seed(67)
km2 <- kmeans(X2_scaled, centers = 4, nstart = 10)
df_full$Cluster <- NA
df_full$Cluster[as.integer(rownames(X2))] <- km2$cluster

cp2 <- aggregate(. ~ Cluster, data = df_full[!is.na(df_full$Cluster), c("Cluster", available_cv2)], FUN = mean)
cluster_names2 <- character(4)
for (i in 1:4) {
    avg <- mean(as.numeric(cp2[cp2$Cluster == i, available_cv2]))
    if (avg > 4.0) {
        cluster_names2[i] <- "AI Enthusiasts"
    } else if (avg > 3.0) {
        cluster_names2[i] <- "Cautious Adopters"
    } else if (avg > 2.0) {
        cluster_names2[i] <- "Moderate Users"
    } else {
        cluster_names2[i] <- "Skeptical Users"
    }
}
df_full$UserType <- cluster_names2[df_full$Cluster]

THEME_KW_SYNTH <- list(
    "Positive Experience"  = c("enjoy", "love", "great", "helpful", "useful", "good", "like", "amazing", "excellent", "wonderful", "beneficial"),
    "Concerns/Caution"     = c("concern", "worry", "careful", "caution", "risk", "afraid", "fear", "dangerous"),
    "Accuracy/Reliability" = c("accurate", "accuracy", "reliable", "reliability", "trust", "correct", "wrong", "error", "mistake", "inaccurate"),
    "Learning/Education"   = c("learn", "study", "school", "education", "research", "student", "homework", "class"),
    "Work/Productivity"    = c("work", "job", "task", "productivity", "efficient", "time", "fast", "quick"),
    "Ethics/Privacy"       = c("ethic", "privacy", "data", "security", "moral", "honest", "integrity")
)

detect_themes <- function(text) {
    if (is.na(text) || !is.character(text) || nchar(trimws(text)) < 10) {
        return(character(0))
    }
    tl <- tolower(text)
    found <- character(0)
    for (theme in names(THEME_KW_SYNTH)) {
        if (any(grepl(paste(THEME_KW_SYNTH[[theme]], collapse = "|"), tl))) {
            found <- c(found, theme)
        }
    }
    found
}

df_full$Themes <- lapply(df_full$Open_Feedback, detect_themes)
df_full$HasThemes <- sapply(df_full$Themes, function(t) length(t) > 0)

df_themed <- df_full[!is.na(df_full$UserType) & df_full$HasThemes, ]
cat(sprintf("Themed responses: %d\n", nrow(df_themed)))

unique_types <- sort(unique(na.omit(df_themed$UserType)))
crosstab_results <- list()

for (theme in names(THEME_KW_SYNTH)) {
    df_themed[[paste0("Has_", theme)]] <- sapply(df_themed$Themes, function(t) theme %in% t)
    tbl <- table(df_themed$UserType, df_themed[[paste0("Has_", theme)]])
    if (ncol(tbl) == 2 && nrow(tbl) >= 2) {
        ct <- tryCatch(chisq.test(tbl), error = function(e) NULL)
        if (!is.null(ct)) {
            pcts <- tapply(df_themed[[paste0("Has_", theme)]], df_themed$UserType, mean) * 100
            row <- list(
                Theme = theme, Chi2 = as.numeric(ct$statistic), p_value = ct$p.value,
                Significant = ifelse(ct$p.value < 0.05, "Yes", "No")
            )
            for (ut in unique_types) row[[paste0(ut, "_%")]] <- pcts[ut] %||% 0
            crosstab_results[[length(crosstab_results) + 1]] <- row
            sig <- ifelse(ct$p.value < 0.05, "*", "")
            cat(sprintf("  %s: chi2=%.2f, p=%.3f %s\n", theme, ct$statistic, ct$p.value, sig))
        }
    }
}

if (length(crosstab_results) > 0) {
    df_ct <- do.call(rbind, lapply(crosstab_results, as.data.frame, stringsAsFactors = FALSE))
    write.csv(df_ct, "tables/10_typology_theme_crosstab.csv", row.names = FALSE)
    cat("Saved tables/10_typology_theme_crosstab.csv\n")

    # Heatmap
    pct_cols <- grep("_%$", names(df_ct), value = TRUE)
    if (length(pct_cols) > 0) {
        hm_data <- as.matrix(df_ct[, pct_cols])
        rownames(hm_data) <- df_ct$Theme
        colnames(hm_data) <- sub("_%$", "", pct_cols)

        png("plots/10_typology_theme_crosstab.png", width = 1000, height = 600, res = 150)
        par(mar = c(8, 12, 3, 6))
        image(1:ncol(hm_data), 1:nrow(hm_data), t(hm_data),
            col = colorRampPalette(c("#fff3e0", "#e65100"))(50),
            axes = FALSE, xlab = "", ylab = "",
            main = "Qualitative Theme Prevalence by User Typology"
        )
        axis(1, at = 1:ncol(hm_data), labels = colnames(hm_data), las = 2, cex.axis = 0.7)
        axis(2, at = 1:nrow(hm_data), labels = rownames(hm_data), las = 1, cex.axis = 0.7)
        for (i in 1:nrow(hm_data)) {
            for (j in 1:ncol(hm_data)) {
                text(j, i, sprintf("%.0f%%", hm_data[i, j]), cex = 0.7)
            }
        }
        dev.off()
        cat("Saved plots/10_typology_theme_crosstab.png\n")
    }
}

# Update synthesis with cross-tab
sig_themes <- sum(sapply(crosstab_results, function(r) r$Significant == "Yes"))
synthesis$crosstab_analysis <- list(
    n_themed_responses = nrow(df_themed),
    themes_analyzed = names(THEME_KW_SYNTH),
    significant_associations = sig_themes
)
write_json(synthesis, "data/final_synthesis.json", pretty = TRUE, auto_unbox = TRUE)
cat("Updated data/final_synthesis.json\n")

cat("\nPhase 10 complete.\n")
