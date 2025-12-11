############################################################
# Author: Jan-Hendrik Schünemann
# Module: STAT
# Task: 11 – Outlier and Extreme Value Analysis (DECopiesW1)
# Version: v1.0 (2025-12-11)
# Required Dataset: MovieData.rds
# Required Libraries: dplyr, ggplot2
############################################################

library(dplyr)
library(ggplot2)

df <- readRDS("MovieData.rds")

############################################################
### STEP 1 — Calculate fences for outliers and extreme values
###
### Definitions (Boxplot Rule):
###
###   Q1, Q3 = 1st and 3rd quartile
###   IQR    = Q3 – Q1
###
### Outlier fence:
###   Lower = Q1 – 1.5 * IQR
###   Upper = Q3 + 1.5 * IQR
###
### Extreme value fence:
###   Lower = Q1 – 3 * IQR
###   Upper = Q3 + 3 * IQR
###
### We use type = 2 quantiles (n + 1 rule) because it matches
### the method used in class and allows manual verification.
############################################################

Q1  <- quantile(df$DECopiesW1, 0.25, type = 2, na.rm = TRUE)
Q3  <- quantile(df$DECopiesW1, 0.75, type = 2, na.rm = TRUE)
IQR <- Q3 - Q1

# Outlier boundaries
lower_fence_outlier  <- Q1 - 1.5 * IQR
upper_fence_outlier  <- Q3 + 1.5 * IQR

# Extreme value boundaries
lower_fence_extreme  <- Q1 - 3 * IQR
upper_fence_extreme  <- Q3 + 3 * IQR


############################################################
### STEP 2 — Custom Boxplot with Outliers & Extreme Values
###
### ggplot’s default outlier symbol does not distinguish
### between regular outliers and extreme values.
###
### Therefore:
###   • We turn off default outlier drawing.
###   • We add our own points:
###         ○  Blue circle = outlier
###         ✶  Red star   = extreme value
############################################################

ggplot(df, aes(x = "", y = DECopiesW1)) +
  stat_boxplot(geom = 'errorbar', width = 0.5) +
  geom_boxplot(fill = "skyblue", width = 0.7, outlier.shape = NA) +
  geom_point(
    data = df %>% filter(DECopiesW1 > upper_fence_outlier & DECopiesW1 <= upper_fence_extreme),
    aes(x = "", y = DECopiesW1),
    color = "blue", shape = 1, size = 3
  ) +
  geom_point(
    data = df %>% filter(DECopiesW1 > upper_fence_extreme),
    aes(x = "", y = DECopiesW1),
    color = "red", shape = 8, size = 3
  ) +
  labs(
    title = "Boxplot of DECopiesW1 with Outliers and Extreme Values",
    y = "Copies (Germany, Week 1)"
  ) +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.text.x  = element_blank(),
    axis.ticks.x = element_blank()
  )

############################################################
### Interpretation:
### • The box shows where the central 50% of movies lie.
### • Points outside the fences suggest unusually high counts.
### • Extreme values (red stars) indicate major blockbusters.
############################################################


############################################################
### STEP 3 — Classify each film as:
###          "None", "Outlier", or "Extreme"
###
### Explanation of the final condition:
###
### case_when() evaluates conditions from top to bottom.
### Every observation must fall into exactly one category.
###
### TRUE ~ "None" acts as the "else" case and ensures that
### all non-outliers receive a valid category.
############################################################

df <- df %>%
  mutate(
    OutlierType = case_when(
      DECopiesW1 > upper_fence_extreme               ~ "Extreme",
      DECopiesW1 > upper_fence_outlier               ~ "Outlier",
      TRUE                                           ~ "None"      # catch-all (else case)
    )
  )


############################################################
### STEP 4 — Proportion of Outliers + Extreme Values
############################################################

proportion_table <- df %>%
  summarise(
    Total     = n(),
    Outliers  = sum(OutlierType == "Outlier"),
    Extremes  = sum(OutlierType == "Extreme"),
    Combined  = Outliers + Extremes,
    Proportion = paste0(round(Combined / Total * 100, 1), "%")
  )

proportion_table


############################################################
### STEP 5 — Summary Measures With and Without Outliers
###
### We compute:
###   • 5-number summary (Min, Q1, Median, Q3, Max)
###   • Mean
###   • Standard deviation
###
### Purpose:
###   → Compare how strongly outliers affect the mean & SD.
###   → Quartiles and median should barely change (robust).
############################################################

# Full dataset
full_summary <- df %>%
  summarise(
    Min    = min(DECopiesW1),
    Q1     = quantile(DECopiesW1, 0.25, type = 2),
    Median = median(DECopiesW1),
    Q3     = quantile(DECopiesW1, 0.75, type = 2),
    Max    = max(DECopiesW1),
    Mean   = mean(DECopiesW1),
    SD     = sd(DECopiesW1)
  )

# Filtered dataset (no outliers or extreme values)
filtered_summary <- df %>%
  filter(OutlierType == "None") %>%
  summarise(
    Min    = min(DECopiesW1),
    Q1     = quantile(DECopiesW1, 0.25, type = 2),
    Median = median(DECopiesW1),
    Q3     = quantile(DECopiesW1, 0.75, type = 2),
    Max    = max(DECopiesW1),
    Mean   = mean(DECopiesW1),
    SD     = sd(DECopiesW1)
  )

# Combine into one table
comparison <- bind_rows(
  Full_Data     = full_summary,
  Filtered_Data = filtered_summary
)

comparison


############################################################
### Interpretation:
###
### • Median, Q1, and Q3 barely change
###       → These statistics are robust.
###
### • Mean drops noticeably after removing outliers
### • Standard deviation becomes much smaller
###       → Both are highly sensitive to extreme values.
###
### • Max reduces drastically in the filtered dataset
###       → Because the extreme blockbusters are removed.
############################################################
