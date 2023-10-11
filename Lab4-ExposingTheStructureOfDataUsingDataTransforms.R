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

### The Boston Housing Dataset ----
# Execute the following to load the “BostonHousing” dataset which is offered
# in the "mlbench" package:
data("BostonHousing")

### Crop Dataset ----
# Execute the following to load the downloaded Crop dataset:
crop_dataset <- read_csv("data/crop.data.csv",
  col_types = cols(
    density = col_factor(levels = c("1", "2")),
    block = col_factor(levels = c("1", "2", "3", "4")),
    fertilizer = col_factor(levels = c("1", "2", "3"))
  )
)

### Iris Dataset ----
# Execute the following to load the downloaded Iris dataset:
iris_dataset <- read.csv("data/iris.data", header = FALSE,
                         stringsAsFactors = TRUE)
# This time, we name the attributes of the Iris Dataset as follows:
names(iris_dataset) <- c("sepal length in cm", "sepal width in cm",
                         "petal length in cm", "petal width in cm", "class")

### The Pima Indians Diabetes Dataset ----
# Execute the following to load the "Pima Indians Diabetes" dataset from the
# mlbench package:
data("PimaIndiansDiabetes")

# Scale Data Transform ----

## STEP 3. Apply a Scale Data Transform ----
# The scale data transform is useful for scaling data that has a Gaussian
# distribution. The scale data transform works by calculating the standard
# deviation of an attribute and then divides each value by the standard
# deviation.

### Benefits of Scaling ----
#### 1. Facilitating Algorithm Convergence ----
# Many machine learning algorithms, such as gradient descent-based methods and
# support vector machines, work more efficiently and converge faster when the
# input features are on similar scales. Rescaling the data helps prevent some
# features from dominating the learning process.

#### 2. Improving Interpretability ----
# Scaling makes it easier to compare the importance of different features in a
# model. When features have different scales, it can be challenging to
# interpret their relative contributions.

#### 3.Enhancing Model Performance ----
# Some machine learning algorithms, like k-nearest neighbors and principal
# component analysis, are sensitive to the scale of the data. Scaling can lead
# to better model performance and more reliable results.

#### 4. Handling Outliers ----
# Standardizing data can help mitigate the impact of outliers. Outliers are
# data points that are significantly different from the majority of the data.
# If not properly handled, outliers can distort model predictions.

#### 5. Comparing Variables ----
# Scaling allows you to compare variables that have different units or
# measurement scales. For example, you can compare variables like age and
# income on the same scale after scaling.

# We use the "preProcess()" function in the caret package

### The Scale Basic Transform on the Boston Housing Dataset ----
# BEFORE
summary(BostonHousing)
hist(BostonHousing[, 1], main = names(BostonHousing)[1])
hist(BostonHousing[, 2], main = names(BostonHousing)[2])
hist(BostonHousing[, 3], main = names(BostonHousing)[3])
hist(BostonHousing[, 5], main = names(BostonHousing)[5])
hist(BostonHousing[, 6], main = names(BostonHousing)[6])
hist(BostonHousing[, 7], main = names(BostonHousing)[7])
hist(BostonHousing[, 8], main = names(BostonHousing)[8])
hist(BostonHousing[, 9], main = names(BostonHousing)[9])
hist(BostonHousing[, 10], main = names(BostonHousing)[10])
hist(BostonHousing[, 11], main = names(BostonHousing)[11])
hist(BostonHousing[, 12], main = names(BostonHousing)[12])
hist(BostonHousing[, 13], main = names(BostonHousing)[13])
hist(BostonHousing[, 14], main = names(BostonHousing)[14])

model_of_the_transform <- preProcess(BostonHousing, method = c("scale"))
print(model_of_the_transform)
boston_housing_scale_transform <- predict(model_of_the_transform,
                                          BostonHousing)
# AFTER
summary(boston_housing_scale_transform)
hist(boston_housing_scale_transform[, 1],
     main = names(boston_housing_scale_transform)[1])
hist(boston_housing_scale_transform[, 2],
     main = names(boston_housing_scale_transform)[2])
hist(boston_housing_scale_transform[, 3],
     main = names(boston_housing_scale_transform)[3])
hist(boston_housing_scale_transform[, 5],
     main = names(boston_housing_scale_transform)[5])
hist(boston_housing_scale_transform[, 6],
     main = names(boston_housing_scale_transform)[6])
hist(boston_housing_scale_transform[, 7],
     main = names(boston_housing_scale_transform)[7])
hist(boston_housing_scale_transform[, 8],
     main = names(boston_housing_scale_transform)[8])
hist(boston_housing_scale_transform[, 9],
     main = names(boston_housing_scale_transform)[9])
hist(boston_housing_scale_transform[, 10],
     main = names(boston_housing_scale_transform)[10])
hist(boston_housing_scale_transform[, 11],
     main = names(boston_housing_scale_transform)[11])
hist(boston_housing_scale_transform[, 12],
     main = names(boston_housing_scale_transform)[12])
hist(boston_housing_scale_transform[, 13],
     main = names(boston_housing_scale_transform)[13])
hist(boston_housing_scale_transform[, 14],
     main = names(boston_housing_scale_transform)[14])

### The Scale Basic Transform on the Crop Dataset ----
# BEFORE
summary(crop_dataset)
# The code below converts column number 4 into unlisted and numeric data first
# so that a histogram can be plotted. Further reading:
crop_dataset_yield <- as.numeric(unlist(crop_dataset[, 4]))
hist(crop_dataset_yield, main = names(crop_dataset)[4])

model_of_the_transform <- preProcess(crop_dataset, method = c("scale"))
print(model_of_the_transform)
crop_data_scale_transform <- predict(model_of_the_transform, crop_dataset)

# AFTER
summary(crop_data_scale_transform)
crop_dataset_yield <- as.numeric(unlist(crop_data_scale_transform[, 4]))
hist(crop_dataset_yield, main = names(crop_data_scale_transform)[4])

# Center Data Transform ----

## STEP 4. Apply a Centre Data Transform ----
# The centre data transform calculates the mean of an attribute and subtracts
# it from each value.

