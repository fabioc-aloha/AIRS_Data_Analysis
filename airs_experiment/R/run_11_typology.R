#!/usr/bin/env Rscript
# ==============================================================================
# AIRS Phase 11: Practitioner Typology Classification
# R port of run_11_typology.py
#
# K-means cluster analysis on AIRS-16 constructs.
# k=3 optimal, k=4 comparison, predictive validation, classification function.
# Outputs: results/phase11_practitioner_typology_results.json
# ==============================================================================

library(jsonlite)
library(cluster)

cat(strrep("=", 90), "\n")
cat("PHASE 11: PRACTITIONER TYPOLOGY CLASSIFICATION\n")
cat(strrep("=", 90), "\n")

dir.create("results", showWarnings = FALSE)

# ── Configuration ─────────────────────────────────────────────────────────────
AIRS16_CONSTRUCTS <- c("PE", "EE", "SI", "FC", "HM", "PV", "HB", "TR")
OUTCOME <- "BI"
SELECTED_K <- 3
K_ALT <- 4
RANDOM_STATE <- 42

# ── Load Data ─────────────────────────────────────────────────────────────────
df <- read.csv("data/AIRS_clean.csv", stringsAsFactors = FALSE)
cat(sprintf("\nLoaded: %d rows x %d columns\n", nrow(df), ncol(df)))

item_map <- list(
    PE = c("PE1", "PE2"), EE = c("EE1", "EE2"), SI = c("SI1", "SI2"),
    FC = c("FC1", "FC2"), HM = c("HM1", "HM2"), PV = c("PV1", "PV2"),
    HB = c("HB1", "HB2"), TR = c("TR1", "TR2")
)
for (cn in names(item_map)) {
    df[[cn]] <- rowMeans(df[, item_map[[cn]], drop = FALSE], na.rm = TRUE)
}
df$BI <- rowMeans(df[, c("BI1", "BI2", "BI3", "BI4")], na.rm = TRUE)

cat(sprintf("\nConstruct scores computed (N = %d)\n", nrow(df)))
print(summary(df[, c(AIRS16_CONSTRUCTS, "BI")]))

# Correlation with BI
cat("\nCorrelation with BI:\n")
for (cn in AIRS16_CONSTRUCTS) {
    r <- cor(df[[cn]], df$BI, use = "complete.obs")
    cat(sprintf("  %s: r = %.3f\n", cn, r))
}

# ── Prepare Clustering ───────────────────────────────────────────────────────
X <- df[complete.cases(df[, AIRS16_CONSTRUCTS]), AIRS16_CONSTRUCTS]
X_scaled <- scale(X)
pop_means <- colMeans(df[, AIRS16_CONSTRUCTS], na.rm = TRUE)
pop_stds <- apply(df[, AIRS16_CONSTRUCTS], 2, sd, na.rm = TRUE)

# ── Silhouette Analysis (k=2 to 8) ──────────────────────────────────────────
cat(sprintf("\n%s\n", strrep("=", 90)))
cat("SILHOUETTE ANALYSIS\n")
cat(strrep("=", 90), "\n")

sil_scores <- numeric()
for (k in 2:8) {
    set.seed(RANDOM_STATE)
    km <- kmeans(X_scaled, centers = k, nstart = 10)
    sil <- mean(silhouette(km$cluster, dist(X_scaled))[, "sil_width"])
    sil_scores[k] <- sil
    marker <- ifelse(k == SELECTED_K, " <-", "")
    cat(sprintf("  k=%d: silhouette = %.3f%s\n", k, sil, marker))
}

# ── k=3 Final Clustering ────────────────────────────────────────────────────
cat(sprintf("\n%s\n", strrep("=", 90)))
cat(sprintf("FINAL CLUSTERING (k=%d)\n", SELECTED_K))
cat(strrep("=", 90), "\n")

