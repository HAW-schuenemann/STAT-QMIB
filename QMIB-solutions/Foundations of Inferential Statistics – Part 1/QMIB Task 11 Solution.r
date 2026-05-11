# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 11 – Normal Distribution and Sampling Distribution
# Version: v1.0
# Last Update: 2026-05-11
# Required Dataset(s): None
# Required Packages: None
# License: MIT
# ============================================================

# ============================================================
# Exercise 11
# ============================================================

# Task context:
#
# The mean cost of domestic airfares in the United States was reported as
# 385 dollars per ticket.
#
# We assume that domestic airfares are normally distributed with:
#
# Mean = 385 dollars
# Standard deviation = 150 dollars
#
# In R, the normal distribution can be handled with:
#
# pnorm() = cumulative probability of the normal distribution
# qnorm() = quantile of the normal distribution
#
# pnorm() answers probability questions.
# qnorm() answers questions about required values or cut-off points.
#
# Important:
# Most parts of this exercise are about one randomly selected domestic airfare.
# Part c is different because it asks about the average airfare in a sample
# of 100 tickets.
#
# For a sample mean, we use the standard error:
#
# Standard error = standard deviation / sqrt(sample size)
#
# Reason:
# Sample means vary less than individual observations.
# Dividing by sqrt(n) adjusts the standard deviation to the distribution
# of sample means.


# ============================================================
# a. Probability that a domestic airfare is $550 or more
# ============================================================

# $550 or more means:
#
# P(x >= 550)

pnorm(550, mean = 385, sd = 150, lower.tail = FALSE)

# Shorter version:
pnorm(550, 385, 150, lower.tail = FALSE)

# Answer:
# The probability is approximately 0.1357, or 13.57%.


# ============================================================
# b. Probability that a domestic airfare is $380 or less
# ============================================================

# $380 or less means:
#
# P(x <= 380)

pnorm(380, mean = 385, sd = 150)

# Shorter version:
pnorm(380, 385, 150)

# Answer:
# The probability is approximately 0.4867, or 48.67%.


# ============================================================
# c. Probability that the average airfare in a sample of 100 tickets
#    is $380 or less
# ============================================================

# This question is about the sample mean of 100 tickets.
#
# Therefore, we use the standard error instead of the original standard
# deviation.
#
# Standard error = 150 / sqrt(100)
#
# P(sample mean <= 380)

pnorm(380, mean = 385, sd = 150 / sqrt(100))

# Shorter version:
pnorm(380, 385, 150 / sqrt(100))

# Answer:
# The probability is approximately 0.3694, or 36.94%.


# ============================================================
# d. Probability that a domestic airfare is between $300 and $500
# ============================================================

# Between $300 and $500 means:
#
# P(300 <= x <= 500)

pnorm(500, mean = 385, sd = 150) -
  pnorm(300, mean = 385, sd = 150)

# Shorter version:
pnorm(500, 385, 150) -
  pnorm(300, 385, 150)

# Answer:
# The probability is approximately 0.4927, or 49.27%.


# ============================================================
# e. Minimum cost of the 3% highest domestic airfares
# ============================================================

# The 3% highest airfares are in the upper tail of the distribution.
#
# Therefore, we need the cut-off value where 3% are above the value
# and 97% are below the value.
#
# This is a quantile question, so we use qnorm().

# Option 1:
qnorm(0.03, mean = 385, sd = 150, lower.tail = FALSE)

# Option 2:
qnorm(0.97, mean = 385, sd = 150, lower.tail = TRUE)

# Shorter versions:
qnorm(0.03, 385, 150, lower.tail = FALSE)
qnorm(0.97, 385, 150, lower.tail = TRUE)

# Answer:
# The 3% highest domestic airfares cost at least approximately $667.12.


# ============================================================
# f. Cost that is not exceeded by the 15% lowest domestic airfares
# ============================================================

# The 15% lowest airfares are in the lower tail of the distribution.
#
# Therefore, we need the value where 15% of airfares are below or equal
# to this value.
#
# In other words:
#
# P(x <= cost) = 0.15

qnorm(0.15, mean = 385, sd = 150)

# Shorter version:
qnorm(0.15, 385, 150)

# Answer:
# The cost that is not exceeded by the 15% lowest domestic airfares is
# approximately $229.54.
