############################################################
# Author: Jan-Hendrik Schünemann
# Module: STAT
# Task: 12 – Summary Measures for GENRE, MIN, BOOK, AWARDS
# Version: v1.1 (2025-12-11)
# Required Dataset: MovieData.rds
# Required Libraries: dplyr, summarytools, ggplot2, plotly
############################################################

library(dplyr)
library(summarytools)
library(ggplot2)
library(plotly)

df <- readRDS("MovieData.rds")

############################################################
### NOTE FOR STUDENTS:
### The task requires ONLY the summary measures.
### All visualisations shown below are OPTIONAL and included 
### to help interpret the data more easily.
############################################################


############################################################
### 1. GENRE (Nominal variable)
### Suitable summary measure: Frequency table
### Optional: Bar Chart
############################################################

# Frequency table
freq(df$GENRE)

# OPTIONAL: Bar chart
ggplot(df, aes(x = GENRE)) +
  geom_bar(fill = "steelblue") +
  labs(
    title = "Distribution of Movie Genres",
    x = "Genre",
    y = "Count"
  ) +
  theme_minimal()

# Interpretation guidance:
# - Identify which genres appear most often.
# - Check if the distribution is balanced or dominated by a few genres.


############################################################
### 2. MIN – Film length in minutes (Scale variable)
### Suitable summary measures:
###   • Min, Q1, Median, Q3, Max
###   • Mean, Standard deviation
### Optional: Boxplot
############################################################

df %>%
  summarise(
    Min    = min(MIN, na.rm = TRUE),
    Q1     = quantile(MIN, 0.25, type = 2, na.rm = TRUE),
    Median = median(MIN, na.rm = TRUE),
    Q3     = quantile(MIN, 0.75, type = 2, na.rm = TRUE),
    Max    = max(MIN, na.rm = TRUE),
    Mean   = mean(MIN, na.rm = TRUE),
    SD     = sd(MIN, na.rm = TRUE)
  )

# OPTIONAL: Boxplot
ggplot(df, aes(x = "", y = MIN)) +
  geom_boxplot(fill = "skyblue") +
  labs(
    title = "Boxplot of Film Length (Minutes)",
    y = "Minutes"
  ) +
  theme_minimal() +
  theme(axis.title.x = element_blank(),
        axis.text.x  = element_blank(),
        axis.ticks.x = element_blank())

# Interpretation guidance:
# - Compare mean vs. median to assess skewness.
# - Check Q1–Q3 range for typical film lengths.
# - Outliers indicate unusually long or short movies.


############################################################
### 3. BOOK – Film based on a book template (Nominal)
### Suitable summary:
###   • Frequency table
### Optional:
###   • Plotly Pie Chart (preferred visualization)
############################################################

# Frequency table
freq(df$BOOK)

# OPTIONAL: Pie chart (Plotly)
plot_ly(
  data = df,
  labels = ~BOOK,
  type = "pie"
) %>%
  layout(title = "Films Based on a Book Template")

# Interpretation guidance:
# - Shows the proportion of book-based films.
# - Useful to understand how common adaptations are in the dataset.


############################################################
### 4. AWARDS – Number of awards won (Scale variable)
### Suitable summary measures:
###   • Min, Q1, Median, Q3, Max
###   • Mean, Standard deviation
### Optional: Boxplot
############################################################

df %>%
  summarise(
    Min    = min(AWARDS, na.rm = TRUE),
    Q1     = quantile(AWARDS, 0.25, type = 2, na.rm = TRUE),
    Median = median(AWARDS, na.rm = TRUE),
    Q3     = quantile(AWARDS, 0.75, type = 2, na.rm = TRUE),
    Max    = max(AWARDS, na.rm = TRUE),
    Mean   = mean(AWARDS, na.rm = TRUE),
    SD     = sd(AWARDS, na.rm = TRUE)
  )

# OPTIONAL: Boxplot
ggplot(df, aes(x = "", y = AWARDS)) +
  geom_boxplot(fill = "orange") +
  labs(
    title = "Boxplot of Awards Won",
    y = "Awards"
  ) +
  theme_minimal() +
  theme(axis.title.x = element_blank(),
        axis.text.x  = element_blank(),
        axis.ticks.x = element_blank())

# Interpretation guidance:
# - Awards are usually right-skewed.
# - Mean > median suggests a few high-award films.
# - Boxplot helps identify exceptional blockbusters.
