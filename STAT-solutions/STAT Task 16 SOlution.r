############################################################
# Author: Jan-Hendrik Schünemann
# Module: STAT
# Task: 16 – Measures of Association
# Version: v1.4 (2025-12-11)
# Required Dataset: MovieData.rds
# Required Libraries: vcd
############################################################

library(vcd)

df <- readRDS("MovieData.rds")


############################################################
### 1. DEVisitorsW1 (metric) vs CIN_TIP (binary factor)
###    Measure: Point–Biserial Correlation
############################################################

# CIN_TIP is a factor with 2 levels.
# Pearson correlation requires numeric input.
#
# as.numeric() converts factor levels into:
#     1 = first level
#     2 = second level
#
# This produces the point–biserial correlation, the correct
# measure when correlating a metric variable with a binary
# categorical variable.

cor(df$DEVisitorsW1, as.numeric(df$CIN_TIP),
    use = "complete.obs", method = "pearson")

### Interpretation:
# • Sign → direction of relationship
# • Magnitude → strength
# • Only valid because CIN_TIP is binary.


############################################################
### 2. BOOK (categorical) vs CIN_TIP (categorical)
###    Measures: Cramer's V + Normalised Contingency Coefficient
############################################################

ct_book <- table(df$BOOK, df$CIN_TIP)
assoc_book <- assocstats(ct_book)

# Cramer's V (strength 0–1)
assoc_book$cramer

# Contingency Coefficient C (raw, NOT normed)
assoc_book$cont

# Normalisation of the contingency coefficient
# ----------------------------------------------
# The raw contingency coefficient C does not range from 0–1.
# Its theoretical maximum depends on table dimension:
#
#   C_max = sqrt( (min(r, c) - 1) / min(r, c) )
#
# where r = number of rows, c = number of columns.
#
# For BOOK × CIN_TIP:
#   r = 2, c = 2 → min = 2
#
# Thus:
#   C_max = sqrt( (2 - 1) / 2 ) = sqrt(1/2)
#
# Normalised coefficient:
#   C_norm = C / C_max
#
assoc_book$cont / sqrt(1/2)

### Interpretation:
# • Use Cramer's V or C_norm to describe strength.
# • No direction for nominal variables.


############################################################
### 3. CIN_CRITIC (ordinal) vs CIN_TIP (categorical)
###    Measures: Cramer's V + Normalised Contingency Coefficient
############################################################

ct_critic <- table(df$CIN_CRITIC, df$CIN_TIP)
assoc_critic <- assocstats(ct_critic)

assoc_critic$cramer
assoc_critic$cont
assoc_critic$cont / sqrt(1/2)

### Interpretation:
# • Higher critic ratings generally show higher proportions of CIN_TIP = "yes".
# • Strength only, no direction.


############################################################
### 4. STARPOWER (metric) vs SUCCESS (metric)
###    Measures: Pearson & Spearman Correlation
############################################################

pearson_correlation <- cor(df$STARPOWER, df$SUCCESS,
                           use = "complete.obs", method = "pearson")

spearman_correlation <- cor(df$STARPOWER, df$SUCCESS,
                            use = "complete.obs", method = "spearman")

pearson_correlation
spearman_correlation


############################################################
### OFFICIAL SCRIPT RULE: Pearson vs Spearman
###
### Step 1: Compute absolute deviation (% difference)
###
### Step 2: Apply rule:
###
###   • If absolute deviation ≤ 10%
###        → assume linear relationship
###        → interpret ONLY the Pearson correlation
###
###   • If absolute deviation > 10%
###        → assume monotonic (non-linear) relationship
###        → interpret ONLY the Spearman correlation
###
### Formula:
###     deviation_ratio = |Pearson - Spearman| / |Pearson|
############################################################

deviation_ratio <- abs(pearson_correlation - spearman_correlation) / abs(pearson_correlation)
deviation_ratio

### Interpretation:
# If deviation_ratio ≤ 0.10 → Pearson is used
# If deviation_ratio > 0.10 → Spearman is used
