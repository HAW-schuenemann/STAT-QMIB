# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 5 – Normal Distribution and Quantiles
# Version: v1.0
# Last Update: 2026-05-11
# Required Dataset(s): None
# Required Packages: None
# License: MIT
# ============================================================

# ============================================================
# Exercise 5
# ============================================================

# Task context:
#
# The American Automobile Association (AAA) reported that families planning
# to travel over the Labor Day weekend spend an average of $749.
#
# We assume that the amount spent is normally distributed with:
#
# Mean = 749 dollars
# Standard deviation = 225 dollars
#
# In R, the normal distribution can be handled with:
#
# pnorm() = cumulative probability of the normal distribution
# qnorm() = quantile of the normal distribution
#
# pnorm() answers probability questions.
# qnorm() answers questions about required values or cut-off points.


# ============================================================
# a. Probability that family expenses are less than $400
# ============================================================

# P(x < 400)

pnorm(400, mean = 749, sd = 225)

# Shorter version:
pnorm(400, 749, 225)

# Answer:
# The probability is approximately 0.0604, or 6.04%.


# ============================================================
# b. Probability that family expenses are $800 or more
# ============================================================

# P(x >= 800)

pnorm(800, mean = 749, sd = 225, lower.tail = FALSE)

# Shorter version:
pnorm(800, 749, 225, lower.tail = FALSE)

# Answer:
# The probability is approximately 0.4103, or 41.03%.


# ============================================================
# c. Probability that family expenses are between $500 and $1,000
# ============================================================

# P(500 < x < 1000)

pnorm(1000, mean = 749, sd = 225) -
  pnorm(500, mean = 749, sd = 225)

# Shorter version:
pnorm(1000, 749, 225) -
  pnorm(500, 749, 225)

# Answer:
# The probability is approximately 0.7330, or 73.30%.


# ============================================================
# d. Minimum expenses for the 5% of families with the most expensive plans
# ============================================================

# The 5% of families with the most expensive travel plans are in the
# upper tail of the distribution.
#
# Therefore, we need the cut-off value where 5% are above the value
# and 95% are below the value.

# Option 1:
qnorm(0.05, mean = 749, sd = 225, lower.tail = FALSE)

# Option 2:
qnorm(0.95, mean = 749, sd = 225, lower.tail = TRUE)

# Shorter versions:
qnorm(0.05, 749, 225, lower.tail = FALSE)
qnorm(0.95, 749, 225, lower.tail = TRUE)

# Answer:
# The Labor Day weekend expenses would have to be at least approximately
# $1,119.09 to be among the 5% most expensive travel plans.
