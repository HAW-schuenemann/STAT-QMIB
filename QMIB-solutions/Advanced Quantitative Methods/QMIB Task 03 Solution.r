# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Exercise 3 – Multiple Linear Regression for Job Motivation Data
# Version: v1.4
# Last Update: 2026-07-06
# Required Dataset(s): JobMotivation.rds
# Required Packages: jmv, dplyr
# License: MIT
# ============================================================


# ============================================================
# Load packages
# ============================================================

# jmv is used for the regression models via linReg().
# dplyr is used for data transformation, selecting variables and calculating summaries.

library(jmv)
library(dplyr)


# ============================================================
# Load data
# ============================================================

# readRDS() loads an R data file in .rds format.
# The loaded object is stored as df so that we can access the variables
# with the structure df$variable_name.

df <- readRDS("JobMotivation.rds")

# Categorical variables are entered directly in linReg() via factors = vars().
# The reference levels are set inside linReg() using refLevels.
# This keeps all regression settings in one place.


# ============================================================
# a. Regression model for job motivation using all suitable variables
# ============================================================

# Task:
# A regression analysis is used to explain employees' job motivation.
# The significance level is 5%.
#
# Dependent variable:
# motivation
#
# Suitable independent variables:
# ambition, creative, drive, image, salary, conditions, develop,
# diversity, colleagues, gender, site
#
# The variable id is not suitable as a predictor because it is only an interview ID.

# Model A uses all suitable variables from the data set.
# Metric predictors are entered as covariates.
# Categorical predictors are entered as factors.
# Reference levels for categorical predictors are set inside linReg().

model_A <- linReg(
  data = df,
  dep = motivation,

  covs = vars(
    ambition,
    creative,
    drive,
    image,
    salary,
    conditions,
    develop,
    diversity,
    colleagues
  ),

  factors = vars(
    gender,
    site
  ),

  blocks = list(
    list(
      "ambition",
      "creative",
      "drive",
      "image",
      "salary",
      "conditions",
      "develop",
      "diversity",
      "colleagues",
      "gender",
      "site"
    )
  ),

  refLevels = list(
    list(var = "gender", ref = "Female"),
    list(var = "site", ref = "Berlin")
  ),

  modelTest = TRUE,
  stdEst = TRUE,
  collin = TRUE
)

model_A

# Result for Model A:
# R = 0.971
# R squared = 0.943
# F(12, 187) = 257.75
# p < 0.001
#
# Interpretation:
# Model A explains around 94.3% of the variance in job motivation.
# Therefore, the explanatory power of the model is very strong.
#
# The significant model test shows that the model as a whole explains job
# motivation significantly better than a model without predictors.
#
# However, the model still needs to be checked for non-significant predictors,
# problematic coefficients and multicollinearity.


# ============================================================
# b. Influence of salary on job motivation
# ============================================================

# In Model A, the coefficient for salary is negative.
#
# Result for salary in Model A:
# Estimate = -0.0012
# Standard error = 0.0004
# t = -3.04
# p = 0.0027
# Standardized estimate = -0.104
#
# Interpretation:
# Holding all other predictors constant, one additional euro of monthly net salary
# is associated with a predicted decrease in job motivation of about 0.0012 points.
#
# For a salary difference of 1,000 euros, the predicted difference is:
# -0.0012 * 1000 = -1.2 points.

# This result is striking because the coefficient is negative.
# This means that, within this multiple regression model, higher salary is associated
# with lower predicted job motivation when all other predictors are held constant.
#
# This is not necessarily a reliable substantive conclusion.
# The bivariate Pearson correlation between salary and motivation is almost zero.
# Therefore, salary does not have a clear direct linear relationship with motivation.

# Correlation between salary and motivation:

df %>%
  select(motivation, salary) %>%
  cor(method = "pearson", use = "complete.obs") %>%
  round(digits = 3)

# Result:
# r_salary_motivation = -0.038
#
# This means that salary has almost no direct linear relationship with job motivation.
#
# The negative significant regression coefficient is therefore likely caused by
# the way salary overlaps with other predictors in the multiple regression model.
# For example, salary correlates strongly with image.

# Correlation between salary and other metric predictors:

df %>%
  select(
    motivation, ambition, creative, drive, image, salary,
    conditions, develop, diversity, colleagues
  ) %>%
  cor(method = "pearson", use = "complete.obs") %>%
  round(digits = 3)

# Important correlations involving salary:
# salary and motivation: r = -0.038
# salary and image:      r =  0.717
# salary and ambition:   r = -0.326
# salary and drive:      r = -0.249
#
# Conclusion for salary:
# In Model A, salary is statistically significant at the 5% level.
# However, it should not be concluded with certainty that salary truly has a
# negative effect on job motivation.
#
# The reason is that salary has almost no bivariate relationship with motivation,
# while the regression coefficient becomes negative and significant only after
# controlling for other predictors. This suggests a suppressor effect or a
# multicollinearity-related interpretation problem.


