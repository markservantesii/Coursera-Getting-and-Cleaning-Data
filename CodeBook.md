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

+X_train.txt
+y_train.txt
+X_test.txt
+y_test.txt
+features.txt
+subject_test.txt
+subject_train.txt

These files are moved to the same working directory as the run_analysis.R script.
Each of these is then read in using read.table(... , as.is=TRUE).

The X data contain the measurement values, and the y data contain the activities performed during each measurement.
The features.txt file contains the variable names for each measurement, and the subject files contain the subject id's.

## Combining Test and Training Data

The training and test data sets are combined first using bind_rows(), leaving three sets of data:
+X data is stored in variable "x"
+y data is stored in variable "y"
+subject id's are stored in variable "subid"
+Measurement variable names are stored in variable "varnames"

## Cleaning the Data

First, the names for each set of data is updated. The variable names stored in "varnames" are used to rename the columns of x.
"y" contains a single column, and it is changed to "activity".
"subid" also has one column, and it is changed to "subid".

Next, we only keep columns of "x" that contain "mean()" or "std()" in the column name.

Once the unwanted variables are removed, the column names are cleaned up using make.names().
This produces "." in the variable names, so they are removed using gsub(). As an effort to make the names more descriptive, instances of "Acc" and "Mag" are changed to "accel" and "magnitude", respectively. Finally, the names are made entirely lowercase using tolower(). 

The "y" data is transformed using a user-defined function "actid". It replaces the activity id with the appropriate label as follows:

1-walking
2-walking upstairs
3-walking downstairs
4-sitting
5-standing
6-laying

Next, the "x" and "y" data is combined using bind_cols(). Then the "subid" data is added.

This dataset is then grouped by subject id and activity, and the average value for each variable is calculated according to these groups.

This results in the final tidy data set. It is written to file using write.table(..., row.names=FALSE)

## Final Data
The final data set contains 180 rows and 81 columns.
Each value in the final data table represents an average value for each measurement for a given subject and activity.

**Column names:**
The column names of the final data set are as follows:

 [1] "subid"                              
 [2] "tbodyaccelmeanx"                    
 [3] "tbodyaccelmeany"                    
 [4] "tbodyaccelmeanz"                    
 [5] "tbodyaccelstdx"                     
 [6] "tbodyaccelstdy"                     
 [7] "tbodyaccelstdz"                     
 [8] "tgravityaccelmeanx"                 
 [9] "tgravityaccelmeany"                 
[10] "tgravityaccelmeanz"                 
[11] "tgravityaccelstdx"                  
[12] "tgravityaccelstdy"                  
[13] "tgravityaccelstdz"                  
[14] "tbodyacceljerkmeanx"                
[15] "tbodyacceljerkmeany"                
[16] "tbodyacceljerkmeanz"                
[17] "tbodyacceljerkstdx"                 
[18] "tbodyacceljerkstdy"                 
[19] "tbodyacceljerkstdz"                 
[20] "tbodygyromeanx"                     
[21] "tbodygyromeany"                     
[22] "tbodygyromeanz"                     
[23] "tbodygyrostdx"                      
[24] "tbodygyrostdy"                      
[25] "tbodygyrostdz"                      
[26] "tbodygyrojerkmeanx"                 
[27] "tbodygyrojerkmeany"                 
[28] "tbodygyrojerkmeanz"                 
[29] "tbodygyrojerkstdx"                  
[30] "tbodygyrojerkstdy"                  
[31] "tbodygyrojerkstdz"                  
[32] "tbodyaccelmagnitudemean"            
[33] "tbodyaccelmagnitudestd"             
[34] "tgravityaccelmagnitudemean"         
[35] "tgravityaccelmagnitudestd"          
[36] "tbodyacceljerkmagnitudemean"        
[37] "tbodyacceljerkmagnitudestd"         
[38] "tbodygyromagnitudemean"             
[39] "tbodygyromagnitudestd"              
[40] "tbodygyrojerkmagnitudemean"         
[41] "tbodygyrojerkmagnitudestd"          
[42] "fbodyaccelmeanx"                    
[43] "fbodyaccelmeany"                    
[44] "fbodyaccelmeanz"                    
[45] "fbodyaccelstdx"                     
[46] "fbodyaccelstdy"                     
[47] "fbodyaccelstdz"                     
[48] "fbodyaccelmeanfreqx"                
[49] "fbodyaccelmeanfreqy"                
[50] "fbodyaccelmeanfreqz"                
[51] "fbodyacceljerkmeanx"                
[52] "fbodyacceljerkmeany"                
[53] "fbodyacceljerkmeanz"                
[54] "fbodyacceljerkstdx"                 
[55] "fbodyacceljerkstdy"                 
[56] "fbodyacceljerkstdz"                 
[57] "fbodyacceljerkmeanfreqx"            
[58] "fbodyacceljerkmeanfreqy"            
[59] "fbodyacceljerkmeanfreqz"            
[60] "fbodygyromeanx"                     
[61] "fbodygyromeany"                     
[62] "fbodygyromeanz"                     
[63] "fbodygyrostdx"                      
[64] "fbodygyrostdy"                      
[65] "fbodygyrostdz"                      
[66] "fbodygyromeanfreqx"                 
[67] "fbodygyromeanfreqy"                 
[68] "fbodygyromeanfreqz"                 
[69] "fbodyaccelmagnitudemean"            
[70] "fbodyaccelmagnitudestd"             
[71] "fbodyaccelmagnitudemeanfreq"        
[72] "fbodybodyacceljerkmagnitudemean"    
[73] "fbodybodyacceljerkmagnitudestd"     
[74] "fbodybodyacceljerkmagnitudemeanfreq"
[75] "fbodybodygyromagnitudemean"         
[76] "fbodybodygyromagnitudestd"          
[77] "fbodybodygyromagnitudemeanfreq"     
[78] "fbodybodygyrojerkmagnitudemean"     
[79] "fbodybodygyrojerkmagnitudestd"      
[80] "fbodybodygyrojerkmagnitudemeanfreq" 
[81] "activity"  

These are not necessarily easier to read, but they are "acceptable" according to the course lectures.
"subid" and "activity" are the subject id and activity performed, respectively. The other variable descriptions
can be found in the features_info.txt file included in the original data. The only difference is that each measurement has been averaged for each subject and activity.




