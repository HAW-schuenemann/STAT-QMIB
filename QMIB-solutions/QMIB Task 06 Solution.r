# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 6 – Exponential Distribution
# Version: v1.0
# Last Update: 2026-05-11
# Required Dataset(s): None
# Required Packages: None
# License: MIT
# ============================================================

# ============================================================
# Exercise 6
# ============================================================

# Task context:
#
# Comcast customers are told that service will be restored in two hours.
# We assume that two hours is the mean repair time.
#
# The repair time follows an exponential distribution.
#
# For the exponential distribution in R:
#
# pexp() = cumulative probability of the exponential distribution
#
# Important:
# R uses the rate parameter for the exponential distribution.
#
# rate = 1 / mean
#
# In this case:
#
# rate = 1 / 2


# ============================================================
# a. Probability that the cable service is repaired in one hour or less
# ============================================================

# P(x <= 1)

pexp(1, rate = 1 / 2)

# Answer:
# The probability is approximately 0.3935, or 39.35%.


# ============================================================
# b. Probability that the repair takes between one and two hours
# ============================================================

# P(1 <= x <= 2)

pexp(2, rate = 1 / 2) -
  pexp(1, rate = 1 / 2)

# Answer:
# The probability is approximately 0.2387, or 23.87%.


# ============================================================
# c. Probability that the cable service is not repaired by 5:00 p.m.
# ============================================================

# A customer calls at 1:00 p.m.
# By 5:00 p.m., four hours have passed.
#
# Therefore, the question is:
#
# P(x > 4)

pexp(4, rate = 1 / 2, lower.tail = FALSE)

# Answer:
# The probability is approximately 0.1353, or 13.53%.