# ============================================================
# c. Influence of gender and site on job motivation
# ============================================================

# Gender and site are included in Model A as categorical predictors.
# The reference groups are defined inside linReg() via refLevels.
# The reference group for gender is Female.
# The reference group for site is Berlin.
#
# Result for gender:
# Male compared with Female:
# Estimate = 0.159
# t = 0.675
# p = 0.501
#
# Interpretation:
# Holding all other predictors constant, male employees are predicted to have
# a motivation score that is about 0.16 points higher than female employees.
# This difference is not statistically significant.
#
# Conclusion:
# Gender does not have a significant influence on job motivation in Model A.

# Result for site:
# Frankfurt compared with Berlin:
# Estimate = 1.821
# t = 5.259
# p < 0.001
#
# Hamburg compared with Berlin:
# Estimate = 1.694
# t = 6.264
# p < 0.001
#
# Interpretation:
# Holding all other predictors constant, employees in Frankfurt and Hamburg
# have significantly higher predicted motivation scores than employees in Berlin.
#
# Conclusion:
# Site has a significant influence on job motivation in Model A.


# ============================================================
# d. Maximum contribution of working conditions and corporate diversity
# ============================================================

# Task:
# Calculate the maximum value that working conditions and corporate diversity
# can contribute to predicting job motivation based on the available data.
#
# The coefficients from Model A are used here:
# conditions: Estimate = 0.0519
# diversity:  Estimate = 0.1844
#
# To find the maximum possible contribution based on the available data,
# the maximum observed value of each predictor is used.

# Five number summary for working conditions and corporate diversity:

df %>%
  summarise(
    conditions_min = min(conditions, na.rm = TRUE),
    conditions_q1 = quantile(conditions, 0.25, type = 2, na.rm = TRUE),
    conditions_median = median(conditions, na.rm = TRUE),
    conditions_q3 = quantile(conditions, 0.75, type = 2, na.rm = TRUE),
    conditions_max = max(conditions, na.rm = TRUE),
    diversity_min = min(diversity, na.rm = TRUE),
    diversity_q1 = quantile(diversity, 0.25, type = 2, na.rm = TRUE),
    diversity_median = median(diversity, na.rm = TRUE),
    diversity_q3 = quantile(diversity, 0.75, type = 2, na.rm = TRUE),
    diversity_max = max(diversity, na.rm = TRUE)
  )

# Result:
# conditions: min = 53, Q1 = 69, median = 72, Q3 = 77, max = 89
# diversity:  min = 31, Q1 = 39, median = 44, Q3 = 53, max = 69

# Maximum contribution based on the available data:

coef_conditions_A <- 0.0519
coef_diversity_A <- 0.1844

max_conditions <- max(df$conditions, na.rm = TRUE)
max_diversity <- max(df$diversity, na.rm = TRUE)

coef_conditions_A * max_conditions
coef_diversity_A * max_diversity

# Result:
# Maximum contribution of conditions = 0.0519 * 89 = 4.62 points
# Maximum contribution of diversity  = 0.1844 * 69 = 12.72 points
#
# Interpretation:
# Based on the available data and Model A, working conditions can contribute
# at most around 4.62 points to the predicted motivation score.
#
# Corporate diversity can contribute at most around 12.72 points to the
# predicted motivation score.
#
# Diversity therefore has a much larger possible contribution than working
# conditions in the regression prediction.


# ============================================================
# e1. Improvements and predictor selection for the final model
# ============================================================

# The full Model A should be improved before being used as the final model.
# The following issues are visible:
#
# 1. gender is not significant.
#    p = 0.501
#    Therefore, gender should be removed.
#
# 2. drive is not significant in Model A.
#    p = 0.082
#    It is also highly correlated with ambition.
#    r_drive_ambition = 0.818
#    Since ambition is more strongly correlated with motivation, ambition is kept
#    and drive is removed.
#
# 3. salary is statistically significant in Model A, but its interpretation is problematic.
#    Salary has almost no direct bivariate correlation with motivation.
#    r_salary_motivation = -0.038
#    Its negative coefficient is therefore likely caused by overlap with other predictors.
#    For a more interpretable final model, salary is removed.
#
# 4. id is not included because it is only an interview ID.
#
# Final model predictors:
# ambition, creative, image, conditions, develop, diversity, colleagues, site
#
# Predictors not included in the final model:
# id, salary, gender, drive

# Correlation matrix between all metric variables:

