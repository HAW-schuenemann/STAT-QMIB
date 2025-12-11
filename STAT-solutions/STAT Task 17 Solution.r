############################################################
# Author: Jan-Hendrik Schünemann
# Module: STAT
# Task: 17 – Measures of Association (Mixed Variable Types)
# Version: v1.0 (2025-12-11)
# Required Dataset: MovieData.rds
# Required Libraries: vcd
############################################################

library(vcd)

df <- readRDS("MovieData.rds")

############################################################
### REMINDER:
### • Metric + Metric → Pearson + Spearman (10% rule)
### • Metric + Binary categorical → Point–biserial (Pearson with as.numeric)
### • Categorical + Categorical → Cramer's V + normed contingency coefficient
###
### 10% RULE (from script):
### If |Pearson - Spearman| ≤ 10% of |Pearson| → linear → use Pearson.
### If deviation > 10% → monotonic → use Spearman.
############################################################



############################################################
### 1. DEVisitorsW1 (metric) vs USSalesW1 (metric)
############################################################

p1 <- cor(df$DEVisitorsW1, df$USSalesW1, use = "complete.obs", method = "pearson")
s1 <- cor(df$DEVisitorsW1, df$USSalesW1, use = "complete.obs", method = "spearman")

p1
s1
abs(p1 - s1) / abs(p1)   # 10% rule check

### Interpretation:
# Pearson ~ 0.76, Spearman ~ 0.74 → deviation ~2.7% < 10%
# → Strong positive linear relationship.
# → Use Pearson.



############################################################
### 2. SEQUEL (categorical) vs USSTART (categorical)
############################################################

ct2 <- table(df$SEQUEL, df$USSTART)
assoc2 <- assocstats(ct2)

assoc2$cramer                # Cramer's V
assoc2$cont                  # raw contingency coefficient
assoc2$cont / sqrt(1/2)      # normalised C (course standard)

### Interpretation:
# Cramer's V ≈ 0.17, C_norm ≈ 0.24 → weak association.
# Sequels are slightly more likely to start in the US, but not strongly.



############################################################
### 3. STARPOWER (metric) vs DEVisitorsW1 (metric)
############################################################

p3 <- cor(df$STARPOWER, df$DEVisitorsW1, use = "complete.obs", method = "pearson")
s3 <- cor(df$STARPOWER, df$DEVisitorsW1, use = "complete.obs", method = "spearman")

p3
s3
abs(p3 - s3) / abs(p3)   # deviation check

### Interpretation:
# Pearson ~ 0.42, Spearman ~ 0.66 → deviation ~36% > 10%
# → Relationship is monotonic but not linear.
# → Use Spearman.
# Strength: medium positive monotonic association.



############################################################
### 4. USSalesW1 (metric) vs SEQUEL (binary categorical)
###    Measure: Point–Biserial Correlation
############################################################

# as.numeric(SEQUEL) converts factor levels to 1/2 → point–biserial
cor(df$USSalesW1, as.numeric(df$SEQUEL), use = "complete.obs", method = "pearson")

### Interpretation:
# Medium positive relationship:
# Sequels tend to have higher US sales in Week 1.



############################################################
### 5. BUDGET (metric) vs DECopiesW1 (metric)
############################################################

p5 <- cor(df$BUDGET, df$DECopiesW1, use = "complete.obs", method = "pearson")
s5 <- cor(df$BUDGET, df$DECopiesW1, use = "complete.obs", method = "spearman")

p5
s5
abs(p5 - s5) / abs(p5)   # deviation check

### Interpretation:
# Pearson ~ 0.71, Spearman ~ 0.73 → deviation ~3.3% < 10%
# → Strong positive linear relationship.
# → Use Pearson.



############################################################
### 6. STARPOWER (metric) vs USSTART (binary categorical)
###    Measure: Point–Biserial Correlation
############################################################

cor(df$STARPOWER, as.numeric(df$USSTART), use = "complete.obs", method = "pearson")

### Interpretation:
# Medium positive point–biserial correlation.
# Films with higher star power are more likely to start in the US.
############################################################
