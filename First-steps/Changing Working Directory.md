# Working Directory Guide  
Author: Jan-Hendrik Schünemann  
Module: STAT / QMIB  
Version: v1.0  
Last Update: YYYY-MM-DD  
License: MIT  

---

## 1. Why the Working Directory Matters

In this course, you will often load datasets from your computer using commands such as:

```r
df <- readRDS("personnel_survey.rds")
```

R must know *where* to find this file.  
Unlike Excel or SPSS, you cannot simply double-click a dataset to open it in R.

Therefore, you must set your **working directory** to the folder where your data files are stored.

The working directory tells R:

> “This is the default folder where my files are located and where new files should be saved.”

If the working directory is wrong, R will display errors such as:

```
Error in readRDS("file.rds") : cannot open the connection
```

---

## 2. How to Check Your Current Working Directory

Run:

```r
getwd()
```

This prints the folder RStudio is currently using.

---

## 3. Changing the Working Directory (via RStudio menu)

This is the easiest and most beginner-friendly method.

### RStudio Menu:

1. Click **Session** in the top menu  
2. Choose **Set Working Directory**  
3. Select **Choose Directory…**  
4. Navigate to your folder containing the datasets  
5. Click **Open**

RStudio will print a command like:

```r
setwd("C:/Users/Name/Documents/STAT/")
```

This confirms that the working directory has been updated.

---

## 4. Changing the Working Directory (via R code)

Alternatively, you can set it manually:

```r
setwd("C:/path/to/your/folder")
```

Examples:

```r
setwd("C:/Users/Student/Documents/STAT")
setwd("/Users/student/Desktop/RProjects")
```

Important notes:

- Use **forward slashes `/`** even on Windows  
- Adjust the path according to your own folder structure  

---

## 5. Recommended Workflow in This Course

1. Create a dedicated folder for the module (e.g., `STAT` or `QMIB`).  
2. Save all datasets and R scripts inside this folder.  
3. At the start of each session, set your working directory:

   - via **Session → Set Working Directory → Choose Directory…**, or  
   - via `setwd("…")`  

4. Confirm with:

```r
getwd()
```

---

## 6. Loading Data After Setting the Working Directory

Once the working directory is correctly set, loading data becomes straightforward:

```r
df <- readRDS("personnel_survey.rds")
```

No full path is needed, because R now looks inside the working directory automatically.

---
