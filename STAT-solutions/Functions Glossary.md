# Function Glossary  
Author: Jan-Hendrik Schünemann  
Module: STAT / QMIB  
Version: v1.0  
Last Update: 2025-12-11  
License: MIT  

---

# STAT FUNCTION REFERENCE (Alphabetical Order)
**📘 STAT Course Function Reference (Alphabetical Order) - All functions used in Tasks 1–17**

This reference lists all R functions used across Tasks 1–17, providing comprehensive details on usage and core arguments.

For each function, you will find:
* What it does
* How to use it (simple example with arguments)
* Which package it belongs to
* Notes (if needed)

---

## **1. arrange()**
* **Package:** `dplyr`
* **Purpose:** Sorts a data frame by the values of one or more specified columns.
* **Core Arguments:**
    * `...`: The columns to sort by. Use `desc()` to sort in descending order.
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
* **Core Arguments:**
    * `x`: The object to be coerced to numeric.
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
* **Core Arguments:**
    * `x`: A table object (e.g., created by `table()`).
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
* **Core Arguments:**
    * `x`: The numeric vector or list of vectors for the plot.
    * `main`: Optional title for the plot.
* **Usage:**
    ```r
    boxplot(
        df$DECopiesW1, # The numeric vector for which to draw the boxplot
        main = "Distribution of Copies" 
    )
    ```

---

## **5. case_when()**
* **Package:** `dplyr`
* **Purpose:** Performs conditional logic (like an `if/else if/else` structure) to create new variables based on multiple criteria.
* **Core Arguments:**
    * `...`: Pairs of logical conditions (LHS) and corresponding results (RHS), separated by a tilde (`~`). `TRUE ~ result` is the catch-all final case.
* **Usage:**
    ```r
    df %>% mutate(
        new_var = case_when(
            x > 10 ~ "High",   # Condition (LHS) ~ Result (RHS)
            x > 5 ~ "Medium",
            TRUE ~ "Other"     # The 'else' condition
        )
    )
    ```

---

## **6. cbind()**
* **Package:** Base R
* **Purpose:** Combines R objects (e.g., vectors, matrices, or data frames) by columns (column bind).
* **Core Arguments:**
    * `...`: The R objects to combine.
* **Usage:**
    ```r
    cbind(
        abs = table(age),         # First object (named column)
        rel = table(age)/length(age) # Second object
    )
    ```

---

## **7. complete.cases()**
* **Package:** Base R
* **Purpose:** Returns a logical vector (`TRUE`/`FALSE`) indicating which rows in a data frame or vector have **no missing values** (`NA`).
* **Core Arguments:**
    * `...`: The vectors or data frames to test for completeness.
* **Usage:**
    ```r
    # Subset df to include only rows where AGE is not missing
    df[
        complete.cases(df$AGE), # Returns TRUE for non-NA rows
        ]
    ```

---

## **8. cor()**
* **Package:** Base R
* **Purpose:** Computes the correlation coefficient between two vectors.
* **Core Arguments:**
    * `x`, `y`: First and second numeric vectors.
    * `method`: The correlation method, typically `"pearson"` (linear), `"spearman"` (rank-based), or `"kendall"`.
    * `use`: How to handle NAs, often `"pairwise.complete.obs"`.
* **Usage:**
    ```r
    cor(
        df$x,           
        df$y,           
        method = "pearson"
    )
    ```

---

## **9. coord_polar()**
* **Package:** `ggplot2`
* **Purpose:** Converts a Cartesian coordinate system into a **polar coordinate system**, used primarily to turn bar charts into pie charts.
* **Core Arguments:**
    * `theta`: The aesthetic to map to the angle, usually `"x"` or `"y"`. For pie charts derived from counts, this is `"y"`.
* **Usage:**
    ```r
    coord_polar(
        "y" 
    )
    ```

---

