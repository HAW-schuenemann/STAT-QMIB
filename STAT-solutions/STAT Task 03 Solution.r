############################################################
# Author: Jan-Hendrik Schünemann
# Module: STAT
# Task: 3 – MovieData Frequency Tables
# Version: v1.0 (2025-12-11)
# Required Dataset: MovieData.rds
# Required Libraries: summarytools, dplyr, ggplot2, plotly
############################################################

## 1. Load required packages -------------------------------------------------

# If the packages are not installed yet:
# install.packages("summarytools")
# install.packages("dplyr")
# install.packages("ggplot2")
# install.packages("plotly")

library(summarytools)
library(dplyr)
library(ggplot2)
library(plotly)

## 2. Load dataset -----------------------------------------------------------
# The .rds format preserves variable types (numeric, factor, ordered factor).

df <- readRDS("MovieData.rds")

############################################################
### Part (a)
### Frequency tables for BOOK and CIN_CRITIC
### + suitable graphical representations
############################################################

## 3. Frequency table for BOOK ------------------------------------------------
# BOOK indicates whether a film is based on a book template.

freq(df$BOOK)

# Optional dplyr versions:
# df %>% select(BOOK) %>% freq()
# df %>% freq(BOOK)

# Plotly pie chart for BOOK (default graphical representation)
plot_ly(
  data = df,
  labels = ~BOOK,
  type = "pie"
) %>%
  layout(title = "Films Based on a Book Template")

## 4. Frequency table for CIN_CRITIC -----------------------------------------
# CIN_CRITIC = Critics’ rating from the magazine Cinema.

freq(df$CIN_CRITIC)

# Optional dplyr versions:
# df %>% select(CIN_CRITIC) %>% freq()
# df %>% freq(CIN_CRITIC)

# ggplot2 bar chart (required visualization)
ggplot(df, aes(x = CIN_CRITIC)) +
  geom_bar() +
  labs(
    title = "Critics' Rating (CINEMA Magazine)",
    x = "Rating",
    y = "Count"
  )

############################################################
### Part (b)
### Frequency table for GENRE + description
############################################################

## 5. Frequency table for GENRE -----------------------------------------------
# GENRE = film genre (categorical). Students must describe the result verbally.

freq(df$GENRE)

# Optional dplyr versions:
# df %>% select(GENRE) %>% freq()
# df %>% freq(GENRE)

# (A bar chart would be appropriate but is NOT required by the task.)
# ggplot(df, aes(x = GENRE)) +
#   geom_bar() +
#   labs(title = "Film Genres in the Sample", x = "Genre", y = "Count")

############################################################
### Interpretation notes for students
############################################################

# Part (a):
# - BOOK: Which category is more common: films based on a book or not?
# - CIN_CRITIC: Describe how critic ratings are distributed across the sample.
#
# Part (b):
# - GENRE: Identify the most and least common genres.
# - Describe overall patterns (e.g., dominant genres, rare categories).
