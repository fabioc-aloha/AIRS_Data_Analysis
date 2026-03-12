#!/usr/bin/env Rscript
# ==============================================================================
# AIRS Phase 12: Simplified Classification System
# R port of run_12_classification.py
#
# Method 1 — Cut-point classification (ARI sum)
# Method 2 — Decision tree (rpart, max_depth=3)
# Method 3 — Simplified top-3 constructs
# Outputs: results/phase12_simplified_classification_results.json, 6 plots
# ==============================================================================

library(jsonlite)
library(rpart)
library(rpart.plot)

cat(strrep("=", 90), "\n")
cat("PHASE 12: SIMPLIFIED CLASSIFICATION SYSTEM\n")
cat(strrep("=", 90), "\n")

dir.create("results", showWarnings = FALSE)
dir.create("plots", showWarnings = FALSE)

# ── Configuration ─────────────────────────────────────────────────────────────
AIRS16_CONSTRUCTS <- c("PE", "EE", "SI", "FC", "HM", "PV", "HB", "TR")
CONSTRUCT_ITEMS <- list(
    PE = c("PE1", "PE2"), EE = c("EE1", "EE2"), SI = c("SI1", "SI2"),
    FC = c("FC1", "FC2"), HM = c("HM1", "HM2"), PV = c("PV1", "PV2"),
    HB = c("HB1", "HB2"), TR = c("TR1", "TR2")
)
BI_ITEMS <- c("BI1", "BI2", "BI3", "BI4")

classify_by_cutpoints <- function(ari, low_cut, high_cut) {
    ifelse(ari <= low_cut, "AI Skeptics",
        ifelse(ari >= high_cut, "AI Enthusiasts", "Moderate Users")
    )
}

# ── Load Data ─────────────────────────────────────────────────────────────────
df <- read.csv("data/AIRS_clean.csv", stringsAsFactors = FALSE)
cat(sprintf("Loaded AIRS_clean.csv: N=%d\n", nrow(df)))

# Load NB11 results
nb11 <- list()
if (file.exists("results/phase11_practitioner_typology_results.json")) {
    nb11 <- fromJSON("results/phase11_practitioner_typology_results.json", simplifyVector = FALSE)
    cat("Loaded NB11 results\n")
}

# Compute construct scores
for (nm in names(CONSTRUCT_ITEMS)) {
    df[[nm]] <- rowMeans(df[, CONSTRUCT_ITEMS[[nm]], drop = FALSE], na.rm = TRUE)
}
df$BI <- rowMeans(df[, intersect(BI_ITEMS, names(df)), drop = FALSE], na.rm = TRUE)

# ── Recreate K-means k=3 ground truth ────────────────────────────────────────
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("RECREATING K-MEANS k=3 GROUND TRUTH\n")
cat(strrep("=", 70), "\n")

X <- df[complete.cases(df[, AIRS16_CONSTRUCTS]), AIRS16_CONSTRUCTS]
X_scaled <- scale(X)
set.seed(67)
km <- kmeans(X_scaled, centers = 3, nstart = 10)
df$Cluster <- NA
df$Cluster[as.integer(rownames(X))] <- km$cluster

# Map cluster labels to names by BI mean
cluster_bi <- tapply(df$BI[!is.na(df$Cluster)], df$Cluster[!is.na(df$Cluster)], mean)
sorted_idx <- order(cluster_bi)
name_map <- character(3)
name_map[sorted_idx[1]] <- "AI Skeptics"
name_map[sorted_idx[2]] <- "Moderate Users"
name_map[sorted_idx[3]] <- "AI Enthusiasts"
df$ClusterName <- name_map[df$Cluster]

for (cname in c("AI Skeptics", "Moderate Users", "AI Enthusiasts")) {
    n <- sum(df$ClusterName == cname, na.rm = TRUE)
    bi <- mean(df$BI[df$ClusterName == cname], na.rm = TRUE)
    cat(sprintf("  %s: n=%d, BI mean=%.3f\n", cname, n, bi))
}

# BI statistics
grand_mean <- mean(df$BI, na.rm = TRUE)
ss_total <- sum((df$BI - grand_mean)^2, na.rm = TRUE)

nb11_eta <- nb11$validation$bi_eta_squared
if (!is.null(nb11_eta)) cat(sprintf("\n  NB11 eta2 = %.4f\n", nb11_eta))

