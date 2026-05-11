# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 12 – Exponential Distribution
# Version: v1.0
# Last Update: 2026-05-11
# Required Dataset(s): None
# Required Packages: None
# License: MIT
# ============================================================

# ============================================================
# Exercise 12
# ============================================================

# Task context:
#
# The time between arrivals of vehicles at a particular intersection follows
# an exponential distribution with a mean of 12 seconds.
#
# In R, the exponential distribution can be handled with:
#
# pexp() = cumulative probability of the exponential distribution
# qexp() = quantile of the exponential distribution
#
# pexp() answers probability questions.
# qexp() answers questions about required values or cut-off points.
#
# Important:
# R uses the rate parameter for the exponential distribution.
#
# rate = 1 / mean
#
# In this case:
#
# rate = 1 / 12


# ============================================================
# a. Probability that the arrival time is 12 seconds or less
# ============================================================

# 12 seconds or less means:
#
# P(x <= 12)

pexp(12, rate = 1 / 12)

# Answer:
# The probability is approximately 0.6321, or 63.21%.


# ============================================================
# b. Probability that the arrival time is between 6 and 12 seconds
# ============================================================

# Between 6 and 12 seconds means:
#
# P(6 <= x <= 12)

pexp(12, rate = 1 / 12) -
  pexp(6, rate = 1 / 12)

# Answer:
# The probability is approximately 0.2387, or 23.87%.


# ============================================================
# c. Probability that the arrival time is more than 18 seconds
# ============================================================

# More than 18 seconds means:
#
# P(x > 18)
#
# We use lower.tail = FALSE because we need the upper tail probability.

pexp(18, rate = 1 / 12, lower.tail = FALSE)

# Answer:
# The probability is approximately 0.2231, or 22.31%.


# ============================================================
# d. Arrival time that is exceeded by the 10% highest arrival times
# ============================================================

# The 10% highest arrival times are in the upper tail.
#
# We need the cut-off value where 10% of arrival times are above the value
# and 90% are below or equal to the value.
#
# This is a quantile question, so we use qexp().

# Option 1:
qexp(0.10, rate = 1 / 12, lower.tail = FALSE)

# Option 2:
qexp(0.90, rate = 1 / 12, lower.tail = TRUE)

# Answer:
# The arrival time that is exceeded by the 10% highest arrival times is
# approximately 27.63 seconds.


# ============================================================
# e. Maximum arrival time for the 15% lowest arrival times
# ============================================================

# The 15% lowest arrival times are in the lower tail.
#
# We need the value where 15% of arrival times are below or equal to this value.
#
# In other words:
#
# P(x <= arrival time) = 0.15

qexp(0.15, rate = 1 / 12)

# Answer:
# The maximum arrival time for the 15% lowest arrival times is
# approximately 1.95 seconds.
