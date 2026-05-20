# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 1 – Hypothesis Tests for Department Store Data
# Version: v1.0
# Last Update: 2026-05-20
# Required Dataset(s): RDepartmentstore.rds
# Required Packages: None
# License: MIT
# ============================================================

# ============================================================
# Load data
# ============================================================

# readRDS() loads an R data file in .rds format.
# The loaded object is stored as df so that we can access the variables
# with the structure df$variable_name.

df <- readRDS("RDepartmentstore data.rds")


# ============================================================
# a. Proportion of customers who ordered the last catalogue
# ============================================================

# Claim:
# “The proportion of customers who have ordered our last catalogue
# is above 15%”.
#
# H1: pi_response > 0.15
# H0: pi_response <= 0.15

# table() gives the absolute frequencies of a variable.
# We use it here to find the number of customers who ordered the last catalogue.
#
# The count for the relevant category is then used as x in prop.test().

table(df$response)

# prop.test() performs a test for proportions.
#
# x = number of observed successes
# n = total number of observations
# p = hypothesised population proportion under H0
# alternative = direction of H1
# conf.level = confidence level
# correct = FALSE switches off Yates' continuity correction
#
# Since the claim says "above 15%", we use alternative = "greater".

prop.test(
  x = 121,
  n = 1000,
  p = 0.15,
  alternative = "greater",
  conf.level = 0.95,
  correct = FALSE
)

# As p = 0.9949 > 0.05 and χ² = 6.5961, H0 cannot be rejected.
#
# It can be concluded at a significance level of 5% that there is not enough
# evidence which would support H1 claiming that the proportion of customers who
# have ordered the last catalogue is above 15%.


# ============================================================
# b. Average annual net income of customers
# ============================================================

# Claim:
# “The average annual net income of our customers exceeds 50,000 US$”.
#
# H1: mu_income > 50000
# H0: mu_income <= 50000
#
# Note:
# The income variable is measured in thousand US$.
# Therefore, 50,000 US$ is entered as 50.

# t.test() performs a t-test.
#
# Here, we use a one-sample t-test because we compare the sample mean
# of one metric variable against a hypothesised value.
#
# df$income is the variable being tested.
# mu = 50 is the hypothesised mean under H0.
# alternative = "greater" is used because the claim says "exceeds".

t.test(
  df$income,
  alternative = "greater",
  mu = 50,
  conf.level = 0.95
)

# As p = 0.0006709 < 0.05 and t = 3.2168, H0 can be rejected.
#
# It can be concluded at a significance level of 5% that there is enough evidence
# which supports H1 claiming that the average annual net income of the customers
# exceeds 50,000 US$.


# ============================================================
# c. Average age by TV purchase
# ============================================================

# Claim:
# “There is no difference between the average age of our customers who have not
# bought a new TV set in the last 24 months and those who have”.
#
# H1: mu_age_tvpurchase_No != mu_age_tvpurchase_Yes
# H0: mu_age_tvpurchase_No = mu_age_tvpurchase_Yes

# Here, t.test() is used as a two-sample t-test.
#
# The formula structure is:
#
# metric variable ~ grouping variable
#
# df$age is the metric variable.
# df$tvpurchase is the grouping variable.
#
# alternative = "two.sided" is used because the claim is about a difference
# in either direction.

t.test(
  df$age ~ df$tvpurchase,
  alternative = "two.sided",
  conf.level = 0.95
)

# As p < 2.2e-16 < 0.05 and t = -9.8791, H0 can be rejected.
#
# It can be concluded at a significance level of 5% that there is enough evidence
# which supports H1 claiming that the average age of customers who have not bought
# a new TV set in the last 24 months and those who have bought one is significantly
# different.


# ============================================================
# d. Daily newspaper subscription
# ============================================================

# Claim:
# “Fewer than half of our customers have a daily newspaper subscription”.
#
# H1: pi_news < 0.50
# H0: pi_news >= 0.50

# We use table() again to find the count of customers with a daily newspaper
# subscription.

table(df$news)

# This is again a one-sample test for a proportion.
#
# x = 471 is the number of customers with a daily newspaper subscription.
# n = 1000 is the total sample size.
# p = 0.50 is the hypothesised proportion under H0.
#
# Since the claim says "fewer than half", we use alternative = "less".