set.seed(RANDOM_STATE)
km_final <- kmeans(X_scaled, centers = SELECTED_K, nstart = 10)
df$Cluster <- NA
df$Cluster[as.integer(rownames(X))] <- km_final$cluster
final_silhouette <- mean(silhouette(km_final$cluster, dist(X_scaled))[, "sil_width"])
cat(sprintf("  Silhouette score: %.3f\n", final_silhouette))

# Cluster sizes
sizes <- table(df$Cluster)
for (c_id in names(sizes)) {
    cat(sprintf("  Cluster %s: n = %d (%.1f%%)\n", c_id, sizes[c_id], sizes[c_id] / nrow(df) * 100))
}

# Cluster profiles (z-scores)
cluster_means_raw <- aggregate(. ~ Cluster, data = df[!is.na(df$Cluster), c("Cluster", AIRS16_CONSTRUCTS)], FUN = mean)
cluster_means_z <- cluster_means_raw
for (cn in AIRS16_CONSTRUCTS) {
    cluster_means_z[[cn]] <- (cluster_means_raw[[cn]] - pop_means[cn]) / pop_stds[cn]
}

cat("\n  Z-scored cluster profiles:\n")
print(round(cluster_means_z, 3))

# Cluster naming
CLUSTER_NAMES <- character(SELECTED_K)
for (cid in 1:SELECTED_K) {
    profile <- cluster_means_z[cluster_means_z$Cluster == cid, AIRS16_CONSTRUCTS]
    mean_z <- mean(as.numeric(profile))
    if (mean_z > 0.3) {
        CLUSTER_NAMES[cid] <- "AI Enthusiasts"
    } else if (mean_z < -0.3) {
        CLUSTER_NAMES[cid] <- "AI Skeptics"
    } else {
        CLUSTER_NAMES[cid] <- "Moderate Users"
    }
}
df$Typology <- CLUSTER_NAMES[df$Cluster]

cat("\n  Cluster names:\n")
for (cid in 1:SELECTED_K) {
    n <- sizes[as.character(cid)]
    bi_mean <- mean(df$BI[df$Cluster == cid], na.rm = TRUE)
    cat(sprintf("  %d: %s (n=%d, BI mean=%.2f)\n", cid, CLUSTER_NAMES[cid], n, bi_mean))
}

# ── k=4 Comparison ──────────────────────────────────────────────────────────
cat(sprintf("\n%s\n", strrep("=", 90)))
cat(sprintf("k=%d ALTERNATIVE COMPARISON\n", K_ALT))
cat(strrep("=", 90), "\n")

set.seed(RANDOM_STATE)
km_k4 <- kmeans(X_scaled, centers = K_ALT, nstart = 10)
sil_k4 <- mean(silhouette(km_k4$cluster, dist(X_scaled))[, "sil_width"])
k4_sizes <- table(km_k4$cluster)
cat(sprintf("  k=4 silhouette: %.3f (k=3: %.3f)\n", sil_k4, final_silhouette))
for (c_id in names(k4_sizes)) {
    cat(sprintf("  Cluster %s: n = %d (%.1f%%)\n", c_id, k4_sizes[c_id], k4_sizes[c_id] / nrow(X) * 100))
}

# k=4 z-scored profiles
df_k4 <- df[!is.na(df$Cluster), ]
df_k4$K4_Cluster <- NA
df_k4$K4_Cluster[as.integer(rownames(X))] <- km_k4$cluster
k4_means <- aggregate(. ~ K4_Cluster, data = df_k4[!is.na(df_k4$K4_Cluster), c("K4_Cluster", AIRS16_CONSTRUCTS)], FUN = mean)
k4_means_z <- k4_means
for (cn in AIRS16_CONSTRUCTS) {
    k4_means_z[[cn]] <- (k4_means[[cn]] - pop_means[cn]) / pop_stds[cn]
}
cat("\n  k=4 z-scored profiles:\n")
print(round(k4_means_z, 3))

