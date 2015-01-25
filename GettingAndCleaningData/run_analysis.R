# uncomment the line below and update to set working directories to something other than default
#setwd("C:\\Users\\matt\\Dropbox\\Coursera\\Getting and Cleaning Data\\Project")

# save original working directory
orig_wd <- getwd()

# set working directory of unzipped files
setwd("UCI HAR Dataset")

# load required libraries
library(dplyr)

# get column names for dataset
c_names <- read.csv("features.txt", sep="", header=FALSE)

# get activity names to join with final data set
a_names <- read.csv("activity_labels.txt", sep="", header=FALSE)
names(a_names) <- c("Activity","ActivityDesc")

# change directories to "test"
setwd("test")

# read data and assign column names
subject_test <- read.csv("subject_test.txt", header=FALSE)
names(subject_test) <- "Subject"
X_test <- read.csv("X_test.txt", sep="", header=FALSE)
names(X_test) <- c_names[,2]
y_test <- read.csv("y_test.txt", header=FALSE)
names(y_test) <- "Activity"

# combine all test data
test_data <- cbind(subject_test, y_test, X_test)

# change directories to "train"
setwd("..\\train")

# read data and assign column names
subject_train <- read.csv("subject_train.txt", header=FALSE)
names(subject_train) <- "Subject"
X_train <- read.csv("X_train.txt", sep="", header=FALSE)
names(X_train) <- c_names[,2]
y_train <- read.csv("y_train.txt", header=FALSE)
names(y_train) <- "Activity"

# done reading data, go back to original dir
setwd(orig_wd)

# combine all train data
train_data <- cbind(subject_train, y_train, X_train)

# combine all data
all_data <- rbind(test_data, train_data)

# remove duplicate and unneeded columns
all_data <- all_data[,c(1:304,347:383,426:462,505:563)]

# select mean and standard deviation columns and create final_data set
final_data <- select(all_data, 1:2, contains("-mean()"), contains("-std()"))

# join final_data with a_names (activity names) to update the activity numbers to descriptions
final_data <- merge(final_data, a_names, by.x = "Activity", by.y = "Activity", all.x = TRUE)

# re-order columns to have Subject, Activity, ActivityDesc as the first three columns
final_data <- select(final_data,2,1,69,3:68)

# replace Activity number with the ActivityDesc value
final_data <- select(mutate(final_data, "Activity" = ActivityDesc), 1:2, 4:69)

# now clean-up the column names
final_data_names <- names(final_data)
final_data_names <- gsub("-std\\(\\)","StdDev",final_data_names)
final_data_names <- gsub("-mean\\(\\)","Mean",final_data_names)
final_data_names <- gsub("-","",final_data_names)
final_data_names <- gsub("\\(\\)","",final_data_names)
final_data_names <- gsub("^t","Time",final_data_names)
final_data_names <- gsub("^f","Frequency",final_data_names)
final_data_names <- gsub("Gyro","Gyroscope",final_data_names)
final_data_names <- gsub("Acc","Acceleration",final_data_names)
final_data_names <- gsub("Mag","Magnitude",final_data_names)

# apply cleaned column names to final_data set
names(final_data) <- final_data_names

# now create a second independent tidy data set with the average of each variable for each activity and each subject.

# first group the data
grouped <- group_by(final_data, Subject, Activity)