### Benefits of Centering ----
#### 1. Removes the Effect of the Mean ----
# Centering makes the data's mean equal to zero. By subtracting the mean from
# each data point, you effectively remove any systematic bias or shift in the
# data. This is particularly useful when you want to focus on variations or
# deviations from the mean.

#### 2. Interpretability ----
# Centering enhances the interpretability of data. When data is centered, the
# coefficients or parameters in statistical models become more interpretable.
# For example, in linear regression, the intercept (constant term) represents
# the predicted value when all predictor variables are at their means, making
# it easier to understand the effect of the predictors.

#### 3. Stabilizes Numerical Computations ----
# In some numerical algorithms, centering data can improve the numerical
# stability of computations. Centering often reduces large numerical values and
# can prevent issues like numerical instability or overflow in certain
# calculations.

#### 4. Facilitates Comparison ----
# When working with multiple variables or features with different units or
# measurement scales, centering helps standardize these variables for
# meaningful comparisons. It makes it easier to assess the relative impact or
# importance of different features in a model.

#### 5. Eases Visual Interpretation ----
# Centering can simplify the interpretation of data visualizations, such as
# scatter plots. By centering the data, you can focus on the shape of the
# distribution around the center (mean) rather than being influenced by the
# location of the data in the plot.

#### 6. Improves Model Convergence ----
# Some optimization algorithms used in statistical modeling and machine
# learning may converge more quickly and stably when data is centered.
# This is particularly relevant when dealing with iterative optimization
# procedures.

#### 7. Handling Interaction Terms ----
# When creating interaction terms in regression models, centering the variables
# involved in the interaction can help in reducing multicollinearity and
# improve the interpretation of interaction effects.

### The Centre Basic Transform on the Boston Housing Dataset ----
# BEFORE
summary(BostonHousing)
boxplot(BostonHousing[, 1], main = names(BostonHousing)[1])
boxplot(BostonHousing[, 2], main = names(BostonHousing)[2])
boxplot(BostonHousing[, 3], main = names(BostonHousing)[3])
boxplot(BostonHousing[, 5], main = names(BostonHousing)[5])
boxplot(BostonHousing[, 6], main = names(BostonHousing)[6])
boxplot(BostonHousing[, 7], main = names(BostonHousing)[7])
boxplot(BostonHousing[, 8], main = names(BostonHousing)[8])
boxplot(BostonHousing[, 9], main = names(BostonHousing)[9])
boxplot(BostonHousing[, 10], main = names(BostonHousing)[10])
boxplot(BostonHousing[, 11], main = names(BostonHousing)[11])
boxplot(BostonHousing[, 12], main = names(BostonHousing)[12])
boxplot(BostonHousing[, 13], main = names(BostonHousing)[13])
boxplot(BostonHousing[, 14], main = names(BostonHousing)[14])

model_of_the_transform <- preProcess(BostonHousing, method = c("center"))
print(model_of_the_transform)
boston_housing_center_transform <- predict(model_of_the_transform, # nolint
                                           BostonHousing)

# AFTER
summary(boston_housing_center_transform)
boxplot(boston_housing_center_transform[, 1],
        main = names(boston_housing_center_transform)[1])
boxplot(boston_housing_center_transform[, 2],
        main = names(boston_housing_center_transform)[2])
boxplot(boston_housing_center_transform[, 3],
        main = names(boston_housing_center_transform)[3])
boxplot(boston_housing_center_transform[, 5],
        main = names(boston_housing_center_transform)[5])
boxplot(boston_housing_center_transform[, 6],
        main = names(boston_housing_center_transform)[6])
boxplot(boston_housing_center_transform[, 7],
        main = names(boston_housing_center_transform)[7])
boxplot(boston_housing_center_transform[, 8],
        main = names(boston_housing_center_transform)[8])
boxplot(boston_housing_center_transform[, 9],
        main = names(boston_housing_center_transform)[9])
boxplot(boston_housing_center_transform[, 10],
        main = names(boston_housing_center_transform)[10])
boxplot(boston_housing_center_transform[, 11],
        main = names(boston_housing_center_transform)[11])
boxplot(boston_housing_center_transform[, 12],
        main = names(boston_housing_center_transform)[12])
boxplot(boston_housing_center_transform[, 13],
        main = names(boston_housing_center_transform)[13])
boxplot(boston_housing_center_transform[, 14],
        main = names(boston_housing_center_transform)[14])

### The Centre Basic Transform on the Crop Dataset ----
summary(crop_dataset)
model_of_the_transform <- preProcess(crop_dataset, method = c("center"))
print(model_of_the_transform)
crop_data_center_transform <- predict(model_of_the_transform, crop_dataset)
summary(crop_data_center_transform)

### The Centre Basic Transform on the Iris Dataset ----
summary(iris_dataset)
model_of_the_transform <- preProcess(iris_dataset, method = c("center"))
print(model_of_the_transform)
iris_dataset_center_transform <- predict(model_of_the_transform, iris_dataset)
summary(iris_dataset_center_transform)

### The Centre Basic Transform on the Pima Indians Diabetes Dataset ----
summary(PimaIndiansDiabetes)
model_of_the_transform <- preProcess(PimaIndiansDiabetes, method = c("center"))
print(model_of_the_transform)
pima_indians_diabetes_center_transform <- predict(model_of_the_transform, # nolint
                                                  PimaIndiansDiabetes)
summary(pima_indians_diabetes_center_transform)

# Standardize Data Transform ----
## STEP 5. Apply a Standardize Data Transform ----
# The standardize data transform ensures that each numeric attribute has a mean
# value of 0 and a standard deviation of 1. This is done by combining the scale
# data transform and the centre data transform.

### Benefits of Standardizing ----
#### 1. Enhances Model Performance ----
# Many machine learning algorithms, such as support vector machines, k-nearest
# neighbors, and principal component analysis, perform better when the input
# features are on the same scale. Standardizing data can lead to improved model
# performance and more reliable results.