k4_defensible <- sil_k4 >= 0.25 && min(k4_sizes) >= 50
cat(sprintf(
    "\n  k=4 defensible: %s (sil>=0.25=%s, min_n>=50=%s)\n",
    k4_defensible, sil_k4 >= 0.25, min(k4_sizes) >= 50
))

# ── Predictive Validation ───────────────────────────────────────────────────
cat(sprintf("\n%s\n", strrep("=", 90)))
cat("PREDICTIVE VALIDATION\n")
cat(strrep("=", 90), "\n")

# ANOVA: BI by cluster
groups <- lapply(1:SELECTED_K, function(c) df$BI[df$Cluster == c & !is.na(df$Cluster)])
aov_res <- oneway.test(BI ~ factor(Cluster), data = df[!is.na(df$Cluster), ])
grand_mean <- mean(df$BI, na.rm = TRUE)
ss_between <- sum(sapply(groups, function(g) length(na.omit(g)) * (mean(g, na.rm = TRUE) - grand_mean)^2))
ss_total <- sum((df$BI[!is.na(df$Cluster)] - grand_mean)^2, na.rm = TRUE)
eta_squared <- ss_between / ss_total

effect_interp <- ifelse(eta_squared > 0.14, "large", ifelse(eta_squared > 0.06, "medium", "small"))
cat(sprintf("  ANOVA: F = %.2f, p = %.6f\n", aov_res$statistic, aov_res$p.value))
cat(sprintf("  eta2 = %.3f (%s)\n", eta_squared, effect_interp))

# Regression: AIRS-16 -> BI
X_reg <- df[complete.cases(df[, c(AIRS16_CONSTRUCTS, "BI")]), AIRS16_CONSTRUCTS]
y_reg <- df[rownames(X_reg), "BI"]
reg_fit <- lm(y_reg ~ ., data = X_reg)
r2 <- summary(reg_fit)$r.squared

# 5-fold CV R2
set.seed(RANDOM_STATE)
n <- nrow(X_reg)
folds <- sample(rep(1:5, length.out = n))
cv_r2 <- numeric(5)
for (fold in 1:5) {
    train <- folds != fold
    test <- folds == fold
    fit_cv <- lm(y_reg[train] ~ ., data = X_reg[train, ])
    preds <- predict(fit_cv, newdata = X_reg[test, ])
    ss_res <- sum((y_reg[test] - preds)^2)
    ss_tot <- sum((y_reg[test] - mean(y_reg[test]))^2)
    cv_r2[fold] <- 1 - ss_res / ss_tot
}
cat(sprintf("  Regression R2 = %.3f\n", r2))
cat(sprintf("  5-fold CV R2 = %.3f (+/-%.3f)\n", mean(cv_r2), sd(cv_r2)))

# Cluster-based R2
bi_cluster_mean <- tapply(df$BI[!is.na(df$Cluster)], df$Cluster[!is.na(df$Cluster)], mean)
df$BI_pred_cluster <- bi_cluster_mean[as.character(df$Cluster)]
ss_res_cluster <- sum((df$BI[!is.na(df$Cluster)] - df$BI_pred_cluster[!is.na(df$Cluster)])^2, na.rm = TRUE)
r2_cluster <- 1 - ss_res_cluster / ss_total
cat(sprintf("  Cluster-based R2 = %.3f\n", r2_cluster))

# ── Classification Function Validation ───────────────────────────────────────
# Store centroids for classification
CENTROIDS <- list()
for (cid in 1:SELECTED_K) {
    name <- CLUSTER_NAMES[cid]
    z_scores <- as.list(cluster_means_z[cluster_means_z$Cluster == cid, AIRS16_CONSTRUCTS])
    raw_means <- as.list(cluster_means_raw[cluster_means_raw$Cluster == cid, AIRS16_CONSTRUCTS])
    mask <- !is.na(df$Cluster) & df$Cluster == cid
    CENTROIDS[[name]] <- list(
        cluster_id = cid, z_scores = z_scores, raw_means = raw_means,
        expected_BI = mean(df$BI[mask], na.rm = TRUE),
        n = sum(mask), pct = sum(mask) / nrow(df) * 100
    )
}

