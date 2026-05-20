# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 2: Hypothesis Tests for QuestionAir Data
# Version: v1.0
# Last Update: 2026-05-20
# Required Dataset(s): RQuestionAir.rds
# Required Packages: dplyr, gmodels
# License: MIT
# ============================================================

# ============================================================
# Load data
# ============================================================

# readRDS() loads an R data file in .rds format.
# The loaded object is stored as df so that we can access the variables
# with the structure df$variable_name.

df <- readRDS("RQuestionAir.rds")


# ============================================================
# a. Average reputation by gender
# ============================================================

# Claim:
# Female customers attribute a higher reputation on average than male customers.
#
# H1: mu_reputation_female > mu_reputation_male
# H0: mu_reputation_female <= mu_reputation_male

# t.test() performs a t-test.
#
# Here, we use a two-sample t-test because we compare the mean of a metric
# variable between two independent groups.
#
# The formula structure is:
#
# metric variable ~ grouping variable
#
# reputation is the metric variable.
# gender is the grouping variable.
#
# alternative = "greater" is used because the claim states that the mean
# reputation of the first group shown by R is higher than the mean reputation
# of the second group.
#
# conf.level = 0.99 is used because the significance level is 1%.

t.test(
  reputation ~ gender,
  data = df,
  alternative = "greater",
  conf.level = 0.99
)

# As p = 0.02951 > 0.01 and t = 1.8922, H0 cannot be rejected.
#
# It can be concluded at a significance level of 1% that there is not enough
# evidence which would support H1 claiming that female customers attribute a
# higher reputation on average than male customers.


# ============================================================
# b. Average satisfaction by gender
# ============================================================

# Claim:
# Male customers are less satisfied on average than female customers.
#
# H1: mu_satisfaction_male < mu_satisfaction_female
# H0: mu_satisfaction_male >= mu_satisfaction_female

# This is a two-sample t-test because we compare average satisfaction
# between female and male customers.
#
# alternative = "greater" is used here because of the order in which R compares
# the gender groups. The test checks whether the mean satisfaction of the first
# group is greater than the mean satisfaction of the second group.

t.test(
  satisfaction ~ gender,
  data = df,
  alternative = "greater",
  conf.level = 0.99
)

# As p = 0.002533 < 0.01 and t = 2.8374, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that male customers are less satisfied on average
# than female customers.


# ============================================================
# c. Average commitment by gender
# ============================================================

# Claim:
# The average commitment of female and male customers differs significantly.
#
# H1: mu_commitment_female != mu_commitment_male
# H0: mu_commitment_female = mu_commitment_male

# This is a two-sided two-sample t-test because the claim is about a difference
# in either direction.
#
# alternative = "two.sided" tests whether the two group means are significantly
# different from each other.

t.test(
  commitment ~ gender,
  data = df,
  alternative = "two.sided",
  conf.level = 0.99
)

# As p = 0.01424 > 0.01 and t = 2.4724, H0 cannot be rejected.
#
# It can be concluded at a significance level of 1% that there is not enough
# evidence which would support H1 claiming that the average commitment of female
# and male customers differs significantly.


# ============================================================
# d. Average satisfaction by flight type
# ============================================================

# Claim:
# Customers who last had a domestic flight are less satisfied on average than
# customers who last had an international flight.
#
# H1: mu_satisfaction_domestic < mu_satisfaction_international
# H0: mu_satisfaction_domestic >= mu_satisfaction_international

# This is a two-sample t-test because we compare satisfaction between two
# independent groups.
#
# alternative = "less" is used because the claim states that the mean satisfaction
# of the domestic group is lower than the mean satisfaction of the international
# group.

t.test(
  satisfaction ~ flight_type,
  data = df,
  alternative = "less",
  conf.level = 0.99
)

# As p = 0.007215 < 0.01 and t = -2.4593, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that customers who last had a domestic flight are
# less satisfied on average than customers who last had an international flight.


# ============================================================
# e. Average loyalty by flight type
# ============================================================

# Claim:
# The loyalty of customers who last had a domestic flight differs significantly
# on average from the loyalty of customers who last had an international flight.
#
# H1: mu_loyalty_domestic != mu_loyalty_international
# H0: mu_loyalty_domestic = mu_loyalty_international

