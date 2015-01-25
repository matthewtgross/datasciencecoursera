# Coursera: Getting and Cleaning Data #
# Course Project README.md #

## The Data ##

The data for this project is provided by UCI Machine Learning Repository 
(website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  

The data for this project can be downloaded at the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Citation:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity 
Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International 
Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## Course Project Requirements ##

You should create one R script called run_analysis.R that does the following. 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Assumptions and steps of the run_analysis.R script:

User will unzip the zip file to the default/standard R working directory and will make no changes to the folders and files unzipped.  To run the script in R execute: source("run_analysis.R")

Steps taken to clean up the data (note that the run_analysis.R script contains detailed comments on each step for further reference):
* Save original working directory
* Change working directory to "UCI HAR Dataset" folder.
* Load required libraries
* Get column names for dataset from features.txt file
* Get activity names from activity_labels.txt file (and add appropriate column headers to data frame) to join with final data set
* Change directories to "test"
* Read data and assign column names to data frames
* Combine all test data
* Change directories to "train"
* Read data and assign column names
* Done reading data, go back to original dir
* Combine all train data
* Combine all data (test and train)
* Remove duplicate and unneeded columns
* Select mean and standard deviation columns and create final_data set
* Join final_data with a_names (activity names) to update the activity numbers to descriptions
* Re-order columns to have Subject, Activity, ActivityDesc as the first three columns
* Replace Activity number with the ActivityDesc value
* Clean-up the column names and set to descriptive variable names
* Apply cleaned column names to final_data set
* Create a second independent tidy data set with the average of each variable for each activity and each subject.
* First group the data for the second independent tidy data set
* Now calc means for the second independent tidy data set
* Write the first tidy data set (final_data) to the current working directory as file: "tidy_data_set.txt"
* Write the second data set (second_data_set) to the current working directory as file: "second_data_set.txt"
* Clean up unneeded objects, leave final_data and second_data_set data frames in R environment for the user to work with.
