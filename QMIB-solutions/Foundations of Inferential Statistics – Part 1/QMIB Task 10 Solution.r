# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 10 – Uniform Distribution
# Version: v1.0
# Last Update: 2026-05-11
# Required Dataset(s): None
# Required Packages: None
# License: MIT
# ============================================================

# ============================================================
# Exercise 10
# ============================================================

# Task context:
#
# Delta Airlines quotes a flight time of 2 hours and 5 minutes.
#
# Quoted flight time:
#
# 2 hours and 5 minutes = 125 minutes
#
# The actual flight times are uniformly distributed between
# 2 hours and 2 hours and 20 minutes.
#
# Lower limit:
#
# 2 hours = 120 minutes
#
# Upper limit:
#
# 2 hours and 20 minutes = 140 minutes
#
# Therefore:
#
# x follows a uniform distribution between 120 and 140 minutes.
#
# In R, the uniform distribution can be handled with:
#
# punif() = cumulative probability of the uniform distribution
# qunif() = quantile of the uniform distribution
#
# punif() answers probability questions.
# qunif() answers questions about required values or cut-off points.


# ============================================================
# a. Probability that a flight is not delayed
# ============================================================

# A flight is not delayed if the actual flight time is no longer than
# the quoted flight time.
#
# Quoted flight time = 125 minutes
#
# Therefore:
#
# P(x <= 125)

punif(125, min = 120, max = 140)

# Shorter version:
punif(125, 120, 140)

# Answer:
# The probability is 0.25, or 25%.


# ============================================================
# b. Probability that a flight will be no more than 5 minutes late
# ============================================================

# A flight is no more than 5 minutes late if the actual flight time is
# at most 5 minutes longer than the quoted flight time.
#
# Quoted flight time = 125 minutes
# 5 minutes late = 125 + 5 = 130 minutes
#
# Therefore:
#
# P(x <= 130)

punif(130, min = 120, max = 140)

# Shorter version:
punif(130, 120, 140)

# Answer:
# The probability is 0.50, or 50%.


# ============================================================
# c. Probability that a flight will be at least 12 minutes late
# ============================================================

# A flight is at least 12 minutes late if the actual flight time is
# at least 12 minutes longer than the quoted flight time.
#
# Quoted flight time = 125 minutes
# 12 minutes late = 125 + 12 = 137 minutes
#
# Therefore:
#
# P(x >= 137)

punif(137, min = 120, max = 140, lower.tail = FALSE)

# Shorter version:
punif(137, 120, 140, lower.tail = FALSE)

# Answer:
# The probability is 0.15, or 15%.


# ============================================================
# d. Expected flight time
# ============================================================

# For a uniform distribution, the expected value is the midpoint between
# the lower and upper limit.
#
# Expected value = (lower limit + upper limit) / 2

(120 + 140) / 2

# Answer:
# The expected flight time is 130 minutes.
# This equals 2 hours and 10 minutes.


# ============================================================
# e. Flight time that is not exceeded by 35% of flights
# ============================================================

# This asks for the 35% quantile.
#
# In other words:
#
# P(x <= flight time) = 0.35

qunif(0.35, min = 120, max = 140)

# Shorter version:
qunif(0.35, 120, 140)

# Answer:
# The flight time that is not exceeded by 35% of flights is 127 minutes.
# This equals 2 hours and 7 minutes.