# This is a two-sided two-sample t-test because the claim is about a significant
# difference, without specifying a direction.

t.test(
  loyalty ~ flight_type,
  data = df,
  alternative = "two.sided",
  conf.level = 0.99
)

# As p = 0.006152 < 0.01 and t = -2.7584, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that the average loyalty of customers who last had a
# domestic flight differs significantly from the average loyalty of customers who
# last had an international flight.


# ============================================================
# f. Average commitment by flight purpose
# ============================================================

# Claim:
# Customers who last flew for private purposes are on average less committed
# than customers who last flew for business purposes.
#
# H1: mu_commitment_business > mu_commitment_private
# H0: mu_commitment_business <= mu_commitment_private

# This is a two-sample t-test because we compare commitment between business
# and private travellers.
#
# alternative = "greater" is used because the hypothesis is written as:
#
# mu_commitment_business > mu_commitment_private

t.test(
  commitment ~ flight_purpose,
  data = df,
  alternative = "greater",
  conf.level = 0.99
)

# As p = 1 > 0.01 and t = -4.5763, H0 cannot be rejected.
#
# It can be concluded at a significance level of 1% that there is not enough
# evidence which would support H1 claiming that customers who last flew for
# private purposes are on average less committed than customers who last flew
# for business purposes.


# ============================================================
# g. Business flight purpose by gender
# ============================================================

# Claim:
# The proportion of customers who last flew for business purposes is
# significantly higher among male customers than among female customers.
#
# H1: pi_business_male > pi_business_female
# H0: pi_business_male <= pi_business_female

# table() gives the absolute frequencies for categorical variables.
#
# Here, table(df$flight_purpose, df$gender) shows how flight purpose is
# distributed across gender groups.
#
# addmargins() adds row or column totals to the table.
# margin = 1 adds totals across the rows.
# This helps to identify the relevant counts for the proportion test.

addmargins(table(df$flight_purpose, df$gender), margin = 1)

# prop.test() performs a test for proportions.
#
# For a two-sample proportion test:
#
# x = vector with the number of successes in each group
# n = vector with the total number of observations in each group
#
# Here, "success" means business flight.
#
# x = c(449, 76) contains the number of business flights for male and female
# customers.
#
# n = c(785, 280) contains the total number of male and female customers.
#
# alternative = "greater" tests whether the first proportion is greater than
# the second proportion.
#
# correct = FALSE switches off Yates' continuity correction.

prop.test(
  x = c(449, 76),
  n = c(785, 280),
  alternative = "greater",
  conf.level = 0.99,
  correct = FALSE
)

# As p < 2.2e-16 < 0.01 and χ² = 74.584, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that the proportion of customers who last flew for
# business purposes is significantly higher among male customers than among female
# customers.


# ============================================================
# h. Economy class by flight type
# ============================================================

# Claim:
# The proportion of customers who last flew economy class is significantly higher
# among customers who had an international flight than among customers who had a
# domestic flight.
#
# H1: pi_economy_international > pi_economy_domestic
# H0: pi_economy_international <= pi_economy_domestic

# We first check the absolute frequencies.
#
# The table shows flight class by flight type.
# addmargins(..., margin = 2) adds column totals.

addmargins(table(df$flight_class, df$flight_type), margin = 2)

# This is a two-sample proportion test.
#
# "Success" means economy class.
#
# x = c(361, 504) contains the number of economy class customers in the two
# flight type groups.
#
# n = c(507, 558) contains the total number of customers in the two flight type
# groups.
#
# alternative = "greater" tests whether the first proportion is greater than
# the second proportion.

prop.test(
  x = c(361, 504),
  n = c(507, 558),
  alternative = "greater",
  conf.level = 0.99,
  correct = FALSE
)

# As p = 1 > 0.01 and χ² = 63.664, H0 cannot be rejected.
#
# It can be concluded at a significance level of 1% that there is not enough
# evidence which would support H1 claiming that the proportion of customers who
# last flew economy class is significantly higher among customers who had an
# international flight than among customers who had a domestic flight.


