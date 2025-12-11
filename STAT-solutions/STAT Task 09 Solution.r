############################################################
# Author: Jan-Hendrik Schünemann
# Module: STAT
# Task: 9 – Classification of BUDGET into 4 Classes
# Version: v1.0 (2025-12-11)
# Required Dataset: MovieData.rds
# Required Libraries: dplyr, summarytools, ggplot2
############################################################

library(dplyr)
library(summarytools)
library(ggplot2)

df <- readRDS("MovieData.rds")

############################################################
### Classification Rules:
### 0–1 million                → Class_1
### >1–10 million              → Class_2
### >10–100 million            → Class_3
### >100 million               → Class_4
###
### We recode these categories with case_when() and then convert
### them into a factor for clean output and easier interpretation.
############################################################

df <- df %>% 
  mutate(
    BUDGET_classified = case_when(
      BUDGET >=        0  & BUDGET <     1000000 ~ 1,
      BUDGET >=  1000000  & BUDGET <    10000000 ~ 2,
      BUDGET >= 10000000  & BUDGET <   100000000 ~ 3,
      BUDGET >=100000000                         ~ 4
    )
  )

df$BUDGET_classified <- factor(
  df$BUDGET_classified,
  levels = c(1, 2, 3, 4),
  labels = c("Class_1", "Class_2", "Class_3", "Class_4")
)

############################################################
### Frequency table for the classified variable
############################################################

freq(df$BUDGET_classified)

############################################################
### Quality Check: Cumulative Relative Frequency Plot
###
### We use cume_dist() to compute cumulative proportions and color
### by the new budget classes. This shows:
###   • whether classes align with the distribution,
###   • where large jumps or clustering occur.
############################################################

df %>% 
  mutate(cum_rel = cume_dist(BUDGET) * 100) %>% 
  ggplot(aes(x = BUDGET, y = cum_rel, color = BUDGET_classified)) +
  geom_point() +
  labs(
    title = "Cumulative Relative Frequency Curve of BUDGET Colored by Budget Class",
    x = "Budget",
    y = "Cumulative %"
  ) +
  theme_minimal()
