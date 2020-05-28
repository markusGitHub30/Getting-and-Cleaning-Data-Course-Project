# Getting-and-Cleaning-Data-Course-Project
Coursera: Gettin and Cleaning Data Course Project

Content of the repository:

Codebook - Describes content of the tidy data
run_analysis.R - R code for tidying the data
tidy_data.txt - Summerized tidy data after step 5 of the project

## run_analysis description:
The code contains of 4 sections, the numbers of the sections refers to the task specification of the prokect.

### 0)Import data
loads data from website, if not already existing in the workingdirectory

### 1)Merges the training and the test sets to create one data set
### involves 3+4 (descriptive activity names + appropriately labels)

Merging all data into one matrix using rbind,cbind and merge. 
Name the columns:
Acticity -> activities like Sitting, Going, ..
Volunteer_ID -> The identification number of the 30 volunteers

Just take the relevant columns (mean and std), adapt the names of variables

### 5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

Generate the independent tidy data set with the average of each variable for each activity and each subject
 and safe it



