# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 14 – Normal Distribution and Sampling Distribution
# Version: v1.0
# Last Update: 2026-05-11
# Required Dataset(s): None
# Required Packages: None
# License: MIT
# ============================================================

# ============================================================
# Exercise 14
# ============================================================

# Task context:
#
# The weight of apples from Cocoloco follows a normal distribution with:
#
# Mean = 130 g
# Standard deviation = 40 g
#
# The government proposes three weight classes:
#
# light:    x < 120 g
# standard: 120 g <= x <= 150 g
# heavy:    x > 150 g
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
# Parts a to d are about individual apples.
# Part e is about the average weight in a sample of 35 apples.
#
# For an individual apple, we use the original standard deviation.
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
# a. Probability that a randomly selected apple is heavy
# ============================================================

# Heavy means:
#
# x > 150
#
# Therefore:
#
# P(x > 150)
#
# We use lower.tail = FALSE because we need the upper tail probability.

pnorm(150, mean = 130, sd = 40, lower.tail = FALSE)

# Shorter version:
pnorm(150, 130, 40, lower.tail = FALSE)

# Answer:
# The probability is approximately 0.3085, or 30.85%.


# ============================================================
# b. Probability that a randomly selected apple is light
# ============================================================

# Light means:
#
# x < 120
#
# Therefore:
#
# P(x < 120)

pnorm(120, mean = 130, sd = 40)

# Shorter version:
pnorm(120, 130, 40)

# Answer:
# The probability is approximately 0.4013, or 40.13%.


# ============================================================
# c. New upper limit for the light category if a maximum of 25%
#    of apples should fall into this category
# ============================================================

# This is a quantile question.
#
# We need the weight limit where 25% of apples are below or equal to
# this value.
#
# In other words:
#
# P(x <= limit) = 0.25

qnorm(0.25, mean = 130, sd = 40)

# Shorter version:
qnorm(0.25, 130, 40)

# Answer:
# The upper limit for the light category would have to be approximately
# 103.02 g.


# ============================================================
# d. Expected number of apples in the standard category
#    in a random sample of 35 apples
# ============================================================

# Standard means:
#
# 120 <= x <= 150
#
# First, calculate the probability that one randomly selected apple falls
# into the standard category.
#
# Then multiply this probability by the sample size.
#
# P(120 <= x <= 150) * 35

(
  pnorm(150, mean = 130, sd = 40) -
    pnorm(120, mean = 130, sd = 40)
) * 35

# Shorter version:
(
  pnorm(150, 130, 40) -
    pnorm(120, 130, 40)
) * 35

# Answer:
# The expected number is approximately 10.17 apples.


# ============================================================
# e. Probability that the average weight in a random sample of 35 apples
#    falls into the standard category
# ============================================================

# This question is about the sample mean of 35 apples.
#
# Therefore, we use the standard error instead of the original standard
# deviation.
#
# Standard error = 40 / sqrt(35)
#
# The sample average falls into the standard category if:
#
# 120 <= sample mean <= 150

pnorm(150, mean = 130, sd = 40 / sqrt(35)) -
  pnorm(120, mean = 130, sd = 40 / sqrt(35))

# Shorter version:
pnorm(150, 130, 40 / sqrt(35)) -
  pnorm(120, 130, 40 / sqrt(35))

# Answer:
# The probability is approximately 0.9298, or 92.98%.
