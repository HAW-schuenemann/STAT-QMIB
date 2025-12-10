##############
### TASK 2 ###
##############

# Load data
df <- readRDS("personnel_survey.rds")

# --- Frequency Tables ---

# Load necessary libraries
if(!require(summarytools)) install.packages("summarytools")
library(summarytools)

# Frequency table for 'professional experience'
experience_table <- freq(df$experience, style = "simple")
print(experience_table)

# Frequency table for 'education'
education_table <- freq(df$education, style = "simple")
print(education_table)

# Frequency table for 'gender'
gender_table <- freq(df$gender, style = "simple")
print(gender_table)

# Frequency table for 'gross salary'
# Note: Since 'gross salary' is a continuous variable, consider whether a frequency table is useful.
# Frequency tables are typically more informative for categorical data.
salary_table <- freq(df$salary, style = "simple")
print(salary_table)

# --- Visualizations ---

# Load ggplot2 for visualization
if (!require(ggplot2)) install.packages("ggplot2")
library(ggplot2)

# Visualization of Year of Joining
ggplot(df, aes(x = as.factor(date))) +
  geom_bar() +
  labs(title = "Year of Joining", x = "Year", y = "Count of Employees")

# Visualization of Department
ggplot(df, aes(x = department)) +
  geom_bar() +
  labs(title = "Employee Count by Department", x = "Department", y = "Count")

# Visualization of Employment Type (Full-Time/Part-Time)
ggplot(df, aes(x = "", fill = type)) +
  geom_bar(width = 1) +
  coord_polar("y", start = 0) +
  labs(title = "Full-Time vs Part-Time Employment") +
  theme_void()

library(plotly)

plot_ly(
  data = df,
  labels = ~type,
  type = "pie"
) %>%
  layout(
    title = "Full-Time vs Part-Time Employment"
  )

# --- Percentile Calculations for Age ---

# Calculate the 40th and 50th percentiles for age
P40 <- quantile(df$age, 0.40, na.rm = TRUE)
P50 <- quantile(df$age, 0.50, na.rm = TRUE)  # 50th percentile is also the median

# Interpretation of Percentiles
print(P40)
# P40 (40th Percentile) = 37.2
# This means that at least 40% of employees are aged 37.2 years or younger.
# Conversely, at least 60% of employees are older than 37.2 years.

print(P50)
# The 50th percentile (or median) indicates that at least half of the employees are aged 38 years or younger,
# while the other half are older than 38. This median value represents the central point in the age
# distribution of employees, showing an even split between younger and older employees.

# Summary
# These percentiles suggest that most employees are in a similar age range, with the age distribution
# slightly concentrated around the upper 30s.
