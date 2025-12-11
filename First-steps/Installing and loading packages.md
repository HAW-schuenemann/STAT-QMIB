# Installing and Loading Packages in R  
Author: Jan-Hendrik Schünemann  
Module: STAT / QMIB  
Version: v1.0  
Last Update: 2025-12-11  
License: MIT  

---

## 1. Overview

R packages extend the basic functionality of R. They provide additional tools for:

- data manipulation  
- statistical analysis  
- visualisation  
- importing files  
- reporting  

In this course you will commonly use:

- `summarytools`  
- `dplyr`  
- `ggplot2`  
- `plotly`  

There are three ways to install packages:

1. **Via code** (recommended)  
2. **Via the Packages tab**  
3. **Via the Tools menu**

Loading a package (making it available in your session) is always done via:

```r
library(packageName)
```

---

## 2. Installing Packages via Code (Preferred Method)

This is the most reliable and reproducible method.  
It also documents your workflow in your script.

### 2.1 Installing a single package

```r
install.packages("summarytools")
```

### 2.2 Installing multiple packages

```r
install.packages(c("summarytools", "dplyr", "ggplot2", "plotly"))
```

You only need to **install** each package once on your computer.

---

## 3. Loading Packages via Code

Once installed, a package must be loaded *every time you start RStudio*.

```r
library(summarytools)
```

Example:

```r
install.packages("dplyr")   # install once
library(dplyr)              # load in every session
```

---

## 4. Installing Packages via the RStudio **Packages** Tab

RStudio provides a point-and-click method for installing packages.

### Steps:

1. Open RStudio  
2. Go to the **Packages** tab (bottom-right pane)  
3. Click the **Install** button  
4. Enter the package name (e.g., `ggplot2`)  
5. Click **Install**

RStudio will run the corresponding command internally:

```r
install.packages("ggplot2")
```

---

## 5. Installing Packages via the RStudio **Tools** Menu

This is an alternative to the Packages tab.

### Steps:

1. In the top menu bar, click **Tools**  
2. Select **Install Packages…**  
3. Enter the package name  
4. Ensure “Install from: Repository (CRAN)” is selected  
5. Click **Install**

This performs the same installation as:

```r
install.packages("packageName")
```

The Tools menu is useful on smaller screens where the Packages tab may be collapsed.

---

## 6. Loading Packages via the RStudio Menu

You can load installed packages via the Packages tab:

1. Open the **Packages** tab  
2. Scroll or search for the package  
3. Tick the checkbox next to its name  

RStudio internally runs:

```r
library(packageName)
```

### Why loading via code is preferred

- Menu actions are not recorded in your script  
- Your analysis becomes non-reproducible  
- Assignments and exams require explicit `library()` calls  
- Anyone reading your code must see which packages you rely on  

Therefore, always use `library()` in your scripts.

---

## 7. Troubleshooting

### 7.1 "Package not found" or similar error
You may have forgotten to install it:

```r
install.packages("packageName")
```

### 7.2 macOS users: missing XQuartz
Some packages require XQuartz.  
See the Installation Guide for details.

### 7.3 Internet connection is required
Package installation downloads files from CRAN.

### 7.4 Installation errors due to missing dependencies
Try reinstalling with:

```r
install.packages("packageName", dependencies = TRUE)
```

---

## 8. Summary

| Task | Method | Notes |
|------|--------|-------|
| Install a package (preferred) | `install.packages("pkg")` | Run once |
| Install several | `install.packages(c("a","b","c"))` | Run once |
| Install via Packages tab | Packages → Install | Convenient |
| Install via Tools menu | Tools → Install Packages… | Alternative |
| Load a package | `library(pkg)` | Every R session |
| Load via menu | Packages → check box | Not recommended |
| Document usage | Include `library(pkg)` in scripts | Required in class |

---

