#!/usr/bin/env Rscript
# =============================================================================
# AIRS Phase 1: Exploratory Factor Analysis (EFA) — R port
# Mirrors: python/run_01_efa.py
#
# MINRES extraction + Promax rotation on development sample.
# Outputs: tables/efa_summary.json, tables/full_pattern_matrix.csv,
#          tables/item_diagnostics.csv, tables/construct_diagnostics.csv,
#          tables/factor_quality.csv, plots/phase1_*.png, plots/phase2_*.png
# =============================================================================

library(psych)
library(GPArotation)
library(jsonlite)
library(ggplot2)

set.seed(67)

cat(paste(rep("=", 90), collapse = ""), "\n")
cat("PHASE 1: EXPLORATORY FACTOR ANALYSIS (EFA)\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

dir.create("plots", showWarnings = FALSE)
dir.create("tables", showWarnings = FALSE)

# =============================================================================
# LOAD DATA
# =============================================================================

df_full <- read.csv("data/AIRS_experiment.csv", stringsAsFactors = FALSE)
exp_config <- fromJSON("data/experiment_config.json")
item_metadata <- fromJSON("data/airs_28item_complete.json")

ALL_PREDICTOR_ITEMS <- item_metadata$predictor_items
outcome_items <- item_metadata$outcome_items
metadata <- item_metadata$metadata

# Build construct groups from predictor items
ALL_PREDICTOR_CONSTRUCTS <- list()
for (item in ALL_PREDICTOR_ITEMS) {
    construct <- substr(item, 1, 2)
    ALL_PREDICTOR_CONSTRUCTS[[construct]] <- c(ALL_PREDICTOR_CONSTRUCTS[[construct]], item)
}

cat(sprintf("\nEFA Sample: N = %d\n", nrow(df_full)))
cat(sprintf("Predictor items: %d\n", length(ALL_PREDICTOR_ITEMS)))
cat(sprintf("Constructs: %d\n", length(ALL_PREDICTOR_CONSTRUCTS)))

df_all_items <- df_full[, ALL_PREDICTOR_ITEMS]

# =============================================================================
# DESCRIPTIVE STATISTICS
# =============================================================================

desc_stats <- data.frame(
    item = ALL_PREDICTOR_ITEMS,
    construct = sapply(ALL_PREDICTOR_ITEMS, function(x) metadata[[x]]$construct_abbr),
    mean = sapply(df_all_items, mean, na.rm = TRUE),
    sd = sapply(df_all_items, sd, na.rm = TRUE),
    min = sapply(df_all_items, min, na.rm = TRUE),
    max = sapply(df_all_items, max, na.rm = TRUE),
    skew = sapply(df_all_items, function(x) psych::skew(x)),
    kurtosis = sapply(df_all_items, function(x) psych::kurtosi(x)),
    stringsAsFactors = FALSE, row.names = NULL
)

cat("\nDESCRIPTIVE STATISTICS (24 predictors)\n")
cat(paste(rep("-", 80), collapse = ""), "\n")
num_cols <- sapply(desc_stats, is.numeric)
print(cbind(desc_stats[, !num_cols, drop = FALSE], round(desc_stats[, num_cols, drop = FALSE], 3)))

skew_issues <- desc_stats[abs(desc_stats$skew) > 1.0, ]
kurt_issues <- desc_stats[abs(desc_stats$kurtosis) > 3.0, ]
if (nrow(skew_issues) > 0) cat(sprintf("\nItems with |skewness| > 1.0: %s\n", paste(skew_issues$item, collapse = ", ")))
if (nrow(kurt_issues) > 0) cat(sprintf("Items with |kurtosis| > 3.0: %s\n", paste(kurt_issues$item, collapse = ", ")))

# =============================================================================
# WITHIN-CONSTRUCT RELIABILITY
# =============================================================================

cat("\n", paste(rep("=", 90), collapse = ""), "\n")
cat("WITHIN-CONSTRUCT RELIABILITY\n")
cat(paste(rep("=", 90), collapse = ""), "\n")

construct_diagnostics <- data.frame(
    Construct = character(), Name = character(), Items = character(),
    r_inter = numeric(), Alpha = numeric(),
    ITC_1 = numeric(), ITC_2 = numeric(), Status = character(),
    stringsAsFactors = FALSE
)

for (construct in names(ALL_PREDICTOR_CONSTRUCTS)) {
    items <- ALL_PREDICTOR_CONSTRUCTS[[construct]]
    construct_name <- metadata[[items[1]]]$construct
    construct_df <- df_all_items[, items]

    r_val <- cor(construct_df)[1, 2]
    alpha_result <- psych::alpha(construct_df, check.keys = FALSE)
    alpha_val <- alpha_result$total$raw_alpha

    # Corrected item-total correlations
    total <- rowSums(construct_df)
    itc <- sapply(items, function(item) {
        corrected <- total - construct_df[[item]]
        cor(construct_df[[item]], corrected)
    })

    status <- if (alpha_val >= 0.70) "Good" else if (alpha_val >= 0.60) "Marginal" else "Poor"

    construct_diagnostics <- rbind(construct_diagnostics, data.frame(
        Construct = construct, Name = construct_name,
        Items = paste(items, collapse = ", "),
        r_inter = r_val, Alpha = alpha_val,
        ITC_1 = itc[1], ITC_2 = itc[2], Status = status,
        stringsAsFactors = FALSE
    ))

    cat(sprintf("\n%s (%s):\n", construct, construct_name))
    cat(sprintf("  Inter-item r = %.3f, Alpha = %.3f [%s]\n", r_val, alpha_val, status))
}

good <- sum(construct_diagnostics$Alpha >= 0.70)
marginal <- sum(construct_diagnostics$Alpha >= 0.60 & construct_diagnostics$Alpha < 0.70)
poor <- sum(construct_diagnostics$Alpha < 0.60)
cat(sprintf("\nGood (alpha >= .70): %d/12, Marginal: %d/12, Poor: %d/12\n", good, marginal, poor))

# =============================================================================
# WITHIN-CONSTRUCT HEATMAP (combined)
# =============================================================================

png("plots/phase1_within_construct_correlations.png", width = 1600, height = 1200, res = 150)
par(mfrow = c(3, 4), mar = c(3, 3, 3, 1))
for (i in seq_along(names(ALL_PREDICTOR_CONSTRUCTS))) {
    construct <- names(ALL_PREDICTOR_CONSTRUCTS)[i]
    items <- ALL_PREDICTOR_CONSTRUCTS[[construct]]
    corr_mat <- cor(df_all_items[, items])
    alpha_val <- construct_diagnostics$Alpha[construct_diagnostics$Construct == construct]
    status <- construct_diagnostics$Status[construct_diagnostics$Construct == construct]
    col_title <- ifelse(status == "Good", "darkgreen",
        ifelse(status == "Marginal", "goldenrod", "darkred")
    )

    image(1:2, 1:2, corr_mat,
        col = colorRampPalette(c("white", "green"))(20),
        xlab = "", ylab = "", axes = FALSE,
        main = sprintf("%s (a=%.2f)", construct, alpha_val)
    )
    title(main = sprintf("%s (a=%.2f)", construct, alpha_val), col.main = col_title)
    axis(1, at = 1:2, labels = items, las = 1, cex.axis = 0.8)
    axis(2, at = 1:2, labels = items, las = 2, cex.axis = 0.8)
    for (r in 1:2) {
        for (c2 in 1:2) {
            text(r, c2, sprintf("%.2f", corr_mat[r, c2]), cex = 1.0)
        }
    }
}
dev.off()
cat("\nSaved: plots/phase1_within_construct_correlations.png\n")

# =============================================================================
# ITEM DIAGNOSTICS
# =============================================================================

item_diagnostics <- data.frame(
    Item = character(), Construct = character(), Direction = character(),
    Mean = numeric(), SD = numeric(), Skew = numeric(), Kurt = numeric(),
    ITC = numeric(), Issues = character(), stringsAsFactors = FALSE
)

for (item in ALL_PREDICTOR_ITEMS) {
    construct <- metadata[[item]]$construct_abbr
    direction <- metadata[[item]]$direction
    items_in_construct <- ALL_PREDICTOR_CONSTRUCTS[[construct]]

    total <- rowSums(df_all_items[, items_in_construct])
    corrected <- total - df_all_items[[item]]
    itc_val <- cor(df_all_items[[item]], corrected)

    mean_val <- mean(df_all_items[[item]], na.rm = TRUE)
    sd_val <- sd(df_all_items[[item]], na.rm = TRUE)
    skew_val <- psych::skew(df_all_items[[item]])
    kurt_val <- psych::kurtosi(df_all_items[[item]])

    issues <- c()
    if (abs(skew_val) > 1.0) issues <- c(issues, "SKEW")
    if (abs(kurt_val) > 3.0) issues <- c(issues, "KURT")
    if (itc_val < 0.30) issues <- c(issues, "LOW_ITC")
    issues_str <- if (length(issues) > 0) paste(issues, collapse = ", ") else "OK"

    item_diagnostics <- rbind(item_diagnostics, data.frame(
        Item = item, Construct = construct, Direction = direction,
        Mean = mean_val, SD = sd_val, Skew = skew_val, Kurt = kurt_val,
        ITC = itc_val, Issues = issues_str, stringsAsFactors = FALSE
    ))
}

problem_items <- item_diagnostics[item_diagnostics$Issues != "OK", ]
if (nrow(problem_items) > 0) {
    cat(sprintf("\nItems with issues (%d):\n", nrow(problem_items)))
    for (i in seq_len(nrow(problem_items))) {
        cat(sprintf(
            "  %s (%s): %s\n",
            problem_items$Item[i], problem_items$Construct[i], problem_items$Issues[i]
        ))
    }
}

# =============================================================================
# KMO & BARTLETT'S TEST
# =============================================================================

kmo_result <- KMO(df_all_items)
kmo_model <- kmo_result$MSA

bartlett_result <- cortest.bartlett(cor(df_all_items), n = nrow(df_all_items))
chi_square <- bartlett_result$chisq
p_value <- bartlett_result$p.value

kmo_interpretation <- if (kmo_model >= 0.90) "Marvelous" else if (kmo_model >= 0.80) "Meritorious" else if (kmo_model >= 0.70) "Middling" else if (kmo_model >= 0.60) "Mediocre" else if (kmo_model >= 0.50) "Miserable" else "Unacceptable"

cat(sprintf("\n%s\n", paste(rep("=", 90), collapse = "")))
cat("FACTORABILITY\n")
cat(sprintf("%s\n", paste(rep("=", 90), collapse = "")))
cat(sprintf("KMO = %.3f (%s)\n", kmo_model, kmo_interpretation))
cat(sprintf("Bartlett's chi2 = %.2f, p = %.2e\n", chi_square, p_value))

# =============================================================================
# COMMUNALITIES (6-factor solution)
# =============================================================================

fa_comm <- fa(df_all_items, nfactors = 6, rotate = "promax", fm = "minres")
communalities <- fa_comm$communality

comm_df <- data.frame(
    Item = names(communalities),
    Communality = as.numeric(communalities),
    Construct = sapply(names(communalities), function(x) metadata[[x]]$construct_abbr),
    stringsAsFactors = FALSE
)
comm_df <- comm_df[order(comm_df$Item, decreasing = TRUE), ]

png("plots/phase1_communalities.png", width = 1000, height = 1000, res = 150)
par(mar = c(5, 10, 3, 2))
cols <- ifelse(comm_df$Communality < 0.30, "darkred",
    ifelse(comm_df$Communality < 0.40, "goldenrod", "darkgreen")
)
barplot(comm_df$Communality,
    names.arg = paste0(comm_df$Item, " (", comm_df$Construct, ")"),
    horiz = TRUE, las = 1, col = cols, border = "black",
    main = "Item Communalities (6-Factor Solution)", xlab = "Communality",
    xlim = c(0, 1), cex.names = 0.7
)
abline(v = 0.40, col = "green", lty = 2, lwd = 2)
abline(v = 0.30, col = "red", lty = 2, lwd = 2)
legend("bottomright",
    legend = c("Good (>=0.40)", "Minimum (>=0.30)"),
    col = c("green", "red"), lty = 2, lwd = 2
)
dev.off()
cat("Saved: plots/phase1_communalities.png\n")

# =============================================================================
# PARALLEL ANALYSIS & EIGENVALUES
# =============================================================================

predictor_items <- ALL_PREDICTOR_ITEMS
df_efa <- df_full[, predictor_items]

pa_result <- fa.parallel(df_efa, fm = "minres", fa = "fa", n.iter = 100, plot = FALSE)
n_factors_kaiser <- sum(pa_result$fa.values > 1)
n_factors_pa <- pa_result$nfact

cat(sprintf("\n%s\n", paste(rep("=", 90), collapse = "")))
cat("FACTOR EXTRACTION CRITERIA\n")
cat(sprintf("%s\n", paste(rep("=", 90), collapse = "")))
cat(sprintf("Kaiser criterion (lambda > 1): %d factors\n", n_factors_kaiser))
cat(sprintf("Parallel analysis: %d factors\n", n_factors_pa))

# Scree plot
ev <- pa_result$fa.values
random_ev <- pa_result$fa.sim

png("plots/phase2_scree_plot.png", width = 1200, height = 600, res = 150)
plot(seq_along(ev), ev,
    type = "b", pch = 16, col = "blue", lwd = 2,
    xlab = "Factor Number", ylab = "Eigenvalue",
    main = "Scree Plot with Parallel Analysis",
    ylim = c(min(c(ev, random_ev)), max(ev) * 1.1)
)
lines(seq_along(random_ev), random_ev, type = "b", pch = 17, col = "red", lty = 2, lwd = 2)
abline(h = 1, col = "gray", lty = 3)
legend("topright",
    legend = c("Actual Eigenvalues", "Parallel Analysis (95th pctile)", "Kaiser Criterion"),
    col = c("blue", "red", "gray"), lty = c(1, 2, 3), pch = c(16, 17, NA), lwd = 2
)
dev.off()
cat("Saved: plots/phase2_scree_plot.png\n")

# =============================================================================
# FULL 12-FACTOR EFA (MINRES + Promax)
# =============================================================================

n_factors_max <- min(12, length(predictor_items))
efa_full <- fa(df_efa, nfactors = n_factors_max, rotate = "promax", fm = "minres")

eigenvalues_full <- efa_full$values[1:n_factors_max]
prop_var_full <- efa_full$Vaccounted["Proportion Var", ]
cum_var_full <- efa_full$Vaccounted["Cumulative Var", ]

cat(sprintf("\n%s\n", paste(rep("=", 90), collapse = "")))
cat(sprintf("FULL %d-FACTOR SOLUTION (MINRES + Promax)\n", n_factors_max))
cat(sprintf("%s\n", paste(rep("=", 90), collapse = "")))
cat(sprintf("%-8s %-12s %-10s %-10s\n", "Factor", "SS Loading", "% Var", "Cum %"))
cat(paste(rep("-", 40), collapse = ""), "\n")
for (i in seq_len(n_factors_max)) {
    cat(sprintf(
        "F%-7d %-12.3f %-10.1f %-10.1f\n",
        i, eigenvalues_full[i], prop_var_full[i] * 100, cum_var_full[i] * 100
    ))
}
cat(sprintf("\nTotal variance explained: %.1f%%\n", cum_var_full[n_factors_max] * 100))

# =============================================================================
# PATTERN MATRIX
# =============================================================================

loadings_matrix <- as.data.frame(unclass(efa_full$loadings))
factor_cols <- colnames(loadings_matrix)
# Rename to F1..F12
colnames(loadings_matrix) <- paste0("F", seq_len(ncol(loadings_matrix)))
factor_cols <- colnames(loadings_matrix)
loadings_matrix$Construct <- sapply(rownames(loadings_matrix), function(x) metadata[[x]]$construct_abbr)

cat("\nPATTERN MATRIX (loadings >= 0.32 shown)\n")
cat(paste(rep("-", 90), collapse = ""), "\n")
for (item in predictor_items) {
    row <- loadings_matrix[item, factor_cols]
    sig <- row[abs(row) >= 0.32]
    if (length(sig) > 0) {
        loads <- paste(sapply(names(sig), function(f) sprintf("%s=%+.3f", f, sig[[f]])), collapse = ", ")
    } else {
        loads <- "(no loading >= .32)"
    }
    cat(sprintf("  %-4s (%2s): %s\n", item, metadata[[item]]$construct_abbr, loads))
}

# =============================================================================
# FACTOR QUALITY
# =============================================================================

factor_quality <- data.frame(
    Factor = character(), Eigenvalue = numeric(), Strong_Items = integer(),
    Cross_Loadings = integer(), Constructs = character(), Quality = character(),
    stringsAsFactors = FALSE
)

for (i in seq_len(n_factors_max)) {
    fname <- paste0("F", i)
    abs_loadings <- abs(loadings_matrix[[fname]])
    names(abs_loadings) <- rownames(loadings_matrix)
    strong_items <- names(abs_loadings[abs_loadings >= 0.50])

    cross_count <- 0
    for (item in strong_items) {
        other_factors <- setdiff(factor_cols, fname)
        other_max <- max(abs(loadings_matrix[item, other_factors]))
        if (other_max >= 0.32) cross_count <- cross_count + 1
    }

    constructs <- unique(sapply(strong_items, function(x) metadata[[x]]$construct_abbr))
    quality <- if (length(strong_items) >= 2 && cross_count == 0) {
        "RETAIN (clean)"
    } else if (length(strong_items) >= 2) {
        "RETAIN (cross-loading)"
    } else if (length(strong_items) == 1) {
        "CONSIDER"
    } else {
        "SKIP"
    }

    factor_quality <- rbind(factor_quality, data.frame(
        Factor = fname, Eigenvalue = eigenvalues_full[i],
        Strong_Items = length(strong_items), Cross_Loadings = cross_count,
        Constructs = paste(constructs, collapse = ", "), Quality = quality,
        stringsAsFactors = FALSE
    ))
}

cat(sprintf("\n%s\n", paste(rep("=", 90), collapse = "")))
cat("FACTOR QUALITY SUMMARY\n")
cat(sprintf("%s\n", paste(rep("=", 90), collapse = "")))
for (i in seq_len(nrow(factor_quality))) {
    cat(sprintf(
        "  %s: lambda=%.2f, strong=%d, cross=%d -> %s\n",
        factor_quality$Factor[i], factor_quality$Eigenvalue[i],
        factor_quality$Strong_Items[i], factor_quality$Cross_Loadings[i],
        factor_quality$Quality[i]
    ))
}

# =============================================================================
# CROSS-LOADING ANALYSIS
# =============================================================================

cross_loading_threshold <- 0.32
cross_loaders <- list()

for (item in predictor_items) {
    item_loadings <- abs(loadings_matrix[item, factor_cols])
    significant <- item_loadings[item_loadings >= cross_loading_threshold]
    if (length(significant) > 1) {
        primary <- names(which.max(abs(loadings_matrix[item, factor_cols])))
        secondary_factors <- setdiff(names(significant), primary)
        cross_loaders[[length(cross_loaders) + 1]] <- data.frame(
            Item = item,
            Construct = metadata[[item]]$construct_abbr,
            Primary = primary,
            Primary_Loading = as.numeric(loadings_matrix[item, primary]),
            Cross_Factors = paste(sapply(secondary_factors, function(f) {
                sprintf("%s(%+.2f)", f, loadings_matrix[item, f])
            }), collapse = ", "),
            stringsAsFactors = FALSE
        )
    }
}
cross_df <- if (length(cross_loaders) > 0) do.call(rbind, cross_loaders) else data.frame()

# Cross-loading bar chart
items_sorted <- predictor_items[order(
    sapply(predictor_items, function(x) metadata[[x]]$construct_abbr),
    predictor_items
)]
primary_loads <- sapply(items_sorted, function(item) max(abs(loadings_matrix[item, factor_cols])))
secondary_loads <- sapply(items_sorted, function(item) {
    vals <- sort(abs(as.numeric(loadings_matrix[item, factor_cols])), decreasing = TRUE)
    vals[2]
})

png("plots/phase2_cross_loadings.png", width = 1400, height = 600, res = 150)
par(mar = c(8, 5, 3, 2))
cross_items_set <- if (nrow(cross_df) > 0) cross_df$Item else character(0)
cols <- ifelse(items_sorted %in% cross_items_set, "#f39c12", "#2ecc71")
bp <- barplot(primary_loads,
    col = cols, border = "black", ylim = c(0, 1),
    names.arg = paste0(items_sorted, "\n(", sapply(items_sorted, function(x) metadata[[x]]$construct_abbr), ")"),
    las = 2, cex.names = 0.6, main = "Cross-Loading Analysis",
    ylab = "Absolute Loading"
)
barplot(secondary_loads, col = "lightgray", border = "black", add = TRUE, axes = FALSE)
abline(h = cross_loading_threshold, col = "red", lty = 2, lwd = 2)
legend("topright",
    legend = c("Primary", "Secondary", "Threshold (0.32)"),
    fill = c("#2ecc71", "lightgray", NA), border = c("black", "black", NA),
    lty = c(NA, NA, 2), col = c(NA, NA, "red"), lwd = c(NA, NA, 2)
)
dev.off()
cat(sprintf("\nSaved: plots/phase2_cross_loadings.png\n"))
cat(sprintf("Clean items: %d/%d\n", length(predictor_items) - nrow(cross_df), length(predictor_items)))
cat(sprintf("Cross-loaders: %d/%d\n", nrow(cross_df), length(predictor_items)))

# =============================================================================
# EXPORT
# =============================================================================

cat(sprintf("\n%s\n", paste(rep("=", 90), collapse = "")))
cat("EXPORTING EFA RESULTS\n")
cat(sprintf("%s\n", paste(rep("=", 90), collapse = "")))

write.csv(loadings_matrix, "tables/full_pattern_matrix.csv")
cat("  tables/full_pattern_matrix.csv\n")

write.csv(item_diagnostics, "tables/item_diagnostics.csv", row.names = FALSE)
cat("  tables/item_diagnostics.csv\n")

write.csv(construct_diagnostics, "tables/construct_diagnostics.csv", row.names = FALSE)
cat("  tables/construct_diagnostics.csv\n")

write.csv(factor_quality, "tables/factor_quality.csv", row.names = FALSE)
cat("  tables/factor_quality.csv\n")

# Validated factor structure (alpha >= .70 only)
good_constructs <- construct_diagnostics$Construct[construct_diagnostics$Alpha >= 0.70]
validated_factor_structure <- ALL_PREDICTOR_CONSTRUCTS[good_constructs]

efa_summary <- list(
    population = ifelse(!is.null(exp_config$population), exp_config$population, "ALL"),
    n_observations = nrow(df_full),
    n_items = length(predictor_items),
    n_constructs = length(ALL_PREDICTOR_CONSTRUCTS),
    kmo = kmo_model,
    kmo_interpretation = kmo_interpretation,
    bartlett_chi2 = chi_square,
    bartlett_p = p_value,
    n_factors_kaiser = n_factors_kaiser,
    n_factors_parallel = n_factors_pa,
    variance_explained_12factors = cum_var_full[n_factors_max],
    constructs_good_reliability = good_constructs,
    constructs_marginal_reliability = construct_diagnostics$Construct[
        construct_diagnostics$Alpha >= 0.60 & construct_diagnostics$Alpha < 0.70
    ],
    constructs_poor_reliability = construct_diagnostics$Construct[
        construct_diagnostics$Alpha < 0.60
    ],
    validated_factor_structure = validated_factor_structure,
    all_factor_structure = ALL_PREDICTOR_CONSTRUCTS,
    reliability_coefficients = setNames(
        round(construct_diagnostics$Alpha, 3),
        construct_diagnostics$Construct
    )
)
write_json(efa_summary, "tables/efa_summary.json", pretty = TRUE, auto_unbox = TRUE)
cat("  tables/efa_summary.json\n")

cat(sprintf("\nValidated structure (%d factors):\n", length(validated_factor_structure)))
for (factor in names(validated_factor_structure)) {
    alpha_val <- construct_diagnostics$Alpha[construct_diagnostics$Construct == factor]
    cat(sprintf(
        "  %s: %s (alpha = %.2f)\n", factor,
        paste(validated_factor_structure[[factor]], collapse = ", "), alpha_val
    ))
}

# =============================================================================
# SUMMARY
# =============================================================================

cat(sprintf("\n%s\n", paste(rep("=", 90), collapse = "")))
cat("EFA SUMMARY\n")
cat(sprintf("%s\n", paste(rep("=", 90), collapse = "")))
cat(sprintf(
    "  N = %d, Items = %d, Constructs = %d\n",
    nrow(df_full), length(predictor_items), length(ALL_PREDICTOR_CONSTRUCTS)
))
cat(sprintf("  KMO = %.3f (%s)\n", kmo_model, kmo_interpretation))
cat(sprintf("  Bartlett chi2 = %.2f, p = %.2e\n", chi_square, p_value))
cat(sprintf("  Kaiser: %d factors, Parallel Analysis: %d factors\n", n_factors_kaiser, n_factors_pa))
cat(sprintf("  Variance explained (12 factors): %.1f%%\n", cum_var_full[n_factors_max] * 100))
cat(sprintf("  Good alpha: %d/12, Marginal: %d/12, Poor: %d/12\n", good, marginal, poor))
cat(sprintf(
    "  Poor constructs: %s\n",
    paste(construct_diagnostics$Construct[construct_diagnostics$Alpha < 0.60], collapse = ", ")
))

cat(sprintf("\n%s\n", paste(rep("=", 90), collapse = "")))
cat("PHASE 1 COMPLETE\n")
cat(sprintf("%s\n", paste(rep("=", 90), collapse = "")))