## **10. CrossTable()**
* **Package:** `gmodels`
* **Purpose:** Creates a highly detailed two-way frequency table (cross-tabulation) including percentages and $\chi^2$ statistics.
* **Core Arguments:**
    * `x`: Factor or vector for the rows.
    * `y`: Factor or vector for the columns.
* **Usage:**
    ```r
    CrossTable(
        df$A, 
        df$B
    )
    ```

---

## **11. cume_dist()**
* **Package:** `dplyr`
* **Purpose:** Calculates the **cumulative distribution** of values, returning a value between 0 and 1.
* **Core Arguments:**
    * `x`: The numeric vector.
* **Usage:**
    ```r
    df %>% mutate(
        cum = cume_dist(DECopiesW1)
    )
    ```

---

## **12. cut()**
* **Package:** Base R
* **Purpose:** Divides a numeric vector into intervals (bins) and codes the values as a factor.
* **Core Arguments:**
    * `x`: The numeric vector to cut.
    * `breaks`: A numeric vector of cut points (boundaries).
    * `include.lowest`: Logical, indicating if the lowest value should be included in the first interval.
* **Usage:**
    ```r
    cut(
        x, 
        breaks = quantile(x, probs = seq(0, 1, by = 0.2)), # Creates equal frequency breaks
        include.lowest = TRUE 
    )
    ```
* **Note:** The example usage creates classes with approximately **equal frequencies** (quintiles).

---

## **13. filter()**
* **Package:** `dplyr`
* **Purpose:** Selects a subset of rows based on specified logical conditions.
* **Core Arguments:**
    * `...`: Logical expressions defining the conditions to keep rows.
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
* **Purpose:** Generates a comprehensive one-way frequency table showing counts, frequencies, and cumulative frequencies.
* **Core Arguments:**
    * `x`: The vector to analyze.
    * `report.nas`: Logical, whether to report NAs as a category.
* **Usage:**
    ```r
    freq(
        df$GENRE, 
        report.nas = FALSE 
    )
    ```
* **Note:** Can be used after pipes.

---

## **15. geom_bar()**
* **Package:** `ggplot2`
* **Purpose:** Used within `ggplot()` to create bar charts. By default, it counts the observations in each category.
* **Core Arguments:**
    * `mapping`: Aesthetics to override or compute (e.g., mapping Y to relative frequency).
* **Usage:**
    ```r
    geom_bar(
        mapping = aes(y = after_stat(count/sum(count))) # Shows relative frequency on Y
    )
    ```

---

## **16. geom_boxplot()**
* **Package:** `ggplot2`
* **Purpose:** Used within `ggplot()` to create a boxplot layer.
* **Core Arguments:**
    * `outlier.shape`: Controls the appearance of outliers; often set to `NA` when points are added separately.
* **Usage:**
    ```r
    geom_boxplot(
        outlier.shape = NA 
    )
    ```

---

## **17. geom_point()**
* **Package:** `ggplot2`
* **Purpose:** Used within `ggplot()` to create a layer of points (e.g., for scatter plots or raw data points on a boxplot).
* **Core Arguments:**
    * `alpha`: Transparency level (0 to 1).
    * `position`: How to handle overlapping points, often `position_jitter()` for scatter.
* **Usage:**
    ```r
    geom_point(
        alpha = 0.3, 
        position = position_jitter(width = 0.1) 
    )
    ```

---

## **18. ggplot()**
* **Package:** `ggplot2`
* **Purpose:** The main function to **initialize a plot object** and define the data and the primary aesthetic mappings.
* **Core Arguments:**
    * `data`: The data frame to use.
    * `mapping`: Aesthetic mappings, defined using `aes()`, linking variables to visual properties (e.g., `x`, `y`).
* **Usage:**
    ```r
    ggplot(
        df,         
        aes(x = x, y = y)   
    ) + geom_point() 
    ```

---

## **19. group_by()**
* **Package:** `dplyr`
* **Purpose:** Groups a data frame by one or more variables. Subsequent operations will be applied per group.
* **Core Arguments:**
    * `...`: The columns to group by.
