# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 2 – Hypothesis Tests for Customer Satisfaction Data
# Version: v1.0
# Last Update: 2026-06-24
# Required Dataset(s): CustomerSat.rds
# Required Packages: car, jmv, misty, dplyr
# License: MIT
# ============================================================


# ============================================================
# Load packages
# ============================================================

# car is used for Levene's Test.
# jmv is used for the standard one way ANOVA.
# misty is used for Welch's ANOVA and Games Howell post hoc tests.
# dplyr is used for filtering the data where needed.

library(car)
library(jmv)
library(misty)
library(dplyr)


# ============================================================
# Load data
# ============================================================

# readRDS() loads an R data file in .rds format.
# The loaded object is stored as df so that we can access the variables
# with the structure df$variable_name.

df <- readRDS("CustomerSat.rds")


# ============================================================
# a. Age and average customer satisfaction
# ============================================================

# Claim:
# Age has a significant effect on the average satisfaction of customers.
#
# Since satispoints is metric and age has more than two independent groups,
# a one way ANOVA type test is appropriate.
#
# Before the ANOVA, Levene's Test is used to check whether the assumption
# of equal variances is plausible.
#
# Significance level:
# alpha = 0.01

# Hypotheses for Levene's Test:
#
# H1: At least one age group has a different variance.
# H0: The variances of satispoints are equal across all age groups.

leveneTest(
  data = df,
  satispoints ~ age,
  center = median
)

# As p = 7.66e-05 < 0.01 and F = 9.6329, H0 of Levene's Test can be rejected.
#
# It can be concluded at a significance level of 1% that the variances differ
# significantly between the age groups.
#
# Therefore, Welch's ANOVA is used instead of the standard one way ANOVA.

# Hypotheses for Welch's ANOVA:
#
# H1: At least one age group has a different mean satisfaction score.
# H0: The mean satisfaction score is equal across all age groups.

test.welch(
  data = df,
  satispoints ~ age,
  effsize = TRUE
)

# As p < 0.001 < 0.01 and F = 17.12, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that average customer satisfaction differs
# significantly between the age groups.
#
# eta squared = 0.05
# omega squared = 0.05
#
# This indicates a small effect.

# Since Welch's ANOVA is significant, Games Howell post hoc tests are used.
# Games Howell is appropriate here because equal variances cannot be assumed.

test.welch(
  data = df,
  satispoints ~ age,
  descript = TRUE,
  posthoc = TRUE
)

# The post hoc tests show the following results:
#
# 18 to under 35 years vs. 35 to under 50 years:
# Mean difference = 3.22, p = 0.444
#
# This difference is not statistically significant at the 1% level.
#
# 18 to under 35 years vs. 50 years and over:
# Mean difference = 13.52, p < 0.001
#
# Customers aged 50 years and over are significantly more satisfied on average
# than customers aged 18 to under 35 years at the 1% level.
#
# 35 to under 50 years vs. 50 years and over:
# Mean difference = 10.30, p < 0.001
#
# Customers aged 50 years and over are significantly more satisfied on average
# than customers aged 35 to under 50 years at the 1% level.
#
# ClickIT's assumption 1 can be confirmed at the 1% significance level.
#
# Age has a statistically significant effect on average customer satisfaction.
# The post hoc tests show that this effect is mainly driven by the oldest age group.
#
# Customers aged 50 years and over have significantly higher average satisfaction
# than both younger age groups.
#
# The two younger age groups do not differ significantly from each other.
#
# The head of marketing claims that customers under the age of 50 are on average
# significantly less satisfied than those aged 50 and over.
#
# This claim is correct at the 1% significance level because both age groups
# below 50 have significantly lower average satisfaction scores than the group
# aged 50 years and over.


# ============================================================
# b. Purchase and average customer satisfaction
# ============================================================

# Claim:
# Making a purchase has a significant positive effect on average customer
# satisfaction compared with not making a purchase.
#
# Since satispoints is metric and purchase has two independent groups,
# a two sample t-test is appropriate.
#
# Since the claim has a clear direction, a one sided test is used.
#
# The purchase variable is ordered as:
# No, Yes
#
# Therefore, R tests the difference:
# mean(No) - mean(Yes)
#
# To test whether customers without a purchase are less satisfied than customers
# with a purchase, the alternative must be "less".
#
# Significance level:
# alpha = 0.01

# Hypotheses:
#
# H1: mu_No < mu_Yes
# Customers who did not make a purchase are on average less satisfied than
# customers who made a purchase.
#
# H0: mu_No >= mu_Yes
# Customers who did not make a purchase are on average equally or more satisfied
# than customers who made a purchase.

t.test(
  data = df,
  satispoints ~ purchase,
  alternative = "less",
  conf.level = 0.99
)

# As p = 0.002774 < 0.01 and t = -2.7906, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that customers who did not make a purchase are
# on average less satisfied than customers who made a purchase.
#
# The mean satisfaction scores are:
#
# No purchase: 51.93
# Purchase:    58.08
#
# The 99% confidence interval for mean(No) - mean(Yes) is fully below 0:
# -Inf to -1.00005
#
# ClickIT's assumption 2 can be confirmed at the 1% significance level.
#
# Customers who did not make a purchase are on average significantly less satisfied.
# This follows from the significant one sided Welch two sample t-test and the lower
# sample mean for customers without a purchase.


# ============================================================
# c. Shopping frequency and average customer satisfaction
# ============================================================

# Claim:
# Shopping frequency has a significant effect on the average customer satisfaction.
#
# Since satispoints is metric and shopfreq has more than two independent groups,
# a one way ANOVA is appropriate.
#
# Before the ANOVA, Levene's Test is used to check whether the assumption
# of equal variances is plausible.
#
# Significance level:
# alpha = 0.01

