############################################################
# Author: Jan-Hendrik Schünemann
# Module: STAT
# Task: 15 – Bivariate Graphics and Interpretation
# Version: v1.1 (2025-12-11)
# Required Dataset: MovieData.rds
# Required Libraries: ggplot2
############################################################

library(ggplot2)

df <- readRDS("MovieData.rds")


############################################################
### 1. DEVisitorsW1 (metric) vs CIN_TIP (categorical)
###    → Use boxplots (quick base R + improved ggplot2)
############################################################

### Quick & dirty base R boxplots
plot(df$CIN_TIP, df$DEVisitorsW1)                      # Simple plot
boxplot(df$DEVisitorsW1 ~ df$CIN_TIP)                  # Base R boxplot


### Improved ggplot2 version
ggplot(df, aes(x = CIN_TIP, y = DEVisitorsW1)) +
  stat_boxplot(geom = "errorbar", width = 0.25) +
  geom_boxplot(fill = "skyblue", outlier.shape = 1, outlier.alpha = 0.5) +
  labs(
    x = "Tip on www.cinema.de",
    y = "Number of Visitors in Germany (Week 1)",
    title = "Distribution of Visitors by Tip Status"
  ) +
  theme_minimal()

### Interpretation:
# Movies receiving a tip tend to have higher median visitor numbers.
# Greater variability in the tipped group indicates that some tipped films
# achieve very high reach. This suggests a possible positive relationship.


############################################################
### 2. BOOK (categorical) vs CIN_TIP (categorical)
###    → Use mosaic plot or stacked bar charts
############################################################

### Stacked bar chart (proportions)
ggplot(df, aes(x = BOOK, fill = CIN_TIP)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of CIN_TIP within BOOK Categories")

### Mosaic plot (quick base R)
plot(df$BOOK, df$CIN_TIP)

### Interpretation:
# Book-based films have a noticeably higher proportion of CIN_TIP = “yes”.
# This suggests that book adaptations may be more likely to receive recommendations.


############################################################
### 3. CIN_CRITIC (ordinal) vs CIN_TIP (categorical)
###    → Use mosaic plot or proportional stacked bars
############################################################

### Stacked bar chart (proportions)
ggplot(df, aes(x = CIN_CRITIC, fill = CIN_TIP)) +
  geom_bar(position = "fill") +
  labs(title = "CIN_TIP Distribution Across Critic Ratings")

### Mosaic plot (quick base R)
plot(df$CIN_CRITIC, df$CIN_TIP)

### Interpretation:
# Higher critic ratings correspond to higher proportions of CIN_TIP = “yes”.
# Films with rating 4 almost never receive a tip.
# There is a clear positive relationship between critic ratings and tip likelihood.


############################################################
### 4. STARPOWER (metric) vs SUCCESS (metric)
###    → Use scatterplots
############################################################

### Quick & dirty scatterplot
plot(df$SUCCESS, df$STARPOWER)


### Improved ggplot2 version
ggplot(df, aes(x = SUCCESS, y = STARPOWER)) +
  geom_point(alpha = 0.1) +
  labs(
    x = "Success Indicator",
    y = "Star Power Index",
    title = "Relationship Between Star Power and Success"
  ) +
  theme_minimal()

### Explanation of alpha:
# The argument alpha controls how transparent each point is.
#
# alpha = 1.0 → completely opaque (solid color)
# alpha = 0.1 → very transparent
#
# Why use alpha?
# In scatterplots with many overlapping points, fully opaque dots produce
# a single dark blob where structure is hidden.
#
# Lower alpha solves this:
# • Light areas → few observations
# • Dark areas → many overlapping observations (high density)
#
# This reduces overplotting and makes relationships easier to see.


### Interpretation:
# The scatterplot shows a weak positive trend: higher star power tends to align
# with higher success, but many exceptions exist. Star power alone is not a
# strong predictor of success; other variables likely influence performance.


############################################################
### GENERAL INTERPRETATION SUMMARY FOR TASK 15
###
### • Boxplots → used when one metric + one categorical variable.
### • Stacked bar charts / mosaics → used when both variables are categorical.
### • Scatterplots → used when both variables are metric.
###
### Across all four comparisons:
### • CIN_TIP appears positively related to visitor numbers and critic ratings.
### • BOOK shows a mild association with CIN_TIP.
### • STARPOWER and SUCCESS show only a weak relationship.
############################################################
