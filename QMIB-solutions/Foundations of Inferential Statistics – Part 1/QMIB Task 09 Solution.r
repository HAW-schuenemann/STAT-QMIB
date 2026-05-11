# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 9 – Sampling Distribution of a Sample Proportion
# Version: v1.0
# Last Update: 2026-05-11
# Required Dataset(s): None
# Required Packages: ggplot2
# License: MIT
# ============================================================

# Install package first if needed:
# install.packages("ggplot2")

library(ggplot2) # used for creating plots

# ============================================================
# Exercise 9
# ============================================================

# Task context:
#
# The Wall Street Journal reported that the age at first startup for
# 55% of entrepreneurs was 29 years of age or less.
#
# Therefore, the population proportion is:
#
# p = 0.55
#
# This exercise is about the sampling distribution of a sample proportion.
#
# Important:
# We are not looking at one individual entrepreneur.
# We are looking at the proportion in a sample.
#
# For a sample proportion, the sampling distribution has:
#
# Mean = p
# Standard error = sqrt(p * (1 - p) / n)
#
# Reason:
# Sample proportions vary from sample to sample.
# The standard error describes how much sample proportions are expected
# to vary around the true population proportion.
#
# The larger the sample size, the smaller the standard error becomes.


# ============================================================
# a. Sampling distribution of p_tilde for n = 200
# ============================================================

# The population proportion is:
#
# p = 0.55
#
# The sample size is:
#
# n = 200
#
# Mean of the sampling distribution:
#
# mean = 0.55
#
# Standard error:
#
# sqrt(0.55 * (1 - 0.55) / 200)

sqrt(0.55 * (1 - 0.55) / 200)

# This means:
#
# p_tilde is approximately normally distributed with:
#
# Mean = 0.55
# Standard error approximately 0.0352
#
# p_tilde ~ N(0.55, 0.0352)

# Create values for possible sample proportions
x <- seq(0.40, 0.70, length.out = 500)

# Create the density values for the approximate normal sampling distribution
pdf <- dnorm(
  x,
  mean = 0.55,
  sd = sqrt(0.55 * (1 - 0.55) / 200)
)

# Store the values in a data frame
df_pdf <- data.frame(
  x = x,
  density = pdf
)

# Plot the sampling distribution
ggplot(df_pdf, aes(x = x, y = density)) +
  geom_line(linewidth = 1.2) +
  ggtitle("Sampling Distribution of the Sample Proportion") +
  xlab("Sample proportion") +
  ylab("Density") +
  theme_minimal()


# ============================================================
# b. Probability that the sample proportion is within ±0.05
#    of the population proportion
# ============================================================

# The population proportion is 0.55.
#
# Within ±0.05 means:
#
# Lower limit = 0.55 - 0.05 = 0.50
# Upper limit = 0.55 + 0.05 = 0.60
#
# Therefore:
#
# P(0.50 <= p_tilde <= 0.60)
#
# Since this is about a sample proportion with n = 200, we use:
#
# mean = 0.55
# standard error = sqrt(0.55 * (1 - 0.55) / 200)

pnorm(
  0.60,
  mean = 0.55,
  sd = sqrt(0.55 * (1 - 0.55) / 200)
) -
  pnorm(
    0.50,
    mean = 0.55,
    sd = sqrt(0.55 * (1 - 0.55) / 200)
  )

# Answer:
# The probability is approximately 0.8441, or 84.41%.


# ============================================================
# c. Probability that the sample proportion is at least 58%
#    for a sample of 80 entrepreneurs
# ============================================================

# Here the sample size changes to:
#
# n = 80
#
# The question asks for:
#
# P(p_tilde >= 0.58)
#
# Since the sample size changed, the standard error also changes:
#
# sqrt(0.55 * (1 - 0.55) / 80)

sqrt(0.55 * (1 - 0.55) / 80)

# We use lower.tail = FALSE because we need the upper tail probability.

pnorm(
  0.58,
  mean = 0.55,
  sd = sqrt(0.55 * (1 - 0.55) / 80),
  lower.tail = FALSE
)

# Answer:
# The probability is approximately 0.2949, or 29.49%.
