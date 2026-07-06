# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 4 – Multiple Linear Regression for Online Ad Test Data
# Version: v1.0
# Last Update: 2026-07-06
# Required Dataset(s): OnlineAdTest.rds
# Required Packages: jmv, dplyr
# License: MIT
# ============================================================


# ============================================================
# Load packages
# ============================================================

# jmv is used for the regression models via linReg().
# dplyr is used for selecting variables, calculating correlations and summaries.

library(jmv)
library(dplyr)


# ============================================================
# Load data
# ============================================================

# readRDS() loads an R data file in .rds format.
# The loaded object is stored as df so that we can access the variables
# with the structure df$variable_name.

df <- readRDS("OnlineAdTest.rds")


# ============================================================
# a. Model A: Interest predicted by explicit statements, gender and Gen Z
# ============================================================

# Task:
# Superbank wants to find out which explicitly stated opinions about the advert,
# as well as gender and belonging to Gen Z, predict interest in opening an
# account with Nexus.
#
# Dependent variable:
# interest
#
# Explicit statement predictors:
# like, creative, unique, fit, story, involve, trust, image
#
# Categorical predictors:
# gender, genz
#
# The measured emotional engagement variable emotion is not included in Model A,
# because task a only refers to explicit statements as well as gender and Gen Z.
#
# Significance level:
# alpha = 0.05

model_A <- linReg(
  data = df,
  dep = interest,
  
  covs = vars(
    like,
    creative,
    unique,
    fit,
    story,
    involve,
    trust,
    image
  ),
  
  factors = vars(
    gender,
    genz
  ),
  
  blocks = list(
    list(
      "like",
      "creative",
      "unique",
      "fit",
      "story",
      "involve",
      "trust",
      "image",
      "gender",
      "genz"
    )
  ),
  
  refLevels = list(
    list(var = "gender", ref = "Female"),
    list(var = "genz", ref = "No")
  ),
  
  modelTest = TRUE,
  stdEst = TRUE,
  collin = TRUE
)

model_A

# Result for Model A:
# R = 0.713
# R squared = 0.508
# F(10, 114) = 11.77
# p < 0.001
#
# Interpretation:
# Model A explains around 50.8% of the variance in interest.
# The model test is significant, so the model as a whole explains interest
# significantly better than a model without predictors.
#
# This means that Model A has relevant explanatory power and is useful as a first
# prediction model.
#
# However, the model still needs to be checked for multicollinearity before the
# coefficients and their significance are interpreted in detail.


# ============================================================
# b. Problem in Model A: multicollinearity
# ============================================================

# The main problem in Model A is multicollinearity.
#
# The collinearity diagnostics show that like has a very high VIF:
#
# VIF for like = 14.89
#
# This is problematic because a VIF clearly above 10 indicates that the predictor
# strongly overlaps with other predictors in the model.
#
# As a result, the regression coefficients and their p-values become more difficult
# to interpret.
#
# The predictor most affected is like.

# To demonstrate the problem, the correlation matrix between like and the other
# explicit statement variables is calculated.

# The dependent variable interest is included so that we can also see the direct
# bivariate relationships with interest.

df %>%
  select(
    interest,
    like,
    creative,
    unique,
    fit,
    story,
    involve,
    trust,
    image
  ) %>%
  cor(method = "pearson", use = "complete.obs") %>%
  round(digits = 3)

# Important correlations involving like:
#
# like and fit:     r = -0.708
# like and trust:   r =  0.706
# like and image:   r =  0.675
# like and involve: r = -0.652
# like and unique:  r =  0.573
#
# Logical explanation:
# The variable like measures the overall enjoyment of watching the advert.
# This is a broad overall judgement and therefore overlaps strongly with more
# specific evaluations of the advert, such as whether the ad fits the bank,
# whether it improves the bank's image, whether the message seems trustworthy
# and whether the content is personally relevant.
#
# Therefore, like partly measures the same underlying evaluation as several other
# predictors.
#
# This explains why like has such a high VIF in Model A.
#
# To avoid this multicollinearity problem, like is removed from the next model.


# ============================================================
# c. Model B: Model A without like
# ============================================================

# Model B removes like from Model A.
#
# Reason:
# like is the predictor most affected by multicollinearity and shows the highest
# VIF in Model A.
#
# The remaining explicit statement predictors are kept for now.

model_B <- linReg(
  data = df,
  dep = interest,
  
  covs = vars(
    creative,
    unique,
    fit,
    story,
    involve,
    trust,
    image
  ),
  
  factors = vars(
    gender,
    genz
  ),
  
  blocks = list(
    list(
      "creative",
      "unique",
      "fit",
      "story",
      "involve",
      "trust",
      "image",
      "gender",
      "genz"
    )
  ),
  
  refLevels = list(
    list(var = "gender", ref = "Female"),
    list(var = "genz", ref = "No")
  ),
  
  modelTest = TRUE,
  stdEst = TRUE,
  collin = TRUE
)

