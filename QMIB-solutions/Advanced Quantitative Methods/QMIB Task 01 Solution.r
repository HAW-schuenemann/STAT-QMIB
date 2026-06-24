# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 2: ANOVA for EasyFoods Data
# Version: v1.1
# Last Update: 2026-06-24
# Required Dataset(s): EasyFoods.rds
# Required Packages: car, jmv, misty, dplyr
# License: MIT
# ============================================================


# ============================================================
# Load packages
# ============================================================

# car is used for Levene's Test.
# jmv is used for the standard one way ANOVA.
# misty is used for Welch's ANOVA and Games Howell post hoc tests.
# dplyr is used for filtering the data.

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

df <- readRDS("EasyFoods.rds")


# ============================================================
# a. Testing EasyFoods' assumptions 1 to 3
# ============================================================

# EasyFoods wants to test whether discount coupons, shopping frequency
# and supermarket format significantly influence the average amount spent.
#
# All tests are conducted at a significance level of 5%.
#
# alpha = 0.05


# ============================================================
# a1. Assumption 1: Discount coupons and average expenditure
# ============================================================

# Claim:
# The average expenditure for a purchase at EasyFoods differs depending on
# the amount of the discount coupon.

# Since spent is metric and coupon has more than two independent groups,
# a one way ANOVA is appropriate.
#
# Before the ANOVA, Levene's Test is used to check whether the assumption
# of equal variances is plausible.

# Hypotheses for Levene's Test:
#
# H1: At least one coupon group has a different variance.
# H0: The variances of spent are equal across all coupon groups.

leveneTest(
  data = df,
  spent ~ coupon,
  center = median
)

# As p = 0.1775 > 0.05 and F = 1.6436, H0 of Levene's Test cannot be rejected.
#
# It can be concluded at a significance level of 5% that there is no significant
# evidence against equal variances. Therefore, the standard one way ANOVA can be used.

# Hypotheses for the ANOVA:
#
# H1: At least one coupon group has a different mean amount spent.
# H0: The mean amount spent is equal across all coupon groups.

ANOVA(
  data = df,
  dep = spent,
  factors = coupon,
  effectSize = "eta"
)

# As p = 0.0000978 < 0.05 and F = 7.1077, H0 can be rejected.
#
# It can be concluded at a significance level of 5% that there is enough evidence
# which supports H1 claiming that the average expenditure differs depending on
# the amount of the discount coupon.
#
# eta squared = 0.0166. This means that around 1.66% of the variance in spent
# is explained by coupon group. The effect is statistically significant, but small.

# Since the overall ANOVA is significant, post hoc tests are used to identify
# which coupon groups differ significantly.
#
# Scheffe correction is used for the pairwise comparisons.

ANOVA(
  data = df,
  dep = spent,
  factors = coupon,
  postHoc = spent ~ coupon,
  postHocCorr = "scheffe"
)

# The post hoc tests show significant differences for:
#
# no discount coupon vs. 10 pct discount coupon:
# Mean difference = -12.1619, p = 0.0064
#
# no discount coupon vs. 20 pct discount coupon:
# Mean difference = -14.9003, p = 0.0003
#
# The other pairwise comparisons are not significant at the 5% level.
#
# Therefore, assumption 1 can be supported. The difference is mainly driven by
# the higher spending of customers with a 10% or 20% discount coupon compared
# with customers without a discount coupon.


# ============================================================
# a2. Assumption 2: Shopping frequency and average expenditure
# ============================================================

# Claim:
# The average expenditure for a purchase at EasyFoods differs depending on
# the shopping frequency of the customers.

# Since spent is metric and shopfreq has more than two independent groups,
# a one way ANOVA type test is appropriate.
#
# Before the ANOVA, Levene's Test is used to check whether the assumption
# of equal variances is plausible.

# Hypotheses for Levene's Test:
#
# H1: At least one shopping frequency group has a different variance.
# H0: The variances of spent are equal across all shopping frequency groups.

leveneTest(
  data = df,
  spent ~ shopfreq,
  center = median
)

# As p < 2.2e-16 < 0.05 and F = 423.42, H0 of Levene's Test can be rejected.
#
# It can be concluded at a significance level of 5% that the variances differ
# significantly between the shopping frequency groups.
#
# Therefore, Welch's ANOVA is used instead of the standard one way ANOVA.

# Hypotheses for Welch's ANOVA:
#
# H1: At least one shopping frequency group has a different mean amount spent.
# H0: The mean amount spent is equal across all shopping frequency groups.

test.welch(
  data = df,
  spent ~ shopfreq,
  effsize = TRUE
)