# ══════════════════════════════════════════════════════════════════════════════
# Method 1: Cut-Point Classification
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("METHOD 1: CUT-POINT CLASSIFICATION\n")
cat(strrep("=", 70), "\n")

df$ARI_Sum <- rowSums(df[, AIRS16_CONSTRUCTS], na.rm = TRUE)

# Weighted ARI via regression
X_reg <- df[complete.cases(df[, c(AIRS16_CONSTRUCTS, "BI")]), AIRS16_CONSTRUCTS]
y_reg <- df[rownames(X_reg), "BI"]
reg_fit <- lm(y_reg ~ ., data = X_reg)
weights <- pmax(coef(reg_fit)[-1], 0) # exclude intercept, floor at 0
weights <- weights / sum(weights)
df$ARI_Weighted <- as.numeric(as.matrix(df[, AIRS16_CONSTRUCTS]) %*% weights)

# BI correlation
ari_bi_corr <- cor.test(df$ARI_Sum, df$BI, use = "complete.obs")
cat(sprintf("  ARI_Sum x BI: r=%.3f, p=%.4f\n", ari_bi_corr$estimate, ari_bi_corr$p.value))

# Tertile cuts
p33 <- quantile(df$ARI_Sum, 0.333, na.rm = TRUE)
p67 <- quantile(df$ARI_Sum, 0.667, na.rm = TRUE)
cat(sprintf("  Tertile cuts: p33=%.2f, p67=%.2f\n", p33, p67))

# Optimize cuts
accuracy <- function(cuts) {
    low <- min(cuts)
    high <- max(cuts)
    preds <- classify_by_cutpoints(df$ARI_Sum, low, high)
    mean(preds == df$ClusterName, na.rm = TRUE)
}
opt <- optim(c(p33, p67), fn = function(x) 1 - accuracy(x), method = "Nelder-Mead")
opt_low <- min(opt$par)
opt_high <- max(opt$par)
cat(sprintf("  Optimized cuts: %.2f, %.2f\n", opt_low, opt_high))

# Practical thresholds
practical_low <- 20.0
practical_high <- 30.0
df$CutPoint_Pred <- classify_by_cutpoints(df$ARI_Sum, practical_low, practical_high)
cut_acc <- mean(df$CutPoint_Pred == df$ClusterName, na.rm = TRUE)
cat(sprintf("  Practical cuts (20/30): accuracy=%.3f\n", cut_acc))

# Eta-squared for cut-point
cut_groups <- split(df$BI[!is.na(df$CutPoint_Pred)], df$CutPoint_Pred[!is.na(df$CutPoint_Pred)])
ss_between_cut <- sum(sapply(cut_groups, function(g) length(g) * (mean(g) - grand_mean)^2))
eta_sq_cut <- ss_between_cut / ss_total
cat(sprintf("  Cut-point eta2 = %.4f\n", eta_sq_cut))

# ARI x BI scatter
png("plots/12_00_ari_bi_correlation.png", width = 1000, height = 600, res = 150)
colors <- ifelse(df$ClusterName == "AI Skeptics", "#ef5350",
    ifelse(df$ClusterName == "Moderate Users", "#ffa726", "#42a5f5")
)
plot(df$ARI_Sum, df$BI,
    col = colors, pch = 16, cex = 0.5,
    xlab = "ARI Sum Score", ylab = "Behavioral Intention",
    main = "ARI Sum vs BI with K-means Ground Truth"
)
abline(v = practical_low, col = "red", lty = 2)
abline(v = practical_high, col = "green", lty = 2)
legend("bottomright",
    legend = c("AI Skeptics", "Moderate Users", "AI Enthusiasts"),
    col = c("#ef5350", "#ffa726", "#42a5f5"), pch = 16, cex = 0.7
)
dev.off()
cat("Saved plots/12_00_ari_bi_correlation.png\n")