* **Usage:**
    ```r
    df %>% group_by(
        GENRE, 
        AGE    
    )
    ```

---

## **20. kable()**
* **Package:** `knitr` (often used with `kableExtra`)
* **Purpose:** Converts R objects (like data frames or tables) into presentable table formats (e.g., Markdown, HTML).
* **Core Arguments:**
    * `x`: The R object (data frame/table) to format.
    * `caption`: Optional table caption.
    * `digits`: Number of decimal places to round numeric columns to.
* **Usage:**
    ```r
    df %>% kable(
        caption = "Summary Table", 
        digits = 2                 
    )
    ```

---

## **21. labs()**
* **Package:** `ggplot2`
* **Purpose:** Defines or overrides the labels for plot elements (title, axes, legends).
* **Core Arguments:**
    * `title`, `subtitle`: Main and secondary title.
    * `x`, `y`: Axis labels.
    * `fill`, `color`: Legend titles.
* **Usage:**
    ```r
    labs(
        title = "Plot Title",
        x = "X-Axis Label",
        y = "Y-Axis Label"
    )
    ```

---

## **22. mean(), median(), min(), max()**
* **Package:** Base R
* **Purpose:** Standard functions for calculating measures of central tendency (`mean`, `median`) and range (`min`, `max`).
* **Core Arguments:**
    * `x`: The numeric vector.
    * `na.rm`: Logical, **must be set to `TRUE`** to remove `NA` values before calculation.
* **Usage:**
    ```r
    mean(
        df$x,          
        na.rm = TRUE   
    )
    ```

---

## **23. mutate()**
* **Package:** `dplyr`
* **Purpose:** Adds new variables to an existing data frame or modifies the values of existing variables.
* **Core Arguments:**
    * `...`: New column names followed by an equals sign and the expression defining the new variable.
* **Usage:**
    ```r
    df %>% mutate(
        y = x * 2,         # Creates new variable 'y'
        z = log(x)         # Creates new variable 'z'
    )
    ```

---

## **24. plot()**
* **Package:** Base R
* **Purpose:** Generic function for plotting. Creates **scatterplots** for two numeric variables and **mosaic plots** for two categorical variables. 
* **Core Arguments:**
    * `x`, `y`: The vectors to plot.
* **Usage:**
    ```r
    plot(
        df$x, # Numeric x
        df$y  # Numeric y -> Scatterplot
    )

    plot(
        df$A, # Categorical A
        df$B  # Categorical B -> Mosaic Plot
    )
    ```

---

## **25. plot_ly()**
* **Package:** `plotly`
* **Purpose:** The main function for creating **interactive, web-based graphs**.
* **Core Arguments:**
    * `data`: The data frame.
    * `labels`: The column for the slice labels (e.g., category names).
    * `values`: The column for the slice values (e.g., counts).
    * `type`: The type of plot, e.g., `"pie"`.
* **Usage:**
    ```r
    plot_ly(
        df,          
        labels = ~BOOK, 
        values = ~count, 
        type = "pie" 
    )
    ```

---

## **26. quantile()**
* **Package:** Base R
* **Purpose:** Computes sample quantiles corresponding to given probabilities (e.g., percentiles, quartiles).
* **Core Arguments:**
    * `x`: The numeric vector.
    * `probs`: The probability (or vector of probabilities) for which to find the quantile (0 to 1).
    * `type`: The algorithm used for calculation; **`type = 2`** is used in the course.
* **Usage:**
    ```r
    quantile(
        df$age,      
        probs = 0.33, 
        type = 2     
    )
    ```
* **Note:** `type = 2` matches the $(n+1)p$ percentile rule used in the course.

---

## **27. readRDS()**
* **Package:** Base R
* **Purpose:** Loads a single R object (like a data frame) that was saved in the RDS binary format.
* **Core Arguments:**
    * `file`: The path and filename of the RDS file.
