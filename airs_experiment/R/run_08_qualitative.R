#!/usr/bin/env Rscript
# ==============================================================================
# AIRS Phase 8: Qualitative Feedback Analysis (RQ11-12)
# R port of run_08_qualitative.py
#
# Theme detection via keyword matching on Open_Feedback.
# 3-group chi-square: Role Type x Theme.
# Outputs: results/phase8_qualitative_results.json, 2 plots
# ==============================================================================

library(jsonlite)

cat(strrep("=", 90), "\n")
cat("PHASE 8: QUALITATIVE FEEDBACK ANALYSIS\n")
cat(strrep("=", 90), "\n")

dir.create("results", showWarnings = FALSE)
dir.create("plots", showWarnings = FALSE)

# ── Configuration ─────────────────────────────────────────────────────────────
MIN_RESPONSE_LENGTH <- 10

THEME_KEYWORDS <- list(
    "Positive Experience"   = c("enjoy", "love", "great", "helpful", "useful", "good", "like", "amazing", "excellent", "wonderful", "beneficial"),
    "Concerns/Caution"      = c("concern", "worry", "careful", "caution", "risk", "afraid", "fear", "dangerous"),
    "Accuracy/Reliability"  = c("accurate", "accuracy", "reliable", "reliability", "trust", "correct", "wrong", "error", "mistake", "inaccurate"),
    "Learning/Education"    = c("learn", "study", "school", "education", "research", "student", "homework", "class"),
    "Work/Productivity"     = c("work", "job", "task", "productivity", "efficient", "time", "fast", "quick"),
    "Ethics/Privacy"        = c("ethic", "privacy", "data", "security", "moral", "honest", "integrity"),
    "Future/Potential"      = c("future", "potential", "evolving", "improve", "develop", "growing", "progress"),
    "Cost/Access"           = c("cost", "free", "pay", "expensive", "access", "available", "subscription"),
    "Job Replacement"       = c("replace", "job", "employment", "automate", "obsolete", "take over"),
    "Human Element"         = c("human", "people", "personal", "creative", "think", "critical")
)

classify_role <- function(rc) {
    ifelse(is.na(rc), "Professional",
        ifelse(rc %in% c("FT_Student", "PT_Student"), "Academic",
            ifelse(rc %in% c("Manager", "Executive"), "Leader", "Professional")
        )
    )
}

identify_themes <- function(text) {
    if (is.na(text) || !is.character(text)) {
        return(character(0))
    }
    tl <- tolower(text)
    found <- character(0)
    for (theme in names(THEME_KEYWORDS)) {
        if (any(grepl(paste(THEME_KEYWORDS[[theme]], collapse = "|"), tl, fixed = FALSE))) {
            found <- c(found, theme)
        }
    }
    found
}

# ── Load Data ─────────────────────────────────────────────────────────────────
df_efa <- read.csv("data/AIRS_experiment.csv", stringsAsFactors = FALSE)
df_cfa <- read.csv("data/AIRS_holdout.csv", stringsAsFactors = FALSE)
df <- rbind(df_efa, df_cfa)
cat(sprintf("Combined sample N = %d\n", nrow(df)))

df$Role_Type <- classify_role(df$Role_Category)

# Filter to substantive responses
has_feedback <- !is.na(df$Open_Feedback) & nchar(trimws(as.character(df$Open_Feedback))) >= MIN_RESPONSE_LENGTH
df_sub <- df[has_feedback, ]
df_sub$feedback_text <- trimws(as.character(df_sub$Open_Feedback))
df_sub$response_length <- nchar(df_sub$feedback_text)
df_sub$word_count <- sapply(strsplit(df_sub$feedback_text, "\\s+"), length)

cat(sprintf("Responses with feedback: %d\n", sum(!is.na(df$Open_Feedback))))
cat(sprintf("Substantive (>=%d chars): %d\n", MIN_RESPONSE_LENGTH, nrow(df_sub)))
cat(sprintf(
    "Mean length: %.0f chars, %.1f words\n",
    mean(df_sub$response_length), mean(df_sub$word_count)
))

# ══════════════════════════════════════════════════════════════════════════════
# Theme Detection
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("THEME ANALYSIS\n")
cat(strrep("=", 70), "\n")

df_sub$themes <- lapply(df_sub$feedback_text, identify_themes)

theme_counter <- table(unlist(df_sub$themes))
theme_counter <- sort(theme_counter, decreasing = TRUE)
n_sub <- nrow(df_sub)

theme_freq <- list()
cat(sprintf("\nTheme frequencies (N=%d):\n", n_sub))
for (theme in names(theme_counter)) {
    cnt <- as.integer(theme_counter[theme])
    pct <- cnt / n_sub * 100
    theme_freq[[theme]] <- list(count = cnt, pct = round(pct, 1))
    cat(sprintf("  %s: %d (%.1f%%)\n", theme, cnt, pct))
}

