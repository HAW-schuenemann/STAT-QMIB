# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 2 – Normal Distribution
# Version: v1.0
# Last Update: 2026-05-11
# Required Dataset(s): None
# Required Packages: None
# License: MIT
# ============================================================

# ============================================================
# Exercise 2
# ============================================================

# We assume that the variable follows a normal distribution with:
#
# Mean = 183
# Standard deviation = 10.5
#
# In R, the normal distribution can be handled with:
#
# pnorm() = cumulative probability of the normal distribution
#
# General structure:
#
# pnorm(value, mean = ..., sd = ...)
#
# This gives the probability of observing a value less than or equal to
# the specified value.


# ============================================================
# a. Probability of observing a value less than 175
# ============================================================

# P(x <= 175)

pnorm(175, mean = 183, sd = 10.5)

# Answer:
# The probability is approximately 0.2238, or 22.38%.


# ============================================================
# b. Probability of observing a value greater than 195
# ============================================================

# P(x > 195)

# Option 1:
1 - pnorm(195, mean = 183, sd = 10.5)

# Option 2:
pnorm(195, mean = 183, sd = 10.5, lower.tail = FALSE)

# Answer:
# The probability is approximately 0.1265, or 12.65%.


# ============================================================
# c. Probability of observing a value between 173 and 193
# ============================================================

# P(173 <= x <= 193)

pnorm(193, mean = 183, sd = 10.5) -
  pnorm(173, mean = 183, sd = 10.5)

# Answer:
# The probability is approximately 0.6591, or 65.91%.


# ============================================================
# d. Expected number of observations greater than 187 in a sample of 60
# ============================================================

# First, calculate the probability that one observation is greater than 187.
# Then multiply this probability by the sample size.

# P(x > 187) * 60

pnorm(187, mean = 183, sd = 10.5, lower.tail = FALSE) * 60

# Alternative version:
(1 - pnorm(187, mean = 183, sd = 10.5)) * 60

# Answer:
# The expected number is approximately 21.12 observations.


# ============================================================
# e. Probability that the sample mean is greater than 187
# ============================================================

# For the sample mean, we use the standard error instead of the standard
# deviation of individual observations.
#
# Standard error = sd / sqrt(n)

# P(mean > 187), with n = 60

pnorm(187, mean = 183, sd = 10.5 / sqrt(60), lower.tail = FALSE) * 100

# Answer:
# The probability is approximately 0.16%.
