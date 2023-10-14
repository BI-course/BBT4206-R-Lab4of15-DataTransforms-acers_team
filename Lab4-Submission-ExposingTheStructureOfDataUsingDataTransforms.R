# *****************************************************************************
# Lab 4: Exposing the Structure of Data using Data Transforms ----
#
# Course Code: BBT4206
# Course Name: Business Intelligence II
# Semester Duration: 21st August 2023 to 28th November 2023
#
# Lecturer: Allan Omondi
# Contact: aomondi [at] strathmore.edu
#
# Note: The lecture contains both theory and practice. This file forms part of
#       the practice. It has required lab work submissions that are graded for
#       coursework marks.
#
# License: GNU GPL-3.0-or-later
# See LICENSE file for licensing information.
# *****************************************************************************

# **[OPTIONAL] Initialization: Install and use renv ----
# The R Environment ("renv") package helps you create reproducible environments
# for your R projects. This is helpful when working in teams because it makes
# your R projects more isolated, portable and reproducible.

# Further reading:
#   Summary: https://rstudio.github.io/renv/
#   More detailed article: https://rstudio.github.io/renv/articles/renv.html

# "renv" It can be installed as follows:
# if (!is.element("renv", installed.packages()[, 1])) {
# install.packages("renv", dependencies = TRUE,
# repos = "https://cloud.r-project.org") # nolint
# }
# require("renv") # nolint

# Once installed, you can then use renv::init() to initialize renv in a new
# project.

# The prompt received after executing renv::init() is as shown below:
# This project already has a lockfile. What would you like to do?

# 1: Restore the project from the lockfile.
# 2: Discard the lockfile and re-initialize the project.
# 3: Activate the project without snapshotting or installing any packages.
# 4: Abort project initialization.

# Select option 1 to restore the project from the lockfile
# renv::init() # nolint

# This will set up a project library, containing all the packages you are
# currently using. The packages (and all the metadata needed to reinstall
# them) are recorded into a lockfile, renv.lock, and a .Rprofile ensures that
# the library is used every time you open the project.

# Consider a library as the location where packages are stored.
# Execute the following command to list all the libraries available in your
# computer:
.libPaths()

# One of the libraries should be a folder inside the project if you are using
# renv

# Then execute the following command to see which packages are available in
# each library:
lapply(.libPaths(), list.files)

# This can also be configured using the RStudio GUI when you click the project
# file, e.g., "BBT4206-R.Rproj" in the case of this project. Then
# navigate to the "Environments" tab and select "Use renv with this project".

# As you continue to work on your project, you can install and upgrade
# packages, using either:
# install.packages() and update.packages or
# renv::install() and renv::update()

# You can also clean up a project by removing unused packages using the
# following command: renv::clean()

# After you have confirmed that your code works as expected, use
# renv::snapshot(), AT THE END, to record the packages and their
# sources in the lockfile.

# Later, if you need to share your code with someone else or run your code on
# a new machine, your collaborator (or you) can call renv::restore() to
# reinstall the specific package versions recorded in the lockfile.

# [OPTIONAL]
# Execute the following code to reinstall the specific package versions
# recorded in the lockfile (restart R after executing the command):
# renv::restore() # nolint

# [OPTIONAL]
# If you get several errors setting up renv and you prefer not to use it, then
# you can deactivate it using the following command (restart R after executing
# the command):
# renv::deactivate() # nolint

# If renv::restore() did not install the "languageserver" package (required to
# use R for VS Code), then it can be installed manually as follows (restart R
# after executing the command):

