# run_analysis.R

# Downloads the Human Activity Recognition Using Smartphones data set, 
# does some clean up and produces a tidy data set.
#
# see README.md

library("reshape2")

#if file doesn't exist locally, download and unzip

zipname = "getdata-projectfiles-UCI HAR Dataset.zip"
if (!file.exists(zipname)) 
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                      destfile = zipname)

if (!file.exists("UCI HAR Dataset"))
        unzip("getdata-projectfiles-UCI HAR Dataset.zip")


# Read all the relevant files as tables

xTest <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt", sep = "")
yTest <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt", sep = "")
subjectTest <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", sep = "")

subjectTrain <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", sep = "")
xTrain <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt", sep = "")
yTrain <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt", sep = "")

features <- read.table(".\\UCI HAR Dataset\\features.txt", sep = "")
activityLabels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt", sep = "")

# Merge train and tests data sets

totalx <- rbind(xTest, xTrain)
totaly <- rbind(yTest, yTrain)
totals <- rbind(subjectTest, subjectTrain)

# Appropriately labels the data set with descriptive variable names
# by applying each features as the column names

colnames(totalx) <- features[,2]

# Extracts only the measurements on the mean and standard deviation for each measurement.

# get indexes for mean and standard deviation from features, 
# then do a subset selecting only matching columns

meanIndexes <- grep("-mean()", features[,2], fixed=TRUE)
stdIndexes <- grep("-std()", features[,2], fixed=TRUE)

data <- totalx[, c(meanIndexes, stdIndexes)]

# Uses descriptive activity names to name the activities in the data set

# activity text matched with y test/train by their activity number  

data["Activity"] <- activityLabels[ , 2][match(totaly[, 1], activityLabels[ , 1])]
data["Subject"] <- totals

# Create an independent tidy data set with the average of each variable for each activity and each subject.

variables <- colnames(data)[!colnames(data) %in% c("Activity", "Subject")]

melted <- melt(data, id=c("Activity", "Subject"), measure.vars = variables )
tidy <- dcast(melted, Subject + Activity ~ variable, mean)

# write tidy data set

write.table(tidy, file = "tidy.txt", row.names = FALSE)
