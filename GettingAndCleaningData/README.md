# Coursera: Getting and Cleaning Data #
# Course Project README.md #

## The Data ##

The data for this project is provided by UCI Machine Learning Repository 
(website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  
The data for this project can be downloaded at the following link:
Data download: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Citation:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity 
Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International 
Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## Course Project Requirements ##

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Assumptions and steps of the run_analysis.R script:
1. User will unzip the zip file to the default/standard R working directory and will make no changes to the folders and files unzipped.

Steps taken to clean up the data (note that the run_analysis.R script contains detailed comments on each step for further reference):
1.  Save original working directory
2.  Change working directory to "UCI HAR Dataset" folder.
3.  Load required libraries
4.  Get column names for dataset from features.txt file
5.  Get activity names from activity_labels.txt file (and add appropriate column headers to data frame) to join with final data set
6.  Change directories to "test"
7.  Read data and assign column names to data frames
8.  Combine all test data
9.  Change directories to "train"
10. Read data and assign column names
11. Done reading data, go back to original dir
12. Combine all train data
13. Combine all data (test and train)
14. Remove duplicate and unneeded columns
15. Select mean and standard deviation columns and create final_data set
16. Join final_data with a_names (activity names) to update the activity numbers to descriptions
17. Re-order columns to have Subject, Activity, ActivityDesc as the first three columns
18. Replace Activity number with the ActivityDesc value
19. Clean-up the column names and set to descriptive variable names
20. Apply cleaned column names to final_data set
21. Create a second independent tidy data set with the average of each variable for each activity and each subject.
22. First group the data for the second independent tidy data set
23. Now calc means for the second independent tidy data set
24. Write the first tidy data set (final_data) to the current working directory as file: "tidy_data_set.txt"
25. Write the second data set (second_data_set) to the current working directory as file: "second_data_set.txt"
26. Clean up unneeded objects, leave final_data and second_data_set data frames in R environment for the user to work with.