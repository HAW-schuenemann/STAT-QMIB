############################################################
# Author: Jan-Hendrik Schünemann
# Module: STAT
# Task: 14 – Grouped Summary Measures
# Version: v1.0 (2025-12-11)
# Required Dataset: MovieData.rds
# Required Libraries: dplyr, kableExtra
############################################################

library(dplyr)
library(kableExtra)

df <- readRDS("MovieData.rds")

############################################################
### IMPORTANT:
### For grouped summaries we:
### • group_by() the categorical variable
### • compute the five-number summary + mean + SD
### • use quantile(type = 2) to match the n+1 rule from class
### • interpret differences between groups
############################################################


############################################################
### 1. DEVisitorsW1 grouped by CIN_TIP
###    → Do visitor numbers differ depending on the tip level?
############################################################

df %>%
  group_by(CIN_TIP) %>%
  summarise(
    Min    = min(DEVisitorsW1, na.rm = TRUE),
    Q1     = quantile(DEVisitorsW1, 0.25, type = 2, na.rm = TRUE),
    Median = median(DEVisitorsW1, na.rm = TRUE),
    Q3     = quantile(DEVisitorsW1, 0.75, type = 2, na.rm = TRUE),
    Max    = max(DEVisitorsW1, na.rm = TRUE),
    Mean   = mean(DEVisitorsW1, na.rm = TRUE),
    SD     = sd(DEVisitorsW1, na.rm = TRUE),
    Count  = n()
  ) %>%
  kable()

# Interpretation hint:
# Compare Median and Mean across CIN_TIP groups.
# Larger differences imply that tip levels relate to visitor numbers.


############################################################
### 2. BUDGET grouped by BOOK
###    → Does budget differ depending on whether a film is based on a book?
###
### Note: BOOK is an ordered factor. Using group_by(BOOK) is correct.
############################################################

df %>%
  group_by(BOOK) %>%
  summarise(
    Min    = min(BUDGET, na.rm = TRUE),
    Q1     = quantile(BUDGET, 0.25, type = 2, na.rm = TRUE),
    Median = median(BUDGET, na.rm = TRUE),
    Q3     = quantile(BUDGET, 0.75, type = 2, na.rm = TRUE),
    Max    = max(BUDGET, na.rm = TRUE),
    Mean   = mean(BUDGET, na.rm = TRUE),
    SD     = sd(BUDGET, na.rm = TRUE),
    Count  = n()
  ) %>%
  kable()

# Interpretation hint:
# If book-based films systematically show higher/lower values,
# a potential relationship between BOOK and BUDGET can be assumed.


############################################################
### 3. USCopiesW1 grouped by SEQUEL
###    → Do films in a series have different US copy numbers?
############################################################

df %>%
  group_by(SEQUEL) %>%
  summarise(
    Min    = min(USCopiesW1, na.rm = TRUE),
    Q1     = quantile(USCopiesW1, 0.25, type = 2, na.rm = TRUE),
    Median = median(USCopiesW1, na.rm = TRUE),
    Q3     = quantile(USCopiesW1, 0.75, type = 2, na.rm = TRUE),
    Max    = max(USCopiesW1, na.rm = TRUE),
    Mean   = mean(USCopiesW1, na.rm = TRUE),
    SD     = sd(USCopiesW1, na.rm = TRUE),
    Count  = n()
  ) %>%
  kable()

# Interpretation hint:
# Compare Medians. If series films consistently have higher/lower values,
# this may indicate a relationship between SEQUEL and USCopiesW1.

############################################################
### General Interpretation Notes
###
### • For each comparison, look primarily at:
###     Median (robust to outliers)
###     Mean (sensitive to extreme values)
###     SD (spread within each group)
###
### • Clear differences across groups suggest a potential relationship.
###
### • If summaries look similar, no strong relationship is assumed.
############################################################