#### 2. Promotes Fair Comparison ----
# Standardizing data allows for a fair and meaningful comparison of the
# importance of different features. When features have different units or
# measurement scales, it can be challenging to compare their contributions to a
# model. Standardizing puts all features on the same scale, making these
# comparisons more straightforward.

#### 3. Facilitates Gradient Descent ----
# In optimization algorithms like gradient descent, the scale of the features
# can affect convergence. Features with large scales can dominate the learning
# process and slow down convergence. Standardization can help mitigate this
# problem by ensuring that all features have similar scales.

#### 4. Simplifies Interpretation ----
# Standardized coefficients in linear models are directly interpretable.
# In linear regression, the coefficients represent the change in the dependent
# variable associated with a one-standard-deviation change in the predictor
# variable. This makes the interpretation of the model more intuitive.

#### 5. Robust to Outliers ----
# Standardization is less affected by outliers than some other scaling methods
# like min-max scaling. Outliers have a limited impact on the mean and standard
# deviation, so standardization can be a robust choice when dealing with data
# containing outliers.

#### 6. Improves Clustering and Dimensionality Reduction ----
# In clustering and dimensionality reduction techniques like k-means clustering
# and principal component analysis (PCA), the scale of the data can influence
# the results. Standardizing data helps these techniques produce more
# meaningful and stable results.

#### 7. Easier Feature Engineering ----
# When creating new features or interaction terms in models, standardizing the
# variables involved can simplify the process and improve model
# interpretability.

# Standardizing data does not change the fundamental relationships in the data;
# it merely transforms the scale. The choice to
# standardize depends on the specific characteristics of the data and the
# requirements of the analysis or model. In some cases, standardization is
# necessary for the model to perform effectively, while in others, it may not be
# required. The decision should be made based on the context and the nature of
# the data.

### The Standardize Basic Transform on the Boston Housing Dataset ----
# BEFORE
summary(BostonHousing)
sapply(BostonHousing[, -4], sd)

model_of_the_transform <- preProcess(BostonHousing,
                                     method = c("scale", "center"))
print(model_of_the_transform)
boston_housing_standardize_transform <- predict(model_of_the_transform, # nolint
                                                BostonHousing)

# AFTER
summary(boston_housing_standardize_transform)
sapply(boston_housing_standardize_transform[, -4], sd)

### The Standardize Basic Transform on the Crop Dataset ----
# BEFORE
summary(crop_dataset)
sapply(crop_dataset[, 4], sd)
model_of_the_transform <- preProcess(crop_dataset,
                                     method = c("scale", "center"))
print(model_of_the_transform)
crop_data_standardize_transform <- predict(model_of_the_transform, crop_dataset) # nolint

# AFTER
summary(crop_data_standardize_transform)
sapply(crop_data_standardize_transform[, 4], sd)

### The Standardize Basic Transform on the Iris Dataset ----
# BEFORE
summary(iris_dataset)
sapply(iris_dataset[, 1:4], sd)

model_of_the_transform <- preProcess(iris_dataset,
                                     method = c("scale", "center"))
print(model_of_the_transform)
iris_dataset_standardize_transform <- predict(model_of_the_transform, # nolint
                                              iris_dataset)

# AFTER
summary(iris_dataset_standardize_transform)
sapply(iris_dataset_standardize_transform[, 1:4], sd)

### The Standardize Basic Transform on the Pima Indians Diabetes Dataset ----
# BEFORE
summary(PimaIndiansDiabetes)
sapply(PimaIndiansDiabetes[, 1:8], sd)

model_of_the_transform <- preProcess(PimaIndiansDiabetes,
                                     method = c("scale", "center"))
print(model_of_the_transform)
pima_indians_diabetes_standardize_transform <- predict(model_of_the_transform, # nolint
                                                       PimaIndiansDiabetes)

# AFTER
summary(pima_indians_diabetes_standardize_transform)
sapply(pima_indians_diabetes_standardize_transform[, 1:8], sd)

# Normalize Data Transform ----

## STEP 6. Apply a Normalize Data Transform ----
# Normalizing a dataset implies ensuring the numerical data are
# between [0, 1] (inclusive).

### Benefits of the Normalize Data Transform ----
#### 1. Comparability ----
# Normalization allows for the comparison of variables with different units
# and measurement scales. By transforming all features to the same scale, you
# can evaluate their relative contributions more easily.

#### 2. Improved Model Performance ----
# Some machine learning algorithms, like neural networks, can benefit from
# having input features within a certain range. Normalizing the data ensures
# that the input features are within a consistent range, which can lead to
# improved model performance.

#### 3. Sensitivity to Magnitude ----
# Certain algorithms are sensitive to the magnitude
# of data, and this can lead to issues during training. Normalization reduces
# the sensitivity to the scale of the input features, making the optimization
# process more stable.

#### 4. Facilitates Convergence ----
# In optimization algorithms such as gradient descent,
# having all input features within a similar scale can help algorithms converge
# faster and reach a global minimum more efficiently.

#### 5. Dimension Reduction Techniques ----
# Normalization is often used in dimensionality
# reduction techniques like PCA (Principal Component Analysis). Scaling the data
# ensures that each dimension contributes equally to the computation of
# principal components.

#### 6. Handling Distance-Based Algorithms ----
# Algorithms that rely on distance metrics, such as k-means clustering, are
# sensitive to the scale of features. Normalizing the data helps prevent
# features with larger scales from dominating the distance calculations.

#### 7. Visualization ----
# Normalized data can lead to more meaningful and interpretable visualizations,
# especially when comparing different variables on the same plot.

#### 8. Facilitates Feature Engineering ----
# When creating interaction terms or composite features, normalizing the
# variables involved can simplify the process and enhance the interpretability
# of the model.

#### 9. Prevents Overfitting ----
# In some models, features with larger scales may be more prone to overfitting.
# Normalizing data can help mitigate this issue.

#### 10. Handling Multicollinearity ----
# Normalizing can reduce multicollinearity, a situation where two or more
# features are highly correlated. Reducing multicollinearity can make models
# more interpretable.

# Even though normalization is beneficial in many cases, it may not always be
# necessary, especially when the data is already on a compatible scale for the
# intended analysis.