# ============================================================
# i. Silver traveller status by flight class
# ============================================================

# Claim:
# The proportion of customers who have Silver traveller status differs
# significantly between customers whose last flight was a First/Business Class
# flight and customers whose last flight was an Economy Class flight.
#
# H1: pi_silver_business_first != pi_silver_economy
# H0: pi_silver_business_first = pi_silver_economy

# We first check the absolute frequencies of traveller status by flight class.

addmargins(table(df$status, df$flight_class), margin = 1)

# This is a two-sample proportion test.
#
# "Success" means Silver traveller status.
#
# alternative = "two.sided" is used because the claim is about a difference
# between the proportions in either direction.

prop.test(
  x = c(47, 198),
  n = c(200, 865),
  alternative = "two.sided",
  conf.level = 0.99,
  correct = FALSE
)

# As p = 0.8535 > 0.01 and χ² = 0.034106, H0 cannot be rejected.
#
# It can be concluded at a significance level of 1% that there is not enough
# evidence which would support H1 claiming that the proportion of customers who
# have Silver traveller status differs significantly between customers whose last
# flight was a First/Business Class flight and customers whose last flight was an
# Economy Class flight.


# ============================================================
# j. Average loyalty compared with satisfaction
# ============================================================

# Claim:
# On average, the loyalty of customers is significantly higher than their
# satisfaction.
#
# H1: mu_loyalty > mu_satisfaction
# H0: mu_loyalty <= mu_satisfaction

# Here, we use a paired t-test.
#
# A paired t-test is used when two metric variables are measured for the same
# observations.
#
# In this case, each customer has a loyalty value and a satisfaction value.
# Therefore, the two values are linked within each customer.
#
# paired = TRUE tells R to compare the within-customer differences.
#
# alternative = "greater" tests whether the mean of x is greater than the mean
# of y.

t.test(
  x = df$loyalty,
  y = df$satisfaction,
  paired = TRUE,
  alternative = "greater",
  conf.level = 0.99
)

# As p = 0.006388 < 0.01 and t = 2.5244, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that the loyalty of customers is on average
# significantly higher than their satisfaction.


# ============================================================
# k. Average satisfaction compared with commitment
# ============================================================

# Claim:
# On average, there is a significant difference between the satisfaction of
# customers and their commitment.
#
# H1: mu_satisfaction != mu_commitment
# H0: mu_satisfaction = mu_commitment

# This is again a paired t-test because satisfaction and commitment are measured
# for the same customers.
#
# alternative = "two.sided" is used because the claim is about a difference in
# either direction.

t.test(
  x = df$satisfaction,
  y = df$commitment,
  paired = TRUE,
  alternative = "two.sided",
  conf.level = 0.99
)

# As p = 4.913e-06 < 0.01 and t = 4.7197, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that there is a significant difference between the
# average satisfaction and the average commitment of customers.


# ============================================================
# l. Commitment compared with loyalty for Business/First Class customers
# ============================================================

# Claim:
# On average, there is no difference between the commitment and the loyalty of
# customers whose last flight was a First/Business Class flight.
#
# H1: mu_commitment_business_first != mu_loyalty_business_first
# H0: mu_commitment_business_first = mu_loyalty_business_first

# library() loads an R package so that its functions can be used.
#
# dplyr is used here because filter() makes it easy to create a subset of the
# data.

library(dplyr)

# filter() keeps only rows that meet a condition.
#
# Here, we keep only customers whose last flight was Business/First Class.

df_bf <- df %>%
  filter(flight_class == "Business/First")

# This is a paired t-test because commitment and loyalty are measured for the
# same Business/First Class customers.

t.test(
  df_bf$commitment,
  df_bf$loyalty,
  paired = TRUE,
  alternative = "two.sided",
  conf.level = 0.99
)

# As p = 0.04147 > 0.01 and t = -2.1191, H0 cannot be rejected.
#
# It can be concluded at a significance level of 1% that there is not enough
# evidence which would support H1 claiming that, on average, there is a significant
# difference between the commitment and loyalty of customers whose last flight was
# a First/Business Class flight.


