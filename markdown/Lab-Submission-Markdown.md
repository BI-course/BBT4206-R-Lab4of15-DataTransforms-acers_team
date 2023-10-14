Business Intelligence Project
================
Acers_Team
October 14, 2023

- [Student Details](#student-details)
- [Setup Chunk](#setup-chunk)
- [Understanding the Dataset (Exploratory Data Analysis
  (EDA))](#understanding-the-dataset-exploratory-data-analysis-eda)
  - [Loading the Dataset](#loading-the-dataset)
    - [Source:](#source)
    - [Reference:](#reference)
  - [STEP 1. Install and Load the Required Packages
    —-](#step-1-install-and-load-the-required-packages--)
  - [STEP 2: Loading datasets](#step-2-loading-datasets)
  - [STEP 3. Apply a Scale Data Transform
    —-](#step-3-apply-a-scale-data-transform--)
  - [STEP 4. Apply a Centre Data Transform
    —-](#step-4-apply-a-centre-data-transform--)
  - [STEP 5. Apply a Standardize Data Transform
    —-](#step-5-apply-a-standardize-data-transform--)
  - [STEP 6. Apply a Normalize Data Transform
    —-](#step-6-apply-a-normalize-data-transform--)
  - [STEP 7. Apply a Box-Cox Power Transform
    —-](#step-7-apply-a-box-cox-power-transform--)
  - [STEP 8. Apply a Yeo-Johnson Power Transform
    —-](#step-8-apply-a-yeo-johnson-power-transform--)
  - [STEP 9.a. PCA Linear Algebra Transform for Dimensionality Reduction
    —-](#step-9a-pca-linear-algebra-transform-for-dimensionality-reduction--)

# Student Details

|                                              |                   |
|----------------------------------------------|-------------------|
| **Student ID Number**                        | …                 |
| **Student Name**                             | Nicholas Bwalley  |
| **Student Name**                             | Sarah Mongare     |
| **Student Name**                             | Millicent Cheptoi |
| **Student Name**                             | Angela Kinya      |
| **Student Name**                             | Lesley Tulienge   |
| **BBIT 4.2 Group**                           | Acers Team        |
| **BI Project Group Name/ID (if applicable)** | …                 |

# Setup Chunk

**Note:** the following KnitR options have been set as the global
defaults: <BR>
`knitr::opts_chunk$set(echo = TRUE, warning = FALSE, eval = TRUE, collapse = FALSE, tidy = TRUE)`.

More KnitR options are documented here
<https://bookdown.org/yihui/rmarkdown-cookbook/chunk-options.html> and
here <https://yihui.org/knitr/options/>.

# Understanding the Dataset (Exploratory Data Analysis (EDA))

## Loading the Dataset

### Source:

The dataset that was used can be downloaded here: *\<provide a link\>*

### Reference:

*\<Cite the dataset here using APA\>  
Refer to the APA 7th edition manual for rules on how to cite datasets:
<https://apastyle.apa.org/style-grammar-guidelines/references/examples/data-set-references>*

## STEP 1. Install and Load the Required Packages —-

``` r
if (require("languageserver")) {
  require("languageserver")
} else {
  install.packages("languageserver", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: languageserver

``` r
## mlbench ----
if (require("mlbench")) {
  require("mlbench")
} else {
  install.packages("mlbench", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: mlbench

``` r
## readr ----
if (require("readr")) {
  require("readr")
} else {
  install.packages("readr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: readr

``` r
## caret ----
if (require("caret")) {
  require("caret")
} else {
  install.packages("caret", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: caret

    ## Loading required package: ggplot2

    ## Loading required package: lattice

``` r
## e1071 ----
if (require("e1071")) {
  require("e1071")
} else {
  install.packages("e1071", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: e1071

``` r
## factoextra ----
if (require("factoextra")) {
  require("factoextra")
} else {
  install.packages("factoextra", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: factoextra

    ## Welcome! Want to learn more? See two factoextra-related books at https://goo.gl/ve3WBa

``` r
## FactoMineR ----
if (require("FactoMineR")) {
  require("FactoMineR")
} else {
  install.packages("FactoMineR", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: FactoMineR

## STEP 2: Loading datasets

``` r
library(readr)


StudentPerformanceDataset <- read_csv("C:/Users/NICK BWALLEY/OneDrive - Strathmore University/MyStrath/BBIT/4.2/Business Intelligence II - Dr. Allan Omondi/BI2-Labs/BBT4206-R-Lab4of15-DataTransforms-acers_team/data/StudentPerformanceDataset.csv")
```

    ## Rows: 101 Columns: 100
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (4): class_group, D - 1. Write two things you like about the teaching a...
    ## dbl (96): gender, YOB, regret_choosing_bi, drop_bi_now, motivator, read_cont...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
View(StudentPerformanceDataset)
```

## STEP 3. Apply a Scale Data Transform —-

``` r
summary(StudentPerformanceDataset)
```

    ##  class_group            gender            YOB       regret_choosing_bi
    ##  Length:101         Min.   :0.0000   Min.   :1998   Min.   :0.0000    
    ##  Class :character   1st Qu.:0.0000   1st Qu.:2000   1st Qu.:0.0000    
    ##  Mode  :character   Median :1.0000   Median :2001   Median :0.0000    
    ##                     Mean   :0.5743   Mean   :2001   Mean   :0.0198    
    ##                     3rd Qu.:1.0000   3rd Qu.:2002   3rd Qu.:0.0000    
    ##                     Max.   :1.0000   Max.   :2003   Max.   :1.0000    
    ##                                                                       
    ##   drop_bi_now       motivator      read_content_before_lecture
    ##  Min.   :0.0000   Min.   :0.0000   Min.   :1.000              
    ##  1st Qu.:0.0000   1st Qu.:1.0000   1st Qu.:2.000              
    ##  Median :0.0000   Median :1.0000   Median :3.000              
    ##  Mean   :0.0198   Mean   :0.7525   Mean   :2.752              
    ##  3rd Qu.:0.0000   3rd Qu.:1.0000   3rd Qu.:3.000              
    ##  Max.   :1.0000   Max.   :1.0000   Max.   :5.000              
    ##                                                               
    ##  anticipate_test_questions answer_rhetorical_questions find_terms_I_do_not_know
    ##  Min.   :1.000             Min.   :1.000               Min.   :1.000           
    ##  1st Qu.:3.000             1st Qu.:3.000               1st Qu.:3.000           
    ##  Median :4.000             Median :4.000               Median :4.000           
    ##  Mean   :3.584             Mean   :3.426               Mean   :3.743           
    ##  3rd Qu.:4.000             3rd Qu.:4.000               3rd Qu.:5.000           
    ##  Max.   :5.000             Max.   :5.000               Max.   :5.000           
    ##                                                                                
    ##  copy_new_terms_in_reading_notebook take_quizzes_and_use_results
    ##  Min.   :1.000                      Min.   :1.000               
    ##  1st Qu.:3.000                      1st Qu.:3.000               
    ##  Median :4.000                      Median :4.000               
    ##  Mean   :3.663                      Mean   :3.941               
    ##  3rd Qu.:4.000                      3rd Qu.:5.000               
    ##  Max.   :5.000                      Max.   :5.000               
    ##                                                                 
    ##  reorganise_course_outline write_down_important_points space_out_revision
    ##  Min.   :1.000             Min.   :1.000               Min.   :1.000     
    ##  1st Qu.:3.000             1st Qu.:3.000               1st Qu.:3.000     
    ##  Median :3.000             Median :4.000               Median :3.000     
    ##  Mean   :3.376             Mean   :3.832               Mean   :3.228     
    ##  3rd Qu.:4.000             3rd Qu.:5.000               3rd Qu.:4.000     
    ##  Max.   :5.000             Max.   :5.000               Max.   :5.000     
    ##                                                                          
    ##  studying_in_study_group schedule_appointments goal_oriented  
    ##  Min.   :1.000           Min.   :1.000         Min.   :0.000  
    ##  1st Qu.:1.000           1st Qu.:1.000         1st Qu.:0.000  
    ##  Median :2.000           Median :2.000         Median :0.000  
    ##  Mean   :2.455           Mean   :1.931         Mean   :0.198  
    ##  3rd Qu.:3.000           3rd Qu.:2.000         3rd Qu.:0.000  
    ##  Max.   :5.000           Max.   :5.000         Max.   :1.000  
    ##                                                               
    ##  spaced_repetition testing_and_active_recall  interleaving    categorizing  
    ##  Min.   :1.000     Min.   :1.000             Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:2.000     1st Qu.:3.000             1st Qu.:2.000   1st Qu.:2.000  
    ##  Median :3.000     Median :3.000             Median :2.000   Median :3.000  
    ##  Mean   :2.554     Mean   :3.059             Mean   :2.257   Mean   :2.713  
    ##  3rd Qu.:3.000     3rd Qu.:4.000             3rd Qu.:3.000   3rd Qu.:3.000  
    ##  Max.   :4.000     Max.   :4.000             Max.   :4.000   Max.   :4.000  
    ##                                                                             
    ##  retrospective_timetable cornell_notes        sq3r          commute    
    ##  Min.   :1.000           Min.   :1.000   Min.   :1.000   Min.   :1.00  
    ##  1st Qu.:2.000           1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.00  
    ##  Median :2.000           Median :3.000   Median :3.000   Median :3.00  
    ##  Mean   :2.406           Mean   :2.545   Mean   :2.614   Mean   :2.73  
    ##  3rd Qu.:3.000           3rd Qu.:3.000   3rd Qu.:3.000   3rd Qu.:4.00  
    ##  Max.   :4.000           Max.   :4.000   Max.   :4.000   Max.   :4.00  
    ##                                                          NA's   :1     
    ##    study_time   repeats_since_Y1  paid_tuition   free_tuition  extra_curricular
    ##  Min.   :1.00   Min.   : 0.00    Min.   :0.00   Min.   :0.00   Min.   :0.00    
    ##  1st Qu.:1.00   1st Qu.: 0.00    1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00    
    ##  Median :2.00   Median : 2.00    Median :0.00   Median :0.00   Median :1.00    
    ##  Mean   :1.75   Mean   : 2.05    Mean   :0.11   Mean   :0.27   Mean   :0.53    
    ##  3rd Qu.:2.00   3rd Qu.: 3.00    3rd Qu.:0.00   3rd Qu.:1.00   3rd Qu.:1.00    
    ##  Max.   :4.00   Max.   :10.00    Max.   :1.00   Max.   :1.00   Max.   :1.00    
    ##  NA's   :1      NA's   :1        NA's   :1      NA's   :1      NA's   :1       
    ##  sports_extra_curricular exercise_per_week    meditate         pray     
    ##  Min.   :0.00            Min.   :0.0       Min.   :0.00   Min.   :0.00  
    ##  1st Qu.:0.00            1st Qu.:1.0       1st Qu.:0.00   1st Qu.:1.00  
    ##  Median :0.00            Median :1.0       Median :1.00   Median :2.00  
    ##  Mean   :0.36            Mean   :1.1       Mean   :0.76   Mean   :2.09  
    ##  3rd Qu.:1.00            3rd Qu.:2.0       3rd Qu.:1.00   3rd Qu.:3.00  
    ##  Max.   :1.00            Max.   :3.0       Max.   :3.00   Max.   :3.00  
    ##  NA's   :1               NA's   :1         NA's   :1      NA's   :1     
    ##     internet        laptop  family_relationships  friendships  
    ##  Min.   :0.00   Min.   :1   Min.   :2.00         Min.   :2.00  
    ##  1st Qu.:1.00   1st Qu.:1   1st Qu.:4.00         1st Qu.:4.00  
    ##  Median :1.00   Median :1   Median :4.00         Median :4.00  
    ##  Mean   :0.87   Mean   :1   Mean   :4.19         Mean   :4.01  
    ##  3rd Qu.:1.00   3rd Qu.:1   3rd Qu.:5.00         3rd Qu.:4.00  
    ##  Max.   :1.00   Max.   :1   Max.   :5.00         Max.   :5.00  
    ##  NA's   :1      NA's   :1   NA's   :1            NA's   :1     
    ##  romantic_relationships spiritual_wellnes financial_wellness     health    
    ##  Min.   :0.00           Min.   :1.00      Min.   :1.00       Min.   :1.00  
    ##  1st Qu.:0.00           1st Qu.:3.00      1st Qu.:2.00       1st Qu.:3.00  
    ##  Median :0.00           Median :4.00      Median :3.00       Median :4.00  
    ##  Mean   :1.37           Mean   :3.65      Mean   :3.03       Mean   :4.04  
    ##  3rd Qu.:3.00           3rd Qu.:4.00      3rd Qu.:4.00       3rd Qu.:5.00  
    ##  Max.   :4.00           Max.   :5.00      Max.   :5.00       Max.   :5.00  
    ##  NA's   :1              NA's   :1         NA's   :1          NA's   :1     
    ##     day_out      night_out    alcohol_or_narcotics     mentor    
    ##  Min.   :0.0   Min.   :0.00   Min.   :0.00         Min.   :0.00  
    ##  1st Qu.:0.0   1st Qu.:0.00   1st Qu.:0.00         1st Qu.:0.00  
    ##  Median :1.0   Median :0.00   Median :0.00         Median :0.00  
    ##  Mean   :0.8   Mean   :0.51   Mean   :0.35         Mean   :0.41  
    ##  3rd Qu.:1.0   3rd Qu.:1.00   3rd Qu.:1.00         3rd Qu.:1.00  
    ##  Max.   :3.0   Max.   :3.00   Max.   :3.00         Max.   :1.00  
    ##  NA's   :1     NA's   :1      NA's   :1            NA's   :1     
    ##  mentor_meetings A - 1. I am enjoying the subject
    ##  Min.   :0.00    Min.   :3.00                    
    ##  1st Qu.:0.00    1st Qu.:4.00                    
    ##  Median :0.00    Median :5.00                    
    ##  Mean   :0.68    Mean   :4.49                    
    ##  3rd Qu.:1.00    3rd Qu.:5.00                    
    ##  Max.   :3.00    Max.   :5.00                    
    ##  NA's   :1       NA's   :1                       
    ##  A - 2. Classes start and end on time
    ##  Min.   :3.00                        
    ##  1st Qu.:4.00                        
    ##  Median :5.00                        
    ##  Mean   :4.68                        
    ##  3rd Qu.:5.00                        
    ##  Max.   :5.00                        
    ##  NA's   :1                           
    ##  A - 3. The learning environment is participative, involves learning by doing and is group-based
    ##  Min.   :3.00                                                                                   
    ##  1st Qu.:4.00                                                                                   
    ##  Median :4.00                                                                                   
    ##  Mean   :4.35                                                                                   
    ##  3rd Qu.:5.00                                                                                   
    ##  Max.   :5.00                                                                                   
    ##  NA's   :1                                                                                      
    ##  A - 4. The subject content is delivered according to the course outline and meets my expectations
    ##  Min.   :3.00                                                                                     
    ##  1st Qu.:4.75                                                                                     
    ##  Median :5.00                                                                                     
    ##  Mean   :4.74                                                                                     
    ##  3rd Qu.:5.00                                                                                     
    ##  Max.   :5.00                                                                                     
    ##  NA's   :1                                                                                        
    ##  A - 5. The topics are clear and logically developed
    ##  Min.   :2.00                                       
    ##  1st Qu.:4.00                                       
    ##  Median :5.00                                       
    ##  Mean   :4.65                                       
    ##  3rd Qu.:5.00                                       
    ##  Max.   :5.00                                       
    ##  NA's   :1                                          
    ##  A - 6. I am developing my oral and writing skills
    ##  Min.   :1.00                                     
    ##  1st Qu.:4.00                                     
    ##  Median :4.00                                     
    ##  Mean   :4.11                                     
    ##  3rd Qu.:5.00                                     
    ##  Max.   :5.00                                     
    ##  NA's   :1                                        
    ##  A - 7. I am developing my reflective and critical reasoning skills
    ##  Min.   :2.00                                                      
    ##  1st Qu.:4.00                                                      
    ##  Median :4.00                                                      
    ##  Mean   :4.38                                                      
    ##  3rd Qu.:5.00                                                      
    ##  Max.   :5.00                                                      
    ##  NA's   :1                                                         
    ##  A - 8. The assessment methods are assisting me to learn
    ##  Min.   :1.00                                           
    ##  1st Qu.:4.00                                           
    ##  Median :5.00                                           
    ##  Mean   :4.61                                           
    ##  3rd Qu.:5.00                                           
    ##  Max.   :5.00                                           
    ##  NA's   :1                                              
    ##  A - 9. I receive relevant feedback
    ##  Min.   :3.00                      
    ##  1st Qu.:4.00                      
    ##  Median :5.00                      
    ##  Mean   :4.58                      
    ##  3rd Qu.:5.00                      
    ##  Max.   :5.00                      
    ##  NA's   :1                         
    ##  A - 10. I read the recommended readings and notes
    ##  Min.   :3.00                                     
    ##  1st Qu.:4.00                                     
    ##  Median :5.00                                     
    ##  Mean   :4.55                                     
    ##  3rd Qu.:5.00                                     
    ##  Max.   :5.00                                     
    ##  NA's   :1                                        
    ##  A - 11. I use the eLearning material posted
    ##  Min.   :3.0                                
    ##  1st Qu.:4.0                                
    ##  Median :5.0                                
    ##  Mean   :4.7                                
    ##  3rd Qu.:5.0                                
    ##  Max.   :5.0                                
    ##  NA's   :1                                  
    ##  B - 1. Concept 1 of 6: Principles of Business Intelligence and the DataOps Philosophy
    ##  Min.   :1.00                                                                         
    ##  1st Qu.:4.00                                                                         
    ##  Median :4.00                                                                         
    ##  Mean   :4.25                                                                         
    ##  3rd Qu.:5.00                                                                         
    ##  Max.   :5.00                                                                         
    ##  NA's   :1                                                                            
    ##  B - 2. Concept 3 of 6: Linear Algorithms for Predictive Analytics
    ##  Min.   :2.00                                                     
    ##  1st Qu.:3.00                                                     
    ##  Median :4.00                                                     
    ##  Mean   :3.94                                                     
    ##  3rd Qu.:5.00                                                     
    ##  Max.   :5.00                                                     
    ##  NA's   :1                                                        
    ##  C - 2. Quizzes at the end of each concept
    ##  Min.   :2.00                             
    ##  1st Qu.:4.00                             
    ##  Median :5.00                             
    ##  Mean   :4.59                             
    ##  3rd Qu.:5.00                             
    ##  Max.   :5.00                             
    ##  NA's   :1                                
    ##  C - 3. Lab manuals that outline the steps to follow during the labs
    ##  Min.   :3.00                                                       
    ##  1st Qu.:4.00                                                       
    ##  Median :5.00                                                       
    ##  Mean   :4.61                                                       
    ##  3rd Qu.:5.00                                                       
    ##  Max.   :5.00                                                       
    ##  NA's   :1                                                          
    ##  C - 4. Required lab work submissions at the end of each lab manual that outline the activity to be done on your own
    ##  Min.   :3.00                                                                                                       
    ##  1st Qu.:4.00                                                                                                       
    ##  Median :5.00                                                                                                       
    ##  Mean   :4.55                                                                                                       
    ##  3rd Qu.:5.00                                                                                                       
    ##  Max.   :5.00                                                                                                       
    ##  NA's   :1                                                                                                          
    ##  C - 5. Supplementary videos to watch
    ##  Min.   :1.00                        
    ##  1st Qu.:4.00                        
    ##  Median :4.00                        
    ##  Mean   :4.19                        
    ##  3rd Qu.:5.00                        
    ##  Max.   :5.00                        
    ##  NA's   :1                           
    ##  C - 6. Supplementary podcasts to listen to
    ##  Min.   :1.00                              
    ##  1st Qu.:4.00                              
    ##  Median :4.00                              
    ##  Mean   :4.08                              
    ##  3rd Qu.:5.00                              
    ##  Max.   :5.00                              
    ##  NA's   :1                                 
    ##  C - 7. Supplementary content to read C - 8. Lectures slides
    ##  Min.   :1.00                         Min.   :2.0           
    ##  1st Qu.:4.00                         1st Qu.:4.0           
    ##  Median :4.00                         Median :5.0           
    ##  Mean   :4.17                         Mean   :4.6           
    ##  3rd Qu.:5.00                         3rd Qu.:5.0           
    ##  Max.   :5.00                         Max.   :5.0           
    ##  NA's   :1                            NA's   :1             
    ##  C - 9. Lecture notes on some of the lecture slides
    ##  Min.   :2.0                                       
    ##  1st Qu.:4.0                                       
    ##  Median :5.0                                       
    ##  Mean   :4.6                                       
    ##  3rd Qu.:5.0                                       
    ##  Max.   :5.0                                       
    ##  NA's   :1                                         
    ##  C - 10. The quality of the lectures given (quality measured by the breadth (the full span of knowledge of a subject) and depth (the extent to which specific topics are focused upon, amplified, and explored) of learning - NOT quality measured by how fun/comical/lively the lectures are)
    ##  Min.   :2.00                                                                                                                                                                                                                                                                                 
    ##  1st Qu.:4.00                                                                                                                                                                                                                                                                                 
    ##  Median :5.00                                                                                                                                                                                                                                                                                 
    ##  Mean   :4.54                                                                                                                                                                                                                                                                                 
    ##  3rd Qu.:5.00                                                                                                                                                                                                                                                                                 
    ##  Max.   :5.00                                                                                                                                                                                                                                                                                 
    ##  NA's   :1                                                                                                                                                                                                                                                                                    
    ##  C - 11. The division of theory and practice such that most of the theory is done during the recorded online classes and most of the practice is done during the physical classes
    ##  Min.   :2.00                                                                                                                                                                    
    ##  1st Qu.:4.00                                                                                                                                                                    
    ##  Median :5.00                                                                                                                                                                    
    ##  Mean   :4.49                                                                                                                                                                    
    ##  3rd Qu.:5.00                                                                                                                                                                    
    ##  Max.   :5.00                                                                                                                                                                    
    ##  NA's   :1                                                                                                                                                                       
    ##  C - 12. The recordings of online classes
    ##  Min.   :2.00                            
    ##  1st Qu.:4.00                            
    ##  Median :5.00                            
    ##  Mean   :4.33                            
    ##  3rd Qu.:5.00                            
    ##  Max.   :5.00                            
    ##  NA's   :1                               
    ##  D - 1. Write two things you like about the teaching and learning in this unit so far.
    ##  Length:101                                                                           
    ##  Class :character                                                                     
    ##  Mode  :character                                                                     
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##  D - 2. Write at least one recommendation to improve the teaching and learning in this unit (for the remaining weeks in the semester)
    ##  Length:101                                                                                                                          
    ##  Class :character                                                                                                                    
    ##  Mode  :character                                                                                                                    
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##  Average Course Evaluation Rating Average Level of Learning Attained Rating
    ##  Min.   :2.909                    Min.   :2.000                            
    ##  1st Qu.:4.273                    1st Qu.:3.500                            
    ##  Median :4.545                    Median :4.000                            
    ##  Mean   :4.531                    Mean   :4.095                            
    ##  3rd Qu.:4.909                    3rd Qu.:4.500                            
    ##  Max.   :5.000                    Max.   :5.000                            
    ##  NA's   :1                        NA's   :1                                
    ##  Average Pedagogical Strategy Effectiveness Rating
    ##  Min.   :3.182                                    
    ##  1st Qu.:4.068                                    
    ##  Median :4.545                                    
    ##  Mean   :4.432                                    
    ##  3rd Qu.:4.909                                    
    ##  Max.   :5.000                                    
    ##  NA's   :1                                        
    ##  Project: Section 1-4: (20%) x/10 Project: Section 5-11: (50%) x/10
    ##  Min.   : 0.000                   Min.   : 0.000                   
    ##  1st Qu.: 7.400                   1st Qu.: 6.000                   
    ##  Median : 8.500                   Median : 7.800                   
    ##  Mean   : 8.011                   Mean   : 6.582                   
    ##  3rd Qu.: 9.000                   3rd Qu.: 8.300                   
    ##  Max.   :10.000                   Max.   :10.000                   
    ##                                                                    
    ##  Project: Section 12: (30%) x/5 Project: (10%): x/30 x 100 TOTAL
    ##  Min.   :0.000                  Min.   :  0.00                  
    ##  1st Qu.:0.000                  1st Qu.: 56.00                  
    ##  Median :0.000                  Median : 66.40                  
    ##  Mean   :1.015                  Mean   : 62.39                  
    ##  3rd Qu.:1.250                  3rd Qu.: 71.60                  
    ##  Max.   :5.000                  Max.   :100.00                  
    ##  NA's   :1                                                      
    ##  Quiz 1 on Concept 1 (Introduction) x/32 Quiz 3 on Concept 3 (Linear) x/15
    ##  Min.   : 4.75                           Min.   : 3.00                    
    ##  1st Qu.:11.53                           1st Qu.: 7.00                    
    ##  Median :15.33                           Median : 9.00                    
    ##  Mean   :16.36                           Mean   : 9.53                    
    ##  3rd Qu.:19.63                           3rd Qu.:12.00                    
    ##  Max.   :31.25                           Max.   :15.00                    
    ##                                          NA's   :2                        
    ##  Quiz 4 on Concept 4 (Non-Linear) x/22 Quiz 5 on Concept 5 (Dashboarding) x/10
    ##  Min.   : 3.00                         Min.   : 0.000                         
    ##  1st Qu.:10.91                         1st Qu.: 5.000                         
    ##  Median :13.50                         Median : 6.330                         
    ##  Mean   :13.94                         Mean   : 6.367                         
    ##  3rd Qu.:17.50                         3rd Qu.: 8.000                         
    ##  Max.   :22.00                         Max.   :12.670                         
    ##  NA's   :6                             NA's   :12                             
    ##  Quizzes and  Bonus Marks (7%): x/79 x 100 TOTAL
    ##  Min.   :26.26                                  
    ##  1st Qu.:43.82                                  
    ##  Median :55.31                                  
    ##  Mean   :56.22                                  
    ##  3rd Qu.:65.16                                  
    ##  Max.   :95.25                                  
    ##                                                 
    ##  Lab 1 - 2.c. - (Simple Linear Regression) x/5
    ##  Min.   :3.000                                
    ##  1st Qu.:5.000                                
    ##  Median :5.000                                
    ##  Mean   :4.898                                
    ##  3rd Qu.:5.000                                
    ##  Max.   :5.000                                
    ##  NA's   :3                                    
    ##  Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5
    ##  Min.   :2.150                                                 
    ##  1st Qu.:3.150                                                 
    ##  Median :4.850                                                 
    ##  Mean   :4.166                                                 
    ##  3rd Qu.:5.000                                                 
    ##  Max.   :5.000                                                 
    ##  NA's   :6                                                     
    ##  Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5
    ##  Min.   :2.85                                                   
    ##  1st Qu.:4.85                                                   
    ##  Median :4.85                                                   
    ##  Mean   :4.63                                                   
    ##  3rd Qu.:4.85                                                   
    ##  Max.   :5.00                                                   
    ##  NA's   :9                                                      
    ##  Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5
    ##  Min.   :1.850                                    
    ##  1st Qu.:4.100                                    
    ##  Median :4.850                                    
    ##  Mean   :4.425                                    
    ##  3rd Qu.:5.000                                    
    ##  Max.   :5.000                                    
    ##  NA's   :18                                       
    ##  Lab 5 - Chart JS Dashboard Setup x/5 Lab Work (7%) x/25 x 100
    ##  Min.   :0.000                        Min.   : 17.80          
    ##  1st Qu.:0.000                        1st Qu.: 70.80          
    ##  Median :5.000                        Median : 80.00          
    ##  Mean   :3.404                        Mean   : 79.72          
    ##  3rd Qu.:5.000                        3rd Qu.: 97.20          
    ##  Max.   :5.000                        Max.   :100.00          
    ##                                                               
    ##  CAT 1 (8%): x/38 x 100 CAT 2 (8%): x/100 x 100
    ##  Min.   :32.89          Min.   :  0.00         
    ##  1st Qu.:59.21          1st Qu.: 51.00         
    ##  Median :69.73          Median : 63.50         
    ##  Mean   :69.39          Mean   : 62.13         
    ##  3rd Qu.:82.89          3rd Qu.: 81.75         
    ##  Max.   :97.36          Max.   :100.00         
    ##  NA's   :4              NA's   :31             
    ##  Attendance Waiver Granted: 1 = Yes, 0 = No Absenteeism Percentage
    ##  Min.   :0.00000                            Min.   : 0.00         
    ##  1st Qu.:0.00000                            1st Qu.: 7.41         
    ##  Median :0.00000                            Median :14.81         
    ##  Mean   :0.04951                            Mean   :15.42         
    ##  3rd Qu.:0.00000                            3rd Qu.:22.22         
    ##  Max.   :1.00000                            Max.   :51.85         
    ##                                                                   
    ##  Coursework TOTAL: x/40 (40%) EXAM: x/60 (60%)
    ##  Min.   : 7.47                Min.   : 5.00   
    ##  1st Qu.:20.44                1st Qu.:26.00   
    ##  Median :24.58                Median :34.00   
    ##  Mean   :24.53                Mean   :33.94   
    ##  3rd Qu.:29.31                3rd Qu.:42.00   
    ##  Max.   :35.08                Max.   :56.00   
    ##                               NA's   :4       
    ##  TOTAL = Coursework TOTAL + EXAM (100%)    GRADE          
    ##  Min.   : 7.47                          Length:101        
    ##  1st Qu.:45.54                          Class :character  
    ##  Median :58.69                          Mode  :character  
    ##  Mean   :57.12                                            
    ##  3rd Qu.:68.83                                            
    ##  Max.   :87.72                                            
    ## 

``` r
# The code below converts column number 4 into unlisted and numeric data first
# so that a histogram can be plotted. Further reading:
StudentPerformanceDataset_yield <- as.numeric(unlist(StudentPerformanceDataset[, 4]))
hist(StudentPerformanceDataset_yield, main = names(StudentPerformanceDataset)[4])
```

![](Lab-Submission-Markdown_files/figure-gfm/code%20chunk%20three-1.png)<!-- -->

``` r
model_of_the_transform <- preProcess(StudentPerformanceDataset, method = c("scale"))
print(model_of_the_transform)
```

    ## Created from 51 samples and 100 variables
    ## 
    ## Pre-processing:
    ##   - ignored (4)
    ##   - scaled (96)

``` r
student_dataset_scale_transform <- predict(model_of_the_transform, StudentPerformanceDataset)

# AFTER
summary(student_dataset_scale_transform)
```

    ##  class_group            gender           YOB       regret_choosing_bi
    ##  Length:101         Min.   :0.000   Min.   :2008   Min.   :0.0000    
    ##  Class :character   1st Qu.:0.000   1st Qu.:2010   1st Qu.:0.0000    
    ##  Mode  :character   Median :2.012   Median :2011   Median :0.0000    
    ##                     Mean   :1.156   Mean   :2011   Mean   :0.1414    
    ##                     3rd Qu.:2.012   3rd Qu.:2012   3rd Qu.:0.0000    
    ##                     Max.   :2.012   Max.   :2013   Max.   :7.1421    
    ##                                                                      
    ##   drop_bi_now       motivator     read_content_before_lecture
    ##  Min.   :0.0000   Min.   :0.000   Min.   :1.038              
    ##  1st Qu.:0.0000   1st Qu.:2.306   1st Qu.:2.076              
    ##  Median :0.0000   Median :2.306   Median :3.114              
    ##  Mean   :0.1414   Mean   :1.735   Mean   :2.857              
    ##  3rd Qu.:0.0000   3rd Qu.:2.306   3rd Qu.:3.114              
    ##  Max.   :7.1421   Max.   :2.306   Max.   :5.190              
    ##                                                              
    ##  anticipate_test_questions answer_rhetorical_questions find_terms_I_do_not_know
    ##  Min.   :1.007             Min.   :1.007               Min.   :0.9478          
    ##  1st Qu.:3.022             1st Qu.:3.020               1st Qu.:2.8435          
    ##  Median :4.030             Median :4.026               Median :3.7914          
    ##  Mean   :3.611             Mean   :3.448               Mean   :3.5474          
    ##  3rd Qu.:4.030             3rd Qu.:4.026               3rd Qu.:4.7392          
    ##  Max.   :5.037             Max.   :5.033               Max.   :4.7392          
    ##                                                                                
    ##  copy_new_terms_in_reading_notebook take_quizzes_and_use_results
    ##  Min.   :0.9033                     Min.   :0.9299              
    ##  1st Qu.:2.7099                     1st Qu.:2.7897              
    ##  Median :3.6132                     Median :3.7196              
    ##  Mean   :3.3091                     Mean   :3.6644              
    ##  3rd Qu.:3.6132                     3rd Qu.:4.6495              
    ##  Max.   :4.5165                     Max.   :4.6495              
    ##                                                                 
    ##  reorganise_course_outline write_down_important_points space_out_revision
    ##  Min.   :0.8648            Min.   :0.9279              Min.   :0.8847    
    ##  1st Qu.:2.5945            1st Qu.:2.7838              1st Qu.:2.6541    
    ##  Median :2.5945            Median :3.7117              Median :2.6541    
    ##  Mean   :2.9199            Mean   :3.5555              Mean   :2.8556    
    ##  3rd Qu.:3.4593            3rd Qu.:4.6396              3rd Qu.:3.5388    
    ##  Max.   :4.3241            Max.   :4.6396              Max.   :4.4235    
    ##                                                                          
    ##  studying_in_study_group schedule_appointments goal_oriented   
    ##  Min.   :0.7473          Min.   :0.9782        Min.   :0.0000  
    ##  1st Qu.:0.7473          1st Qu.:0.9782        1st Qu.:0.0000  
    ##  Median :1.4947          Median :1.9563        Median :0.0000  
    ##  Mean   :1.8350          Mean   :1.8885        Mean   :0.4944  
    ##  3rd Qu.:2.2420          3rd Qu.:1.9563        3rd Qu.:0.0000  
    ##  Max.   :3.7367          Max.   :4.8908        Max.   :2.4969  
    ##                                                                
    ##  spaced_repetition testing_and_active_recall  interleaving    categorizing  
    ##  Min.   :1.204     Min.   :1.392             Min.   :1.345   Min.   :1.352  
    ##  1st Qu.:2.409     1st Qu.:4.175             1st Qu.:2.689   1st Qu.:2.705  
    ##  Median :3.613     Median :4.175             Median :2.689   Median :4.057  
    ##  Mean   :3.076     Mean   :4.257             Mean   :3.035   Mean   :3.669  
    ##  3rd Qu.:3.613     3rd Qu.:5.566             3rd Qu.:4.034   3rd Qu.:4.057  
    ##  Max.   :4.817     Max.   :5.566             Max.   :5.379   Max.   :5.410  
    ##                                                                             
    ##  retrospective_timetable cornell_notes        sq3r           commute      
    ##  Min.   :1.130           Min.   :1.005   Min.   :0.9537   Min.   :0.9587  
    ##  1st Qu.:2.259           1st Qu.:2.010   1st Qu.:1.9074   1st Qu.:1.9174  
    ##  Median :2.259           Median :3.014   Median :2.8612   Median :2.8761  
    ##  Mean   :2.718           Mean   :2.557   Mean   :2.4929   Mean   :2.6173  
    ##  3rd Qu.:3.389           3rd Qu.:3.014   3rd Qu.:2.8612   3rd Qu.:3.8349  
    ##  Max.   :4.519           Max.   :4.019   Max.   :3.8149   Max.   :3.8349  
    ##                                                           NA's   :1       
    ##    study_time    repeats_since_Y1  paid_tuition     free_tuition   
    ##  Min.   :1.218   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
    ##  1st Qu.:1.218   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  
    ##  Median :2.436   Median :0.9479   Median :0.0000   Median :0.0000  
    ##  Mean   :2.131   Mean   :0.9716   Mean   :0.3498   Mean   :0.6051  
    ##  3rd Qu.:2.436   3rd Qu.:1.4218   3rd Qu.:0.0000   3rd Qu.:2.2412  
    ##  Max.   :4.871   Max.   :4.7394   Max.   :3.1800   Max.   :2.2412  
    ##  NA's   :1       NA's   :1        NA's   :1        NA's   :1       
    ##  extra_curricular sports_extra_curricular exercise_per_week    meditate     
    ##  Min.   :0.000    Min.   :0.0000          Min.   :0.000     Min.   :0.0000  
    ##  1st Qu.:0.000    1st Qu.:0.0000          1st Qu.:1.234     1st Qu.:0.0000  
    ##  Median :1.994    Median :0.0000          Median :1.234     Median :1.0714  
    ##  Mean   :1.057    Mean   :0.7462          Mean   :1.358     Mean   :0.8143  
    ##  3rd Qu.:1.994    3rd Qu.:2.0729          3rd Qu.:2.468     3rd Qu.:1.0714  
    ##  Max.   :1.994    Max.   :2.0729          Max.   :3.702     Max.   :3.2143  
    ##  NA's   :1        NA's   :1               NA's   :1         NA's   :1       
    ##       pray           internet         laptop  family_relationships
    ##  Min.   :0.0000   Min.   :0.000   Min.   :1   Min.   :2.499       
    ##  1st Qu.:0.9748   1st Qu.:2.959   1st Qu.:1   1st Qu.:4.999       
    ##  Median :1.9496   Median :2.959   Median :1   Median :4.999       
    ##  Mean   :2.0373   Mean   :2.574   Mean   :1   Mean   :5.236       
    ##  3rd Qu.:2.9243   3rd Qu.:2.959   3rd Qu.:1   3rd Qu.:6.249       
    ##  Max.   :2.9243   Max.   :2.959   Max.   :1   Max.   :6.249       
    ##  NA's   :1        NA's   :1       NA's   :1   NA's   :1           
    ##   friendships    romantic_relationships spiritual_wellnes financial_wellness
    ##  Min.   :2.734   Min.   :0.0000         Min.   :1.068     Min.   :0.9124    
    ##  1st Qu.:5.467   1st Qu.:0.0000         1st Qu.:3.205     1st Qu.:1.8249    
    ##  Median :5.467   Median :0.0000         Median :4.273     Median :2.7373    
    ##  Mean   :5.481   Mean   :0.8531         Mean   :3.899     Mean   :2.7647    
    ##  3rd Qu.:5.467   3rd Qu.:1.8681         3rd Qu.:4.273     3rd Qu.:3.6498    
    ##  Max.   :6.834   Max.   :2.4908         Max.   :5.341     Max.   :4.5622    
    ##  NA's   :1       NA's   :1              NA's   :1         NA's   :1         
    ##      health         day_out        night_out      alcohol_or_narcotics
    ##  Min.   :1.050   Min.   :0.000   Min.   :0.0000   Min.   :0.000       
    ##  1st Qu.:3.149   1st Qu.:0.000   1st Qu.:0.0000   1st Qu.:0.000       
    ##  Median :4.199   Median :1.759   Median :0.0000   Median :0.000       
    ##  Mean   :4.241   Mean   :1.407   Mean   :0.7926   Mean   :0.628       
    ##  3rd Qu.:5.249   3rd Qu.:1.759   3rd Qu.:1.5541   3rd Qu.:1.794       
    ##  Max.   :5.249   Max.   :5.277   Max.   :4.6623   Max.   :5.383       
    ##  NA's   :1       NA's   :1       NA's   :1        NA's   :1           
    ##      mentor       mentor_meetings  A - 1. I am enjoying the subject
    ##  Min.   :0.0000   Min.   :0.0000   Min.   :5.046                   
    ##  1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:6.728                   
    ##  Median :0.0000   Median :0.0000   Median :8.410                   
    ##  Mean   :0.8294   Mean   :0.8101   Mean   :7.553                   
    ##  3rd Qu.:2.0230   3rd Qu.:1.1913   3rd Qu.:8.410                   
    ##  Max.   :2.0230   Max.   :3.5738   Max.   :8.410                   
    ##  NA's   :1        NA's   :1        NA's   :1                       
    ##  A - 2. Classes start and end on time
    ##  Min.   : 6.124                      
    ##  1st Qu.: 8.165                      
    ##  Median :10.206                      
    ##  Mean   : 9.553                      
    ##  3rd Qu.:10.206                      
    ##  Max.   :10.206                      
    ##  NA's   :1                           
    ##  A - 3. The learning environment is participative, involves learning by doing and is group-based
    ##  Min.   :4.565                                                                                  
    ##  1st Qu.:6.087                                                                                  
    ##  Median :6.087                                                                                  
    ##  Mean   :6.620                                                                                  
    ##  3rd Qu.:7.609                                                                                  
    ##  Max.   :7.609                                                                                  
    ##  NA's   :1                                                                                      
    ##  A - 4. The subject content is delivered according to the course outline and meets my expectations
    ##  Min.   : 6.477                                                                                   
    ##  1st Qu.:10.255                                                                                   
    ##  Median :10.795                                                                                   
    ##  Mean   :10.233                                                                                   
    ##  3rd Qu.:10.795                                                                                   
    ##  Max.   :10.795                                                                                   
    ##  NA's   :1                                                                                        
    ##  A - 5. The topics are clear and logically developed
    ##  Min.   :3.477                                      
    ##  1st Qu.:6.955                                      
    ##  Median :8.693                                      
    ##  Mean   :8.085                                      
    ##  3rd Qu.:8.693                                      
    ##  Max.   :8.693                                      
    ##  NA's   :1                                          
    ##  A - 6. I am developing my oral and writing skills
    ##  Min.   :1.143                                    
    ##  1st Qu.:4.572                                    
    ##  Median :4.572                                    
    ##  Mean   :4.697                                    
    ##  3rd Qu.:5.715                                    
    ##  Max.   :5.715                                    
    ##  NA's   :1                                        
    ##  A - 7. I am developing my reflective and critical reasoning skills
    ##  Min.   :2.886                                                     
    ##  1st Qu.:5.771                                                     
    ##  Median :5.771                                                     
    ##  Mean   :6.319                                                     
    ##  3rd Qu.:7.214                                                     
    ##  Max.   :7.214                                                     
    ##  NA's   :1                                                         
    ##  A - 8. The assessment methods are assisting me to learn
    ##  Min.   :1.539                                          
    ##  1st Qu.:6.157                                          
    ##  Median :7.696                                          
    ##  Mean   :7.095                                          
    ##  3rd Qu.:7.696                                          
    ##  Max.   :7.696                                          
    ##  NA's   :1                                              
    ##  A - 9. I receive relevant feedback
    ##  Min.   :5.417                     
    ##  1st Qu.:7.223                     
    ##  Median :9.029                     
    ##  Mean   :8.271                     
    ##  3rd Qu.:9.029                     
    ##  Max.   :9.029                     
    ##  NA's   :1                         
    ##  A - 10. I read the recommended readings and notes
    ##  Min.   :4.795                                    
    ##  1st Qu.:6.394                                    
    ##  Median :7.992                                    
    ##  Mean   :7.273                                    
    ##  3rd Qu.:7.992                                    
    ##  Max.   :7.992                                    
    ##  NA's   :1                                        
    ##  A - 11. I use the eLearning material posted
    ##  Min.   :5.745                              
    ##  1st Qu.:7.659                              
    ##  Median :9.574                              
    ##  Mean   :9.000                              
    ##  3rd Qu.:9.574                              
    ##  Max.   :9.574                              
    ##  NA's   :1                                  
    ##  B - 1. Concept 1 of 6: Principles of Business Intelligence and the DataOps Philosophy
    ##  Min.   :1.277                                                                        
    ##  1st Qu.:5.106                                                                        
    ##  Median :5.106                                                                        
    ##  Mean   :5.425                                                                        
    ##  3rd Qu.:6.383                                                                        
    ##  Max.   :6.383                                                                        
    ##  NA's   :1                                                                            
    ##  B - 2. Concept 3 of 6: Linear Algorithms for Predictive Analytics
    ##  Min.   :2.319                                                    
    ##  1st Qu.:3.478                                                    
    ##  Median :4.638                                                    
    ##  Mean   :4.568                                                    
    ##  3rd Qu.:5.797                                                    
    ##  Max.   :5.797                                                    
    ##  NA's   :1                                                        
    ##  C - 2. Quizzes at the end of each concept
    ##  Min.   :3.22                             
    ##  1st Qu.:6.44                             
    ##  Median :8.05                             
    ##  Mean   :7.39                             
    ##  3rd Qu.:8.05                             
    ##  Max.   :8.05                             
    ##  NA's   :1                                
    ##  C - 3. Lab manuals that outline the steps to follow during the labs
    ##  Min.   :4.990                                                      
    ##  1st Qu.:6.653                                                      
    ##  Median :8.316                                                      
    ##  Mean   :7.667                                                      
    ##  3rd Qu.:8.316                                                      
    ##  Max.   :8.316                                                      
    ##  NA's   :1                                                          
    ##  C - 4. Required lab work submissions at the end of each lab manual that outline the activity to be done on your own
    ##  Min.   :4.924                                                                                                      
    ##  1st Qu.:6.565                                                                                                      
    ##  Median :8.207                                                                                                      
    ##  Mean   :7.468                                                                                                      
    ##  3rd Qu.:8.207                                                                                                      
    ##  Max.   :8.207                                                                                                      
    ##  NA's   :1                                                                                                          
    ##  C - 5. Supplementary videos to watch
    ##  Min.   :1.131                       
    ##  1st Qu.:4.524                       
    ##  Median :4.524                       
    ##  Mean   :4.739                       
    ##  3rd Qu.:5.655                       
    ##  Max.   :5.655                       
    ##  NA's   :1                           
    ##  C - 6. Supplementary podcasts to listen to
    ##  Min.   :1.008                             
    ##  1st Qu.:4.034                             
    ##  Median :4.034                             
    ##  Mean   :4.114                             
    ##  3rd Qu.:5.042                             
    ##  Max.   :5.042                             
    ##  NA's   :1                                 
    ##  C - 7. Supplementary content to read C - 8. Lectures slides
    ##  Min.   :1.037                        Min.   :2.760         
    ##  1st Qu.:4.147                        1st Qu.:5.519         
    ##  Median :4.147                        Median :6.899         
    ##  Mean   :4.323                        Mean   :6.347         
    ##  3rd Qu.:5.184                        3rd Qu.:6.899         
    ##  Max.   :5.184                        Max.   :6.899         
    ##  NA's   :1                            NA's   :1             
    ##  C - 9. Lecture notes on some of the lecture slides
    ##  Min.   :3.146                                     
    ##  1st Qu.:6.293                                     
    ##  Median :7.866                                     
    ##  Mean   :7.237                                     
    ##  3rd Qu.:7.866                                     
    ##  Max.   :7.866                                     
    ##  NA's   :1                                         
    ##  C - 10. The quality of the lectures given (quality measured by the breadth (the full span of knowledge of a subject) and depth (the extent to which specific topics are focused upon, amplified, and explored) of learning - NOT quality measured by how fun/comical/lively the lectures are)
    ##  Min.   :3.040                                                                                                                                                                                                                                                                                
    ##  1st Qu.:6.081                                                                                                                                                                                                                                                                                
    ##  Median :7.601                                                                                                                                                                                                                                                                                
    ##  Mean   :6.902                                                                                                                                                                                                                                                                                
    ##  3rd Qu.:7.601                                                                                                                                                                                                                                                                                
    ##  Max.   :7.601                                                                                                                                                                                                                                                                                
    ##  NA's   :1                                                                                                                                                                                                                                                                                    
    ##  C - 11. The division of theory and practice such that most of the theory is done during the recorded online classes and most of the practice is done during the physical classes
    ##  Min.   :2.903                                                                                                                                                                   
    ##  1st Qu.:5.806                                                                                                                                                                   
    ##  Median :7.257                                                                                                                                                                   
    ##  Mean   :6.517                                                                                                                                                                   
    ##  3rd Qu.:7.257                                                                                                                                                                   
    ##  Max.   :7.257                                                                                                                                                                   
    ##  NA's   :1                                                                                                                                                                       
    ##  C - 12. The recordings of online classes
    ##  Min.   :2.343                           
    ##  1st Qu.:4.687                           
    ##  Median :5.859                           
    ##  Mean   :5.074                           
    ##  3rd Qu.:5.859                           
    ##  Max.   :5.859                           
    ##  NA's   :1                               
    ##  D - 1. Write two things you like about the teaching and learning in this unit so far.
    ##  Length:101                                                                           
    ##  Class :character                                                                     
    ##  Mode  :character                                                                     
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##  D - 2. Write at least one recommendation to improve the teaching and learning in this unit (for the remaining weeks in the semester)
    ##  Length:101                                                                                                                          
    ##  Class :character                                                                                                                    
    ##  Mode  :character                                                                                                                    
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##  Average Course Evaluation Rating Average Level of Learning Attained Rating
    ##  Min.   : 7.267                   Min.   :2.833                            
    ##  1st Qu.:10.674                   1st Qu.:4.957                            
    ##  Median :11.355                   Median :5.666                            
    ##  Mean   :11.319                   Mean   :5.800                            
    ##  3rd Qu.:12.264                   3rd Qu.:6.374                            
    ##  Max.   :12.491                   Max.   :7.082                            
    ##  NA's   :1                        NA's   :1                                
    ##  Average Pedagogical Strategy Effectiveness Rating
    ##  Min.   :6.297                                    
    ##  1st Qu.:8.051                                    
    ##  Median :8.995                                    
    ##  Mean   :8.770                                    
    ##  3rd Qu.:9.715                                    
    ##  Max.   :9.895                                    
    ##  NA's   :1                                        
    ##  Project: Section 1-4: (20%) x/10 Project: Section 5-11: (50%) x/10
    ##  Min.   :0.000                    Min.   :0.000                    
    ##  1st Qu.:3.521                    1st Qu.:2.151                    
    ##  Median :4.044                    Median :2.797                    
    ##  Mean   :3.811                    Mean   :2.360                    
    ##  3rd Qu.:4.282                    3rd Qu.:2.976                    
    ##  Max.   :4.758                    Max.   :3.585                    
    ##                                                                    
    ##  Project: Section 12: (30%) x/5 Project: (10%): x/30 x 100 TOTAL
    ##  Min.   :0.0000                 Min.   :0.000                   
    ##  1st Qu.:0.0000                 1st Qu.:2.779                   
    ##  Median :0.0000                 Median :3.295                   
    ##  Mean   :0.5683                 Mean   :3.096                   
    ##  3rd Qu.:0.6998                 3rd Qu.:3.553                   
    ##  Max.   :2.7993                 Max.   :4.962                   
    ##  NA's   :1                                                      
    ##  Quiz 1 on Concept 1 (Introduction) x/32 Quiz 3 on Concept 3 (Linear) x/15
    ##  Min.   :0.7302                          Min.   :0.9661                   
    ##  1st Qu.:1.7724                          1st Qu.:2.2543                   
    ##  Median :2.3565                          Median :2.8984                   
    ##  Mean   :2.5144                          Mean   :3.0692                   
    ##  3rd Qu.:3.0175                          3rd Qu.:3.8646                   
    ##  Max.   :4.8038                          Max.   :4.8307                   
    ##                                          NA's   :2                        
    ##  Quiz 4 on Concept 4 (Non-Linear) x/22 Quiz 5 on Concept 5 (Dashboarding) x/10
    ##  Min.   :0.6769                        Min.   :0.000                          
    ##  1st Qu.:2.4628                        1st Qu.:2.381                          
    ##  Median :3.0461                        Median :3.014                          
    ##  Mean   :3.1444                        Mean   :3.032                          
    ##  3rd Qu.:3.9486                        3rd Qu.:3.809                          
    ##  Max.   :4.9640                        Max.   :6.033                          
    ##  NA's   :6                             NA's   :12                             
    ##  Quizzes and  Bonus Marks (7%): x/79 x 100 TOTAL
    ##  Min.   :1.592                                  
    ##  1st Qu.:2.657                                  
    ##  Median :3.353                                  
    ##  Mean   :3.408                                  
    ##  3rd Qu.:3.951                                  
    ##  Max.   :5.775                                  
    ##                                                 
    ##  Lab 1 - 2.c. - (Simple Linear Regression) x/5
    ##  Min.   : 7.634                               
    ##  1st Qu.:12.723                               
    ##  Median :12.723                               
    ##  Mean   :12.464                               
    ##  3rd Qu.:12.723                               
    ##  Max.   :12.723                               
    ##  NA's   :3                                    
    ##  Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5
    ##  Min.   :2.078                                                 
    ##  1st Qu.:3.044                                                 
    ##  Median :4.687                                                 
    ##  Mean   :4.026                                                 
    ##  3rd Qu.:4.832                                                 
    ##  Max.   :4.832                                                 
    ##  NA's   :6                                                     
    ##  Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5
    ##  Min.   :4.450                                                  
    ##  1st Qu.:7.572                                                  
    ##  Median :7.572                                                  
    ##  Mean   :7.229                                                  
    ##  3rd Qu.:7.572                                                  
    ##  Max.   :7.806                                                  
    ##  NA's   :9                                                      
    ##  Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5
    ##  Min.   :2.054                                    
    ##  1st Qu.:4.552                                    
    ##  Median :5.385                                    
    ##  Mean   :4.913                                    
    ##  3rd Qu.:5.551                                    
    ##  Max.   :5.551                                    
    ##  NA's   :18                                       
    ##  Lab 5 - Chart JS Dashboard Setup x/5 Lab Work (7%) x/25 x 100
    ##  Min.   :0.000                        Min.   :0.9221          
    ##  1st Qu.:0.000                        1st Qu.:3.6678          
    ##  Median :2.143                        Median :4.1444          
    ##  Mean   :1.459                        Mean   :4.1297          
    ##  3rd Qu.:2.143                        3rd Qu.:5.0355          
    ##  Max.   :2.143                        Max.   :5.1805          
    ##                                                               
    ##  CAT 1 (8%): x/38 x 100 CAT 2 (8%): x/100 x 100
    ##  Min.   :2.175          Min.   :0.000          
    ##  1st Qu.:3.915          1st Qu.:2.067          
    ##  Median :4.610          Median :2.574          
    ##  Mean   :4.588          Mean   :2.518          
    ##  3rd Qu.:5.480          3rd Qu.:3.314          
    ##  Max.   :6.437          Max.   :4.053          
    ##  NA's   :4              NA's   :31             
    ##  Attendance Waiver Granted: 1 = Yes, 0 = No Absenteeism Percentage
    ##  Min.   :0.0000                             Min.   :0.0000        
    ##  1st Qu.:0.0000                             1st Qu.:0.8153        
    ##  Median :0.0000                             Median :1.6295        
    ##  Mean   :0.2271                             Mean   :1.6961        
    ##  3rd Qu.:0.0000                             3rd Qu.:2.4448        
    ##  Max.   :4.5871                             Max.   :5.7049        
    ##                                                                   
    ##  Coursework TOTAL: x/40 (40%) EXAM: x/60 (60%)
    ##  Min.   :1.200                Min.   :0.4441  
    ##  1st Qu.:3.284                1st Qu.:2.3094  
    ##  Median :3.949                Median :3.0200  
    ##  Mean   :3.941                Mean   :3.0145  
    ##  3rd Qu.:4.709                3rd Qu.:3.7306  
    ##  Max.   :5.636                Max.   :4.9742  
    ##                               NA's   :4       
    ##  TOTAL = Coursework TOTAL + EXAM (100%)    GRADE          
    ##  Min.   :0.475                          Length:101        
    ##  1st Qu.:2.896                          Class :character  
    ##  Median :3.732                          Mode  :character  
    ##  Mean   :3.632                                            
    ##  3rd Qu.:4.377                                            
    ##  Max.   :5.578                                            
    ## 

``` r
student_datasetset_yield <- as.numeric(unlist(student_dataset_scale_transform[, 4]))
hist(student_datasetset_yield, main = names(student_dataset_scale_transform)[4])
```

![](Lab-Submission-Markdown_files/figure-gfm/code%20chunk%20three-2.png)<!-- -->

## STEP 4. Apply a Centre Data Transform —-

``` r
### The Centre Basic Transform on the StudentDataset ----
summary(StudentPerformanceDataset)
```

    ##  class_group            gender            YOB       regret_choosing_bi
    ##  Length:101         Min.   :0.0000   Min.   :1998   Min.   :0.0000    
    ##  Class :character   1st Qu.:0.0000   1st Qu.:2000   1st Qu.:0.0000    
    ##  Mode  :character   Median :1.0000   Median :2001   Median :0.0000    
    ##                     Mean   :0.5743   Mean   :2001   Mean   :0.0198    
    ##                     3rd Qu.:1.0000   3rd Qu.:2002   3rd Qu.:0.0000    
    ##                     Max.   :1.0000   Max.   :2003   Max.   :1.0000    
    ##                                                                       
    ##   drop_bi_now       motivator      read_content_before_lecture
    ##  Min.   :0.0000   Min.   :0.0000   Min.   :1.000              
    ##  1st Qu.:0.0000   1st Qu.:1.0000   1st Qu.:2.000              
    ##  Median :0.0000   Median :1.0000   Median :3.000              
    ##  Mean   :0.0198   Mean   :0.7525   Mean   :2.752              
    ##  3rd Qu.:0.0000   3rd Qu.:1.0000   3rd Qu.:3.000              
    ##  Max.   :1.0000   Max.   :1.0000   Max.   :5.000              
    ##                                                               
    ##  anticipate_test_questions answer_rhetorical_questions find_terms_I_do_not_know
    ##  Min.   :1.000             Min.   :1.000               Min.   :1.000           
    ##  1st Qu.:3.000             1st Qu.:3.000               1st Qu.:3.000           
    ##  Median :4.000             Median :4.000               Median :4.000           
    ##  Mean   :3.584             Mean   :3.426               Mean   :3.743           
    ##  3rd Qu.:4.000             3rd Qu.:4.000               3rd Qu.:5.000           
    ##  Max.   :5.000             Max.   :5.000               Max.   :5.000           
    ##                                                                                
    ##  copy_new_terms_in_reading_notebook take_quizzes_and_use_results
    ##  Min.   :1.000                      Min.   :1.000               
    ##  1st Qu.:3.000                      1st Qu.:3.000               
    ##  Median :4.000                      Median :4.000               
    ##  Mean   :3.663                      Mean   :3.941               
    ##  3rd Qu.:4.000                      3rd Qu.:5.000               
    ##  Max.   :5.000                      Max.   :5.000               
    ##                                                                 
    ##  reorganise_course_outline write_down_important_points space_out_revision
    ##  Min.   :1.000             Min.   :1.000               Min.   :1.000     
    ##  1st Qu.:3.000             1st Qu.:3.000               1st Qu.:3.000     
    ##  Median :3.000             Median :4.000               Median :3.000     
    ##  Mean   :3.376             Mean   :3.832               Mean   :3.228     
    ##  3rd Qu.:4.000             3rd Qu.:5.000               3rd Qu.:4.000     
    ##  Max.   :5.000             Max.   :5.000               Max.   :5.000     
    ##                                                                          
    ##  studying_in_study_group schedule_appointments goal_oriented  
    ##  Min.   :1.000           Min.   :1.000         Min.   :0.000  
    ##  1st Qu.:1.000           1st Qu.:1.000         1st Qu.:0.000  
    ##  Median :2.000           Median :2.000         Median :0.000  
    ##  Mean   :2.455           Mean   :1.931         Mean   :0.198  
    ##  3rd Qu.:3.000           3rd Qu.:2.000         3rd Qu.:0.000  
    ##  Max.   :5.000           Max.   :5.000         Max.   :1.000  
    ##                                                               
    ##  spaced_repetition testing_and_active_recall  interleaving    categorizing  
    ##  Min.   :1.000     Min.   :1.000             Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:2.000     1st Qu.:3.000             1st Qu.:2.000   1st Qu.:2.000  
    ##  Median :3.000     Median :3.000             Median :2.000   Median :3.000  
    ##  Mean   :2.554     Mean   :3.059             Mean   :2.257   Mean   :2.713  
    ##  3rd Qu.:3.000     3rd Qu.:4.000             3rd Qu.:3.000   3rd Qu.:3.000  
    ##  Max.   :4.000     Max.   :4.000             Max.   :4.000   Max.   :4.000  
    ##                                                                             
    ##  retrospective_timetable cornell_notes        sq3r          commute    
    ##  Min.   :1.000           Min.   :1.000   Min.   :1.000   Min.   :1.00  
    ##  1st Qu.:2.000           1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.00  
    ##  Median :2.000           Median :3.000   Median :3.000   Median :3.00  
    ##  Mean   :2.406           Mean   :2.545   Mean   :2.614   Mean   :2.73  
    ##  3rd Qu.:3.000           3rd Qu.:3.000   3rd Qu.:3.000   3rd Qu.:4.00  
    ##  Max.   :4.000           Max.   :4.000   Max.   :4.000   Max.   :4.00  
    ##                                                          NA's   :1     
    ##    study_time   repeats_since_Y1  paid_tuition   free_tuition  extra_curricular
    ##  Min.   :1.00   Min.   : 0.00    Min.   :0.00   Min.   :0.00   Min.   :0.00    
    ##  1st Qu.:1.00   1st Qu.: 0.00    1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00    
    ##  Median :2.00   Median : 2.00    Median :0.00   Median :0.00   Median :1.00    
    ##  Mean   :1.75   Mean   : 2.05    Mean   :0.11   Mean   :0.27   Mean   :0.53    
    ##  3rd Qu.:2.00   3rd Qu.: 3.00    3rd Qu.:0.00   3rd Qu.:1.00   3rd Qu.:1.00    
    ##  Max.   :4.00   Max.   :10.00    Max.   :1.00   Max.   :1.00   Max.   :1.00    
    ##  NA's   :1      NA's   :1        NA's   :1      NA's   :1      NA's   :1       
    ##  sports_extra_curricular exercise_per_week    meditate         pray     
    ##  Min.   :0.00            Min.   :0.0       Min.   :0.00   Min.   :0.00  
    ##  1st Qu.:0.00            1st Qu.:1.0       1st Qu.:0.00   1st Qu.:1.00  
    ##  Median :0.00            Median :1.0       Median :1.00   Median :2.00  
    ##  Mean   :0.36            Mean   :1.1       Mean   :0.76   Mean   :2.09  
    ##  3rd Qu.:1.00            3rd Qu.:2.0       3rd Qu.:1.00   3rd Qu.:3.00  
    ##  Max.   :1.00            Max.   :3.0       Max.   :3.00   Max.   :3.00  
    ##  NA's   :1               NA's   :1         NA's   :1      NA's   :1     
    ##     internet        laptop  family_relationships  friendships  
    ##  Min.   :0.00   Min.   :1   Min.   :2.00         Min.   :2.00  
    ##  1st Qu.:1.00   1st Qu.:1   1st Qu.:4.00         1st Qu.:4.00  
    ##  Median :1.00   Median :1   Median :4.00         Median :4.00  
    ##  Mean   :0.87   Mean   :1   Mean   :4.19         Mean   :4.01  
    ##  3rd Qu.:1.00   3rd Qu.:1   3rd Qu.:5.00         3rd Qu.:4.00  
    ##  Max.   :1.00   Max.   :1   Max.   :5.00         Max.   :5.00  
    ##  NA's   :1      NA's   :1   NA's   :1            NA's   :1     
    ##  romantic_relationships spiritual_wellnes financial_wellness     health    
    ##  Min.   :0.00           Min.   :1.00      Min.   :1.00       Min.   :1.00  
    ##  1st Qu.:0.00           1st Qu.:3.00      1st Qu.:2.00       1st Qu.:3.00  
    ##  Median :0.00           Median :4.00      Median :3.00       Median :4.00  
    ##  Mean   :1.37           Mean   :3.65      Mean   :3.03       Mean   :4.04  
    ##  3rd Qu.:3.00           3rd Qu.:4.00      3rd Qu.:4.00       3rd Qu.:5.00  
    ##  Max.   :4.00           Max.   :5.00      Max.   :5.00       Max.   :5.00  
    ##  NA's   :1              NA's   :1         NA's   :1          NA's   :1     
    ##     day_out      night_out    alcohol_or_narcotics     mentor    
    ##  Min.   :0.0   Min.   :0.00   Min.   :0.00         Min.   :0.00  
    ##  1st Qu.:0.0   1st Qu.:0.00   1st Qu.:0.00         1st Qu.:0.00  
    ##  Median :1.0   Median :0.00   Median :0.00         Median :0.00  
    ##  Mean   :0.8   Mean   :0.51   Mean   :0.35         Mean   :0.41  
    ##  3rd Qu.:1.0   3rd Qu.:1.00   3rd Qu.:1.00         3rd Qu.:1.00  
    ##  Max.   :3.0   Max.   :3.00   Max.   :3.00         Max.   :1.00  
    ##  NA's   :1     NA's   :1      NA's   :1            NA's   :1     
    ##  mentor_meetings A - 1. I am enjoying the subject
    ##  Min.   :0.00    Min.   :3.00                    
    ##  1st Qu.:0.00    1st Qu.:4.00                    
    ##  Median :0.00    Median :5.00                    
    ##  Mean   :0.68    Mean   :4.49                    
    ##  3rd Qu.:1.00    3rd Qu.:5.00                    
    ##  Max.   :3.00    Max.   :5.00                    
    ##  NA's   :1       NA's   :1                       
    ##  A - 2. Classes start and end on time
    ##  Min.   :3.00                        
    ##  1st Qu.:4.00                        
    ##  Median :5.00                        
    ##  Mean   :4.68                        
    ##  3rd Qu.:5.00                        
    ##  Max.   :5.00                        
    ##  NA's   :1                           
    ##  A - 3. The learning environment is participative, involves learning by doing and is group-based
    ##  Min.   :3.00                                                                                   
    ##  1st Qu.:4.00                                                                                   
    ##  Median :4.00                                                                                   
    ##  Mean   :4.35                                                                                   
    ##  3rd Qu.:5.00                                                                                   
    ##  Max.   :5.00                                                                                   
    ##  NA's   :1                                                                                      
    ##  A - 4. The subject content is delivered according to the course outline and meets my expectations
    ##  Min.   :3.00                                                                                     
    ##  1st Qu.:4.75                                                                                     
    ##  Median :5.00                                                                                     
    ##  Mean   :4.74                                                                                     
    ##  3rd Qu.:5.00                                                                                     
    ##  Max.   :5.00                                                                                     
    ##  NA's   :1                                                                                        
    ##  A - 5. The topics are clear and logically developed
    ##  Min.   :2.00                                       
    ##  1st Qu.:4.00                                       
    ##  Median :5.00                                       
    ##  Mean   :4.65                                       
    ##  3rd Qu.:5.00                                       
    ##  Max.   :5.00                                       
    ##  NA's   :1                                          
    ##  A - 6. I am developing my oral and writing skills
    ##  Min.   :1.00                                     
    ##  1st Qu.:4.00                                     
    ##  Median :4.00                                     
    ##  Mean   :4.11                                     
    ##  3rd Qu.:5.00                                     
    ##  Max.   :5.00                                     
    ##  NA's   :1                                        
    ##  A - 7. I am developing my reflective and critical reasoning skills
    ##  Min.   :2.00                                                      
    ##  1st Qu.:4.00                                                      
    ##  Median :4.00                                                      
    ##  Mean   :4.38                                                      
    ##  3rd Qu.:5.00                                                      
    ##  Max.   :5.00                                                      
    ##  NA's   :1                                                         
    ##  A - 8. The assessment methods are assisting me to learn
    ##  Min.   :1.00                                           
    ##  1st Qu.:4.00                                           
    ##  Median :5.00                                           
    ##  Mean   :4.61                                           
    ##  3rd Qu.:5.00                                           
    ##  Max.   :5.00                                           
    ##  NA's   :1                                              
    ##  A - 9. I receive relevant feedback
    ##  Min.   :3.00                      
    ##  1st Qu.:4.00                      
    ##  Median :5.00                      
    ##  Mean   :4.58                      
    ##  3rd Qu.:5.00                      
    ##  Max.   :5.00                      
    ##  NA's   :1                         
    ##  A - 10. I read the recommended readings and notes
    ##  Min.   :3.00                                     
    ##  1st Qu.:4.00                                     
    ##  Median :5.00                                     
    ##  Mean   :4.55                                     
    ##  3rd Qu.:5.00                                     
    ##  Max.   :5.00                                     
    ##  NA's   :1                                        
    ##  A - 11. I use the eLearning material posted
    ##  Min.   :3.0                                
    ##  1st Qu.:4.0                                
    ##  Median :5.0                                
    ##  Mean   :4.7                                
    ##  3rd Qu.:5.0                                
    ##  Max.   :5.0                                
    ##  NA's   :1                                  
    ##  B - 1. Concept 1 of 6: Principles of Business Intelligence and the DataOps Philosophy
    ##  Min.   :1.00                                                                         
    ##  1st Qu.:4.00                                                                         
    ##  Median :4.00                                                                         
    ##  Mean   :4.25                                                                         
    ##  3rd Qu.:5.00                                                                         
    ##  Max.   :5.00                                                                         
    ##  NA's   :1                                                                            
    ##  B - 2. Concept 3 of 6: Linear Algorithms for Predictive Analytics
    ##  Min.   :2.00                                                     
    ##  1st Qu.:3.00                                                     
    ##  Median :4.00                                                     
    ##  Mean   :3.94                                                     
    ##  3rd Qu.:5.00                                                     
    ##  Max.   :5.00                                                     
    ##  NA's   :1                                                        
    ##  C - 2. Quizzes at the end of each concept
    ##  Min.   :2.00                             
    ##  1st Qu.:4.00                             
    ##  Median :5.00                             
    ##  Mean   :4.59                             
    ##  3rd Qu.:5.00                             
    ##  Max.   :5.00                             
    ##  NA's   :1                                
    ##  C - 3. Lab manuals that outline the steps to follow during the labs
    ##  Min.   :3.00                                                       
    ##  1st Qu.:4.00                                                       
    ##  Median :5.00                                                       
    ##  Mean   :4.61                                                       
    ##  3rd Qu.:5.00                                                       
    ##  Max.   :5.00                                                       
    ##  NA's   :1                                                          
    ##  C - 4. Required lab work submissions at the end of each lab manual that outline the activity to be done on your own
    ##  Min.   :3.00                                                                                                       
    ##  1st Qu.:4.00                                                                                                       
    ##  Median :5.00                                                                                                       
    ##  Mean   :4.55                                                                                                       
    ##  3rd Qu.:5.00                                                                                                       
    ##  Max.   :5.00                                                                                                       
    ##  NA's   :1                                                                                                          
    ##  C - 5. Supplementary videos to watch
    ##  Min.   :1.00                        
    ##  1st Qu.:4.00                        
    ##  Median :4.00                        
    ##  Mean   :4.19                        
    ##  3rd Qu.:5.00                        
    ##  Max.   :5.00                        
    ##  NA's   :1                           
    ##  C - 6. Supplementary podcasts to listen to
    ##  Min.   :1.00                              
    ##  1st Qu.:4.00                              
    ##  Median :4.00                              
    ##  Mean   :4.08                              
    ##  3rd Qu.:5.00                              
    ##  Max.   :5.00                              
    ##  NA's   :1                                 
    ##  C - 7. Supplementary content to read C - 8. Lectures slides
    ##  Min.   :1.00                         Min.   :2.0           
    ##  1st Qu.:4.00                         1st Qu.:4.0           
    ##  Median :4.00                         Median :5.0           
    ##  Mean   :4.17                         Mean   :4.6           
    ##  3rd Qu.:5.00                         3rd Qu.:5.0           
    ##  Max.   :5.00                         Max.   :5.0           
    ##  NA's   :1                            NA's   :1             
    ##  C - 9. Lecture notes on some of the lecture slides
    ##  Min.   :2.0                                       
    ##  1st Qu.:4.0                                       
    ##  Median :5.0                                       
    ##  Mean   :4.6                                       
    ##  3rd Qu.:5.0                                       
    ##  Max.   :5.0                                       
    ##  NA's   :1                                         
    ##  C - 10. The quality of the lectures given (quality measured by the breadth (the full span of knowledge of a subject) and depth (the extent to which specific topics are focused upon, amplified, and explored) of learning - NOT quality measured by how fun/comical/lively the lectures are)
    ##  Min.   :2.00                                                                                                                                                                                                                                                                                 
    ##  1st Qu.:4.00                                                                                                                                                                                                                                                                                 
    ##  Median :5.00                                                                                                                                                                                                                                                                                 
    ##  Mean   :4.54                                                                                                                                                                                                                                                                                 
    ##  3rd Qu.:5.00                                                                                                                                                                                                                                                                                 
    ##  Max.   :5.00                                                                                                                                                                                                                                                                                 
    ##  NA's   :1                                                                                                                                                                                                                                                                                    
    ##  C - 11. The division of theory and practice such that most of the theory is done during the recorded online classes and most of the practice is done during the physical classes
    ##  Min.   :2.00                                                                                                                                                                    
    ##  1st Qu.:4.00                                                                                                                                                                    
    ##  Median :5.00                                                                                                                                                                    
    ##  Mean   :4.49                                                                                                                                                                    
    ##  3rd Qu.:5.00                                                                                                                                                                    
    ##  Max.   :5.00                                                                                                                                                                    
    ##  NA's   :1                                                                                                                                                                       
    ##  C - 12. The recordings of online classes
    ##  Min.   :2.00                            
    ##  1st Qu.:4.00                            
    ##  Median :5.00                            
    ##  Mean   :4.33                            
    ##  3rd Qu.:5.00                            
    ##  Max.   :5.00                            
    ##  NA's   :1                               
    ##  D - 1. Write two things you like about the teaching and learning in this unit so far.
    ##  Length:101                                                                           
    ##  Class :character                                                                     
    ##  Mode  :character                                                                     
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##  D - 2. Write at least one recommendation to improve the teaching and learning in this unit (for the remaining weeks in the semester)
    ##  Length:101                                                                                                                          
    ##  Class :character                                                                                                                    
    ##  Mode  :character                                                                                                                    
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##  Average Course Evaluation Rating Average Level of Learning Attained Rating
    ##  Min.   :2.909                    Min.   :2.000                            
    ##  1st Qu.:4.273                    1st Qu.:3.500                            
    ##  Median :4.545                    Median :4.000                            
    ##  Mean   :4.531                    Mean   :4.095                            
    ##  3rd Qu.:4.909                    3rd Qu.:4.500                            
    ##  Max.   :5.000                    Max.   :5.000                            
    ##  NA's   :1                        NA's   :1                                
    ##  Average Pedagogical Strategy Effectiveness Rating
    ##  Min.   :3.182                                    
    ##  1st Qu.:4.068                                    
    ##  Median :4.545                                    
    ##  Mean   :4.432                                    
    ##  3rd Qu.:4.909                                    
    ##  Max.   :5.000                                    
    ##  NA's   :1                                        
    ##  Project: Section 1-4: (20%) x/10 Project: Section 5-11: (50%) x/10
    ##  Min.   : 0.000                   Min.   : 0.000                   
    ##  1st Qu.: 7.400                   1st Qu.: 6.000                   
    ##  Median : 8.500                   Median : 7.800                   
    ##  Mean   : 8.011                   Mean   : 6.582                   
    ##  3rd Qu.: 9.000                   3rd Qu.: 8.300                   
    ##  Max.   :10.000                   Max.   :10.000                   
    ##                                                                    
    ##  Project: Section 12: (30%) x/5 Project: (10%): x/30 x 100 TOTAL
    ##  Min.   :0.000                  Min.   :  0.00                  
    ##  1st Qu.:0.000                  1st Qu.: 56.00                  
    ##  Median :0.000                  Median : 66.40                  
    ##  Mean   :1.015                  Mean   : 62.39                  
    ##  3rd Qu.:1.250                  3rd Qu.: 71.60                  
    ##  Max.   :5.000                  Max.   :100.00                  
    ##  NA's   :1                                                      
    ##  Quiz 1 on Concept 1 (Introduction) x/32 Quiz 3 on Concept 3 (Linear) x/15
    ##  Min.   : 4.75                           Min.   : 3.00                    
    ##  1st Qu.:11.53                           1st Qu.: 7.00                    
    ##  Median :15.33                           Median : 9.00                    
    ##  Mean   :16.36                           Mean   : 9.53                    
    ##  3rd Qu.:19.63                           3rd Qu.:12.00                    
    ##  Max.   :31.25                           Max.   :15.00                    
    ##                                          NA's   :2                        
    ##  Quiz 4 on Concept 4 (Non-Linear) x/22 Quiz 5 on Concept 5 (Dashboarding) x/10
    ##  Min.   : 3.00                         Min.   : 0.000                         
    ##  1st Qu.:10.91                         1st Qu.: 5.000                         
    ##  Median :13.50                         Median : 6.330                         
    ##  Mean   :13.94                         Mean   : 6.367                         
    ##  3rd Qu.:17.50                         3rd Qu.: 8.000                         
    ##  Max.   :22.00                         Max.   :12.670                         
    ##  NA's   :6                             NA's   :12                             
    ##  Quizzes and  Bonus Marks (7%): x/79 x 100 TOTAL
    ##  Min.   :26.26                                  
    ##  1st Qu.:43.82                                  
    ##  Median :55.31                                  
    ##  Mean   :56.22                                  
    ##  3rd Qu.:65.16                                  
    ##  Max.   :95.25                                  
    ##                                                 
    ##  Lab 1 - 2.c. - (Simple Linear Regression) x/5
    ##  Min.   :3.000                                
    ##  1st Qu.:5.000                                
    ##  Median :5.000                                
    ##  Mean   :4.898                                
    ##  3rd Qu.:5.000                                
    ##  Max.   :5.000                                
    ##  NA's   :3                                    
    ##  Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5
    ##  Min.   :2.150                                                 
    ##  1st Qu.:3.150                                                 
    ##  Median :4.850                                                 
    ##  Mean   :4.166                                                 
    ##  3rd Qu.:5.000                                                 
    ##  Max.   :5.000                                                 
    ##  NA's   :6                                                     
    ##  Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5
    ##  Min.   :2.85                                                   
    ##  1st Qu.:4.85                                                   
    ##  Median :4.85                                                   
    ##  Mean   :4.63                                                   
    ##  3rd Qu.:4.85                                                   
    ##  Max.   :5.00                                                   
    ##  NA's   :9                                                      
    ##  Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5
    ##  Min.   :1.850                                    
    ##  1st Qu.:4.100                                    
    ##  Median :4.850                                    
    ##  Mean   :4.425                                    
    ##  3rd Qu.:5.000                                    
    ##  Max.   :5.000                                    
    ##  NA's   :18                                       
    ##  Lab 5 - Chart JS Dashboard Setup x/5 Lab Work (7%) x/25 x 100
    ##  Min.   :0.000                        Min.   : 17.80          
    ##  1st Qu.:0.000                        1st Qu.: 70.80          
    ##  Median :5.000                        Median : 80.00          
    ##  Mean   :3.404                        Mean   : 79.72          
    ##  3rd Qu.:5.000                        3rd Qu.: 97.20          
    ##  Max.   :5.000                        Max.   :100.00          
    ##                                                               
    ##  CAT 1 (8%): x/38 x 100 CAT 2 (8%): x/100 x 100
    ##  Min.   :32.89          Min.   :  0.00         
    ##  1st Qu.:59.21          1st Qu.: 51.00         
    ##  Median :69.73          Median : 63.50         
    ##  Mean   :69.39          Mean   : 62.13         
    ##  3rd Qu.:82.89          3rd Qu.: 81.75         
    ##  Max.   :97.36          Max.   :100.00         
    ##  NA's   :4              NA's   :31             
    ##  Attendance Waiver Granted: 1 = Yes, 0 = No Absenteeism Percentage
    ##  Min.   :0.00000                            Min.   : 0.00         
    ##  1st Qu.:0.00000                            1st Qu.: 7.41         
    ##  Median :0.00000                            Median :14.81         
    ##  Mean   :0.04951                            Mean   :15.42         
    ##  3rd Qu.:0.00000                            3rd Qu.:22.22         
    ##  Max.   :1.00000                            Max.   :51.85         
    ##                                                                   
    ##  Coursework TOTAL: x/40 (40%) EXAM: x/60 (60%)
    ##  Min.   : 7.47                Min.   : 5.00   
    ##  1st Qu.:20.44                1st Qu.:26.00   
    ##  Median :24.58                Median :34.00   
    ##  Mean   :24.53                Mean   :33.94   
    ##  3rd Qu.:29.31                3rd Qu.:42.00   
    ##  Max.   :35.08                Max.   :56.00   
    ##                               NA's   :4       
    ##  TOTAL = Coursework TOTAL + EXAM (100%)    GRADE          
    ##  Min.   : 7.47                          Length:101        
    ##  1st Qu.:45.54                          Class :character  
    ##  Median :58.69                          Mode  :character  
    ##  Mean   :57.12                                            
    ##  3rd Qu.:68.83                                            
    ##  Max.   :87.72                                            
    ## 

``` r
model_of_the_transform <- preProcess(StudentPerformanceDataset, method = c("center"))
print(model_of_the_transform)
```

    ## Created from 51 samples and 100 variables
    ## 
    ## Pre-processing:
    ##   - centered (96)
    ##   - ignored (4)

``` r
student_dataset_center_transform <- predict(model_of_the_transform, StudentPerformanceDataset)
summary(student_dataset_center_transform)
```

    ##  class_group            gender             YOB           regret_choosing_bi
    ##  Length:101         Min.   :-0.5743   Min.   :-2.90099   Min.   :-0.0198   
    ##  Class :character   1st Qu.:-0.5743   1st Qu.:-0.90099   1st Qu.:-0.0198   
    ##  Mode  :character   Median : 0.4257   Median : 0.09901   Median :-0.0198   
    ##                     Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.0000   
    ##                     3rd Qu.: 0.4257   3rd Qu.: 1.09901   3rd Qu.:-0.0198   
    ##                     Max.   : 0.4257   Max.   : 2.09901   Max.   : 0.9802   
    ##                                                                            
    ##   drop_bi_now        motivator       read_content_before_lecture
    ##  Min.   :-0.0198   Min.   :-0.7525   Min.   :-1.7525            
    ##  1st Qu.:-0.0198   1st Qu.: 0.2475   1st Qu.:-0.7525            
    ##  Median :-0.0198   Median : 0.2475   Median : 0.2475            
    ##  Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000            
    ##  3rd Qu.:-0.0198   3rd Qu.: 0.2475   3rd Qu.: 0.2475            
    ##  Max.   : 0.9802   Max.   : 0.2475   Max.   : 2.2475            
    ##                                                                 
    ##  anticipate_test_questions answer_rhetorical_questions find_terms_I_do_not_know
    ##  Min.   :-2.5842           Min.   :-2.4257             Min.   :-2.7426         
    ##  1st Qu.:-0.5842           1st Qu.:-0.4257             1st Qu.:-0.7426         
    ##  Median : 0.4158           Median : 0.5743             Median : 0.2574         
    ##  Mean   : 0.0000           Mean   : 0.0000             Mean   : 0.0000         
    ##  3rd Qu.: 0.4158           3rd Qu.: 0.5743             3rd Qu.: 1.2574         
    ##  Max.   : 1.4158           Max.   : 1.5743             Max.   : 1.2574         
    ##                                                                                
    ##  copy_new_terms_in_reading_notebook take_quizzes_and_use_results
    ##  Min.   :-2.6634                    Min.   :-2.94059            
    ##  1st Qu.:-0.6634                    1st Qu.:-0.94059            
    ##  Median : 0.3366                    Median : 0.05941            
    ##  Mean   : 0.0000                    Mean   : 0.00000            
    ##  3rd Qu.: 0.3366                    3rd Qu.: 1.05941            
    ##  Max.   : 1.3366                    Max.   : 1.05941            
    ##                                                                 
    ##  reorganise_course_outline write_down_important_points space_out_revision
    ##  Min.   :-2.3762           Min.   :-2.8317             Min.   :-2.2277   
    ##  1st Qu.:-0.3762           1st Qu.:-0.8317             1st Qu.:-0.2277   
    ##  Median :-0.3762           Median : 0.1683             Median :-0.2277   
    ##  Mean   : 0.0000           Mean   : 0.0000             Mean   : 0.0000   
    ##  3rd Qu.: 0.6238           3rd Qu.: 1.1683             3rd Qu.: 0.7723   
    ##  Max.   : 1.6238           Max.   : 1.1683             Max.   : 1.7723   
    ##                                                                          
    ##  studying_in_study_group schedule_appointments goal_oriented   
    ##  Min.   :-1.4554         Min.   :-0.93069      Min.   :-0.198  
    ##  1st Qu.:-1.4554         1st Qu.:-0.93069      1st Qu.:-0.198  
    ##  Median :-0.4554         Median : 0.06931      Median :-0.198  
    ##  Mean   : 0.0000         Mean   : 0.00000      Mean   : 0.000  
    ##  3rd Qu.: 0.5446         3rd Qu.: 0.06931      3rd Qu.:-0.198  
    ##  Max.   : 2.5446         Max.   : 3.06931      Max.   : 0.802  
    ##                                                                
    ##  spaced_repetition testing_and_active_recall  interleaving    
    ##  Min.   :-1.5545   Min.   :-2.05941          Min.   :-1.2574  
    ##  1st Qu.:-0.5545   1st Qu.:-0.05941          1st Qu.:-0.2574  
    ##  Median : 0.4455   Median :-0.05941          Median :-0.2574  
    ##  Mean   : 0.0000   Mean   : 0.00000          Mean   : 0.0000  
    ##  3rd Qu.: 0.4455   3rd Qu.: 0.94059          3rd Qu.: 0.7426  
    ##  Max.   : 1.4455   Max.   : 0.94059          Max.   : 1.7426  
    ##                                                               
    ##   categorizing     retrospective_timetable cornell_notes          sq3r        
    ##  Min.   :-1.7129   Min.   :-1.4059         Min.   :-1.5446   Min.   :-1.6139  
    ##  1st Qu.:-0.7129   1st Qu.:-0.4059         1st Qu.:-0.5446   1st Qu.:-0.6139  
    ##  Median : 0.2871   Median :-0.4059         Median : 0.4554   Median : 0.3861  
    ##  Mean   : 0.0000   Mean   : 0.0000         Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 0.2871   3rd Qu.: 0.5941         3rd Qu.: 0.4554   3rd Qu.: 0.3861  
    ##  Max.   : 1.2871   Max.   : 1.5941         Max.   : 1.4554   Max.   : 1.3861  
    ##                                                                               
    ##     commute        study_time    repeats_since_Y1  paid_tuition  
    ##  Min.   :-1.73   Min.   :-0.75   Min.   :-2.05    Min.   :-0.11  
    ##  1st Qu.:-0.73   1st Qu.:-0.75   1st Qu.:-2.05    1st Qu.:-0.11  
    ##  Median : 0.27   Median : 0.25   Median :-0.05    Median :-0.11  
    ##  Mean   : 0.00   Mean   : 0.00   Mean   : 0.00    Mean   : 0.00  
    ##  3rd Qu.: 1.27   3rd Qu.: 0.25   3rd Qu.: 0.95    3rd Qu.:-0.11  
    ##  Max.   : 1.27   Max.   : 2.25   Max.   : 7.95    Max.   : 0.89  
    ##  NA's   :1       NA's   :1       NA's   :1        NA's   :1      
    ##   free_tuition   extra_curricular sports_extra_curricular exercise_per_week
    ##  Min.   :-0.27   Min.   :-0.53    Min.   :-0.36           Min.   :-1.1     
    ##  1st Qu.:-0.27   1st Qu.:-0.53    1st Qu.:-0.36           1st Qu.:-0.1     
    ##  Median :-0.27   Median : 0.47    Median :-0.36           Median :-0.1     
    ##  Mean   : 0.00   Mean   : 0.00    Mean   : 0.00           Mean   : 0.0     
    ##  3rd Qu.: 0.73   3rd Qu.: 0.47    3rd Qu.: 0.64           3rd Qu.: 0.9     
    ##  Max.   : 0.73   Max.   : 0.47    Max.   : 0.64           Max.   : 1.9     
    ##  NA's   :1       NA's   :1        NA's   :1               NA's   :1        
    ##     meditate          pray          internet         laptop 
    ##  Min.   :-0.76   Min.   :-2.09   Min.   :-0.87   Min.   :0  
    ##  1st Qu.:-0.76   1st Qu.:-1.09   1st Qu.: 0.13   1st Qu.:0  
    ##  Median : 0.24   Median :-0.09   Median : 0.13   Median :0  
    ##  Mean   : 0.00   Mean   : 0.00   Mean   : 0.00   Mean   :0  
    ##  3rd Qu.: 0.24   3rd Qu.: 0.91   3rd Qu.: 0.13   3rd Qu.:0  
    ##  Max.   : 2.24   Max.   : 0.91   Max.   : 0.13   Max.   :0  
    ##  NA's   :1       NA's   :1       NA's   :1       NA's   :1  
    ##  family_relationships  friendships    romantic_relationships spiritual_wellnes
    ##  Min.   :-2.19        Min.   :-2.01   Min.   :-1.37          Min.   :-2.65    
    ##  1st Qu.:-0.19        1st Qu.:-0.01   1st Qu.:-1.37          1st Qu.:-0.65    
    ##  Median :-0.19        Median :-0.01   Median :-1.37          Median : 0.35    
    ##  Mean   : 0.00        Mean   : 0.00   Mean   : 0.00          Mean   : 0.00    
    ##  3rd Qu.: 0.81        3rd Qu.:-0.01   3rd Qu.: 1.63          3rd Qu.: 0.35    
    ##  Max.   : 0.81        Max.   : 0.99   Max.   : 2.63          Max.   : 1.35    
    ##  NA's   :1            NA's   :1       NA's   :1              NA's   :1        
    ##  financial_wellness     health         day_out       night_out    
    ##  Min.   :-2.03      Min.   :-3.04   Min.   :-0.8   Min.   :-0.51  
    ##  1st Qu.:-1.03      1st Qu.:-1.04   1st Qu.:-0.8   1st Qu.:-0.51  
    ##  Median :-0.03      Median :-0.04   Median : 0.2   Median :-0.51  
    ##  Mean   : 0.00      Mean   : 0.00   Mean   : 0.0   Mean   : 0.00  
    ##  3rd Qu.: 0.97      3rd Qu.: 0.96   3rd Qu.: 0.2   3rd Qu.: 0.49  
    ##  Max.   : 1.97      Max.   : 0.96   Max.   : 2.2   Max.   : 2.49  
    ##  NA's   :1          NA's   :1       NA's   :1      NA's   :1      
    ##  alcohol_or_narcotics     mentor      mentor_meetings
    ##  Min.   :-0.35        Min.   :-0.41   Min.   :-0.68  
    ##  1st Qu.:-0.35        1st Qu.:-0.41   1st Qu.:-0.68  
    ##  Median :-0.35        Median :-0.41   Median :-0.68  
    ##  Mean   : 0.00        Mean   : 0.00   Mean   : 0.00  
    ##  3rd Qu.: 0.65        3rd Qu.: 0.59   3rd Qu.: 0.32  
    ##  Max.   : 2.65        Max.   : 0.59   Max.   : 2.32  
    ##  NA's   :1            NA's   :1       NA's   :1      
    ##  A - 1. I am enjoying the subject A - 2. Classes start and end on time
    ##  Min.   :-1.49                    Min.   :-1.68                       
    ##  1st Qu.:-0.49                    1st Qu.:-0.68                       
    ##  Median : 0.51                    Median : 0.32                       
    ##  Mean   : 0.00                    Mean   : 0.00                       
    ##  3rd Qu.: 0.51                    3rd Qu.: 0.32                       
    ##  Max.   : 0.51                    Max.   : 0.32                       
    ##  NA's   :1                        NA's   :1                           
    ##  A - 3. The learning environment is participative, involves learning by doing and is group-based
    ##  Min.   :-1.35                                                                                  
    ##  1st Qu.:-0.35                                                                                  
    ##  Median :-0.35                                                                                  
    ##  Mean   : 0.00                                                                                  
    ##  3rd Qu.: 0.65                                                                                  
    ##  Max.   : 0.65                                                                                  
    ##  NA's   :1                                                                                      
    ##  A - 4. The subject content is delivered according to the course outline and meets my expectations
    ##  Min.   :-1.74                                                                                    
    ##  1st Qu.: 0.01                                                                                    
    ##  Median : 0.26                                                                                    
    ##  Mean   : 0.00                                                                                    
    ##  3rd Qu.: 0.26                                                                                    
    ##  Max.   : 0.26                                                                                    
    ##  NA's   :1                                                                                        
    ##  A - 5. The topics are clear and logically developed
    ##  Min.   :-2.65                                      
    ##  1st Qu.:-0.65                                      
    ##  Median : 0.35                                      
    ##  Mean   : 0.00                                      
    ##  3rd Qu.: 0.35                                      
    ##  Max.   : 0.35                                      
    ##  NA's   :1                                          
    ##  A - 6. I am developing my oral and writing skills
    ##  Min.   :-3.11                                    
    ##  1st Qu.:-0.11                                    
    ##  Median :-0.11                                    
    ##  Mean   : 0.00                                    
    ##  3rd Qu.: 0.89                                    
    ##  Max.   : 0.89                                    
    ##  NA's   :1                                        
    ##  A - 7. I am developing my reflective and critical reasoning skills
    ##  Min.   :-2.38                                                     
    ##  1st Qu.:-0.38                                                     
    ##  Median :-0.38                                                     
    ##  Mean   : 0.00                                                     
    ##  3rd Qu.: 0.62                                                     
    ##  Max.   : 0.62                                                     
    ##  NA's   :1                                                         
    ##  A - 8. The assessment methods are assisting me to learn
    ##  Min.   :-3.61                                          
    ##  1st Qu.:-0.61                                          
    ##  Median : 0.39                                          
    ##  Mean   : 0.00                                          
    ##  3rd Qu.: 0.39                                          
    ##  Max.   : 0.39                                          
    ##  NA's   :1                                              
    ##  A - 9. I receive relevant feedback
    ##  Min.   :-1.58                     
    ##  1st Qu.:-0.58                     
    ##  Median : 0.42                     
    ##  Mean   : 0.00                     
    ##  3rd Qu.: 0.42                     
    ##  Max.   : 0.42                     
    ##  NA's   :1                         
    ##  A - 10. I read the recommended readings and notes
    ##  Min.   :-1.55                                    
    ##  1st Qu.:-0.55                                    
    ##  Median : 0.45                                    
    ##  Mean   : 0.00                                    
    ##  3rd Qu.: 0.45                                    
    ##  Max.   : 0.45                                    
    ##  NA's   :1                                        
    ##  A - 11. I use the eLearning material posted
    ##  Min.   :-1.7                               
    ##  1st Qu.:-0.7                               
    ##  Median : 0.3                               
    ##  Mean   : 0.0                               
    ##  3rd Qu.: 0.3                               
    ##  Max.   : 0.3                               
    ##  NA's   :1                                  
    ##  B - 1. Concept 1 of 6: Principles of Business Intelligence and the DataOps Philosophy
    ##  Min.   :-3.25                                                                        
    ##  1st Qu.:-0.25                                                                        
    ##  Median :-0.25                                                                        
    ##  Mean   : 0.00                                                                        
    ##  3rd Qu.: 0.75                                                                        
    ##  Max.   : 0.75                                                                        
    ##  NA's   :1                                                                            
    ##  B - 2. Concept 3 of 6: Linear Algorithms for Predictive Analytics
    ##  Min.   :-1.94                                                    
    ##  1st Qu.:-0.94                                                    
    ##  Median : 0.06                                                    
    ##  Mean   : 0.00                                                    
    ##  3rd Qu.: 1.06                                                    
    ##  Max.   : 1.06                                                    
    ##  NA's   :1                                                        
    ##  C - 2. Quizzes at the end of each concept
    ##  Min.   :-2.59                            
    ##  1st Qu.:-0.59                            
    ##  Median : 0.41                            
    ##  Mean   : 0.00                            
    ##  3rd Qu.: 0.41                            
    ##  Max.   : 0.41                            
    ##  NA's   :1                                
    ##  C - 3. Lab manuals that outline the steps to follow during the labs
    ##  Min.   :-1.61                                                      
    ##  1st Qu.:-0.61                                                      
    ##  Median : 0.39                                                      
    ##  Mean   : 0.00                                                      
    ##  3rd Qu.: 0.39                                                      
    ##  Max.   : 0.39                                                      
    ##  NA's   :1                                                          
    ##  C - 4. Required lab work submissions at the end of each lab manual that outline the activity to be done on your own
    ##  Min.   :-1.55                                                                                                      
    ##  1st Qu.:-0.55                                                                                                      
    ##  Median : 0.45                                                                                                      
    ##  Mean   : 0.00                                                                                                      
    ##  3rd Qu.: 0.45                                                                                                      
    ##  Max.   : 0.45                                                                                                      
    ##  NA's   :1                                                                                                          
    ##  C - 5. Supplementary videos to watch
    ##  Min.   :-3.19                       
    ##  1st Qu.:-0.19                       
    ##  Median :-0.19                       
    ##  Mean   : 0.00                       
    ##  3rd Qu.: 0.81                       
    ##  Max.   : 0.81                       
    ##  NA's   :1                           
    ##  C - 6. Supplementary podcasts to listen to
    ##  Min.   :-3.08                             
    ##  1st Qu.:-0.08                             
    ##  Median :-0.08                             
    ##  Mean   : 0.00                             
    ##  3rd Qu.: 0.92                             
    ##  Max.   : 0.92                             
    ##  NA's   :1                                 
    ##  C - 7. Supplementary content to read C - 8. Lectures slides
    ##  Min.   :-3.17                        Min.   :-2.6          
    ##  1st Qu.:-0.17                        1st Qu.:-0.6          
    ##  Median :-0.17                        Median : 0.4          
    ##  Mean   : 0.00                        Mean   : 0.0          
    ##  3rd Qu.: 0.83                        3rd Qu.: 0.4          
    ##  Max.   : 0.83                        Max.   : 0.4          
    ##  NA's   :1                            NA's   :1             
    ##  C - 9. Lecture notes on some of the lecture slides
    ##  Min.   :-2.6                                      
    ##  1st Qu.:-0.6                                      
    ##  Median : 0.4                                      
    ##  Mean   : 0.0                                      
    ##  3rd Qu.: 0.4                                      
    ##  Max.   : 0.4                                      
    ##  NA's   :1                                         
    ##  C - 10. The quality of the lectures given (quality measured by the breadth (the full span of knowledge of a subject) and depth (the extent to which specific topics are focused upon, amplified, and explored) of learning - NOT quality measured by how fun/comical/lively the lectures are)
    ##  Min.   :-2.54                                                                                                                                                                                                                                                                                
    ##  1st Qu.:-0.54                                                                                                                                                                                                                                                                                
    ##  Median : 0.46                                                                                                                                                                                                                                                                                
    ##  Mean   : 0.00                                                                                                                                                                                                                                                                                
    ##  3rd Qu.: 0.46                                                                                                                                                                                                                                                                                
    ##  Max.   : 0.46                                                                                                                                                                                                                                                                                
    ##  NA's   :1                                                                                                                                                                                                                                                                                    
    ##  C - 11. The division of theory and practice such that most of the theory is done during the recorded online classes and most of the practice is done during the physical classes
    ##  Min.   :-2.49                                                                                                                                                                   
    ##  1st Qu.:-0.49                                                                                                                                                                   
    ##  Median : 0.51                                                                                                                                                                   
    ##  Mean   : 0.00                                                                                                                                                                   
    ##  3rd Qu.: 0.51                                                                                                                                                                   
    ##  Max.   : 0.51                                                                                                                                                                   
    ##  NA's   :1                                                                                                                                                                       
    ##  C - 12. The recordings of online classes
    ##  Min.   :-2.33                           
    ##  1st Qu.:-0.33                           
    ##  Median : 0.67                           
    ##  Mean   : 0.00                           
    ##  3rd Qu.: 0.67                           
    ##  Max.   : 0.67                           
    ##  NA's   :1                               
    ##  D - 1. Write two things you like about the teaching and learning in this unit so far.
    ##  Length:101                                                                           
    ##  Class :character                                                                     
    ##  Mode  :character                                                                     
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##  D - 2. Write at least one recommendation to improve the teaching and learning in this unit (for the remaining weeks in the semester)
    ##  Length:101                                                                                                                          
    ##  Class :character                                                                                                                    
    ##  Mode  :character                                                                                                                    
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##  Average Course Evaluation Rating Average Level of Learning Attained Rating
    ##  Min.   :-1.62181                 Min.   :-2.095                           
    ##  1st Qu.:-0.25821                 1st Qu.:-0.595                           
    ##  Median : 0.01459                 Median :-0.095                           
    ##  Mean   : 0.00000                 Mean   : 0.000                           
    ##  3rd Qu.: 0.37819                 3rd Qu.: 0.405                           
    ##  Max.   : 0.46909                 Max.   : 0.905                           
    ##  NA's   :1                        NA's   :1                                
    ##  Average Pedagogical Strategy Effectiveness Rating
    ##  Min.   :-1.2500                                  
    ##  1st Qu.:-0.3636                                  
    ##  Median : 0.1137                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.4773                                  
    ##  Max.   : 0.5682                                  
    ##  NA's   :1                                        
    ##  Project: Section 1-4: (20%) x/10 Project: Section 5-11: (50%) x/10
    ##  Min.   :-8.0109                  Min.   :-6.5822                  
    ##  1st Qu.:-0.6109                  1st Qu.:-0.5822                  
    ##  Median : 0.4891                  Median : 1.2178                  
    ##  Mean   : 0.0000                  Mean   : 0.0000                  
    ##  3rd Qu.: 0.9891                  3rd Qu.: 1.7178                  
    ##  Max.   : 1.9891                  Max.   : 3.4178                  
    ##                                                                    
    ##  Project: Section 12: (30%) x/5 Project: (10%): x/30 x 100 TOTAL
    ##  Min.   :-1.015                 Min.   :-62.392                 
    ##  1st Qu.:-1.015                 1st Qu.: -6.392                 
    ##  Median :-1.015                 Median :  4.008                 
    ##  Mean   : 0.000                 Mean   :  0.000                 
    ##  3rd Qu.: 0.235                 3rd Qu.:  9.208                 
    ##  Max.   : 3.985                 Max.   : 37.608                 
    ##  NA's   :1                                                      
    ##  Quiz 1 on Concept 1 (Introduction) x/32 Quiz 3 on Concept 3 (Linear) x/15
    ##  Min.   :-11.607                         Min.   :-6.5303                  
    ##  1st Qu.: -4.827                         1st Qu.:-2.5303                  
    ##  Median : -1.027                         Median :-0.5303                  
    ##  Mean   :  0.000                         Mean   : 0.0000                  
    ##  3rd Qu.:  3.273                         3rd Qu.: 2.4697                  
    ##  Max.   : 14.893                         Max.   : 5.4697                  
    ##                                          NA's   :2                        
    ##  Quiz 4 on Concept 4 (Non-Linear) x/22 Quiz 5 on Concept 5 (Dashboarding) x/10
    ##  Min.   :-10.9357                      Min.   :-6.36742                       
    ##  1st Qu.: -3.0207                      1st Qu.:-1.36742                       
    ##  Median : -0.4357                      Median :-0.03742                       
    ##  Mean   :  0.0000                      Mean   : 0.00000                       
    ##  3rd Qu.:  3.5643                      3rd Qu.: 1.63258                       
    ##  Max.   :  8.0643                      Max.   : 6.30258                       
    ##  NA's   :6                             NA's   :12                             
    ##  Quizzes and  Bonus Marks (7%): x/79 x 100 TOTAL
    ##  Min.   :-29.9592                               
    ##  1st Qu.:-12.3992                               
    ##  Median : -0.9092                               
    ##  Mean   :  0.0000                               
    ##  3rd Qu.:  8.9408                               
    ##  Max.   : 39.0308                               
    ##                                                 
    ##  Lab 1 - 2.c. - (Simple Linear Regression) x/5
    ##  Min.   :-1.898                               
    ##  1st Qu.: 0.102                               
    ##  Median : 0.102                               
    ##  Mean   : 0.000                               
    ##  3rd Qu.: 0.102                               
    ##  Max.   : 0.102                               
    ##  NA's   :3                                    
    ##  Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5
    ##  Min.   :-2.0163                                               
    ##  1st Qu.:-1.0163                                               
    ##  Median : 0.6837                                               
    ##  Mean   : 0.0000                                               
    ##  3rd Qu.: 0.8337                                               
    ##  Max.   : 0.8337                                               
    ##  NA's   :6                                                     
    ##  Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5
    ##  Min.   :-1.7802                                                
    ##  1st Qu.: 0.2198                                                
    ##  Median : 0.2198                                                
    ##  Mean   : 0.0000                                                
    ##  3rd Qu.: 0.2198                                                
    ##  Max.   : 0.3698                                                
    ##  NA's   :9                                                      
    ##  Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5
    ##  Min.   :-2.5747                                  
    ##  1st Qu.:-0.3247                                  
    ##  Median : 0.4253                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.5753                                  
    ##  Max.   : 0.5753                                  
    ##  NA's   :18                                       
    ##  Lab 5 - Chart JS Dashboard Setup x/5 Lab Work (7%) x/25 x 100
    ##  Min.   :-3.404                       Min.   :-61.916         
    ##  1st Qu.:-3.404                       1st Qu.: -8.916         
    ##  Median : 1.596                       Median :  0.284         
    ##  Mean   : 0.000                       Mean   :  0.000         
    ##  3rd Qu.: 1.596                       3rd Qu.: 17.484         
    ##  Max.   : 1.596                       Max.   : 20.284         
    ##                                                               
    ##  CAT 1 (8%): x/38 x 100 CAT 2 (8%): x/100 x 100
    ##  Min.   :-36.5033       Min.   :-62.129        
    ##  1st Qu.:-10.1833       1st Qu.:-11.129        
    ##  Median :  0.3367       Median :  1.371        
    ##  Mean   :  0.0000       Mean   :  0.000        
    ##  3rd Qu.: 13.4967       3rd Qu.: 19.621        
    ##  Max.   : 27.9667       Max.   : 37.871        
    ##  NA's   :4              NA's   :31             
    ##  Attendance Waiver Granted: 1 = Yes, 0 = No Absenteeism Percentage
    ##  Min.   :-0.04951                           Min.   :-15.4155      
    ##  1st Qu.:-0.04951                           1st Qu.: -8.0055      
    ##  Median :-0.04951                           Median : -0.6055      
    ##  Mean   : 0.00000                           Mean   :  0.0000      
    ##  3rd Qu.:-0.04951                           3rd Qu.:  6.8045      
    ##  Max.   : 0.95049                           Max.   : 36.4345      
    ##                                                                   
    ##  Coursework TOTAL: x/40 (40%) EXAM: x/60 (60%)   
    ##  Min.   :-17.05604            Min.   :-28.93814  
    ##  1st Qu.: -4.08604            1st Qu.: -7.93814  
    ##  Median :  0.05396            Median :  0.06186  
    ##  Mean   :  0.00000            Mean   :  0.00000  
    ##  3rd Qu.:  4.78396            3rd Qu.:  8.06186  
    ##  Max.   : 10.55396            Max.   : 22.06186  
    ##                               NA's   :4          
    ##  TOTAL = Coursework TOTAL + EXAM (100%)    GRADE          
    ##  Min.   :-49.65                         Length:101        
    ##  1st Qu.:-11.58                         Class :character  
    ##  Median :  1.57                         Mode  :character  
    ##  Mean   :  0.00                                           
    ##  3rd Qu.: 11.71                                           
    ##  Max.   : 30.60                                           
    ## 

``` r
### The Standardize Basic Transform on the Crop Dataset ----
# BEFORE
summary(StudentPerformanceDataset)
```

    ##  class_group            gender            YOB       regret_choosing_bi
    ##  Length:101         Min.   :0.0000   Min.   :1998   Min.   :0.0000    
    ##  Class :character   1st Qu.:0.0000   1st Qu.:2000   1st Qu.:0.0000    
    ##  Mode  :character   Median :1.0000   Median :2001   Median :0.0000    
    ##                     Mean   :0.5743   Mean   :2001   Mean   :0.0198    
    ##                     3rd Qu.:1.0000   3rd Qu.:2002   3rd Qu.:0.0000    
    ##                     Max.   :1.0000   Max.   :2003   Max.   :1.0000    
    ##                                                                       
    ##   drop_bi_now       motivator      read_content_before_lecture
    ##  Min.   :0.0000   Min.   :0.0000   Min.   :1.000              
    ##  1st Qu.:0.0000   1st Qu.:1.0000   1st Qu.:2.000              
    ##  Median :0.0000   Median :1.0000   Median :3.000              
    ##  Mean   :0.0198   Mean   :0.7525   Mean   :2.752              
    ##  3rd Qu.:0.0000   3rd Qu.:1.0000   3rd Qu.:3.000              
    ##  Max.   :1.0000   Max.   :1.0000   Max.   :5.000              
    ##                                                               
    ##  anticipate_test_questions answer_rhetorical_questions find_terms_I_do_not_know
    ##  Min.   :1.000             Min.   :1.000               Min.   :1.000           
    ##  1st Qu.:3.000             1st Qu.:3.000               1st Qu.:3.000           
    ##  Median :4.000             Median :4.000               Median :4.000           
    ##  Mean   :3.584             Mean   :3.426               Mean   :3.743           
    ##  3rd Qu.:4.000             3rd Qu.:4.000               3rd Qu.:5.000           
    ##  Max.   :5.000             Max.   :5.000               Max.   :5.000           
    ##                                                                                
    ##  copy_new_terms_in_reading_notebook take_quizzes_and_use_results
    ##  Min.   :1.000                      Min.   :1.000               
    ##  1st Qu.:3.000                      1st Qu.:3.000               
    ##  Median :4.000                      Median :4.000               
    ##  Mean   :3.663                      Mean   :3.941               
    ##  3rd Qu.:4.000                      3rd Qu.:5.000               
    ##  Max.   :5.000                      Max.   :5.000               
    ##                                                                 
    ##  reorganise_course_outline write_down_important_points space_out_revision
    ##  Min.   :1.000             Min.   :1.000               Min.   :1.000     
    ##  1st Qu.:3.000             1st Qu.:3.000               1st Qu.:3.000     
    ##  Median :3.000             Median :4.000               Median :3.000     
    ##  Mean   :3.376             Mean   :3.832               Mean   :3.228     
    ##  3rd Qu.:4.000             3rd Qu.:5.000               3rd Qu.:4.000     
    ##  Max.   :5.000             Max.   :5.000               Max.   :5.000     
    ##                                                                          
    ##  studying_in_study_group schedule_appointments goal_oriented  
    ##  Min.   :1.000           Min.   :1.000         Min.   :0.000  
    ##  1st Qu.:1.000           1st Qu.:1.000         1st Qu.:0.000  
    ##  Median :2.000           Median :2.000         Median :0.000  
    ##  Mean   :2.455           Mean   :1.931         Mean   :0.198  
    ##  3rd Qu.:3.000           3rd Qu.:2.000         3rd Qu.:0.000  
    ##  Max.   :5.000           Max.   :5.000         Max.   :1.000  
    ##                                                               
    ##  spaced_repetition testing_and_active_recall  interleaving    categorizing  
    ##  Min.   :1.000     Min.   :1.000             Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:2.000     1st Qu.:3.000             1st Qu.:2.000   1st Qu.:2.000  
    ##  Median :3.000     Median :3.000             Median :2.000   Median :3.000  
    ##  Mean   :2.554     Mean   :3.059             Mean   :2.257   Mean   :2.713  
    ##  3rd Qu.:3.000     3rd Qu.:4.000             3rd Qu.:3.000   3rd Qu.:3.000  
    ##  Max.   :4.000     Max.   :4.000             Max.   :4.000   Max.   :4.000  
    ##                                                                             
    ##  retrospective_timetable cornell_notes        sq3r          commute    
    ##  Min.   :1.000           Min.   :1.000   Min.   :1.000   Min.   :1.00  
    ##  1st Qu.:2.000           1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.00  
    ##  Median :2.000           Median :3.000   Median :3.000   Median :3.00  
    ##  Mean   :2.406           Mean   :2.545   Mean   :2.614   Mean   :2.73  
    ##  3rd Qu.:3.000           3rd Qu.:3.000   3rd Qu.:3.000   3rd Qu.:4.00  
    ##  Max.   :4.000           Max.   :4.000   Max.   :4.000   Max.   :4.00  
    ##                                                          NA's   :1     
    ##    study_time   repeats_since_Y1  paid_tuition   free_tuition  extra_curricular
    ##  Min.   :1.00   Min.   : 0.00    Min.   :0.00   Min.   :0.00   Min.   :0.00    
    ##  1st Qu.:1.00   1st Qu.: 0.00    1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00    
    ##  Median :2.00   Median : 2.00    Median :0.00   Median :0.00   Median :1.00    
    ##  Mean   :1.75   Mean   : 2.05    Mean   :0.11   Mean   :0.27   Mean   :0.53    
    ##  3rd Qu.:2.00   3rd Qu.: 3.00    3rd Qu.:0.00   3rd Qu.:1.00   3rd Qu.:1.00    
    ##  Max.   :4.00   Max.   :10.00    Max.   :1.00   Max.   :1.00   Max.   :1.00    
    ##  NA's   :1      NA's   :1        NA's   :1      NA's   :1      NA's   :1       
    ##  sports_extra_curricular exercise_per_week    meditate         pray     
    ##  Min.   :0.00            Min.   :0.0       Min.   :0.00   Min.   :0.00  
    ##  1st Qu.:0.00            1st Qu.:1.0       1st Qu.:0.00   1st Qu.:1.00  
    ##  Median :0.00            Median :1.0       Median :1.00   Median :2.00  
    ##  Mean   :0.36            Mean   :1.1       Mean   :0.76   Mean   :2.09  
    ##  3rd Qu.:1.00            3rd Qu.:2.0       3rd Qu.:1.00   3rd Qu.:3.00  
    ##  Max.   :1.00            Max.   :3.0       Max.   :3.00   Max.   :3.00  
    ##  NA's   :1               NA's   :1         NA's   :1      NA's   :1     
    ##     internet        laptop  family_relationships  friendships  
    ##  Min.   :0.00   Min.   :1   Min.   :2.00         Min.   :2.00  
    ##  1st Qu.:1.00   1st Qu.:1   1st Qu.:4.00         1st Qu.:4.00  
    ##  Median :1.00   Median :1   Median :4.00         Median :4.00  
    ##  Mean   :0.87   Mean   :1   Mean   :4.19         Mean   :4.01  
    ##  3rd Qu.:1.00   3rd Qu.:1   3rd Qu.:5.00         3rd Qu.:4.00  
    ##  Max.   :1.00   Max.   :1   Max.   :5.00         Max.   :5.00  
    ##  NA's   :1      NA's   :1   NA's   :1            NA's   :1     
    ##  romantic_relationships spiritual_wellnes financial_wellness     health    
    ##  Min.   :0.00           Min.   :1.00      Min.   :1.00       Min.   :1.00  
    ##  1st Qu.:0.00           1st Qu.:3.00      1st Qu.:2.00       1st Qu.:3.00  
    ##  Median :0.00           Median :4.00      Median :3.00       Median :4.00  
    ##  Mean   :1.37           Mean   :3.65      Mean   :3.03       Mean   :4.04  
    ##  3rd Qu.:3.00           3rd Qu.:4.00      3rd Qu.:4.00       3rd Qu.:5.00  
    ##  Max.   :4.00           Max.   :5.00      Max.   :5.00       Max.   :5.00  
    ##  NA's   :1              NA's   :1         NA's   :1          NA's   :1     
    ##     day_out      night_out    alcohol_or_narcotics     mentor    
    ##  Min.   :0.0   Min.   :0.00   Min.   :0.00         Min.   :0.00  
    ##  1st Qu.:0.0   1st Qu.:0.00   1st Qu.:0.00         1st Qu.:0.00  
    ##  Median :1.0   Median :0.00   Median :0.00         Median :0.00  
    ##  Mean   :0.8   Mean   :0.51   Mean   :0.35         Mean   :0.41  
    ##  3rd Qu.:1.0   3rd Qu.:1.00   3rd Qu.:1.00         3rd Qu.:1.00  
    ##  Max.   :3.0   Max.   :3.00   Max.   :3.00         Max.   :1.00  
    ##  NA's   :1     NA's   :1      NA's   :1            NA's   :1     
    ##  mentor_meetings A - 1. I am enjoying the subject
    ##  Min.   :0.00    Min.   :3.00                    
    ##  1st Qu.:0.00    1st Qu.:4.00                    
    ##  Median :0.00    Median :5.00                    
    ##  Mean   :0.68    Mean   :4.49                    
    ##  3rd Qu.:1.00    3rd Qu.:5.00                    
    ##  Max.   :3.00    Max.   :5.00                    
    ##  NA's   :1       NA's   :1                       
    ##  A - 2. Classes start and end on time
    ##  Min.   :3.00                        
    ##  1st Qu.:4.00                        
    ##  Median :5.00                        
    ##  Mean   :4.68                        
    ##  3rd Qu.:5.00                        
    ##  Max.   :5.00                        
    ##  NA's   :1                           
    ##  A - 3. The learning environment is participative, involves learning by doing and is group-based
    ##  Min.   :3.00                                                                                   
    ##  1st Qu.:4.00                                                                                   
    ##  Median :4.00                                                                                   
    ##  Mean   :4.35                                                                                   
    ##  3rd Qu.:5.00                                                                                   
    ##  Max.   :5.00                                                                                   
    ##  NA's   :1                                                                                      
    ##  A - 4. The subject content is delivered according to the course outline and meets my expectations
    ##  Min.   :3.00                                                                                     
    ##  1st Qu.:4.75                                                                                     
    ##  Median :5.00                                                                                     
    ##  Mean   :4.74                                                                                     
    ##  3rd Qu.:5.00                                                                                     
    ##  Max.   :5.00                                                                                     
    ##  NA's   :1                                                                                        
    ##  A - 5. The topics are clear and logically developed
    ##  Min.   :2.00                                       
    ##  1st Qu.:4.00                                       
    ##  Median :5.00                                       
    ##  Mean   :4.65                                       
    ##  3rd Qu.:5.00                                       
    ##  Max.   :5.00                                       
    ##  NA's   :1                                          
    ##  A - 6. I am developing my oral and writing skills
    ##  Min.   :1.00                                     
    ##  1st Qu.:4.00                                     
    ##  Median :4.00                                     
    ##  Mean   :4.11                                     
    ##  3rd Qu.:5.00                                     
    ##  Max.   :5.00                                     
    ##  NA's   :1                                        
    ##  A - 7. I am developing my reflective and critical reasoning skills
    ##  Min.   :2.00                                                      
    ##  1st Qu.:4.00                                                      
    ##  Median :4.00                                                      
    ##  Mean   :4.38                                                      
    ##  3rd Qu.:5.00                                                      
    ##  Max.   :5.00                                                      
    ##  NA's   :1                                                         
    ##  A - 8. The assessment methods are assisting me to learn
    ##  Min.   :1.00                                           
    ##  1st Qu.:4.00                                           
    ##  Median :5.00                                           
    ##  Mean   :4.61                                           
    ##  3rd Qu.:5.00                                           
    ##  Max.   :5.00                                           
    ##  NA's   :1                                              
    ##  A - 9. I receive relevant feedback
    ##  Min.   :3.00                      
    ##  1st Qu.:4.00                      
    ##  Median :5.00                      
    ##  Mean   :4.58                      
    ##  3rd Qu.:5.00                      
    ##  Max.   :5.00                      
    ##  NA's   :1                         
    ##  A - 10. I read the recommended readings and notes
    ##  Min.   :3.00                                     
    ##  1st Qu.:4.00                                     
    ##  Median :5.00                                     
    ##  Mean   :4.55                                     
    ##  3rd Qu.:5.00                                     
    ##  Max.   :5.00                                     
    ##  NA's   :1                                        
    ##  A - 11. I use the eLearning material posted
    ##  Min.   :3.0                                
    ##  1st Qu.:4.0                                
    ##  Median :5.0                                
    ##  Mean   :4.7                                
    ##  3rd Qu.:5.0                                
    ##  Max.   :5.0                                
    ##  NA's   :1                                  
    ##  B - 1. Concept 1 of 6: Principles of Business Intelligence and the DataOps Philosophy
    ##  Min.   :1.00                                                                         
    ##  1st Qu.:4.00                                                                         
    ##  Median :4.00                                                                         
    ##  Mean   :4.25                                                                         
    ##  3rd Qu.:5.00                                                                         
    ##  Max.   :5.00                                                                         
    ##  NA's   :1                                                                            
    ##  B - 2. Concept 3 of 6: Linear Algorithms for Predictive Analytics
    ##  Min.   :2.00                                                     
    ##  1st Qu.:3.00                                                     
    ##  Median :4.00                                                     
    ##  Mean   :3.94                                                     
    ##  3rd Qu.:5.00                                                     
    ##  Max.   :5.00                                                     
    ##  NA's   :1                                                        
    ##  C - 2. Quizzes at the end of each concept
    ##  Min.   :2.00                             
    ##  1st Qu.:4.00                             
    ##  Median :5.00                             
    ##  Mean   :4.59                             
    ##  3rd Qu.:5.00                             
    ##  Max.   :5.00                             
    ##  NA's   :1                                
    ##  C - 3. Lab manuals that outline the steps to follow during the labs
    ##  Min.   :3.00                                                       
    ##  1st Qu.:4.00                                                       
    ##  Median :5.00                                                       
    ##  Mean   :4.61                                                       
    ##  3rd Qu.:5.00                                                       
    ##  Max.   :5.00                                                       
    ##  NA's   :1                                                          
    ##  C - 4. Required lab work submissions at the end of each lab manual that outline the activity to be done on your own
    ##  Min.   :3.00                                                                                                       
    ##  1st Qu.:4.00                                                                                                       
    ##  Median :5.00                                                                                                       
    ##  Mean   :4.55                                                                                                       
    ##  3rd Qu.:5.00                                                                                                       
    ##  Max.   :5.00                                                                                                       
    ##  NA's   :1                                                                                                          
    ##  C - 5. Supplementary videos to watch
    ##  Min.   :1.00                        
    ##  1st Qu.:4.00                        
    ##  Median :4.00                        
    ##  Mean   :4.19                        
    ##  3rd Qu.:5.00                        
    ##  Max.   :5.00                        
    ##  NA's   :1                           
    ##  C - 6. Supplementary podcasts to listen to
    ##  Min.   :1.00                              
    ##  1st Qu.:4.00                              
    ##  Median :4.00                              
    ##  Mean   :4.08                              
    ##  3rd Qu.:5.00                              
    ##  Max.   :5.00                              
    ##  NA's   :1                                 
    ##  C - 7. Supplementary content to read C - 8. Lectures slides
    ##  Min.   :1.00                         Min.   :2.0           
    ##  1st Qu.:4.00                         1st Qu.:4.0           
    ##  Median :4.00                         Median :5.0           
    ##  Mean   :4.17                         Mean   :4.6           
    ##  3rd Qu.:5.00                         3rd Qu.:5.0           
    ##  Max.   :5.00                         Max.   :5.0           
    ##  NA's   :1                            NA's   :1             
    ##  C - 9. Lecture notes on some of the lecture slides
    ##  Min.   :2.0                                       
    ##  1st Qu.:4.0                                       
    ##  Median :5.0                                       
    ##  Mean   :4.6                                       
    ##  3rd Qu.:5.0                                       
    ##  Max.   :5.0                                       
    ##  NA's   :1                                         
    ##  C - 10. The quality of the lectures given (quality measured by the breadth (the full span of knowledge of a subject) and depth (the extent to which specific topics are focused upon, amplified, and explored) of learning - NOT quality measured by how fun/comical/lively the lectures are)
    ##  Min.   :2.00                                                                                                                                                                                                                                                                                 
    ##  1st Qu.:4.00                                                                                                                                                                                                                                                                                 
    ##  Median :5.00                                                                                                                                                                                                                                                                                 
    ##  Mean   :4.54                                                                                                                                                                                                                                                                                 
    ##  3rd Qu.:5.00                                                                                                                                                                                                                                                                                 
    ##  Max.   :5.00                                                                                                                                                                                                                                                                                 
    ##  NA's   :1                                                                                                                                                                                                                                                                                    
    ##  C - 11. The division of theory and practice such that most of the theory is done during the recorded online classes and most of the practice is done during the physical classes
    ##  Min.   :2.00                                                                                                                                                                    
    ##  1st Qu.:4.00                                                                                                                                                                    
    ##  Median :5.00                                                                                                                                                                    
    ##  Mean   :4.49                                                                                                                                                                    
    ##  3rd Qu.:5.00                                                                                                                                                                    
    ##  Max.   :5.00                                                                                                                                                                    
    ##  NA's   :1                                                                                                                                                                       
    ##  C - 12. The recordings of online classes
    ##  Min.   :2.00                            
    ##  1st Qu.:4.00                            
    ##  Median :5.00                            
    ##  Mean   :4.33                            
    ##  3rd Qu.:5.00                            
    ##  Max.   :5.00                            
    ##  NA's   :1                               
    ##  D - 1. Write two things you like about the teaching and learning in this unit so far.
    ##  Length:101                                                                           
    ##  Class :character                                                                     
    ##  Mode  :character                                                                     
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##  D - 2. Write at least one recommendation to improve the teaching and learning in this unit (for the remaining weeks in the semester)
    ##  Length:101                                                                                                                          
    ##  Class :character                                                                                                                    
    ##  Mode  :character                                                                                                                    
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##  Average Course Evaluation Rating Average Level of Learning Attained Rating
    ##  Min.   :2.909                    Min.   :2.000                            
    ##  1st Qu.:4.273                    1st Qu.:3.500                            
    ##  Median :4.545                    Median :4.000                            
    ##  Mean   :4.531                    Mean   :4.095                            
    ##  3rd Qu.:4.909                    3rd Qu.:4.500                            
    ##  Max.   :5.000                    Max.   :5.000                            
    ##  NA's   :1                        NA's   :1                                
    ##  Average Pedagogical Strategy Effectiveness Rating
    ##  Min.   :3.182                                    
    ##  1st Qu.:4.068                                    
    ##  Median :4.545                                    
    ##  Mean   :4.432                                    
    ##  3rd Qu.:4.909                                    
    ##  Max.   :5.000                                    
    ##  NA's   :1                                        
    ##  Project: Section 1-4: (20%) x/10 Project: Section 5-11: (50%) x/10
    ##  Min.   : 0.000                   Min.   : 0.000                   
    ##  1st Qu.: 7.400                   1st Qu.: 6.000                   
    ##  Median : 8.500                   Median : 7.800                   
    ##  Mean   : 8.011                   Mean   : 6.582                   
    ##  3rd Qu.: 9.000                   3rd Qu.: 8.300                   
    ##  Max.   :10.000                   Max.   :10.000                   
    ##                                                                    
    ##  Project: Section 12: (30%) x/5 Project: (10%): x/30 x 100 TOTAL
    ##  Min.   :0.000                  Min.   :  0.00                  
    ##  1st Qu.:0.000                  1st Qu.: 56.00                  
    ##  Median :0.000                  Median : 66.40                  
    ##  Mean   :1.015                  Mean   : 62.39                  
    ##  3rd Qu.:1.250                  3rd Qu.: 71.60                  
    ##  Max.   :5.000                  Max.   :100.00                  
    ##  NA's   :1                                                      
    ##  Quiz 1 on Concept 1 (Introduction) x/32 Quiz 3 on Concept 3 (Linear) x/15
    ##  Min.   : 4.75                           Min.   : 3.00                    
    ##  1st Qu.:11.53                           1st Qu.: 7.00                    
    ##  Median :15.33                           Median : 9.00                    
    ##  Mean   :16.36                           Mean   : 9.53                    
    ##  3rd Qu.:19.63                           3rd Qu.:12.00                    
    ##  Max.   :31.25                           Max.   :15.00                    
    ##                                          NA's   :2                        
    ##  Quiz 4 on Concept 4 (Non-Linear) x/22 Quiz 5 on Concept 5 (Dashboarding) x/10
    ##  Min.   : 3.00                         Min.   : 0.000                         
    ##  1st Qu.:10.91                         1st Qu.: 5.000                         
    ##  Median :13.50                         Median : 6.330                         
    ##  Mean   :13.94                         Mean   : 6.367                         
    ##  3rd Qu.:17.50                         3rd Qu.: 8.000                         
    ##  Max.   :22.00                         Max.   :12.670                         
    ##  NA's   :6                             NA's   :12                             
    ##  Quizzes and  Bonus Marks (7%): x/79 x 100 TOTAL
    ##  Min.   :26.26                                  
    ##  1st Qu.:43.82                                  
    ##  Median :55.31                                  
    ##  Mean   :56.22                                  
    ##  3rd Qu.:65.16                                  
    ##  Max.   :95.25                                  
    ##                                                 
    ##  Lab 1 - 2.c. - (Simple Linear Regression) x/5
    ##  Min.   :3.000                                
    ##  1st Qu.:5.000                                
    ##  Median :5.000                                
    ##  Mean   :4.898                                
    ##  3rd Qu.:5.000                                
    ##  Max.   :5.000                                
    ##  NA's   :3                                    
    ##  Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5
    ##  Min.   :2.150                                                 
    ##  1st Qu.:3.150                                                 
    ##  Median :4.850                                                 
    ##  Mean   :4.166                                                 
    ##  3rd Qu.:5.000                                                 
    ##  Max.   :5.000                                                 
    ##  NA's   :6                                                     
    ##  Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5
    ##  Min.   :2.85                                                   
    ##  1st Qu.:4.85                                                   
    ##  Median :4.85                                                   
    ##  Mean   :4.63                                                   
    ##  3rd Qu.:4.85                                                   
    ##  Max.   :5.00                                                   
    ##  NA's   :9                                                      
    ##  Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5
    ##  Min.   :1.850                                    
    ##  1st Qu.:4.100                                    
    ##  Median :4.850                                    
    ##  Mean   :4.425                                    
    ##  3rd Qu.:5.000                                    
    ##  Max.   :5.000                                    
    ##  NA's   :18                                       
    ##  Lab 5 - Chart JS Dashboard Setup x/5 Lab Work (7%) x/25 x 100
    ##  Min.   :0.000                        Min.   : 17.80          
    ##  1st Qu.:0.000                        1st Qu.: 70.80          
    ##  Median :5.000                        Median : 80.00          
    ##  Mean   :3.404                        Mean   : 79.72          
    ##  3rd Qu.:5.000                        3rd Qu.: 97.20          
    ##  Max.   :5.000                        Max.   :100.00          
    ##                                                               
    ##  CAT 1 (8%): x/38 x 100 CAT 2 (8%): x/100 x 100
    ##  Min.   :32.89          Min.   :  0.00         
    ##  1st Qu.:59.21          1st Qu.: 51.00         
    ##  Median :69.73          Median : 63.50         
    ##  Mean   :69.39          Mean   : 62.13         
    ##  3rd Qu.:82.89          3rd Qu.: 81.75         
    ##  Max.   :97.36          Max.   :100.00         
    ##  NA's   :4              NA's   :31             
    ##  Attendance Waiver Granted: 1 = Yes, 0 = No Absenteeism Percentage
    ##  Min.   :0.00000                            Min.   : 0.00         
    ##  1st Qu.:0.00000                            1st Qu.: 7.41         
    ##  Median :0.00000                            Median :14.81         
    ##  Mean   :0.04951                            Mean   :15.42         
    ##  3rd Qu.:0.00000                            3rd Qu.:22.22         
    ##  Max.   :1.00000                            Max.   :51.85         
    ##                                                                   
    ##  Coursework TOTAL: x/40 (40%) EXAM: x/60 (60%)
    ##  Min.   : 7.47                Min.   : 5.00   
    ##  1st Qu.:20.44                1st Qu.:26.00   
    ##  Median :24.58                Median :34.00   
    ##  Mean   :24.53                Mean   :33.94   
    ##  3rd Qu.:29.31                3rd Qu.:42.00   
    ##  Max.   :35.08                Max.   :56.00   
    ##                               NA's   :4       
    ##  TOTAL = Coursework TOTAL + EXAM (100%)    GRADE          
    ##  Min.   : 7.47                          Length:101        
    ##  1st Qu.:45.54                          Class :character  
    ##  Median :58.69                          Mode  :character  
    ##  Mean   :57.12                                            
    ##  3rd Qu.:68.83                                            
    ##  Max.   :87.72                                            
    ## 

``` r
sapply(StudentPerformanceDataset[, 4], sd)
```

    ## regret_choosing_bi 
    ##          0.1400141

``` r
model_of_the_transform <- preProcess(StudentPerformanceDataset,
                                     method = c("scale", "center"))
print(model_of_the_transform)
```

    ## Created from 51 samples and 100 variables
    ## 
    ## Pre-processing:
    ##   - centered (96)
    ##   - ignored (4)
    ##   - scaled (96)

``` r
student_dataset_standardize_transform <- predict(model_of_the_transform, StudentPerformanceDataset) # nolint

# AFTER
summary(student_dataset_standardize_transform)
```

    ##  class_group            gender             YOB          regret_choosing_bi
    ##  Length:101         Min.   :-1.1556   Min.   :-2.9155   Min.   :-0.1414   
    ##  Class :character   1st Qu.:-1.1556   1st Qu.:-0.9055   1st Qu.:-0.1414   
    ##  Mode  :character   Median : 0.8568   Median : 0.0995   Median :-0.1414   
    ##                     Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   
    ##                     3rd Qu.: 0.8568   3rd Qu.: 1.1045   3rd Qu.:-0.1414   
    ##                     Max.   : 0.8568   Max.   : 2.1095   Max.   : 7.0007   
    ##                                                                           
    ##   drop_bi_now        motivator       read_content_before_lecture
    ##  Min.   :-0.1414   Min.   :-1.7349   Min.   :-1.8191            
    ##  1st Qu.:-0.1414   1st Qu.: 0.5707   1st Qu.:-0.7811            
    ##  Median :-0.1414   Median : 0.5707   Median : 0.2569            
    ##  Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000            
    ##  3rd Qu.:-0.1414   3rd Qu.: 0.5707   3rd Qu.: 0.2569            
    ##  Max.   : 7.0007   Max.   : 0.5707   Max.   : 2.3329            
    ##                                                                 
    ##  anticipate_test_questions answer_rhetorical_questions find_terms_I_do_not_know
    ##  Min.   :-2.6033           Min.   :-2.4418             Min.   :-2.5995         
    ##  1st Qu.:-0.5885           1st Qu.:-0.4286             1st Qu.:-0.7038         
    ##  Median : 0.4189           Median : 0.5780             Median : 0.2440         
    ##  Mean   : 0.0000           Mean   : 0.0000             Mean   : 0.0000         
    ##  3rd Qu.: 0.4189           3rd Qu.: 0.5780             3rd Qu.: 1.1918         
    ##  Max.   : 1.4263           Max.   : 1.5846             Max.   : 1.1918         
    ##                                                                                
    ##  copy_new_terms_in_reading_notebook take_quizzes_and_use_results
    ##  Min.   :-2.4058                    Min.   :-2.73448            
    ##  1st Qu.:-0.5992                    1st Qu.:-0.87466            
    ##  Median : 0.3041                    Median : 0.05524            
    ##  Mean   : 0.0000                    Mean   : 0.00000            
    ##  3rd Qu.: 0.3041                    3rd Qu.: 0.98515            
    ##  Max.   : 1.2074                    Max.   : 0.98515            
    ##                                                                 
    ##  reorganise_course_outline write_down_important_points space_out_revision
    ##  Min.   :-2.0550           Min.   :-2.6276             Min.   :-1.9709   
    ##  1st Qu.:-0.3254           1st Qu.:-0.7717             1st Qu.:-0.2015   
    ##  Median :-0.3254           Median : 0.1562             Median :-0.2015   
    ##  Mean   : 0.0000           Mean   : 0.0000             Mean   : 0.0000   
    ##  3rd Qu.: 0.5394           3rd Qu.: 1.0841             3rd Qu.: 0.6832   
    ##  Max.   : 1.4043           Max.   : 1.0841             Max.   : 1.5679   
    ##                                                                          
    ##  studying_in_study_group schedule_appointments goal_oriented    
    ##  Min.   :-1.0877         Min.   :-0.91037      Min.   :-0.4944  
    ##  1st Qu.:-1.0877         1st Qu.:-0.91037      1st Qu.:-0.4944  
    ##  Median :-0.3404         Median : 0.06779      Median :-0.4944  
    ##  Mean   : 0.0000         Mean   : 0.00000      Mean   : 0.0000  
    ##  3rd Qu.: 0.4070         3rd Qu.: 0.06779      3rd Qu.:-0.4944  
    ##  Max.   : 1.9016         Max.   : 3.00228      Max.   : 2.0025  
    ##                                                                 
    ##  spaced_repetition testing_and_active_recall  interleaving    
    ##  Min.   :-1.8720   Min.   :-2.86572          Min.   :-1.6908  
    ##  1st Qu.:-0.6677   1st Qu.:-0.08267          1st Qu.:-0.3461  
    ##  Median : 0.5366   Median :-0.08267          Median :-0.3461  
    ##  Mean   : 0.0000   Mean   : 0.00000          Mean   : 0.0000  
    ##  3rd Qu.: 0.5366   3rd Qu.: 1.30886          3rd Qu.: 0.9985  
    ##  Max.   : 1.7409   Max.   : 1.30886          Max.   : 2.3432  
    ##                                                               
    ##   categorizing     retrospective_timetable cornell_notes          sq3r        
    ##  Min.   :-2.3165   Min.   :-1.5883         Min.   :-1.5519   Min.   :-1.5392  
    ##  1st Qu.:-0.9641   1st Qu.:-0.4586         1st Qu.:-0.5472   1st Qu.:-0.5855  
    ##  Median : 0.3883   Median :-0.4586         Median : 0.4576   Median : 0.3683  
    ##  Mean   : 0.0000   Mean   : 0.0000         Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 0.3883   3rd Qu.: 0.6711         3rd Qu.: 0.4576   3rd Qu.: 0.3683  
    ##  Max.   : 1.7407   Max.   : 1.8008         Max.   : 1.4624   Max.   : 1.3220  
    ##                                                                               
    ##     commute          study_time      repeats_since_Y1   paid_tuition    
    ##  Min.   :-1.6586   Min.   :-0.9134   Min.   :-0.9716   Min.   :-0.3498  
    ##  1st Qu.:-0.6999   1st Qu.:-0.9134   1st Qu.:-0.9716   1st Qu.:-0.3498  
    ##  Median : 0.2589   Median : 0.3045   Median :-0.0237   Median :-0.3498  
    ##  Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 1.2176   3rd Qu.: 0.3045   3rd Qu.: 0.4502   3rd Qu.:-0.3498  
    ##  Max.   : 1.2176   Max.   : 2.7402   Max.   : 3.7678   Max.   : 2.8302  
    ##  NA's   :1         NA's   :1         NA's   :1         NA's   :1        
    ##   free_tuition     extra_curricular sports_extra_curricular exercise_per_week
    ##  Min.   :-0.6051   Min.   :-1.057   Min.   :-0.7462         Min.   :-1.3575  
    ##  1st Qu.:-0.6051   1st Qu.:-1.057   1st Qu.:-0.7462         1st Qu.:-0.1234  
    ##  Median :-0.6051   Median : 0.937   Median :-0.7462         Median :-0.1234  
    ##  Mean   : 0.0000   Mean   : 0.000   Mean   : 0.0000         Mean   : 0.0000  
    ##  3rd Qu.: 1.6361   3rd Qu.: 0.937   3rd Qu.: 1.3266         3rd Qu.: 1.1107  
    ##  Max.   : 1.6361   Max.   : 0.937   Max.   : 1.3266         Max.   : 2.3448  
    ##  NA's   :1         NA's   :1        NA's   :1               NA's   :1        
    ##     meditate            pray             internet           laptop 
    ##  Min.   :-0.8143   Min.   :-2.03728   Min.   :-2.5740   Min.   :0  
    ##  1st Qu.:-0.8143   1st Qu.:-1.06251   1st Qu.: 0.3846   1st Qu.:0  
    ##  Median : 0.2571   Median :-0.08773   Median : 0.3846   Median :0  
    ##  Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.0000   Mean   :0  
    ##  3rd Qu.: 0.2571   3rd Qu.: 0.88705   3rd Qu.: 0.3846   3rd Qu.:0  
    ##  Max.   : 2.4000   Max.   : 0.88705   Max.   : 0.3846   Max.   :0  
    ##  NA's   :1         NA's   :1          NA's   :1         NA's   :1  
    ##  family_relationships  friendships       romantic_relationships
    ##  Min.   :-2.7369      Min.   :-2.74737   Min.   :-0.8531       
    ##  1st Qu.:-0.2374      1st Qu.:-0.01367   1st Qu.:-0.8531       
    ##  Median :-0.2374      Median :-0.01367   Median :-0.8531       
    ##  Mean   : 0.0000      Mean   : 0.00000   Mean   : 0.0000       
    ##  3rd Qu.: 1.0123      3rd Qu.:-0.01367   3rd Qu.: 1.0150       
    ##  Max.   : 1.0123      Max.   : 1.35318   Max.   : 1.6377       
    ##  NA's   :1            NA's   :1          NA's   :1             
    ##  spiritual_wellnes financial_wellness     health            day_out       
    ##  Min.   :-2.8309   Min.   :-1.85227   Min.   :-3.19122   Min.   :-1.4071  
    ##  1st Qu.:-0.6944   1st Qu.:-0.93982   1st Qu.:-1.09173   1st Qu.:-1.4071  
    ##  Median : 0.3739   Median :-0.02737   Median :-0.04199   Median : 0.3518  
    ##  Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.00000   Mean   : 0.0000  
    ##  3rd Qu.: 0.3739   3rd Qu.: 0.88508   3rd Qu.: 1.00775   3rd Qu.: 0.3518  
    ##  Max.   : 1.4422   Max.   : 1.79752   Max.   : 1.00775   Max.   : 3.8696  
    ##  NA's   :1         NA's   :1          NA's   :1          NA's   :1        
    ##    night_out       alcohol_or_narcotics     mentor        mentor_meetings  
    ##  Min.   :-0.7926   Min.   :-0.628       Min.   :-0.8294   Min.   :-0.8101  
    ##  1st Qu.:-0.7926   1st Qu.:-0.628       1st Qu.:-0.8294   1st Qu.:-0.8101  
    ##  Median :-0.7926   Median :-0.628       Median :-0.8294   Median :-0.8101  
    ##  Mean   : 0.0000   Mean   : 0.000       Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 0.7615   3rd Qu.: 1.166       3rd Qu.: 1.1936   3rd Qu.: 0.3812  
    ##  Max.   : 3.8697   Max.   : 4.755       Max.   : 1.1936   Max.   : 2.7638  
    ##  NA's   :1         NA's   :1            NA's   :1         NA's   :1        
    ##  A - 1. I am enjoying the subject A - 2. Classes start and end on time
    ##  Min.   :-2.5063                  Min.   :-3.4293                     
    ##  1st Qu.:-0.8242                  1st Qu.:-1.3880                     
    ##  Median : 0.8579                  Median : 0.6532                     
    ##  Mean   : 0.0000                  Mean   : 0.0000                     
    ##  3rd Qu.: 0.8579                  3rd Qu.: 0.6532                     
    ##  Max.   : 0.8579                  Max.   : 0.6532                     
    ##  NA's   :1                        NA's   :1                           
    ##  A - 3. The learning environment is participative, involves learning by doing and is group-based
    ##  Min.   :-2.0544                                                                                
    ##  1st Qu.:-0.5326                                                                                
    ##  Median :-0.5326                                                                                
    ##  Mean   : 0.0000                                                                                
    ##  3rd Qu.: 0.9892                                                                                
    ##  Max.   : 0.9892                                                                                
    ##  NA's   :1                                                                                      
    ##  A - 4. The subject content is delivered according to the course outline and meets my expectations
    ##  Min.   :-3.75655                                                                                 
    ##  1st Qu.: 0.02159                                                                                 
    ##  Median : 0.56132                                                                                 
    ##  Mean   : 0.00000                                                                                 
    ##  3rd Qu.: 0.56132                                                                                 
    ##  Max.   : 0.56132                                                                                 
    ##  NA's   :1                                                                                        
    ##  A - 5. The topics are clear and logically developed
    ##  Min.   :-4.6074                                    
    ##  1st Qu.:-1.1301                                    
    ##  Median : 0.6085                                    
    ##  Mean   : 0.0000                                    
    ##  3rd Qu.: 0.6085                                    
    ##  Max.   : 0.6085                                    
    ##  NA's   :1                                          
    ##  A - 6. I am developing my oral and writing skills
    ##  Min.   :-3.5544                                  
    ##  1st Qu.:-0.1257                                  
    ##  Median :-0.1257                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 1.0172                                  
    ##  Max.   : 1.0172                                  
    ##  NA's   :1                                        
    ##  A - 7. I am developing my reflective and critical reasoning skills
    ##  Min.   :-3.4338                                                   
    ##  1st Qu.:-0.5483                                                   
    ##  Median :-0.5483                                                   
    ##  Mean   : 0.0000                                                   
    ##  3rd Qu.: 0.8945                                                   
    ##  Max.   : 0.8945                                                   
    ##  NA's   :1                                                         
    ##  A - 8. The assessment methods are assisting me to learn
    ##  Min.   :-5.5563                                        
    ##  1st Qu.:-0.9389                                        
    ##  Median : 0.6003                                        
    ##  Mean   : 0.0000                                        
    ##  3rd Qu.: 0.6003                                        
    ##  Max.   : 0.6003                                        
    ##  NA's   :1                                              
    ##  A - 9. I receive relevant feedback
    ##  Min.   :-2.8531                   
    ##  1st Qu.:-1.0474                   
    ##  Median : 0.7584                   
    ##  Mean   : 0.0000                   
    ##  3rd Qu.: 0.7584                   
    ##  Max.   : 0.7584                   
    ##  NA's   :1                         
    ##  A - 10. I read the recommended readings and notes
    ##  Min.   :-2.4775                                  
    ##  1st Qu.:-0.8791                                  
    ##  Median : 0.7193                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.7193                                  
    ##  Max.   : 0.7193                                  
    ##  NA's   :1                                        
    ##  A - 11. I use the eLearning material posted
    ##  Min.   :-3.2553                            
    ##  1st Qu.:-1.3404                            
    ##  Median : 0.5745                            
    ##  Mean   : 0.0000                            
    ##  3rd Qu.: 0.5745                            
    ##  Max.   : 0.5745                            
    ##  NA's   :1                                  
    ##  B - 1. Concept 1 of 6: Principles of Business Intelligence and the DataOps Philosophy
    ##  Min.   :-4.1489                                                                      
    ##  1st Qu.:-0.3191                                                                      
    ##  Median :-0.3191                                                                      
    ##  Mean   : 0.0000                                                                      
    ##  3rd Qu.: 0.9574                                                                      
    ##  Max.   : 0.9574                                                                      
    ##  NA's   :1                                                                            
    ##  B - 2. Concept 3 of 6: Linear Algorithms for Predictive Analytics
    ##  Min.   :-2.24938                                                 
    ##  1st Qu.:-1.08990                                                 
    ##  Median : 0.06957                                                 
    ##  Mean   : 0.00000                                                 
    ##  3rd Qu.: 1.22904                                                 
    ##  Max.   : 1.22904                                                 
    ##  NA's   :1                                                        
    ##  C - 2. Quizzes at the end of each concept
    ##  Min.   :-4.1701                          
    ##  1st Qu.:-0.9499                          
    ##  Median : 0.6601                          
    ##  Mean   : 0.0000                          
    ##  3rd Qu.: 0.6601                          
    ##  Max.   : 0.6601                          
    ##  NA's   :1                                
    ##  C - 3. Lab manuals that outline the steps to follow during the labs
    ##  Min.   :-2.6777                                                    
    ##  1st Qu.:-1.0145                                                    
    ##  Median : 0.6486                                                    
    ##  Mean   : 0.0000                                                    
    ##  3rd Qu.: 0.6486                                                    
    ##  Max.   : 0.6486                                                    
    ##  NA's   :1                                                          
    ##  C - 4. Required lab work submissions at the end of each lab manual that outline the activity to be done on your own
    ##  Min.   :-2.5440                                                                                                    
    ##  1st Qu.:-0.9027                                                                                                    
    ##  Median : 0.7386                                                                                                    
    ##  Mean   : 0.0000                                                                                                    
    ##  3rd Qu.: 0.7386                                                                                                    
    ##  Max.   : 0.7386                                                                                                    
    ##  NA's   :1                                                                                                          
    ##  C - 5. Supplementary videos to watch
    ##  Min.   :-3.6080                     
    ##  1st Qu.:-0.2149                     
    ##  Median :-0.2149                     
    ##  Mean   : 0.0000                     
    ##  3rd Qu.: 0.9161                     
    ##  Max.   : 0.9161                     
    ##  NA's   :1                           
    ##  C - 6. Supplementary podcasts to listen to
    ##  Min.   :-3.10583                          
    ##  1st Qu.:-0.08067                          
    ##  Median :-0.08067                          
    ##  Mean   : 0.00000                          
    ##  3rd Qu.: 0.92772                          
    ##  Max.   : 0.92772                          
    ##  NA's   :1                                 
    ##  C - 7. Supplementary content to read C - 8. Lectures slides
    ##  Min.   :-3.2864                      Min.   :-3.5875       
    ##  1st Qu.:-0.1762                      1st Qu.:-0.8279       
    ##  Median :-0.1762                      Median : 0.5519       
    ##  Mean   : 0.0000                      Mean   : 0.0000       
    ##  3rd Qu.: 0.8605                      3rd Qu.: 0.5519       
    ##  Max.   : 0.8605                      Max.   : 0.5519       
    ##  NA's   :1                            NA's   :1             
    ##  C - 9. Lecture notes on some of the lecture slides
    ##  Min.   :-4.0904                                   
    ##  1st Qu.:-0.9439                                   
    ##  Median : 0.6293                                   
    ##  Mean   : 0.0000                                   
    ##  3rd Qu.: 0.6293                                   
    ##  Max.   : 0.6293                                   
    ##  NA's   :1                                         
    ##  C - 10. The quality of the lectures given (quality measured by the breadth (the full span of knowledge of a subject) and depth (the extent to which specific topics are focused upon, amplified, and explored) of learning - NOT quality measured by how fun/comical/lively the lectures are)
    ##  Min.   :-3.8612                                                                                                                                                                                                                                                                              
    ##  1st Qu.:-0.8209                                                                                                                                                                                                                                                                              
    ##  Median : 0.6993                                                                                                                                                                                                                                                                              
    ##  Mean   : 0.0000                                                                                                                                                                                                                                                                              
    ##  3rd Qu.: 0.6993                                                                                                                                                                                                                                                                              
    ##  Max.   : 0.6993                                                                                                                                                                                                                                                                              
    ##  NA's   :1                                                                                                                                                                                                                                                                                    
    ##  C - 11. The division of theory and practice such that most of the theory is done during the recorded online classes and most of the practice is done during the physical classes
    ##  Min.   :-3.6142                                                                                                                                                                 
    ##  1st Qu.:-0.7112                                                                                                                                                                 
    ##  Median : 0.7403                                                                                                                                                                 
    ##  Mean   : 0.0000                                                                                                                                                                 
    ##  3rd Qu.: 0.7403                                                                                                                                                                 
    ##  Max.   : 0.7403                                                                                                                                                                 
    ##  NA's   :1                                                                                                                                                                       
    ##  C - 12. The recordings of online classes
    ##  Min.   :-2.7301                         
    ##  1st Qu.:-0.3867                         
    ##  Median : 0.7850                         
    ##  Mean   : 0.0000                         
    ##  3rd Qu.: 0.7850                         
    ##  Max.   : 0.7850                         
    ##  NA's   :1                               
    ##  D - 1. Write two things you like about the teaching and learning in this unit so far.
    ##  Length:101                                                                           
    ##  Class :character                                                                     
    ##  Mode  :character                                                                     
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##  D - 2. Write at least one recommendation to improve the teaching and learning in this unit (for the remaining weeks in the semester)
    ##  Length:101                                                                                                                          
    ##  Class :character                                                                                                                    
    ##  Mode  :character                                                                                                                    
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##  Average Course Evaluation Rating Average Level of Learning Attained Rating
    ##  Min.   :-4.05150                 Min.   :-2.9674                          
    ##  1st Qu.:-0.64504                 1st Qu.:-0.8428                          
    ##  Median : 0.03645                 Median :-0.1346                          
    ##  Mean   : 0.00000                 Mean   : 0.0000                          
    ##  3rd Qu.: 0.94477                 3rd Qu.: 0.5736                          
    ##  Max.   : 1.17185                 Max.   : 1.2818                          
    ##  NA's   :1                        NA's   :1                                
    ##  Average Pedagogical Strategy Effectiveness Rating
    ##  Min.   :-2.4737                                  
    ##  1st Qu.:-0.7196                                  
    ##  Median : 0.2250                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.9445                                  
    ##  Max.   : 1.1244                                  
    ##  NA's   :1                                        
    ##  Project: Section 1-4: (20%) x/10 Project: Section 5-11: (50%) x/10
    ##  Min.   :-3.8114                  Min.   :-2.3600                  
    ##  1st Qu.:-0.2907                  1st Qu.:-0.2087                  
    ##  Median : 0.2327                  Median : 0.4366                  
    ##  Mean   : 0.0000                  Mean   : 0.0000                  
    ##  3rd Qu.: 0.4706                  3rd Qu.: 0.6159                  
    ##  Max.   : 0.9464                  Max.   : 1.2255                  
    ##                                                                    
    ##  Project: Section 12: (30%) x/5 Project: (10%): x/30 x 100 TOTAL
    ##  Min.   :-0.5683                Min.   :-3.0961                 
    ##  1st Qu.:-0.5683                1st Qu.:-0.3172                 
    ##  Median :-0.5683                Median : 0.1989                 
    ##  Mean   : 0.0000                Mean   : 0.0000                 
    ##  3rd Qu.: 0.1316                3rd Qu.: 0.4569                 
    ##  Max.   : 2.2310                Max.   : 1.8662                 
    ##  NA's   :1                                                      
    ##  Quiz 1 on Concept 1 (Introduction) x/32 Quiz 3 on Concept 3 (Linear) x/15
    ##  Min.   :-1.7842                         Min.   :-2.1031                  
    ##  1st Qu.:-0.7420                         1st Qu.:-0.8149                  
    ##  Median :-0.1578                         Median :-0.1708                  
    ##  Mean   : 0.0000                         Mean   : 0.0000                  
    ##  3rd Qu.: 0.5032                         3rd Qu.: 0.7954                  
    ##  Max.   : 2.2894                         Max.   : 1.7615                  
    ##                                          NA's   :2                        
    ##  Quiz 4 on Concept 4 (Non-Linear) x/22 Quiz 5 on Concept 5 (Dashboarding) x/10
    ##  Min.   :-2.46748                      Min.   :-3.03179                       
    ##  1st Qu.:-0.68157                      1st Qu.:-0.65108                       
    ##  Median :-0.09831                      Median :-0.01782                       
    ##  Mean   : 0.00000                      Mean   : 0.00000                       
    ##  3rd Qu.: 0.80424                      3rd Qu.: 0.77734                       
    ##  Max.   : 1.81960                      Max.   : 3.00092                       
    ##  NA's   :6                             NA's   :12                             
    ##  Quizzes and  Bonus Marks (7%): x/79 x 100 TOTAL
    ##  Min.   :-1.81638                               
    ##  1st Qu.:-0.75175                               
    ##  Median :-0.05512                               
    ##  Mean   : 0.00000                               
    ##  3rd Qu.: 0.54207                               
    ##  Max.   : 2.36638                               
    ##                                                 
    ##  Lab 1 - 2.c. - (Simple Linear Regression) x/5
    ##  Min.   :-4.8297                              
    ##  1st Qu.: 0.2597                              
    ##  Median : 0.2597                              
    ##  Mean   : 0.0000                              
    ##  3rd Qu.: 0.2597                              
    ##  Max.   : 0.2597                              
    ##  NA's   :3                                    
    ##  Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5
    ##  Min.   :-1.9485                                               
    ##  1st Qu.:-0.9821                                               
    ##  Median : 0.6607                                               
    ##  Mean   : 0.0000                                               
    ##  3rd Qu.: 0.8056                                               
    ##  Max.   : 0.8056                                               
    ##  NA's   :6                                                     
    ##  Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5
    ##  Min.   :-2.7794                                                
    ##  1st Qu.: 0.3431                                                
    ##  Median : 0.3431                                                
    ##  Mean   : 0.0000                                                
    ##  3rd Qu.: 0.3431                                                
    ##  Max.   : 0.5773                                                
    ##  NA's   :9                                                      
    ##  Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5
    ##  Min.   :-2.8586                                  
    ##  1st Qu.:-0.3605                                  
    ##  Median : 0.4722                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.6387                                  
    ##  Max.   : 0.6387                                  
    ##  NA's   :18                                       
    ##  Lab 5 - Chart JS Dashboard Setup x/5 Lab Work (7%) x/25 x 100
    ##  Min.   :-1.4592                      Min.   :-3.20757        
    ##  1st Qu.:-1.4592                      1st Qu.:-0.46190        
    ##  Median : 0.6842                      Median : 0.01471        
    ##  Mean   : 0.0000                      Mean   : 0.00000        
    ##  3rd Qu.: 0.6842                      3rd Qu.: 0.90576        
    ##  Max.   : 0.6842                      Max.   : 1.05081        
    ##                                                               
    ##  CAT 1 (8%): x/38 x 100 CAT 2 (8%): x/100 x 100
    ##  Min.   :-2.41349       Min.   :-2.51821       
    ##  1st Qu.:-0.67329       1st Qu.:-0.45107       
    ##  Median : 0.02226       Median : 0.05559       
    ##  Mean   : 0.00000       Mean   : 0.00000       
    ##  3rd Qu.: 0.89236       3rd Qu.: 0.79530       
    ##  Max.   : 1.84908       Max.   : 1.53501       
    ##  NA's   :4              NA's   :31             
    ##  Attendance Waiver Granted: 1 = Yes, 0 = No Absenteeism Percentage
    ##  Min.   :-0.2271                            Min.   :-1.69613      
    ##  1st Qu.:-0.2271                            1st Qu.:-0.88083      
    ##  Median :-0.2271                            Median :-0.06663      
    ##  Mean   : 0.0000                            Mean   : 0.00000      
    ##  3rd Qu.:-0.2271                            3rd Qu.: 0.74867      
    ##  Max.   : 4.3600                            Max.   : 4.00877      
    ##                                                                   
    ##  Coursework TOTAL: x/40 (40%) EXAM: x/60 (60%)   
    ##  Min.   :-2.74036             Min.   :-2.570415  
    ##  1st Qu.:-0.65650             1st Qu.:-0.705101  
    ##  Median : 0.00867             Median : 0.005494  
    ##  Mean   : 0.00000             Mean   : 0.000000  
    ##  3rd Qu.: 0.76863             3rd Qu.: 0.716090  
    ##  Max.   : 1.69569             Max.   : 1.959633  
    ##                               NA's   :4          
    ##  TOTAL = Coursework TOTAL + EXAM (100%)    GRADE          
    ##  Min.   :-3.15733                       Length:101        
    ##  1st Qu.:-0.73640                       Class :character  
    ##  Median : 0.09983                       Mode  :character  
    ##  Mean   : 0.00000                                         
    ##  3rd Qu.: 0.74465                                         
    ##  Max.   : 1.94590                                         
    ## 

``` r
sapply(student_dataset_standardize_transform[, 4], sd)
```

    ## regret_choosing_bi 
    ##                  1

## STEP 5. Apply a Standardize Data Transform —-

``` r
### The Standardize Basic Transform on the StudentDataset ----
# BEFORE
summary(StudentPerformanceDataset)
```

    ##  class_group            gender            YOB       regret_choosing_bi
    ##  Length:101         Min.   :0.0000   Min.   :1998   Min.   :0.0000    
    ##  Class :character   1st Qu.:0.0000   1st Qu.:2000   1st Qu.:0.0000    
    ##  Mode  :character   Median :1.0000   Median :2001   Median :0.0000    
    ##                     Mean   :0.5743   Mean   :2001   Mean   :0.0198    
    ##                     3rd Qu.:1.0000   3rd Qu.:2002   3rd Qu.:0.0000    
    ##                     Max.   :1.0000   Max.   :2003   Max.   :1.0000    
    ##                                                                       
    ##   drop_bi_now       motivator      read_content_before_lecture
    ##  Min.   :0.0000   Min.   :0.0000   Min.   :1.000              
    ##  1st Qu.:0.0000   1st Qu.:1.0000   1st Qu.:2.000              
    ##  Median :0.0000   Median :1.0000   Median :3.000              
    ##  Mean   :0.0198   Mean   :0.7525   Mean   :2.752              
    ##  3rd Qu.:0.0000   3rd Qu.:1.0000   3rd Qu.:3.000              
    ##  Max.   :1.0000   Max.   :1.0000   Max.   :5.000              
    ##                                                               
    ##  anticipate_test_questions answer_rhetorical_questions find_terms_I_do_not_know
    ##  Min.   :1.000             Min.   :1.000               Min.   :1.000           
    ##  1st Qu.:3.000             1st Qu.:3.000               1st Qu.:3.000           
    ##  Median :4.000             Median :4.000               Median :4.000           
    ##  Mean   :3.584             Mean   :3.426               Mean   :3.743           
    ##  3rd Qu.:4.000             3rd Qu.:4.000               3rd Qu.:5.000           
    ##  Max.   :5.000             Max.   :5.000               Max.   :5.000           
    ##                                                                                
    ##  copy_new_terms_in_reading_notebook take_quizzes_and_use_results
    ##  Min.   :1.000                      Min.   :1.000               
    ##  1st Qu.:3.000                      1st Qu.:3.000               
    ##  Median :4.000                      Median :4.000               
    ##  Mean   :3.663                      Mean   :3.941               
    ##  3rd Qu.:4.000                      3rd Qu.:5.000               
    ##  Max.   :5.000                      Max.   :5.000               
    ##                                                                 
    ##  reorganise_course_outline write_down_important_points space_out_revision
    ##  Min.   :1.000             Min.   :1.000               Min.   :1.000     
    ##  1st Qu.:3.000             1st Qu.:3.000               1st Qu.:3.000     
    ##  Median :3.000             Median :4.000               Median :3.000     
    ##  Mean   :3.376             Mean   :3.832               Mean   :3.228     
    ##  3rd Qu.:4.000             3rd Qu.:5.000               3rd Qu.:4.000     
    ##  Max.   :5.000             Max.   :5.000               Max.   :5.000     
    ##                                                                          
    ##  studying_in_study_group schedule_appointments goal_oriented  
    ##  Min.   :1.000           Min.   :1.000         Min.   :0.000  
    ##  1st Qu.:1.000           1st Qu.:1.000         1st Qu.:0.000  
    ##  Median :2.000           Median :2.000         Median :0.000  
    ##  Mean   :2.455           Mean   :1.931         Mean   :0.198  
    ##  3rd Qu.:3.000           3rd Qu.:2.000         3rd Qu.:0.000  
    ##  Max.   :5.000           Max.   :5.000         Max.   :1.000  
    ##                                                               
    ##  spaced_repetition testing_and_active_recall  interleaving    categorizing  
    ##  Min.   :1.000     Min.   :1.000             Min.   :1.000   Min.   :1.000  
    ##  1st Qu.:2.000     1st Qu.:3.000             1st Qu.:2.000   1st Qu.:2.000  
    ##  Median :3.000     Median :3.000             Median :2.000   Median :3.000  
    ##  Mean   :2.554     Mean   :3.059             Mean   :2.257   Mean   :2.713  
    ##  3rd Qu.:3.000     3rd Qu.:4.000             3rd Qu.:3.000   3rd Qu.:3.000  
    ##  Max.   :4.000     Max.   :4.000             Max.   :4.000   Max.   :4.000  
    ##                                                                             
    ##  retrospective_timetable cornell_notes        sq3r          commute    
    ##  Min.   :1.000           Min.   :1.000   Min.   :1.000   Min.   :1.00  
    ##  1st Qu.:2.000           1st Qu.:2.000   1st Qu.:2.000   1st Qu.:2.00  
    ##  Median :2.000           Median :3.000   Median :3.000   Median :3.00  
    ##  Mean   :2.406           Mean   :2.545   Mean   :2.614   Mean   :2.73  
    ##  3rd Qu.:3.000           3rd Qu.:3.000   3rd Qu.:3.000   3rd Qu.:4.00  
    ##  Max.   :4.000           Max.   :4.000   Max.   :4.000   Max.   :4.00  
    ##                                                          NA's   :1     
    ##    study_time   repeats_since_Y1  paid_tuition   free_tuition  extra_curricular
    ##  Min.   :1.00   Min.   : 0.00    Min.   :0.00   Min.   :0.00   Min.   :0.00    
    ##  1st Qu.:1.00   1st Qu.: 0.00    1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00    
    ##  Median :2.00   Median : 2.00    Median :0.00   Median :0.00   Median :1.00    
    ##  Mean   :1.75   Mean   : 2.05    Mean   :0.11   Mean   :0.27   Mean   :0.53    
    ##  3rd Qu.:2.00   3rd Qu.: 3.00    3rd Qu.:0.00   3rd Qu.:1.00   3rd Qu.:1.00    
    ##  Max.   :4.00   Max.   :10.00    Max.   :1.00   Max.   :1.00   Max.   :1.00    
    ##  NA's   :1      NA's   :1        NA's   :1      NA's   :1      NA's   :1       
    ##  sports_extra_curricular exercise_per_week    meditate         pray     
    ##  Min.   :0.00            Min.   :0.0       Min.   :0.00   Min.   :0.00  
    ##  1st Qu.:0.00            1st Qu.:1.0       1st Qu.:0.00   1st Qu.:1.00  
    ##  Median :0.00            Median :1.0       Median :1.00   Median :2.00  
    ##  Mean   :0.36            Mean   :1.1       Mean   :0.76   Mean   :2.09  
    ##  3rd Qu.:1.00            3rd Qu.:2.0       3rd Qu.:1.00   3rd Qu.:3.00  
    ##  Max.   :1.00            Max.   :3.0       Max.   :3.00   Max.   :3.00  
    ##  NA's   :1               NA's   :1         NA's   :1      NA's   :1     
    ##     internet        laptop  family_relationships  friendships  
    ##  Min.   :0.00   Min.   :1   Min.   :2.00         Min.   :2.00  
    ##  1st Qu.:1.00   1st Qu.:1   1st Qu.:4.00         1st Qu.:4.00  
    ##  Median :1.00   Median :1   Median :4.00         Median :4.00  
    ##  Mean   :0.87   Mean   :1   Mean   :4.19         Mean   :4.01  
    ##  3rd Qu.:1.00   3rd Qu.:1   3rd Qu.:5.00         3rd Qu.:4.00  
    ##  Max.   :1.00   Max.   :1   Max.   :5.00         Max.   :5.00  
    ##  NA's   :1      NA's   :1   NA's   :1            NA's   :1     
    ##  romantic_relationships spiritual_wellnes financial_wellness     health    
    ##  Min.   :0.00           Min.   :1.00      Min.   :1.00       Min.   :1.00  
    ##  1st Qu.:0.00           1st Qu.:3.00      1st Qu.:2.00       1st Qu.:3.00  
    ##  Median :0.00           Median :4.00      Median :3.00       Median :4.00  
    ##  Mean   :1.37           Mean   :3.65      Mean   :3.03       Mean   :4.04  
    ##  3rd Qu.:3.00           3rd Qu.:4.00      3rd Qu.:4.00       3rd Qu.:5.00  
    ##  Max.   :4.00           Max.   :5.00      Max.   :5.00       Max.   :5.00  
    ##  NA's   :1              NA's   :1         NA's   :1          NA's   :1     
    ##     day_out      night_out    alcohol_or_narcotics     mentor    
    ##  Min.   :0.0   Min.   :0.00   Min.   :0.00         Min.   :0.00  
    ##  1st Qu.:0.0   1st Qu.:0.00   1st Qu.:0.00         1st Qu.:0.00  
    ##  Median :1.0   Median :0.00   Median :0.00         Median :0.00  
    ##  Mean   :0.8   Mean   :0.51   Mean   :0.35         Mean   :0.41  
    ##  3rd Qu.:1.0   3rd Qu.:1.00   3rd Qu.:1.00         3rd Qu.:1.00  
    ##  Max.   :3.0   Max.   :3.00   Max.   :3.00         Max.   :1.00  
    ##  NA's   :1     NA's   :1      NA's   :1            NA's   :1     
    ##  mentor_meetings A - 1. I am enjoying the subject
    ##  Min.   :0.00    Min.   :3.00                    
    ##  1st Qu.:0.00    1st Qu.:4.00                    
    ##  Median :0.00    Median :5.00                    
    ##  Mean   :0.68    Mean   :4.49                    
    ##  3rd Qu.:1.00    3rd Qu.:5.00                    
    ##  Max.   :3.00    Max.   :5.00                    
    ##  NA's   :1       NA's   :1                       
    ##  A - 2. Classes start and end on time
    ##  Min.   :3.00                        
    ##  1st Qu.:4.00                        
    ##  Median :5.00                        
    ##  Mean   :4.68                        
    ##  3rd Qu.:5.00                        
    ##  Max.   :5.00                        
    ##  NA's   :1                           
    ##  A - 3. The learning environment is participative, involves learning by doing and is group-based
    ##  Min.   :3.00                                                                                   
    ##  1st Qu.:4.00                                                                                   
    ##  Median :4.00                                                                                   
    ##  Mean   :4.35                                                                                   
    ##  3rd Qu.:5.00                                                                                   
    ##  Max.   :5.00                                                                                   
    ##  NA's   :1                                                                                      
    ##  A - 4. The subject content is delivered according to the course outline and meets my expectations
    ##  Min.   :3.00                                                                                     
    ##  1st Qu.:4.75                                                                                     
    ##  Median :5.00                                                                                     
    ##  Mean   :4.74                                                                                     
    ##  3rd Qu.:5.00                                                                                     
    ##  Max.   :5.00                                                                                     
    ##  NA's   :1                                                                                        
    ##  A - 5. The topics are clear and logically developed
    ##  Min.   :2.00                                       
    ##  1st Qu.:4.00                                       
    ##  Median :5.00                                       
    ##  Mean   :4.65                                       
    ##  3rd Qu.:5.00                                       
    ##  Max.   :5.00                                       
    ##  NA's   :1                                          
    ##  A - 6. I am developing my oral and writing skills
    ##  Min.   :1.00                                     
    ##  1st Qu.:4.00                                     
    ##  Median :4.00                                     
    ##  Mean   :4.11                                     
    ##  3rd Qu.:5.00                                     
    ##  Max.   :5.00                                     
    ##  NA's   :1                                        
    ##  A - 7. I am developing my reflective and critical reasoning skills
    ##  Min.   :2.00                                                      
    ##  1st Qu.:4.00                                                      
    ##  Median :4.00                                                      
    ##  Mean   :4.38                                                      
    ##  3rd Qu.:5.00                                                      
    ##  Max.   :5.00                                                      
    ##  NA's   :1                                                         
    ##  A - 8. The assessment methods are assisting me to learn
    ##  Min.   :1.00                                           
    ##  1st Qu.:4.00                                           
    ##  Median :5.00                                           
    ##  Mean   :4.61                                           
    ##  3rd Qu.:5.00                                           
    ##  Max.   :5.00                                           
    ##  NA's   :1                                              
    ##  A - 9. I receive relevant feedback
    ##  Min.   :3.00                      
    ##  1st Qu.:4.00                      
    ##  Median :5.00                      
    ##  Mean   :4.58                      
    ##  3rd Qu.:5.00                      
    ##  Max.   :5.00                      
    ##  NA's   :1                         
    ##  A - 10. I read the recommended readings and notes
    ##  Min.   :3.00                                     
    ##  1st Qu.:4.00                                     
    ##  Median :5.00                                     
    ##  Mean   :4.55                                     
    ##  3rd Qu.:5.00                                     
    ##  Max.   :5.00                                     
    ##  NA's   :1                                        
    ##  A - 11. I use the eLearning material posted
    ##  Min.   :3.0                                
    ##  1st Qu.:4.0                                
    ##  Median :5.0                                
    ##  Mean   :4.7                                
    ##  3rd Qu.:5.0                                
    ##  Max.   :5.0                                
    ##  NA's   :1                                  
    ##  B - 1. Concept 1 of 6: Principles of Business Intelligence and the DataOps Philosophy
    ##  Min.   :1.00                                                                         
    ##  1st Qu.:4.00                                                                         
    ##  Median :4.00                                                                         
    ##  Mean   :4.25                                                                         
    ##  3rd Qu.:5.00                                                                         
    ##  Max.   :5.00                                                                         
    ##  NA's   :1                                                                            
    ##  B - 2. Concept 3 of 6: Linear Algorithms for Predictive Analytics
    ##  Min.   :2.00                                                     
    ##  1st Qu.:3.00                                                     
    ##  Median :4.00                                                     
    ##  Mean   :3.94                                                     
    ##  3rd Qu.:5.00                                                     
    ##  Max.   :5.00                                                     
    ##  NA's   :1                                                        
    ##  C - 2. Quizzes at the end of each concept
    ##  Min.   :2.00                             
    ##  1st Qu.:4.00                             
    ##  Median :5.00                             
    ##  Mean   :4.59                             
    ##  3rd Qu.:5.00                             
    ##  Max.   :5.00                             
    ##  NA's   :1                                
    ##  C - 3. Lab manuals that outline the steps to follow during the labs
    ##  Min.   :3.00                                                       
    ##  1st Qu.:4.00                                                       
    ##  Median :5.00                                                       
    ##  Mean   :4.61                                                       
    ##  3rd Qu.:5.00                                                       
    ##  Max.   :5.00                                                       
    ##  NA's   :1                                                          
    ##  C - 4. Required lab work submissions at the end of each lab manual that outline the activity to be done on your own
    ##  Min.   :3.00                                                                                                       
    ##  1st Qu.:4.00                                                                                                       
    ##  Median :5.00                                                                                                       
    ##  Mean   :4.55                                                                                                       
    ##  3rd Qu.:5.00                                                                                                       
    ##  Max.   :5.00                                                                                                       
    ##  NA's   :1                                                                                                          
    ##  C - 5. Supplementary videos to watch
    ##  Min.   :1.00                        
    ##  1st Qu.:4.00                        
    ##  Median :4.00                        
    ##  Mean   :4.19                        
    ##  3rd Qu.:5.00                        
    ##  Max.   :5.00                        
    ##  NA's   :1                           
    ##  C - 6. Supplementary podcasts to listen to
    ##  Min.   :1.00                              
    ##  1st Qu.:4.00                              
    ##  Median :4.00                              
    ##  Mean   :4.08                              
    ##  3rd Qu.:5.00                              
    ##  Max.   :5.00                              
    ##  NA's   :1                                 
    ##  C - 7. Supplementary content to read C - 8. Lectures slides
    ##  Min.   :1.00                         Min.   :2.0           
    ##  1st Qu.:4.00                         1st Qu.:4.0           
    ##  Median :4.00                         Median :5.0           
    ##  Mean   :4.17                         Mean   :4.6           
    ##  3rd Qu.:5.00                         3rd Qu.:5.0           
    ##  Max.   :5.00                         Max.   :5.0           
    ##  NA's   :1                            NA's   :1             
    ##  C - 9. Lecture notes on some of the lecture slides
    ##  Min.   :2.0                                       
    ##  1st Qu.:4.0                                       
    ##  Median :5.0                                       
    ##  Mean   :4.6                                       
    ##  3rd Qu.:5.0                                       
    ##  Max.   :5.0                                       
    ##  NA's   :1                                         
    ##  C - 10. The quality of the lectures given (quality measured by the breadth (the full span of knowledge of a subject) and depth (the extent to which specific topics are focused upon, amplified, and explored) of learning - NOT quality measured by how fun/comical/lively the lectures are)
    ##  Min.   :2.00                                                                                                                                                                                                                                                                                 
    ##  1st Qu.:4.00                                                                                                                                                                                                                                                                                 
    ##  Median :5.00                                                                                                                                                                                                                                                                                 
    ##  Mean   :4.54                                                                                                                                                                                                                                                                                 
    ##  3rd Qu.:5.00                                                                                                                                                                                                                                                                                 
    ##  Max.   :5.00                                                                                                                                                                                                                                                                                 
    ##  NA's   :1                                                                                                                                                                                                                                                                                    
    ##  C - 11. The division of theory and practice such that most of the theory is done during the recorded online classes and most of the practice is done during the physical classes
    ##  Min.   :2.00                                                                                                                                                                    
    ##  1st Qu.:4.00                                                                                                                                                                    
    ##  Median :5.00                                                                                                                                                                    
    ##  Mean   :4.49                                                                                                                                                                    
    ##  3rd Qu.:5.00                                                                                                                                                                    
    ##  Max.   :5.00                                                                                                                                                                    
    ##  NA's   :1                                                                                                                                                                       
    ##  C - 12. The recordings of online classes
    ##  Min.   :2.00                            
    ##  1st Qu.:4.00                            
    ##  Median :5.00                            
    ##  Mean   :4.33                            
    ##  3rd Qu.:5.00                            
    ##  Max.   :5.00                            
    ##  NA's   :1                               
    ##  D - 1. Write two things you like about the teaching and learning in this unit so far.
    ##  Length:101                                                                           
    ##  Class :character                                                                     
    ##  Mode  :character                                                                     
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##  D - 2. Write at least one recommendation to improve the teaching and learning in this unit (for the remaining weeks in the semester)
    ##  Length:101                                                                                                                          
    ##  Class :character                                                                                                                    
    ##  Mode  :character                                                                                                                    
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##  Average Course Evaluation Rating Average Level of Learning Attained Rating
    ##  Min.   :2.909                    Min.   :2.000                            
    ##  1st Qu.:4.273                    1st Qu.:3.500                            
    ##  Median :4.545                    Median :4.000                            
    ##  Mean   :4.531                    Mean   :4.095                            
    ##  3rd Qu.:4.909                    3rd Qu.:4.500                            
    ##  Max.   :5.000                    Max.   :5.000                            
    ##  NA's   :1                        NA's   :1                                
    ##  Average Pedagogical Strategy Effectiveness Rating
    ##  Min.   :3.182                                    
    ##  1st Qu.:4.068                                    
    ##  Median :4.545                                    
    ##  Mean   :4.432                                    
    ##  3rd Qu.:4.909                                    
    ##  Max.   :5.000                                    
    ##  NA's   :1                                        
    ##  Project: Section 1-4: (20%) x/10 Project: Section 5-11: (50%) x/10
    ##  Min.   : 0.000                   Min.   : 0.000                   
    ##  1st Qu.: 7.400                   1st Qu.: 6.000                   
    ##  Median : 8.500                   Median : 7.800                   
    ##  Mean   : 8.011                   Mean   : 6.582                   
    ##  3rd Qu.: 9.000                   3rd Qu.: 8.300                   
    ##  Max.   :10.000                   Max.   :10.000                   
    ##                                                                    
    ##  Project: Section 12: (30%) x/5 Project: (10%): x/30 x 100 TOTAL
    ##  Min.   :0.000                  Min.   :  0.00                  
    ##  1st Qu.:0.000                  1st Qu.: 56.00                  
    ##  Median :0.000                  Median : 66.40                  
    ##  Mean   :1.015                  Mean   : 62.39                  
    ##  3rd Qu.:1.250                  3rd Qu.: 71.60                  
    ##  Max.   :5.000                  Max.   :100.00                  
    ##  NA's   :1                                                      
    ##  Quiz 1 on Concept 1 (Introduction) x/32 Quiz 3 on Concept 3 (Linear) x/15
    ##  Min.   : 4.75                           Min.   : 3.00                    
    ##  1st Qu.:11.53                           1st Qu.: 7.00                    
    ##  Median :15.33                           Median : 9.00                    
    ##  Mean   :16.36                           Mean   : 9.53                    
    ##  3rd Qu.:19.63                           3rd Qu.:12.00                    
    ##  Max.   :31.25                           Max.   :15.00                    
    ##                                          NA's   :2                        
    ##  Quiz 4 on Concept 4 (Non-Linear) x/22 Quiz 5 on Concept 5 (Dashboarding) x/10
    ##  Min.   : 3.00                         Min.   : 0.000                         
    ##  1st Qu.:10.91                         1st Qu.: 5.000                         
    ##  Median :13.50                         Median : 6.330                         
    ##  Mean   :13.94                         Mean   : 6.367                         
    ##  3rd Qu.:17.50                         3rd Qu.: 8.000                         
    ##  Max.   :22.00                         Max.   :12.670                         
    ##  NA's   :6                             NA's   :12                             
    ##  Quizzes and  Bonus Marks (7%): x/79 x 100 TOTAL
    ##  Min.   :26.26                                  
    ##  1st Qu.:43.82                                  
    ##  Median :55.31                                  
    ##  Mean   :56.22                                  
    ##  3rd Qu.:65.16                                  
    ##  Max.   :95.25                                  
    ##                                                 
    ##  Lab 1 - 2.c. - (Simple Linear Regression) x/5
    ##  Min.   :3.000                                
    ##  1st Qu.:5.000                                
    ##  Median :5.000                                
    ##  Mean   :4.898                                
    ##  3rd Qu.:5.000                                
    ##  Max.   :5.000                                
    ##  NA's   :3                                    
    ##  Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5
    ##  Min.   :2.150                                                 
    ##  1st Qu.:3.150                                                 
    ##  Median :4.850                                                 
    ##  Mean   :4.166                                                 
    ##  3rd Qu.:5.000                                                 
    ##  Max.   :5.000                                                 
    ##  NA's   :6                                                     
    ##  Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5
    ##  Min.   :2.85                                                   
    ##  1st Qu.:4.85                                                   
    ##  Median :4.85                                                   
    ##  Mean   :4.63                                                   
    ##  3rd Qu.:4.85                                                   
    ##  Max.   :5.00                                                   
    ##  NA's   :9                                                      
    ##  Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5
    ##  Min.   :1.850                                    
    ##  1st Qu.:4.100                                    
    ##  Median :4.850                                    
    ##  Mean   :4.425                                    
    ##  3rd Qu.:5.000                                    
    ##  Max.   :5.000                                    
    ##  NA's   :18                                       
    ##  Lab 5 - Chart JS Dashboard Setup x/5 Lab Work (7%) x/25 x 100
    ##  Min.   :0.000                        Min.   : 17.80          
    ##  1st Qu.:0.000                        1st Qu.: 70.80          
    ##  Median :5.000                        Median : 80.00          
    ##  Mean   :3.404                        Mean   : 79.72          
    ##  3rd Qu.:5.000                        3rd Qu.: 97.20          
    ##  Max.   :5.000                        Max.   :100.00          
    ##                                                               
    ##  CAT 1 (8%): x/38 x 100 CAT 2 (8%): x/100 x 100
    ##  Min.   :32.89          Min.   :  0.00         
    ##  1st Qu.:59.21          1st Qu.: 51.00         
    ##  Median :69.73          Median : 63.50         
    ##  Mean   :69.39          Mean   : 62.13         
    ##  3rd Qu.:82.89          3rd Qu.: 81.75         
    ##  Max.   :97.36          Max.   :100.00         
    ##  NA's   :4              NA's   :31             
    ##  Attendance Waiver Granted: 1 = Yes, 0 = No Absenteeism Percentage
    ##  Min.   :0.00000                            Min.   : 0.00         
    ##  1st Qu.:0.00000                            1st Qu.: 7.41         
    ##  Median :0.00000                            Median :14.81         
    ##  Mean   :0.04951                            Mean   :15.42         
    ##  3rd Qu.:0.00000                            3rd Qu.:22.22         
    ##  Max.   :1.00000                            Max.   :51.85         
    ##                                                                   
    ##  Coursework TOTAL: x/40 (40%) EXAM: x/60 (60%)
    ##  Min.   : 7.47                Min.   : 5.00   
    ##  1st Qu.:20.44                1st Qu.:26.00   
    ##  Median :24.58                Median :34.00   
    ##  Mean   :24.53                Mean   :33.94   
    ##  3rd Qu.:29.31                3rd Qu.:42.00   
    ##  Max.   :35.08                Max.   :56.00   
    ##                               NA's   :4       
    ##  TOTAL = Coursework TOTAL + EXAM (100%)    GRADE          
    ##  Min.   : 7.47                          Length:101        
    ##  1st Qu.:45.54                          Class :character  
    ##  Median :58.69                          Mode  :character  
    ##  Mean   :57.12                                            
    ##  3rd Qu.:68.83                                            
    ##  Max.   :87.72                                            
    ## 

``` r
sapply(StudentPerformanceDataset[, 4], sd)
```

    ## regret_choosing_bi 
    ##          0.1400141

``` r
model_of_the_transform <- preProcess(StudentPerformanceDataset,
                                     method = c("scale", "center"))
print(model_of_the_transform)
```

    ## Created from 51 samples and 100 variables
    ## 
    ## Pre-processing:
    ##   - centered (96)
    ##   - ignored (4)
    ##   - scaled (96)

``` r
student_dataset_standardize_transform <- predict(model_of_the_transform, StudentPerformanceDataset) # nolint

# AFTER
summary(student_dataset_standardize_transform)
```

    ##  class_group            gender             YOB          regret_choosing_bi
    ##  Length:101         Min.   :-1.1556   Min.   :-2.9155   Min.   :-0.1414   
    ##  Class :character   1st Qu.:-1.1556   1st Qu.:-0.9055   1st Qu.:-0.1414   
    ##  Mode  :character   Median : 0.8568   Median : 0.0995   Median :-0.1414   
    ##                     Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   
    ##                     3rd Qu.: 0.8568   3rd Qu.: 1.1045   3rd Qu.:-0.1414   
    ##                     Max.   : 0.8568   Max.   : 2.1095   Max.   : 7.0007   
    ##                                                                           
    ##   drop_bi_now        motivator       read_content_before_lecture
    ##  Min.   :-0.1414   Min.   :-1.7349   Min.   :-1.8191            
    ##  1st Qu.:-0.1414   1st Qu.: 0.5707   1st Qu.:-0.7811            
    ##  Median :-0.1414   Median : 0.5707   Median : 0.2569            
    ##  Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000            
    ##  3rd Qu.:-0.1414   3rd Qu.: 0.5707   3rd Qu.: 0.2569            
    ##  Max.   : 7.0007   Max.   : 0.5707   Max.   : 2.3329            
    ##                                                                 
    ##  anticipate_test_questions answer_rhetorical_questions find_terms_I_do_not_know
    ##  Min.   :-2.6033           Min.   :-2.4418             Min.   :-2.5995         
    ##  1st Qu.:-0.5885           1st Qu.:-0.4286             1st Qu.:-0.7038         
    ##  Median : 0.4189           Median : 0.5780             Median : 0.2440         
    ##  Mean   : 0.0000           Mean   : 0.0000             Mean   : 0.0000         
    ##  3rd Qu.: 0.4189           3rd Qu.: 0.5780             3rd Qu.: 1.1918         
    ##  Max.   : 1.4263           Max.   : 1.5846             Max.   : 1.1918         
    ##                                                                                
    ##  copy_new_terms_in_reading_notebook take_quizzes_and_use_results
    ##  Min.   :-2.4058                    Min.   :-2.73448            
    ##  1st Qu.:-0.5992                    1st Qu.:-0.87466            
    ##  Median : 0.3041                    Median : 0.05524            
    ##  Mean   : 0.0000                    Mean   : 0.00000            
    ##  3rd Qu.: 0.3041                    3rd Qu.: 0.98515            
    ##  Max.   : 1.2074                    Max.   : 0.98515            
    ##                                                                 
    ##  reorganise_course_outline write_down_important_points space_out_revision
    ##  Min.   :-2.0550           Min.   :-2.6276             Min.   :-1.9709   
    ##  1st Qu.:-0.3254           1st Qu.:-0.7717             1st Qu.:-0.2015   
    ##  Median :-0.3254           Median : 0.1562             Median :-0.2015   
    ##  Mean   : 0.0000           Mean   : 0.0000             Mean   : 0.0000   
    ##  3rd Qu.: 0.5394           3rd Qu.: 1.0841             3rd Qu.: 0.6832   
    ##  Max.   : 1.4043           Max.   : 1.0841             Max.   : 1.5679   
    ##                                                                          
    ##  studying_in_study_group schedule_appointments goal_oriented    
    ##  Min.   :-1.0877         Min.   :-0.91037      Min.   :-0.4944  
    ##  1st Qu.:-1.0877         1st Qu.:-0.91037      1st Qu.:-0.4944  
    ##  Median :-0.3404         Median : 0.06779      Median :-0.4944  
    ##  Mean   : 0.0000         Mean   : 0.00000      Mean   : 0.0000  
    ##  3rd Qu.: 0.4070         3rd Qu.: 0.06779      3rd Qu.:-0.4944  
    ##  Max.   : 1.9016         Max.   : 3.00228      Max.   : 2.0025  
    ##                                                                 
    ##  spaced_repetition testing_and_active_recall  interleaving    
    ##  Min.   :-1.8720   Min.   :-2.86572          Min.   :-1.6908  
    ##  1st Qu.:-0.6677   1st Qu.:-0.08267          1st Qu.:-0.3461  
    ##  Median : 0.5366   Median :-0.08267          Median :-0.3461  
    ##  Mean   : 0.0000   Mean   : 0.00000          Mean   : 0.0000  
    ##  3rd Qu.: 0.5366   3rd Qu.: 1.30886          3rd Qu.: 0.9985  
    ##  Max.   : 1.7409   Max.   : 1.30886          Max.   : 2.3432  
    ##                                                               
    ##   categorizing     retrospective_timetable cornell_notes          sq3r        
    ##  Min.   :-2.3165   Min.   :-1.5883         Min.   :-1.5519   Min.   :-1.5392  
    ##  1st Qu.:-0.9641   1st Qu.:-0.4586         1st Qu.:-0.5472   1st Qu.:-0.5855  
    ##  Median : 0.3883   Median :-0.4586         Median : 0.4576   Median : 0.3683  
    ##  Mean   : 0.0000   Mean   : 0.0000         Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 0.3883   3rd Qu.: 0.6711         3rd Qu.: 0.4576   3rd Qu.: 0.3683  
    ##  Max.   : 1.7407   Max.   : 1.8008         Max.   : 1.4624   Max.   : 1.3220  
    ##                                                                               
    ##     commute          study_time      repeats_since_Y1   paid_tuition    
    ##  Min.   :-1.6586   Min.   :-0.9134   Min.   :-0.9716   Min.   :-0.3498  
    ##  1st Qu.:-0.6999   1st Qu.:-0.9134   1st Qu.:-0.9716   1st Qu.:-0.3498  
    ##  Median : 0.2589   Median : 0.3045   Median :-0.0237   Median :-0.3498  
    ##  Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 1.2176   3rd Qu.: 0.3045   3rd Qu.: 0.4502   3rd Qu.:-0.3498  
    ##  Max.   : 1.2176   Max.   : 2.7402   Max.   : 3.7678   Max.   : 2.8302  
    ##  NA's   :1         NA's   :1         NA's   :1         NA's   :1        
    ##   free_tuition     extra_curricular sports_extra_curricular exercise_per_week
    ##  Min.   :-0.6051   Min.   :-1.057   Min.   :-0.7462         Min.   :-1.3575  
    ##  1st Qu.:-0.6051   1st Qu.:-1.057   1st Qu.:-0.7462         1st Qu.:-0.1234  
    ##  Median :-0.6051   Median : 0.937   Median :-0.7462         Median :-0.1234  
    ##  Mean   : 0.0000   Mean   : 0.000   Mean   : 0.0000         Mean   : 0.0000  
    ##  3rd Qu.: 1.6361   3rd Qu.: 0.937   3rd Qu.: 1.3266         3rd Qu.: 1.1107  
    ##  Max.   : 1.6361   Max.   : 0.937   Max.   : 1.3266         Max.   : 2.3448  
    ##  NA's   :1         NA's   :1        NA's   :1               NA's   :1        
    ##     meditate            pray             internet           laptop 
    ##  Min.   :-0.8143   Min.   :-2.03728   Min.   :-2.5740   Min.   :0  
    ##  1st Qu.:-0.8143   1st Qu.:-1.06251   1st Qu.: 0.3846   1st Qu.:0  
    ##  Median : 0.2571   Median :-0.08773   Median : 0.3846   Median :0  
    ##  Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.0000   Mean   :0  
    ##  3rd Qu.: 0.2571   3rd Qu.: 0.88705   3rd Qu.: 0.3846   3rd Qu.:0  
    ##  Max.   : 2.4000   Max.   : 0.88705   Max.   : 0.3846   Max.   :0  
    ##  NA's   :1         NA's   :1          NA's   :1         NA's   :1  
    ##  family_relationships  friendships       romantic_relationships
    ##  Min.   :-2.7369      Min.   :-2.74737   Min.   :-0.8531       
    ##  1st Qu.:-0.2374      1st Qu.:-0.01367   1st Qu.:-0.8531       
    ##  Median :-0.2374      Median :-0.01367   Median :-0.8531       
    ##  Mean   : 0.0000      Mean   : 0.00000   Mean   : 0.0000       
    ##  3rd Qu.: 1.0123      3rd Qu.:-0.01367   3rd Qu.: 1.0150       
    ##  Max.   : 1.0123      Max.   : 1.35318   Max.   : 1.6377       
    ##  NA's   :1            NA's   :1          NA's   :1             
    ##  spiritual_wellnes financial_wellness     health            day_out       
    ##  Min.   :-2.8309   Min.   :-1.85227   Min.   :-3.19122   Min.   :-1.4071  
    ##  1st Qu.:-0.6944   1st Qu.:-0.93982   1st Qu.:-1.09173   1st Qu.:-1.4071  
    ##  Median : 0.3739   Median :-0.02737   Median :-0.04199   Median : 0.3518  
    ##  Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.00000   Mean   : 0.0000  
    ##  3rd Qu.: 0.3739   3rd Qu.: 0.88508   3rd Qu.: 1.00775   3rd Qu.: 0.3518  
    ##  Max.   : 1.4422   Max.   : 1.79752   Max.   : 1.00775   Max.   : 3.8696  
    ##  NA's   :1         NA's   :1          NA's   :1          NA's   :1        
    ##    night_out       alcohol_or_narcotics     mentor        mentor_meetings  
    ##  Min.   :-0.7926   Min.   :-0.628       Min.   :-0.8294   Min.   :-0.8101  
    ##  1st Qu.:-0.7926   1st Qu.:-0.628       1st Qu.:-0.8294   1st Qu.:-0.8101  
    ##  Median :-0.7926   Median :-0.628       Median :-0.8294   Median :-0.8101  
    ##  Mean   : 0.0000   Mean   : 0.000       Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 0.7615   3rd Qu.: 1.166       3rd Qu.: 1.1936   3rd Qu.: 0.3812  
    ##  Max.   : 3.8697   Max.   : 4.755       Max.   : 1.1936   Max.   : 2.7638  
    ##  NA's   :1         NA's   :1            NA's   :1         NA's   :1        
    ##  A - 1. I am enjoying the subject A - 2. Classes start and end on time
    ##  Min.   :-2.5063                  Min.   :-3.4293                     
    ##  1st Qu.:-0.8242                  1st Qu.:-1.3880                     
    ##  Median : 0.8579                  Median : 0.6532                     
    ##  Mean   : 0.0000                  Mean   : 0.0000                     
    ##  3rd Qu.: 0.8579                  3rd Qu.: 0.6532                     
    ##  Max.   : 0.8579                  Max.   : 0.6532                     
    ##  NA's   :1                        NA's   :1                           
    ##  A - 3. The learning environment is participative, involves learning by doing and is group-based
    ##  Min.   :-2.0544                                                                                
    ##  1st Qu.:-0.5326                                                                                
    ##  Median :-0.5326                                                                                
    ##  Mean   : 0.0000                                                                                
    ##  3rd Qu.: 0.9892                                                                                
    ##  Max.   : 0.9892                                                                                
    ##  NA's   :1                                                                                      
    ##  A - 4. The subject content is delivered according to the course outline and meets my expectations
    ##  Min.   :-3.75655                                                                                 
    ##  1st Qu.: 0.02159                                                                                 
    ##  Median : 0.56132                                                                                 
    ##  Mean   : 0.00000                                                                                 
    ##  3rd Qu.: 0.56132                                                                                 
    ##  Max.   : 0.56132                                                                                 
    ##  NA's   :1                                                                                        
    ##  A - 5. The topics are clear and logically developed
    ##  Min.   :-4.6074                                    
    ##  1st Qu.:-1.1301                                    
    ##  Median : 0.6085                                    
    ##  Mean   : 0.0000                                    
    ##  3rd Qu.: 0.6085                                    
    ##  Max.   : 0.6085                                    
    ##  NA's   :1                                          
    ##  A - 6. I am developing my oral and writing skills
    ##  Min.   :-3.5544                                  
    ##  1st Qu.:-0.1257                                  
    ##  Median :-0.1257                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 1.0172                                  
    ##  Max.   : 1.0172                                  
    ##  NA's   :1                                        
    ##  A - 7. I am developing my reflective and critical reasoning skills
    ##  Min.   :-3.4338                                                   
    ##  1st Qu.:-0.5483                                                   
    ##  Median :-0.5483                                                   
    ##  Mean   : 0.0000                                                   
    ##  3rd Qu.: 0.8945                                                   
    ##  Max.   : 0.8945                                                   
    ##  NA's   :1                                                         
    ##  A - 8. The assessment methods are assisting me to learn
    ##  Min.   :-5.5563                                        
    ##  1st Qu.:-0.9389                                        
    ##  Median : 0.6003                                        
    ##  Mean   : 0.0000                                        
    ##  3rd Qu.: 0.6003                                        
    ##  Max.   : 0.6003                                        
    ##  NA's   :1                                              
    ##  A - 9. I receive relevant feedback
    ##  Min.   :-2.8531                   
    ##  1st Qu.:-1.0474                   
    ##  Median : 0.7584                   
    ##  Mean   : 0.0000                   
    ##  3rd Qu.: 0.7584                   
    ##  Max.   : 0.7584                   
    ##  NA's   :1                         
    ##  A - 10. I read the recommended readings and notes
    ##  Min.   :-2.4775                                  
    ##  1st Qu.:-0.8791                                  
    ##  Median : 0.7193                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.7193                                  
    ##  Max.   : 0.7193                                  
    ##  NA's   :1                                        
    ##  A - 11. I use the eLearning material posted
    ##  Min.   :-3.2553                            
    ##  1st Qu.:-1.3404                            
    ##  Median : 0.5745                            
    ##  Mean   : 0.0000                            
    ##  3rd Qu.: 0.5745                            
    ##  Max.   : 0.5745                            
    ##  NA's   :1                                  
    ##  B - 1. Concept 1 of 6: Principles of Business Intelligence and the DataOps Philosophy
    ##  Min.   :-4.1489                                                                      
    ##  1st Qu.:-0.3191                                                                      
    ##  Median :-0.3191                                                                      
    ##  Mean   : 0.0000                                                                      
    ##  3rd Qu.: 0.9574                                                                      
    ##  Max.   : 0.9574                                                                      
    ##  NA's   :1                                                                            
    ##  B - 2. Concept 3 of 6: Linear Algorithms for Predictive Analytics
    ##  Min.   :-2.24938                                                 
    ##  1st Qu.:-1.08990                                                 
    ##  Median : 0.06957                                                 
    ##  Mean   : 0.00000                                                 
    ##  3rd Qu.: 1.22904                                                 
    ##  Max.   : 1.22904                                                 
    ##  NA's   :1                                                        
    ##  C - 2. Quizzes at the end of each concept
    ##  Min.   :-4.1701                          
    ##  1st Qu.:-0.9499                          
    ##  Median : 0.6601                          
    ##  Mean   : 0.0000                          
    ##  3rd Qu.: 0.6601                          
    ##  Max.   : 0.6601                          
    ##  NA's   :1                                
    ##  C - 3. Lab manuals that outline the steps to follow during the labs
    ##  Min.   :-2.6777                                                    
    ##  1st Qu.:-1.0145                                                    
    ##  Median : 0.6486                                                    
    ##  Mean   : 0.0000                                                    
    ##  3rd Qu.: 0.6486                                                    
    ##  Max.   : 0.6486                                                    
    ##  NA's   :1                                                          
    ##  C - 4. Required lab work submissions at the end of each lab manual that outline the activity to be done on your own
    ##  Min.   :-2.5440                                                                                                    
    ##  1st Qu.:-0.9027                                                                                                    
    ##  Median : 0.7386                                                                                                    
    ##  Mean   : 0.0000                                                                                                    
    ##  3rd Qu.: 0.7386                                                                                                    
    ##  Max.   : 0.7386                                                                                                    
    ##  NA's   :1                                                                                                          
    ##  C - 5. Supplementary videos to watch
    ##  Min.   :-3.6080                     
    ##  1st Qu.:-0.2149                     
    ##  Median :-0.2149                     
    ##  Mean   : 0.0000                     
    ##  3rd Qu.: 0.9161                     
    ##  Max.   : 0.9161                     
    ##  NA's   :1                           
    ##  C - 6. Supplementary podcasts to listen to
    ##  Min.   :-3.10583                          
    ##  1st Qu.:-0.08067                          
    ##  Median :-0.08067                          
    ##  Mean   : 0.00000                          
    ##  3rd Qu.: 0.92772                          
    ##  Max.   : 0.92772                          
    ##  NA's   :1                                 
    ##  C - 7. Supplementary content to read C - 8. Lectures slides
    ##  Min.   :-3.2864                      Min.   :-3.5875       
    ##  1st Qu.:-0.1762                      1st Qu.:-0.8279       
    ##  Median :-0.1762                      Median : 0.5519       
    ##  Mean   : 0.0000                      Mean   : 0.0000       
    ##  3rd Qu.: 0.8605                      3rd Qu.: 0.5519       
    ##  Max.   : 0.8605                      Max.   : 0.5519       
    ##  NA's   :1                            NA's   :1             
    ##  C - 9. Lecture notes on some of the lecture slides
    ##  Min.   :-4.0904                                   
    ##  1st Qu.:-0.9439                                   
    ##  Median : 0.6293                                   
    ##  Mean   : 0.0000                                   
    ##  3rd Qu.: 0.6293                                   
    ##  Max.   : 0.6293                                   
    ##  NA's   :1                                         
    ##  C - 10. The quality of the lectures given (quality measured by the breadth (the full span of knowledge of a subject) and depth (the extent to which specific topics are focused upon, amplified, and explored) of learning - NOT quality measured by how fun/comical/lively the lectures are)
    ##  Min.   :-3.8612                                                                                                                                                                                                                                                                              
    ##  1st Qu.:-0.8209                                                                                                                                                                                                                                                                              
    ##  Median : 0.6993                                                                                                                                                                                                                                                                              
    ##  Mean   : 0.0000                                                                                                                                                                                                                                                                              
    ##  3rd Qu.: 0.6993                                                                                                                                                                                                                                                                              
    ##  Max.   : 0.6993                                                                                                                                                                                                                                                                              
    ##  NA's   :1                                                                                                                                                                                                                                                                                    
    ##  C - 11. The division of theory and practice such that most of the theory is done during the recorded online classes and most of the practice is done during the physical classes
    ##  Min.   :-3.6142                                                                                                                                                                 
    ##  1st Qu.:-0.7112                                                                                                                                                                 
    ##  Median : 0.7403                                                                                                                                                                 
    ##  Mean   : 0.0000                                                                                                                                                                 
    ##  3rd Qu.: 0.7403                                                                                                                                                                 
    ##  Max.   : 0.7403                                                                                                                                                                 
    ##  NA's   :1                                                                                                                                                                       
    ##  C - 12. The recordings of online classes
    ##  Min.   :-2.7301                         
    ##  1st Qu.:-0.3867                         
    ##  Median : 0.7850                         
    ##  Mean   : 0.0000                         
    ##  3rd Qu.: 0.7850                         
    ##  Max.   : 0.7850                         
    ##  NA's   :1                               
    ##  D - 1. Write two things you like about the teaching and learning in this unit so far.
    ##  Length:101                                                                           
    ##  Class :character                                                                     
    ##  Mode  :character                                                                     
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##  D - 2. Write at least one recommendation to improve the teaching and learning in this unit (for the remaining weeks in the semester)
    ##  Length:101                                                                                                                          
    ##  Class :character                                                                                                                    
    ##  Mode  :character                                                                                                                    
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##  Average Course Evaluation Rating Average Level of Learning Attained Rating
    ##  Min.   :-4.05150                 Min.   :-2.9674                          
    ##  1st Qu.:-0.64504                 1st Qu.:-0.8428                          
    ##  Median : 0.03645                 Median :-0.1346                          
    ##  Mean   : 0.00000                 Mean   : 0.0000                          
    ##  3rd Qu.: 0.94477                 3rd Qu.: 0.5736                          
    ##  Max.   : 1.17185                 Max.   : 1.2818                          
    ##  NA's   :1                        NA's   :1                                
    ##  Average Pedagogical Strategy Effectiveness Rating
    ##  Min.   :-2.4737                                  
    ##  1st Qu.:-0.7196                                  
    ##  Median : 0.2250                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.9445                                  
    ##  Max.   : 1.1244                                  
    ##  NA's   :1                                        
    ##  Project: Section 1-4: (20%) x/10 Project: Section 5-11: (50%) x/10
    ##  Min.   :-3.8114                  Min.   :-2.3600                  
    ##  1st Qu.:-0.2907                  1st Qu.:-0.2087                  
    ##  Median : 0.2327                  Median : 0.4366                  
    ##  Mean   : 0.0000                  Mean   : 0.0000                  
    ##  3rd Qu.: 0.4706                  3rd Qu.: 0.6159                  
    ##  Max.   : 0.9464                  Max.   : 1.2255                  
    ##                                                                    
    ##  Project: Section 12: (30%) x/5 Project: (10%): x/30 x 100 TOTAL
    ##  Min.   :-0.5683                Min.   :-3.0961                 
    ##  1st Qu.:-0.5683                1st Qu.:-0.3172                 
    ##  Median :-0.5683                Median : 0.1989                 
    ##  Mean   : 0.0000                Mean   : 0.0000                 
    ##  3rd Qu.: 0.1316                3rd Qu.: 0.4569                 
    ##  Max.   : 2.2310                Max.   : 1.8662                 
    ##  NA's   :1                                                      
    ##  Quiz 1 on Concept 1 (Introduction) x/32 Quiz 3 on Concept 3 (Linear) x/15
    ##  Min.   :-1.7842                         Min.   :-2.1031                  
    ##  1st Qu.:-0.7420                         1st Qu.:-0.8149                  
    ##  Median :-0.1578                         Median :-0.1708                  
    ##  Mean   : 0.0000                         Mean   : 0.0000                  
    ##  3rd Qu.: 0.5032                         3rd Qu.: 0.7954                  
    ##  Max.   : 2.2894                         Max.   : 1.7615                  
    ##                                          NA's   :2                        
    ##  Quiz 4 on Concept 4 (Non-Linear) x/22 Quiz 5 on Concept 5 (Dashboarding) x/10
    ##  Min.   :-2.46748                      Min.   :-3.03179                       
    ##  1st Qu.:-0.68157                      1st Qu.:-0.65108                       
    ##  Median :-0.09831                      Median :-0.01782                       
    ##  Mean   : 0.00000                      Mean   : 0.00000                       
    ##  3rd Qu.: 0.80424                      3rd Qu.: 0.77734                       
    ##  Max.   : 1.81960                      Max.   : 3.00092                       
    ##  NA's   :6                             NA's   :12                             
    ##  Quizzes and  Bonus Marks (7%): x/79 x 100 TOTAL
    ##  Min.   :-1.81638                               
    ##  1st Qu.:-0.75175                               
    ##  Median :-0.05512                               
    ##  Mean   : 0.00000                               
    ##  3rd Qu.: 0.54207                               
    ##  Max.   : 2.36638                               
    ##                                                 
    ##  Lab 1 - 2.c. - (Simple Linear Regression) x/5
    ##  Min.   :-4.8297                              
    ##  1st Qu.: 0.2597                              
    ##  Median : 0.2597                              
    ##  Mean   : 0.0000                              
    ##  3rd Qu.: 0.2597                              
    ##  Max.   : 0.2597                              
    ##  NA's   :3                                    
    ##  Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5
    ##  Min.   :-1.9485                                               
    ##  1st Qu.:-0.9821                                               
    ##  Median : 0.6607                                               
    ##  Mean   : 0.0000                                               
    ##  3rd Qu.: 0.8056                                               
    ##  Max.   : 0.8056                                               
    ##  NA's   :6                                                     
    ##  Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5
    ##  Min.   :-2.7794                                                
    ##  1st Qu.: 0.3431                                                
    ##  Median : 0.3431                                                
    ##  Mean   : 0.0000                                                
    ##  3rd Qu.: 0.3431                                                
    ##  Max.   : 0.5773                                                
    ##  NA's   :9                                                      
    ##  Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5
    ##  Min.   :-2.8586                                  
    ##  1st Qu.:-0.3605                                  
    ##  Median : 0.4722                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.6387                                  
    ##  Max.   : 0.6387                                  
    ##  NA's   :18                                       
    ##  Lab 5 - Chart JS Dashboard Setup x/5 Lab Work (7%) x/25 x 100
    ##  Min.   :-1.4592                      Min.   :-3.20757        
    ##  1st Qu.:-1.4592                      1st Qu.:-0.46190        
    ##  Median : 0.6842                      Median : 0.01471        
    ##  Mean   : 0.0000                      Mean   : 0.00000        
    ##  3rd Qu.: 0.6842                      3rd Qu.: 0.90576        
    ##  Max.   : 0.6842                      Max.   : 1.05081        
    ##                                                               
    ##  CAT 1 (8%): x/38 x 100 CAT 2 (8%): x/100 x 100
    ##  Min.   :-2.41349       Min.   :-2.51821       
    ##  1st Qu.:-0.67329       1st Qu.:-0.45107       
    ##  Median : 0.02226       Median : 0.05559       
    ##  Mean   : 0.00000       Mean   : 0.00000       
    ##  3rd Qu.: 0.89236       3rd Qu.: 0.79530       
    ##  Max.   : 1.84908       Max.   : 1.53501       
    ##  NA's   :4              NA's   :31             
    ##  Attendance Waiver Granted: 1 = Yes, 0 = No Absenteeism Percentage
    ##  Min.   :-0.2271                            Min.   :-1.69613      
    ##  1st Qu.:-0.2271                            1st Qu.:-0.88083      
    ##  Median :-0.2271                            Median :-0.06663      
    ##  Mean   : 0.0000                            Mean   : 0.00000      
    ##  3rd Qu.:-0.2271                            3rd Qu.: 0.74867      
    ##  Max.   : 4.3600                            Max.   : 4.00877      
    ##                                                                   
    ##  Coursework TOTAL: x/40 (40%) EXAM: x/60 (60%)   
    ##  Min.   :-2.74036             Min.   :-2.570415  
    ##  1st Qu.:-0.65650             1st Qu.:-0.705101  
    ##  Median : 0.00867             Median : 0.005494  
    ##  Mean   : 0.00000             Mean   : 0.000000  
    ##  3rd Qu.: 0.76863             3rd Qu.: 0.716090  
    ##  Max.   : 1.69569             Max.   : 1.959633  
    ##                               NA's   :4          
    ##  TOTAL = Coursework TOTAL + EXAM (100%)    GRADE          
    ##  Min.   :-3.15733                       Length:101        
    ##  1st Qu.:-0.73640                       Class :character  
    ##  Median : 0.09983                       Mode  :character  
    ##  Mean   : 0.00000                                         
    ##  3rd Qu.: 0.74465                                         
    ##  Max.   : 1.94590                                         
    ## 

``` r
sapply(student_dataset_standardize_transform[, 4], sd)
```

    ## regret_choosing_bi 
    ##                  1

## STEP 6. Apply a Normalize Data Transform —-

``` code
### The Normalize Transform on the StudentDataset ----
summary(StudentPerformanceDataset)
model_of_the_transform <- preProcess(StudentPerformanceDataset, method = c("range"))
print(model_of_the_transform)
student_dataset_normalize_transform <- predict(model_of_the_transform, StudentPerformanceDataset)
summary(student_dataset_normalize_transform)
```

## STEP 7. Apply a Box-Cox Power Transform —-

``` r
### Box-Cox Power Transform on the StudentDataset ----
# BEFORE
summary(student_dataset_standardize_transform)
```

    ##  class_group            gender             YOB          regret_choosing_bi
    ##  Length:101         Min.   :-1.1556   Min.   :-2.9155   Min.   :-0.1414   
    ##  Class :character   1st Qu.:-1.1556   1st Qu.:-0.9055   1st Qu.:-0.1414   
    ##  Mode  :character   Median : 0.8568   Median : 0.0995   Median :-0.1414   
    ##                     Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   
    ##                     3rd Qu.: 0.8568   3rd Qu.: 1.1045   3rd Qu.:-0.1414   
    ##                     Max.   : 0.8568   Max.   : 2.1095   Max.   : 7.0007   
    ##                                                                           
    ##   drop_bi_now        motivator       read_content_before_lecture
    ##  Min.   :-0.1414   Min.   :-1.7349   Min.   :-1.8191            
    ##  1st Qu.:-0.1414   1st Qu.: 0.5707   1st Qu.:-0.7811            
    ##  Median :-0.1414   Median : 0.5707   Median : 0.2569            
    ##  Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000            
    ##  3rd Qu.:-0.1414   3rd Qu.: 0.5707   3rd Qu.: 0.2569            
    ##  Max.   : 7.0007   Max.   : 0.5707   Max.   : 2.3329            
    ##                                                                 
    ##  anticipate_test_questions answer_rhetorical_questions find_terms_I_do_not_know
    ##  Min.   :-2.6033           Min.   :-2.4418             Min.   :-2.5995         
    ##  1st Qu.:-0.5885           1st Qu.:-0.4286             1st Qu.:-0.7038         
    ##  Median : 0.4189           Median : 0.5780             Median : 0.2440         
    ##  Mean   : 0.0000           Mean   : 0.0000             Mean   : 0.0000         
    ##  3rd Qu.: 0.4189           3rd Qu.: 0.5780             3rd Qu.: 1.1918         
    ##  Max.   : 1.4263           Max.   : 1.5846             Max.   : 1.1918         
    ##                                                                                
    ##  copy_new_terms_in_reading_notebook take_quizzes_and_use_results
    ##  Min.   :-2.4058                    Min.   :-2.73448            
    ##  1st Qu.:-0.5992                    1st Qu.:-0.87466            
    ##  Median : 0.3041                    Median : 0.05524            
    ##  Mean   : 0.0000                    Mean   : 0.00000            
    ##  3rd Qu.: 0.3041                    3rd Qu.: 0.98515            
    ##  Max.   : 1.2074                    Max.   : 0.98515            
    ##                                                                 
    ##  reorganise_course_outline write_down_important_points space_out_revision
    ##  Min.   :-2.0550           Min.   :-2.6276             Min.   :-1.9709   
    ##  1st Qu.:-0.3254           1st Qu.:-0.7717             1st Qu.:-0.2015   
    ##  Median :-0.3254           Median : 0.1562             Median :-0.2015   
    ##  Mean   : 0.0000           Mean   : 0.0000             Mean   : 0.0000   
    ##  3rd Qu.: 0.5394           3rd Qu.: 1.0841             3rd Qu.: 0.6832   
    ##  Max.   : 1.4043           Max.   : 1.0841             Max.   : 1.5679   
    ##                                                                          
    ##  studying_in_study_group schedule_appointments goal_oriented    
    ##  Min.   :-1.0877         Min.   :-0.91037      Min.   :-0.4944  
    ##  1st Qu.:-1.0877         1st Qu.:-0.91037      1st Qu.:-0.4944  
    ##  Median :-0.3404         Median : 0.06779      Median :-0.4944  
    ##  Mean   : 0.0000         Mean   : 0.00000      Mean   : 0.0000  
    ##  3rd Qu.: 0.4070         3rd Qu.: 0.06779      3rd Qu.:-0.4944  
    ##  Max.   : 1.9016         Max.   : 3.00228      Max.   : 2.0025  
    ##                                                                 
    ##  spaced_repetition testing_and_active_recall  interleaving    
    ##  Min.   :-1.8720   Min.   :-2.86572          Min.   :-1.6908  
    ##  1st Qu.:-0.6677   1st Qu.:-0.08267          1st Qu.:-0.3461  
    ##  Median : 0.5366   Median :-0.08267          Median :-0.3461  
    ##  Mean   : 0.0000   Mean   : 0.00000          Mean   : 0.0000  
    ##  3rd Qu.: 0.5366   3rd Qu.: 1.30886          3rd Qu.: 0.9985  
    ##  Max.   : 1.7409   Max.   : 1.30886          Max.   : 2.3432  
    ##                                                               
    ##   categorizing     retrospective_timetable cornell_notes          sq3r        
    ##  Min.   :-2.3165   Min.   :-1.5883         Min.   :-1.5519   Min.   :-1.5392  
    ##  1st Qu.:-0.9641   1st Qu.:-0.4586         1st Qu.:-0.5472   1st Qu.:-0.5855  
    ##  Median : 0.3883   Median :-0.4586         Median : 0.4576   Median : 0.3683  
    ##  Mean   : 0.0000   Mean   : 0.0000         Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 0.3883   3rd Qu.: 0.6711         3rd Qu.: 0.4576   3rd Qu.: 0.3683  
    ##  Max.   : 1.7407   Max.   : 1.8008         Max.   : 1.4624   Max.   : 1.3220  
    ##                                                                               
    ##     commute          study_time      repeats_since_Y1   paid_tuition    
    ##  Min.   :-1.6586   Min.   :-0.9134   Min.   :-0.9716   Min.   :-0.3498  
    ##  1st Qu.:-0.6999   1st Qu.:-0.9134   1st Qu.:-0.9716   1st Qu.:-0.3498  
    ##  Median : 0.2589   Median : 0.3045   Median :-0.0237   Median :-0.3498  
    ##  Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 1.2176   3rd Qu.: 0.3045   3rd Qu.: 0.4502   3rd Qu.:-0.3498  
    ##  Max.   : 1.2176   Max.   : 2.7402   Max.   : 3.7678   Max.   : 2.8302  
    ##  NA's   :1         NA's   :1         NA's   :1         NA's   :1        
    ##   free_tuition     extra_curricular sports_extra_curricular exercise_per_week
    ##  Min.   :-0.6051   Min.   :-1.057   Min.   :-0.7462         Min.   :-1.3575  
    ##  1st Qu.:-0.6051   1st Qu.:-1.057   1st Qu.:-0.7462         1st Qu.:-0.1234  
    ##  Median :-0.6051   Median : 0.937   Median :-0.7462         Median :-0.1234  
    ##  Mean   : 0.0000   Mean   : 0.000   Mean   : 0.0000         Mean   : 0.0000  
    ##  3rd Qu.: 1.6361   3rd Qu.: 0.937   3rd Qu.: 1.3266         3rd Qu.: 1.1107  
    ##  Max.   : 1.6361   Max.   : 0.937   Max.   : 1.3266         Max.   : 2.3448  
    ##  NA's   :1         NA's   :1        NA's   :1               NA's   :1        
    ##     meditate            pray             internet           laptop 
    ##  Min.   :-0.8143   Min.   :-2.03728   Min.   :-2.5740   Min.   :0  
    ##  1st Qu.:-0.8143   1st Qu.:-1.06251   1st Qu.: 0.3846   1st Qu.:0  
    ##  Median : 0.2571   Median :-0.08773   Median : 0.3846   Median :0  
    ##  Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.0000   Mean   :0  
    ##  3rd Qu.: 0.2571   3rd Qu.: 0.88705   3rd Qu.: 0.3846   3rd Qu.:0  
    ##  Max.   : 2.4000   Max.   : 0.88705   Max.   : 0.3846   Max.   :0  
    ##  NA's   :1         NA's   :1          NA's   :1         NA's   :1  
    ##  family_relationships  friendships       romantic_relationships
    ##  Min.   :-2.7369      Min.   :-2.74737   Min.   :-0.8531       
    ##  1st Qu.:-0.2374      1st Qu.:-0.01367   1st Qu.:-0.8531       
    ##  Median :-0.2374      Median :-0.01367   Median :-0.8531       
    ##  Mean   : 0.0000      Mean   : 0.00000   Mean   : 0.0000       
    ##  3rd Qu.: 1.0123      3rd Qu.:-0.01367   3rd Qu.: 1.0150       
    ##  Max.   : 1.0123      Max.   : 1.35318   Max.   : 1.6377       
    ##  NA's   :1            NA's   :1          NA's   :1             
    ##  spiritual_wellnes financial_wellness     health            day_out       
    ##  Min.   :-2.8309   Min.   :-1.85227   Min.   :-3.19122   Min.   :-1.4071  
    ##  1st Qu.:-0.6944   1st Qu.:-0.93982   1st Qu.:-1.09173   1st Qu.:-1.4071  
    ##  Median : 0.3739   Median :-0.02737   Median :-0.04199   Median : 0.3518  
    ##  Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.00000   Mean   : 0.0000  
    ##  3rd Qu.: 0.3739   3rd Qu.: 0.88508   3rd Qu.: 1.00775   3rd Qu.: 0.3518  
    ##  Max.   : 1.4422   Max.   : 1.79752   Max.   : 1.00775   Max.   : 3.8696  
    ##  NA's   :1         NA's   :1          NA's   :1          NA's   :1        
    ##    night_out       alcohol_or_narcotics     mentor        mentor_meetings  
    ##  Min.   :-0.7926   Min.   :-0.628       Min.   :-0.8294   Min.   :-0.8101  
    ##  1st Qu.:-0.7926   1st Qu.:-0.628       1st Qu.:-0.8294   1st Qu.:-0.8101  
    ##  Median :-0.7926   Median :-0.628       Median :-0.8294   Median :-0.8101  
    ##  Mean   : 0.0000   Mean   : 0.000       Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 0.7615   3rd Qu.: 1.166       3rd Qu.: 1.1936   3rd Qu.: 0.3812  
    ##  Max.   : 3.8697   Max.   : 4.755       Max.   : 1.1936   Max.   : 2.7638  
    ##  NA's   :1         NA's   :1            NA's   :1         NA's   :1        
    ##  A - 1. I am enjoying the subject A - 2. Classes start and end on time
    ##  Min.   :-2.5063                  Min.   :-3.4293                     
    ##  1st Qu.:-0.8242                  1st Qu.:-1.3880                     
    ##  Median : 0.8579                  Median : 0.6532                     
    ##  Mean   : 0.0000                  Mean   : 0.0000                     
    ##  3rd Qu.: 0.8579                  3rd Qu.: 0.6532                     
    ##  Max.   : 0.8579                  Max.   : 0.6532                     
    ##  NA's   :1                        NA's   :1                           
    ##  A - 3. The learning environment is participative, involves learning by doing and is group-based
    ##  Min.   :-2.0544                                                                                
    ##  1st Qu.:-0.5326                                                                                
    ##  Median :-0.5326                                                                                
    ##  Mean   : 0.0000                                                                                
    ##  3rd Qu.: 0.9892                                                                                
    ##  Max.   : 0.9892                                                                                
    ##  NA's   :1                                                                                      
    ##  A - 4. The subject content is delivered according to the course outline and meets my expectations
    ##  Min.   :-3.75655                                                                                 
    ##  1st Qu.: 0.02159                                                                                 
    ##  Median : 0.56132                                                                                 
    ##  Mean   : 0.00000                                                                                 
    ##  3rd Qu.: 0.56132                                                                                 
    ##  Max.   : 0.56132                                                                                 
    ##  NA's   :1                                                                                        
    ##  A - 5. The topics are clear and logically developed
    ##  Min.   :-4.6074                                    
    ##  1st Qu.:-1.1301                                    
    ##  Median : 0.6085                                    
    ##  Mean   : 0.0000                                    
    ##  3rd Qu.: 0.6085                                    
    ##  Max.   : 0.6085                                    
    ##  NA's   :1                                          
    ##  A - 6. I am developing my oral and writing skills
    ##  Min.   :-3.5544                                  
    ##  1st Qu.:-0.1257                                  
    ##  Median :-0.1257                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 1.0172                                  
    ##  Max.   : 1.0172                                  
    ##  NA's   :1                                        
    ##  A - 7. I am developing my reflective and critical reasoning skills
    ##  Min.   :-3.4338                                                   
    ##  1st Qu.:-0.5483                                                   
    ##  Median :-0.5483                                                   
    ##  Mean   : 0.0000                                                   
    ##  3rd Qu.: 0.8945                                                   
    ##  Max.   : 0.8945                                                   
    ##  NA's   :1                                                         
    ##  A - 8. The assessment methods are assisting me to learn
    ##  Min.   :-5.5563                                        
    ##  1st Qu.:-0.9389                                        
    ##  Median : 0.6003                                        
    ##  Mean   : 0.0000                                        
    ##  3rd Qu.: 0.6003                                        
    ##  Max.   : 0.6003                                        
    ##  NA's   :1                                              
    ##  A - 9. I receive relevant feedback
    ##  Min.   :-2.8531                   
    ##  1st Qu.:-1.0474                   
    ##  Median : 0.7584                   
    ##  Mean   : 0.0000                   
    ##  3rd Qu.: 0.7584                   
    ##  Max.   : 0.7584                   
    ##  NA's   :1                         
    ##  A - 10. I read the recommended readings and notes
    ##  Min.   :-2.4775                                  
    ##  1st Qu.:-0.8791                                  
    ##  Median : 0.7193                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.7193                                  
    ##  Max.   : 0.7193                                  
    ##  NA's   :1                                        
    ##  A - 11. I use the eLearning material posted
    ##  Min.   :-3.2553                            
    ##  1st Qu.:-1.3404                            
    ##  Median : 0.5745                            
    ##  Mean   : 0.0000                            
    ##  3rd Qu.: 0.5745                            
    ##  Max.   : 0.5745                            
    ##  NA's   :1                                  
    ##  B - 1. Concept 1 of 6: Principles of Business Intelligence and the DataOps Philosophy
    ##  Min.   :-4.1489                                                                      
    ##  1st Qu.:-0.3191                                                                      
    ##  Median :-0.3191                                                                      
    ##  Mean   : 0.0000                                                                      
    ##  3rd Qu.: 0.9574                                                                      
    ##  Max.   : 0.9574                                                                      
    ##  NA's   :1                                                                            
    ##  B - 2. Concept 3 of 6: Linear Algorithms for Predictive Analytics
    ##  Min.   :-2.24938                                                 
    ##  1st Qu.:-1.08990                                                 
    ##  Median : 0.06957                                                 
    ##  Mean   : 0.00000                                                 
    ##  3rd Qu.: 1.22904                                                 
    ##  Max.   : 1.22904                                                 
    ##  NA's   :1                                                        
    ##  C - 2. Quizzes at the end of each concept
    ##  Min.   :-4.1701                          
    ##  1st Qu.:-0.9499                          
    ##  Median : 0.6601                          
    ##  Mean   : 0.0000                          
    ##  3rd Qu.: 0.6601                          
    ##  Max.   : 0.6601                          
    ##  NA's   :1                                
    ##  C - 3. Lab manuals that outline the steps to follow during the labs
    ##  Min.   :-2.6777                                                    
    ##  1st Qu.:-1.0145                                                    
    ##  Median : 0.6486                                                    
    ##  Mean   : 0.0000                                                    
    ##  3rd Qu.: 0.6486                                                    
    ##  Max.   : 0.6486                                                    
    ##  NA's   :1                                                          
    ##  C - 4. Required lab work submissions at the end of each lab manual that outline the activity to be done on your own
    ##  Min.   :-2.5440                                                                                                    
    ##  1st Qu.:-0.9027                                                                                                    
    ##  Median : 0.7386                                                                                                    
    ##  Mean   : 0.0000                                                                                                    
    ##  3rd Qu.: 0.7386                                                                                                    
    ##  Max.   : 0.7386                                                                                                    
    ##  NA's   :1                                                                                                          
    ##  C - 5. Supplementary videos to watch
    ##  Min.   :-3.6080                     
    ##  1st Qu.:-0.2149                     
    ##  Median :-0.2149                     
    ##  Mean   : 0.0000                     
    ##  3rd Qu.: 0.9161                     
    ##  Max.   : 0.9161                     
    ##  NA's   :1                           
    ##  C - 6. Supplementary podcasts to listen to
    ##  Min.   :-3.10583                          
    ##  1st Qu.:-0.08067                          
    ##  Median :-0.08067                          
    ##  Mean   : 0.00000                          
    ##  3rd Qu.: 0.92772                          
    ##  Max.   : 0.92772                          
    ##  NA's   :1                                 
    ##  C - 7. Supplementary content to read C - 8. Lectures slides
    ##  Min.   :-3.2864                      Min.   :-3.5875       
    ##  1st Qu.:-0.1762                      1st Qu.:-0.8279       
    ##  Median :-0.1762                      Median : 0.5519       
    ##  Mean   : 0.0000                      Mean   : 0.0000       
    ##  3rd Qu.: 0.8605                      3rd Qu.: 0.5519       
    ##  Max.   : 0.8605                      Max.   : 0.5519       
    ##  NA's   :1                            NA's   :1             
    ##  C - 9. Lecture notes on some of the lecture slides
    ##  Min.   :-4.0904                                   
    ##  1st Qu.:-0.9439                                   
    ##  Median : 0.6293                                   
    ##  Mean   : 0.0000                                   
    ##  3rd Qu.: 0.6293                                   
    ##  Max.   : 0.6293                                   
    ##  NA's   :1                                         
    ##  C - 10. The quality of the lectures given (quality measured by the breadth (the full span of knowledge of a subject) and depth (the extent to which specific topics are focused upon, amplified, and explored) of learning - NOT quality measured by how fun/comical/lively the lectures are)
    ##  Min.   :-3.8612                                                                                                                                                                                                                                                                              
    ##  1st Qu.:-0.8209                                                                                                                                                                                                                                                                              
    ##  Median : 0.6993                                                                                                                                                                                                                                                                              
    ##  Mean   : 0.0000                                                                                                                                                                                                                                                                              
    ##  3rd Qu.: 0.6993                                                                                                                                                                                                                                                                              
    ##  Max.   : 0.6993                                                                                                                                                                                                                                                                              
    ##  NA's   :1                                                                                                                                                                                                                                                                                    
    ##  C - 11. The division of theory and practice such that most of the theory is done during the recorded online classes and most of the practice is done during the physical classes
    ##  Min.   :-3.6142                                                                                                                                                                 
    ##  1st Qu.:-0.7112                                                                                                                                                                 
    ##  Median : 0.7403                                                                                                                                                                 
    ##  Mean   : 0.0000                                                                                                                                                                 
    ##  3rd Qu.: 0.7403                                                                                                                                                                 
    ##  Max.   : 0.7403                                                                                                                                                                 
    ##  NA's   :1                                                                                                                                                                       
    ##  C - 12. The recordings of online classes
    ##  Min.   :-2.7301                         
    ##  1st Qu.:-0.3867                         
    ##  Median : 0.7850                         
    ##  Mean   : 0.0000                         
    ##  3rd Qu.: 0.7850                         
    ##  Max.   : 0.7850                         
    ##  NA's   :1                               
    ##  D - 1. Write two things you like about the teaching and learning in this unit so far.
    ##  Length:101                                                                           
    ##  Class :character                                                                     
    ##  Mode  :character                                                                     
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##  D - 2. Write at least one recommendation to improve the teaching and learning in this unit (for the remaining weeks in the semester)
    ##  Length:101                                                                                                                          
    ##  Class :character                                                                                                                    
    ##  Mode  :character                                                                                                                    
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##  Average Course Evaluation Rating Average Level of Learning Attained Rating
    ##  Min.   :-4.05150                 Min.   :-2.9674                          
    ##  1st Qu.:-0.64504                 1st Qu.:-0.8428                          
    ##  Median : 0.03645                 Median :-0.1346                          
    ##  Mean   : 0.00000                 Mean   : 0.0000                          
    ##  3rd Qu.: 0.94477                 3rd Qu.: 0.5736                          
    ##  Max.   : 1.17185                 Max.   : 1.2818                          
    ##  NA's   :1                        NA's   :1                                
    ##  Average Pedagogical Strategy Effectiveness Rating
    ##  Min.   :-2.4737                                  
    ##  1st Qu.:-0.7196                                  
    ##  Median : 0.2250                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.9445                                  
    ##  Max.   : 1.1244                                  
    ##  NA's   :1                                        
    ##  Project: Section 1-4: (20%) x/10 Project: Section 5-11: (50%) x/10
    ##  Min.   :-3.8114                  Min.   :-2.3600                  
    ##  1st Qu.:-0.2907                  1st Qu.:-0.2087                  
    ##  Median : 0.2327                  Median : 0.4366                  
    ##  Mean   : 0.0000                  Mean   : 0.0000                  
    ##  3rd Qu.: 0.4706                  3rd Qu.: 0.6159                  
    ##  Max.   : 0.9464                  Max.   : 1.2255                  
    ##                                                                    
    ##  Project: Section 12: (30%) x/5 Project: (10%): x/30 x 100 TOTAL
    ##  Min.   :-0.5683                Min.   :-3.0961                 
    ##  1st Qu.:-0.5683                1st Qu.:-0.3172                 
    ##  Median :-0.5683                Median : 0.1989                 
    ##  Mean   : 0.0000                Mean   : 0.0000                 
    ##  3rd Qu.: 0.1316                3rd Qu.: 0.4569                 
    ##  Max.   : 2.2310                Max.   : 1.8662                 
    ##  NA's   :1                                                      
    ##  Quiz 1 on Concept 1 (Introduction) x/32 Quiz 3 on Concept 3 (Linear) x/15
    ##  Min.   :-1.7842                         Min.   :-2.1031                  
    ##  1st Qu.:-0.7420                         1st Qu.:-0.8149                  
    ##  Median :-0.1578                         Median :-0.1708                  
    ##  Mean   : 0.0000                         Mean   : 0.0000                  
    ##  3rd Qu.: 0.5032                         3rd Qu.: 0.7954                  
    ##  Max.   : 2.2894                         Max.   : 1.7615                  
    ##                                          NA's   :2                        
    ##  Quiz 4 on Concept 4 (Non-Linear) x/22 Quiz 5 on Concept 5 (Dashboarding) x/10
    ##  Min.   :-2.46748                      Min.   :-3.03179                       
    ##  1st Qu.:-0.68157                      1st Qu.:-0.65108                       
    ##  Median :-0.09831                      Median :-0.01782                       
    ##  Mean   : 0.00000                      Mean   : 0.00000                       
    ##  3rd Qu.: 0.80424                      3rd Qu.: 0.77734                       
    ##  Max.   : 1.81960                      Max.   : 3.00092                       
    ##  NA's   :6                             NA's   :12                             
    ##  Quizzes and  Bonus Marks (7%): x/79 x 100 TOTAL
    ##  Min.   :-1.81638                               
    ##  1st Qu.:-0.75175                               
    ##  Median :-0.05512                               
    ##  Mean   : 0.00000                               
    ##  3rd Qu.: 0.54207                               
    ##  Max.   : 2.36638                               
    ##                                                 
    ##  Lab 1 - 2.c. - (Simple Linear Regression) x/5
    ##  Min.   :-4.8297                              
    ##  1st Qu.: 0.2597                              
    ##  Median : 0.2597                              
    ##  Mean   : 0.0000                              
    ##  3rd Qu.: 0.2597                              
    ##  Max.   : 0.2597                              
    ##  NA's   :3                                    
    ##  Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5
    ##  Min.   :-1.9485                                               
    ##  1st Qu.:-0.9821                                               
    ##  Median : 0.6607                                               
    ##  Mean   : 0.0000                                               
    ##  3rd Qu.: 0.8056                                               
    ##  Max.   : 0.8056                                               
    ##  NA's   :6                                                     
    ##  Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5
    ##  Min.   :-2.7794                                                
    ##  1st Qu.: 0.3431                                                
    ##  Median : 0.3431                                                
    ##  Mean   : 0.0000                                                
    ##  3rd Qu.: 0.3431                                                
    ##  Max.   : 0.5773                                                
    ##  NA's   :9                                                      
    ##  Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5
    ##  Min.   :-2.8586                                  
    ##  1st Qu.:-0.3605                                  
    ##  Median : 0.4722                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.6387                                  
    ##  Max.   : 0.6387                                  
    ##  NA's   :18                                       
    ##  Lab 5 - Chart JS Dashboard Setup x/5 Lab Work (7%) x/25 x 100
    ##  Min.   :-1.4592                      Min.   :-3.20757        
    ##  1st Qu.:-1.4592                      1st Qu.:-0.46190        
    ##  Median : 0.6842                      Median : 0.01471        
    ##  Mean   : 0.0000                      Mean   : 0.00000        
    ##  3rd Qu.: 0.6842                      3rd Qu.: 0.90576        
    ##  Max.   : 0.6842                      Max.   : 1.05081        
    ##                                                               
    ##  CAT 1 (8%): x/38 x 100 CAT 2 (8%): x/100 x 100
    ##  Min.   :-2.41349       Min.   :-2.51821       
    ##  1st Qu.:-0.67329       1st Qu.:-0.45107       
    ##  Median : 0.02226       Median : 0.05559       
    ##  Mean   : 0.00000       Mean   : 0.00000       
    ##  3rd Qu.: 0.89236       3rd Qu.: 0.79530       
    ##  Max.   : 1.84908       Max.   : 1.53501       
    ##  NA's   :4              NA's   :31             
    ##  Attendance Waiver Granted: 1 = Yes, 0 = No Absenteeism Percentage
    ##  Min.   :-0.2271                            Min.   :-1.69613      
    ##  1st Qu.:-0.2271                            1st Qu.:-0.88083      
    ##  Median :-0.2271                            Median :-0.06663      
    ##  Mean   : 0.0000                            Mean   : 0.00000      
    ##  3rd Qu.:-0.2271                            3rd Qu.: 0.74867      
    ##  Max.   : 4.3600                            Max.   : 4.00877      
    ##                                                                   
    ##  Coursework TOTAL: x/40 (40%) EXAM: x/60 (60%)   
    ##  Min.   :-2.74036             Min.   :-2.570415  
    ##  1st Qu.:-0.65650             1st Qu.:-0.705101  
    ##  Median : 0.00867             Median : 0.005494  
    ##  Mean   : 0.00000             Mean   : 0.000000  
    ##  3rd Qu.: 0.76863             3rd Qu.: 0.716090  
    ##  Max.   : 1.69569             Max.   : 1.959633  
    ##                               NA's   :4          
    ##  TOTAL = Coursework TOTAL + EXAM (100%)    GRADE          
    ##  Min.   :-3.15733                       Length:101        
    ##  1st Qu.:-0.73640                       Class :character  
    ##  Median : 0.09983                       Mode  :character  
    ##  Mean   : 0.00000                                         
    ##  3rd Qu.: 0.74465                                         
    ##  Max.   : 1.94590                                         
    ## 

``` r
# Calculate the skewness before the Box-Cox transform
sapply(student_dataset_standardize_transform[, 4],  skewness, type = 2)
```

    ## regret_choosing_bi 
    ##            6.99785

``` r
sapply(student_dataset_standardize_transform[, 4], sd)
```

    ## regret_choosing_bi 
    ##                  1

``` r
model_of_the_transform <- preProcess(student_dataset_standardize_transform,
                                     method = c("BoxCox"))
print(model_of_the_transform)
```

    ## Created from 51 samples and 4 variables
    ## 
    ## Pre-processing:
    ##   - ignored (4)

``` r
student_dataset_box_cox_transform <- predict(model_of_the_transform,
                                             student_dataset_standardize_transform)

# AFTER
summary(student_dataset_box_cox_transform)
```

    ##  class_group            gender             YOB          regret_choosing_bi
    ##  Length:101         Min.   :-1.1556   Min.   :-2.9155   Min.   :-0.1414   
    ##  Class :character   1st Qu.:-1.1556   1st Qu.:-0.9055   1st Qu.:-0.1414   
    ##  Mode  :character   Median : 0.8568   Median : 0.0995   Median :-0.1414   
    ##                     Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   
    ##                     3rd Qu.: 0.8568   3rd Qu.: 1.1045   3rd Qu.:-0.1414   
    ##                     Max.   : 0.8568   Max.   : 2.1095   Max.   : 7.0007   
    ##                                                                           
    ##   drop_bi_now        motivator       read_content_before_lecture
    ##  Min.   :-0.1414   Min.   :-1.7349   Min.   :-1.8191            
    ##  1st Qu.:-0.1414   1st Qu.: 0.5707   1st Qu.:-0.7811            
    ##  Median :-0.1414   Median : 0.5707   Median : 0.2569            
    ##  Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000            
    ##  3rd Qu.:-0.1414   3rd Qu.: 0.5707   3rd Qu.: 0.2569            
    ##  Max.   : 7.0007   Max.   : 0.5707   Max.   : 2.3329            
    ##                                                                 
    ##  anticipate_test_questions answer_rhetorical_questions find_terms_I_do_not_know
    ##  Min.   :-2.6033           Min.   :-2.4418             Min.   :-2.5995         
    ##  1st Qu.:-0.5885           1st Qu.:-0.4286             1st Qu.:-0.7038         
    ##  Median : 0.4189           Median : 0.5780             Median : 0.2440         
    ##  Mean   : 0.0000           Mean   : 0.0000             Mean   : 0.0000         
    ##  3rd Qu.: 0.4189           3rd Qu.: 0.5780             3rd Qu.: 1.1918         
    ##  Max.   : 1.4263           Max.   : 1.5846             Max.   : 1.1918         
    ##                                                                                
    ##  copy_new_terms_in_reading_notebook take_quizzes_and_use_results
    ##  Min.   :-2.4058                    Min.   :-2.73448            
    ##  1st Qu.:-0.5992                    1st Qu.:-0.87466            
    ##  Median : 0.3041                    Median : 0.05524            
    ##  Mean   : 0.0000                    Mean   : 0.00000            
    ##  3rd Qu.: 0.3041                    3rd Qu.: 0.98515            
    ##  Max.   : 1.2074                    Max.   : 0.98515            
    ##                                                                 
    ##  reorganise_course_outline write_down_important_points space_out_revision
    ##  Min.   :-2.0550           Min.   :-2.6276             Min.   :-1.9709   
    ##  1st Qu.:-0.3254           1st Qu.:-0.7717             1st Qu.:-0.2015   
    ##  Median :-0.3254           Median : 0.1562             Median :-0.2015   
    ##  Mean   : 0.0000           Mean   : 0.0000             Mean   : 0.0000   
    ##  3rd Qu.: 0.5394           3rd Qu.: 1.0841             3rd Qu.: 0.6832   
    ##  Max.   : 1.4043           Max.   : 1.0841             Max.   : 1.5679   
    ##                                                                          
    ##  studying_in_study_group schedule_appointments goal_oriented    
    ##  Min.   :-1.0877         Min.   :-0.91037      Min.   :-0.4944  
    ##  1st Qu.:-1.0877         1st Qu.:-0.91037      1st Qu.:-0.4944  
    ##  Median :-0.3404         Median : 0.06779      Median :-0.4944  
    ##  Mean   : 0.0000         Mean   : 0.00000      Mean   : 0.0000  
    ##  3rd Qu.: 0.4070         3rd Qu.: 0.06779      3rd Qu.:-0.4944  
    ##  Max.   : 1.9016         Max.   : 3.00228      Max.   : 2.0025  
    ##                                                                 
    ##  spaced_repetition testing_and_active_recall  interleaving    
    ##  Min.   :-1.8720   Min.   :-2.86572          Min.   :-1.6908  
    ##  1st Qu.:-0.6677   1st Qu.:-0.08267          1st Qu.:-0.3461  
    ##  Median : 0.5366   Median :-0.08267          Median :-0.3461  
    ##  Mean   : 0.0000   Mean   : 0.00000          Mean   : 0.0000  
    ##  3rd Qu.: 0.5366   3rd Qu.: 1.30886          3rd Qu.: 0.9985  
    ##  Max.   : 1.7409   Max.   : 1.30886          Max.   : 2.3432  
    ##                                                               
    ##   categorizing     retrospective_timetable cornell_notes          sq3r        
    ##  Min.   :-2.3165   Min.   :-1.5883         Min.   :-1.5519   Min.   :-1.5392  
    ##  1st Qu.:-0.9641   1st Qu.:-0.4586         1st Qu.:-0.5472   1st Qu.:-0.5855  
    ##  Median : 0.3883   Median :-0.4586         Median : 0.4576   Median : 0.3683  
    ##  Mean   : 0.0000   Mean   : 0.0000         Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 0.3883   3rd Qu.: 0.6711         3rd Qu.: 0.4576   3rd Qu.: 0.3683  
    ##  Max.   : 1.7407   Max.   : 1.8008         Max.   : 1.4624   Max.   : 1.3220  
    ##                                                                               
    ##     commute          study_time      repeats_since_Y1   paid_tuition    
    ##  Min.   :-1.6586   Min.   :-0.9134   Min.   :-0.9716   Min.   :-0.3498  
    ##  1st Qu.:-0.6999   1st Qu.:-0.9134   1st Qu.:-0.9716   1st Qu.:-0.3498  
    ##  Median : 0.2589   Median : 0.3045   Median :-0.0237   Median :-0.3498  
    ##  Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 1.2176   3rd Qu.: 0.3045   3rd Qu.: 0.4502   3rd Qu.:-0.3498  
    ##  Max.   : 1.2176   Max.   : 2.7402   Max.   : 3.7678   Max.   : 2.8302  
    ##  NA's   :1         NA's   :1         NA's   :1         NA's   :1        
    ##   free_tuition     extra_curricular sports_extra_curricular exercise_per_week
    ##  Min.   :-0.6051   Min.   :-1.057   Min.   :-0.7462         Min.   :-1.3575  
    ##  1st Qu.:-0.6051   1st Qu.:-1.057   1st Qu.:-0.7462         1st Qu.:-0.1234  
    ##  Median :-0.6051   Median : 0.937   Median :-0.7462         Median :-0.1234  
    ##  Mean   : 0.0000   Mean   : 0.000   Mean   : 0.0000         Mean   : 0.0000  
    ##  3rd Qu.: 1.6361   3rd Qu.: 0.937   3rd Qu.: 1.3266         3rd Qu.: 1.1107  
    ##  Max.   : 1.6361   Max.   : 0.937   Max.   : 1.3266         Max.   : 2.3448  
    ##  NA's   :1         NA's   :1        NA's   :1               NA's   :1        
    ##     meditate            pray             internet           laptop 
    ##  Min.   :-0.8143   Min.   :-2.03728   Min.   :-2.5740   Min.   :0  
    ##  1st Qu.:-0.8143   1st Qu.:-1.06251   1st Qu.: 0.3846   1st Qu.:0  
    ##  Median : 0.2571   Median :-0.08773   Median : 0.3846   Median :0  
    ##  Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.0000   Mean   :0  
    ##  3rd Qu.: 0.2571   3rd Qu.: 0.88705   3rd Qu.: 0.3846   3rd Qu.:0  
    ##  Max.   : 2.4000   Max.   : 0.88705   Max.   : 0.3846   Max.   :0  
    ##  NA's   :1         NA's   :1          NA's   :1         NA's   :1  
    ##  family_relationships  friendships       romantic_relationships
    ##  Min.   :-2.7369      Min.   :-2.74737   Min.   :-0.8531       
    ##  1st Qu.:-0.2374      1st Qu.:-0.01367   1st Qu.:-0.8531       
    ##  Median :-0.2374      Median :-0.01367   Median :-0.8531       
    ##  Mean   : 0.0000      Mean   : 0.00000   Mean   : 0.0000       
    ##  3rd Qu.: 1.0123      3rd Qu.:-0.01367   3rd Qu.: 1.0150       
    ##  Max.   : 1.0123      Max.   : 1.35318   Max.   : 1.6377       
    ##  NA's   :1            NA's   :1          NA's   :1             
    ##  spiritual_wellnes financial_wellness     health            day_out       
    ##  Min.   :-2.8309   Min.   :-1.85227   Min.   :-3.19122   Min.   :-1.4071  
    ##  1st Qu.:-0.6944   1st Qu.:-0.93982   1st Qu.:-1.09173   1st Qu.:-1.4071  
    ##  Median : 0.3739   Median :-0.02737   Median :-0.04199   Median : 0.3518  
    ##  Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.00000   Mean   : 0.0000  
    ##  3rd Qu.: 0.3739   3rd Qu.: 0.88508   3rd Qu.: 1.00775   3rd Qu.: 0.3518  
    ##  Max.   : 1.4422   Max.   : 1.79752   Max.   : 1.00775   Max.   : 3.8696  
    ##  NA's   :1         NA's   :1          NA's   :1          NA's   :1        
    ##    night_out       alcohol_or_narcotics     mentor        mentor_meetings  
    ##  Min.   :-0.7926   Min.   :-0.628       Min.   :-0.8294   Min.   :-0.8101  
    ##  1st Qu.:-0.7926   1st Qu.:-0.628       1st Qu.:-0.8294   1st Qu.:-0.8101  
    ##  Median :-0.7926   Median :-0.628       Median :-0.8294   Median :-0.8101  
    ##  Mean   : 0.0000   Mean   : 0.000       Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 0.7615   3rd Qu.: 1.166       3rd Qu.: 1.1936   3rd Qu.: 0.3812  
    ##  Max.   : 3.8697   Max.   : 4.755       Max.   : 1.1936   Max.   : 2.7638  
    ##  NA's   :1         NA's   :1            NA's   :1         NA's   :1        
    ##  A - 1. I am enjoying the subject A - 2. Classes start and end on time
    ##  Min.   :-2.5063                  Min.   :-3.4293                     
    ##  1st Qu.:-0.8242                  1st Qu.:-1.3880                     
    ##  Median : 0.8579                  Median : 0.6532                     
    ##  Mean   : 0.0000                  Mean   : 0.0000                     
    ##  3rd Qu.: 0.8579                  3rd Qu.: 0.6532                     
    ##  Max.   : 0.8579                  Max.   : 0.6532                     
    ##  NA's   :1                        NA's   :1                           
    ##  A - 3. The learning environment is participative, involves learning by doing and is group-based
    ##  Min.   :-2.0544                                                                                
    ##  1st Qu.:-0.5326                                                                                
    ##  Median :-0.5326                                                                                
    ##  Mean   : 0.0000                                                                                
    ##  3rd Qu.: 0.9892                                                                                
    ##  Max.   : 0.9892                                                                                
    ##  NA's   :1                                                                                      
    ##  A - 4. The subject content is delivered according to the course outline and meets my expectations
    ##  Min.   :-3.75655                                                                                 
    ##  1st Qu.: 0.02159                                                                                 
    ##  Median : 0.56132                                                                                 
    ##  Mean   : 0.00000                                                                                 
    ##  3rd Qu.: 0.56132                                                                                 
    ##  Max.   : 0.56132                                                                                 
    ##  NA's   :1                                                                                        
    ##  A - 5. The topics are clear and logically developed
    ##  Min.   :-4.6074                                    
    ##  1st Qu.:-1.1301                                    
    ##  Median : 0.6085                                    
    ##  Mean   : 0.0000                                    
    ##  3rd Qu.: 0.6085                                    
    ##  Max.   : 0.6085                                    
    ##  NA's   :1                                          
    ##  A - 6. I am developing my oral and writing skills
    ##  Min.   :-3.5544                                  
    ##  1st Qu.:-0.1257                                  
    ##  Median :-0.1257                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 1.0172                                  
    ##  Max.   : 1.0172                                  
    ##  NA's   :1                                        
    ##  A - 7. I am developing my reflective and critical reasoning skills
    ##  Min.   :-3.4338                                                   
    ##  1st Qu.:-0.5483                                                   
    ##  Median :-0.5483                                                   
    ##  Mean   : 0.0000                                                   
    ##  3rd Qu.: 0.8945                                                   
    ##  Max.   : 0.8945                                                   
    ##  NA's   :1                                                         
    ##  A - 8. The assessment methods are assisting me to learn
    ##  Min.   :-5.5563                                        
    ##  1st Qu.:-0.9389                                        
    ##  Median : 0.6003                                        
    ##  Mean   : 0.0000                                        
    ##  3rd Qu.: 0.6003                                        
    ##  Max.   : 0.6003                                        
    ##  NA's   :1                                              
    ##  A - 9. I receive relevant feedback
    ##  Min.   :-2.8531                   
    ##  1st Qu.:-1.0474                   
    ##  Median : 0.7584                   
    ##  Mean   : 0.0000                   
    ##  3rd Qu.: 0.7584                   
    ##  Max.   : 0.7584                   
    ##  NA's   :1                         
    ##  A - 10. I read the recommended readings and notes
    ##  Min.   :-2.4775                                  
    ##  1st Qu.:-0.8791                                  
    ##  Median : 0.7193                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.7193                                  
    ##  Max.   : 0.7193                                  
    ##  NA's   :1                                        
    ##  A - 11. I use the eLearning material posted
    ##  Min.   :-3.2553                            
    ##  1st Qu.:-1.3404                            
    ##  Median : 0.5745                            
    ##  Mean   : 0.0000                            
    ##  3rd Qu.: 0.5745                            
    ##  Max.   : 0.5745                            
    ##  NA's   :1                                  
    ##  B - 1. Concept 1 of 6: Principles of Business Intelligence and the DataOps Philosophy
    ##  Min.   :-4.1489                                                                      
    ##  1st Qu.:-0.3191                                                                      
    ##  Median :-0.3191                                                                      
    ##  Mean   : 0.0000                                                                      
    ##  3rd Qu.: 0.9574                                                                      
    ##  Max.   : 0.9574                                                                      
    ##  NA's   :1                                                                            
    ##  B - 2. Concept 3 of 6: Linear Algorithms for Predictive Analytics
    ##  Min.   :-2.24938                                                 
    ##  1st Qu.:-1.08990                                                 
    ##  Median : 0.06957                                                 
    ##  Mean   : 0.00000                                                 
    ##  3rd Qu.: 1.22904                                                 
    ##  Max.   : 1.22904                                                 
    ##  NA's   :1                                                        
    ##  C - 2. Quizzes at the end of each concept
    ##  Min.   :-4.1701                          
    ##  1st Qu.:-0.9499                          
    ##  Median : 0.6601                          
    ##  Mean   : 0.0000                          
    ##  3rd Qu.: 0.6601                          
    ##  Max.   : 0.6601                          
    ##  NA's   :1                                
    ##  C - 3. Lab manuals that outline the steps to follow during the labs
    ##  Min.   :-2.6777                                                    
    ##  1st Qu.:-1.0145                                                    
    ##  Median : 0.6486                                                    
    ##  Mean   : 0.0000                                                    
    ##  3rd Qu.: 0.6486                                                    
    ##  Max.   : 0.6486                                                    
    ##  NA's   :1                                                          
    ##  C - 4. Required lab work submissions at the end of each lab manual that outline the activity to be done on your own
    ##  Min.   :-2.5440                                                                                                    
    ##  1st Qu.:-0.9027                                                                                                    
    ##  Median : 0.7386                                                                                                    
    ##  Mean   : 0.0000                                                                                                    
    ##  3rd Qu.: 0.7386                                                                                                    
    ##  Max.   : 0.7386                                                                                                    
    ##  NA's   :1                                                                                                          
    ##  C - 5. Supplementary videos to watch
    ##  Min.   :-3.6080                     
    ##  1st Qu.:-0.2149                     
    ##  Median :-0.2149                     
    ##  Mean   : 0.0000                     
    ##  3rd Qu.: 0.9161                     
    ##  Max.   : 0.9161                     
    ##  NA's   :1                           
    ##  C - 6. Supplementary podcasts to listen to
    ##  Min.   :-3.10583                          
    ##  1st Qu.:-0.08067                          
    ##  Median :-0.08067                          
    ##  Mean   : 0.00000                          
    ##  3rd Qu.: 0.92772                          
    ##  Max.   : 0.92772                          
    ##  NA's   :1                                 
    ##  C - 7. Supplementary content to read C - 8. Lectures slides
    ##  Min.   :-3.2864                      Min.   :-3.5875       
    ##  1st Qu.:-0.1762                      1st Qu.:-0.8279       
    ##  Median :-0.1762                      Median : 0.5519       
    ##  Mean   : 0.0000                      Mean   : 0.0000       
    ##  3rd Qu.: 0.8605                      3rd Qu.: 0.5519       
    ##  Max.   : 0.8605                      Max.   : 0.5519       
    ##  NA's   :1                            NA's   :1             
    ##  C - 9. Lecture notes on some of the lecture slides
    ##  Min.   :-4.0904                                   
    ##  1st Qu.:-0.9439                                   
    ##  Median : 0.6293                                   
    ##  Mean   : 0.0000                                   
    ##  3rd Qu.: 0.6293                                   
    ##  Max.   : 0.6293                                   
    ##  NA's   :1                                         
    ##  C - 10. The quality of the lectures given (quality measured by the breadth (the full span of knowledge of a subject) and depth (the extent to which specific topics are focused upon, amplified, and explored) of learning - NOT quality measured by how fun/comical/lively the lectures are)
    ##  Min.   :-3.8612                                                                                                                                                                                                                                                                              
    ##  1st Qu.:-0.8209                                                                                                                                                                                                                                                                              
    ##  Median : 0.6993                                                                                                                                                                                                                                                                              
    ##  Mean   : 0.0000                                                                                                                                                                                                                                                                              
    ##  3rd Qu.: 0.6993                                                                                                                                                                                                                                                                              
    ##  Max.   : 0.6993                                                                                                                                                                                                                                                                              
    ##  NA's   :1                                                                                                                                                                                                                                                                                    
    ##  C - 11. The division of theory and practice such that most of the theory is done during the recorded online classes and most of the practice is done during the physical classes
    ##  Min.   :-3.6142                                                                                                                                                                 
    ##  1st Qu.:-0.7112                                                                                                                                                                 
    ##  Median : 0.7403                                                                                                                                                                 
    ##  Mean   : 0.0000                                                                                                                                                                 
    ##  3rd Qu.: 0.7403                                                                                                                                                                 
    ##  Max.   : 0.7403                                                                                                                                                                 
    ##  NA's   :1                                                                                                                                                                       
    ##  C - 12. The recordings of online classes
    ##  Min.   :-2.7301                         
    ##  1st Qu.:-0.3867                         
    ##  Median : 0.7850                         
    ##  Mean   : 0.0000                         
    ##  3rd Qu.: 0.7850                         
    ##  Max.   : 0.7850                         
    ##  NA's   :1                               
    ##  D - 1. Write two things you like about the teaching and learning in this unit so far.
    ##  Length:101                                                                           
    ##  Class :character                                                                     
    ##  Mode  :character                                                                     
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##  D - 2. Write at least one recommendation to improve the teaching and learning in this unit (for the remaining weeks in the semester)
    ##  Length:101                                                                                                                          
    ##  Class :character                                                                                                                    
    ##  Mode  :character                                                                                                                    
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##  Average Course Evaluation Rating Average Level of Learning Attained Rating
    ##  Min.   :-4.05150                 Min.   :-2.9674                          
    ##  1st Qu.:-0.64504                 1st Qu.:-0.8428                          
    ##  Median : 0.03645                 Median :-0.1346                          
    ##  Mean   : 0.00000                 Mean   : 0.0000                          
    ##  3rd Qu.: 0.94477                 3rd Qu.: 0.5736                          
    ##  Max.   : 1.17185                 Max.   : 1.2818                          
    ##  NA's   :1                        NA's   :1                                
    ##  Average Pedagogical Strategy Effectiveness Rating
    ##  Min.   :-2.4737                                  
    ##  1st Qu.:-0.7196                                  
    ##  Median : 0.2250                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.9445                                  
    ##  Max.   : 1.1244                                  
    ##  NA's   :1                                        
    ##  Project: Section 1-4: (20%) x/10 Project: Section 5-11: (50%) x/10
    ##  Min.   :-3.8114                  Min.   :-2.3600                  
    ##  1st Qu.:-0.2907                  1st Qu.:-0.2087                  
    ##  Median : 0.2327                  Median : 0.4366                  
    ##  Mean   : 0.0000                  Mean   : 0.0000                  
    ##  3rd Qu.: 0.4706                  3rd Qu.: 0.6159                  
    ##  Max.   : 0.9464                  Max.   : 1.2255                  
    ##                                                                    
    ##  Project: Section 12: (30%) x/5 Project: (10%): x/30 x 100 TOTAL
    ##  Min.   :-0.5683                Min.   :-3.0961                 
    ##  1st Qu.:-0.5683                1st Qu.:-0.3172                 
    ##  Median :-0.5683                Median : 0.1989                 
    ##  Mean   : 0.0000                Mean   : 0.0000                 
    ##  3rd Qu.: 0.1316                3rd Qu.: 0.4569                 
    ##  Max.   : 2.2310                Max.   : 1.8662                 
    ##  NA's   :1                                                      
    ##  Quiz 1 on Concept 1 (Introduction) x/32 Quiz 3 on Concept 3 (Linear) x/15
    ##  Min.   :-1.7842                         Min.   :-2.1031                  
    ##  1st Qu.:-0.7420                         1st Qu.:-0.8149                  
    ##  Median :-0.1578                         Median :-0.1708                  
    ##  Mean   : 0.0000                         Mean   : 0.0000                  
    ##  3rd Qu.: 0.5032                         3rd Qu.: 0.7954                  
    ##  Max.   : 2.2894                         Max.   : 1.7615                  
    ##                                          NA's   :2                        
    ##  Quiz 4 on Concept 4 (Non-Linear) x/22 Quiz 5 on Concept 5 (Dashboarding) x/10
    ##  Min.   :-2.46748                      Min.   :-3.03179                       
    ##  1st Qu.:-0.68157                      1st Qu.:-0.65108                       
    ##  Median :-0.09831                      Median :-0.01782                       
    ##  Mean   : 0.00000                      Mean   : 0.00000                       
    ##  3rd Qu.: 0.80424                      3rd Qu.: 0.77734                       
    ##  Max.   : 1.81960                      Max.   : 3.00092                       
    ##  NA's   :6                             NA's   :12                             
    ##  Quizzes and  Bonus Marks (7%): x/79 x 100 TOTAL
    ##  Min.   :-1.81638                               
    ##  1st Qu.:-0.75175                               
    ##  Median :-0.05512                               
    ##  Mean   : 0.00000                               
    ##  3rd Qu.: 0.54207                               
    ##  Max.   : 2.36638                               
    ##                                                 
    ##  Lab 1 - 2.c. - (Simple Linear Regression) x/5
    ##  Min.   :-4.8297                              
    ##  1st Qu.: 0.2597                              
    ##  Median : 0.2597                              
    ##  Mean   : 0.0000                              
    ##  3rd Qu.: 0.2597                              
    ##  Max.   : 0.2597                              
    ##  NA's   :3                                    
    ##  Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5
    ##  Min.   :-1.9485                                               
    ##  1st Qu.:-0.9821                                               
    ##  Median : 0.6607                                               
    ##  Mean   : 0.0000                                               
    ##  3rd Qu.: 0.8056                                               
    ##  Max.   : 0.8056                                               
    ##  NA's   :6                                                     
    ##  Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5
    ##  Min.   :-2.7794                                                
    ##  1st Qu.: 0.3431                                                
    ##  Median : 0.3431                                                
    ##  Mean   : 0.0000                                                
    ##  3rd Qu.: 0.3431                                                
    ##  Max.   : 0.5773                                                
    ##  NA's   :9                                                      
    ##  Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5
    ##  Min.   :-2.8586                                  
    ##  1st Qu.:-0.3605                                  
    ##  Median : 0.4722                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.6387                                  
    ##  Max.   : 0.6387                                  
    ##  NA's   :18                                       
    ##  Lab 5 - Chart JS Dashboard Setup x/5 Lab Work (7%) x/25 x 100
    ##  Min.   :-1.4592                      Min.   :-3.20757        
    ##  1st Qu.:-1.4592                      1st Qu.:-0.46190        
    ##  Median : 0.6842                      Median : 0.01471        
    ##  Mean   : 0.0000                      Mean   : 0.00000        
    ##  3rd Qu.: 0.6842                      3rd Qu.: 0.90576        
    ##  Max.   : 0.6842                      Max.   : 1.05081        
    ##                                                               
    ##  CAT 1 (8%): x/38 x 100 CAT 2 (8%): x/100 x 100
    ##  Min.   :-2.41349       Min.   :-2.51821       
    ##  1st Qu.:-0.67329       1st Qu.:-0.45107       
    ##  Median : 0.02226       Median : 0.05559       
    ##  Mean   : 0.00000       Mean   : 0.00000       
    ##  3rd Qu.: 0.89236       3rd Qu.: 0.79530       
    ##  Max.   : 1.84908       Max.   : 1.53501       
    ##  NA's   :4              NA's   :31             
    ##  Attendance Waiver Granted: 1 = Yes, 0 = No Absenteeism Percentage
    ##  Min.   :-0.2271                            Min.   :-1.69613      
    ##  1st Qu.:-0.2271                            1st Qu.:-0.88083      
    ##  Median :-0.2271                            Median :-0.06663      
    ##  Mean   : 0.0000                            Mean   : 0.00000      
    ##  3rd Qu.:-0.2271                            3rd Qu.: 0.74867      
    ##  Max.   : 4.3600                            Max.   : 4.00877      
    ##                                                                   
    ##  Coursework TOTAL: x/40 (40%) EXAM: x/60 (60%)   
    ##  Min.   :-2.74036             Min.   :-2.570415  
    ##  1st Qu.:-0.65650             1st Qu.:-0.705101  
    ##  Median : 0.00867             Median : 0.005494  
    ##  Mean   : 0.00000             Mean   : 0.000000  
    ##  3rd Qu.: 0.76863             3rd Qu.: 0.716090  
    ##  Max.   : 1.69569             Max.   : 1.959633  
    ##                               NA's   :4          
    ##  TOTAL = Coursework TOTAL + EXAM (100%)    GRADE          
    ##  Min.   :-3.15733                       Length:101        
    ##  1st Qu.:-0.73640                       Class :character  
    ##  Median : 0.09983                       Mode  :character  
    ##  Mean   : 0.00000                                         
    ##  3rd Qu.: 0.74465                                         
    ##  Max.   : 1.94590                                         
    ## 

``` r
sapply(student_dataset_box_cox_transform[, 4],  skewness, type = 2)
```

    ## regret_choosing_bi 
    ##            6.99785

``` r
sapply(student_dataset_box_cox_transform[, 4], sd)
```

    ## regret_choosing_bi 
    ##                  1

``` r
# Calculate the skewness after the Box-Cox transform
sapply(student_dataset_box_cox_transform[, 4],  skewness, type = 2)
```

    ## regret_choosing_bi 
    ##            6.99785

``` r
sapply(student_dataset_box_cox_transform[, 4], sd)
```

    ## regret_choosing_bi 
    ##                  1

## STEP 8. Apply a Yeo-Johnson Power Transform —-

``` r
### Yeo-Johnson Power Transform on the StudentDataset ----
# BEFORE
summary(student_dataset_standardize_transform)
```

    ##  class_group            gender             YOB          regret_choosing_bi
    ##  Length:101         Min.   :-1.1556   Min.   :-2.9155   Min.   :-0.1414   
    ##  Class :character   1st Qu.:-1.1556   1st Qu.:-0.9055   1st Qu.:-0.1414   
    ##  Mode  :character   Median : 0.8568   Median : 0.0995   Median :-0.1414   
    ##                     Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   
    ##                     3rd Qu.: 0.8568   3rd Qu.: 1.1045   3rd Qu.:-0.1414   
    ##                     Max.   : 0.8568   Max.   : 2.1095   Max.   : 7.0007   
    ##                                                                           
    ##   drop_bi_now        motivator       read_content_before_lecture
    ##  Min.   :-0.1414   Min.   :-1.7349   Min.   :-1.8191            
    ##  1st Qu.:-0.1414   1st Qu.: 0.5707   1st Qu.:-0.7811            
    ##  Median :-0.1414   Median : 0.5707   Median : 0.2569            
    ##  Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000            
    ##  3rd Qu.:-0.1414   3rd Qu.: 0.5707   3rd Qu.: 0.2569            
    ##  Max.   : 7.0007   Max.   : 0.5707   Max.   : 2.3329            
    ##                                                                 
    ##  anticipate_test_questions answer_rhetorical_questions find_terms_I_do_not_know
    ##  Min.   :-2.6033           Min.   :-2.4418             Min.   :-2.5995         
    ##  1st Qu.:-0.5885           1st Qu.:-0.4286             1st Qu.:-0.7038         
    ##  Median : 0.4189           Median : 0.5780             Median : 0.2440         
    ##  Mean   : 0.0000           Mean   : 0.0000             Mean   : 0.0000         
    ##  3rd Qu.: 0.4189           3rd Qu.: 0.5780             3rd Qu.: 1.1918         
    ##  Max.   : 1.4263           Max.   : 1.5846             Max.   : 1.1918         
    ##                                                                                
    ##  copy_new_terms_in_reading_notebook take_quizzes_and_use_results
    ##  Min.   :-2.4058                    Min.   :-2.73448            
    ##  1st Qu.:-0.5992                    1st Qu.:-0.87466            
    ##  Median : 0.3041                    Median : 0.05524            
    ##  Mean   : 0.0000                    Mean   : 0.00000            
    ##  3rd Qu.: 0.3041                    3rd Qu.: 0.98515            
    ##  Max.   : 1.2074                    Max.   : 0.98515            
    ##                                                                 
    ##  reorganise_course_outline write_down_important_points space_out_revision
    ##  Min.   :-2.0550           Min.   :-2.6276             Min.   :-1.9709   
    ##  1st Qu.:-0.3254           1st Qu.:-0.7717             1st Qu.:-0.2015   
    ##  Median :-0.3254           Median : 0.1562             Median :-0.2015   
    ##  Mean   : 0.0000           Mean   : 0.0000             Mean   : 0.0000   
    ##  3rd Qu.: 0.5394           3rd Qu.: 1.0841             3rd Qu.: 0.6832   
    ##  Max.   : 1.4043           Max.   : 1.0841             Max.   : 1.5679   
    ##                                                                          
    ##  studying_in_study_group schedule_appointments goal_oriented    
    ##  Min.   :-1.0877         Min.   :-0.91037      Min.   :-0.4944  
    ##  1st Qu.:-1.0877         1st Qu.:-0.91037      1st Qu.:-0.4944  
    ##  Median :-0.3404         Median : 0.06779      Median :-0.4944  
    ##  Mean   : 0.0000         Mean   : 0.00000      Mean   : 0.0000  
    ##  3rd Qu.: 0.4070         3rd Qu.: 0.06779      3rd Qu.:-0.4944  
    ##  Max.   : 1.9016         Max.   : 3.00228      Max.   : 2.0025  
    ##                                                                 
    ##  spaced_repetition testing_and_active_recall  interleaving    
    ##  Min.   :-1.8720   Min.   :-2.86572          Min.   :-1.6908  
    ##  1st Qu.:-0.6677   1st Qu.:-0.08267          1st Qu.:-0.3461  
    ##  Median : 0.5366   Median :-0.08267          Median :-0.3461  
    ##  Mean   : 0.0000   Mean   : 0.00000          Mean   : 0.0000  
    ##  3rd Qu.: 0.5366   3rd Qu.: 1.30886          3rd Qu.: 0.9985  
    ##  Max.   : 1.7409   Max.   : 1.30886          Max.   : 2.3432  
    ##                                                               
    ##   categorizing     retrospective_timetable cornell_notes          sq3r        
    ##  Min.   :-2.3165   Min.   :-1.5883         Min.   :-1.5519   Min.   :-1.5392  
    ##  1st Qu.:-0.9641   1st Qu.:-0.4586         1st Qu.:-0.5472   1st Qu.:-0.5855  
    ##  Median : 0.3883   Median :-0.4586         Median : 0.4576   Median : 0.3683  
    ##  Mean   : 0.0000   Mean   : 0.0000         Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 0.3883   3rd Qu.: 0.6711         3rd Qu.: 0.4576   3rd Qu.: 0.3683  
    ##  Max.   : 1.7407   Max.   : 1.8008         Max.   : 1.4624   Max.   : 1.3220  
    ##                                                                               
    ##     commute          study_time      repeats_since_Y1   paid_tuition    
    ##  Min.   :-1.6586   Min.   :-0.9134   Min.   :-0.9716   Min.   :-0.3498  
    ##  1st Qu.:-0.6999   1st Qu.:-0.9134   1st Qu.:-0.9716   1st Qu.:-0.3498  
    ##  Median : 0.2589   Median : 0.3045   Median :-0.0237   Median :-0.3498  
    ##  Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 1.2176   3rd Qu.: 0.3045   3rd Qu.: 0.4502   3rd Qu.:-0.3498  
    ##  Max.   : 1.2176   Max.   : 2.7402   Max.   : 3.7678   Max.   : 2.8302  
    ##  NA's   :1         NA's   :1         NA's   :1         NA's   :1        
    ##   free_tuition     extra_curricular sports_extra_curricular exercise_per_week
    ##  Min.   :-0.6051   Min.   :-1.057   Min.   :-0.7462         Min.   :-1.3575  
    ##  1st Qu.:-0.6051   1st Qu.:-1.057   1st Qu.:-0.7462         1st Qu.:-0.1234  
    ##  Median :-0.6051   Median : 0.937   Median :-0.7462         Median :-0.1234  
    ##  Mean   : 0.0000   Mean   : 0.000   Mean   : 0.0000         Mean   : 0.0000  
    ##  3rd Qu.: 1.6361   3rd Qu.: 0.937   3rd Qu.: 1.3266         3rd Qu.: 1.1107  
    ##  Max.   : 1.6361   Max.   : 0.937   Max.   : 1.3266         Max.   : 2.3448  
    ##  NA's   :1         NA's   :1        NA's   :1               NA's   :1        
    ##     meditate            pray             internet           laptop 
    ##  Min.   :-0.8143   Min.   :-2.03728   Min.   :-2.5740   Min.   :0  
    ##  1st Qu.:-0.8143   1st Qu.:-1.06251   1st Qu.: 0.3846   1st Qu.:0  
    ##  Median : 0.2571   Median :-0.08773   Median : 0.3846   Median :0  
    ##  Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.0000   Mean   :0  
    ##  3rd Qu.: 0.2571   3rd Qu.: 0.88705   3rd Qu.: 0.3846   3rd Qu.:0  
    ##  Max.   : 2.4000   Max.   : 0.88705   Max.   : 0.3846   Max.   :0  
    ##  NA's   :1         NA's   :1          NA's   :1         NA's   :1  
    ##  family_relationships  friendships       romantic_relationships
    ##  Min.   :-2.7369      Min.   :-2.74737   Min.   :-0.8531       
    ##  1st Qu.:-0.2374      1st Qu.:-0.01367   1st Qu.:-0.8531       
    ##  Median :-0.2374      Median :-0.01367   Median :-0.8531       
    ##  Mean   : 0.0000      Mean   : 0.00000   Mean   : 0.0000       
    ##  3rd Qu.: 1.0123      3rd Qu.:-0.01367   3rd Qu.: 1.0150       
    ##  Max.   : 1.0123      Max.   : 1.35318   Max.   : 1.6377       
    ##  NA's   :1            NA's   :1          NA's   :1             
    ##  spiritual_wellnes financial_wellness     health            day_out       
    ##  Min.   :-2.8309   Min.   :-1.85227   Min.   :-3.19122   Min.   :-1.4071  
    ##  1st Qu.:-0.6944   1st Qu.:-0.93982   1st Qu.:-1.09173   1st Qu.:-1.4071  
    ##  Median : 0.3739   Median :-0.02737   Median :-0.04199   Median : 0.3518  
    ##  Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.00000   Mean   : 0.0000  
    ##  3rd Qu.: 0.3739   3rd Qu.: 0.88508   3rd Qu.: 1.00775   3rd Qu.: 0.3518  
    ##  Max.   : 1.4422   Max.   : 1.79752   Max.   : 1.00775   Max.   : 3.8696  
    ##  NA's   :1         NA's   :1          NA's   :1          NA's   :1        
    ##    night_out       alcohol_or_narcotics     mentor        mentor_meetings  
    ##  Min.   :-0.7926   Min.   :-0.628       Min.   :-0.8294   Min.   :-0.8101  
    ##  1st Qu.:-0.7926   1st Qu.:-0.628       1st Qu.:-0.8294   1st Qu.:-0.8101  
    ##  Median :-0.7926   Median :-0.628       Median :-0.8294   Median :-0.8101  
    ##  Mean   : 0.0000   Mean   : 0.000       Mean   : 0.0000   Mean   : 0.0000  
    ##  3rd Qu.: 0.7615   3rd Qu.: 1.166       3rd Qu.: 1.1936   3rd Qu.: 0.3812  
    ##  Max.   : 3.8697   Max.   : 4.755       Max.   : 1.1936   Max.   : 2.7638  
    ##  NA's   :1         NA's   :1            NA's   :1         NA's   :1        
    ##  A - 1. I am enjoying the subject A - 2. Classes start and end on time
    ##  Min.   :-2.5063                  Min.   :-3.4293                     
    ##  1st Qu.:-0.8242                  1st Qu.:-1.3880                     
    ##  Median : 0.8579                  Median : 0.6532                     
    ##  Mean   : 0.0000                  Mean   : 0.0000                     
    ##  3rd Qu.: 0.8579                  3rd Qu.: 0.6532                     
    ##  Max.   : 0.8579                  Max.   : 0.6532                     
    ##  NA's   :1                        NA's   :1                           
    ##  A - 3. The learning environment is participative, involves learning by doing and is group-based
    ##  Min.   :-2.0544                                                                                
    ##  1st Qu.:-0.5326                                                                                
    ##  Median :-0.5326                                                                                
    ##  Mean   : 0.0000                                                                                
    ##  3rd Qu.: 0.9892                                                                                
    ##  Max.   : 0.9892                                                                                
    ##  NA's   :1                                                                                      
    ##  A - 4. The subject content is delivered according to the course outline and meets my expectations
    ##  Min.   :-3.75655                                                                                 
    ##  1st Qu.: 0.02159                                                                                 
    ##  Median : 0.56132                                                                                 
    ##  Mean   : 0.00000                                                                                 
    ##  3rd Qu.: 0.56132                                                                                 
    ##  Max.   : 0.56132                                                                                 
    ##  NA's   :1                                                                                        
    ##  A - 5. The topics are clear and logically developed
    ##  Min.   :-4.6074                                    
    ##  1st Qu.:-1.1301                                    
    ##  Median : 0.6085                                    
    ##  Mean   : 0.0000                                    
    ##  3rd Qu.: 0.6085                                    
    ##  Max.   : 0.6085                                    
    ##  NA's   :1                                          
    ##  A - 6. I am developing my oral and writing skills
    ##  Min.   :-3.5544                                  
    ##  1st Qu.:-0.1257                                  
    ##  Median :-0.1257                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 1.0172                                  
    ##  Max.   : 1.0172                                  
    ##  NA's   :1                                        
    ##  A - 7. I am developing my reflective and critical reasoning skills
    ##  Min.   :-3.4338                                                   
    ##  1st Qu.:-0.5483                                                   
    ##  Median :-0.5483                                                   
    ##  Mean   : 0.0000                                                   
    ##  3rd Qu.: 0.8945                                                   
    ##  Max.   : 0.8945                                                   
    ##  NA's   :1                                                         
    ##  A - 8. The assessment methods are assisting me to learn
    ##  Min.   :-5.5563                                        
    ##  1st Qu.:-0.9389                                        
    ##  Median : 0.6003                                        
    ##  Mean   : 0.0000                                        
    ##  3rd Qu.: 0.6003                                        
    ##  Max.   : 0.6003                                        
    ##  NA's   :1                                              
    ##  A - 9. I receive relevant feedback
    ##  Min.   :-2.8531                   
    ##  1st Qu.:-1.0474                   
    ##  Median : 0.7584                   
    ##  Mean   : 0.0000                   
    ##  3rd Qu.: 0.7584                   
    ##  Max.   : 0.7584                   
    ##  NA's   :1                         
    ##  A - 10. I read the recommended readings and notes
    ##  Min.   :-2.4775                                  
    ##  1st Qu.:-0.8791                                  
    ##  Median : 0.7193                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.7193                                  
    ##  Max.   : 0.7193                                  
    ##  NA's   :1                                        
    ##  A - 11. I use the eLearning material posted
    ##  Min.   :-3.2553                            
    ##  1st Qu.:-1.3404                            
    ##  Median : 0.5745                            
    ##  Mean   : 0.0000                            
    ##  3rd Qu.: 0.5745                            
    ##  Max.   : 0.5745                            
    ##  NA's   :1                                  
    ##  B - 1. Concept 1 of 6: Principles of Business Intelligence and the DataOps Philosophy
    ##  Min.   :-4.1489                                                                      
    ##  1st Qu.:-0.3191                                                                      
    ##  Median :-0.3191                                                                      
    ##  Mean   : 0.0000                                                                      
    ##  3rd Qu.: 0.9574                                                                      
    ##  Max.   : 0.9574                                                                      
    ##  NA's   :1                                                                            
    ##  B - 2. Concept 3 of 6: Linear Algorithms for Predictive Analytics
    ##  Min.   :-2.24938                                                 
    ##  1st Qu.:-1.08990                                                 
    ##  Median : 0.06957                                                 
    ##  Mean   : 0.00000                                                 
    ##  3rd Qu.: 1.22904                                                 
    ##  Max.   : 1.22904                                                 
    ##  NA's   :1                                                        
    ##  C - 2. Quizzes at the end of each concept
    ##  Min.   :-4.1701                          
    ##  1st Qu.:-0.9499                          
    ##  Median : 0.6601                          
    ##  Mean   : 0.0000                          
    ##  3rd Qu.: 0.6601                          
    ##  Max.   : 0.6601                          
    ##  NA's   :1                                
    ##  C - 3. Lab manuals that outline the steps to follow during the labs
    ##  Min.   :-2.6777                                                    
    ##  1st Qu.:-1.0145                                                    
    ##  Median : 0.6486                                                    
    ##  Mean   : 0.0000                                                    
    ##  3rd Qu.: 0.6486                                                    
    ##  Max.   : 0.6486                                                    
    ##  NA's   :1                                                          
    ##  C - 4. Required lab work submissions at the end of each lab manual that outline the activity to be done on your own
    ##  Min.   :-2.5440                                                                                                    
    ##  1st Qu.:-0.9027                                                                                                    
    ##  Median : 0.7386                                                                                                    
    ##  Mean   : 0.0000                                                                                                    
    ##  3rd Qu.: 0.7386                                                                                                    
    ##  Max.   : 0.7386                                                                                                    
    ##  NA's   :1                                                                                                          
    ##  C - 5. Supplementary videos to watch
    ##  Min.   :-3.6080                     
    ##  1st Qu.:-0.2149                     
    ##  Median :-0.2149                     
    ##  Mean   : 0.0000                     
    ##  3rd Qu.: 0.9161                     
    ##  Max.   : 0.9161                     
    ##  NA's   :1                           
    ##  C - 6. Supplementary podcasts to listen to
    ##  Min.   :-3.10583                          
    ##  1st Qu.:-0.08067                          
    ##  Median :-0.08067                          
    ##  Mean   : 0.00000                          
    ##  3rd Qu.: 0.92772                          
    ##  Max.   : 0.92772                          
    ##  NA's   :1                                 
    ##  C - 7. Supplementary content to read C - 8. Lectures slides
    ##  Min.   :-3.2864                      Min.   :-3.5875       
    ##  1st Qu.:-0.1762                      1st Qu.:-0.8279       
    ##  Median :-0.1762                      Median : 0.5519       
    ##  Mean   : 0.0000                      Mean   : 0.0000       
    ##  3rd Qu.: 0.8605                      3rd Qu.: 0.5519       
    ##  Max.   : 0.8605                      Max.   : 0.5519       
    ##  NA's   :1                            NA's   :1             
    ##  C - 9. Lecture notes on some of the lecture slides
    ##  Min.   :-4.0904                                   
    ##  1st Qu.:-0.9439                                   
    ##  Median : 0.6293                                   
    ##  Mean   : 0.0000                                   
    ##  3rd Qu.: 0.6293                                   
    ##  Max.   : 0.6293                                   
    ##  NA's   :1                                         
    ##  C - 10. The quality of the lectures given (quality measured by the breadth (the full span of knowledge of a subject) and depth (the extent to which specific topics are focused upon, amplified, and explored) of learning - NOT quality measured by how fun/comical/lively the lectures are)
    ##  Min.   :-3.8612                                                                                                                                                                                                                                                                              
    ##  1st Qu.:-0.8209                                                                                                                                                                                                                                                                              
    ##  Median : 0.6993                                                                                                                                                                                                                                                                              
    ##  Mean   : 0.0000                                                                                                                                                                                                                                                                              
    ##  3rd Qu.: 0.6993                                                                                                                                                                                                                                                                              
    ##  Max.   : 0.6993                                                                                                                                                                                                                                                                              
    ##  NA's   :1                                                                                                                                                                                                                                                                                    
    ##  C - 11. The division of theory and practice such that most of the theory is done during the recorded online classes and most of the practice is done during the physical classes
    ##  Min.   :-3.6142                                                                                                                                                                 
    ##  1st Qu.:-0.7112                                                                                                                                                                 
    ##  Median : 0.7403                                                                                                                                                                 
    ##  Mean   : 0.0000                                                                                                                                                                 
    ##  3rd Qu.: 0.7403                                                                                                                                                                 
    ##  Max.   : 0.7403                                                                                                                                                                 
    ##  NA's   :1                                                                                                                                                                       
    ##  C - 12. The recordings of online classes
    ##  Min.   :-2.7301                         
    ##  1st Qu.:-0.3867                         
    ##  Median : 0.7850                         
    ##  Mean   : 0.0000                         
    ##  3rd Qu.: 0.7850                         
    ##  Max.   : 0.7850                         
    ##  NA's   :1                               
    ##  D - 1. Write two things you like about the teaching and learning in this unit so far.
    ##  Length:101                                                                           
    ##  Class :character                                                                     
    ##  Mode  :character                                                                     
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##  D - 2. Write at least one recommendation to improve the teaching and learning in this unit (for the remaining weeks in the semester)
    ##  Length:101                                                                                                                          
    ##  Class :character                                                                                                                    
    ##  Mode  :character                                                                                                                    
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##  Average Course Evaluation Rating Average Level of Learning Attained Rating
    ##  Min.   :-4.05150                 Min.   :-2.9674                          
    ##  1st Qu.:-0.64504                 1st Qu.:-0.8428                          
    ##  Median : 0.03645                 Median :-0.1346                          
    ##  Mean   : 0.00000                 Mean   : 0.0000                          
    ##  3rd Qu.: 0.94477                 3rd Qu.: 0.5736                          
    ##  Max.   : 1.17185                 Max.   : 1.2818                          
    ##  NA's   :1                        NA's   :1                                
    ##  Average Pedagogical Strategy Effectiveness Rating
    ##  Min.   :-2.4737                                  
    ##  1st Qu.:-0.7196                                  
    ##  Median : 0.2250                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.9445                                  
    ##  Max.   : 1.1244                                  
    ##  NA's   :1                                        
    ##  Project: Section 1-4: (20%) x/10 Project: Section 5-11: (50%) x/10
    ##  Min.   :-3.8114                  Min.   :-2.3600                  
    ##  1st Qu.:-0.2907                  1st Qu.:-0.2087                  
    ##  Median : 0.2327                  Median : 0.4366                  
    ##  Mean   : 0.0000                  Mean   : 0.0000                  
    ##  3rd Qu.: 0.4706                  3rd Qu.: 0.6159                  
    ##  Max.   : 0.9464                  Max.   : 1.2255                  
    ##                                                                    
    ##  Project: Section 12: (30%) x/5 Project: (10%): x/30 x 100 TOTAL
    ##  Min.   :-0.5683                Min.   :-3.0961                 
    ##  1st Qu.:-0.5683                1st Qu.:-0.3172                 
    ##  Median :-0.5683                Median : 0.1989                 
    ##  Mean   : 0.0000                Mean   : 0.0000                 
    ##  3rd Qu.: 0.1316                3rd Qu.: 0.4569                 
    ##  Max.   : 2.2310                Max.   : 1.8662                 
    ##  NA's   :1                                                      
    ##  Quiz 1 on Concept 1 (Introduction) x/32 Quiz 3 on Concept 3 (Linear) x/15
    ##  Min.   :-1.7842                         Min.   :-2.1031                  
    ##  1st Qu.:-0.7420                         1st Qu.:-0.8149                  
    ##  Median :-0.1578                         Median :-0.1708                  
    ##  Mean   : 0.0000                         Mean   : 0.0000                  
    ##  3rd Qu.: 0.5032                         3rd Qu.: 0.7954                  
    ##  Max.   : 2.2894                         Max.   : 1.7615                  
    ##                                          NA's   :2                        
    ##  Quiz 4 on Concept 4 (Non-Linear) x/22 Quiz 5 on Concept 5 (Dashboarding) x/10
    ##  Min.   :-2.46748                      Min.   :-3.03179                       
    ##  1st Qu.:-0.68157                      1st Qu.:-0.65108                       
    ##  Median :-0.09831                      Median :-0.01782                       
    ##  Mean   : 0.00000                      Mean   : 0.00000                       
    ##  3rd Qu.: 0.80424                      3rd Qu.: 0.77734                       
    ##  Max.   : 1.81960                      Max.   : 3.00092                       
    ##  NA's   :6                             NA's   :12                             
    ##  Quizzes and  Bonus Marks (7%): x/79 x 100 TOTAL
    ##  Min.   :-1.81638                               
    ##  1st Qu.:-0.75175                               
    ##  Median :-0.05512                               
    ##  Mean   : 0.00000                               
    ##  3rd Qu.: 0.54207                               
    ##  Max.   : 2.36638                               
    ##                                                 
    ##  Lab 1 - 2.c. - (Simple Linear Regression) x/5
    ##  Min.   :-4.8297                              
    ##  1st Qu.: 0.2597                              
    ##  Median : 0.2597                              
    ##  Mean   : 0.0000                              
    ##  3rd Qu.: 0.2597                              
    ##  Max.   : 0.2597                              
    ##  NA's   :3                                    
    ##  Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5
    ##  Min.   :-1.9485                                               
    ##  1st Qu.:-0.9821                                               
    ##  Median : 0.6607                                               
    ##  Mean   : 0.0000                                               
    ##  3rd Qu.: 0.8056                                               
    ##  Max.   : 0.8056                                               
    ##  NA's   :6                                                     
    ##  Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5
    ##  Min.   :-2.7794                                                
    ##  1st Qu.: 0.3431                                                
    ##  Median : 0.3431                                                
    ##  Mean   : 0.0000                                                
    ##  3rd Qu.: 0.3431                                                
    ##  Max.   : 0.5773                                                
    ##  NA's   :9                                                      
    ##  Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5
    ##  Min.   :-2.8586                                  
    ##  1st Qu.:-0.3605                                  
    ##  Median : 0.4722                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.6387                                  
    ##  Max.   : 0.6387                                  
    ##  NA's   :18                                       
    ##  Lab 5 - Chart JS Dashboard Setup x/5 Lab Work (7%) x/25 x 100
    ##  Min.   :-1.4592                      Min.   :-3.20757        
    ##  1st Qu.:-1.4592                      1st Qu.:-0.46190        
    ##  Median : 0.6842                      Median : 0.01471        
    ##  Mean   : 0.0000                      Mean   : 0.00000        
    ##  3rd Qu.: 0.6842                      3rd Qu.: 0.90576        
    ##  Max.   : 0.6842                      Max.   : 1.05081        
    ##                                                               
    ##  CAT 1 (8%): x/38 x 100 CAT 2 (8%): x/100 x 100
    ##  Min.   :-2.41349       Min.   :-2.51821       
    ##  1st Qu.:-0.67329       1st Qu.:-0.45107       
    ##  Median : 0.02226       Median : 0.05559       
    ##  Mean   : 0.00000       Mean   : 0.00000       
    ##  3rd Qu.: 0.89236       3rd Qu.: 0.79530       
    ##  Max.   : 1.84908       Max.   : 1.53501       
    ##  NA's   :4              NA's   :31             
    ##  Attendance Waiver Granted: 1 = Yes, 0 = No Absenteeism Percentage
    ##  Min.   :-0.2271                            Min.   :-1.69613      
    ##  1st Qu.:-0.2271                            1st Qu.:-0.88083      
    ##  Median :-0.2271                            Median :-0.06663      
    ##  Mean   : 0.0000                            Mean   : 0.00000      
    ##  3rd Qu.:-0.2271                            3rd Qu.: 0.74867      
    ##  Max.   : 4.3600                            Max.   : 4.00877      
    ##                                                                   
    ##  Coursework TOTAL: x/40 (40%) EXAM: x/60 (60%)   
    ##  Min.   :-2.74036             Min.   :-2.570415  
    ##  1st Qu.:-0.65650             1st Qu.:-0.705101  
    ##  Median : 0.00867             Median : 0.005494  
    ##  Mean   : 0.00000             Mean   : 0.000000  
    ##  3rd Qu.: 0.76863             3rd Qu.: 0.716090  
    ##  Max.   : 1.69569             Max.   : 1.959633  
    ##                               NA's   :4          
    ##  TOTAL = Coursework TOTAL + EXAM (100%)    GRADE          
    ##  Min.   :-3.15733                       Length:101        
    ##  1st Qu.:-0.73640                       Class :character  
    ##  Median : 0.09983                       Mode  :character  
    ##  Mean   : 0.00000                                         
    ##  3rd Qu.: 0.74465                                         
    ##  Max.   : 1.94590                                         
    ## 

``` r
# Calculate the skewness before the Yeo-Johnson transform
sapply(student_dataset_standardize_transform[, 4],  skewness, type = 2)
```

    ## regret_choosing_bi 
    ##            6.99785

``` r
sapply(student_dataset_standardize_transform[, 4], sd)
```

    ## regret_choosing_bi 
    ##                  1

``` r
model_of_the_transform <- preProcess(student_dataset_standardize_transform,
                                     method = c("YeoJohnson"))
print(model_of_the_transform)
```

    ## Created from 51 samples and 80 variables
    ## 
    ## Pre-processing:
    ##   - ignored (4)
    ##   - Yeo-Johnson transformation (76)
    ## 
    ## Lambda estimates for Yeo-Johnson transformation:
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##  -1.516   1.019   1.286   1.346   1.729   2.944

``` r
student_dataset_yeo_johnson_transform <- predict(model_of_the_transform, # nolint
                                                 student_dataset_standardize_transform)

# AFTER
summary(student_dataset_yeo_johnson_transform)
```

    ##  class_group            gender             YOB          regret_choosing_bi
    ##  Length:101         Min.   :-1.1556   Min.   :-2.2666   Min.   :-0.1414   
    ##  Class :character   1st Qu.:-1.1556   1st Qu.:-0.8119   1st Qu.:-0.1414   
    ##  Mode  :character   Median : 0.8568   Median : 0.1010   Median :-0.1414   
    ##                     Mean   : 0.0000   Mean   : 0.1060   Mean   : 0.0000   
    ##                     3rd Qu.: 0.8568   3rd Qu.: 1.2602   3rd Qu.:-0.1414   
    ##                     Max.   : 0.8568   Max.   : 2.6116   Max.   : 7.0007   
    ##                                                                           
    ##   drop_bi_now        motivator       read_content_before_lecture
    ##  Min.   :-0.1414   Min.   :-1.7349   Min.   :-1.798183          
    ##  1st Qu.:-0.1414   1st Qu.: 0.5707   1st Qu.:-0.776376          
    ##  Median :-0.1414   Median : 0.5707   Median : 0.257514          
    ##  Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.006614          
    ##  3rd Qu.:-0.1414   3rd Qu.: 0.5707   3rd Qu.: 0.257514          
    ##  Max.   : 7.0007   Max.   : 0.5707   Max.   : 2.365249          
    ##                                                                 
    ##  anticipate_test_questions answer_rhetorical_questions find_terms_I_do_not_know
    ##  Min.   :-1.9321           Min.   :-2.09770            Min.   :-1.8211         
    ##  1st Qu.:-0.5336           1st Qu.:-0.41212            1st Qu.:-0.6142         
    ##  Median : 0.4513           Median : 0.60856            Median : 0.2577         
    ##  Mean   : 0.1341           Mean   : 0.07314            Mean   : 0.1602         
    ##  3rd Qu.: 0.4513           3rd Qu.: 0.60856            3rd Qu.: 1.4823         
    ##  Max.   : 1.7547           Max.   : 1.77914            Max.   : 1.4823         
    ##                                                                                
    ##  copy_new_terms_in_reading_notebook take_quizzes_and_use_results
    ##  Min.   :-1.7255                    Min.   :-1.64398            
    ##  1st Qu.:-0.5331                    1st Qu.:-0.69707            
    ##  Median : 0.3248                    Median : 0.05627            
    ##  Mean   : 0.1608                    Mean   : 0.22411            
    ##  3rd Qu.: 0.3248                    3rd Qu.: 1.28604            
    ##  Max.   : 1.4985                    Max.   : 1.28604            
    ##                                                                 
    ##  reorganise_course_outline write_down_important_points space_out_revision
    ##  Min.   :-1.74452          Min.   :-1.6851             Min.   :-1.81498  
    ##  1st Qu.:-0.31354          1st Qu.:-0.6425             1st Qu.:-0.19902  
    ##  Median :-0.31354          Median : 0.1634             Median :-0.19902  
    ##  Mean   : 0.08931          Mean   : 0.2004             Mean   : 0.04579  
    ##  3rd Qu.: 0.57220          3rd Qu.: 1.3991             3rd Qu.: 0.70891  
    ##  Max.   : 1.59747          Max.   : 1.3991             Max.   : 1.68372  
    ##                                                                          
    ##  studying_in_study_group schedule_appointments goal_oriented    
    ##  Min.   :-1.3056         Min.   :-1.22922      Min.   :-0.4944  
    ##  1st Qu.:-1.3056         1st Qu.:-1.22922      1st Qu.:-0.4944  
    ##  Median :-0.3640         Median : 0.06601      Median :-0.4944  
    ##  Mean   :-0.1541         Mean   :-0.25840      Mean   : 0.0000  
    ##  3rd Qu.: 0.3768         3rd Qu.: 0.06601      3rd Qu.:-0.4944  
    ##  Max.   : 1.4633         Max.   : 1.58982      Max.   : 2.0025  
    ##                                                                 
    ##  spaced_repetition  testing_and_active_recall  interleaving     
    ##  Min.   :-1.63578   Min.   :-2.44185          Min.   :-1.80877  
    ##  1st Qu.:-0.62825   1st Qu.:-0.08201          1st Qu.:-0.35250  
    ##  Median : 0.56484   Median :-0.08201          Median :-0.35250  
    ##  Mean   : 0.07797   Mean   : 0.06764          Mean   :-0.04078  
    ##  3rd Qu.: 0.56484   3rd Qu.: 1.43953          3rd Qu.: 0.95493  
    ##  Max.   : 1.98677   Max.   : 1.43953          Max.   : 2.15605  
    ##                                                                 
    ##   categorizing      retrospective_timetable cornell_notes     
    ##  Min.   :-1.92388   Min.   :-1.57200        Min.   :-1.42815  
    ##  1st Qu.:-0.87408   1st Qu.:-0.45687        1st Qu.:-0.52772  
    ##  Median : 0.40665   Median :-0.45687        Median : 0.47215  
    ##  Mean   : 0.09096   Mean   : 0.00671        Mean   : 0.05579  
    ##  3rd Qu.: 0.40665   3rd Qu.: 0.67463        3rd Qu.: 0.47215  
    ##  Max.   : 2.03934   Max.   : 1.82130        Max.   : 1.58606  
    ##                                                               
    ##       sq3r            commute          study_time      repeats_since_Y1  
    ##  Min.   :-1.4465   Min.   :-1.4057   Min.   :-1.1821   Min.   :-1.33309  
    ##  1st Qu.:-0.5688   1st Qu.:-0.6429   1st Qu.:-1.1821   1st Qu.:-1.33309  
    ##  Median : 0.3754   Median : 0.2683   Median : 0.2769   Median :-0.02392  
    ##  Mean   : 0.0422   Mean   : 0.1065   Mean   :-0.2308   Mean   :-0.26078  
    ##  3rd Qu.: 0.3754   3rd Qu.: 1.3954   3rd Qu.: 0.2769   3rd Qu.: 0.38545  
    ##  Max.   : 1.3985   Max.   : 1.3954   Max.   : 1.6239   Max.   : 1.82421  
    ##                    NA's   :1         NA's   :1         NA's   :1         
    ##   paid_tuition      free_tuition     extra_curricular sports_extra_curricular
    ##  Min.   :-0.3498   Min.   :-0.6051   Min.   :-1.057   Min.   :-0.7462        
    ##  1st Qu.:-0.3498   1st Qu.:-0.6051   1st Qu.:-1.057   1st Qu.:-0.7462        
    ##  Median :-0.3498   Median :-0.6051   Median : 0.937   Median :-0.7462        
    ##  Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.000   Mean   : 0.0000        
    ##  3rd Qu.:-0.3498   3rd Qu.: 1.6361   3rd Qu.: 0.937   3rd Qu.: 1.3266        
    ##  Max.   : 2.8302   Max.   : 1.6361   Max.   : 0.937   Max.   : 1.3266        
    ##  NA's   :1         NA's   :1         NA's   :1        NA's   :1              
    ##  exercise_per_week    meditate            pray             internet      
    ##  Min.   :-1.5447   Min.   :-1.1509   Min.   :-1.27321   Min.   :-2.5740  
    ##  1st Qu.:-0.1253   1st Qu.:-1.1509   1st Qu.:-0.79064   1st Qu.: 0.3846  
    ##  Median :-0.1253   Median : 0.2285   Median :-0.08495   Median : 0.3846  
    ##  Mean   :-0.0897   Mean   :-0.3158   Mean   : 0.26508   Mean   : 0.0000  
    ##  3rd Qu.: 0.9975   3rd Qu.: 0.2285   3rd Qu.: 1.16904   3rd Qu.: 0.3846  
    ##  Max.   : 1.9511   Max.   : 1.2145   Max.   : 1.16904   Max.   : 0.3846  
    ##  NA's   :1         NA's   :1         NA's   :1          NA's   :1        
    ##      laptop  family_relationships  friendships       romantic_relationships
    ##  Min.   :0   Min.   :-1.9235      Min.   :-2.27383   Min.   :-1.1137       
    ##  1st Qu.:0   1st Qu.:-0.2258      1st Qu.:-0.01365   1st Qu.:-1.1137       
    ##  Median :0   Median :-0.2258      Median :-0.01365   Median :-1.1137       
    ##  Mean   :0   Mean   : 0.1599      Mean   : 0.08138   Mean   :-0.2766       
    ##  3rd Qu.:0   3rd Qu.: 1.2157      3rd Qu.:-0.01365   3rd Qu.: 0.7635       
    ##  Max.   :0   Max.   : 1.2157      Max.   : 1.52456   Max.   : 1.0932       
    ##  NA's   :1   NA's   :1            NA's   :1          NA's   :1             
    ##  spiritual_wellnes  financial_wellness     health            day_out        
    ##  Min.   :-2.66531   Min.   :-1.81321   Min.   :-1.96975   Min.   :-1.41267  
    ##  1st Qu.:-0.67980   1st Qu.:-0.92790   1st Qu.:-0.86608   1st Qu.:-1.41267  
    ##  Median : 0.37857   Median :-0.02736   Median :-0.04149   Median : 0.35135  
    ##  Mean   : 0.02641   Mean   : 0.01215   Mean   : 0.19377   Mean   :-0.00264  
    ##  3rd Qu.: 0.37857   3rd Qu.: 0.89595   3rd Qu.: 1.26947   3rd Qu.: 0.35135  
    ##  Max.   : 1.49828   Max.   : 1.83561   Max.   : 1.26947   Max.   : 3.83971  
    ##  NA's   :1          NA's   :1          NA's   :1          NA's   :1         
    ##    night_out       alcohol_or_narcotics     mentor        mentor_meetings  
    ##  Min.   :-1.0827   Min.   :-1.0815      Min.   :-0.8294   Min.   :-1.1321  
    ##  1st Qu.:-1.0827   1st Qu.:-1.0815      1st Qu.:-0.8294   1st Qu.:-1.1321  
    ##  Median :-1.0827   Median :-1.0815      Median :-0.8294   Median :-1.1321  
    ##  Mean   :-0.3010   Mean   :-0.5535      Mean   : 0.0000   Mean   :-0.3232  
    ##  3rd Qu.: 0.5764   3rd Qu.: 0.5516      3rd Qu.: 1.1936   3rd Qu.: 0.3237  
    ##  Max.   : 1.6649   Max.   : 0.8649      Max.   : 1.1936   Max.   : 1.3387  
    ##  NA's   :1         NA's   :1            NA's   :1         NA's   :1        
    ##  A - 1. I am enjoying the subject A - 2. Classes start and end on time
    ##  Min.   :-1.5019                  Min.   :-0.8033                     
    ##  1st Qu.:-0.6545                  1st Qu.:-0.5955                     
    ##  Median : 1.1063                  Median : 1.1495                     
    ##  Mean   : 0.2540                  Mean   : 0.6065                     
    ##  3rd Qu.: 1.1063                  3rd Qu.: 1.1495                     
    ##  Max.   : 1.1063                  Max.   : 1.1495                     
    ##  NA's   :1                        NA's   :1                           
    ##  A - 3. The learning environment is participative, involves learning by doing and is group-based
    ##  Min.   :-1.6003                                                                                
    ##  1st Qu.:-0.4878                                                                                
    ##  Median :-0.4878                                                                                
    ##  Mean   : 0.1388                                                                                
    ##  3rd Qu.: 1.1517                                                                                
    ##  Max.   : 1.1517                                                                                
    ##  NA's   :1                                                                                      
    ##  A - 4. The subject content is delivered according to the course outline and meets my expectations
    ##  Min.   :-3.75655                                                                                 
    ##  1st Qu.: 0.02159                                                                                 
    ##  Median : 0.56132                                                                                 
    ##  Mean   : 0.00000                                                                                 
    ##  3rd Qu.: 0.56132                                                                                 
    ##  Max.   : 0.56132                                                                                 
    ##  NA's   :1                                                                                        
    ##  A - 5. The topics are clear and logically developed
    ##  Min.   :-4.6074                                    
    ##  1st Qu.:-1.1301                                    
    ##  Median : 0.6085                                    
    ##  Mean   : 0.0000                                    
    ##  3rd Qu.: 0.6085                                    
    ##  Max.   : 0.6085                                    
    ##  NA's   :1                                          
    ##  A - 6. I am developing my oral and writing skills
    ##  Min.   :-2.0600                                  
    ##  1st Qu.:-0.1212                                  
    ##  Median :-0.1212                                  
    ##  Mean   : 0.1942                                  
    ##  3rd Qu.: 1.3035                                  
    ##  Max.   : 1.3035                                  
    ##  NA's   :1                                        
    ##  A - 7. I am developing my reflective and critical reasoning skills
    ##  Min.   :-1.9407                                                   
    ##  1st Qu.:-0.4714                                                   
    ##  Median :-0.4714                                                   
    ##  Mean   : 0.2199                                                   
    ##  3rd Qu.: 1.1371                                                   
    ##  Max.   : 1.1371                                                   
    ##  NA's   :1                                                         
    ##  A - 8. The assessment methods are assisting me to learn
    ##  Min.   :-0.8799                                        
    ##  1st Qu.:-0.4924                                        
    ##  Median : 1.0161                                        
    ##  Mean   : 0.5072                                        
    ##  3rd Qu.: 1.0161                                        
    ##  Max.   : 1.0161                                        
    ##  NA's   :1                                              
    ##  A - 9. I receive relevant feedback
    ##  Min.   :-1.1901                   
    ##  1st Qu.:-0.6700                   
    ##  Median : 1.1150                   
    ##  Mean   : 0.4033                   
    ##  3rd Qu.: 1.1150                   
    ##  Max.   : 1.1150                   
    ##  NA's   :1                         
    ##  A - 10. I read the recommended readings and notes
    ##  Min.   :-0.9936                                  
    ##  1st Qu.:-0.5612                                  
    ##  Median : 1.1052                                  
    ##  Mean   : 0.4417                                  
    ##  3rd Qu.: 1.1052                                  
    ##  Max.   : 1.1052                                  
    ##  NA's   :1                                        
    ##  A - 11. I use the eLearning material posted
    ##  Min.   :-3.2553                            
    ##  1st Qu.:-1.3404                            
    ##  Median : 0.5745                            
    ##  Mean   : 0.0000                            
    ##  3rd Qu.: 0.5745                            
    ##  Max.   : 0.5745                            
    ##  NA's   :1                                  
    ##  B - 1. Concept 1 of 6: Principles of Business Intelligence and the DataOps Philosophy
    ##  Min.   :-2.3393                                                                      
    ##  1st Qu.:-0.2934                                                                      
    ##  Median :-0.2934                                                                      
    ##  Mean   : 0.1933                                                                      
    ##  3rd Qu.: 1.2002                                                                      
    ##  Max.   : 1.2002                                                                      
    ##  NA's   :1                                                                            
    ##  B - 2. Concept 3 of 6: Linear Algorithms for Predictive Analytics
    ##  Min.   :-1.86873                                                 
    ##  1st Qu.:-0.97651                                                 
    ##  Median : 0.07021                                                 
    ##  Mean   : 0.09478                                                 
    ##  3rd Qu.: 1.39159                                                 
    ##  Max.   : 1.39159                                                 
    ##  NA's   :1                                                        
    ##  C - 2. Quizzes at the end of each concept
    ##  Min.   :-0.9942                          
    ##  1st Qu.:-0.5379                          
    ##  Median : 1.0761                          
    ##  Mean   : 0.4940                          
    ##  3rd Qu.: 1.0761                          
    ##  Max.   : 1.0761                          
    ##  NA's   :1                                
    ##  C - 3. Lab manuals that outline the steps to follow during the labs
    ##  Min.   :-0.7952                                                    
    ##  1st Qu.:-0.5308                                                    
    ##  Median : 1.1017                                                    
    ##  Mean   : 0.5471                                                    
    ##  3rd Qu.: 1.1017                                                    
    ##  Max.   : 1.1017                                                    
    ##  NA's   :1                                                          
    ##  C - 4. Required lab work submissions at the end of each lab manual that outline the activity to be done on your own
    ##  Min.   :-1.0695                                                                                                    
    ##  1st Qu.:-0.5899                                                                                                    
    ##  Median : 1.1068                                                                                                    
    ##  Mean   : 0.4163                                                                                                    
    ##  3rd Qu.: 1.1068                                                                                                    
    ##  Max.   : 1.1068                                                                                                    
    ##  NA's   :1                                                                                                          
    ##  C - 5. Supplementary videos to watch
    ##  Min.   :-1.9132                     
    ##  1st Qu.:-0.2001                     
    ##  Median :-0.2001                     
    ##  Mean   : 0.2306                     
    ##  3rd Qu.: 1.1959                     
    ##  Max.   : 1.1959                     
    ##  NA's   :1                           
    ##  C - 6. Supplementary podcasts to listen to
    ##  Min.   :-1.69189                          
    ##  1st Qu.:-0.07833                          
    ##  Median :-0.07833                          
    ##  Mean   : 0.24205                          
    ##  3rd Qu.: 1.23147                          
    ##  Max.   : 1.23147                          
    ##  NA's   :1                                 
    ##  C - 7. Supplementary content to read C - 8. Lectures slides
    ##  Min.   :-1.6109                      Min.   :-3.5875       
    ##  1st Qu.:-0.1641                      1st Qu.:-0.8279       
    ##  Median :-0.1641                      Median : 0.5519       
    ##  Mean   : 0.2733                      Mean   : 0.0000       
    ##  3rd Qu.: 1.1696                      3rd Qu.: 0.5519       
    ##  Max.   : 1.1696                      Max.   : 0.5519       
    ##  NA's   :1                            NA's   :1             
    ##  C - 9. Lecture notes on some of the lecture slides
    ##  Min.   :-0.8621                                   
    ##  1st Qu.:-0.5024                                   
    ##  Median : 1.0708                                   
    ##  Mean   : 0.5352                                   
    ##  3rd Qu.: 1.0708                                   
    ##  Max.   : 1.0708                                   
    ##  NA's   :1                                         
    ##  C - 10. The quality of the lectures given (quality measured by the breadth (the full span of knowledge of a subject) and depth (the extent to which specific topics are focused upon, amplified, and explored) of learning - NOT quality measured by how fun/comical/lively the lectures are)
    ##  Min.   :-1.1435                                                                                                                                                                                                                                                                              
    ##  1st Qu.:-0.5276                                                                                                                                                                                                                                                                              
    ##  Median : 1.0827                                                                                                                                                                                                                                                                              
    ##  Mean   : 0.4400                                                                                                                                                                                                                                                                              
    ##  3rd Qu.: 1.0827                                                                                                                                                                                                                                                                              
    ##  Max.   : 1.0827                                                                                                                                                                                                                                                                              
    ##  NA's   :1                                                                                                                                                                                                                                                                                    
    ##  C - 11. The division of theory and practice such that most of the theory is done during the recorded online classes and most of the practice is done during the physical classes
    ##  Min.   :-1.2903                                                                                                                                                                 
    ##  1st Qu.:-0.5055                                                                                                                                                                 
    ##  Median : 1.0938                                                                                                                                                                 
    ##  Mean   : 0.3897                                                                                                                                                                 
    ##  3rd Qu.: 1.0938                                                                                                                                                                 
    ##  Max.   : 1.0938                                                                                                                                                                 
    ##  NA's   :1                                                                                                                                                                       
    ##  C - 12. The recordings of online classes
    ##  Min.   :-1.2524                         
    ##  1st Qu.:-0.3229                         
    ##  Median : 1.1224                         
    ##  Mean   : 0.3445                         
    ##  3rd Qu.: 1.1224                         
    ##  Max.   : 1.1224                         
    ##  NA's   :1                               
    ##  D - 1. Write two things you like about the teaching and learning in this unit so far.
    ##  Length:101                                                                           
    ##  Class :character                                                                     
    ##  Mode  :character                                                                     
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##                                                                                       
    ##  D - 2. Write at least one recommendation to improve the teaching and learning in this unit (for the remaining weeks in the semester)
    ##  Length:101                                                                                                                          
    ##  Class :character                                                                                                                    
    ##  Mode  :character                                                                                                                    
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##                                                                                                                                      
    ##  Average Course Evaluation Rating Average Level of Learning Attained Rating
    ##  Min.   :-2.37483                 Min.   :-2.39745                         
    ##  1st Qu.:-0.55732                 1st Qu.:-0.77321                         
    ##  Median : 0.03681                 Median :-0.13234                         
    ##  Mean   : 0.18276                 Mean   : 0.09053                         
    ##  3rd Qu.: 1.16562                 3rd Qu.: 0.61137                         
    ##  Max.   : 1.50436                 Max.   : 1.44985                         
    ##  NA's   :1                        NA's   :1                                
    ##  Average Pedagogical Strategy Effectiveness Rating
    ##  Min.   :-1.6052                                  
    ##  1st Qu.:-0.6033                                  
    ##  Median : 0.2399                                  
    ##  Mean   : 0.2096                                  
    ##  3rd Qu.: 1.1900                                  
    ##  Max.   : 1.4670                                  
    ##  NA's   :1                                        
    ##  Project: Section 1-4: (20%) x/10 Project: Section 5-11: (50%) x/10
    ##  Min.   :-1.2808                  Min.   :-1.1123                  
    ##  1st Qu.:-0.2466                  1st Qu.:-0.1870                  
    ##  Median : 0.2678                  Median : 0.5478                  
    ##  Mean   : 0.3038                  Mean   : 0.3425                  
    ##  3rd Qu.: 0.6167                  3rd Qu.: 0.8386                  
    ##  Max.   : 1.5568                  Max.   : 2.1253                  
    ##                                                                    
    ##  Project: Section 12: (30%) x/5 Project: (10%): x/30 x 100 TOTAL
    ##  Min.   :-1.0993                Min.   :-1.8850                 
    ##  1st Qu.:-1.0993                1st Qu.:-0.2910                 
    ##  Median :-1.0993                Median : 0.2106                 
    ##  Mean   :-0.6697                Mean   : 0.1856                 
    ##  3rd Qu.: 0.0738                3rd Qu.: 0.5169                 
    ##  Max.   : 0.5481                Max.   : 2.7564                 
    ##  NA's   :1                                                      
    ##  Quiz 1 on Concept 1 (Introduction) x/32 Quiz 3 on Concept 3 (Linear) x/15
    ##  Min.   :-2.4418                         Min.   :-2.2502                  
    ##  1st Qu.:-0.8681                         1st Qu.:-0.8421                  
    ##  Median :-0.1640                         Median :-0.1722                  
    ##  Mean   :-0.1708                         Mean   :-0.0357                  
    ##  3rd Qu.: 0.4514                         3rd Qu.: 0.7703                  
    ##  Max.   : 1.6197                         Max.   : 1.6608                  
    ##                                          NA's   :2                        
    ##  Quiz 4 on Concept 4 (Non-Linear) x/22 Quiz 5 on Concept 5 (Dashboarding) x/10
    ##  Min.   :-2.434354                     Min.   :-2.91084                       
    ##  1st Qu.:-0.678094                     1st Qu.:-0.64269                       
    ##  Median :-0.098221                     Median :-0.01781                       
    ##  Mean   : 0.006457                     Mean   : 0.01651                       
    ##  3rd Qu.: 0.808973                     3rd Qu.: 0.78917                       
    ##  Max.   : 1.839714                     Max.   : 3.12584                       
    ##  NA's   :6                             NA's   :12                             
    ##  Quizzes and  Bonus Marks (7%): x/79 x 100 TOTAL
    ##  Min.   :-2.14298                               
    ##  1st Qu.:-0.81685                               
    ##  Median :-0.05553                               
    ##  Mean   :-0.09385                               
    ##  3rd Qu.: 0.50964                               
    ##  Max.   : 1.95555                               
    ##                                                 
    ##  Lab 1 - 2.c. - (Simple Linear Regression) x/5
    ##  Min.   :-4.8297                              
    ##  1st Qu.: 0.2597                              
    ##  Median : 0.2597                              
    ##  Mean   : 0.0000                              
    ##  3rd Qu.: 0.2597                              
    ##  Max.   : 0.2597                              
    ##  NA's   :3                                    
    ##  Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5
    ##  Min.   :-0.9938                                               
    ##  1st Qu.:-0.6484                                               
    ##  Median : 0.9213                                               
    ##  Mean   : 0.3904                                               
    ##  3rd Qu.: 1.1954                                               
    ##  Max.   : 1.1954                                               
    ##  NA's   :6                                                     
    ##  Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5
    ##  Min.   :-2.7794                                                
    ##  1st Qu.: 0.3431                                                
    ##  Median : 0.3431                                                
    ##  Mean   : 0.0000                                                
    ##  3rd Qu.: 0.3431                                                
    ##  Max.   : 0.5773                                                
    ##  NA's   :9                                                      
    ##  Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5
    ##  Min.   :-2.8586                                  
    ##  1st Qu.:-0.3605                                  
    ##  Median : 0.4722                                  
    ##  Mean   : 0.0000                                  
    ##  3rd Qu.: 0.6387                                  
    ##  Max.   : 0.6387                                  
    ##  NA's   :18                                       
    ##  Lab 5 - Chart JS Dashboard Setup x/5 Lab Work (7%) x/25 x 100
    ##  Min.   :-0.6467                      Min.   :-1.70773        
    ##  1st Qu.:-0.6467                      1st Qu.:-0.39710        
    ##  Median : 1.1724                      Median : 0.01479        
    ##  Mean   : 0.5864                      Mean   : 0.24373        
    ##  3rd Qu.: 1.1724                      3rd Qu.: 1.20235        
    ##  Max.   : 1.1724                      Max.   : 1.44698        
    ##                                                               
    ##  CAT 1 (8%): x/38 x 100 CAT 2 (8%): x/100 x 100
    ##  Min.   :-2.13568       Min.   :-1.93378       
    ##  1st Qu.:-0.64256       1st Qu.:-0.42046       
    ##  Median : 0.02230       Median : 0.05621       
    ##  Mean   : 0.06024       Mean   : 0.12024       
    ##  3rd Qu.: 0.94737       3rd Qu.: 0.89413       
    ##  Max.   : 2.05263       Max.   : 1.86925       
    ##  NA's   :4              NA's   :31             
    ##  Attendance Waiver Granted: 1 = Yes, 0 = No Absenteeism Percentage
    ##  Min.   :-0.2271                            Min.   :-2.01500      
    ##  1st Qu.:-0.2271                            1st Qu.:-0.97700      
    ##  Median :-0.2271                            Median :-0.06727      
    ##  Mean   : 0.0000                            Mean   :-0.09993      
    ##  3rd Qu.:-0.2271                            3rd Qu.: 0.68536      
    ##  Max.   : 4.3600                            Max.   : 3.00415      
    ##                                                                   
    ##  Coursework TOTAL: x/40 (40%) EXAM: x/60 (60%)   
    ##  Min.   :-2.21224             Min.   :-2.394610  
    ##  1st Qu.:-0.60962             1st Qu.:-0.686386  
    ##  Median : 0.00868             Median : 0.005496  
    ##  Mean   : 0.09551             Mean   : 0.032796  
    ##  3rd Qu.: 0.83801             3rd Qu.: 0.736025  
    ##  Max.   : 1.99130             Max.   : 2.080373  
    ##                               NA's   :4          
    ##  TOTAL = Coursework TOTAL + EXAM (100%)    GRADE          
    ##  Min.   :-2.57529                       Length:101        
    ##  1st Qu.:-0.68604                       Class :character  
    ##  Median : 0.10099                       Mode  :character  
    ##  Mean   : 0.08164                                         
    ##  3rd Qu.: 0.80099                                         
    ##  Max.   : 2.26892                                         
    ## 

``` r
# Calculate the skewness after the Yeo-Johnson transform
sapply(student_dataset_yeo_johnson_transform[, 4],  skewness, type = 2)
```

    ## regret_choosing_bi 
    ##            6.99785

``` r
sapply(student_dataset_yeo_johnson_transform[, 4], sd)
```

    ## regret_choosing_bi 
    ##                  1

## STEP 9.a. PCA Linear Algebra Transform for Dimensionality Reduction —-
