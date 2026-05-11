# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 4 – Uniform Distribution
# Version: v1.0
# Last Update: 2026-05-11
# Required Dataset(s): None
# Required Packages: None
# License: MIT
# ============================================================

# ============================================================
# Exercise 4
# ============================================================

# Task context:
#
# The nightly recharge time for the BBD Model A is assumed to be uniformly
# distributed between 90 and 120 minutes.
#
# In R, the uniform distribution can be handled with:
#
# punif() = cumulative probability of the uniform distribution
# qunif() = quantile of the uniform distribution
#
# punif() answers probability questions.
# qunif() answers questions about required values or cut-off points.


# ============================================================
# a. Mathematical expression for the probability density function
# ============================================================

# For a uniform distribution between 90 and 120, the density is:
#
# f(x) = 1 / (120 - 90) for 90 <= x <= 120
# f(x) = 0 elsewhere
#
# Therefore:
#
# f(x) = 1 / 30 for 90 <= x <= 120
# f(x) = 0 elsewhere


# ============================================================
# b. Probability that the recharge time is less than 110 minutes
# ============================================================

# P(x < 110)

punif(110, min = 90, max = 120)

# Shorter version:
punif(110, 90, 120)

# Answer:
# The probability is approximately 0.6667, or 66.67%.


# ============================================================
# c. Probability that the recharge time is at least 100 minutes
# ============================================================

# At least 100 minutes means:
#
# P(x >= 100)

punif(q = 100, min = 90, max = 120, lower.tail = FALSE)

# Shorter version:
punif(100, 90, 120, lower.tail = FALSE)

# Answer:
# The probability is approximately 0.6667, or 66.67%.


# ============================================================
# d. Probability that the recharge time is between 95 and 110 minutes
# ============================================================

# P(95 <= x <= 110)

punif(110, min = 90, max = 120) -
  punif(95, min = 90, max = 120)

# Shorter version:
punif(110, 90, 120) -
  punif(95, 90, 120)

# Answer:
# The probability is 0.50, or 50%.


# ============================================================
# e. Charging time that will not be exceeded in 20% of charging processes
# ============================================================

# This asks for the 20% quantile.
#
# In other words:
#
# P(x <= charging time) = 0.20

qunif(0.20, min = 90, max = 120)

# Alternative version:
qunif(0.80, min = 90, max = 120, lower.tail = FALSE)

# Shorter versions:
qunif(0.20, 90, 120)
qunif(0.80, 90, 120, lower.tail = FALSE)

# Answer:
# The charging time that will not be exceeded in 20% of charging processes
# is 96 minutes.