classify_typology <- function(scores) {
    z <- (scores - pop_means) / pop_stds
    distances <- sapply(CENTROIDS, function(cd) {
        centroid_z <- unlist(cd$z_scores)
        sqrt(sum((z - centroid_z)^2))
    })
    nearest <- names(which.min(distances))
    list(type = nearest, confidence = 1 / (1 + min(distances)))
}

# Validate reclassification
correct <- 0
valid_rows <- which(!is.na(df$Cluster))
for (idx in valid_rows) {
    scores <- as.numeric(df[idx, AIRS16_CONSTRUCTS])
    names(scores) <- AIRS16_CONSTRUCTS
    pred <- classify_typology(scores)
    if (pred$type == df$Typology[idx]) correct <- correct + 1
}
agreement <- correct / length(valid_rows)
cat(sprintf("\n  Classification validation: %.1f%% agreement\n", agreement * 100))

# ── Success Criteria ─────────────────────────────────────────────────────────
cat(sprintf("\n%s\n", strrep("=", 90)))
cat("SUCCESS CRITERIA\n")
cat(strrep("=", 90), "\n")
cat(sprintf("  Silhouette > 0.25: %s (%.3f)\n", ifelse(final_silhouette > 0.25, "PASS", "FAIL"), final_silhouette))
cat(sprintf("  BI eta2 > 0.14: %s (%.3f)\n", ifelse(eta_squared > 0.14, "PASS", "FAIL"), eta_squared))
cat(sprintf("  Regression R2 > 0.40: %s (%.3f)\n", ifelse(r2 > 0.40, "PASS", "FAIL"), r2))

# ── Export ───────────────────────────────────────────────────────────────────
cat(sprintf("\n%s\n", strrep("=", 90)))
cat("EXPORTING RESULTS\n")
cat(strrep("=", 90), "\n")

results <- list(
    metadata = list(
        notebook = "11_Practitioner_Typology",
        date = as.character(Sys.time()),
        n_samples = nrow(df),
        constructs_used = AIRS16_CONSTRUCTS,
        outcome_variable = OUTCOME
    ),
    clustering = list(
        n_clusters = SELECTED_K,
        silhouette_score = final_silhouette,
        cluster_sizes = as.list(sizes)
    ),
    k4_alternative = list(
        n_clusters = K_ALT,
        silhouette_score = sil_k4,
        cluster_sizes = as.list(k4_sizes),
        defensible = k4_defensible
    ),
    validation = list(
        bi_anova_f = as.numeric(aov_res$statistic),
        bi_anova_p = aov_res$p.value,
        bi_eta_squared = eta_squared,
        regression_r2 = r2,
        regression_cv_r2 = mean(cv_r2),
        cluster_r2 = r2_cluster
    ),
    population_parameters = list(means = as.list(pop_means), stds = as.list(pop_stds)),
    centroids = CENTROIDS,
    cluster_names = as.list(CLUSTER_NAMES)
)

write_json(results, "results/phase11_practitioner_typology_results.json",
    pretty = TRUE, auto_unbox = TRUE
)
cat("Saved results/phase11_practitioner_typology_results.json\n")

cat(sprintf("\n%s\n", strrep("=", 90)))
cat("PHASE 11: PRACTITIONER TYPOLOGY COMPLETE\n")
cat(strrep("=", 90), "\n")
for (name in names(CENTROIDS)) {
    cd <- CENTROIDS[[name]]
    cat(sprintf("  %s: n=%d (%.1f%%), BI=%.2f\n", name, cd$n, cd$pct, cd$expected_BI))
}