prop.test(
  x = 471,
  n = 1000,
  p = 0.50,
  alternative = "less",
  conf.level = 0.95,
  correct = FALSE
)

# As p = 0.03332 < 0.05 and χ² = 3.364, H0 can be rejected.
#
# It can be concluded at a significance level of 5% that there is enough evidence
# which supports H1 claiming that fewer than half of the customers have a daily
# newspaper subscription.


# ============================================================
# e. Weekly TV viewing time by marital status
# ============================================================

# Claim:
# Married customers have on average a higher weekly TV viewing time than
# unmarried customers.
#
# H1: mu_hourstv_married > mu_hourstv_unmarried
# H0: mu_hourstv_married <= mu_hourstv_unmarried

# This is a two-sample t-test because we compare the mean weekly TV viewing time
# between two independent groups.
#
# df$hourstv is the metric variable.
# df$marital is the grouping variable.
#
# The direction of alternative depends on the order in which R compares the
# groups. Here, alternative = "less" matches the intended comparison based on
# the coding and ordering of df$marital.

t.test(
  df$hourstv ~ df$marital,
  alternative = "less",
  conf.level = 0.95
)

# As p = 0.3258 > 0.05 and t = -0.45158, H0 cannot be rejected.
#
# It can be concluded at a significance level of 5% that there is not enough
# evidence which would support H1 claiming that married customers have on average
# a higher weekly TV viewing time than unmarried customers.


# ============================================================
# f. Average amount of financing granted for purchases
# ============================================================

# Claim:
# The average amount of financing granted for purchases of the customers
# is below 1,400 US$.
#
# H1: mu_debt < 1400
# H0: mu_debt >= 1400

# This is a one-sample t-test because we compare the sample mean of debt
# against the hypothesised value of 1,400.
#
# Since the claim says "below 1,400", we use alternative = "less".

t.test(
  df$debt,
  alternative = "less",
  mu = 1400,
  conf.level = 0.95
)

# As p = 0.976 > 0.05 and t = 1.9791, H0 cannot be rejected.
#
# It can be concluded at a significance level of 5% that there is not enough
# evidence which would support H1 claiming that the average amount of financing
# granted for purchases of the customers is below 1,400 US$.


# ============================================================
# g. Average annual net income by gender
# ============================================================

# Claim:
# The average annual net income of male customers is higher than that of
# female customers.
#
# H1: mu_income_male > mu_income_female
# H0: mu_income_male <= mu_income_female

# This is a two-sample t-test because we compare mean income between two
# independent groups.
#
# df$income is the metric variable.
# df$gender is the grouping variable.
#
# alternative = "greater" is used because the claim states that the mean
# income of the first group shown by R is higher than the mean income of
# the second group.

t.test(
  df$income ~ df$gender,
  alternative = "greater",
  conf.level = 0.95
)

# As p = 0.02699 < 0.05 and t = 1.9299, H0 can be rejected.
#
# It can be concluded at a significance level of 5% that there is enough evidence
# which supports H1 claiming that the average annual net income of male customers
# is higher than that of female customers.


# ============================================================
# h. Average age by catalogue response
# ============================================================

# Claim:
# Customers who have ordered the last catalogue are on average older than those
# who have not ordered it.
#
# H1: mu_age_response_Yes > mu_age_response_No
# H0: mu_age_response_Yes <= mu_age_response_No

# This is a two-sample t-test because we compare the average age between
# customers who ordered the catalogue and those who did not.
#
# df$age is the metric variable.
# df$response is the grouping variable.
#
# The direction of alternative depends on the order in which R compares the
# response groups. Here, alternative = "less" matches the intended comparison
# based on the coding and ordering of df$response.

t.test(
  df$age ~ df$response,
  alternative = "less",
  conf.level = 0.95
)

# As p = 0.9707 > 0.05 and t = 1.904, H0 cannot be rejected.
#
# It can be concluded at a significance level of 5% that there is not enough
# evidence which would support H1 claiming that customers who have ordered the
# last catalogue are on average older than those who have not ordered it.
