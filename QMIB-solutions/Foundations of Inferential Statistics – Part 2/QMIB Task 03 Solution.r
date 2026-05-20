
```r
# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 3: Hypothesis Tests for Superbank Data
# Version: v1.0
# Last Update: 2026-05-20
# Required Dataset(s): RSuperbank.rds
# Required Packages: dplyr
# License: MIT
# ============================================================

# ============================================================
# Load data
# ============================================================

# readRDS() loads an R data file in .rds format.
# The loaded object is stored as df so that we can access the variables
# with the structure df$variable_name.

df <- readRDS("RSuperbank.rds")


# ============================================================
# a. Age and years with current or last employer
# ============================================================

# Claim:
# There is a significant relationship between the age of the customers
# and the years with their current or last employer:
# the older a customer is, the longer they have been with their current
# or last employer.
#
# H1: cor_age_employer > 0
# H0: cor_age_employer <= 0

# cor() calculates the correlation coefficient between two variables.
#
# method = "pearson" calculates the Pearson correlation.
# Pearson correlation measures the strength of a linear relationship
# between two metric variables.
#
# use = "complete.obs" tells R to only use observations where both variables
# are available. This avoids problems caused by missing values.

corP <- cor(
  df$age,
  df$employer,
  use = "complete.obs",
  method = "pearson"
)

corP

# method = "spearman" calculates the Spearman rank correlation.
# Spearman correlation measures whether there is a monotonic relationship.
# It is less sensitive to non-linear relationships and outliers than Pearson.

corS <- cor(
  df$age,
  df$employer,
  use = "complete.obs",
  method = "spearman"
)

corS

# This compares Pearson and Spearman correlation.
# It shows by how many percent Pearson differs from Spearman.

(corP / corS - 1) * 100

# cor.test() tests whether a correlation is statistically significant.
#
# Here, we test the Pearson correlation because the claim refers to a positive
# linear relationship between age and years with the employer.
#
# alternative = "greater" is used because the claim states a positive
# relationship.
#
# conf.level = 0.99 is used because the significance level is 1%.

cor.test(
  df$age,
  df$employer,
  alternative = "greater",
  method = "pearson",
  conf.level = 0.99
)

# As p < 2.2e-16 < 0.01 and t = 24.435, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that there is a significant positive linear relationship
# between the age of the customers and the years with their current or last employer.


# ============================================================
# b. Likelihood to recommend and service rating
# ============================================================

# Claim:
# There is a significant relationship between the likelihood to recommend
# Superbank and its service rating regarding the last 12 months.
#
# H1: cor_recommend_service != 0
# H0: cor_recommend_service = 0

# Spearman correlation is used because both variables are ordinal.
#
# as.numeric() converts the variables into numeric values so that R can calculate
# the correlation. This is needed if the variables are stored as factors or
# labelled categories.

corS <- cor(
  as.numeric(df$recommend),
  as.numeric(df$service),
  use = "complete.obs",
  method = "spearman"
)

corS

# This tests whether the Spearman correlation is significantly different from 0.
#
# alternative = "two.sided" is used because the claim is about a significant
# relationship, without specifying a positive or negative direction.
#
# exact = FALSE is used because exact p-values are often not available for
# Spearman tests with ties or larger samples.

cor.test(
  as.numeric(df$recommend),
  as.numeric(df$service),
  alternative = "two.sided",
  method = "spearman",
  conf.level = 0.99,
  exact = FALSE
)

# As p < 2.2e-16 < 0.01, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that there is a significant relationship between the
# likelihood to recommend Superbank and its service rating regarding the last 12 months.


# ============================================================
# c. Household size and personal monthly net income
# ============================================================

# Claim:
# There is no significant relationship between the number of persons
# in the customers' household and their personal monthly net income.
#
# H1: cor_pershh_income != 0
# H0: cor_pershh_income = 0

# We first compare Pearson and Spearman correlation.
# This helps to check whether the relationship is similarly represented
# as a linear relationship and as a rank-based relationship.

corP <- cor(
  df$pershh,
  df$income,
  use = "complete.obs",
  method = "pearson"
)

corP

corS <- cor(
  df$pershh,
  df$income,
  use = "complete.obs",
  method = "spearman"
)

corS

# Percentage deviation between Pearson and Spearman

(corP / corS - 1) * 100

# The test is performed with Spearman correlation because household size
# is a count variable and may not behave like a continuous metric variable.

cor.test(
  df$pershh,
  df$income,
  alternative = "two.sided",
  method = "spearman",
  conf.level = 0.99,
  exact = FALSE
)

# As p = 0.703 > 0.01, H0 cannot be rejected.
#
# It can be concluded at a significance level of 1% that there is not enough evidence
# which would support H1 claiming that there is a significant relationship between
# the number of persons in the customers' household and their personal monthly net income.


# ============================================================
# d. Personal monthly income by credit offer acceptance
# ============================================================

# Claim:
# Customers who have accepted the credit offer have on average a lower
# personal monthly income than those who have not accepted the offer.
#
# H1: mu_income_accepted < mu_income_not_accepted
# H0: mu_income_accepted >= mu_income_not_accepted

# t.test() performs a t-test.
#
# Here, we use a two-sample t-test because we compare the mean income
# between two independent groups.
#
# The formula structure is:
#
# metric variable ~ grouping variable
#
# income is the metric variable.
# creditoffer is the grouping variable.
#
# alternative = "greater" is used because of the order in which R compares
# the groups. The test checks whether the mean income of the first group
# is greater than the mean income of the second group.

t.test(
  income ~ creditoffer,
  data = df,
  alternative = "greater",
  conf.level = 0.99
)

# As p = 1.818e-06 < 0.01 and t = 4.6989, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that customers who have accepted the credit offer have
# on average a lower personal monthly income than those who have not accepted the offer.


# ============================================================
# e. Current account balance by savings account ownership
# ============================================================

# Claim:
# Customers who have a Superbank savings account have on average a lower
# current account balance than those who do not have a savings account.
#
# H1: mu_current_savings_yes < mu_current_savings_no
# H0: mu_current_savings_yes >= mu_current_savings_no

# This is a two-sample t-test because we compare the mean current account
# balance between customers with and without a savings account.
#
# alternative = "greater" is used because of the order in which R compares
# the groups.

t.test(
  current ~ savings,
  data = df,
  alternative = "greater",
  conf.level = 0.99
)

# As p = 0.296 > 0.01 and t = 0.53613, H0 cannot be rejected.
#
# It can be concluded at a significance level of 1% that there is not enough evidence
# which would support H1 claiming that customers who have a Superbank savings account
# have on average a lower current account balance than those who do not have a savings
# account.


# ============================================================
# f. Age and likelihood to recommend for customers aged 18 to 25
# ============================================================

# Claim:
# In the segment of customers aged between 18 and 25 years there is
# a positive relationship between age and likelihood to recommend Superbank.
#
# H1: corS_age_recommend > 0
# H0: corS_age_recommend <= 0

# library() loads an R package so that its functions can be used.
#
# dplyr is used here because filter() makes it easy to create subsets
# of the data.

library(dplyr)

# filter() keeps only rows that meet a condition.
#
# Here, we keep only customers in the age category "18 to 25 years".

df_18_25 <- df %>%
  filter(age_cat == "18 to 25 years")

# Spearman correlation is used because likelihood to recommend is ordinal.
#
# as.numeric() converts the recommendation variable into numeric values
# so that the rank correlation can be calculated.

corS <- cor(
  df_18_25$age,
  as.numeric(df_18_25$recommend),
  use = "complete.obs",
  method = "spearman"
)

corS

# alternative = "greater" is used because the claim states a positive
# relationship.

cor.test(
  df_18_25$age,
  as.numeric(df_18_25$recommend),
  alternative = "greater",
  method = "spearman",
  conf.level = 0.99,
  exact = FALSE
)

# As p = 0.04862 > 0.01, H0 cannot be rejected.
#
# It can be concluded at a significance level of 1% that there is not enough evidence
# which would support H1 claiming that there is a positive relationship between age
# and likelihood to recommend Superbank in the segment of customers aged between
# 18 and 25 years.


# ============================================================
# g. Age and likelihood to recommend
# ============================================================

# Claim:
# There is a significant relationship between the age of the customers
# and their likelihood to recommend Superbank:
# the older the customers are the more likely they will recommend Superbank.
#
# H1: corS_age_recommend < 0
# H0: corS_age_recommend >= 0

# Spearman correlation is used because likelihood to recommend is ordinal.
#
# Note:
# The direction of the hypothesis depends on the coding of the recommendation
# variable. If lower numeric values indicate a higher likelihood to recommend,
# then "older customers are more likely to recommend" corresponds to a negative
# correlation.

corS <- cor(
  df$age,
  as.numeric(df$recommend),
  use = "complete.obs",
  method = "spearman"
)

corS

# alternative = "less" is used because the coding implies that a higher likelihood
# to recommend is represented by lower numeric values.

cor.test(
  df$age,
  as.numeric(df$recommend),
  alternative = "less",
  method = "spearman",
  conf.level = 0.99,
  exact = FALSE
)

# As p = 0.3509 > 0.01, H0 cannot be rejected.
#
# It can be concluded at a significance level of 1% that there is not enough evidence
# which would support H1 claiming that there is a significant negative relationship
# between the age of the customers and their likelihood to recommend Superbank.


# ============================================================
# h. Current account balance and last credit card statement
#    for customers aged 18 to 35 with a Superbank credit card
# ============================================================

# Claim:
# Among customers aged between 18 and 35 possessing a Superbank credit card,
# there exists a negative relationship between their current account balance
# and the amount of their last credit card statement.
#
# H1: cor_current_cardspent < 0
# H0: cor_current_cardspent >= 0

# We create a subset only for customers aged 18 to 35 who possess a Superbank
# credit card.
#
# %in% checks whether a value belongs to a set of possible values.
# Here, it checks whether age_cat belongs to one of the two age categories
# covering 18 to 35 years.

df_18_35_cc <- df %>%
  filter(
    age_cat %in% c("18 to 25 years", "over 25 to 35 years"),
    creditcard == "Yes"
  )

# Check Pearson and Spearman correlation

corP <- cor(
  df_18_35_cc$current,
  df_18_35_cc$cardspent,
  use = "complete.obs",
  method = "pearson"
)

corP

corS <- cor(
  df_18_35_cc$current,
  df_18_35_cc$cardspent,
  use = "complete.obs",
  method = "spearman"
)

corS

# Percentage deviation between Pearson and Spearman

(corP / corS - 1) * 100

# The test is performed with Spearman correlation.
#
# alternative = "less" is used because the claim states a negative relationship.

cor.test(
  df_18_35_cc$current,
  df_18_35_cc$cardspent,
  alternative = "less",
  method = "spearman",
  conf.level = 0.99,
  exact = FALSE
)

# As p = 0.2419 > 0.01, H0 cannot be rejected.
#
# It can be concluded at a significance level of 1% that there is not enough evidence
# which would support H1 claiming that among customers aged between 18 and 35 possessing
# a Superbank credit card, there exists a negative relationship between their current
# account balance and the amount of their last credit card statement.


# ============================================================
# i. Credit card ownership and credit offer acceptance among customers over 55
# ============================================================

# Claim:
# Among customers over 55 years old, the possession of a Superbank credit card
# and the acceptance of the last credit offer are dependent on each other.
#
# H1: possession of a Superbank credit card and acceptance of the last credit offer
#     are dependent on each other among customers over 55 years old
# H0: possession of a Superbank credit card and acceptance of the last credit offer
#     are independent of each other among customers over 55 years old

# We create a subset only for customers over 55 years old.

df_over55 <- df %>%
  filter(age_cat %in% c("over 55 to 65 years", "over 65 to 70 years"))

# table() creates a contingency table for two categorical variables.
#
# The resulting table shows how often each combination of credit card ownership
# and credit offer acceptance occurs.

cctable <- table(df_over55$creditcard, df_over55$creditoffer)
cctable

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
  cctable,
  correct = FALSE
)

# As p = 0.0248 > 0.01 and χ² = 5.0378, H0 cannot be rejected.
#
# It can be concluded at a significance level of 1% that there is not enough evidence
# which would support H1 claiming that among customers over 55 years old, the
# possession of a Superbank credit card and the acceptance of the last credit offer
# are dependent on each other.


# ============================================================
# j. Current account balance and car price among car owners
#    without a Superbank credit card
# ============================================================

# Claim:
# Among customers who own a car and do not possess a Superbank credit card
# there exists a significant relationship between their current account balance
# and the price they paid for their current car.
#
# H1: cor_current_carprice != 0
# H0: cor_current_carprice = 0

# We create a subset only for customers who own a car and do not possess
# a Superbank credit card.

df_car_no_cc <- df %>%
  filter(
    carown == "Yes",
    creditcard == "No"
  )

# Check Pearson and Spearman correlation

corP <- cor(
  df_car_no_cc$current,
  df_car_no_cc$carprice,
  use = "complete.obs",
  method = "pearson"
)

corP

corS <- cor(
  df_car_no_cc$current,
  df_car_no_cc$carprice,
  use = "complete.obs",
  method = "spearman"
)

corS

# Percentage deviation between Pearson and Spearman

(corP / corS - 1) * 100

# The test is performed with Pearson correlation because the variables are metric
# and the relationship is interpreted as a linear relationship.
#
# alternative = "two.sided" is used because the claim is about a significant
# relationship, without specifying a positive or negative direction.

cor.test(
  df_car_no_cc$current,
  df_car_no_cc$carprice,
  alternative = "two.sided",
  method = "pearson",
  conf.level = 0.99
)

# As p = 4.078e-14 < 0.01 and t = 8, H0 can be rejected.
#
# It can be concluded at a significance level of 1% that there is enough evidence
# which supports H1 claiming that among customers who own a car and do not possess
# a Superbank credit card, there exists a significant relationship between their
# current account balance and the price they paid for their current car.
