# dplyr, Understanding Pipes (`%>%`) and Basic Data Transformations in R  
Author: Jan-Hendrik Schünemann  
Module: STAT / QMIB  
Version: v1.0  
Last Update: 2025-12-11  
License: MIT  

---

## 1. Overview

In this course we work with R in two styles:

### Base R style (no pipes)
```r
freq(df$gender)
```

### dplyr style (with pipes)
```r
df %>% freq(gender)
```

Both work for simple frequency tables.  
However:

---

## 2. When Are Pipes Optional, and When Are They Required?

### Pipes are optional when:
- You are *not* modifying the data  
- You are only accessing an existing variable  
- You are only using functions like `freq(df$variable)`  

### Pipes are *not* optional when:
- You are using **dplyr transformations**, such as:

  - `select()`
  - `filter()`
  - `mutate()`
  - `summarise()`
  - `group_by()`

These functions are designed to work naturally with the pipe operator.

Example:

```r
df %>% 
  filter(gender == "Female") %>% 
  select(age)
```

Trying to write this without pipes is technically possible but much harder to read:

```r
select(filter(df, gender == "Female"), age)
```

For this reason, **pipes are considered standard when transforming data**.

---

## 3. What Does a Pipe (`%>%`) Do?

The pipe operator from **dplyr** passes the object on the left into the function on the right.

```r
df %>% freq(gender)
```

reads as:

> “Take df and apply freq() to the variable gender.”

Equivalent base R:

```r
freq(df$gender)
```

---

## 4. Why Pipes Improve Readability

Without pipes:

```r
freq(select(filter(df, gender == "Female"), department))
```

With pipes:

```r
df %>% 
  filter(gender == "Female") %>% 
  select(department) %>% 
  freq()
```

This reads **step by step**, making the logic obvious.

---

## 5. Important: Pipes Do Not Modify Your Data

This code:

```r
df %>% select(age)
```

does **not** change `df`.

It only creates a temporary object in the pipeline.

To save the result:

```r
df_age <- df %>% select(age)
```

---

## 6. dplyr: The Four Most Important Verbs

The following functions will be used throughout STAT and QMIB.  
These form the core of data transformation in R.

---

### 6.1 `select()` — choose columns

```r
df %>% select(age, gender)
```

This keeps only the specified columns.

Equivalent base R (more complicated):

```r
df[, c("age", "gender")]
```

---

### 6.2 `filter()` — choose rows based on conditions

```r
df %>% filter(gender == "Female")
```

Multiple conditions:

```r
df %>% filter(gender == "Female", age > 30)
```

Equivalent base R:

```r
df[df$gender == "Female" & df$age > 30, ]
```

---

### 6.3 `mutate()` — create or transform variables

```r
df %>% mutate(age_in_months = age * 12)
```

Or modify an existing variable:

```r
df %>% mutate(salary = salary / 1000)
```

Equivalent base R is longer and harder to read.

---

### 6.4 `summarise()` — compute statistics

Used together with `group_by()`:

```r
df %>%
  group_by(department) %>%
  summarise(
    avg_age = mean(age),
    n = n()
  )
```

This creates one summary row per department.

---

## 7. Combined Example

A realistic transformation often used in assignments:

```r
df %>%
  filter(gender == "Female") %>%
  select(age, department, salary) %>%
  mutate(
    salary_k = salary / 1000
  ) %>%
  group_by(department) %>%
  summarise(
    avg_age = mean(age),
    avg_salary = mean(salary_k),
    n = n()
  )
```

This reads as:

1. Take df  
2. Keep only female employees  
3. Keep selected columns  
4. Create a new salary variable  
5. Group by department  
6. Compute summary statistics  

---

## 8. Summary

- The pipe (`%>%`) passes the result of one step into the next step.  
- Pipes are **optional** for simple access like `freq(df$age)`.  
- Pipes are **required** for all data transformations using `dplyr`.  
- Key dplyr verbs:

  - `select()` → choose columns  
  - `filter()` → filter rows  
  - `mutate()` → create/modify variables  
  - `summarise()` → summary statistics  

- Pipes improve readability and make code flow logically from top to bottom.

---

