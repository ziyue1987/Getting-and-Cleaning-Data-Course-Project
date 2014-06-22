Getting-and-Cleaning-Data-Course-Project
========================================

## Run Book

###1,To run the script, Please make the following file paths in the script point to the right directories:

	activity_name_file <- "./UCI HAR Dataset/activity_labels.txt"
	feature_name_file <- "./UCI HAR Dataset/features.txt"
	train_feature_file <- "./UCI HAR Dataset/train/X_train.txt"
	train_activity_file <- "./UCI HAR Dataset/train/y_train.txt"
	train_subject_file <- "./UCI HAR Dataset/train/subject_train.txt"
	test_feature_file <- "./UCI HAR Dataset/test/X_test.txt"
	test_activity_file <- "./UCI HAR Dataset/test/y_test.txt"
	test_subject_file <- "./UCI HAR Dataset/test/subject_test.txt"


###2,Then, you can run the script to generate tidy data.

## How It Works

For generating the tidy data, I read X data set as fixed width format data first.
Then, according to the feature names, I grepped the mean and std variables I want.
At last, append the subjects and activities to the data set.
 
