############################################################
# Author: Jan-Hendrik Schünemann
# Module: STAT
# Task: 13 – Two-Way Frequency Table (SEQUEL × MIN_class)
# Version: v1.1 (2025-12-11)
# Required Dataset: MovieData.rds
# Required Libraries: gmodels, summarytools, dplyr
############################################################

library(gmodels)
library(summarytools)
library(dplyr)

df <- readRDS("MovieData.rds")

############################################################
### STEP 1 — Two-way frequency table
############################################################

table_2way <- table(df$SEQUEL, df$MIN_class)
table_2way


############################################################
### STEP 2 — CrossTable with row %, column %, total %
###
### HOW TO READ THE CROSSTABLE (IMPORTANT FOR THE QUESTIONS)
###
### Each cell in the CrossTable shows FOUR numbers:
###
###  ┌─────────────────────────────────────────────────────┐
###  │  N                  = absolute frequency            │
###  │  N / Row Total      = row percentage                │
###  │  N / Column Total   = column percentage             │
###  │  N / Table Total    = percentage of entire dataset  │
###  └─────────────────────────────────────────────────────┘
###
### Example from the table:
###
###   Not part of series & normal length  → 478
###
### The four numbers printed are:
###   478        (absolute count)
###   0.666      (66.6% of all non-series films are normal length)
###   0.925      (92.5% of ALL normal-length films are NOT part of a series)
###   0.598      (59.8% of ALL FILMS are in this cell)
###
### QUICK READING TIPS:
###
### • If the question is about a COUNT → use the FIRST number (N).
### • If the question is about “% of a column” → use N / Column Total.
### • If the question is about “% of a row” → use N / Row Total.
### • If the question is “% of all films” → use N / Table Total.
###
### This makes answering the task questions MUCH easier and avoids
### calculating things manually.
############################################################

CrossTable(
  df$SEQUEL,
  df$MIN_class,
  prop.r   = TRUE,
  prop.c   = TRUE,
  prop.t   = TRUE,
  prop.chisq = FALSE
)


############################################################
### STEP 3 — Answering the Questions
############################################################

# Extract counts from the table:
short_not   <- 136
normal_not  <- 478
extra_not   <- 104

short_yes   <- 24
normal_yes  <- 39
extra_yes   <- 19

total_films <- 800
total_series <- short_yes + normal_yes + extra_yes


### 1. How many films are part of a series AND have extra length?
answer_1 <- extra_yes
answer_1   # 19


### 2. What percentage of normal-length films are NOT part of a series?
percent_normal_not <- normal_not / (normal_not + normal_yes) * 100
percent_normal_not   # 92.47%


### 3. What percentage of ALL films are short-length AND part of a series?
percent_short_yes <- short_yes / total_films * 100
percent_short_yes   # 3.00% (using CrossTable rounding: 0.030)


### 4. What percentage of series films have normal length?
percent_normal_among_series <- normal_yes / total_series * 100
percent_normal_among_series   # 46.43%


############################################################
### Interpretation Notes
###
### • The table structure (row %, column %, total %) helps answer 
###   questions without manual math.
###
### • Most normal-length films (92.5%) are NOT part of a series.
### • Only 3% of all films are both short AND part of a series.
### • Among series films, normal length is the largest group (≈46%).
############################################################
