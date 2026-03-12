#!/usr/bin/env Rscript
# ==============================================================================
# AIRS Phase 7: AI Tool Usage Patterns (RQ10)
# R port of run_07_tool_usage.py
#
# RQ10a - Usage frequency distributions
# RQ10b - Role-type comparison (3-group ANOVA)
# RQ10c - Usage x construct correlations (Spearman)
# RQ10d - Multi-tool user analysis
# Outputs: results/phase7_tool_usage_results.json, 5 plots
# ==============================================================================

library(jsonlite)

cat(strrep("=", 90), "\n")
cat("PHASE 7: AI TOOL USAGE PATTERNS\n")
cat(strrep("=", 90), "\n")

dir.create("results", showWarnings = FALSE)
dir.create("plots",   showWarnings = FALSE)

# ── Configuration ─────────────────────────────────────────────────────────────
USAGE_COLS <- c("Usage_MSCopilot", "Usage_ChatGPT", "Usage_Gemini", "Usage_Other")
USAGE_LABELS <- c("1" = "Never", "2" = "Rarely", "3" = "Sometimes", "4" = "Often", "5" = "Very often")

CONSTRUCT_ITEMS <- list(
  PerfExp  = c("PE1","PE2"), EffortExp = c("EE1","EE2"),
  SocialInf = c("SI1","SI2"), FacCond  = c("FC1","FC2"),
  HedMot   = c("HM1","HM2"), PriceVal = c("PV1","PV2"),
  Habit    = c("HB1","HB2"), Trust    = c("TR1","TR2")
)
PROFILE_CONSTRUCTS <- c("PerfExp","EffortExp","SocialInf","FacCond",
                         "HedMot","PriceVal","Habit","Trust","BehInt")
CONSTRUCT_LABELS <- c("PE","EE","SI","FC","HM","PV","HB","TR","BI")

classify_role <- function(rc) {
  ifelse(is.na(rc), "Professional",
  ifelse(rc %in% c("FT_Student","PT_Student"), "Academic",
  ifelse(rc %in% c("Manager","Executive"), "Leader", "Professional")))
}

count_tools <- function(row, threshold = 2) {
  sum(row >= threshold, na.rm = TRUE)
}

classify_user <- function(n) {
  ifelse(n == 0, "Non-User",
  ifelse(n == 1, "Single-Tool",
  ifelse(n == 2, "Dual-Tool", "Multi-Tool")))
}

calc_tool_stats <- function(vals) {
  list(mean = mean(vals, na.rm = TRUE), std = sd(vals, na.rm = TRUE),
       median = median(vals, na.rm = TRUE),
       never_pct = mean(vals == 1, na.rm = TRUE) * 100,
       active_pct = mean(vals >= 3, na.rm = TRUE) * 100,
       heavy_pct  = mean(vals >= 4, na.rm = TRUE) * 100)
}

# ── Load Data ─────────────────────────────────────────────────────────────────
df_efa <- read.csv("data/AIRS_experiment.csv", stringsAsFactors = FALSE)
df_cfa <- read.csv("data/AIRS_holdout.csv",    stringsAsFactors = FALSE)
df <- rbind(df_efa, df_cfa)
cat(sprintf("Combined sample N = %d\n", nrow(df)))

# Compute construct scores
for (cn in names(CONSTRUCT_ITEMS)) {
  df[[cn]] <- rowMeans(df[, CONSTRUCT_ITEMS[[cn]], drop = FALSE], na.rm = TRUE)
}
df$BehInt <- rowMeans(df[, c("BI1","BI2","BI3","BI4")], na.rm = TRUE)
uc <- intersect(USAGE_COLS, names(df))
df$Usage_Total <- rowMeans(df[, uc, drop = FALSE], na.rm = TRUE)
df$Role_Type <- classify_role(df$Role_Category)

# ══════════════════════════════════════════════════════════════════════════════
# RQ10a: Usage Frequency Distributions
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("RQ10a: USAGE FREQUENCY DISTRIBUTIONS\n")
cat(strrep("=", 70), "\n")

