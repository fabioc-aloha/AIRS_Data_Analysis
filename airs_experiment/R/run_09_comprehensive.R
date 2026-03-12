#!/usr/bin/env Rscript
# ==============================================================================
# AIRS Phase 9: Comprehensive Review — Gap Analysis
# R port of run_09_comprehensive.py
#
# Gap 1 — Education level (ANOVA)
# Gap 2 — Industry sector (ANOVA)
# Gap 3 — Professional experience (Spearman)
# Gap 4 — Disability accommodations (t-tests)
# Gap 5 — Tool preferences (ChatGPT vs Copilot)
# Gap 6 — User typology (K-means k=4)
# Outputs: results/phase9_comprehensive_review_results.json, 6 plots
# ==============================================================================

library(jsonlite)

cat(strrep("=", 90), "\n")
cat("PHASE 9: COMPREHENSIVE REVIEW — GAP ANALYSIS\n")
cat(strrep("=", 90), "\n")

dir.create("results", showWarnings = FALSE)
dir.create("plots", showWarnings = FALSE)

# ── Configuration ─────────────────────────────────────────────────────────────
USAGE_COLS <- c("Usage_MSCopilot", "Usage_ChatGPT", "Usage_Gemini", "Usage_Other")

CONSTRUCT_DEFS <- list(
    PE = c("PE1", "PE2"), EE = c("EE1", "EE2"), SI = c("SI1", "SI2"),
    FC = c("FC1", "FC2"), HM = c("HM1", "HM2"), PV = c("PV1", "PV2"),
    HB = c("HB1", "HB2"), VO = c("VO1", "VO2"), TR = c("TR1", "TR2"),
    EX = c("EX1", "EX2"), ER = c("ER1", "ER2"), AX = c("AX1", "AX2")
)
BI_ITEMS <- c("BI1", "BI2", "BI3", "BI4")

# ── Load Data ─────────────────────────────────────────────────────────────────
df <- read.csv("data/AIRS_clean.csv", stringsAsFactors = FALSE)
cat(sprintf("Loaded AIRS_clean.csv: N=%d\n", nrow(df)))

# Compute construct scores
for (name in names(CONSTRUCT_DEFS)) {
    cols <- intersect(CONSTRUCT_DEFS[[name]], names(df))
    if (length(cols) > 0) df[[name]] <- rowMeans(df[, cols, drop = FALSE], na.rm = TRUE)
}
bi_cols <- intersect(BI_ITEMS, names(df))
df$BI <- rowMeans(df[, bi_cols, drop = FALSE], na.rm = TRUE)
uc <- intersect(USAGE_COLS, names(df))
if (length(uc) > 0) df$Total_Usage <- rowMeans(df[, uc, drop = FALSE], na.rm = TRUE)
cat("Computed 12 construct scores + BI + Total_Usage\n")

gap_results <- list()

# ══════════════════════════════════════════════════════════════════════════════
# Gap 1 — Education Level
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("GAP 1: EDUCATION LEVEL\n")
cat(strrep("=", 70), "\n")

