############################################################
# Author: Jan-Hendrik Schünemann
# Module: STAT
# Task: 7 – Recoding: Comparison of Copies (Germany vs USA)
# Version: v1.0 (YYYY-MM-DD)
# Required Dataset: MovieData.rds
# Required Libraries: dplyr, summarytools
############################################################

library(dplyr)
library(summarytools)

df <- readRDS("MovieData.rds")

############################################################
### Note:
### We overwrite df here because we add a NEW variable (CopiesCOMP)
### that will be used for the frequency analysis and can be reused
### in later tasks.
############################################################


############################################################
### Create CopiesCOMP
###
### Category 1: DECopiesW1 <= USCopiesW1
### Category 2: DECopiesW1 >  USCopiesW1
############################################################

df <- df %>%
  mutate(
    CopiesCOMP = case_when(
      DECopiesW1 <= USCopiesW1 ~ 1,
      DECopiesW1 >  USCopiesW1 ~ 2
    )
  )

# Frequency table of the new variable
freq(df$CopiesCOMP)

############################################################
### Interpretation Guidance:
###
### The "% Valid" column shows the proportion of films where:
###   1 = Germany Week 1 copies ≤ USA Week 1 copies
###   2 = Germany Week 1 copies  > USA Week 1 copies
###
### Interpret which market performs stronger in the first week based on
### the majority category.
############################################################
