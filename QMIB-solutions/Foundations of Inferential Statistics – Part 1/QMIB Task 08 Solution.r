# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 8 – Sampling Distribution of the Mean
# Version: v1.0
# Last Update: 2026-05-11
# Required Dataset(s): None
# Required Packages: None
# License: MIT
# ============================================================

# ============================================================
# Exercise 8
# ============================================================

# Task context:
#
# The Economic Policy Institute reported the following hourly wages
# for college graduates:
#
# Male graduates:
# Mean = 37.39 dollars
# Standard deviation = 4.60 dollars
#
# Female graduates:
# Mean = 27.83 dollars
# Standard deviation = 4.10 dollars
#
# In each part, the sample size is 100.
#
# Important:
# These questions are not about the wage of one randomly selected person.
# They are about the mean wage in a sample of 100 people.
#
# Therefore, we do not use the original standard deviation directly.
# Instead, we use the standard error of the sample mean.
#
# Standard error = standard deviation / sqrt(sample size)
#
# Reason:
# Sample means vary less than individual observations.
# The larger the sample, the more stable the sample mean becomes.
# Dividing by sqrt(n) adjusts the standard deviation to the distribution
# of sample means.
#
# In R, the normal distribution can be handled with:
#
# pnorm() = cumulative probability of the normal distribution
# qnorm() = quantile of the normal distribution
#
# pnorm() answers probability questions.
# qnorm() answers questions about required values or cut-off points.


# ============================================================
# a. Probability that the sample mean for male graduates is within $1.00
#    of the population mean
# ============================================================

# The population mean is 37.39.
#
# Within $1.00 of the population mean means that the sample mean may be
# one dollar below or one dollar above the population mean.
#
# Lower limit = 37.39 - 1.00 = 36.39
# Upper limit = 37.39 + 1.00 = 38.39
#
# Because the question is about a sample mean, the standard deviation used
# in pnorm() is the standard error:
#
# 4.60 / sqrt(100)
#
# Therefore:
#
# P(36.39 <= sample mean <= 38.39)

pnorm(38.39, mean = 37.39, sd = 4.60 / sqrt(100)) -
  pnorm(36.39, mean = 37.39, sd = 4.60 / sqrt(100))

# Answer:
# The probability is approximately 0.9703, or 97.03%.


# ============================================================
# b. Probability that the sample mean for female graduates is less than $27
# ============================================================

# The female population mean is 27.83.
#
# The question asks whether the average wage in a sample of 100 female
# graduates is less than 27.
#
# Again, this is a question about the sample mean.
# Therefore, we use the standard error:
#
# 4.10 / sqrt(100)
#
# P(sample mean < 27)

pnorm(27, mean = 27.83, sd = 4.10 / sqrt(100))

# Answer:
# The probability is approximately 0.0215, or 2.15%.


# ============================================================
# c. Minimum average wage earned by 80% of male graduates
# ============================================================

# This question asks for a cut-off value.
#
# We are not given a wage and asked for a probability.
# Instead, we are given a probability and asked for the corresponding wage.
#
# Therefore, we use qnorm().
#
# The wording "earned by 80%" is interpreted as the value that is not exceeded
# by 80% of sample means.
#
# In other words:
#
# P(sample mean <= wage) = 0.80
#
# Because this is still about the mean of a sample of 100 male graduates,
# we again use the standard error:
#
# 4.60 / sqrt(100)

qnorm(0.80, mean = 37.39, sd = 4.60 / sqrt(100))

# Answer:
# The minimum average wage earned by 80% of samples is approximately
# $37.78.