if ("Education" %in% names(df)) {
    edu_groups <- split(df$BI, df$Education)
    edu_groups <- edu_groups[sapply(edu_groups, function(g) sum(!is.na(g)) >= 5)]

    if (length(edu_groups) >= 2) {
        aov_fit <- oneway.test(BI ~ Education, data = df[df$Education %in% names(edu_groups), ])
        grand_mean <- mean(df$BI, na.rm = TRUE)
        ss_between <- sum(sapply(edu_groups, function(g) {
            g <- na.omit(g)
            length(g) * (mean(g) - grand_mean)^2
        }))
        ss_total <- sum((df$BI - grand_mean)^2, na.rm = TRUE)
        eta_sq <- ss_between / ss_total

        gap_results$gap1_education <- list(
            title = "Education Level x BI", method = "One-way ANOVA",
            F = aov_fit$statistic, p = aov_fit$p.value, eta_sq = eta_sq,
            n_groups = length(edu_groups),
            group_ns = lapply(edu_groups, function(g) length(na.omit(g))),
            finding = sprintf("F=%.3f, p=%.4f, eta2=%.4f", aov_fit$statistic, aov_fit$p.value, eta_sq)
        )
        cat(sprintf("  F=%.3f, p=%.4f, eta2=%.4f\n", aov_fit$statistic, aov_fit$p.value, eta_sq))
        for (nm in names(edu_groups)) {
            g <- na.omit(edu_groups[[nm]])
            cat(sprintf("    %s: n=%d, M=%.3f\n", nm, length(g), mean(g)))
        }
    }

    png("plots/09_education_comparison.png", width = 1000, height = 600, res = 150)
    edu_agg <- aggregate(BI ~ Education, data = df, FUN = function(x) c(m = mean(x), s = sd(x), n = length(x)))
    edu_df <- data.frame(
        Education = edu_agg$Education, mean = edu_agg$BI[, "m"],
        sd = edu_agg$BI[, "s"], n = edu_agg$BI[, "n"]
    )
    edu_df <- edu_df[edu_df$n >= 5, ]
    bp <- barplot(edu_df$mean,
        names.arg = edu_df$Education, col = "steelblue",
        ylim = c(0, max(edu_df$mean + edu_df$sd, na.rm = TRUE) * 1.2),
        ylab = "Mean BI", main = "Behavioral Intention by Education Level",
        las = 2, cex.names = 0.7
    )
    arrows(bp, edu_df$mean - edu_df$sd, bp, edu_df$mean + edu_df$sd,
        angle = 90, code = 3, length = 0.05
    )
    dev.off()
    cat("  Saved plots/09_education_comparison.png\n")
}

# ══════════════════════════════════════════════════════════════════════════════
# Gap 2 — Industry Sector
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("GAP 2: INDUSTRY SECTOR\n")
cat(strrep("=", 70), "\n")

if ("Industry" %in% names(df)) {
    ind_groups <- split(df$BI, df$Industry)
    ind_groups <- ind_groups[sapply(ind_groups, function(g) sum(!is.na(g)) >= 5)]

    if (length(ind_groups) >= 2) {
        aov_fit <- oneway.test(BI ~ Industry, data = df[df$Industry %in% names(ind_groups), ])
        grand_mean <- mean(df$BI, na.rm = TRUE)
        ss_between <- sum(sapply(ind_groups, function(g) {
            g <- na.omit(g)
            length(g) * (mean(g) - grand_mean)^2
        }))
        ss_total <- sum((df$BI - grand_mean)^2, na.rm = TRUE)
        eta_sq <- ss_between / ss_total

        ind_means <- sapply(ind_groups, function(g) mean(na.omit(g)))
        sorted_ind <- sort(ind_means, decreasing = TRUE)
        top_ind <- names(sorted_ind)[1]
        low_ind <- names(sorted_ind)[length(sorted_ind)]

        gap_results$gap2_industry <- list(
            title = "Industry Sector x BI", method = "One-way ANOVA",
            F = aov_fit$statistic, p = aov_fit$p.value, eta_sq = eta_sq,
            n_groups = length(ind_groups),
            top_industry = top_ind, lowest_industry = low_ind,
            finding = sprintf("F=%.3f, p=%.4f, eta2=%.4f", aov_fit$statistic, aov_fit$p.value, eta_sq)
        )
        cat(sprintf("  F=%.3f, p=%.4f, eta2=%.4f\n", aov_fit$statistic, aov_fit$p.value, eta_sq))
        cat(sprintf("  Top: %s, Lowest: %s\n", top_ind, low_ind))
    }

    png("plots/09_industry_comparison.png", width = 1200, height = 600, res = 150)
    ind_agg <- aggregate(BI ~ Industry, data = df, FUN = function(x) c(m = mean(x), s = sd(x), n = length(x)))
    ind_df <- data.frame(
        Industry = ind_agg$Industry, mean = ind_agg$BI[, "m"],
        sd = ind_agg$BI[, "s"], n = ind_agg$BI[, "n"]
    )
    ind_df <- ind_df[ind_df$n >= 5, ]
    ind_df <- ind_df[order(ind_df$mean), ]
    par(mar = c(5, 12, 3, 2))
    barplot(ind_df$mean,
        names.arg = ind_df$Industry, horiz = TRUE, col = "steelblue",
        las = 1, cex.names = 0.7, xlab = "Mean BI",
        main = "Behavioral Intention by Industry Sector"
    )
    dev.off()
    cat("  Saved plots/09_industry_comparison.png\n")
}

