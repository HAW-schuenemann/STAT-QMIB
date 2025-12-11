# Function Glossary  
Author: Jan-Hendrik Schünemann  
Module: STAT / QMIB  
Version: v1.0  
Last Update: 2025-12-11  
License: MIT  

---

# STAT FUNCTION REFERENCE (Alphabetical Order)
**📘 STAT Course Function Reference (Alphabetical Order) - All functions used in Tasks 1–17**

This reference lists all R functions used across Tasks 1–17, providing detailed usage and arguments.

For each function, you will find:
* What it does
* How to use it (simple example with arguments)
* Which package it belongs to
* Notes (if needed)

---

## **1. arrange()**
* **Package:** `dplyr`
* **Purpose:** Sorts a data frame by the values of one or more specified columns.
* **Usage:**
    ```r
    df %>% arrange(
        DECopiesW1, # Column to sort by (ascending)
        desc(BOOK)  # Use desc() for descending order
    )
    ```

---

## **2. as.numeric()**
* **Package:** Base R
* **Purpose:** Converts the input object (usually a factor or character vector) into a numeric vector.
* **Usage:**
    ```r
    as.numeric(
        df$BOOK # The vector (e.g., factor column) to convert
    )
    ```
* **Note:** Needed for correlations involving categorical variables that have been converted to numeric codes.

---

## **3. assocstats()**
* **Package:** `vcd`
* **Purpose:** Calculates various association statistics for a two-way contingency table, including **Cramer's V**, **contingency coefficient**, and **$\chi^2$ statistics**.
* **Usage:**
    ```r
    assocstats(
        table(df$BOOK, df$CIN_TIP) # The contingency table object
    )
    ```

---

## **4. boxplot()**
* **Package:** Base R
* **Purpose:** Creates a simple base R box-and-whisker plot for visualizing the distribution of a single metric variable.
* **Usage:**
    ```r
    boxplot(
        df$DECopiesW1, # The numeric vector for which to draw the boxplot
        main = "Distribution of Copies" # Optional: Plot title
    )
    ```
* **Note:** The boxplot visually represents the five-number summary (minimum, Q1, median, Q3, maximum/outliers). 

[Image of box and whisker plot diagram]


---

## **5. case_when()**
* **Package:** `dplyr`
* **Purpose:** Performs conditional logic (like an `if/else if/else` structure) to create new variables based on multiple criteria.
* **Usage:**
    ```r
    df %>% mutate(
        new_var = case_when(
            x > 10 ~ "High",   # Condition (LHS) ~ Result (RHS) if condition is TRUE
            x > 5 ~ "Medium",
            TRUE ~ "Other"     # TRUE is the catch-all "else" condition
        )
    )
    ```

---

## **6. cbind()**
* **Package:** Base R
* **Purpose:** Combines R objects (e.g., vectors, matrices, or data frames) by columns (column bind).
* **Usage:**
    ```r
    cbind(
        abs = table(age),         # First object (e.g., absolute frequencies)
        rel = table(age)/length(age) # Second object (e.g., relative frequencies)
    )
    ```

---

## **7. complete.cases()**
* **Package:** Base R
* **Purpose:** Returns a logical vector (`TRUE`/`FALSE`) indicating which rows in a data frame or vector have **no missing values** (`NA`).
* **Usage:**
    ```r
    # Subset df to include only rows where AGE is not missing
    df[
        complete.cases(df$AGE), # Logical vector of TRUE (complete) or FALSE (NA present)
        ]
    ```

---

## **8. cor()**
* **Package:** Base R
* **Purpose:** Computes the correlation coefficient between two vectors.
* **Usage:**
    ```r
    cor(
        df$x,           # First numeric vector
        df$y,           # Second numeric vector
        method = "pearson", # The correlation method: "pearson", "spearman", or "kendall"
        use = "pairwise.complete.obs" # How to handle NAs
    )
    ```

---

## **9. coord_polar()**
* **Package:** `ggplot2`
* **Purpose:** Converts a Cartesian coordinate system (used by standard plots) into a **polar coordinate system**. This is primarily used to turn bar charts into pie charts.
* **Usage:**
    ```r
    coord_polar(
        "y", # The dimension to map to the angle (usually "y" for pie charts)
        start = 0
    )
    ```

---

## **10. CrossTable()**
* **Package:** `gmodels`
* **Purpose:** Creates a highly detailed two-way frequency table (cross-tabulation) including absolute counts, expected counts, $\chi^2$ components, and row/column/total percentages.
* **Usage:**
    ```r
    CrossTable(
        df$A, # Factor or vector for the rows
        df$B  # Factor or vector for the columns
    )
    ```

---

## **11. cume_dist()**
* **Package:** `dplyr`
* **Purpose:** Calculates the **cumulative distribution** of values, returning a value between 0 and 1 (or 0% and 100%).
* **Usage:**
    ```r
    df %>% mutate(
        cum = cume_dist(DECopiesW1) # The numeric vector for which to calculate the distribution
    )
    ```

