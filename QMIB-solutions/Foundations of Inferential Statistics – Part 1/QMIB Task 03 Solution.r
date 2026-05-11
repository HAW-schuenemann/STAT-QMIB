# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 3 – Normal Distribution and Quantiles
# Version: v1.0
# Last Update: 2026-05-11
# Required Dataset(s): None
# Required Packages: None
# License: MIT
# ============================================================

# ============================================================
# Exercise 3
# ============================================================

# Task context:
#
# The result of an intelligence test is normally distributed with:
#
# Mean = 200 points
# Standard deviation = 35 points
#
# In R, the normal distribution can be handled with:
#
# pnorm() = cumulative probability of the normal distribution
# qnorm() = quantile of the normal distribution
#
# pnorm() answers probability questions.
# qnorm() answers questions about required values or cut-off points.


# ============================================================
# a. Probability that a test taker scores between 170 and 220 points
# ============================================================

# P(170 < x < 220)

pnorm(220, mean = 200, sd = 35) -
  pnorm(170, mean = 200, sd = 35)

# Shorter version:
pnorm(220, 200, 35) -
  pnorm(170, 200, 35)

# Answer:
# The probability is approximately 0.5223, or 52.23%.


# ============================================================
# b. Percentage of test participants with a minimum score of 245 points
# ============================================================

# A minimum score of 245 means:
#
# P(x >= 245)

pnorm(245, mean = 200, sd = 35, lower.tail = FALSE) * 100

# Shorter version:
pnorm(245, 200, 35, lower.tail = FALSE) * 100

# Answer:
# Approximately 9.93% of test participants achieve a minimum score of 245 points.


# ============================================================
# c. Minimum test result needed to be among the 10% best participants
# ============================================================

# The 10% best participants are in the upper tail of the distribution.
#
# Therefore, we need the cut-off value where 10% are above the value
# and 90% are below the value.

# Option 1:
qnorm(0.10, mean = 200, sd = 35, lower.tail = FALSE)

# Option 2:
qnorm(0.90, mean = 200, sd = 35, lower.tail = TRUE)

# Shorter versions:
qnorm(0.10, 200, 35, lower.tail = FALSE)
qnorm(0.90, 200, 35, lower.tail = TRUE)

# Answer:
# A test participant needs a minimum score of approximately 244.85 points
# to be among the 10% best test participants.