# ══════════════════════════════════════════════════════════════════════════════
# Gap 3 — Professional Experience
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("GAP 3: PROFESSIONAL EXPERIENCE\n")
cat(strrep("=", 70), "\n")

if ("Experience" %in% names(df)) {
    exp_order <- c("Less than 1 year", "1-3 years", "3-5 years", "5-10 years", "10+ years")
    exp_numeric <- setNames(1:5, exp_order)
    df$Experience_Numeric <- exp_numeric[df$Experience]

    valid <- df[complete.cases(df[, c("Experience_Numeric", "BI")]), ]
    if (nrow(valid) > 10) {
        ct <- cor.test(valid$Experience_Numeric, valid$BI, method = "spearman")
        exp_means <- tapply(df$BI, df$Experience, mean, na.rm = TRUE)
        peak <- names(which.max(exp_means))

        gap_results$gap3_experience <- list(
            title = "Professional Experience x BI", method = "Spearman correlation",
            rho = ct$estimate, p = ct$p.value, peak_experience = peak,
            finding = sprintf("rho=%.3f, p=%.4f", ct$estimate, ct$p.value)
        )
        cat(sprintf("  Spearman rho=%.3f, p=%.4f\n", ct$estimate, ct$p.value))
        cat(sprintf("  Peak experience: %s\n", peak))
    }

    png("plots/09_experience_effect.png", width = 1000, height = 600, res = 150)
    present <- exp_order[exp_order %in% df$Experience]
    means <- sapply(present, function(e) mean(df$BI[df$Experience == e], na.rm = TRUE))
    plot(seq_along(present), means,
        type = "b", pch = 16, col = "steelblue",
        xaxt = "n", xlab = "", ylab = "Mean BI",
        main = "Behavioral Intention by Professional Experience"
    )
    axis(1, at = seq_along(present), labels = present, las = 2, cex.axis = 0.7)
    grid()
    dev.off()
    cat("  Saved plots/09_experience_effect.png\n")
}

# ══════════════════════════════════════════════════════════════════════════════
# Gap 4 — Disability Accommodations
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("GAP 4: DISABILITY ACCOMMODATIONS\n")
cat(strrep("=", 70), "\n")

if ("Disability" %in% names(df)) {
    df_yes <- df[df$Disability == "Yes", ]
    df_no <- df[df$Disability == "No", ]
    cat(sprintf("  Yes: n=%d, No: n=%d\n", nrow(df_yes), nrow(df_no)))

    test_constructs <- c("BI", "Total_Usage", "PE", "EE", "AX", "TR", "EX")
    disability_results <- list()
    for (cname in test_constructs) {
        if (cname %in% names(df)) {
            y <- na.omit(df_yes[[cname]])
            n <- na.omit(df_no[[cname]])
            if (length(y) > 1 && length(n) > 1) {
                tt <- t.test(y, n)
                d <- (mean(y) - mean(n)) / sd(n)
                disability_results[[cname]] <- list(
                    t = tt$statistic, p = tt$p.value, d = d,
                    yes_mean = mean(y), no_mean = mean(n)
                )
                sig <- ifelse(tt$p.value < 0.05, "*", "")
                cat(sprintf("  %s: t=%.3f, p=%.4f, d=%.3f %s\n", cname, tt$statistic, tt$p.value, d, sig))
            }
        }
    }

    finding <- "No significant differences"
    if ("AX" %in% names(disability_results) && disability_results$AX$p < 0.05) {
        finding <- "AX higher in disability group"
    }

    gap_results$gap4_disability <- list(
        title = "Disability x Constructs", method = "Independent-samples t-test",
        yes_n = nrow(df_yes), no_n = nrow(df_no),
        results = disability_results, finding = finding
    )

    png("plots/09_disability_comparison.png", width = 1000, height = 600, res = 150)
    plot_c <- names(disability_results)
    y_means <- sapply(plot_c, function(c) disability_results[[c]]$yes_mean)
    n_means <- sapply(plot_c, function(c) disability_results[[c]]$no_mean)
    x <- seq_along(plot_c)
    plot(x, y_means,
        type = "n", ylim = range(c(y_means, n_means)) * c(0.9, 1.1),
        xaxt = "n", xlab = "", ylab = "Mean Score",
        main = "Construct Means by Disability Status"
    )
    bw <- 0.15
    rect(x - bw * 2, 0, x - bw * 0, y_means, col = "#42a5f5")
    rect(x + bw * 0, 0, x + bw * 2, n_means, col = "#66bb6a")
    axis(1, at = x, labels = plot_c)
    legend("topright", legend = c("Yes", "No"), fill = c("#42a5f5", "#66bb6a"))
    dev.off()
    cat("  Saved plots/09_disability_comparison.png\n")
}