### The Normalize Transform on the Boston Housing Dataset ----
summary(BostonHousing)
model_of_the_transform <- preProcess(BostonHousing, method = c("range"))
print(model_of_the_transform)
boston_housing_normalize_transform <- predict(model_of_the_transform, # nolint
                                              BostonHousing)
summary(boston_housing_normalize_transform)

### The Normalize Transform on the Crop Dataset ----
summary(crop_dataset)
model_of_the_transform <- preProcess(crop_dataset, method = c("range"))
print(model_of_the_transform)
crop_data_normalize_transform <- predict(model_of_the_transform, crop_dataset)
summary(crop_data_normalize_transform)

### The Normalize Transform on the Iris Dataset ----
summary(iris_dataset)
model_of_the_transform <- preProcess(iris_dataset, method = c("range"))
print(model_of_the_transform)
iris_dataset_normalize_transform <- predict(model_of_the_transform, # nolint
                                            iris_dataset)
summary(iris_dataset_normalize_transform)

### The Normalize Transform on the Pima Indians Diabetes Dataset ----
summary(PimaIndiansDiabetes)
model_of_the_transform <- preProcess(PimaIndiansDiabetes, method = c("range"))
print(model_of_the_transform)
pima_indians_diabetes_normalize_transform <- predict(model_of_the_transform, # nolint
                                                     PimaIndiansDiabetes)
summary(pima_indians_diabetes_normalize_transform)


# Box-Cox Power Transform ----

## STEP 7. Apply a Box-Cox Power Transform ----
# The skewness informs you of the asymmetry of the distribution of results.
# Similar to kurtosis, there are several ways of computing the skewness. Using
# “type = 2” (discussed in a previous Lab) can be interpreted as:
#   1.	Skewness between -0.4 and 0.4 (inclusive) implies that there is no
#         skew in the distribution of results; the distribution of results is
#         symmetrical; it is a normal distribution.
#   2.	Skewness above 0.4 implies a positive skew; a right-skewed distribution.
#   3.	Skewness below -0.4 implies a negative skew; a left-skewed distribution.

# Skewness occurs when an attribute has a Gaussian-like distribution but it is
# shifted. The Box-Cox transform reduces the skewness by shifting the
# distribution of an attribute and making the attribute have a more
# Gaussian-like distribution.

### Box-Cox Power Transform on the Boston Housing Dataset ----
# BEFORE
summary(BostonHousing)

#Calculate the skewness before the Box-Cox transform
sapply(BostonHousing[, -4],  skewness, type = 2)

#Plot a histogram to view the skewness before the Box-Cox transform
hist(BostonHousing[, 1], main = names(BostonHousing)[1])
hist(BostonHousing[, 2], main = names(BostonHousing)[2])
hist(BostonHousing[, 3], main = names(BostonHousing)[3])
hist(BostonHousing[, 5], main = names(BostonHousing)[5])
hist(BostonHousing[, 6], main = names(BostonHousing)[6])
hist(BostonHousing[, 7], main = names(BostonHousing)[7])
hist(BostonHousing[, 8], main = names(BostonHousing)[8])
hist(BostonHousing[, 9], main = names(BostonHousing)[9])
hist(BostonHousing[, 10], main = names(BostonHousing)[10])
hist(BostonHousing[, 11], main = names(BostonHousing)[11])
hist(BostonHousing[, 12], main = names(BostonHousing)[12])
hist(BostonHousing[, 13], main = names(BostonHousing)[13])
hist(BostonHousing[, 14], main = names(BostonHousing)[14])

model_of_the_transform <- preProcess(BostonHousing, method = c("BoxCox"))
print(model_of_the_transform)
boston_housing_box_cox_transform <- predict(model_of_the_transform, # nolint
                                            BostonHousing)

# AFTER
summary(boston_housing_box_cox_transform)

# Calculate the skewness after the Box-Cox transform
sapply(boston_housing_box_cox_transform[, -4],  skewness, type = 2)

#Plot a histogram to view the skewness after the Box-Cox transform
hist(boston_housing_box_cox_transform[, 1],
     main = names(boston_housing_box_cox_transform)[1])
hist(boston_housing_box_cox_transform[, 2],
     main = names(boston_housing_box_cox_transform)[2])
hist(boston_housing_box_cox_transform[, 3],
     main = names(boston_housing_box_cox_transform)[3])
hist(boston_housing_box_cox_transform[, 5],
     main = names(boston_housing_box_cox_transform)[5])
hist(boston_housing_box_cox_transform[, 6],
     main = names(boston_housing_box_cox_transform)[6])
hist(boston_housing_box_cox_transform[, 7],
     main = names(boston_housing_box_cox_transform)[7])
hist(boston_housing_box_cox_transform[, 8],
     main = names(boston_housing_box_cox_transform)[8])
hist(boston_housing_box_cox_transform[, 9],
     main = names(boston_housing_box_cox_transform)[9])
hist(boston_housing_box_cox_transform[, 10],
     main = names(boston_housing_box_cox_transform)[10])
hist(boston_housing_box_cox_transform[, 11],
     main = names(boston_housing_box_cox_transform)[11])
hist(boston_housing_box_cox_transform[, 12],
     main = names(boston_housing_box_cox_transform)[12])
hist(boston_housing_box_cox_transform[, 13],
     main = names(boston_housing_box_cox_transform)[13])
hist(boston_housing_box_cox_transform[, 14],
     main = names(boston_housing_box_cox_transform)[14])

### Box-Cox Power Transform on the Crop Dataset ----
# BEFORE
summary(crop_data_standardize_transform)

# Calculate the skewness before the Box-Cox transform
sapply(crop_data_standardize_transform[, 4],  skewness, type = 2)
sapply(crop_data_standardize_transform[, 4], sd)

model_of_the_transform <- preProcess(crop_data_standardize_transform,
                                     method = c("BoxCox"))
print(model_of_the_transform)
crop_data_box_cox_transform <- predict(model_of_the_transform,
                                       crop_data_standardize_transform)

