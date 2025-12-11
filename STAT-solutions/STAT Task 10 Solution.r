############################################################
# Author: Jan-Hendrik Schünemann
# Module: STAT
# Task: 10 – Summary Measures and Graphics
# Version: v1.2 (2025-12-11)
# Required Dataset: MovieData.rds
# Required Libraries: dplyr, summarytools, ggplot2, abdiv, plotly
############################################################

library(dplyr)
library(summarytools)
library(ggplot2)
library(abdiv)
library(plotly)

df <- readRDS("MovieData.rds")

############################################################
### 1. DECopiesW1 – Number of copies in Week 1 (metric)
###    Two options: Quick & Dirty OR Preferred
############################################################

### A) QUICK & DIRTY VERSION (Base R)
summary(df$DECopiesW1)

boxplot(df$DECopiesW1,
        main = "Boxplot of Copies in Germany (Week 1)",
        ylab = "Copies (Week 1)",
        col = "lightblue")

### B) PREFERRED VERSION (Manual summary + ggplot)

# Extended 5-Number Summary and Skewness Calculation (can also be done outside of the summarize function)

df %>%
  summarize(
    Min    = min(DECopiesW1, na.rm = TRUE),
    Q1     = quantile(DECopiesW1, 0.25, type = 2, na.rm = TRUE),
    Median = median(DECopiesW1, na.rm = TRUE),
    Q3     = quantile(DECopiesW1, 0.75, type = 2, na.rm = TRUE),
    Max    = max(DECopiesW1, na.rm = TRUE),
    Mean   = mean(DECopiesW1, na.rm = TRUE),
    SD     = sd(DECopiesW1, na.rm = TRUE),
    Skew   = (3 * (mean(DECopiesW1) - median(DECopiesW1))) / sd(DECopiesW1)
  )

ggplot(df, aes(y = DECopiesW1)) +
  stat_boxplot(geom = "errorbar", width = 0.4) +
  geom_boxplot(fill = "skyblue", width = 0.6) +
  labs(
    title = "Boxplot of Copies in Germany (Week 1)",
    y = "Copies (Week 1)"
  ) +
  theme_minimal()


############################################################
### 2. COMP_INT – Competition Intensity (categorical)
############################################################

freq(df$COMP_INT)

ggplot(df, aes(x = COMP_INT)) +
  geom_bar(fill = "steelblue") +
  labs(
    title = "Competition Intensity (Distribution)",
    x = "Competition Intensity Rating",
    y = "Count"
  ) +
  theme_minimal()

# Simpson Diversity Index
comp_counts <- as.numeric(table(df$COMP_INT))
divindex_comp_int <- simpson(comp_counts) * (length(comp_counts) / (length(comp_counts) - 1))
divindex_comp_int


############################################################
### 3. CIN_TIP – cinema.de editor recommendation (categorical)
############################################################

freq(df$CIN_TIP)

plot_ly(
  data = df,
  labels = ~CIN_TIP,
  type = "pie"
) %>%
  layout(
    title = "cinema.de – Tip Rating"
  )

# Diversity Index
tip_counts <- as.numeric(table(df$CIN_TIP))
divindex_cin_tip <- simpson(tip_counts) * (length(tip_counts) / (length(tip_counts) - 1))
divindex_cin_tip
