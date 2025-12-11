############################################################
# Author: Jan-Hendrik Schünemann
# Module: STAT
# Task: 4 – Cumulative Relative Frequencies & Success Measures
# Version: v1.0 (YYYY-MM-DD)
# Required Dataset: MovieData.rds
# Required Libraries: dplyr, ggplot2
############################################################

## 1. Load required packages --------------------------------------------------

# install.packages("dplyr")
# install.packages("ggplot2")

library(dplyr)
library(ggplot2)

## 2. Load dataset ------------------------------------------------------------
df <- readRDS("MovieData.rds")

############################################################
### Part (a)
### Cumulative relative frequency curve for DECopiesW1
############################################################

df %>%
  mutate(cum_rel = cume_dist(DECopiesW1) * 100) %>%
  ggplot(aes(x = DECopiesW1, y = cum_rel)) +
  geom_point() +
  labs(
    title = "Cumulative Relative Frequency Curve\nCopies in Germany (Week 1)",
    x = "Copies in Germany (Week 1)",
    y = "Cumulative relative frequency (%)"
  ) +
  theme_minimal()

############################################################
### Part (b)
### Create 4-week success variables
############################################################

## Important note on using `.` inside select():
##
## Inside a pipe, `.` refers to “the current data frame”.
## Example:
##   df %>% select(DECopiesW1)
## is equivalent to
##   select(df, DECopiesW1)
##
## For functions like rowSums(), we need select() to extract several columns.
## Using `select(., ...)` means: "select these columns from the data frame that
## is currently flowing through the pipe".
##
## You *can* also write:
##   select(df, DECopiesW1, ...)
## This works the same way, but `.` is more consistent when using pipes.

## 1. Sum of copies in Germany (Weeks 1–4)
df <- df %>%
  mutate(
    SumDECopies04 = rowSums(
      select(., DECopiesW1, DECopiesW2, DECopiesW3, DECopiesW4),
      na.rm = TRUE
    )
  )

## 2. Sum of copies in USA (Weeks 1–4)
df <- df %>%
  mutate(
    SumUSCopies04 = rowSums(
      select(., USCopiesW1, USCopiesW2, USCopiesW3, USCopiesW4),
      na.rm = TRUE
    )
  )

## 3. Total number of visitors in Germany (Weeks 1–4)
df <- df %>%
  mutate(
    SumDEVisitors04 = rowSums(
      select(., DEVisitorsW1, DEVisitorsW2, DEVisitorsW3, DEVisitorsW4),
      na.rm = TRUE
    )
  )

## Optional cumulative curve for SumDEVisitors04
df %>%
  mutate(cum_rel = cume_dist(SumDEVisitors04) * 100) %>%
  ggplot(aes(x = SumDEVisitors04, y = cum_rel)) +
  geom_point() +
  labs(
    title = "Cumulative Relative Frequency\nVisitors in Germany (Weeks 1–4)",
    x = "Total visitors (Weeks 1–4)",
    y = "Cumulative relative frequency (%)"
  ) +
  theme_minimal()

############################################################
### Interpretation Guidance
############################################################

# Part (a):
# - Does the curve increase quickly or slowly?
# - Are most films low-copy or high-copy in Week 1?

# Part (b):
# - Explain each 4-week success variable.
# - Compare patterns between Germany and the USA.