* **Usage:**
    ```r
    df <- readRDS(
        "data.rds" 
    )
    ```

---

## **28. rowSums()**
* **Package:** Base R
* **Purpose:** Calculates the sum of values for each row across specified columns of a matrix or data frame.
* **Core Arguments:**
    * `x`: The array or data frame (usually subsetted to the columns of interest).
    * `na.rm`: Logical, set to `TRUE` to ignore `NA` values in the sum.
* **Usage:**
    ```r
    rowSums(
        df[, c("W1", "W2", "W3", "W4")], # Subsetting the columns
        na.rm = TRUE 
    )
    ```

---

## **29. select()**
* **Package:** `dplyr`
* **Purpose:** Selects and/or renames columns.
* **Core Arguments:**
    * `...`: Column names to keep (or rename using `new_name = old_name`).
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
* **Core Arguments:**
    * `counts`: A vector of counts or frequencies for each category.
    * `unbiased`: Logical, typically `FALSE` for the course.
* **Usage:**
    ```r
    simpson(
        as.numeric(table(df$COMP_INT)), 
        unbiased = FALSE
    )
    ```

---

## **31. stat_boxplot()**
* **Package:** `ggplot2`
* **Purpose:** A statistical summary layer used to calculate boxplot statistics. Used to manually add the whisker bars to a boxplot.
* **Core Arguments:**
    * `geom`: The geometry to use for the calculated stats, typically `"errorbar"` for whiskers.
    * `width`: Width of the errorbar caps.
* **Usage:**
    ```r
    stat_boxplot(
        geom = "errorbar", 
        width = 0.2        
    )
    ```

---

## **32. summarise()**
* **Package:** `dplyr`
* **Purpose:** Collapses a data frame into summary statistics (one row per group or one row total).
* **Core Arguments:**
    * `...`: New column names followed by an equals sign and the summary function (e.g., `mean()`, `n()`).
* **Usage:**
    ```r
    df %>% summarise(
        mean_x = mean(x, na.rm = TRUE), # Calculate mean
        n_obs = n()                     # Count observations
    )
    ```

---

## **33. table()**
* **Package:** Base R
* **Purpose:** Creates a one-way (frequency) or two-way (contingency) table of counts for categorical vectors.
* **Core Arguments:**
    * `...`: The categorical vectors to cross-tabulate.
* **Usage:**
    ```r
    table(
        df$A, # First vector (rows)
        df$B  # Second vector (columns)
    )
    ```

---

## **34. theme_minimal() / theme_void()**
* **Package:** `ggplot2`
* **Purpose:** Predefined theme functions to quickly change the visual appearance of a `ggplot2` plot. `theme_void()` removes all visual noise, ideal for pie charts.
* **Core Arguments:** None required; applied directly to the plot.
* **Usage:**
    ```r
    theme_minimal()
    theme_void()
    ```

---

## **35. ungroup()**
* **Package:** `dplyr`
* **Purpose:** Removes the grouping applied by `group_by()`.
* **Core Arguments:** None required; applied directly after a grouped operation.
* **Usage:**
    ```r
    df %>% ungroup()
    ```

---

## **36. xlim()**
* **Package:** `ggplot2`
* **Purpose:** Manually sets the range (minimum and maximum) of the x-axis.
* **Core Arguments:**
    * `...`: The minimum and maximum limits (e.g., `c(min, max)`).
* **Usage:**
    ```r
    xlim(
        -1, # Lower limit
        1   # Upper limit
    )
    ```

---

## **37. ylab(), xlab()**
* **Package:** `ggplot2`
* **Purpose:** Convenience functions to define the label for the y-axis (`ylab()`) and x-axis (`xlab()`) in a `ggplot2` plot.
* **Core Arguments:**
    * `label`: A character string containing the desired axis label.
* **Usage:**
    ```r
    ylab("Visitors")
    xlab("Category")
    ```