---

## **12. cut()**
* **Package:** Base R
* **Purpose:** Divides a numeric vector into intervals (or bins) and codes the values as a factor based on which interval they fall into.
* **Usage:**
    ```r
    cut(
        x, # The numeric vector to cut
        breaks = quantile(x, probs = seq(0, 1, by = 0.2)), # Defines the cut points (boundaries)
        include.lowest = TRUE # Include the lowest value
    )
    ```
* **Note:** When combined with `quantile(probs = seq(0, 1, by = p))`, it creates classes with approximately **equal frequencies**.

---

## **13. filter()**
* **Package:** `dplyr`
* **Purpose:** Selects a subset of rows based on specified logical conditions.
* **Usage:**
    ```r
    df %>% filter(
        GENRE == "Horror", # Condition 1
        AGE >= 18          # Condition 2 (conditions are combined with AND)
    )
    ```

---

## **14. freq()**
* **Package:** `summarytools`
* **Purpose:** Generates a comprehensive one-way frequency table showing counts, frequencies, and cumulative frequencies, with options for plot generation.
* **Usage:**
    ```r
    freq(
        df$GENRE, # The vector to analyze
        report.nas = FALSE # Do not report NAs
    )
    ```
* **Note:** Can be used after pipes, e.g.: `df %>% filter(GENRE == "Horror") %>% freq(GENRE)`

---

## **15. geom_bar()**
* **Package:** `ggplot2`
* **Purpose:** Used within `ggplot()` to create bar charts. By default, it counts the observations in each category (`stat = "count"`).
* **Usage:**
    ```r
    geom_bar(
        mapping = aes(y = after_stat(count/sum(count))) # Map y to relative frequency
    )
    ```

---

## **16. geom_boxplot()**
* **Package:** `ggplot2`
* **Purpose:** Used within `ggplot()` to create a boxplot layer.
* **Usage:**
    ```r
    geom_boxplot(
        outlier.shape = NA # Hide default outliers for use with geom_point
    )
    ```

---

## **17. geom_point()**
* **Package:** `ggplot2`
* **Purpose:** Used within `ggplot()` to create a layer of points (e.g., for scatter plots or to visualize individual data points on a boxplot).
* **Usage:**
    ```r
    geom_point(
        alpha = 0.3, # Transparency level (0=invisible, 1=opaque)
        position = position_jitter(width = 0.1) # Avoid overplotting
    )
    ```

---

## **18. ggplot()**
* **Package:** `ggplot2`
* **Purpose:** The main function to **initialize a plot object** and define the data and the primary aesthetic mappings (variables to axes).
* **Usage:**
    ```r
    ggplot(
        df,         # The data frame to use
        aes(x, y)   # Aesthetic mappings: define variables for x and y axes
    ) + geom_point() # Add subsequent layers
    ```

---

## **19. group_by()**
* **Package:** `dplyr`
* **Purpose:** Groups a data frame by one or more variables. Subsequent functions (like `summarise()` or `mutate()`) will operate *within* these groups.
* **Usage:**
    ```r
    df %>% group_by(
        GENRE, # First grouping variable
        AGE    # Second grouping variable
    )
    ```

---

## **20. kable()**
* **Package:** `knitr` (often used with `kableExtra`)
* **Purpose:** Converts R objects (like data frames or tables) into presentable table formats (e.g., Markdown, HTML, LaTeX).
* **Usage:**
    ```r
    df %>% kable(
        caption = "Summary Table", # Optional table caption
        digits = 2                 # Number of decimal places
    )
    ```

---

## **21. labs()**
* **Package:** `ggplot2`
* **Purpose:** A function used to define or override the labels for plot elements, including the main title, subtitle, and axes.
* **Usage:**
    ```r
    labs(
        title = "Plot Title",
        x = "X-Axis Label",
        y = "Y-Axis Label",
        fill = "Legend Title" # Also used for legend titles
    )
    ```

---

## **22. mean(), median(), min(), max()**
* **Package:** Base R
* **Purpose:** Standard functions for calculating measures of central tendency (`mean`, `median`) and range (`min`, `max`).
* **Usage:**
    ```r
    mean(
        df$x,          # The numeric vector
        na.rm = TRUE   # Crucial argument: remove missing values (NA) before calculation
    )
    ```

---

## **23. mutate()**
* **Package:** `dplyr`
* **Purpose:** Adds new variables to an existing data frame or modifies the values of existing variables.
* **Usage:**
    ```r
    df %>% mutate(
        y = x * 2,         # Create new variable 'y'
        z = log(x)         # Create new variable 'z'
    )
    ```

---

## **24. plot()**
* **Package:** Base R
* **Purpose:** A generic function that produces different types of plots based on the class of its arguments. It creates **scatterplots** for two numeric variables and **mosaic plots** for two categorical variables.
* **Usage:**
    ```r
    plot(
        df$x, # Numeric (x-axis)
        df$y  # Numeric (y-axis) -> Scatterplot 
    )

    plot(
        df$A, # Categorical
        df$B  # Categorical -> Mosaic Plot 
    )
    ```