# AFTER
summary(crop_data_box_cox_transform)

sapply(crop_data_box_cox_transform[, 4],  skewness, type = 2)
sapply(crop_data_box_cox_transform[, 4], sd)

# Calculate the skewness after the Box-Cox transform
sapply(crop_data_box_cox_transform[, 4],  skewness, type = 2)
sapply(crop_data_box_cox_transform[, 4], sd)

# Notice that none of the attributes in the crop dataset qualify to be
# transformed using the Box Cox data transform. Yield has negative values
# after standardization.

### Box-Cox Power Transform on the Iris Dataset ----
# BEFORE
summary(iris_dataset)

# Calculate the skewness before the Box-Cox transform
sapply(iris_dataset[, 1:4],  skewness, type = 2)

# Plot a histogram to view the skewness before the Box-Cox transform
par(mfrow = c(1, 4))
for (i in 1:4) {
  hist(iris_dataset[, i], main = names(iris_dataset)[i])
}

model_of_the_transform <- preProcess(iris_dataset, method = c("BoxCox"))
print(model_of_the_transform)

iris_dataset_box_cox_transform <- predict(model_of_the_transform,
                                          iris_dataset)
# AFTER
summary(iris_dataset_box_cox_transform)

# Calculate the skewness after the Box-Cox transform
sapply(iris_dataset_box_cox_transform[, 1:4],  skewness, type = 2)

# Plot a histogram to view the skewness after the Box-Cox transform
par(mfrow = c(1, 4))
for (i in 1:4) {
  hist(iris_dataset_box_cox_transform[, i],
       main = names(iris_dataset_box_cox_transform)[i])
}

### Box-Cox Power Transform on the Pima Indians Diabetes Dataset ----
# BEFORE
summary(PimaIndiansDiabetes)

# Calculate the skewness before the Box-Cox transform
sapply(PimaIndiansDiabetes[, 1:8],  skewness, type = 2)

# Plot a histogram to view the skewness before the Box-Cox transform
par(mfrow = c(1, 8))
for (i in 1:8) {
  hist(PimaIndiansDiabetes[, i], main = names(PimaIndiansDiabetes)[i])
}

model_of_the_transform <- preProcess(PimaIndiansDiabetes, method = c("BoxCox"))
print(model_of_the_transform)
pima_indians_diabetes_box_cox_transform <- predict(model_of_the_transform, # nolint
                                                   PimaIndiansDiabetes)

# AFTER
summary(pima_indians_diabetes_box_cox_transform)

# Calculate the skewness after the Box-Cox transform
sapply(pima_indians_diabetes_box_cox_transform[, 1:8],  skewness, type = 2)

# Plot a histogram to view the skewness after the Box-Cox transform
par(mfrow = c(1, 8))
for (i in 1:8) {
  hist(pima_indians_diabetes_box_cox_transform[, i],
       main = names(pima_indians_diabetes_box_cox_transform)[i])
}


# Yeo-Johnson Power Transform ----

## STEP 8. Apply a Yeo-Johnson Power Transform ----
# Similar to the Box-Cox transform, the Yeo-Johnson transform reduces the
# skewness by shifting the distribution of an attribute and making the
# attribute have a more Gaussian-like distribution. The difference is that the
# Yeo-Johnson transform can handle zero and negative values, unlike the Box-Cox
# transform.

### Yeo-Johnson Power Transform on the Boston Housing Dataset ----
# BEFORE
summary(BostonHousing)

# Calculate the skewness before the Yeo-Johnson transform
sapply(BostonHousing[, -4],  skewness, type = 2)

# Plot a histogram to view the skewness before the Box-Cox transform
hist(BostonHousing[, 1], main = names(BostonHousing)[1])
hist(BostonHousing[, 2], main = names(BostonHousing)[2])
hist(BostonHousing[, 3], main = names(BostonHousing)[3])
hist(BostonHousing[, 5], main = names(BostonHousing)[5])
hist(BostonHousing[, 6], main = names(BostonHousing)[6])
hist(BostonHousing[, 7], main = names(BostonHousing)[7])
hist(BostonHousing[, 8], main = names(BostonHousing)[8])
hist(BostonHousing[, 9], main = names(BostonHousing)[9])
hist(BostonHousing[, 10], main = names(BostonHousing)[10])
hist(BostonHousing[, 11], main = names(BostonHousing)[11])
hist(BostonHousing[, 12], main = names(BostonHousing)[12])
hist(BostonHousing[, 13], main = names(BostonHousing)[13])
hist(BostonHousing[, 14], main = names(BostonHousing)[14])

model_of_the_transform <- preProcess(BostonHousing, method = c("YeoJohnson"))
print(model_of_the_transform)
boston_housing_yeo_johnson_transform <- predict(model_of_the_transform, # nolint
                                                BostonHousing)

# AFTER
summary(boston_housing_yeo_johnson_transform)

# Calculate the skewness after the Yeo-Johnson transform
sapply(boston_housing_yeo_johnson_transform[, -4],  skewness, type = 2)

# Plot a histogram to view the skewness after the Box-Cox transform
hist(boston_housing_yeo_johnson_transform[, 1],
     main = names(boston_housing_yeo_johnson_transform)[1])
hist(boston_housing_yeo_johnson_transform[, 2],
     main = names(boston_housing_yeo_johnson_transform)[2])
hist(boston_housing_yeo_johnson_transform[, 3],
     main = names(boston_housing_yeo_johnson_transform)[3])
hist(boston_housing_yeo_johnson_transform[, 5],
     main = names(boston_housing_yeo_johnson_transform)[5])
hist(boston_housing_yeo_johnson_transform[, 6],
     main = names(boston_housing_yeo_johnson_transform)[6])
hist(boston_housing_yeo_johnson_transform[, 7],
     main = names(boston_housing_yeo_johnson_transform)[7])
hist(boston_housing_yeo_johnson_transform[, 8],
     main = names(boston_housing_yeo_johnson_transform)[8])
hist(boston_housing_yeo_johnson_transform[, 9],
     main = names(boston_housing_yeo_johnson_transform)[9])
