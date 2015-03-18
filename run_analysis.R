#------------------------------
# Getting and Cleaning Data
# Course Project
# run_analysis.R
#-------------------------------



library(data.table)
library(tidyr)
library(dplyr)

#-------------------------------
#
#   Reading the Data files
#
#--------------------------------


## Read data from file
xtrain<- tbl_df(read.table("X_train.txt", as.is=TRUE))
ytrain<- tbl_df(read.table("y_train.txt", as.is=TRUE))
xtest<- tbl_df(read.table("X_test.txt", as.is=TRUE))
ytest<- tbl_df(read.table("y_test.txt", as.is=TRUE))

## Read in data variable names
varnames<- tbl_df(read.table('features.txt', as.is=TRUE))

##Read in subject id's
subtest<- tbl_df(read.table("subject_test.txt", as.is=TRUE))
subtrain<- tbl_df(read.table("subject_train.txt", as.is=TRUE))

#------------------------------------
#
#   Cleaning the data
#
#-------------------------------------

## Combine the subject id's, combine x test/train data, combine y test/train data

subid<- bind_rows(subtest,subtrain)
x<- bind_rows(xtest,xtrain)
y<- bind_rows(ytest,ytrain)

## Remove unused variables from environment
rm("xtrain","ytrain","xtest","ytest","subtest","subtrain")

## Rename the column names of x data
varnames<- rename(varnames, names = V2) %>% select(names)
colnames(x)<- varnames$names
colnames(y)<- "activity"
colnames(subid)<- "subid"

## Only keep variables containing mean or standard deviation data
x<- x[,grepl("mean()|std()",colnames(x))]

##Clean up variable names
colnames(x)<- make.names(colnames(x))
colnames(x)<- gsub("\\.","",colnames(x))
colnames(x)<- gsub("Acc","accel",colnames(x))
colnames(x)<- gsub("Mag","magnitude",colnames(x))
colnames(x)<- tolower(colnames(x))




## Function to replace activity id with its appropriate label
actid<- function(activity = integer()){
      if(activity == 1){
            return("walking")}
      else if(activity ==2){
            return("walkingupstairs")}
      else if(activity ==3){
            return("walkingdownstairs")}
      else if(activity ==4){
            return("sitting")}
      else if(activity ==5){
            return("standing")
      }else if(activity ==6){
            return("laying")
}}

## Use the "actid" function (defined above) to replace activity id
## with its appropriate name
y$activity<- sapply(y$activity,actid)

## Combine x and y tables and convert to be used with dplyr package
df<- tbl_df(bind_cols(x,y))
df<- tbl_df(bind_cols(subid,df))

## Group the data by subject id, then activity, and calculate
## the mean for each variable according to this grouping
means<-group_by(df,subid,activity) %>% summarise_each(funs(mean))


## Write the tidy dataset to file:
write.table(means,"tidy.txt", row.names=FALSE)

