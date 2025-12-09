##############
### TASK 1 ###
##############

# Original age data
age <- c(25, 28, 23, 24, 27, 24, 22, 32, 24, 26, 28, 30, 26, 25, 24, 25, 24, 27, 25, 23)

# --- Generate the Frequency Table ---

# Absolute frequency
freq_abs <- table(age)

# Relative frequency as percentages
freq_rel <- (freq_abs)/length(age)

# Cumulative relative frequency
freq_cum_rel <- cumsum(freq_rel)

# Combine all into a single table
freq_table <- cbind(
  Absolute = freq_abs,
  Relative_Percentage = round(freq_rel, 2),
  Cumulative_Relative = round(freq_cum_rel, 2)
)

# Print the frequency table
print(freq_table)

# --- Generate the Frequency Table Using summarytools Package ---

# Install summarytools package if not already installed
if(!require(summarytools)) install.packages("summarytools")
library(summarytools)

# Generate the frequency table using summarytools
freq_table <- freq(age, style = "simple")

# Print the frequency table
print(freq_table)

# --- Manual Calculation of Percentiles (P33 and P60) ---

# Sort the age data
age_sorted <- sort(age)

# Total number of participants
N <- length(age_sorted)

# --- Manual Calculation of P60 ---

# Step 1: Calculate the position for P60
P60_position <- N * 0.6  # This gives 12

# Step 2: Take the average of the values at position 12 and 13
P60_value <- (age_sorted[12] + age_sorted[13]) / 2

# Step 3: Display P60 result
print(P60_value)

# --- Manual Calculation of P33 ---

# Step 1: Calculate the position for P33
P33_position <- N * 0.33  # This gives 6.6

# Step 2: Since 6.6 rounds up, we go to position 7
P33_value <- age_sorted[7]

# Step 3: Display P33 result and interpretation
print(P33_value)

# --- Explanation of N+1 Rule ---
# In many statistical software packages, including R, the position for a percentile is calculated as k * (N + 1), where N is the number of observations.
# This spreads the percentile positions more evenly across the dataset, especially in small datasets, making the percentiles more representative.

# --- Using the quantile Function with N+1 Rule in R ---

# Calculate P60 and P33 using the quantile function (which uses the N+1 rule)
P60_quantile <- quantile(age, 0.60, type = 2)
P33_quantile <- quantile(age, 0.33, type = 2)

# Display results from the quantile function
print(P60_quantile)
print(P33_quantile)