---

## **25. plot_ly()**
* **Package:** `plotly`
* **Purpose:** The main function for creating **interactive, web-based graphs**.
* **Usage:**
    ```r
    plot_ly(
        df,          # The data frame
        labels = ~BOOK, # Column for the slice labels (e.g., category names)
        values = ~count, # Column for the slice values (e.g., counts or percentages)
        type = "pie" # The type of plot
    )
    ```

---

## **26. quantile()**
* **Package:** Base R
* **Purpose:** Computes sample quantiles corresponding to given probabilities (e.g., percentiles, quartiles).
* **Usage:**
    ```r
    quantile(
        df$age,      # The numeric vector
        probs = 0.33, # The probability (or vector of probabilities) for which to find the quantile
        type = 2     # The algorithm to use for calculation (Type 2 is used in the course)
    )
    ```
* **Note:** `type = 2` calculates the quantile based on the position $k = p(n+1)$, matching the $(n+1)p$ percentile rule used in the course.

---

## **27. readRDS()**
* **Package:** Base R
* **Purpose:** Loads a single R object (like a data frame) that was saved in the RDS binary format.
* **Usage:**
    ```r
    df <- readRDS(
        "data.rds" # The path and filename of the RDS file
    )
    ```

---

## **28. rowSums()**
* **Package:** Base R
* **Purpose:** Calculates the sum of values for each row across specified columns of a matrix or data frame.
* **Usage:**
    ```r
    rowSums(
        df[, c("W1", "W2", "W3", "W4")], # The subset of columns to sum across
        na.rm = TRUE # Remove NAs before calculation
    )
    ```

---

## **29. select()**
* **Package:** `dplyr`
* **Purpose:** Selects and/or renames columns. It is used to quickly subset a data frame by columns.
* **Usage:**
    ```r
    df %>% select(
        A,            # Keep column A
        B,            # Keep column B
        C_new = C     # Rename column C to C_new
    )
    ```

---

## **30. simpson()**
* **Package:** `abdiv`
* **Purpose:** Calculates the **Simpson index of diversity** ($1-D$) based on the counts of different categories.
* **Usage:**
    ```r
    simpson(
        as.numeric(table(df$COMP_INT)), # A vector of counts or frequencies for each category
        unbiased = FALSE
    )
    ```
* **Note:** This measures biodiversity or concentration. A higher value (closer to 1) means higher diversity.

---

## **31. stat_boxplot()**
* **Package:** `ggplot2`
* **Purpose:** A statistical summary layer used to calculate the boxplot statistics. It is used in conjunction with `geom = "errorbar"` to manually add the whisker bars to a boxplot.
* **Usage:**
    ```r
    stat_boxplot(
        geom = "errorbar", # Use the errorbar geometry to draw the whiskers
        width = 0.2        # Width of the whisker caps
    )
    ```

---

## **32. summarise()**
* **Package:** `dplyr`
* **Purpose:** Collapses a data frame into a single row (or one row per group if used after `group_by()`), calculating summary statistics.
* **Usage:**
    ```r
    df %>% summarise(
        mean_x = mean(x, na.rm = TRUE), # Create a column 'mean_x'
        n_obs = n()                     # Count the number of observations in the group/data set
    )
    ```

---

## **33. table()**
* **Package:** Base R
* **Purpose:** Creates a one-way (frequency) or two-way (contingency) table of counts for categorical vectors.
* **Usage:**
    ```r
    table(
        df$A, # First categorical vector (rows in 2D table)
        df$B  # Second categorical vector (columns in 2D table)
    )
    ```

---

## **34. theme_minimal() / theme_void()**
* **Package:** `ggplot2`
* **Purpose:** Predefined theme functions to quickly change the visual appearance of a `ggplot2` plot. **`theme_void()`** removes all axis labels, tick marks, and background, ideal for pie charts.
* **Usage:**
    ```r
    theme_minimal()
    theme_void()
    ```

---

## **35. ungroup()**
* **Package:** `dplyr`
* **Purpose:** Removes the grouping applied by `group_by()`, allowing subsequent operations to be applied to the entire data frame.
* **Usage:**
    ```r
    df %>% ungroup()
    ```

---

## **36. xlim()**
* **Package:** `ggplot2`
* **Purpose:** Manually sets the range (minimum and maximum) of the x-axis.
* **Usage:**
    ```r
    xlim(
        -1, # Lower limit of the x-axis
        1   # Upper limit of the x-axis
    )
    ```

---

## **37. ylab(), xlab()**
* **Package:** `ggplot2`
* **Purpose:** Convenience functions to define the label for the y-axis (`ylab()`) and x-axis (`xlab()`) in a `ggplot2` plot.
* **Usage:**
    ```r
    ylab("Visitors")
    xlab("Category")
    ```
