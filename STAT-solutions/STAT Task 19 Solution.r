# ============================================================
# Author: Jan-Hendrik Schünemann
# Module: QMIB
# Exercise: Task 18 – Simple Linear Regression for Movie Data
# Version: v1.0
# Last Update: 2026-07-02
# Required Dataset(s): MovieData.rds
# Required Packages: dplyr
# License: MIT
# ============================================================


# ============================================================
# Load packages
# ============================================================

# dplyr is used for selecting variables before calculating correlations.

library(dplyr)


# ============================================================
# Load data
# ============================================================

# readRDS() loads an R data file in .rds format.
# The loaded object is stored as df so that we can access the variables
# with the structure df$variable_name.

df <- readRDS("MovieData.rds")


# ============================================================
# a. Suitability of potential predictors
# ============================================================

# Task:
# The distributor wants to predict first week US box office sales.
#
# Dependent variable:
# USSalesW1
#
# Potential independent variables:
# STARPOWER
# SUCCESS
# USCopiesW1
# BUDGET

# To assess the suitability of the potential predictors, correlations with
# USSalesW1 are calculated.
#
# Pearson correlation is useful for assessing linear relationships.
# Since the later model is a linear regression model, Pearson correlation is
# especially relevant.
#
# Spearman correlation is also calculated as an additional check. It assesses
# whether the relationship is monotonic.

df %>%
  select(USSalesW1, STARPOWER, SUCCESS, USCopiesW1, BUDGET) %>%
  cor(method = "pearson", use = "complete.obs") %>%
  round(digits = 3)

df %>%
  select(USSalesW1, STARPOWER, SUCCESS, USCopiesW1, BUDGET) %>%
  cor(method = "spearman", use = "complete.obs") %>%
  round(digits = 3)

# Interpretation of the Pearson correlations with USSalesW1:
#
# STARPOWER:
# r = 0.316
#
# This is only a weak to moderate positive relationship.
# STARPOWER is therefore not the best predictor for first week US sales.
#
# SUCCESS:
# r = 0.775
#
# This is a strong positive relationship.
# Films with a higher success indicator tend to have higher first week US sales.
#
# USCopiesW1:
# r = 0.662
#
# This is also a positive relationship, but it is weaker than the Pearson
# correlation between SUCCESS and USSalesW1.
#
# BUDGET:
# r = 0.687
#
# This is a positive relationship, but it is also weaker than the Pearson
# correlation between SUCCESS and USSalesW1.

# Interpretation of the Spearman correlations with USSalesW1:
#
# STARPOWER:
# rho = 0.348
#
# SUCCESS:
# rho = 0.794
#
# USCopiesW1:
# rho = 0.909
#
# BUDGET:
# rho = 0.694
#
# The Spearman correlation for USCopiesW1 is very high. This indicates a strong
# monotonic relationship between the number of copies and first week US sales.
#
# However, for a simple linear regression model, the Pearson correlation is more
# directly relevant because the model estimates a linear relationship.

# Recommendation:
# SUCCESS is recommended as the predictor for the simple linear regression model.
#
# Reason:
# SUCCESS has the strongest Pearson correlation with USSalesW1 among the four
# potential predictors.
#
# STARPOWER is clearly weaker.
# USCopiesW1 has the strongest Spearman correlation, but its Pearson correlation
# is lower than that of SUCCESS.
# BUDGET is also strongly related to USSalesW1, but less strongly than SUCCESS.
#
# Therefore, SUCCESS appears to be the most suitable predictor for this simple
# linear prediction model.


# ============================================================
# b. Simple linear regression with SUCCESS
# ============================================================

# The simple linear regression model is estimated with:
#
# Dependent variable:
# USSalesW1
#
# Independent variable:
# SUCCESS

lreg <- lm(
  USSalesW1 ~ SUCCESS,
  data = df
)

coef(lreg)

summary(lreg)$r.squared

# Estimated regression equation:
#
# USSalesW1_hat = -4,720,296 + 1,027,584 * SUCCESS
#
# Interpretation of the intercept:
# If SUCCESS were 0, the predicted first week US sales would be -4,720,296 US$.
#
# This value is not meaningful in practical terms because negative sales are
# impossible and a SUCCESS value of 0 may be outside the relevant interpretation
# range. In this model, the intercept is mainly needed to calculate predictions.
#
# Interpretation of the slope:
# For each additional point in the success indicator, the predicted first week
# US box office sales increase by about 1,027,584 US$ on average.
#
# Interpretation of R squared:
# R squared = 0.6051
#
# This means that about 60.51% of the variance in first week US box office sales
# is explained by SUCCESS.
#
# The model therefore has a reasonably strong explanatory power for a simple
# linear regression model. However, 39.49% of the variance remains unexplained.


# ============================================================
# c. Prediction for a new film
# ============================================================

# Task:
# Predict first week US box office sales for a film with the following values:
#
# SUCCESS = 70
# STARPOWER = 60
# USCopiesW1 = 3400
# BUDGET = 90,000,000
#
# Since the model only uses SUCCESS as predictor, only SUCCESS = 70 is used
# for the prediction.

xpred <- data.frame(
  SUCCESS = 70
)

xpred$estimate <- predict(
  lreg,
  newdata = xpred
)

xpred$estimate

# Prediction:
#
# USSalesW1_hat = -4,720,296 + 1,027,584 * 70
#
# USSalesW1_hat = 67,210,589
#
# For a film with a success indicator of 70 points, first week US box office
# sales of approximately 67.21 million US$ can be expected.

# Reliability of the estimate:
#
# The estimate is based on a model with R squared = 0.6051.
#
# This means that SUCCESS explains about 60.51% of the variance in first week
# US box office sales.
#
# Therefore, the estimate is useful, but it should not be interpreted as exact.
# A substantial part of the variation in first week US sales is still not explained
# by the model.
#
# In addition, the prediction only uses SUCCESS. The values for STARPOWER,
# USCopiesW1 and BUDGET are not included in this simple regression model.
#
# A more reliable prediction might be possible with a multiple regression model,
# but this task asks for a simple linear regression model using only the relevant
# predictor selected in part a.
