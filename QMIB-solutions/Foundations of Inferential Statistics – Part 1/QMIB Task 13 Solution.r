# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 13 – Normal Distribution and Sampling Distribution
# Version: v1.0
# Last Update: 2026-05-11
# Required Dataset(s): None
# Required Packages: None
# License: MIT
# ============================================================

# ============================================================
# Exercise 13
# ============================================================

# Task context:
#
# The weights of male students at Glendale University are normally distributed
# with:
#
# Mean = 140 lb
# Standard deviation = 10 lb
#
# In R, the normal distribution can be handled with:
#
# pnorm() = cumulative probability of the normal distribution
#
# pnorm() answers probability questions.
#
# Important:
# Parts a to d are about individual students.
# Part e is about the average weight in a sample of 200 students.
#
# For an individual value, we use the original standard deviation.
#
# For a sample mean, we use the standard error:
#
# Standard error = standard deviation / sqrt(sample size)
#
# Reason:
# A sample mean varies less than individual observations.
# Dividing by sqrt(n) adjusts the standard deviation to the distribution
# of sample means.


# ============================================================
# a. Probability that a male student weighs no more than 125 lb
# ============================================================

# No more than 125 lb means:
#
# P(x <= 125)

pnorm(125, mean = 140, sd = 10)

# Shorter version:
pnorm(125, 140, 10)

# Answer:
# The probability is approximately 0.0668, or 6.68%.


# ============================================================
# b. Probability that a male student weighs between 130 lb and 145 lb
# ============================================================

# Between 130 lb and 145 lb means:
#
# P(130 <= x <= 145)

pnorm(145, mean = 140, sd = 10) -
  pnorm(130, mean = 140, sd = 10)

# Shorter version:
pnorm(145, 140, 10) -
  pnorm(130, 140, 10)

# Answer:
# The probability is approximately 0.5328, or 53.28%.


# ============================================================
# c. Probability that a male student weighs more than 160 lb
# ============================================================

# More than 160 lb means:
#
# P(x > 160)
#
# We use lower.tail = FALSE because we need the upper tail probability.

pnorm(160, mean = 140, sd = 10, lower.tail = FALSE)

# Shorter version:
pnorm(160, 140, 10, lower.tail = FALSE)

# Answer:
# The probability is approximately 0.0228, or 2.28%.


# ============================================================
# d. Expected number of male students weighing more than 142 lb
#    in a sample of 200
# ============================================================

# First, calculate the probability that one randomly selected male student
# weighs more than 142 lb.
#
# Then multiply this probability by the sample size.
#
# P(x > 142) * 200

pnorm(142, mean = 140, sd = 10, lower.tail = FALSE) * 200

# Shorter version:
pnorm(142, 140, 10, lower.tail = FALSE) * 200

# Answer:
# The expected number is approximately 84.15 students.


# ============================================================
# e. Probability that the average weight in a sample of 200 students
#    is more than 145 lb
# ============================================================

# This question is about the sample mean of 200 students.
#
# Therefore, we use the standard error instead of the original standard
# deviation.
#
# Standard error = 10 / sqrt(200)
#
# More than 145 lb means:
#
# P(sample mean > 145)

pnorm(145, mean = 140, sd = 10 / sqrt(200), lower.tail = FALSE)

# Shorter version:
pnorm(145, 140, 10 / sqrt(200), lower.tail = FALSE)

# Answer:
# The probability is approximately 0.0000000000007687.
# In percentage terms, this is approximately 0.00000000007687%.
# This probability is extremely close to 0.