hist(boston_housing_yeo_johnson_transform[, 10],
     main = names(boston_housing_yeo_johnson_transform)[10])
hist(boston_housing_yeo_johnson_transform[, 11],
     main = names(boston_housing_yeo_johnson_transform)[11])
hist(boston_housing_yeo_johnson_transform[, 12],
     main = names(boston_housing_yeo_johnson_transform)[12])
hist(boston_housing_yeo_johnson_transform[, 13],
     main = names(boston_housing_yeo_johnson_transform)[13])
hist(boston_housing_yeo_johnson_transform[, 14],
     main = names(boston_housing_yeo_johnson_transform)[14])

### Yeo-Johnson Power Transform on the Crop Dataset ----
# BEFORE
summary(crop_data_standardize_transform)

# Calculate the skewness before the Yeo-Johnson transform
sapply(crop_data_standardize_transform[, 4],  skewness, type = 2)
sapply(crop_data_standardize_transform[, 4], sd)

model_of_the_transform <- preProcess(crop_data_standardize_transform,
                                     method = c("YeoJohnson"))
print(model_of_the_transform)
crop_data_yeo_johnson_transform <- predict(model_of_the_transform, # nolint
                                           crop_data_standardize_transform)

# AFTER
summary(crop_data_yeo_johnson_transform)

# Calculate the skewness after the Yeo-Johnson transform
sapply(crop_data_yeo_johnson_transform[, 4],  skewness, type = 2)
sapply(crop_data_yeo_johnson_transform[, 4], sd)

# Notice that unlike the Box-Cox data transform, the Yeo-Johnson data
# transform considers 1 of the attributes (yield) as qualified to be
# transformed using the Yeo-Johnson transform. This is despite Yield
# having negative values after standardization.

### Yeo-Johnson Power Transform on the Iris Dataset ----
# BEFORE
summary(iris_dataset)

# Calculate the skewness before the Yeo-Johnson transform
sapply(iris_dataset[, 1:4],  skewness, type = 2)

# Plot a histogram to view the skewness before the Yeo-Johnson transform
par(mfrow = c(1, 4))
for (i in 1:4) {
  hist(iris_dataset[, i], main = names(iris_dataset)[i])
}

model_of_the_transform <- preProcess(iris_dataset, method = c("YeoJohnson"))
print(model_of_the_transform)
iris_dataset_yeo_johnson_transform <- predict(model_of_the_transform, iris_dataset) # nolint

# AFTER
summary(iris_dataset_yeo_johnson_transform)
# Calculate the skewness after the Yeo-Johnson transform
sapply(iris_dataset_yeo_johnson_transform[, 1:4],  skewness, type = 2)

# Plot a histogram to view the skewness after the Yeo-Johnson transform
par(mfrow = c(1, 4))
for (i in 1:4) {
  hist(iris_dataset_yeo_johnson_transform[, i],
       main = names(iris_dataset_yeo_johnson_transform)[i])
}

### Yeo-Johnson Power Transform on the Pima Indians Diabetes Dataset ----
# BEFORE
summary(PimaIndiansDiabetes)

# Calculate the skewness before the Yeo-Johnson transform
sapply(PimaIndiansDiabetes[, 1:8],  skewness, type = 2)

# Plot a histogram to view the skewness before the Yeo-Johnson transform
par(mfrow = c(1, 8))
for (i in 1:8) {
  hist(PimaIndiansDiabetes[, i], main = names(PimaIndiansDiabetes)[i])
}

model_of_the_transform <- preProcess(PimaIndiansDiabetes,
                                     method = c("YeoJohnson"))
print(model_of_the_transform)
pima_indians_diabetes_yeo_johnson_transform <- predict(model_of_the_transform, # nolint
                                                       PimaIndiansDiabetes)

# AFTER
summary(pima_indians_diabetes_yeo_johnson_transform)

# Calculate the skewness after the Yeo-Johnson transform
sapply(pima_indians_diabetes_yeo_johnson_transform[, 1:8],  skewness, type = 2)

# Plot a histogram to view the skewness after the Yeo-Johnson transform
par(mfrow = c(1, 8))
for (i in 1:8) {
  hist(pima_indians_diabetes_yeo_johnson_transform[, i],
       main = names(pima_indians_diabetes_yeo_johnson_transform)[i])
}

# Principal Component Analysis (PCA) Linear Algebra Transform ----

## Dimensionality Reduction versus Feature Selection ----
# PCA and ICA are primarily dimensionality reduction techniques used to
# transform high-dimensional data into a lower-dimensional space while
# retaining as much variance as possible. However, they can indirectly assist
# in feature selection by identifying the most important features or components.

# Feature selection and dimensionality reduction are both techniques used to
# reduce the number of features (variables) in a dataset, but they serve
# different purposes and operate in slightly different ways:

# 1. **Feature Selection**:
#    - **Purpose**: The primary goal of feature selection is to choose a subset
#                   of the most relevant and informative features from the
#                   original feature set while discarding irrelevant or
#                   redundant features.
#    - **Mechanism**: Feature selection methods evaluate each feature
#                   individually or in combination with others based on some
#                   criteria (e.g., correlation, mutual information,
#                   statistical tests) and select the most important features.
#    - **Result**: The result is a reduced feature set containing a subset of
#                   the original features. These selected features are typically
#                   unchanged or minimally transformed.
#    - **Interpretability**: Feature selection retains the original features,
#                   making it easier to interpret the relationship between
#                   features and the target variable.

# 2. **Dimensionality Reduction**:
#    - **Purpose**: The primary goal of dimensionality reduction is to
#                   transform the original feature space into a
#                   lower-dimensional space while retaining as much information
#                   (variance) as possible. It is often used to address issues
#                   like multicollinearity, overfitting, and computational
#                   complexity.
#    - **Mechanism**: Dimensionality reduction methods *create new features*
#                   (principal components or latent variables) that are linear
#                   combinations of the original features. These new features
#                   are ordered by the amount of variance they capture.
#    - **Result**: The result is a reduced-dimensional dataset with fewer
#                   features (principal components) than the original dataset.
#                   These new features are typically linearly uncorrelated and
#                   orthogonal (statistically independent) to each other.
#    - **Interpretability**: The principal components created by dimensionality
#                   reduction may not have direct interpretability because they
#                   are linear combinations of original features. However, they
#                   capture patterns of variation in the data.

