
if (require("languageserver")) {
  require("languageserver")
} else {
  install.packages("languageserver", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}

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
StudentPerformanceDataset_ <- as.numeric(unlist(StudentPerformanceDataset[, 4]))
hist(StudentPerformanceDataset_, main = names(StudentPerformanceDataset)[4])

model_of_the_transform <- preProcess(StudentPerformanceDataset, method = c("scale"))
print(model_of_the_transform)
student_dataset_scale_transform <- predict(model_of_the_transform, StudentPerformanceDataset)

# AFTER
summary(student_dataset_scale_transform)
student_datasetset_ <- as.numeric(unlist(student_dataset_scale_transform[, 4]))
hist(student_datasetset_, main = names(student_dataset_scale_transform)[4])

# Center Data Transform ----

## STEP 4. Apply a Centre Data Transform ----
### The Centre Basic Transform on the StudentDataset ----
summary(StudentPerformanceDataset)
model_of_the_transform <- preProcess(StudentPerformanceDataset, method = c("center"))
print(model_of_the_transform)
student_dataset_center_transform <- predict(model_of_the_transform, StudentPerformanceDataset)
summary(student_dataset_center_transform)

### The Standardize Basic Transform on the Student Dataset ----
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

# Independent Component Analysis (ICA) Linear Algebra Transform ----
#STEP 10. ICA Linear Algebra Transform for Dimensionality Reduction ----

# Independent Component Analysis (ICA) transforms the data to return only the
# independent components. The n.comp argument is required to specify the
# desired number of independent components. This also results in a list of
# attributes that are uncorrelated.

if (!is.element("fastICA", installed.packages()[, 1])) {
  install.packages("fastICA", dependencies = TRUE)
}
require("fastICA")

### ICA for Dimensionality Reduction on the Student Dataset ----
# Notice that ICA is not applied to the “Student Data” dataset because it requires
# multiple numeric independent variables. The dataset has 3 categorical
# independent variables and only 1 numeric independent variable.

### ICA for Dimensionality Reduction on the Iris Dataset ----
summary(StudentPerformanceDataset)
model_of_the_transform <- preProcess(StudentPerformanceDataset,
                                     method = c("scale", "center", "ica"),
                                     n.comp = 3)
print(model_of_the_transform)
StudentPerformanceDataset_ica_dr <- predict(model_of_the_transform, StudentPerformanceDataset)

summary(StudentPerformanceDataset_ica_dr)