# ============================================================
# m. Traveller status and class of last flight
# ============================================================

# Claim:
# The traveller status and the class of the last flight are dependent on each
# other.
#
# H1: traveller status and class of last flight are dependent on each other
# H0: traveller status and class of last flight are independent of each other

# We first create a contingency table.
#
# A contingency table shows the joint frequencies of two categorical variables.
# This is the input for a chi-square test of independence.

sctable <- table(df$status, df$flight_class)
sctable

# chisq.test() performs a chi-square test.
#
# Here, it is used as a chi-square test of independence.
# The test checks whether two categorical variables are statistically
# independent.
#
# correct = FALSE switches off Yates' continuity correction.
#
# H0 means that the two variables are independent.
# H1 means that the two variables are dependent.

chisq.test(
  sctable,
  correct = FALSE
)

# As p < 2.2e-16 < 0.01 and χ² = 146.28, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that traveller status and the class of the last flight
# are dependent on each other.

# gmodels provides CrossTable().
#
# CrossTable() displays a contingency table with additional information such as
# proportions and chi-square contributions.
#
# prop.t = FALSE suppresses proportions based on the total table.

library(gmodels)

CrossTable(
  df$status,
  df$flight_class,
  prop.t = FALSE
)

# Based on the sample data, the dependence is mainly driven by Gold customers:
#
# Gold among Business/First = 78 / 200 = 39.0%
# Gold among Economy        = 65 / 865 = 7.5%
#
# Gold customers are therefore much more common among customers whose last flight
# was Business/First Class.
#
# For Blues customers, the opposite pattern can be observed:
#
# Blues among Business/First = 75 / 200 = 37.5%
# Blues among Economy        = 602 / 865 = 69.6%
#
# Blues customers are much more common among Economy Class customers.
#
# For Silver customers, the proportions are almost identical:
#
# Silver among Business/First = 47 / 200 = 23.5%
# Silver among Economy        = 198 / 865 = 22.9%
#
# The highest chi-square contribution comes from the cell Gold and Business/First
# with 97.409, meaning this cell contributes most strongly to the detected
# dependence.


# ============================================================
# n. Date of last flight and purpose of last flight
# ============================================================

# Claim:
# The date of the last flight and the purpose of it are dependent on each other.
#
# H1: date of the last flight and purpose of the last flight are dependent on each other
# H0: date of the last flight and purpose of the last flight are independent of each other

# We first create a contingency table.

fptable <- table(df$flight_latest, df$flight_purpose)
fptable

# This is a chi-square test of independence because both variables are
# categorical.

chisq.test(
  fptable,
  correct = FALSE
)

# As p < 2.2e-16 < 0.01 and χ² = 110.29, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that the date of the last flight and the purpose of
# the last flight are dependent on each other.

# CrossTable() is used to inspect the structure of the dependence more closely.

CrossTable(
  df$flight_latest,
  df$flight_purpose,
  prop.t = FALSE
)

# within last week:      135 / 190 = 71.1% Business
# within last month:     163 / 253 = 64.4% Business
# within last 3 months:  128 / 296 = 43.2% Business
# within last 6 months:   58 / 187 = 31.0% Business
# within last 12 months:  41 / 139 = 29.5% Business
#
# The longer ago the last flight was, the lower the proportion of business
# flights becomes. Private flights show the opposite pattern. The highest
# chi-square contributions occur especially for the most recent flights and the
# less recent flights, meaning these cells contribute strongly to the detected
# dependence.


# ============================================================
# o. Gender and type of last flight
# ============================================================

# Claim:
# Gender and the type of the last flight are dependent on each other.
#
# H1: gender and type of last flight are dependent on each other
# H0: gender and type of last flight are independent of each other

# We first create a contingency table.

gttable <- table(df$gender, df$flight_type)
gttable

# This is a chi-square test of independence because both variables are
# categorical.

chisq.test(
  gttable,
  correct = FALSE
)

# As p = 0.1028 > 0.01 and χ² = 2.6611, H0 cannot be rejected.
#
# It can be concluded at a significance level of 1% that there is not enough
# evidence which would support H1 claiming that gender and the type of the last
# flight are dependent on each other.
