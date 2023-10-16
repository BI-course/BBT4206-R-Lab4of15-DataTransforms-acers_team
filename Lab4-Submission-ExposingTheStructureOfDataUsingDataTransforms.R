
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
StudentPerformanceDataset <-
  readr::read_csv(
    "data/StudentPerformanceDataset.CSV", # nolint
    col_types =
      readr::cols(
        class_group =
          readr::col_factor(levels = c("A", "B", "C")),
        gender = readr::col_factor(levels = c("1", "0")),
        YOB = readr::col_date(format = "%Y"),
        regret_choosing_bi =
          readr::col_factor(levels = c("1", "0")),
        drop_bi_now =
          readr::col_factor(levels = c("1", "0")),
        motivator =
          readr::col_factor(levels = c("1", "0")),
        read_content_before_lecture =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        anticipate_test_questions =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        answer_rhetorical_questions =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        find_terms_I_do_not_know =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        copy_new_terms_in_reading_notebook =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        take_quizzes_and_use_results =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        reorganise_course_outline =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        write_down_important_points =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        space_out_revision =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        studying_in_study_group =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        schedule_appointments =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        goal_oriented =
          readr::col_factor(levels =
                              c("1", "0")),
        spaced_repetition =
          readr::col_factor(levels =
                              c("1", "2", "3", "4")),
        testing_and_active_recall =
          readr::col_factor(levels =
                              c("1", "2", "3", "4")),
        interleaving =
          readr::col_factor(levels =
                              c("1", "2", "3", "4")),
        categorizing =
          readr::col_factor(levels =
                              c("1", "2", "3", "4")),
        retrospective_timetable =
          readr::col_factor(levels =
                              c("1", "2", "3", "4")),
        cornell_notes =
          readr::col_factor(levels =
                              c("1", "2", "3", "4")),
        sq3r = readr::col_factor(levels =
                                   c("1", "2", "3", "4")),
        commute = readr::col_factor(levels =
                                      c("1", "2",
                                        "3", "4")),
        study_time = readr::col_factor(levels =
                                         c("1", "2",
                                           "3", "4")),
        repeats_since_Y1 = readr::col_integer(),
        paid_tuition = readr::col_factor(levels =
                                           c("0", "1")),
        free_tuition = readr::col_factor(levels =
                                           c("0", "1")),
        extra_curricular = readr::col_factor(levels =
                                               c("0", "1")),
        sports_extra_curricular =
          readr::col_factor(levels = c("0", "1")),
        exercise_per_week = readr::col_factor(levels =
                                                c("0", "1",
                                                  "2",
                                                  "3")),
        meditate = readr::col_factor(levels =
                                       c("0", "1",
                                         "2", "3")),
        pray = readr::col_factor(levels =
                                   c("0", "1",
                                     "2", "3")),
        internet = readr::col_factor(levels =
                                       c("0", "1")),
        laptop = readr::col_factor(levels = c("0", "1")),
        family_relationships =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        friendships = readr::col_factor(levels =
                                          c("1", "2", "3",
                                            "4", "5")),
        romantic_relationships =
          readr::col_factor(levels =
                              c("0", "1", "2", "3", "4")),
        spiritual_wellnes =
          readr::col_factor(levels = c("1", "2", "3",
                                       "4", "5")),
        financial_wellness =
          readr::col_factor(levels = c("1", "2", "3",
                                       "4", "5")),
        health = readr::col_factor(levels = c("1", "2",
                                              "3", "4",
                                              "5")),
        day_out = readr::col_factor(levels = c("0", "1",
                                               "2", "3")),
        night_out = readr::col_factor(levels = c("0",
                                                 "1", "2",
                                                 "3")),
        alcohol_or_narcotics =
          readr::col_factor(levels = c("0", "1", "2", "3")),
        mentor = readr::col_factor(levels = c("0", "1")),
        mentor_meetings = readr::col_factor(levels =
                                              c("0", "1",
                                                "2", "3")),
        `Attendance Waiver Granted: 1 = Yes, 0 = No` =
          readr::col_factor(levels = c("0", "1")),
        GRADE = readr::col_factor(levels =
                                    c("A", "B", "C", "D",
                                      "E"))),
    locale = readr::locale())

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

