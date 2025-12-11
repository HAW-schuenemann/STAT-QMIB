############################################################
# Author: Jan-Hendrik Schünemann
# Module: STAT
# Task: 6 – Recoding Variables and Frequency Analysis
# Version: v1.1 (YYYY-MM-DD)
# Required Dataset: MovieData.rds
# Required Libraries: dplyr, summarytools
############################################################

library(dplyr)
library(summarytools)

df <- readRDS("MovieData.rds")

############################################################
### Note on overwriting df in this task:
###
### In earlier tasks, we only used temporary filters (df %>% filter(...))
### and did NOT modify the dataset.
###
### In Task 6 we CREATE NEW VARIABLES:
###   - RATING
###   - DE_WEEK1_VIS
###   - STARPOWER_CAT
###
### These new variables are:
###   • needed for the frequency analyses
###   • useful for later tasks
###   • part of the extended dataset structure
###
### Overwriting df is appropriate here because:
###   1. We are intentionally extending the dataset.
###   2. The new variables remain available for all future analyses.
###   3. It keeps the dataset self-contained and avoids repetitive mutate() calls.
###
### Overwriting is NOT recommended for temporary filters, but it IS useful
### when permanently adding new columns.
############################################################


############################################################
### Part 1
### Percentage of films rated 2 or better vs. 3 or worse
############################################################

df <- df %>%
  mutate(
    RATING = case_when(
      CIN_CRITIC <= 2 ~ "Rated 2 or better",
      CIN_CRITIC >= 3 ~ "Rated 3 or worse"
    )
  )

freq(df$RATING)


############################################################
### Part 2
### Percentage of films with:
###   - ≥ 500,000 visitors in Week 1 (Germany)
###   - < 500,000 visitors
############################################################

df <- df %>%
  mutate(
    DE_WEEK1_VIS = case_when(
      DEVisitorsW1 >= 500000 ~ "≥ 500,000 visitors",
      DEVisitorsW1 < 500000  ~ "< 500,000 visitors"
    )
  )

freq(df$DE_WEEK1_VIS)


############################################################
### Part 3
### Percentage of films with:
###   - STARPOWER ≥ 65 points
###   - STARPOWER < 65 points
############################################################

df <- df %>%
  mutate(
    STARPOWER_CAT = case_when(
      STARPOWER >= 65 ~ "≥ 65 points",
      STARPOWER <  65 ~ "< 65 points"
    )
  )

freq(df$STARPOWER_CAT)