# Exemplar quotes (top 5 themes, up to 3 each)
exemplars <- list()
top5 <- names(theme_counter)[1:min(5, length(theme_counter))]
for (theme in top5) {
    mask <- sapply(df_sub$themes, function(t) theme %in% t)
    samples <- head(df_sub$feedback_text[mask], 3)
    exemplars[[theme]] <- samples
    cat(sprintf("\n  Exemplars - %s:\n", theme))
    for (s in samples) {
        display <- if (nchar(s) > 120) paste0(substr(s, 1, 120), "...") else s
        cat(sprintf("    \"%s\"\n", display))
    }
}

# Theme distribution plot
png("plots/08_theme_distribution.png", width = 1200, height = 800, res = 150)
par(mar = c(5, 14, 3, 2))
barplot(rev(as.numeric(theme_counter)),
    names.arg = rev(names(theme_counter)),
    horiz = TRUE, las = 1, col = "steelblue", cex.names = 0.7,
    xlab = "Number of Responses",
    main = sprintf("Qualitative Theme Distribution (N=%d)", n_sub)
)
dev.off()
cat("\nSaved plots/08_theme_distribution.png\n")

# ══════════════════════════════════════════════════════════════════════════════
# 3-group Chi-Square: Role Type x Theme
# ══════════════════════════════════════════════════════════════════════════════
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("3-GROUP CHI-SQUARE: ROLE TYPE x THEME\n")
cat(strrep("=", 70), "\n")

group_results <- list()
for (theme in names(THEME_KEYWORDS)) {
    df_sub[[paste0("has_", theme)]] <- sapply(df_sub$themes, function(t) theme %in% t)
    tbl <- table(df_sub$Role_Type, df_sub[[paste0("has_", theme)]])
    if (ncol(tbl) == 2 && nrow(tbl) >= 2) {
        ct <- tryCatch(chisq.test(tbl), error = function(e) NULL)
        if (!is.null(ct)) {
            n_obs <- sum(tbl)
            min_dim <- min(dim(tbl)) - 1
            cramers_v <- sqrt(ct$statistic / (n_obs * min_dim))
            group_results[[theme]] <- list(
                chi2 = as.numeric(ct$statistic), p = ct$p.value,
                dof = ct$parameter, cramers_v = as.numeric(cramers_v),
                significant = ct$p.value < 0.05
            )
            sig <- ifelse(ct$p.value < 0.05, "*", "")
            cat(sprintf(
                "  %s: chi2=%.2f, p=%.3f, V=%.3f %s\n",
                theme, ct$statistic, ct$p.value, cramers_v, sig
            ))
        }
    }
}

# Role x theme comparison plot
png("plots/08_role_type_theme_comparison.png", width = 1400, height = 700, res = 150)
roles <- sort(unique(df_sub$Role_Type))
theme_names <- names(THEME_KEYWORDS)
pct_mat <- matrix(NA,
    nrow = length(roles), ncol = length(theme_names),
    dimnames = list(roles, theme_names)
)
for (i in seq_along(roles)) {
    sub <- df_sub[df_sub$Role_Type == roles[i], ]
    for (j in seq_along(theme_names)) {
        mask <- sapply(sub$themes, function(t) theme_names[j] %in% t)
        pct_mat[i, j] <- mean(mask) * 100
    }
}
par(mar = c(10, 5, 3, 8))
barplot(pct_mat,
    beside = TRUE, col = rainbow(length(roles)),
    las = 2, cex.names = 0.65, ylab = "% Mentioning Theme",
    main = "Qualitative Theme Prevalence by Role Type"
)
legend("topright", legend = roles, fill = rainbow(length(roles)), cex = 0.7)
dev.off()
cat("Saved plots/08_role_type_theme_comparison.png\n")

# ── Export ────────────────────────────────────────────────────────────────────
cat(sprintf("\n%s\n", strrep("=", 70)))
cat("EXPORT\n")
cat(strrep("=", 70), "\n")

results <- list(
    sample = list(
        total_n = nrow(df),
        feedback_responses = sum(!is.na(df$Open_Feedback)),
        substantive_responses = n_sub,
        response_rate_percent = round(sum(!is.na(df$Open_Feedback)) / nrow(df) * 100, 1)
    ),
    theme_keywords = THEME_KEYWORDS,
    rq11_themes = list(
        n_themes = length(THEME_KEYWORDS),
        theme_frequencies = lapply(theme_freq, function(x) x$pct)
    ),
    rq12_group_comparison = group_results,
    key_findings = list(
        most_common_theme = names(theme_counter)[1],
        significant_differences = names(Filter(function(x) x$significant, group_results))
    )
)

write_json(results, "results/phase8_qualitative_results.json",
    pretty = TRUE, auto_unbox = TRUE
)
cat("Saved results/phase8_qualitative_results.json\n")

cat("\nPhase 8 complete.\n")