# As p < 0.001 < 0.05 and F = 7.78, H0 can be rejected.
#
# It can be concluded at a significance level of 5% that there is enough evidence
# which supports H1 claiming that the average expenditure differs depending on
# shopping frequency.
#
# eta squared = 0.04. This means that around 4% of the variance in spent is
# explained by shopping frequency. The effect is statistically significant,
# but small.

# Since Welch's ANOVA is significant, Games Howell post hoc tests are used.
# Games Howell is appropriate here because equal variances cannot be assumed.

test.welch(
  data = df,
  spent ~ shopfreq,
  descript = TRUE,
  posthoc = TRUE
)

# The post hoc tests show significant differences for:
#
# Approx. every two weeks vs. Approx. once a week:
# Mean difference = -24.33, p < 0.001
#
# Approx. every two weeks vs. Several times a week:
# Mean difference = -23.55, p = 0.001
#
# The comparison between Approx. once a week and Several times a week is
# not significant at the 5% level.
#
# Therefore, assumption 2 can be supported. The difference is mainly driven by
# customers who shop approximately every two weeks. These customers spend more
# on average than customers who shop once a week or several times a week.


# ============================================================
# a3. Assumption 3: Supermarket format and average expenditure
# ============================================================

# Claim:
# The supermarket format influences grocery shopping expenditure.
# The average expenditure of customers differs depending on the market format.

# Since spent is metric and EFformat has more than two independent groups,
# a one way ANOVA type test is appropriate.
#
# Before the ANOVA, Levene's Test is used to check whether the assumption
# of equal variances is plausible.

# Hypotheses for Levene's Test:
#
# H1: At least one supermarket format has a different variance.
# H0: The variances of spent are equal across all supermarket formats.

leveneTest(
  data = df,
  spent ~ EFformat,
  center = median
)

# As p = 0.04369 < 0.05 and F = 3.1383, H0 of Levene's Test can be rejected.
#
# It can be concluded at a significance level of 5% that the variances differ
# significantly between the supermarket formats.
#
# Therefore, Welch's ANOVA is used instead of the standard one way ANOVA.

# Hypotheses for Welch's ANOVA:
#
# H1: At least one supermarket format has a different mean amount spent.
# H0: The mean amount spent is equal across all supermarket formats.

test.welch(
  data = df,
  spent ~ EFformat,
  effsize = TRUE
)

# As p = 0.061 > 0.05 and F = 2.80, H0 cannot be rejected.
#
# It can be concluded at a significance level of 5% that there is not enough
# evidence which would support H1 claiming that average expenditure differs
# depending on supermarket format.
#
# eta squared = 0.00. This indicates that supermarket format explains almost
# none of the variance in spent.
#
# Since the overall test is not significant, no post hoc tests are conducted.
#
# Therefore, assumption 3 cannot be supported.


# ============================================================
# b. Most relevant significant influencing factor
# ============================================================

# Significant influencing factors from task a:
#
# Discount coupon:
# The overall ANOVA was significant.
# eta squared = 0.0166.
#
# Shopping frequency:
# Welch's ANOVA was significant.
# eta squared = 0.04.
#
# Supermarket format:
# Welch's ANOVA was not significant.
# Therefore, supermarket format is not treated as a confirmed influencing factor.

# Shopping frequency is the most relevant significant influencing factor
# from a statistical perspective because it has the larger effect size.
#
# The effect of shopping frequency on expenditure is stronger than the effect
# of discount coupons.
#
# However, discount coupons are still highly relevant from a management perspective
# because EasyFoods can directly adjust coupon levels. Shopping frequency describes
# customer behaviour, but coupon levels can be used as a marketing instrument.


# ============================================================
# c. Recommendations for the optimisation of discount coupons
# ============================================================

# Recommendation 1:
# EasyFoods should not rely on 5% discount coupons if the goal is to significantly
# increase average expenditure.
#
# The post hoc test showed that the difference between no coupon and 5% discount
# coupon was not statistically significant.
#
# Result:
# p = 0.0786

# Recommendation 2:
# EasyFoods should prefer 10% discount coupons over no coupon.
#
# The post hoc test showed a significant difference between no coupon and
# 10% discount coupon.
#
# Result:
# Mean difference = -12.1619, p = 0.0064
#
# Customers with a 10% discount coupon spent significantly more on average
# than customers without a coupon.

# Recommendation 3:
# EasyFoods should be careful with 20% discount coupons.
#
# The post hoc test showed a significant difference between no coupon and
# 20% discount coupon.
#
# Result:
# Mean difference = -14.9003, p = 0.0003
#
# Customers with a 20% discount coupon spent significantly more on average
# than customers without a coupon.

