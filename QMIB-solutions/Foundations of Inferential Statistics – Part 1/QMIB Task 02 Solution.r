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

# Task context:
#
# Males in the Netherlands are among the tallest, on average, in the world.
# We assume that the height of Dutch men is normally distributed with:
#
# Mean = 183 cm
# Standard deviation = 10.5 cm
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
# a. Probability that a Dutch male is shorter than 175 cm
# ============================================================

# P(x < 175)

pnorm(175, mean = 183, sd = 10.5)

# Answer:
# The probability is approximately 0.2238, or 22.38%.


# ============================================================
# b. Probability that a Dutch male is taller than 195 cm
# ============================================================

# P(x > 195)

# Option 1:
1 - pnorm(195, mean = 183, sd = 10.5)

# Option 2:
pnorm(195, mean = 183, sd = 10.5, lower.tail = FALSE)

# Answer:
# The probability is approximately 0.1265, or 12.65%.


# ============================================================
# c. Probability that a Dutch male is between 173 and 193 cm
# ============================================================

# P(173 < x < 193)

pnorm(193, mean = 183, sd = 10.5) -
  pnorm(173, mean = 183, sd = 10.5)

# Answer:
# The probability is approximately 0.6591, or 65.91%.


# ============================================================
# d. Expected number of Dutch men taller than 187 cm in a sample of 60
# ============================================================

# First, calculate the probability that one randomly selected Dutch man
# is taller than 187 cm.
#
# Then multiply this probability by the sample size.

# P(x > 187) * 60

pnorm(187, mean = 183, sd = 10.5, lower.tail = FALSE) * 60

# Alternative version:
(1 - pnorm(187, mean = 183, sd = 10.5)) * 60

# Answer:
# The expected number is approximately 21.12 men.


# ============================================================
# e. Probability that the sample average height is greater than 187 cm
# ============================================================

# This question asks about the sample mean, not about one individual person.
#
# Therefore, we use the standard error of the mean:
#
# Standard error = standard deviation / sqrt(sample size)

# P(sample mean > 187)

pnorm(187, mean = 183, sd = 10.5 / sqrt(60), lower.tail = FALSE)

# Optional: result as percentage

pnorm(187, mean = 183, sd = 10.5 / sqrt(60), lower.tail = FALSE) * 100

# Answer:
# The probability is approximately 0.0016, or 0.16%.