model_B

# Result for Model B:
# R = 0.685
# R squared = 0.469
# F(9, 115) = 11.27
# p < 0.001
#
# Interpretation:
# Model B explains around 46.9% of the variance in interest.
# The model test is significant, so the model as a whole explains interest
# significantly better than a model without predictors.
#
# Compared with Model A, the explanatory power is lower:
#
# Model A R squared = 0.508
# Model B R squared = 0.469
# Difference = 0.039
#
# This means that removing like reduces the explained variance by about
# 3.9 percentage points.
#
# However, Model B is easier to interpret because the serious multicollinearity
# problem caused by like is removed.


# ============================================================
# d. Model C: Remove non-significant predictors from Model B
# ============================================================

# In Model B, the following predictors are significant at the 5% level:
#
# genz
# unique
# fit
# image
#
# The following predictors are not significant at the 5% level:
#
# gender
# creative
# story
# involve
# trust
#
# Therefore, these non-significant predictors are removed and Model C is
# calculated with only the significant predictors from Model B.

model_C <- linReg(
  data = df,
  dep = interest,
  
  covs = vars(
    unique,
    fit,
    image
  ),
  
  factors = vars(
    genz
  ),
  
  blocks = list(
    list(
      "unique",
      "fit",
      "image",
      "genz"
    )
  ),
  
  refLevels = list(
    list(var = "genz", ref = "No")
  ),
  
  modelTest = TRUE,
  stdEst = TRUE,
  collin = TRUE
)

model_C

# Result for Model C:
# R = 0.653
# R squared = 0.426
# F(4, 120) = 22.30
# p < 0.001
#
# Interpretation:
# Model C explains around 42.6% of the variance in interest.
# The model test is significant, so the model as a whole explains interest
# significantly better than a model without predictors.
#
# All predictors included in Model C are significant at the 5% level.
# The collinearity diagnostics are also unproblematic.
#
# Compared with Model B, the explanatory power is lower:
#
# Model B R squared = 0.469
# Model C R squared = 0.426
# Difference = 0.043
#
# This means that removing the non-significant predictors reduces the explained
# variance by about 4.3 percentage points.
#
# However, Model C is simpler and easier to interpret because it only contains
# significant predictors.


# ============================================================
# e. Model choice: Model B or Model C
# ============================================================

# I would use Model C rather than Model B in its current form.
#
# Reason:
# Model C is simpler and all predictors in Model C are statistically significant.
# The model is therefore easier to explain and interpret.
#
# Model B explains somewhat more variance, but it contains several predictors
# that are not statistically significant.
#
# Therefore, Model C is preferable as the cleaner model for predicting interest,
# as long as only the explicitly stated evaluations and Gen Z are used.
#
# However, Model C should still be tested against an extended model that also
# includes the measured emotional engagement KPI.


# ============================================================
# f. Model D: Extend Model C with emotional engagement
# ============================================================

# Model D extends Model C by adding the measured emotional engagement variable.
#
# This allows us to check whether the implicit emotional response to the advert
# improves the prediction of interest.

model_D <- linReg(
  data = df,
  dep = interest,
  
  covs = vars(
    unique,
    fit,
    image,
    emotion
  ),
  
  factors = vars(
    genz
  ),
  
  blocks = list(
    list(
      "unique",
      "fit",
      "image",
      "emotion",
      "genz"
    )
  ),
  
  refLevels = list(
    list(var = "genz", ref = "No")
  ),
  
  modelTest = TRUE,
  stdEst = TRUE,
  collin = TRUE
)

model_D

# Result for Model D:
# R = 0.905
# R squared = 0.818
# F(5, 119) = 107.21
# p < 0.001
#
# Interpretation:
# Model D explains around 81.8% of the variance in interest.
# The model test is significant, so the model as a whole explains interest
# significantly better than a model without predictors.
#
# Compared with Model C, the explanatory power increases strongly:
#
# Model C R squared = 0.426
# Model D R squared = 0.818
# Difference = 0.392
#
# This means that adding emotional engagement increases the explained variance
# by about 39.2 percentage points.
#
# Therefore, Model D demonstrates a clearly improved explanatory power and is
# more useful for predicting interest than Model C.


# ============================================================
# g. Relative importance of predictors in Model D
# ============================================================

# Relative importance is calculated based on the squared standardized regression
# coefficients from Model D.
#
# The standardized estimates are squared and then divided by the sum of all
# squared standardized estimates.
#
# This gives the relative share of each predictor in percent.
#
# The coefficient table from jmv::linReg() can contain general factor rows.
# These rows do not contain standardized estimates and would produce NA values.
# Therefore, rows with missing standardized estimates are removed.

coef_table <- as.data.frame(
  model_D$models[[1]]$coef
)