# ══════════════════════════════════════════════════════════════════════════════
# Gap 5 — Tool Preferences
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("GAP 5: TOOL PREFERENCES\n")
cat(strrep("=", 70), "\n")

if (length(uc) > 0) {
    df$Primary_Tool <- uc[apply(df[, uc, drop = FALSE], 1, which.max)]
    tool_counts <- table(df$Primary_Tool)
    cat("Primary tool distribution:\n")
    for (tl in names(tool_counts)) {
        cat(sprintf("  %s: n=%d (%.1f%%)\n", tl, tool_counts[tl], tool_counts[tl] / nrow(df) * 100))
    }

    chatgpt_users <- df[df$Primary_Tool == "Usage_ChatGPT", ]
    copilot_users <- df[df$Primary_Tool == "Usage_MSCopilot", ]
    compare_constructs <- c("PE", "EE", "SI", "FC", "HM", "PV", "HB", "TR", "BI", "Total_Usage")
    tool_comparison <- list()
    cat(sprintf("\n  ChatGPT n=%d vs Copilot n=%d\n", nrow(chatgpt_users), nrow(copilot_users)))

    for (cname in compare_constructs) {
        if (cname %in% names(df)) {
            cg <- na.omit(chatgpt_users[[cname]])
            cp <- na.omit(copilot_users[[cname]])
            if (length(cg) > 1 && length(cp) > 1) {
                tt <- t.test(cg, cp)
                tool_comparison[[cname]] <- list(
                    t = tt$statistic, p = tt$p.value,
                    chatgpt_mean = mean(cg), copilot_mean = mean(cp)
                )
                sig <- ifelse(tt$p.value < 0.05, "*", "")
                cat(sprintf("    %s: t=%.3f, p=%.4f %s\n", cname, tt$statistic, tt$p.value, sig))
            }
        }
    }

    gap_results$gap5_tool_preferences <- list(
        title = "Primary Tool x Constructs",
        method = "Independent-samples t-test (ChatGPT vs Copilot)",
        distribution = as.list(tool_counts),
        comparison = tool_comparison
    )

    png("plots/09_tool_profiles.png", width = 1000, height = 600, res = 150)
    plot_c <- names(tool_comparison)
    cg_vals <- sapply(plot_c, function(c) tool_comparison[[c]]$chatgpt_mean)
    cp_vals <- sapply(plot_c, function(c) tool_comparison[[c]]$copilot_mean)
    plot(seq_along(plot_c), cg_vals,
        type = "b", pch = 16, col = "steelblue",
        ylim = range(c(cg_vals, cp_vals)) * c(0.9, 1.1),
        xaxt = "n", xlab = "", ylab = "Mean Score",
        main = "Construct Profiles: ChatGPT vs Copilot Primary Users"
    )
    lines(seq_along(plot_c), cp_vals, type = "b", pch = 15, col = "coral")
    axis(1, at = seq_along(plot_c), labels = plot_c, las = 2, cex.axis = 0.8)
    legend("bottomright",
        legend = c(
            sprintf("ChatGPT (n=%d)", nrow(chatgpt_users)),
            sprintf("Copilot (n=%d)", nrow(copilot_users))
        ),
        col = c("steelblue", "coral"), pch = c(16, 15), lty = 1, cex = 0.8
    )
    grid()
    dev.off()
    cat("  Saved plots/09_tool_profiles.png\n")
}

# ══════════════════════════════════════════════════════════════════════════════
# Gap 6 — User Typology (K-means k=4)
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("GAP 6: USER TYPOLOGY (K-MEANS k=4)\n")
cat(strrep("=", 70), "\n")