# now calc means
second_data_set <- summarize(grouped, 
                             TimeBodyAccelerationMeanX = mean(TimeBodyAccelerationMeanX),
                             TimeBodyAccelerationMeanY = mean(TimeBodyAccelerationMeanY),
                             TimeBodyAccelerationMeanZ = mean(TimeBodyAccelerationMeanZ),
                             TimeGravityAccelerationMeanX = mean(TimeGravityAccelerationMeanX),
                             TimeGravityAccelerationMeanY = mean(TimeGravityAccelerationMeanY),
                             TimeGravityAccelerationMeanZ = mean(TimeGravityAccelerationMeanZ),
                             TimeBodyAccelerationJerkMeanX = mean(TimeBodyAccelerationJerkMeanX),
                             TimeBodyAccelerationJerkMeanY = mean(TimeBodyAccelerationJerkMeanY),
                             TimeBodyAccelerationJerkMeanZ = mean(TimeBodyAccelerationJerkMeanZ),
                             TimeBodyGyroscopeMeanX = mean(TimeBodyGyroscopeMeanX),
                             TimeBodyGyroscopeMeanY = mean(TimeBodyGyroscopeMeanY),
                             TimeBodyGyroscopeMeanZ = mean(TimeBodyGyroscopeMeanZ),
                             TimeBodyGyroscopeJerkMeanX = mean(TimeBodyGyroscopeJerkMeanX),
                             TimeBodyGyroscopeJerkMeanY = mean(TimeBodyGyroscopeJerkMeanY),
                             TimeBodyGyroscopeJerkMeanZ = mean(TimeBodyGyroscopeJerkMeanZ),
                             TimeBodyAccelerationMagnitudeMean = mean(TimeBodyAccelerationMagnitudeMean),
                             TimeGravityAccelerationMagnitudeMean = mean(TimeGravityAccelerationMagnitudeMean),
                             TimeBodyAccelerationJerkMagnitudeMean = mean(TimeBodyAccelerationJerkMagnitudeMean),
                             TimeBodyGyroscopeMagnitudeMean = mean(TimeBodyGyroscopeMagnitudeMean),
                             TimeBodyGyroscopeJerkMagnitudeMean = mean(TimeBodyGyroscopeJerkMagnitudeMean),
                             FrequencyBodyAccelerationMeanX = mean(FrequencyBodyAccelerationMeanX),
                             FrequencyBodyAccelerationMeanY = mean(FrequencyBodyAccelerationMeanY),
                             FrequencyBodyAccelerationMeanZ = mean(FrequencyBodyAccelerationMeanZ),
                             FrequencyBodyAccelerationJerkMeanX = mean(FrequencyBodyAccelerationJerkMeanX),
                             FrequencyBodyAccelerationJerkMeanY = mean(FrequencyBodyAccelerationJerkMeanY),
                             FrequencyBodyAccelerationJerkMeanZ = mean(FrequencyBodyAccelerationJerkMeanZ),
                             FrequencyBodyGyroscopeMeanX = mean(FrequencyBodyGyroscopeMeanX),
                             FrequencyBodyGyroscopeMeanY = mean(FrequencyBodyGyroscopeMeanY),
                             FrequencyBodyGyroscopeMeanZ = mean(FrequencyBodyGyroscopeMeanZ),
                             FrequencyBodyAccelerationMagnitudeMean = mean(FrequencyBodyAccelerationMagnitudeMean),
                             FrequencyBodyBodyAccelerationJerkMagnitudeMean = mean(FrequencyBodyBodyAccelerationJerkMagnitudeMean),
                             FrequencyBodyBodyGyroscopeMagnitudeMean = mean(FrequencyBodyBodyGyroscopeMagnitudeMean),
                             FrequencyBodyBodyGyroscopeJerkMagnitudeMean = mean(FrequencyBodyBodyGyroscopeJerkMagnitudeMean),
                             TimeBodyAccelerationStdDevX = mean(TimeBodyAccelerationStdDevX),
                             TimeBodyAccelerationStdDevY = mean(TimeBodyAccelerationStdDevY),
                             TimeBodyAccelerationStdDevZ = mean(TimeBodyAccelerationStdDevZ),
                             TimeGravityAccelerationStdDevX = mean(TimeGravityAccelerationStdDevX),
                             TimeGravityAccelerationStdDevY = mean(TimeGravityAccelerationStdDevY),
                             TimeGravityAccelerationStdDevZ = mean(TimeGravityAccelerationStdDevZ),
                             TimeBodyAccelerationJerkStdDevX = mean(TimeBodyAccelerationJerkStdDevX),
                             TimeBodyAccelerationJerkStdDevY = mean(TimeBodyAccelerationJerkStdDevY),
                             TimeBodyAccelerationJerkStdDevZ = mean(TimeBodyAccelerationJerkStdDevZ),
                             TimeBodyGyroscopeStdDevX = mean(TimeBodyGyroscopeStdDevX),
                             TimeBodyGyroscopeStdDevY = mean(TimeBodyGyroscopeStdDevY),
                             TimeBodyGyroscopeStdDevZ = mean(TimeBodyGyroscopeStdDevZ),
                             TimeBodyGyroscopeJerkStdDevX = mean(TimeBodyGyroscopeJerkStdDevX),
                             TimeBodyGyroscopeJerkStdDevY = mean(TimeBodyGyroscopeJerkStdDevY),
                             TimeBodyGyroscopeJerkStdDevZ = mean(TimeBodyGyroscopeJerkStdDevZ),
                             TimeBodyAccelerationMagnitudeStdDev = mean(TimeBodyAccelerationMagnitudeStdDev),
                             TimeGravityAccelerationMagnitudeStdDev = mean(TimeGravityAccelerationMagnitudeStdDev),
                             TimeBodyAccelerationJerkMagnitudeStdDev = mean(TimeBodyAccelerationJerkMagnitudeStdDev),
                             TimeBodyGyroscopeMagnitudeStdDev = mean(TimeBodyGyroscopeMagnitudeStdDev),
                             TimeBodyGyroscopeJerkMagnitudeStdDev = mean(TimeBodyGyroscopeJerkMagnitudeStdDev),
                             FrequencyBodyAccelerationStdDevX = mean(FrequencyBodyAccelerationStdDevX),
                             FrequencyBodyAccelerationStdDevY = mean(FrequencyBodyAccelerationStdDevY),
                             FrequencyBodyAccelerationStdDevZ = mean(FrequencyBodyAccelerationStdDevZ),
                             FrequencyBodyAccelerationJerkStdDevX = mean(FrequencyBodyAccelerationJerkStdDevX),
                             FrequencyBodyAccelerationJerkStdDevY = mean(FrequencyBodyAccelerationJerkStdDevY),
                             FrequencyBodyAccelerationJerkStdDevZ = mean(FrequencyBodyAccelerationJerkStdDevZ),
                             FrequencyBodyGyroscopeStdDevX = mean(FrequencyBodyGyroscopeStdDevX),
                             FrequencyBodyGyroscopeStdDevY = mean(FrequencyBodyGyroscopeStdDevY),
                             FrequencyBodyGyroscopeStdDevZ = mean(FrequencyBodyGyroscopeStdDevZ),
                             FrequencyBodyAccelerationMagnitudeStdDev = mean(FrequencyBodyAccelerationMagnitudeStdDev),
                             FrequencyBodyBodyAccelerationJerkMagnitudeStdDev = mean(FrequencyBodyBodyAccelerationJerkMagnitudeStdDev),
                             FrequencyBodyBodyGyroscopeMagnitudeStdDev = mean(FrequencyBodyBodyGyroscopeMagnitudeStdDev),
                             FrequencyBodyBodyGyroscopeJerkMagnitudeStdDev = mean(FrequencyBodyBodyGyroscopeJerkMagnitudeStdDev)
                            )

# write the first tidy data set to the current working directory
write.table(final_data, file = "tidy_data_set.txt", quote=FALSE, row.name=FALSE, sep = ",")

# write the second data set to the current working directory
write.table(second_data_set, file = "second_data_set.txt", quote=FALSE, row.name=FALSE, sep = ",")

# clean up unneeded objects, leave final_data and second_data_set data frames for the user
rm(c_names, subject_test, X_test, y_test, test_data, subject_train, X_train, y_train, train_data, final_data_names, grouped)