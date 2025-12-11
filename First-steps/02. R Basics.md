# R Basics Guide  
Author: Jan-Hendrik Schünemann  
Module: STAT / QMIB  
Version: v1.0  
Last Update: 2025-12-11  
License: MIT  

---

## 1. The Two Main Areas in RStudio

RStudio has two different places where you can write or run code.

### 1. Script Editor (Top-Left Pane)

- This is your **text editor**, where you write and save R scripts (`.R` files).  
- Code written here does **not** execute automatically.  
- You must send code to the console to run it.

There are three ways to run code from the script:

1. **Ctrl + Enter** (Windows) or **Cmd + Enter** (Mac)  
   Runs the current line or selection.
2. **Highlight multiple lines** and then press **Run** (top right of the script panel).  
3. **Click on a line** and press **Run**  
   - RStudio will run that line  
   - If the line is part of a multi-line function call, RStudio may run the whole block

The script editor is the preferred place to write reproducible analyses.

---

### 2. Console (Bottom-Left Pane)

- This is where R executes commands immediately.  
- Code typed here runs as soon as you press Enter.  
- Nothing typed in the console is saved unless you copy it into your script.

Use the console for testing small commands, but keep your main work in the script.

---

## 3. Assigning Values to Objects

You store values in **objects** using the assignment operator `<-`:

```r
x <- 5
```

This saves the value 5 into the object `x` and places it in the **Global Environment**.

---

## 4. Assignment Does Not Print Output

Assignments do **not** print a result:

```r
x <- 5 + 3
```

Nothing appears in the console, because R silently stores the value.  
To see the stored value, you must explicitly print it:

```r
x
```

or:

```r
print(x)
```

This behaviour keeps the console uncluttered when running many calculations.

---

## 5. Running Calculations Without Assignment

If you run a calculation without saving it:

```r
5 + 3
```

R will print the result immediately:

```
[1] 8
```

But nothing is stored in the environment.

---

## 6. Difference Between Assigning and Running Directly

| Action | Example | Result |
|--------|---------|--------|
| Assigning | `x <- 5 + 3` | Saves the result in `x`, prints nothing |
| Printing | `x` | Shows the stored value |
| Running only | `5 + 3` | Prints the result, saves nothing |

Assignments are used when you need the result later.  
Direct calculations are useful for quick checks.

---

## 7. Why Objects Appear in the Global Environment

Every time you assign a value:

```r
my_age <- 24
```

R adds that object to the **Global Environment** (top-right pane).  
This allows you to:

- see which objects exist  
- inspect values  
- keep track of your workflow  
- avoid reusing variable names accidentally  

Reassigning the same name will overwrite the old value.

---

## 8. Example: Putting It All Together

```r
# This runs a calculation and shows the result
10 + 2

# This saves the result silently
result <- 10 + 2

# This prints the stored value
result
```

Output:

```
[1] 12
[1] 12
```

Environment:

```
result   12
```

---

## 9. Summary

- The **script editor** is where you write and save your code.  
- The **console** executes commands immediately but does not save them.  
- Use **Run** or **Ctrl/Cmd + Enter** to execute lines from the script.  
- Assignment (`<-`) stores values without printing.  
- Direct calculations print results but do not save them.  
- Objects appear in the Global Environment when assigned.

---