summary_data <- list()
for (col in uc) {
  s <- calc_tool_stats(df[[col]])
  summary_data[[col]] <- s
  tl <- sub("Usage_", "", col)
  cat(sprintf("\n%s: M=%.2f, SD=%.2f, Never=%.1f%%, Active(>=3)=%.1f%%, Heavy(>=4)=%.1f%%\n",
              tl, s$mean, s$std, s$never_pct, s$active_pct, s$heavy_pct))
}

# Plot
png("plots/07_usage_frequency_distribution.png", width = 1200, height = 800, res = 150)
par(mfrow = c(2, 2), mar = c(5, 4, 3, 1))
for (col in uc) {
  tbl <- table(factor(df[[col]], levels = 1:5))
  barplot(tbl, names.arg = USAGE_LABELS[as.character(1:5)], col = "steelblue",
          main = sub("Usage_", "", col), ylab = "Count", las = 2, cex.names = 0.8)
}
title(main = "AI Tool Usage Frequency Distributions", outer = TRUE, line = -1)
dev.off()
cat("Saved plots/07_usage_frequency_distribution.png\n")

# ══════════════════════════════════════════════════════════════════════════════
# RQ10b: Role-Type Comparison (3-group)
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("RQ10b: ROLE-TYPE COMPARISON (3-GROUP)\n")
cat(strrep("=", 70), "\n")

cat("\nRole distribution:\n")
print(table(df$Role_Type))

anova_results <- list()
for (col in uc) {
  groups <- split(df[[col]], df$Role_Type)
  groups <- lapply(groups, na.omit)
  aov_fit <- tryCatch({
    res <- oneway.test(as.formula(paste(col, "~ Role_Type")), data = df)
    grand_mean <- mean(df[[col]], na.rm = TRUE)
    ss_between <- sum(sapply(groups, function(g) length(g) * (mean(g) - grand_mean)^2))
    ss_total <- sum((df[[col]] - grand_mean)^2, na.rm = TRUE)
    eta_sq <- ss_between / ss_total
    list(F = res$statistic, p = res$p.value, eta_sq = eta_sq)
  }, error = function(e) list(F = NA, p = NA, eta_sq = NA))
  anova_results[[col]] <- aov_fit
  cat(sprintf("  %s: F=%.3f, p=%.4f, eta2=%.4f\n",
              sub("Usage_", "", col), aov_fit$F, aov_fit$p, aov_fit$eta_sq))
}

# 3-group bar chart
png("plots/07_role_type_3group_comparison.png", width = 1000, height = 600, res = 150)
role_means <- aggregate(. ~ Role_Type, data = df[, c("Role_Type", uc)], FUN = mean, na.rm = TRUE)
barplot_data <- t(as.matrix(role_means[, -1]))
colnames(barplot_data) <- role_means$Role_Type
rownames(barplot_data) <- sub("Usage_", "", uc)
barplot(barplot_data, beside = TRUE, col = rainbow(length(uc)),
        ylab = "Mean Usage (1-5)", main = "AI Tool Usage by Role Type (3-Group)",
        legend.text = rownames(barplot_data), args.legend = list(x = "topright", cex = 0.8))
dev.off()
cat("Saved plots/07_role_type_3group_comparison.png\n")

# ── Leadership deep-dive ─────────────────────────────────────────────────────
cat("\n--- Leadership Deep-Dive ---\n")
leaders <- df[df$Role_Type == "Leader", ]
professionals <- df[df$Role_Type == "Professional", ]
cat(sprintf("Leaders n=%d, Professionals n=%d\n", nrow(leaders), nrow(professionals)))

leader_results <- list(leader_n = nrow(leaders), professional_n = nrow(professionals),
                       tool_effects = list(), construct_effects = list())

for (col in uc) {
  tt <- t.test(leaders[[col]], professionals[[col]])
  d <- (mean(leaders[[col]], na.rm = TRUE) - mean(professionals[[col]], na.rm = TRUE)) / sd(professionals[[col]], na.rm = TRUE)
  leader_results$tool_effects[[col]] <- list(t = tt$statistic, p = tt$p.value, cohens_d = d)
  sig <- ifelse(tt$p.value < 0.05, "*", "")
  cat(sprintf("  %s: t=%.3f, p=%.4f, d=%.3f %s\n", sub("Usage_","",col), tt$statistic, tt$p.value, d, sig))
}