# Cut-point classification plot
png("plots/12_01_cutpoint_classification.png", width = 1000, height = 600, res = 150)
colors2 <- ifelse(df$CutPoint_Pred == "AI Skeptics", "#ef5350",
    ifelse(df$CutPoint_Pred == "Moderate Users", "#ffa726", "#42a5f5")
)
plot(df$ARI_Sum, df$BI,
    col = colors2, pch = 16, cex = 0.5,
    xlab = "ARI Sum Score", ylab = "Behavioral Intention",
    main = sprintf("Cut-Point Classification (Accuracy=%.1f%%)", cut_acc * 100)
)
abline(v = practical_low, col = "red", lty = 2)
abline(v = practical_high, col = "green", lty = 2)
dev.off()
cat("Saved plots/12_01_cutpoint_classification.png\n")

# Cut-point with BI prediction
png("plots/12_01b_cutpoint_with_bi.png", width = 1000, height = 600, res = 150)
bi_lookup <- tapply(df$BI, df$ClusterName, mean, na.rm = TRUE)
df$BI_Predicted <- bi_lookup[df$CutPoint_Pred]
plot(df$BI, df$BI_Predicted,
    pch = 16, cex = 0.3, col = rgb(0, 0, 1, 0.3),
    xlab = "Actual BI", ylab = "Predicted BI (from cluster mean)",
    main = "Cut-Point BI Prediction"
)
abline(0, 1, col = "red", lty = 2)
dev.off()
cat("Saved plots/12_01b_cutpoint_with_bi.png\n")

# ══════════════════════════════════════════════════════════════════════════════
# Method 2: Decision Tree
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("METHOD 2: DECISION TREE\n")
cat(strrep("=", 70), "\n")

X_tree <- df[
    complete.cases(df[, c(AIRS16_CONSTRUCTS, "ClusterName")]),
    c(AIRS16_CONSTRUCTS, "ClusterName")
]
X_tree$ClusterName <- factor(X_tree$ClusterName)

dt <- rpart(ClusterName ~ .,
    data = X_tree, method = "class",
    control = rpart.control(maxdepth = 3, minsplit = 20, cp = 0.001)
)

tree_preds <- predict(dt, X_tree, type = "class")
tree_acc <- mean(tree_preds == X_tree$ClusterName)
cat(sprintf("  Training accuracy: %.3f\n", tree_acc))

# 5-fold CV
set.seed(67)
n_tree <- nrow(X_tree)
folds <- sample(rep(1:5, length.out = n_tree))
cv_acc <- numeric(5)
for (fold in 1:5) {
    train_data <- X_tree[folds != fold, ]
    test_data <- X_tree[folds == fold, ]
    fit_cv <- rpart(ClusterName ~ .,
        data = train_data, method = "class",
        control = rpart.control(maxdepth = 3, minsplit = 20, cp = 0.001)
    )
    preds_cv <- predict(fit_cv, test_data, type = "class")
    cv_acc[fold] <- mean(preds_cv == test_data$ClusterName)
}
cat(sprintf("  5-fold CV: %.3f +/- %.3f\n", mean(cv_acc), sd(cv_acc)))

# Feature importance
feat_imp <- dt$variable.importance
feat_imp <- sort(feat_imp / sum(feat_imp), decreasing = TRUE)
key_constructs <- names(feat_imp[feat_imp > 0.1])
cat(sprintf("  Key constructs (importance>0.1): %s\n", paste(key_constructs, collapse = ", ")))

# Eta-squared for decision tree
df_complete <- df[complete.cases(df[, AIRS16_CONSTRUCTS]), ]
df_complete$Tree_Pred <- as.character(predict(dt, df_complete[, AIRS16_CONSTRUCTS], type = "class"))
tree_groups <- split(df_complete$BI, df_complete$Tree_Pred)
ss_between_tree <- sum(sapply(tree_groups, function(g) length(g) * (mean(g) - grand_mean)^2))
eta_sq_tree <- ss_between_tree / ss_total
cat(sprintf("  Decision tree eta2 = %.4f\n", eta_sq_tree))

# Tree visualization
png("plots/12_02_decision_tree.png", width = 1600, height = 800, res = 150)
rpart.plot(dt,
    main = "Decision Tree Classification (max_depth=3)",
    extra = 104, cex = 0.7, box.palette = "RdYlGn"
)
dev.off()
cat("Saved plots/12_02_decision_tree.png\n")

# ══════════════════════════════════════════════════════════════════════════════
# Method 3: Simplified (Top-3 Constructs)
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("METHOD 3: SIMPLIFIED (TOP-3 CONSTRUCTS)\n")
cat(strrep("=", 70), "\n")

