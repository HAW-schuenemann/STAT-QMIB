############################################################
# Author: Jan-Hendrik Schünemann
# Contact: jan-hendrik.schuenemann(at)haw-hamburg.de
# Module: STAT
# Assignment / Task: Task 1 – Age distribution
# Version: v2.0
# Last Update: 2025-12-10
#
# Required Dataset(s): (hard-coded in script)
# Required Packages: summarytools
#
# R Version:
# Operating System:
# License: MIT
############################################################


## 1. Data entry -------------------------------------------------------------

age <- c(
  25, 28, 23, 24, 27, 24, 22, 32, 24, 26,
  28, 30, 26, 25, 24, 25, 24, 27, 25, 23
)


## 2. Frequency table using freq() ------------------------------------------

# If you have not installed the package yet:
# install.packages("summarytools")

library(summarytools)
# Loads the package summarytools.
# Required so R can use the function freq().

freq(age)
# Creates a frequency table including:
# - absolute frequencies
# - relative frequencies
# - cumulative absolute and cumulative relative frequencies
# This is the preferred method in this course.


## 3. Percentiles (P33 and P60) ---------------------------------------------

# quantile() calculates percentiles (and quartiles).
# type = 2 uses the (n + 1) rule discussed in class.
# → Only version that can be manually verified
# Other type values use different calculation methods.

quantile(age, probs = 0.33, type = 2, na.rm = TRUE)  # P33
quantile(age, probs = 0.60, type = 2, na.rm = TRUE)  # P60


## Optional: Manual frequency table (very basic) ----------------------------
# Only shown to understand the underlying logic

freq_abs <- table(age)
freq_rel <- freq_abs / length(age)
freq_rel_cum <- cumsum(freq_rel)

freq_table <- cbind(
  Absolute = freq_abs,
  Relative = round(freq_rel, 2),
  Cumulative_Relative = round(freq_rel_cum, 2)
)

freq_table
