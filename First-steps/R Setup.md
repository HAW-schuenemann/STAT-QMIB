# R & RStudio Installation Guide  
Author: Jan-Hendrik Schünemann  
Module: STAT / QMIB  
Version: v1.0  
Last Update: YYYY-MM-DD  
License: MIT  

---

## 1. Overview

This guide explains how to correctly install R and RStudio for use in the STAT and QMIB modules.

R is the actual programming language.  
RStudio is an editor (IDE) that allows you to write and run R code more easily.

RStudio cannot run without R installed first.  
Therefore, the installation order must be:

1. Install R  
2. Install RStudio  

---

## 2. Installing R (Windows and macOS)

### Step 1: Download R

Visit the official CRAN website:

https://cran.r-project.org/

Choose your operating system:

- Windows: “Download R for Windows”  
- macOS: “Download R for macOS”

Download the appropriate installer.

---

## 3. macOS Users: Determine Your CPU Type

macOS users must install the correct R version depending on their CPU.

To check which CPU your Mac uses:

1. Click the Apple logo () in the top-left corner  
2. Select “About This Mac”  
3. Look for the processor or chip information

Interpretation:

- “Chip: Apple M1 / M2 / M3 …” → Apple Silicon  
- “Processor: Intel …” → Intel-based Mac  

Choose the correct R installer:

- Apple Silicon: file name contains `arm64`  
- Intel Macs: file name contains `x86_64`

Installing the wrong version can lead to issues with certain packages.

---

## 4. Installing RStudio

After installing R, download RStudio Desktop (free version):

https://posit.co/download/rstudio-desktop/

Download the installer for your operating system and follow the steps.

When RStudio starts, it should automatically detect your R installation.  
If RStudio reports that R cannot be found, reinstall R and then restart RStudio.

---

## 5. macOS Users: Installing XQuartz

Some R packages require X11 graphics support.  
On macOS, this is provided by XQuartz.

XQuartz is required for:

- certain graphical functions  
- some statistical packages  
- older libraries depending on X11  

Without XQuartz, packages may fail to load or produce errors such as  
“X11 not available” or “unable to load shared object”.

### Installing XQuartz:

1. Download from: https://www.xquartz.org/  
2. Open the .dmg file  
3. Run the installer  
4. Restart your Mac  

---


