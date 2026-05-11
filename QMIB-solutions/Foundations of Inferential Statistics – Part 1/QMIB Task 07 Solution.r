# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 7 – Exponential Distribution
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
# Exercise 7
# ============================================================

# Task context:
#
# Kroger reduced the average customer waiting time to 26 seconds.
# We assume that waiting times are exponentially distributed.
#
# For the exponential distribution in R:
#
# dexp() = density of the exponential distribution
# pexp() = cumulative probability of the exponential distribution
# qexp() = quantile of the exponential distribution
#
# Important:
# R uses the rate parameter for the exponential distribution.
#
# rate = 1 / mean
#
# In this case:
#
# rate = 1 / 26


# ============================================================
# a. Show the probability density function of the waiting time at Kroger
# ============================================================

# Create x-values from 0 to 180 seconds
x <- seq(0, 180, length.out = 500)

# Create the corresponding density values
pdf <- dexp(x, rate = 1 / 26)

# Store the x-values and density values in a data frame
df_pdf <- data.frame(
  x = x,
  density = pdf
)

# Plot the probability density function
ggplot(df_pdf, aes(x = x, y = density)) +
  geom_line(linewidth = 1.2) +
  ggtitle("PDF of Exponential Distribution for Kroger Waiting Times") +
  xlab("Waiting time in seconds") +
  ylab("Density") +
  theme_minimal()


# ============================================================
# b. Probability that a customer waits between 15 and 30 seconds
# ============================================================

# P(15 <= x <= 30)

pexp(30, rate = 1 / 26) -
  pexp(15, rate = 1 / 26)

# Answer:
# The probability is approximately 0.2461, or 24.61%.


# ============================================================
# c. Probability that a customer waits more than 2 minutes
# ============================================================

# 2 minutes = 120 seconds
#
# P(x > 120)

pexp(120, rate = 1 / 26, lower.tail = FALSE)

# Answer:
# The probability is approximately 0.0099, or 0.99%.


# ============================================================
# d. Minimum waiting time for 10% of Kroger's customers
# ============================================================

# This question asks for the waiting time that is not exceeded by 10%
# of customers.
#
# In other words:
#
# P(x <= waiting time) = 0.10

qexp(0.10, rate = 1 / 26, lower.tail = TRUE)

# Alternative version:
qexp(0.90, rate = 1 / 26, lower.tail = FALSE)

# Answer:
# The minimum waiting time for 10% of customers is approximately
# 2.74 seconds.