# In summary, feature selection involves choosing a subset of the original
# features to keep while discarding others, with the aim of retaining the
# interpretability of the selected features.

# Dimensionality reduction, on the other hand, creates new features (principal
# components) that summarize the information in the original features, often at
# the cost of interpretability.

# The choice between these techniques depends on your specific goals, the
# nature of your data, and the trade-offs between interpretability and data
# reduction.

# The technique used below is dimensionality reduction, followed by an
# identification of the features that are most represented in the principal
# or independent components.

## STEP 9.a. PCA Linear Algebra Transform for Dimensionality Reduction ----
# Principal Component Analysis (PCA) is a statistical approach that can be used
# to analyse high-dimensional data and capture the most important information
# (principal components) from it. This is done by transforming the original
# data into a lower-dimensional space while collating highly correlated
# variables together.

# PCA is applicable when the data is quantitative.
# If the data is qualitative, then Multiple Correspondence Analysis (MCA) or
# Correspondence Analysis (CA) can be used instead.

# If the data has both quantitative and qualitative values, then Multiple
# Factor Analysis (MFA) or Factor Analysis of Mixed Data (FAMD) can be used
# instead.

### PCA for Dimensionality Reduction on the Boston Housing Dataset ----
# The initial 13 numeric variables in the Boston Housing dataset are reduced to
# 10 variables which are in the form of principal components (not the initial
# features).
summary(BostonHousing)

model_of_the_transform <- preProcess(BostonHousing, method =
                                       c("scale", "center", "pca"))

print(model_of_the_transform)
boston_housing_pca_dr <- predict(model_of_the_transform, BostonHousing)

summary(boston_housing_pca_dr)

### PCA for Dimensionality Reduction on the Crop Dataset ----
# Notice that PCA is not applied to the “Crop Data” dataset because it requires
# multiple numeric independent variables. The dataset has 3 categorical
# independent variables and only 1 numeric independent variable.

### PCA for Dimensionality Reduction on the Iris Dataset ----
# The initial 4 numeric variables are reduced to 2 principal components
summary(iris_dataset)

model_of_the_transform <- preProcess(iris_dataset,
                                     method = c("scale", "center", "pca"))
print(model_of_the_transform)
iris_dataset_pca_dr <- predict(model_of_the_transform, iris_dataset)

summary(iris_dataset_pca_dr)
dim(iris_dataset_pca_dr)

### PCA for Dimensionality Reduction on the Pima Indians Diabetes Dataset ----
# The initial 8 numeric variables are "reduced" to 8 principal components
summary(PimaIndiansDiabetes)

model_of_the_transform <- preProcess(PimaIndiansDiabetes,
                                     method = c("scale", "center", "pca"))
print(model_of_the_transform)
pima_indians_diabetes_pca_transform <- predict(model_of_the_transform, # nolint
                                               PimaIndiansDiabetes)
summary(pima_indians_diabetes_pca_transform)

## STEP 9.b. PCA Linear Algebra Transform for Feature Extraction ----

# We use the `princomp()` function is used to perform PCA on a correlation
# matrix.

### PCA for Feature Extraction on the Boston Housing Dataset ----
boston_housing_pca_fe <- princomp(cor(BostonHousing[, -4]))
summary(boston_housing_pca_fe)

#### Scree Plot ----
# The Scree Plot shows that the 1st 2 principal components can cumulatively
# explain 92.8% of the variance, i.e., 87.7% + 5.1% = 92.8%.
factoextra::fviz_eig(boston_housing_pca_fe, addlabels = TRUE)

#### Loading Values ----
# Remember: Principal components are new features created in the process of
#           dimensionality reduction. We would like to know the extent to which
#           each feature is represented in the 1st 2 principal components. We
#           can use "loading values" to determine the extent of representation.

# The loading values for each variable in the 1st 2 principal components are
# shown below:
boston_housing_pca_fe$loadings[, 1:2]

# This is easier to understand using a visualization that shows the extent to
# which each variable is represented in a given component.

# In this case, it shows the extent to which each variable is represented in
# the first 2 components.


# Points to note when interpreting the visualization:
# The Cos2 value is the square cosine. It corresponds to the quality of
# representation.
#    (i) A low value means that the variable is not perfectly represented by
#         that component.
#    (ii) A high value, on the other hand, means a good representation of the
#         variable on that component.

factoextra::fviz_cos2(boston_housing_pca_fe, choice = "var", axes = 1:2)

# The 8 most represented variables in the first 2 components (which we said
# represent 92.8% of the variation) are, in descending order: indus, nox,
# lstat, dis, tax, age, medv, rad

#### Biplot and Cos2 Combined Plot ----
# This can be confirmed using the following visualization.

# Points to note when interpreting the visualization:
#    (i) All the variables that are grouped together are positively correlated.
#    (ii) The longer the arrow, the better represented the variable is.
#    (iii) Variables that are negatively correlated are displayed in the
#          opposite side of the origin.

factoextra::fviz_pca_var(boston_housing_pca_fe, col.var = "cos2",
                         gradient.cols = c("red", "orange", "green"),
                         repel = TRUE)

### PCA for Feature Extraction on the Pima Indians Diabetes Dataset ----

pima_indians_diabetes_fe <- princomp(cor(PimaIndiansDiabetes[, 1:8]))
summary(pima_indians_diabetes_fe)

#### Scree Plot ----
# The Scree Plot shows that the 1st 4 components can cumulatively explain
# 87.4% of the variance.
factoextra::fviz_eig(pima_indians_diabetes_fe,
                     addlabels = TRUE)

#### Loading Values ----
# The loading values for each variable in the 1st 4 principal components are
# shown below
pima_indians_diabetes_fe$loadings[, 1:4]

# This is easier to understand using a visualization that shows the extent to
# which each variable is represented in a given component.