# Recommendation 4:
# EasyFoods should not automatically choose the 20% coupon.
#
# The difference between 10% and 20% discount coupons was not statistically
# significant.
#
# Result:
# p = 0.8892

# Therefore, 10% discount coupons appear to be the better option.
#
# They are associated with significantly higher expenditure compared to no coupon,
# but they do not give away as much discount as the 20% coupon.
#
# Final recommendation:
# EasyFoods should focus on 10% discount coupons as the main coupon strategy.
# The 5% coupon does not show a statistically significant increase in spending.
# The 20% coupon increases spending compared to no coupon, but it does not lead
# to significantly higher spending than the 10% coupon.
# From a cost perspective, the 10% coupon is likely to be more efficient.
#
# Important limitation:
# The analysis only considers average expenditure, not profit or contribution margin.
# Before making a final business decision, EasyFoods should also check whether
# the additional spending generated by coupons is large enough to compensate
# for the discount costs.


# ============================================================
# d. Influence of specialty counters by loyalty card possession
# ============================================================

# Claim:
# The specialty corner installed in a supermarket influences the average purchase
# amount depending on whether customers possess an EasyFoods loyalty card.
#
# Testing strategy:
# The effect of specialty counter is tested separately for customers without
# a loyalty card and for customers with a loyalty card.


# ============================================================
# d1. Customers without loyalty card
# ============================================================

# Since spent is metric and specialty has more than two independent groups,
# a one way ANOVA type test is appropriate.
#
# Before the ANOVA, Levene's Test is used to check whether the assumption
# of equal variances is plausible.

# Hypotheses for Levene's Test:
#
# H1: At least one specialty counter group has a different variance.
# H0: The variances of spent are equal across all specialty counter groups.

leveneTest(
  data = filter(df, EFloyalty == "No"),
  spent ~ specialty,
  center = median
)

# As p = 0.6064 > 0.05 and F = 0.6135, H0 of Levene's Test cannot be rejected.
#
# It can be concluded at a significance level of 5% that there is no significant
# evidence against equal variances.
#
# Therefore, the standard one way ANOVA can be used for customers without
# a loyalty card.

# Hypotheses for the ANOVA:
#
# H1: At least one specialty counter group has a different mean amount spent.
# H0: The mean amount spent is equal across all specialty counter groups.

ANOVA(
  data = filter(df, EFloyalty == "No"),
  dep = spent,
  factors = specialty,
  effectSize = "eta"
)

# As p = 0.9289 > 0.05 and F = 0.1512, H0 cannot be rejected.
#
# It can be concluded at a significance level of 5% that there is not enough
# evidence which would support H1 claiming that average expenditure differs
# depending on the specialty counter among customers without a loyalty card.
#
# eta squared = 0.0007. The specialty counter explains almost none of the
# variance in spent among customers without a loyalty card.


# ============================================================
# d2. Customers with loyalty card
# ============================================================

# Since spent is metric and specialty has more than two independent groups,
# a one way ANOVA type test is appropriate.
#
# Before the ANOVA, Levene's Test is used to check whether the assumption
# of equal variances is plausible.

# Hypotheses for Levene's Test:
#
# H1: At least one specialty counter group has a different variance.
# H0: The variances of spent are equal across all specialty counter groups.

leveneTest(
  data = filter(df, EFloyalty == "Yes"),
  spent ~ specialty,
  center = median
)

# As p = 0.04042 < 0.05 and F = 2.7786, H0 of Levene's Test can be rejected.
#
# It can be concluded at a significance level of 5% that the variances differ
# significantly between the specialty counter groups.
#
# Therefore, Welch's ANOVA is used instead of the standard one way ANOVA.

# Hypotheses for Welch's ANOVA:
#
# H1: At least one specialty counter group has a different mean amount spent.
# H0: The mean amount spent is equal across all specialty counter groups.

test.welch(
  data = filter(df, EFloyalty == "Yes"),
  spent ~ specialty,
  effsize = TRUE
)

# As p = 0.065 > 0.05 and F = 2.44, H0 cannot be rejected.
#
# It can be concluded at a significance level of 5% that there is not enough
# evidence which would support H1 claiming that average expenditure differs
# depending on the specialty counter among customers with a loyalty card.
#
# eta squared = 0.01. The effect is small and not statistically significant.
#
# Since neither the standard ANOVA for customers without a loyalty card nor
# Welch's ANOVA for customers with a loyalty card is significant, no post hoc
# tests are conducted.
#
# Therefore, the assumption from task d cannot be supported. Based on these
# results, there is not enough evidence that specialty counters influence average
# purchase amount depending on loyalty card possession.
