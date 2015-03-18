# Course Project Code Book
Coursera, Getting and Cleaning Data, Course Project

This code book describes the data, variables and transformations used to create a single tidy data set.

**Table of Contents:**
+Raw Data
+Libraries
+Reading the Data
+Combining Test and Training Data
+Cleaning the Data
+Final Data

## Raw Data

The raw data is obtained at the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data contain accelerometer and gyroscope measurements of 30 individuals performing
six different activities: Sitting, standing, walking, laying, walking up stairs, 
and walking downstairs. For a more complete description of the raw data, please see the features_info.txt file included
in the raw data.

## Libraries
The data.table, dplyr, and tidyr libraries are used for reading, manipulating and tidying the raw data.

## Reading the data
The data, as given, is spread across several files. We are only interested in the following
files:

+ X_train.txt
+ y_train.txt
+ X_test.txt
+ y_test.txt
+ features.txt
+ subject_test.txt
+ subject_train.txt

These files are moved to the same working directory as the run_analysis.R script.
Each of these is then read in using read.table(... , as.is=TRUE).

The X data contain the measurement values, and the y data contain the activities performed during each measurement.
The features.txt file contains the variable names for each measurement, and the subject files contain the subject id's.

## Combining Test and Training Data

The training and test data sets are combined first using bind_rows(), leaving three sets of data:
+ X data is stored in variable "x"
+ y data is stored in variable "y"
+ subject id's are stored in variable "subid"
+ Measurement variable names are stored in variable "varnames"

## Cleaning the Data

First, the names for each set of data is updated. The variable names stored in "varnames" are used to rename the columns of x.
"y" contains a single column, and it is changed to "activity".
"subid" also has one column, and it is changed to "subid".

Next, we only keep columns of "x" that contain "mean()" or "std()" in the column name.

Once the unwanted variables are removed, the column names are cleaned up using make.names().
This produces "." in the variable names, so they are removed using gsub(). As an effort to make the names more descriptive, instances of "Acc" and "Mag" are changed to "accel" and "magnitude", respectively. Finally, the names are made entirely lowercase using tolower(). 

The "y" data is transformed using a user-defined function "actid". It replaces the activity id with the appropriate label as follows:

- 1-walking
- 2-walking upstairs
- 3-walking downstairs
- 4-sitting
- 5-standing
- 6-laying

Next, the "x" and "y" data is combined using bind_cols(). Then the "subid" data is added.

This dataset is then grouped by subject id and activity, and the average value for each variable is calculated according to these groups.

This results in the final tidy data set. It is written to file using write.table(..., row.names=FALSE)

## Final Data
The final data set contains 180 rows and 81 columns.
Each value in the final data table represents an average value for each measurement for a given subject and activity.

**Column names:**
The column names of the final data set are as follows:

 [1] "subid"                              
 [2] "activity"                           
 [3] "tbodyaccelmeanx"                    
 [4] "tbodyaccelmeany"                    
 [5] "tbodyaccelmeanz"                    
 [6] "tbodyaccelstdx"                     
 [7] "tbodyaccelstdy"                     
 [8] "tbodyaccelstdz"                     
 [9] "tgravityaccelmeanx"                 
[10] "tgravityaccelmeany"                 
[11] "tgravityaccelmeanz"                 
[12] "tgravityaccelstdx"                  
[13] "tgravityaccelstdy"                  
[14] "tgravityaccelstdz"                  
[15] "tbodyacceljerkmeanx"                
[16] "tbodyacceljerkmeany"                
[17] "tbodyacceljerkmeanz"                
[18] "tbodyacceljerkstdx"                 
[19] "tbodyacceljerkstdy"                 
[20] "tbodyacceljerkstdz"                 
[21] "tbodygyromeanx"                     
[22] "tbodygyromeany"                     
[23] "tbodygyromeanz"                     
[24] "tbodygyrostdx"                      
[25] "tbodygyrostdy"                      
[26] "tbodygyrostdz"                      
[27] "tbodygyrojerkmeanx"                 
[28] "tbodygyrojerkmeany"                 
[29] "tbodygyrojerkmeanz"                 
[30] "tbodygyrojerkstdx"                  
[31] "tbodygyrojerkstdy"                  
[32] "tbodygyrojerkstdz"                  
[33] "tbodyaccelmagnitudemean"            
[34] "tbodyaccelmagnitudestd"             
[35] "tgravityaccelmagnitudemean"         
[36] "tgravityaccelmagnitudestd"          
[37] "tbodyacceljerkmagnitudemean"        
[38] "tbodyacceljerkmagnitudestd"         
[39] "tbodygyromagnitudemean"             
[40] "tbodygyromagnitudestd"              
[41] "tbodygyrojerkmagnitudemean"         
[42] "tbodygyrojerkmagnitudestd"          
[43] "fbodyaccelmeanx"                    
[44] "fbodyaccelmeany"                    
[45] "fbodyaccelmeanz"                    
[46] "fbodyaccelstdx"                     
[47] "fbodyaccelstdy"                     
[48] "fbodyaccelstdz"                     
[49] "fbodyaccelmeanfreqx"                
[50] "fbodyaccelmeanfreqy"                
[51] "fbodyaccelmeanfreqz"                
[52] "fbodyacceljerkmeanx"                
[53] "fbodyacceljerkmeany"                
[54] "fbodyacceljerkmeanz"                
[55] "fbodyacceljerkstdx"                 
[56] "fbodyacceljerkstdy"                 
[57] "fbodyacceljerkstdz"                 
[58] "fbodyacceljerkmeanfreqx"            
[59] "fbodyacceljerkmeanfreqy"            
[60] "fbodyacceljerkmeanfreqz"            
[61] "fbodygyromeanx"                     
[62] "fbodygyromeany"                     
[63] "fbodygyromeanz"                     
[64] "fbodygyrostdx"                      
[65] "fbodygyrostdy"                      
[66] "fbodygyrostdz"                      
[67] "fbodygyromeanfreqx"                 
[68] "fbodygyromeanfreqy"                 
[69] "fbodygyromeanfreqz"                 
[70] "fbodyaccelmagnitudemean"            
[71] "fbodyaccelmagnitudestd"             
[72] "fbodyaccelmagnitudemeanfreq"        
[73] "fbodybodyacceljerkmagnitudemean"    
[74] "fbodybodyacceljerkmagnitudestd"     
[75] "fbodybodyacceljerkmagnitudemeanfreq"
[76] "fbodybodygyromagnitudemean"         
[77] "fbodybodygyromagnitudestd"          
[78] "fbodybodygyromagnitudemeanfreq"     
[79] "fbodybodygyrojerkmagnitudemean"     
[80] "fbodybodygyrojerkmagnitudestd"      
[81] "fbodybodygyrojerkmagnitudemeanfreq" 

These are not necessarily easier to read, but they are "acceptable" according to the course lectures.
"subid" and "activity" are the subject id and activity performed, respectively. The other variable descriptions
can be found in the features_info.txt file included in the original data. The only difference is that each measurement has been averaged for each subject and activity.