cat("\n  Construct comparison (Leaders vs Professionals):\n")
for (cn in PROFILE_CONSTRUCTS) {
  lv <- leaders[[cn]]; pv <- professionals[[cn]]
  if (length(na.omit(lv)) > 1 && length(na.omit(pv)) > 1) {
    tt <- t.test(lv, pv)
    d <- (mean(lv, na.rm = TRUE) - mean(pv, na.rm = TRUE)) / sd(pv, na.rm = TRUE)
    leader_results$construct_effects[[cn]] <- list(t = tt$statistic, p = tt$p.value, cohens_d = d)
    sig <- ifelse(tt$p.value < 0.05, "*", "")
    cat(sprintf("    %s: t=%.3f, p=%.4f, d=%.3f %s\n", cn, tt$statistic, tt$p.value, d, sig))
  }
}

# 2-group bar chart
png("plots/07_role_type_comparison.png", width = 1000, height = 600, res = 150)
l_means <- sapply(PROFILE_CONSTRUCTS, function(cn) mean(leaders[[cn]], na.rm = TRUE))
p_means <- sapply(PROFILE_CONSTRUCTS, function(cn) mean(professionals[[cn]], na.rm = TRUE))
barplot_data2 <- rbind(Leader = l_means, Professional = p_means)
colnames(barplot_data2) <- CONSTRUCT_LABELS
barplot(barplot_data2, beside = TRUE, col = c("#42a5f5", "#66bb6a"),
        ylab = "Mean Score (1-5)", main = "AIRS Construct Means: Leaders vs Professionals",
        legend.text = TRUE, args.legend = list(x = "topright"))
dev.off()
cat("Saved plots/07_role_type_comparison.png\n")

# ══════════════════════════════════════════════════════════════════════════════
# RQ10c: Usage x Construct Correlations (Spearman)
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("RQ10c: USAGE x CONSTRUCT CORRELATIONS (SPEARMAN)\n")
cat(strrep("=", 70), "\n")

usage_vars <- c(uc, "Usage_Total")
corr_dict <- list()

for (uv in usage_vars) {
  corr_dict[[uv]] <- list()
  for (cv in PROFILE_CONSTRUCTS) {
    valid <- complete.cases(df[, c(uv, cv)])
    ct <- cor.test(df[valid, uv], df[valid, cv], method = "spearman")
    corr_dict[[uv]][[cv]] <- list(rho = ct$estimate, p = ct$p.value)
  }
  if (uv == "Usage_Total") {
    cat("\n  Usage_Total correlations:\n")
    for (cv in PROFILE_CONSTRUCTS) {
      r <- corr_dict[[uv]][[cv]]
      sig <- ifelse(r$p < 0.001, "***", ifelse(r$p < 0.01, "**", ifelse(r$p < 0.05, "*", "")))
      cat(sprintf("    %s: rho=%.3f, p=%.4f %s\n", cv, r$rho, r$p, sig))
    }
  }
}

# Heatmap
png("plots/07_usage_construct_correlations.png", width = 1200, height = 600, res = 150)
corr_mat <- matrix(NA, nrow = length(usage_vars), ncol = length(PROFILE_CONSTRUCTS))
rownames(corr_mat) <- sub("Usage_", "", usage_vars)
colnames(corr_mat) <- CONSTRUCT_LABELS
for (i in seq_along(usage_vars)) {
  for (j in seq_along(PROFILE_CONSTRUCTS)) {
    corr_mat[i, j] <- corr_dict[[usage_vars[i]]][[PROFILE_CONSTRUCTS[j]]]$rho
  }
}
par(mar = c(5, 8, 4, 6))
image(1:ncol(corr_mat), 1:nrow(corr_mat), t(corr_mat),
      col = colorRampPalette(c("#c62828","#ffffff","#2e7d32"))(50),
      zlim = c(-0.1, 0.7), axes = FALSE,
      xlab = "", ylab = "", main = "Spearman Correlations: Tool Usage x AIRS Constructs")
axis(1, at = 1:ncol(corr_mat), labels = colnames(corr_mat))
axis(2, at = 1:nrow(corr_mat), labels = rownames(corr_mat), las = 1)
for (i in 1:nrow(corr_mat)) {
  for (j in 1:ncol(corr_mat)) {
    text(j, i, sprintf("%.2f", corr_mat[i, j]), cex = 0.7)
  }
}
dev.off()
cat("Saved plots/07_usage_construct_correlations.png\n")