cluster_vars <- c("PE", "EE", "TR", "HB", "AX", "BI")
available_cv <- intersect(cluster_vars, names(df))
X <- df[complete.cases(df[, available_cv]), available_cv]
cat(sprintf("  Clustering on %s, n=%d\n", paste(available_cv, collapse = ","), nrow(X)))

X_scaled <- scale(X)
set.seed(67)
km <- kmeans(X_scaled, centers = 4, nstart = 10)
df$Cluster <- NA
df$Cluster[as.integer(rownames(X))] <- km$cluster

# Name clusters
cluster_profiles <- aggregate(. ~ Cluster, data = df[!is.na(df$Cluster), c("Cluster", available_cv)], FUN = mean)
cluster_names <- character(4)
for (i in 1:4) {
    bi_val <- cluster_profiles$BI[cluster_profiles$Cluster == i]
    ax_val <- if ("AX" %in% names(cluster_profiles)) cluster_profiles$AX[cluster_profiles$Cluster == i] else 3
    if (bi_val > 3.5 && ax_val < 3.5) {
        cluster_names[i] <- "Confident Adopters"
    } else if (bi_val > 3.5 && ax_val >= 3.5) {
        cluster_names[i] <- "Anxious Enthusiasts"
    } else if (bi_val <= 3.5 && ax_val < 3.5) {
        cluster_names[i] <- "Indifferent Users"
    } else {
        cluster_names[i] <- "Anxious Avoiders"
    }
}

df$ClusterName <- cluster_names[df$Cluster]

cat("\n  Cluster profiles:\n")
for (i in 1:4) {
    n <- sum(df$Cluster == i, na.rm = TRUE)
    cat(sprintf("    %s (n=%d):\n", cluster_names[i], n))
    for (v in available_cv) {
        cat(sprintf("      %s: %.3f\n", v, cluster_profiles[[v]][cluster_profiles$Cluster == i]))
    }
}

gap_results$gap6_user_typology <- list(
    title = "K-means User Typology (k=4)", method = "K-means clustering",
    n_clusters = 4, cluster_vars = available_cv,
    clusters = setNames(lapply(1:4, function(i) {
        list(
            n = sum(df$Cluster == i, na.rm = TRUE),
            profile = as.list(cluster_profiles[cluster_profiles$Cluster == i, available_cv])
        )
    }), cluster_names)
)

png("plots/09_user_typology.png", width = 1000, height = 600, res = 150)
plot(seq_along(available_cv), cluster_profiles[1, available_cv],
    type = "n",
    ylim = c(1, 5), xaxt = "n", xlab = "", ylab = "Mean Score",
    main = "User Typology Profiles (K-means k=4)"
)
cols <- c("#ef5350", "#ffa726", "#66bb6a", "#42a5f5")
for (i in 1:4) {
    n <- sum(df$Cluster == i, na.rm = TRUE)
    means <- as.numeric(cluster_profiles[cluster_profiles$Cluster == i, available_cv])
    lines(seq_along(available_cv), means, type = "b", pch = 16, col = cols[i])
}
axis(1, at = seq_along(available_cv), labels = available_cv)
legend("bottomleft",
    legend = paste0(cluster_names, " (n=", table(df$Cluster)[1:4], ")"),
    col = cols, lty = 1, pch = 16, cex = 0.7
)
grid()
dev.off()
cat("  Saved plots/09_user_typology.png\n")

# ── Export ────────────────────────────────────────────────────────────────────
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("EXPORT\n")
cat(strrep("=", 70), "\n")

output <- list(
    metadata = list(
        n = nrow(df), source = "AIRS_clean.csv",
        constructs = c(names(CONSTRUCT_DEFS), "BI", "Total_Usage")
    ),
    gap_results = gap_results,
    files_generated = c(
        "plots/09_education_comparison.png", "plots/09_industry_comparison.png",
        "plots/09_experience_effect.png", "plots/09_disability_comparison.png",
        "plots/09_tool_profiles.png", "plots/09_user_typology.png"
    )
)

write_json(output, "results/phase9_comprehensive_review_results.json",
    pretty = TRUE, auto_unbox = TRUE
)
cat("Saved results/phase9_comprehensive_review_results.json\n")

cat("\nPhase 9 complete.\n")
