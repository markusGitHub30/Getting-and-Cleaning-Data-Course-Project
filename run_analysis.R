
#Define some variabels for downloading the data
Url_rawData <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
Dir_rawData <- "./rawData"
url2 <- paste(Dir_rawData, "/", "rawData.zip", sep = "")
folder <- "./data"


## if data is not in working directory --> download data
if (!file.exists(Dir_rawData)) {
    dir.create(Dir_rawData)
    download.file(url = Url_rawData, destfile = url2)
}
if (!file.exists(folder)) {
    dir.create(folder)
    unzip(zipfile = url2, exdir = folder)
}

##loading all necessary files
activity_labels <- read.table(paste(sep = "", folder, "/UCI HAR Dataset/activity_labels.txt"))
features <- read.table(paste(sep = "", folder, "/UCI HAR Dataset/features.txt"))

subject_test <- read.table(paste(sep = "", folder, "/UCI HAR Dataset/test/subject_test.txt"))
X_test <- read.table(paste(sep = "", folder, "/UCI HAR Dataset/test/X_test.txt"))
Y_test <- read.table(paste(sep = "", folder, "/UCI HAR Dataset/test/Y_test.txt"))

subject_train <- read.table(paste(sep = "", folder, "/UCI HAR Dataset/train/subject_train.txt"))
X_train <- read.table(paste(sep = "", folder, "/UCI HAR Dataset/train/X_train.txt"))
Y_train <- read.table(paste(sep = "", folder, "/UCI HAR Dataset/train/Y_train.txt"))
##1)Merges the training and the test sets to create one data set
# involves 3+4 (descriptive activity names + appropriately labels)

#extract names of features
names <- features$V2
#name the colums (features) of X_test and x_train
colnames(X_test) <- names
colnames(X_train) <- names

#Merge activities with Y_test and Y_Train
Y_test <- merge(Y_test,activity_labels)
Y_train <- merge(Y_train,activity_labels)

# Combine data (X_test, X_Train) with activity (Y_test,Y_train)
X_test <- cbind(Y_test$V2,X_test)
X_train <- cbind(Y_train$V2,X_train)

#rename first (newly added) column "Activity"
colnames(X_test)[1] <- c("Activity")
colnames(X_train)[1] <- c("Activity")

# Combine data (X_test, X_Train) with subjects (subject_test,subject_train)
X_test <- cbind(subject_test,X_test)
X_train <- cbind(subject_train,X_train)
#rename first (newly added) column "Volunteer_ID"
colnames(X_test)[1] <- c("Volunteer_ID")
colnames(X_train)[1] <- c("Volunteer_ID")

##combine test and training sets
data <- rbind(X_test,X_train)

##2) Extracts only the measurements on the mean and standard deviation for each measurement.

#take all "not-measurement" data
part1 <- c(1,2)

#extract col names of data
col_names <- colnames(data)

#take all measurement data with the word mean in heading
part2 <- grep(".mean.",col_names)

##take all measurement data with the word std in heading
part3 <- grep(".std.",col_names)

#combine the three parts of cols
all_cols <- c(part1,part2,part3)

#subet data
data_tidy <- data[,all_cols]

#remove "[-()]" from colnames
namesOfCols <- names(data_tidy)
namesOfCols <- gsub("[-()]", "", namesOfCols)
colnames(data_tidy) <- namesOfCols


##5)From the data set in step 4, creates a second, independent tidy data set with the 
##average of each variable for each activity and each subject
library(reshape2)

#melt dataset and create a ney tidy dataset
data_melted <- melt(data_tidy, id = c("Volunteer_ID", "Activity"))

tidyData_new <- dcast(data_melted, Volunteer_ID + Activity ~ variable, mean)