df %>%
  select(
    motivation, ambition, creative, drive, image, salary,
    conditions, develop, diversity, colleagues
  ) %>%
  cor(method = "pearson", use = "complete.obs") %>%
  round(digits = 3)

# Important correlations for model improvement:
# ambition and drive:       r = 0.818
# develop and colleagues:   r = 0.724
# image and salary:         r = 0.717
# salary and motivation:    r = -0.038
#
# The correlation between ambition and drive is especially relevant because
# drive is not significant in Model A and overlaps strongly with ambition.
#
# The correlation between salary and image helps explain why salary is difficult
# to interpret in the full multiple regression model.
#
# The correlation between develop and colleagues is also relatively high.
# However, both variables remain significant and meaningful in the improved model,
# so both are kept.


# ============================================================
# e2. Final regression model and explanatory power
# ============================================================

model_final <- linReg(
  data = df,
  dep = motivation,

  covs = vars(
    ambition,
    creative,
    image,
    conditions,
    develop,
    diversity,
    colleagues
  ),

  factors = vars(
    site
  ),

  blocks = list(
    list(
      "ambition",
      "creative",
      "image",
      "conditions",
      "develop",
      "diversity",
      "colleagues",
      "site"
    )
  ),

  refLevels = list(
    list(var = "site", ref = "Berlin")
  ),

  modelTest = TRUE,
  stdEst = TRUE,
  collin = TRUE
)

model_final

# Result for the final model:
# R = 0.969
# R squared = 0.939
# F(9, 190) = 322.88
# p < 0.001
#
# Interpretation:
# The final model explains around 93.9% of the variance in job motivation.
# The model therefore has very strong explanatory power.
#
# The significant model test shows that the final model as a whole explains
# job motivation significantly better than a model without predictors.
#
# Compared with Model A, the final model is slightly simpler and easier to interpret,
# while losing only a small amount of explained variance.


# ============================================================
# e3. Two most important predictors in the final model
# ============================================================

# The two most important predictors can be identified using the standardized
# regression estimates from the final jmv::linReg() model.
#
# Standardized estimates in the final model:
# ambition:    beta = 0.401
# diversity:   beta = 0.319
# creative:    beta = 0.205
# develop:     beta = 0.172
# colleagues:  beta = 0.161
# image:       beta = 0.125
# conditions:  beta = 0.074
#
# For site, the standardized dummy coefficients are:
# Frankfurt vs. Berlin: beta = 0.147
# Hamburg vs. Berlin:   beta = 0.135
#
# Conclusion:
# The two most important individual predictors in the final model are ambition
# and corporate diversity.
#
# Both have the largest standardized effects on job motivation.


# ============================================================
# e4. Relative importance of all predictors in the final model
# ============================================================

# Relative importance is calculated based on the squared standardized regression
# coefficients from the final jmv::linReg() model.
#
# The standardized estimates are squared and then divided by the sum of all
# squared standardized estimates.
#
# This gives the relative share of each predictor in percent.
#
# Note:
# The coefficient table from jmv::linReg() can contain general factor rows,
# for example the overall row for site.
# These rows do not contain standardized estimates and would produce NA values.
# Therefore, rows with missing standardized estimates are removed.

coef_table <- as.data.frame(
  model_final$models[[1]]$coef
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
# ambition:             27.47%
# creative:              7.22%
# image:                 2.67%
# conditions:            0.94%
# develop:               5.05%
# diversity:            17.42%
# colleagues:            4.44%
# Hamburg - Berlin:     14.99%
# Frankfurt - Berlin:   19.79%
#
# Interpretation:
# Based on squared standardized regression coefficients, site is the most
# important overall predictor in the final model.
#
# However, site is a categorical predictor. Therefore, it is represented by
# two dummy-coded contrasts in the table:
#
# Hamburg - Berlin:   14.99%
# Frankfurt - Berlin: 19.79%
#
# If both site contrasts are considered together, site accounts for:
#
# 14.99% + 19.79% = 34.78%
#
# This means that site has the largest overall relative importance in the final
# model. It contributes more strongly to the prediction of job motivation than
# any single metric predictor.
#
# Among the metric predictors, ambition is the most important individual
# predictor.
#
# It accounts for 27.47% of the total squared standardized effects.
# This means that ambition has the largest relative standardized contribution
# among the non-categorical predictors.
#
# Conditions is the least important individual predictor in the final model.
# It accounts for 0.94% of the total squared standardized effects.
# This means that working conditions contribute only weakly compared with the
# other predictors in the model.
#
# Important note:
# The relative importance table can make site look less important at first
# because its effect is split across multiple dummy variables. For interpretation,
# the dummy variables belonging to the same categorical predictor should be
# considered together.