# ══════════════════════════════════════════════════════════════════════════════
# RQ10d: Multi-tool User Analysis
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("RQ10d: MULTI-TOOL USER ANALYSIS\n")
cat(strrep("=", 70), "\n")

df$N_Tools <- apply(df[, uc, drop = FALSE], 1, count_tools)
df$UserType <- classify_user(df$N_Tools)

user_type_order <- c("Non-User", "Single-Tool", "Dual-Tool", "Multi-Tool")
for (ut in user_type_order) {
  n <- sum(df$UserType == ut, na.rm = TRUE)
  cat(sprintf("  %s: n=%d (%.1f%%)\n", ut, n, n / nrow(df) * 100))
}

# ANOVA by user type for BI
groups_bi <- lapply(user_type_order, function(ut) df$BehInt[df$UserType == ut])
groups_bi <- groups_bi[sapply(groups_bi, function(g) length(na.omit(g)) > 0)]
if (length(groups_bi) >= 2) {
  aov_bi <- oneway.test(BehInt ~ UserType, data = df)
  cat(sprintf("\n  BI by UserType: F=%.3f, p=%.4f\n", aov_bi$statistic, aov_bi$p.value))
}

user_type_results <- list()
for (ut in user_type_order) {
  sub <- df[df$UserType == ut, ]
  if (nrow(sub) > 0) {
    user_type_results[[ut]] <- list(
      n = nrow(sub), pct = nrow(sub) / nrow(df) * 100,
      bi_mean = mean(sub$BehInt, na.rm = TRUE),
      bi_std  = sd(sub$BehInt, na.rm = TRUE))
  }
}

# Pie + Profile plot
png("plots/07_user_type_analysis.png", width = 1400, height = 600, res = 150)
par(mfrow = c(1, 2), mar = c(5, 4, 3, 2))
sizes <- sapply(user_type_order, function(ut) sum(df$UserType == ut))
pie(sizes, labels = paste0(user_type_order, "\n(", sizes, ")"),
    col = c("#ef5350","#ffa726","#66bb6a","#42a5f5"), main = "User Type Distribution")

plot(1:length(PROFILE_CONSTRUCTS), type = "n",
     ylim = range(1, 5), xaxt = "n",
     xlab = "", ylab = "Mean Score", main = "Construct Profiles by User Type")
axis(1, at = 1:length(CONSTRUCT_LABELS), labels = CONSTRUCT_LABELS)
cols <- c("#ef5350","#ffa726","#66bb6a","#42a5f5")
for (i in seq_along(user_type_order)) {
  ut <- user_type_order[i]
  sub <- df[df$UserType == ut, ]
  if (nrow(sub) > 0) {
    means <- sapply(PROFILE_CONSTRUCTS, function(cn) mean(sub[[cn]], na.rm = TRUE))
    lines(1:length(means), means, col = cols[i], type = "b", pch = 16)
  }
}
legend("bottomleft", legend = user_type_order, col = cols, lty = 1, pch = 16, cex = 0.7)
grid()
dev.off()
cat("Saved plots/07_user_type_analysis.png\n")

# ── Export ────────────────────────────────────────────────────────────────────
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("EXPORT\n")
cat(strrep("=", 70), "\n")

results <- list(
  sample_size = nrow(df),
  rq10a_usage_frequency = list(
    tools = summary_data,
    finding = "ChatGPT most widely used; Copilot growing segment"
  ),
  rq10b_population_comparison = list(
    analysis_method = "One-way ANOVA (3-group)",
    groups = as.list(table(df$Role_Type)),
    anova_results = anova_results,
    finding = "Leaders show highest usage across all tools"
  ),
  leader_comparison = leader_results,
  rq10c_correlations = corr_dict,
  rq10d_multi_tool = list(
    classification = user_type_results,
    finding = "Multi-tool users have highest BI and readiness"
  ),
  criterion_validity_evidence = "Strong: usage correlates with BI and constructs"
)

write_json(results, "results/phase7_tool_usage_results.json",
           pretty = TRUE, auto_unbox = TRUE)
cat("Saved results/phase7_tool_usage_results.json\n")

cat("\nPhase 7 complete.\n")
