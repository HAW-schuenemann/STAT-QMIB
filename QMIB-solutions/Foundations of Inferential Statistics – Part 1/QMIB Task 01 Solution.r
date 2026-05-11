# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 1 – Uniform Distribution and RAND
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
# Exercise 1
# ============================================================

# The Excel RAND function generates random numbers between 0 and 1.
# Therefore, x follows a continuous uniform distribution on the interval [0, 1].
#
# The probability density function is:
#
# f(x) = 1 for 0 <= x <= 1
# f(x) = 0 elsewhere
#
# In R, the uniform distribution can be handled with:
#
# dunif() = density of the uniform distribution
# punif() = cumulative probability of the uniform distribution


# ============================================================
# a. Graph the probability density function
# ============================================================

# Create x-values from below 0 to above 1
x <- seq(-0.5, 1.5, length.out = 200)

# Create the density values of the Uniform(0,1) distribution
pdf <- ifelse(x >= 0 & x <= 1, 1, 0)

# Store the x-values and density values in a data frame
df_pdf <- data.frame(
  x = x,
  density = pdf
)

# Plot the probability density function
ggplot(df_pdf, aes(x = x, y = density)) +
  geom_step(color = "blue", linewidth = 1.5) +
  ggtitle("PDF of Uniform(0,1) Distribution") +
  ylab("Density") +
  xlab("x") +
  theme_minimal()


# ============================================================
# b. Probability of generating a number between 0.25 and 0.75
# ============================================================

# P(0.25 <= x <= 0.75)

punif(0.75, min = 0, max = 1) -
  punif(0.25, min = 0, max = 1)

# Answer:
# The probability is 0.50, or 50%.


# ============================================================
# c. Probability of generating a number less than 0.30
# ============================================================

# P(x < 0.30)

punif(0.30, min = 0, max = 1)

# Answer:
# The probability is 0.30, or 30%.


# ============================================================
# d. Probability of generating a number greater than 0.60
# ============================================================

# P(x > 0.60)

# Option 1:
1 - punif(0.60, min = 0, max = 1)

# Option 2:
punif(0.60, min = 0, max = 1, lower.tail = FALSE)

# Note:
# The following would also give 0.40, but it answers a different question:
# P(x <= 0.40)

punif(0.40, min = 0, max = 1)

# Answer:
# The probability is 0.40, or 40%.


# ============================================================
# e. Probability of generating the random number 0.99999
# ============================================================

# For a continuous random variable, the probability of obtaining one exact
# value is always 0.
#
# Therefore:
#
# P(x = 0.99999) = 0

0

# Important:
# dunif(0.99999, min = 0, max = 1) gives the density at x = 0.99999,
# not the probability of getting exactly this value.

dunif(0.99999, min = 0, max = 1)

# Answer:
# The probability is 0.
# The density at this point is 1, but the probability of a single exact value
# in a continuous distribution is 0.