# In this case, it shows the extent to which each variable is represented in
# the first 4 components:
factoextra::fviz_cos2(pima_indians_diabetes_fe,
                      choice = "var", axes = 1:4)

# The 6 most represented variables in the first 4 components are, in descending
# order: pregnant, age, triceps, pedigree, insulin, and glucose

#### Biplot and Cos2 Combined Plot ----
# This can be confirmed using the following visualization.

factoextra::fviz_pca_var(pima_indians_diabetes_fe, col.var = "cos2",
                         gradient.cols = c("red", "black", "green"),
                         repel = TRUE)

# Independent Component Analysis (ICA) Linear Algebra Transform ----
## STEP 10. ICA Linear Algebra Transform for Dimensionality Reduction ----

# Independent Component Analysis (ICA) transforms the data to return only the
# independent components. The n.comp argument is required to specify the
# desired number of independent components. This also results in a list of
# attributes that are uncorrelated.

if (!is.element("fastICA", installed.packages()[, 1])) {
  install.packages("fastICA", dependencies = TRUE)
}
require("fastICA")

### ICA for Dimensionality Reduction on the Boston Housing Dataset ----
summary(BostonHousing)

model_of_the_transform <- preProcess(BostonHousing,
                                     method = c("scale", "center", "ica"),
                                     n.comp = 8)
print(model_of_the_transform)
boston_housing_ica_dr <- predict(model_of_the_transform, BostonHousing)

summary(boston_housing_ica_dr)

### ICA for Dimensionality Reduction on the Crop Dataset ----
# Notice that ICA is not applied to the “Crop Data” dataset because it requires
# multiple numeric independent variables. The dataset has 3 categorical
# independent variables and only 1 numeric independent variable.

### ICA for Dimensionality Reduction on the Iris Dataset ----
summary(iris_dataset)
model_of_the_transform <- preProcess(iris_dataset,
                                     method = c("scale", "center", "ica"),
                                     n.comp = 3)
print(model_of_the_transform)
iris_dataset_ica_dr <- predict(model_of_the_transform, iris_dataset)

summary(iris_dataset_ica_dr)

### ICA for Dimensionality Reduction on the Pima Indians Diabetes Dataset ----
summary(PimaIndiansDiabetes)

model_of_the_transform <- preProcess(PimaIndiansDiabetes,
                                     method = c("scale", "center", "ica"),
                                     n.comp = 4)
print(model_of_the_transform)
pima_indians_diabetes_ica <- predict(model_of_the_transform,
                                     PimaIndiansDiabetes)

summary(pima_indians_diabetes_ica)

# [OPTIONAL] **Deinitialization: Create a snapshot of the R environment ----
# Lastly, as a follow-up to the initialization step, record the packages
# installed and their sources in the lockfile so that other team-members can
# use renv::restore() to re-install the same package version in their local
# machine during their initialization step.
# renv::snapshot() # nolint

# References ----
## Bevans, R. (2023). Sample Crop Data Dataset for ANOVA (Version 1) [Dataset]. Scribbr. https://www.scribbr.com/wp-content/uploads//2020/03/crop.data_.anova_.zip # nolint ----

## Fisher, R. A. (1988). Iris [Dataset]. UCI Machine Learning Repository. https://archive.ics.uci.edu/dataset/53/iris # nolint ----

## National Institute of Diabetes and Digestive and Kidney Diseases. (1999). Pima Indians Diabetes Dataset [Dataset]. UCI Machine Learning Repository. https://www.kaggle.com/datasets/uciml/pima-indians-diabetes-database # nolint ----

## StatLib CMU. (1997). Boston Housing [Dataset]. StatLib Carnegie Mellon University. http://lib.stat.cmu.edu/datasets/boston_corrected.txt # nolint ----

# **Required Lab Work Submission** ----
## Part A ----
# Create a new file called
# "Lab4-Submission-ExposingTheStructureOfDataUsingDataTransforms.R".
# Provide all the code you have used to perform data transformation on the
# "BI1 Student Performance" dataset provided in class. Perform ALL the data
# transformations that have been used in the
# "Lab4-ExposingTheStructureOfDataUsingDataTransforms.R" file.

## Part B ----
# Upload *the link* to your
# "Lab4-Submission-ExposingTheStructureOfDataUsingDataTransforms.R" hosted
# on Github (do not upload the .R file itself) through the submission link
# provided on eLearning.

## Part C ----
# Create a markdown file called "Lab-Submission-Markdown.Rmd"
# and place it inside the folder called "markdown". Use R Studio to ensure the
# .Rmd file is based on the "GitHub Document (Markdown)" template when it is
# being created.

# Refer to the following file in Lab 1 for an example of a .Rmd file based on
# the "GitHub Document (Markdown)" template:
#     https://github.com/course-files/BBT4206-R-Lab1of15-LoadingDatasets/blob/main/markdown/BIProject-Template.Rmd # nolint

# Include Line 1 to 14 of BIProject-Template.Rmd in your .Rmd file to make it
# displayable on GitHub when rendered into its .md version

# It should have code chunks that explain the
# data transformation performed on the dataset.

## Part D ----
# Render the .Rmd (R markdown) file into its .md (markdown) version by using
# knitR in RStudio.

# You need to download and install "pandoc" to render the R markdown.
# Pandoc is a file converter that can be used to convert the following files:
#   https://pandoc.org/diagram.svgz?v=20230831075849

# Documentation:
#   https://pandoc.org/installing.html and
#   https://github.com/REditorSupport/vscode-R/wiki/R-Markdown

# By default, Rmd files are open as Markdown documents. To enable R Markdown
# features, you need to associate *.Rmd files with rmd language.
# Add an entry Item "*.Rmd" and Value "rmd" in the VS Code settings,
# "File Association" option.

# Documentation of knitR: https://www.rdocumentation.org/packages/knitr/

# Upload *the link* to "Lab-Submission-Markdown.md" (not .Rmd)
# markdown file hosted on Github (do not upload the .Rmd or .md markdown files)
# through the submission link provided on eLearning.