if (require("languageserver")) {
  require("languageserver")
} else {
  install.packages("languageserver", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

# Introduction ----
# Data transforms can improve the accuracy of your final model when applied as
# part of the pre-processing stage. It is standard practice to apply multiple
# transforms with a suite of different machine learning algorithms. Data
# transforms can be grouped into the following 3 categories:
#   (i)	Basic data transforms:
#              a. Scaling: Divides each value by the standard deviation
#              b. Centering: Subtracts the mean from each value
#              c. Standardization: Ensures that each numeric attribute has a
#                   mean value of 0 and a standard deviation of 1. This is done
#                   by combining the scale data transform and the centre data
#                   transform.
#              d. Normalization: Ensures the numerical data are between [0, 1]
#                   (inclusive).
#   (ii)	Power transforms:
#              a. Box-Cox: reduces the skewness by shifting the distribution of
#                   an attribute and making the attribute have a more
#                   Gaussian-like distribution.
#              b. Yeo-Johnson: like Box-Cox, Yeo-Johnson reduces the skewness
#                   by shifting the distribution of an attribute and making the
#                   attribute have a more Gaussian-like distribution.
#                   The difference is that Yeo-Johnson can handle zero and
#                   negative values.
#   (iii)	Linear algebra transforms: Principal Component Analysis (PCA) and
#         Independent Component Analysis (ICA)

# The first step is to design a model of the transform using the training data.
# This results in a model of the transform that can be applied to multiple
# datasets. The preparation of the model of the transform is done using the
# preProcess() function. The model of the transform can then be applied to a
# dataset in either of the following two ways:
#   (i)	  Standalone: The model of the transform is passed to the predict()
#         function
#   (ii)	Training: The model of the transform is passed to the train()
#         function via the preProcess argument. This is done during the model
#         evaluation stage.
# Note that the preProcess() function ignores non-numeric attributes.

# STEP 1. Install and Load the Required Packages ----
## mlbench ----
if (require("mlbench")) {
  require("mlbench")
} else {
  install.packages("mlbench", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## readr ----
if (require("readr")) {
  require("readr")
} else {
  install.packages("readr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## caret ----
if (require("caret")) {
  require("caret")
} else {
  install.packages("caret", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## e1071 ----
if (require("e1071")) {
  require("e1071")
} else {
  install.packages("e1071", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## factoextra ----
if (require("factoextra")) {
  require("factoextra")
} else {
  install.packages("factoextra", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## FactoMineR ----
if (require("FactoMineR")) {
  require("FactoMineR")
} else {
  install.packages("FactoMineR", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

## STEP 2. Load the Datasets ----
library(readr)
StudentPerformanceDataset <- read_csv("data/StudentPerformanceDataset.csv")

View(StudentPerformanceDataset)

# Scale Data Transform ----

## STEP 3. Apply a Scale Data Transform ----
summary(StudentPerformanceDataset)
# The code below converts column number 4 into unlisted and numeric data first
# so that a histogram can be plotted. Further reading:
StudentPerformanceDataset_yield <- as.numeric(unlist(StudentPerformanceDataset[, 4]))
hist(StudentPerformanceDataset_yield, main = names(StudentPerformanceDataset)[4])

model_of_the_transform <- preProcess(StudentPerformanceDataset, method = c("scale"))
print(model_of_the_transform)
student_dataset_scale_transform <- predict(model_of_the_transform, StudentPerformanceDataset)

# AFTER
summary(student_dataset_scale_transform)
student_datasetset_yield <- as.numeric(unlist(student_dataset_scale_transform[, 4]))
hist(student_datasetset_yield, main = names(student_dataset_scale_transform)[4])

# Center Data Transform ----

## STEP 4. Apply a Centre Data Transform ----
### The Centre Basic Transform on the StudentDataset ----
summary(StudentPerformanceDataset)
model_of_the_transform <- preProcess(StudentPerformanceDataset, method = c("center"))
print(model_of_the_transform)
student_dataset_center_transform <- predict(model_of_the_transform, StudentPerformanceDataset)
summary(student_dataset_center_transform)

### The Standardize Basic Transform on the Crop Dataset ----
# BEFORE
summary(StudentPerformanceDataset)
sapply(StudentPerformanceDataset[, 4], sd)
model_of_the_transform <- preProcess(StudentPerformanceDataset,
                                     method = c("scale", "center"))
print(model_of_the_transform)
student_dataset_standardize_transform <- predict(model_of_the_transform, StudentPerformanceDataset) # nolint

# AFTER
summary(student_dataset_standardize_transform)
sapply(student_dataset_standardize_transform[, 4], sd)

# Standardize Data Transform ----
## STEP 5. Apply a Standardize Data Transform ----
### The Standardize Basic Transform on the StudentDataset ----
# BEFORE
summary(StudentPerformanceDataset)
sapply(StudentPerformanceDataset[, 4], sd)
model_of_the_transform <- preProcess(StudentPerformanceDataset,
                                     method = c("scale", "center"))
print(model_of_the_transform)
student_dataset_standardize_transform <- predict(model_of_the_transform, StudentPerformanceDataset) # nolint

# AFTER
summary(student_dataset_standardize_transform)
sapply(student_dataset_standardize_transform[, 4], sd)

# Normalize Data Transform ----

## STEP 6. Apply a Normalize Data Transform ----
### The Normalize Transform on the StudentDataset ----
summary(StudentPerformanceDataset)
model_of_the_transform <- preProcess(StudentPerformanceDataset, method = c("range"))
print(model_of_the_transform)
student_dataset_normalize_transform <- predict(model_of_the_transform, StudentPerformanceDataset)
summary(student_dataset_normalize_transform)

# Box-Cox Power Transform ----

## STEP 7. Apply a Box-Cox Power Transform ----
### Box-Cox Power Transform on the StudentDataset ----
# BEFORE
summary(student_dataset_standardize_transform)

# Calculate the skewness before the Box-Cox transform
sapply(student_dataset_standardize_transform[, 4],  skewness, type = 2)
sapply(student_dataset_standardize_transform[, 4], sd)

model_of_the_transform <- preProcess(student_dataset_standardize_transform,
                                     method = c("BoxCox"))
print(model_of_the_transform)
student_dataset_box_cox_transform <- predict(model_of_the_transform,
                                             student_dataset_standardize_transform)

# AFTER
summary(student_dataset_box_cox_transform)

sapply(student_dataset_box_cox_transform[, 4],  skewness, type = 2)
sapply(student_dataset_box_cox_transform[, 4], sd)

# Calculate the skewness after the Box-Cox transform
sapply(student_dataset_box_cox_transform[, 4],  skewness, type = 2)
sapply(student_dataset_box_cox_transform[, 4], sd)

# Yeo-Johnson Power Transform ----

## STEP 8. Apply a Yeo-Johnson Power Transform ----
### Yeo-Johnson Power Transform on the StudentDataset ----
# BEFORE
summary(student_dataset_standardize_transform)

# Calculate the skewness before the Yeo-Johnson transform
sapply(student_dataset_standardize_transform[, 4],  skewness, type = 2)
sapply(student_dataset_standardize_transform[, 4], sd)

model_of_the_transform <- preProcess(student_dataset_standardize_transform,
                                     method = c("YeoJohnson"))
print(model_of_the_transform)
student_dataset_yeo_johnson_transform <- predict(model_of_the_transform, # nolint
                                                 student_dataset_standardize_transform)

# AFTER
summary(student_dataset_yeo_johnson_transform)

# Calculate the skewness after the Yeo-Johnson transform
sapply(student_dataset_yeo_johnson_transform[, 4],  skewness, type = 2)
sapply(student_dataset_yeo_johnson_transform[, 4], sd)

# Principal Component Analysis (PCA) Linear Algebra Transform ----

## STEP 9.b. PCA Linear Algebra Transform for Feature Extraction ----
## STEP 9.a. PCA Linear Algebra Transform for Dimensionality Reduction ----
summary(StudentPerformanceDataset)

model_of_the_transform <- preProcess(StudentPerformanceDataset,
                                     method = c("scale", "center", "pca"))
print(model_of_the_transform)
StudentPerformanceDataset_pca_dr <- predict(model_of_the_transform, StudentPerformanceDataset)

summary(StudentPerformanceDataset_pca_dr)
dim(StudentPerformanceDataset_pca_dr)