# Combined ranking from tree importance + regression weights + BI correlations
tree_rank <- rank(-feat_imp[AIRS16_CONSTRUCTS])
names(tree_rank) <- AIRS16_CONSTRUCTS
reg_rank <- rank(-weights)
bi_corrs <- sapply(AIRS16_CONSTRUCTS, function(c) abs(cor(df[[c]], df$BI, use = "complete.obs")))
corr_rank <- rank(-bi_corrs)
avg_rank <- (tree_rank + reg_rank + corr_rank) / 3
top_constructs <- names(sort(avg_rank))[1:3]
cat(sprintf("  Top 3 constructs: %s\n", paste(top_constructs, collapse = ", ")))

df$ARI_Simple <- rowSums(df[, top_constructs], na.rm = TRUE)

# Optimize simplified cuts
accuracy_simple <- function(cuts) {
    low <- min(cuts)
    high <- max(cuts)
    preds <- classify_by_cutpoints(df$ARI_Simple, low, high)
    mean(preds == df$ClusterName, na.rm = TRUE)
}
sp33 <- quantile(df$ARI_Simple, 0.333, na.rm = TRUE)
sp67 <- quantile(df$ARI_Simple, 0.667, na.rm = TRUE)
opt_simple <- optim(c(sp33, sp67), fn = function(x) 1 - accuracy_simple(x), method = "Nelder-Mead")
simp_low <- min(opt_simple$par)
simp_high <- max(opt_simple$par)
df$Simple_Pred <- classify_by_cutpoints(df$ARI_Simple, simp_low, simp_high)
simple_acc <- mean(df$Simple_Pred == df$ClusterName, na.rm = TRUE)
cat(sprintf("  Simplified cuts: %.2f, %.2f\n", simp_low, simp_high))
cat(sprintf("  Simplified accuracy: %.3f\n", simple_acc))

# Eta-squared for simplified
simple_groups <- split(df$BI[!is.na(df$Simple_Pred)], df$Simple_Pred[!is.na(df$Simple_Pred)])
ss_between_simple <- sum(sapply(simple_groups, function(g) length(g) * (mean(g) - grand_mean)^2))
eta_sq_simple <- ss_between_simple / ss_total
cat(sprintf("  Simplified eta2 = %.4f\n", eta_sq_simple))

# ══════════════════════════════════════════════════════════════════════════════
# Method Comparison
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("METHOD COMPARISON\n")
cat(strrep("=", 70), "\n")

comparison <- data.frame(
    Method = c("K-means (ground truth)", "Cut-Point (8 constructs)", "Decision Tree", "Simplified (3 constructs)"),
    Accuracy = c(1.0, cut_acc, tree_acc, simple_acc),
    Eta_Sq = c(ifelse(is.null(nb11_eta), NA, nb11_eta), eta_sq_cut, eta_sq_tree, eta_sq_simple),
    Constructs = c(8, 8, length(key_constructs), 3),
    Complexity = c("High", "Low", "Medium", "Very Low"),
    stringsAsFactors = FALSE
)
print(comparison)

# Comparison plot
png("plots/12_03_method_comparison.png", width = 1200, height = 500, res = 150)
par(mfrow = c(1, 2), mar = c(8, 4, 3, 1))
cols_comp <- c("#2e7d32", "#1976d2", "#f57c00", "#9c27b0")
barplot(comparison$Accuracy,
    names.arg = comparison$Method,
    col = cols_comp, ylab = "Accuracy", main = "Classification Accuracy",
    las = 2, cex.names = 0.65, ylim = c(0, 1.1)
)
barplot(comparison$Eta_Sq,
    names.arg = comparison$Method,
    col = cols_comp, ylab = "eta2", main = "Effect Size (eta2)",
    las = 2, cex.names = 0.65
)
dev.off()
cat("Saved plots/12_03_method_comparison.png\n")

# Confusion matrices (text-based)
cat("\n--- Confusion Matrices ---\n")
for (pred_col in c("CutPoint_Pred", "Tree_Pred", "Simple_Pred")) {
    if (pred_col == "Tree_Pred") {
        actual <- df_complete$ClusterName
        predicted <- df_complete$Tree_Pred
    } else {
        actual <- df$ClusterName
        predicted <- df[[pred_col]]
    }
    valid <- !is.na(actual) & !is.na(predicted)
    cm <- table(Actual = actual[valid], Predicted = predicted[valid])
    cat(sprintf("\n  %s:\n", pred_col))
    print(cm)
}