# Hypotheses for Levene's Test:
#
# H1: At least one shopping frequency group has a different variance.
# H0: The variances of satispoints are equal across all shopping frequency groups.

leveneTest(
  data = df,
  satispoints ~ shopfreq,
  center = median
)

# As p = 0.1273 > 0.01 and F = 1.9069, H0 of Levene's Test cannot be rejected.
#
# It can be concluded at a significance level of 1% that there is no significant
# evidence against equal variances.
#
# Therefore, the standard one way ANOVA can be used.

# Hypotheses for the ANOVA:
#
# H1: At least one shopping frequency group has a different mean satisfaction score.
# H0: The mean satisfaction score is equal across all shopping frequency groups.

ANOVA(
  data = df,
  dep = satispoints,
  factors = shopfreq,
  effectSize = "eta"
)

# As p < 0.0000001 < 0.01 and F = 15.2712, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that average customer satisfaction differs
# significantly depending on shopping frequency.
#
# eta squared = 0.0731
#
# This means that around 7.31% of the variance in satispoints is explained
# by shopping frequency.
#
# This indicates a medium effect.

# Since the overall ANOVA is significant, post hoc tests are used to identify
# which shopping frequency groups differ significantly.
#
# Scheffe correction is used for the pairwise comparisons.

ANOVA(
  data = df,
  dep = satispoints,
  factors = shopfreq,
  postHoc = satispoints ~ shopfreq,
  postHocCorr = "scheffe"
)

# The post hoc tests show the following results:
#
# every 5-6 months or less often vs. every 3-4 months:
# Mean difference = 2.5625, p = 0.8456
#
# This difference is not statistically significant at the 1% level.
#
# every 5-6 months or less often vs. every 1-2 months:
# Mean difference = -13.0197, p = 0.0004
#
# Customers who shop every 5-6 months or less often are significantly less
# satisfied on average than customers who shop every 1-2 months.
#
# every 5-6 months or less often vs. every month or more often:
# Mean difference = -11.4962, p = 0.0008
#
# Customers who shop every 5-6 months or less often are significantly less
# satisfied on average than customers who shop every month or more often.
#
# every 3-4 months vs. every 1-2 months:
# Mean difference = -15.5822, p = 0.0000059
#
# Customers who shop every 3-4 months are significantly less satisfied
# on average than customers who shop every 1-2 months.
#
# every 3-4 months vs. every month or more often:
# Mean difference = -14.0587, p = 0.0000075
#
# Customers who shop every 3-4 months are significantly less satisfied
# on average than customers who shop every month or more often.
#
# every 1-2 months vs. every month or more often:
# Mean difference = 1.5235, p = 0.9649
#
# This difference is not statistically significant at the 1% level.
#
# ClickIT's assumption 3 can be confirmed at the 1% significance level.
#
# The post hoc tests show that customers become significantly less satisfied
# when they shop every 3-4 months or less often compared with customers who shop
# every 1-2 months or more often.
#
# The relevant threshold appears to be between "every 3-4 months" and
# "every 1-2 months".


# ============================================================
# d. Store and likelihood of repeat purchase
# ============================================================

# Task:
# Customers rated the likelihood of shopping again at the store where they
# were surveyed on a scale from 0 to 100.
#
# 0 = extremely unlikely
# 100 = extremely likely
#
# The aim is to test whether the store has a significant influence on the
# average likelihood of repeat purchase.
#
# Since repurchase is metric and store has more than two independent groups,
# a one way ANOVA is appropriate.
#
# Before the ANOVA, Levene's Test is used to check whether the assumption
# of equal variances is plausible.
#
# Significance level:
# alpha = 0.01

# Hypotheses for Levene's Test:
#
# H1: At least one store group has a different variance.
# H0: The variances of repurchase are equal across all stores.

leveneTest(
  data = df,
  repurchase ~ store,
  center = median
)

# As p = 0.6529 > 0.01 and F = 0.6138, H0 of Levene's Test cannot be rejected.
#
# It can be concluded at a significance level of 1% that there is no significant
# evidence against equal variances.
#
# Therefore, the standard one way ANOVA can be used.

# Hypotheses for the ANOVA:
#
# H1: At least one store has a different mean likelihood of repeat purchase.
# H0: The mean likelihood of repeat purchase is equal across all stores.

ANOVA(
  data = df,
  dep = repurchase,
  factors = store,
  effectSize = "eta"
)

# As p < 0.0000001 < 0.01 and F = 141.3349, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that the average likelihood of repeat purchase
# differs significantly between stores.
#
# eta squared = 0.4936
#
# This means that around 49.36% of the variance in repurchase is explained
# by the store.
#
# This indicates a large effect.

# Since the overall ANOVA is significant, post hoc tests are used to identify
# which stores differ significantly.
#
# Scheffe correction is used for the pairwise comparisons.

ANOVA(
  data = df,
  dep = repurchase,
  factors = store,
  postHoc = repurchase ~ store,
  postHocCorr = "scheffe"
)

# The post hoc tests show the following non-significant differences at the
# 1% significance level:
#
# Store 1 and Store 3:
# Mean difference = -3.4530, p = 0.0393
#
# Store 3 and Store 5:
# Mean difference = -0.6496, p = 0.9857
#
# All other store pairs differ significantly at the 1% level.
#
# Therefore, a significant influence of the store on the likelihood of repeat
# purchase can be confirmed at the 1% significance level.
#
# Store explains a substantial part of the differences in customers' likelihood
# of repeat purchase.
