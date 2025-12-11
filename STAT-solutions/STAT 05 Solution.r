############################################################
# Author: Jan-Hendrik Schünemann
# Module: STAT
# Task: 5 – Frequency Analyses with Filters and Grouping
# Version: v1.2 (2025-12-11)
# Required Dataset: MovieData.rds
# Required Libraries: summarytools, dplyr
############################################################

library(summarytools)
library(dplyr)

df <- readRDS("MovieData.rds")

############################################################
### Important Note on Filtering Factor Variables
###
### Many variables (BOOK, GENRE, FSK, CIN_CRITIC …) are stored as factors
### with numeric codes underneath and labels attached on top.
###
### Example for BOOK:
###   Code 1 = Not based on an original book
###   Code 2 = Based on an original book
###
### You can filter in two valid ways:
###
### (A) By label (may vary in wording):
###       filter(BOOK == "Based on an original book")
###
### (B) By code using as.numeric():
###       filter(as.numeric(BOOK) == 2)
###
### Why numeric filtering is often safer:
###   - avoids typos in long labels
###   - works even if label wording changes
###   - cleaner code in pipes
###
### Important:
###       filter(BOOK == 2)
### does NOT work, because factor == number compares a label (text)
### to a number → always FALSE.
###
### Summary:
###   filter(BOOK == "label")           → OK
###   filter(as.numeric(BOOK) == code)  → OK
###   filter(BOOK == 2)                 → NOT OK
############################################################


############################################################
### Part (a)
### What percentage of films based on a book template are horror films?
############################################################

df %>%
  filter(as.numeric(BOOK) == 2) %>%  # 2 = Based on an original book
  freq(GENRE)

# Interpretation:
# Look at the "% Valid" column to see the percentage of Horror films
# among all book-based films.


############################################################
### Part (b)
### What percentage of all horror films are based on a book?
############################################################

df %>%
  filter(GENRE == "Horror") %>%      # Here we show label filtering
  freq(BOOK)

# "% Valid" gives the share of Horror films that are based on a book.


############################################################
### Part (c)
### FSK = 6 years and up
### How many films have this rating?
### How many have NO award?
### How many have AT LEAST one award?
############################################################

# Step 1: Distribution of all FSK values
freq(df$FSK)

# Step 2: Award distribution for films rated "6 years and up"
df %>%
  filter(FSK == "6 years and up") %>%
  freq(AWARDS)

# freq() shows that 87.20% of these films have AWARDS = 0.
# Therefore, the percentage with ≥ 1 award is:

100 - 87.20    # = 12.80%

# This answers the question without further calculations.


############################################################
### Part (d)
### Which group has a higher proportion of the BEST critics' rating?
### Compare BOOK = 1 vs BOOK = 2.
############################################################

# Book-based films
df %>%
  filter(as.numeric(BOOK) == 2) %>%
  freq(CIN_CRITIC)

# Non-book films
df %>%
  filter(as.numeric(BOOK) == 1) %>%
  freq(CIN_CRITIC)

# Interpretation:
# Compare the "% Valid" for the highest CIN_CRITIC category.
# The group with the higher value has the stronger critic performance.