# Confusion matrix heatmap plot
png("plots/12_04_confusion_matrices.png", width = 1800, height = 500, res = 150)
par(mfrow = c(1, 3), mar = c(6, 6, 3, 2))
labels_order <- c("AI Skeptics", "Moderate Users", "AI Enthusiasts")
for (info in list(
    list(col = "CutPoint_Pred", title = "Cut-Point", df_src = df),
    list(col = "Tree_Pred", title = "Decision Tree", df_src = df_complete),
    list(col = "Simple_Pred", title = "Simplified", df_src = df)
)) {
    actual <- factor(info$df_src$ClusterName, levels = labels_order)
    predicted <- factor(info$df_src[[info$col]], levels = labels_order)
    valid <- !is.na(actual) & !is.na(predicted)
    cm <- table(actual[valid], predicted[valid])
    image(1:3, 1:3, t(cm[3:1, ]),
        col = colorRampPalette(c("white", "steelblue"))(50),
        axes = FALSE, xlab = "Predicted", ylab = "Actual", main = info$title
    )
    axis(1, at = 1:3, labels = labels_order, las = 2, cex.axis = 0.6)
    axis(2, at = 1:3, labels = rev(labels_order), las = 1, cex.axis = 0.6)
    for (i in 1:3) {
        for (j in 1:3) {
            text(j, 4 - i, cm[i, j], cex = 1.2)
        }
    }
}
dev.off()
cat("Saved plots/12_04_confusion_matrices.png\n")

# ══════════════════════════════════════════════════════════════════════════════
# Practitioner Guide
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("PRACTITIONER GUIDE: classify_airs16_simple()\n")
cat(strrep("=", 70), "\n")

classify_airs16_simple <- function(pe, ee, si, fc, hm, pv, hb, tr,
                                   low_threshold = 21.13, high_threshold = 30.75) {
    ari <- pe + ee + si + fc + hm + pv + hb + tr
    type <- classify_by_cutpoints(ari, low_threshold, high_threshold)
    list(type = type, ari = ari)
}

test_cases <- list(
    c(4.5, 4.0, 3.5, 4.0, 4.5, 4.0, 4.0, 4.5),
    c(2.0, 2.5, 2.0, 2.5, 1.5, 2.0, 1.5, 2.0),
    c(3.5, 3.0, 3.0, 3.5, 3.0, 3.5, 3.0, 3.5)
)
for (tc in test_cases) {
    res <- do.call(classify_airs16_simple, as.list(tc))
    cat(sprintf(
        "  Input means: %s -> ARI=%.2f -> %s\n",
        paste(tc, collapse = ","), res$ari, res$type
    ))
}

# ── Export ────────────────────────────────────────────────────────────────────
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("EXPORT\n")
cat(strrep("=", 70), "\n")

output <- list(
    metadata = list(
        n = nrow(df), constructs = AIRS16_CONSTRUCTS, ground_truth = "K-means k=3"
    ),
    cutpoint_method = list(
        ari_bi_correlation = as.numeric(ari_bi_corr$estimate),
        practical_thresholds = list(low = practical_low, high = practical_high),
        optimized_thresholds = list(low = opt_low, high = opt_high),
        accuracy = cut_acc, eta_squared = eta_sq_cut
    ),
    decision_tree_method = list(
        max_depth = 3, training_accuracy = tree_acc,
        cv_mean = mean(cv_acc), cv_std = sd(cv_acc),
        key_constructs = key_constructs,
        feature_importance = as.list(feat_imp),
        eta_squared = eta_sq_tree
    ),
    simplified_method = list(
        top_constructs = top_constructs,
        thresholds = list(low = simp_low, high = simp_high),
        accuracy = simple_acc, eta_squared = eta_sq_simple
    ),
    recommendation = "Cut-point method (8 constructs, practical 20/30) offers best balance of accuracy and simplicity",
    bi_lookup = as.list(bi_lookup)
)

write_json(output, "results/phase12_simplified_classification_results.json",
    pretty = TRUE, auto_unbox = TRUE
)
cat("Saved results/phase12_simplified_classification_results.json\n")

cat("\nPhase 12 complete.\n")
