# Course Project README
Coursera, Getting and Cleaning Data, Course Project

###Table of contents:
- Objective
- Files
- Analysis Script: run_analysis.R
- Other Notes

## Objective
The main objective is to create a single, tidy set of data which summarizes the average 
of mean and standard deviation measurements from the data provided
at this link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Files
The following files are included in this project:
- README.md
- CodeBook.md
- run_analysis.R
- tidy.txt

## Analysis Script: run_analysis.R
The run_analysis.R script takes the raw data and creates a single tidy data set,
containing the average measurement value for each subject and each activity. Before running
the script, the following files should be placed in the same working directory:

**Measurement data:**
+ X_train.txt
+ y_train.txt
+ X_test.txt
+ y_test.txt

**Variable names:**
+ features.txt

**Subject ID's:**
+ subject_test.txt
+ subject_train.txt

Assuming that these files have been placed in the same working directory, the script does the following:

1. Load the necessary libraries: data.table, tidyr, dplyr

2. Read the appropriate files (listed above), and convert using the tbl_df() function
to use dplyr package.

3. Combine testing and training data using bind_rows(). 
This results in three sets of data: measurements (x), activity (y), and subject id (subid)

4. Unused data is removed from the environment using rm().

5. Renames columns of each data set using appropriate labels. The measurement data is labelled
using the names found in the features.txt file.

6. Only keep measurements that contain "mean()" or "std()" (mean and standard deviation values)

7. Measurement variable names are cleaned up, using make.names(). This results in "." appearing
in the names, which are then removed. Names containing  "Acc" and "Mag" are changed to "accel"
and "magnitude" respectively, as an effort to make them more descriptive and meaningful.

8. A function "actid" is defined, which replaces the activity id with the appropriate activity label.

9. This function is applied to the activity data (y) to replace the id with the activity label.

10. The all of the data is combined into a single data frame (df) using bind_cols(). First, the measurement and activity data 
(x and y) is combined, then the subject id (subid) data is added.

11. The data is grouped by subject id and activity, and the average measurement is calculated
for each group, stored in a new data frame called "means"

12. The final data set is written to file (tidy.txt). This is the final tidy data set submitted
for evaluation.

## Other Notes
Detailed description of the data and transformations can be found in the Code Book.