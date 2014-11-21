# Getting and Cleaning Data - Course Project - Readme

## Instructions

Clone this repository locally and execute with R the run\_analysis.R script at the root of the cloned directory :

```
source("run_analysis.R")
```

The scripts downloads the data set, does some clean up and produced a tidy data set, `tidy.txt`, in the working directory.

## Data

This scripts uses the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) that is located at:

[UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


## Script

1. Downloads and unzips, unless the files exists locally (to speed run re-runs)

2. Reads all the the relevant data into tables

3. Merges the training and the test sets to create one data set.

4. Labels the data set by use the names in features to name each column 

5. Extracts only the measurements on the mean and standard deviation for each measurement. This was done by selecting column names that contains -mean() and -std().

6. Adds a column "Activity"" from the combined y data set (test/train) and replaced the activity numbers by the label in activity_labels (by matching the numbers).

7. Adds a column "Subject" from the combined subject data set (test train). 

8. Melts the data set by Activity and Subject (using reshape2 library). 

9. Creates a second, tidy data set which contains the average of each variable for each activity and subject

10. Writes the resulting tidy data set to file tidy.txt
