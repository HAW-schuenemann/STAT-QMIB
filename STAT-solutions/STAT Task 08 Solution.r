############################################################
# Author: Jan-Hendrik Schünemann
# Module: STAT
# Task: 8 – Classification: Equal Widths vs Equal Frequencies
# Version: v1.2 (2025-12-11)
# Required Dataset: MovieData.rds
# Required Libraries: dplyr, summarytools, ggplot2
############################################################

library(dplyr)
library(summarytools)
library(ggplot2)

df <- readRDS("MovieData.rds")

############################################################
### PART 1 — CLASSIFICATION INTO 6 CLASSES WITH EQUAL WIDTHS
### (Preferred method using cut())
############################################################

# We first compute the minimum and maximum of DECopiesW1.
min_val <- min(df$DECopiesW1, na.rm = TRUE)
max_val <- max(df$DECopiesW1, na.rm = TRUE)

# The width of each class is the total range divided by 6.
width <- (max_val - min_val) / 6

# The breaks for the classes are created using seq():
breaks_eqwidth <- seq(min_val, max_val, by = width)

################################################################
### Explanation: How cut() works and why we use it here
###
### cut(x, breaks) divides a numeric variable x into categorical
### intervals ("bins") based on the boundaries defined in "breaks".
###
### Example:
###   cut(c(10, 15, 22), breaks = c(0, 20, 30))
### would classify values as:
###   (0,20]  or  (20,30]
###
### Why cut() is useful here:
###   • We need 6 classes with *equal numerical width*.
###   • cut() automatically assigns each observation to the right class.
###   • This avoids writing long and error-prone case_when() chains.
###   • It produces a factor variable ready for freq() and ggplot().
###
################################################################

# Create the equal-width classes using cut()
df <- df %>%
  mutate(
    DECopiesW1_width =
      cut(DECopiesW1,
          breaks = c(breaks_eqwidth, max_val),
          include.lowest = TRUE)
  )

# Frequency table for the equal-width classification
freq(df$DECopiesW1_width)

# Cumulative frequency curve using cume_dist()
df %>%
  mutate(cum_rel = cume_dist(DECopiesW1) * 100) %>%
  ggplot(aes(x = DECopiesW1, y = cum_rel, color = DECopiesW1_width)) +
  geom_point(size = 2.2) +
  labs(
    title = "Cumulative Relative Frequency Curve (Equal Width Classes)",
    x = "DECopiesW1",
    y = "Cumulative %"
  ) +
  theme_minimal()


############################################################
### OPTIONAL: Equal-Width Classification Using case_when()
### (Included for teaching purposes; less efficient than cut())
############################################################

b1 <- min_val + width
b2 <- min_val + 2*width
b3 <- min_val + 3*width
b4 <- min_val + 4*width
b5 <- min_val + 5*width
b6 <- max_val

df <- df %>%
  mutate(
    DECopiesW1_width_manual = case_when(
      DECopiesW1 >= min_val & DECopiesW1 < b1 ~ 1,
      DECopiesW1 >= b1      & DECopiesW1 < b2 ~ 2,
      DECopiesW1 >= b2      & DECopiesW1 < b3 ~ 3,
      DECopiesW1 >= b3      & DECopiesW1 < b4 ~ 4,
      DECopiesW1 >= b4      & DECopiesW1 < b5 ~ 5,
      DECopiesW1 >= b5      & DECopiesW1 <= b6 ~ 6
    )
  )

freq(df$DECopiesW1_width_manual)


############################################################
### PART 2 — CLASSIFICATION INTO 6 CLASSES WITH EQUAL FREQUENCIES
############################################################

#######################################################################
### Explanation: How seq() is used inside quantile()
###
### quantile(x, probs = ...) computes the values of x at the specified
### percentiles.
###
### seq(0, 1, by = 1/6)
###    → creates the vector: 0.00, 0.1667, 0.3333, ..., 1.00
###
### This means:
###   • 0%   percentile (minimum)
###   • 16.7% percentile
###   • 33.3% percentile
###   • ...
###   • 100% percentile (maximum)
###
### quantile(DECopiesW1, probs = seq(...)) gives the boundaries so that
### each class contains *approximately* 1/6 of all observations.
###
### Why this is useful here:
###   • Equal-frequency classes have the same number of films per class.
###   • Useful when the distribution is skewed.
###   • cut() then converts the numeric values into ordinal categories.
###
#######################################################################

# Create quantile-based boundaries
breaks_quant <- quantile(
  df$DECopiesW1,
  probs = seq(0, 1, length.out = 7),  # also equivalent to seq(0, 1, by = 1/6)
  na.rm = TRUE
)

# Create classes with equal frequencies
df <- df %>%
  mutate(
    DECopiesW1_freq =
      cut(DECopiesW1, breaks = breaks_quant, include.lowest = TRUE)
  )

# Frequency table for equal-frequency classification
freq(df$DECopiesW1_freq)

# Cumulative curve with equal-frequency coloring
df %>%
  mutate(cum_rel = cume_dist(DECopiesW1) * 100) %>%
  ggplot(aes(x = DECopiesW1, y = cum_rel, color = DECopiesW1_freq)) +
  geom_point(size = 2.2) +
  labs(
    title = "Cumulative Relative Frequency Curve (Equal Frequency Classes)",
    x = "DECopiesW1",
    y = "Cumulative %"
  ) +
  theme_minimal()


############################################################
### INTERPRETATION GUIDANCE
############################################################

# Equal Width Classes:
# - All intervals have the same numerical width.
# - Frequencies vary depending on data distribution.

# Equal Frequency Classes:
# - Each class contains (approximately) the same number of films.
# - Interval widths adapt to dense/sparse regions of data.

# Cumulative curves:
# - Help visually assess how well boundaries capture the structure
#   of the distribution.
# - Color highlights where classes overlap dense vs. sparse regions.
