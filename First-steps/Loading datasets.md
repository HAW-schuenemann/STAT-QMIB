# Loading Data into R  
Author: Jan-Hendrik Schünemann  
Module: STAT / QMIB  
Version: v1.0  
Last Update: 2025-12-11  
License: MIT  

---

## 1. Overview

In this guide, you will learn two ways to load datasets into R:

1. Loading data via **R code**  
2. Loading data through the **RStudio file window**

Both methods work, but for assignments and reproducibility, loading data via code is preferred.

Before loading data, make sure your **working directory is set correctly**  
(see the Working Directory Guide).

---

## 2. Why We Use `.rds` Files in This Course

Many datasets in this module are provided as `.rds` files instead of `.csv`.  
This is intentional for several reasons:

### 2.1 `.rds` preserves correct variable types
When we load `.rds` files, R restores all variables exactly as they were created:

- numeric stays numeric  
- factors stay factors  
- dates stay dates  
- ordered factors stay ordered  

CSV files cannot reliably preserve this information.

### 2.2 `.rds` avoids beginner bugs
Using `.rds` ensures that:

- frequency tables work immediately  
- factors are correctly identified  
- dates load correctly  
- no encoding issues occur  

### 2.3 `.rds` loads faster and safer
- Efficient for R  
- Avoids locale issues (comma vs dot decimals)  
- Supports all R object types  

This makes `.rds` the best format for teaching clean statistical workflows.

---

## 3. Loading Data via Code (Recommended Approach)

### 3.1 Loading `.rds` files

```r
df <- readRDS("personnel_survey.rds")
```

---

### 3.2 Loading `.csv` files

#### Standard CSV in English/International Format  
(Values separated by commas `,`)

```r
df <- read.csv("datafile.csv")
```

#### Important Note for German Users  
Microsoft Excel (German version) often exports CSV files using **semicolon (`;`) separators** instead of commas.

If your CSV uses semicolons, load it like this:

```r
df <- read.csv("datafile.csv", sep = ";")
```

Otherwise, R will read your entire row as one long column.

#### Alternative using readr (automatically detects separator)

```r
library(readr)
df <- read_delim("datafile.csv", delim = ";")
```

or if the file uses commas:

```r
df <- read_csv("datafile.csv")
```

---

### 3.3 Loading Excel files

```r
install.packages("readxl")
library(readxl)

df <- read_excel("datafile.xlsx")
```

---

## 4. Loading Data Using the RStudio File Window

RStudio includes a file explorer (bottom-right pane).

### Steps:

1. Navigate to the dataset  
2. Click on the file name  
3. For `.csv` or `.xlsx`, the **Import Dataset** window appears  
4. For `.rds`, RStudio asks you to **enter a name** for the new data frame  
5. Confirm the name (e.g., `df`)  
6. RStudio loads the data

If you enter `df`, RStudio executes internally:

```r
df <- readRDS("personnel_survey.rds")
```

---

## 5. Why Code-Based Loading Is Preferred

- Ensures reproducibility  
- Scripts remain self-contained  
- Works consistently across computers  
- Required for assignments and exams  

Point-and-click import is useful for beginners, but code is essential for proper analytical work.

---

## 6. Confirming That the Data Loaded Correctly

Check the structure:

```r
str(df)
```

View the first rows:

```r
head(df)
```

Open spreadsheet viewer:

```r
View(df)
```

---

## 7. Summary

| Action | Recommended Method |
|--------|----------------------------|
| Load `.rds` | `readRDS("file.rds")` |
| Load `.csv` (comma) | `read.csv("file.csv")` |
| Load `.csv` (semicolon) | `read.csv("file.csv", sep = ";")` |
| Load Excel | `read_excel()` |
| Point-and-click import | File pane → click file → name object |
| Verify data | `str()`, `head()`, `View()` |
| Why `.rds`? | Preserves variable types, avoids encoding issues |

---