std_estimates <- coef_table %>%
  filter(
    term != "Intercept",
    !is.na(stdEst)
  ) %>%
  select(
    predictor = term,
    std_estimate = stdEst
  )

rownames(std_estimates) <- NULL

std_estimates

std_estimates %>%
  mutate(
    b2 = std_estimate^2,
    rel_imp = round(b2 / sum(b2) * 100, 2)
  )

# Result:
#
# emotion:   47.05%
# Yes - No:  33.98%
# image:     13.15%
# unique:     4.25%
# fit:        1.58%
#
# Interpretation:
# Emotional engagement is the most important predictor in Model D.
# It accounts for 47.05% of the total squared standardized effects.
#
# This means that emotional engagement has the largest relative standardized
# contribution to the prediction of interest in this model.
#
# The predictor genz is represented by the dummy-coded contrast Yes - No.
# This contrast accounts for 33.98% of the total squared standardized effects.
#
# This means that belonging to Gen Z is the second most important predictor
# in Model D.
#
# Image is the third most important predictor in Model D.
# It accounts for 13.15% of the total squared standardized effects.
#
# Fit is the least important predictor in Model D.
# It accounts for 1.58% of the total squared standardized effects.
#
# The three most important predictors are:
#
# 1. emotion
# 2. genz, represented by the contrast Yes - No
# 3. image


# ============================================================
# h. Suitability of the advert for generating interest
# ============================================================

# Model D has strong explanatory power and shows that emotional engagement,
# image, Gen Z, uniqueness and fit can significantly predict interest.
#
# However, whether the advert is generally suitable to generate interest also
# depends on the observed level of interest.
#
# Therefore, the overall mean interest and the mean interest by Gen Z group are
# calculated.

df %>%
  summarise(
    n = n(),
    mean_interest = mean(interest, na.rm = TRUE),
    median_interest = median(interest, na.rm = TRUE),
    min_interest = min(interest, na.rm = TRUE),
    max_interest = max(interest, na.rm = TRUE)
  )

df %>%
  group_by(genz) %>%
  summarise(
    n = n(),
    mean_interest = mean(interest, na.rm = TRUE),
    median_interest = median(interest, na.rm = TRUE),
  )

# Result:
#
# Overall mean interest = 2.24
# Overall median interest = 2.10
# Minimum interest = 1.20
# Maximum interest = 3.20
#
# Mean interest among non-Gen Z respondents = 2.04
# Mean interest among Gen Z respondents = 2.43
#
# Interpretation:
# The advert is not generally suitable to generate strong interest in opening
# an account with Nexus.
#
# Even though Model D predicts interest well, the observed interest values are
# low on a scale from 0 to 10.
#
# The advert appears to be relatively more suitable for Gen Z than for non-Gen Z
# respondents because the Gen Z coefficient in Model D is positive and significant.
#
# However, the absolute mean interest among Gen Z respondents is still low.
# Therefore, the advert performs better among Gen Z, but it still does not generate
# a high level of interest in opening an account.


# ============================================================
# i. Emotional engagement among Gen Z respondents
# ============================================================

# Claim:
# The Head of Communications believes that Gen Z respondents were more
# emotionally engaged by the advert than other respondents.
#
# Since emotion is metric and genz has two independent groups, a two sample
# t-test is appropriate.
#
# The genz variable is ordered as:
# No, Yes
#
# Therefore, R tests the difference:
# mean(No) - mean(Yes)
#
# To test whether Gen Z respondents have a higher mean emotional engagement,
# the alternative must be "less".
#
# Significance level:
# alpha = 0.05

# Hypotheses:
#
# H1: mu_No < mu_Yes
# Gen Z respondents have a higher average emotional engagement than non-Gen Z
# respondents.
#
# H0: mu_No >= mu_Yes
# Gen Z respondents do not have a higher average emotional engagement than
# non-Gen Z respondents.

df %>%
  group_by(genz) %>%
  summarise(
    n = n(),
    mean_emotion = mean(emotion, na.rm = TRUE),
    median_emotion = median(emotion, na.rm = TRUE),
  )

t.test(
  data = df,
  emotion ~ genz,
  alternative = "less",
  conf.level = 0.95
)

# Result:
#
# Mean emotion among non-Gen Z respondents = 5.78
# Mean emotion among Gen Z respondents = 5.74
#
# t = 0.2278
# p = 0.5899
#
# Test criterion:
# If p < 0.05, reject H0.
# If p >= 0.05, do not reject H0.
#
# Test decision:
# As p = 0.5899 > 0.05, H0 cannot be rejected.
#
# It can be concluded at a significance level of 5% that there is not enough
# evidence to support the claim that Gen Z respondents were more emotionally
# engaged by the advert than non-Gen Z respondents.
#
# The Head of Communications is therefore not correct based on the test result.
# The descriptive means even show a slightly lower average emotional engagement
# among Gen Z respondents.
