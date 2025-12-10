############################################################
# Author: Jan-Hendrik Schünemann
# Contact: jan-hendrik.schuenemann(at)haw-hamburg.de
# Module: STAT
# Assignment / Task: Task 2 – Personnel data
# Version: v1.0
# Last Update: 2025-12-10
#
# Required Dataset(s): personnel_survey.rds
# Required Packages: summarytools, dplyr, ggplot2, plotly
#
# R Version:
# Operating System:
# License: MIT
############################################################


## 1. Load data --------------------------------------------------------------

df <- readRDS("personnel_survey.rds")
# readRDS(): loads an R object stored in a .rds file.


## 2. Frequency tables ------------------------------------------------------

# If you have not installed the packages yet:
# install.packages("summarytools")
# install.packages("dplyr")

library(summarytools)
library(dplyr)
# summarytools gives us freq()
# dplyr gives us pipes (%>%) and select()


### Default method: df$variable  (beginner-friendly)

# Here we use df$experience, df$education, etc.
# The $ tells R: "Take the column with this name from the data frame df".
# If we only wrote experience, R would look for an object called "experience"
# in the global environment and might not find it.

freq(df$experience)  # Professional experience
freq(df$education)   # Education level
freq(df$gender)      # Gender

# Gross salary is continuous → frequency tables are not very informative
# (many different values). A histogram or grouping into classes would be better.
# freq(df$salary)  # optional, not required here


### Optional method 1: Using select() + pipe

df %>%
  select(experience) %>%
  freq()

df %>%
  select(education) %>%
  freq()

df %>%
  select(gender) %>%
  freq()


### Optional method 2: Passing df into freq() and naming the variable

df %>% freq(experience)
df %>% freq(education)
df %>% freq(gender)


## 3. Visualisations --------------------------------------------------------

# If you have not installed the packages yet:
# install.packages("ggplot2")
# install.packages("plotly")

library(ggplot2)
library(plotly)

# Year of joining (bar chart)
ggplot(df, aes(x = as.factor(date))) +
  geom_bar() +
  labs(
    title = "Year of Joining",
    x = "Year of joining",
    y = "Number of employees"
  )

# Department (bar chart)
ggplot(df, aes(x = department)) +
  geom_bar() +
  labs(
    title = "Employees by Department",
    x = "Department",
    y = "Number of employees"
  )

# Full-time vs Part-time (interactive pie chart – main version)
plot_ly(
  data = df,
  labels = ~type,
  type = "pie"
) %>%
  layout(title = "Full-Time vs Part-Time Employment")


## Optional: ggplot2 pie chart (secondary example, not required) -------------

# ggplot(df, aes(x = "", fill = type)) +
#   geom_bar(width = 1) +
#   coord_polar("y") +
#   labs(title = "Employment Type") +
#   theme_void()


## 4. Percentiles (P40 & P50) for age --------------------------------------

# quantile() calculates percentiles.
# type = 2 uses the (n + 1) rule from class.
# This is the only version students can check manually.
# Other type values use slightly different calculation methods.

quantile(df$age, probs = 0.40, type = 2, na.rm = TRUE)  # P40
quantile(df$age, probs = 0.50, type = 2, na.rm = TRUE)  # P50 = median

# Interpretation examples:
# P40: 40% of employees are this age or younger.
# P50: Median age → half of the employees are younger/equal, half are older.
