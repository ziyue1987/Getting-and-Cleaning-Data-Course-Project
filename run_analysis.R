library(reshape2)

#File paths we need
activity_name_file <- "./UCI HAR Dataset/activity_labels.txt"
feature_name_file <- "./UCI HAR Dataset/features.txt"
train_feature_file <- "./UCI HAR Dataset/train/X_train.txt"
train_activity_file <- "./UCI HAR Dataset/train/y_train.txt"
train_subject_file <- "./UCI HAR Dataset/train/subject_train.txt"
test_feature_file <- "./UCI HAR Dataset/test/X_test.txt"
test_activity_file <- "./UCI HAR Dataset/test/y_test.txt"
test_subject_file <- "./UCI HAR Dataset/test/subject_test.txt"

# read features' name from the file
read_feature_names <- function(feature_name_file) {
  raw_data <- read.csv(feature_name_file, header=FALSE, sep=" ")
  features <- as.character.factor(raw_data[,2])
  return(features)
}

# read dataset from the file and preprocess it to make it more tidy.
read_dataset <- function(file) {
  raw_data <- read.fwf(file, widths=rep(16, 561), sep="")

  return(raw_data)
}

# extract mean and std of measurements and name them with descriptive names
extract_features <- function(dataset, feature_names) {
  index <- grep("(mean\\(\\))|(std\\(\\))", feature_names)
  extracted <- dataset[,index]
  names(extracted) <- feature_names[index]
  
  return(extracted)
}

# read activities file and mapping the number to the readable name
# then append activities to dataset 
append_activities <- function(dataset, activity_file, activity_name_file) {
  raw_data <- read.csv(activity_file, header=FALSE, sep=" ")
  activity_name <- read.csv(activity_name_file, header=FALSE, sep=" ")
  
  dataset$activity <- activity_name$V2[raw_data$V1]
  return(dataset)
}

#append subject to the dataset
append_subjects <- function(dataset, subject_file) {
  raw_data <- read.csv(subject_file, header=FALSE, sep=" ")
  dataset$subject <- raw_data$V1
  return(dataset)
}

feature_names <- read_feature_names(feature_name_file)

#generate train tidy dataset
train_dataset <- read_dataset(train_feature_file)
train_dataset <- extract_features(train_dataset, feature_names)
train_dataset <- append_subjects(train_dataset, train_subject_file)
train_dataset <- append_activities(train_dataset, train_activity_file, activity_name_file)

#generate test tidy dataset
test_dataset <- read_dataset(test_feature_file)
test_dataset <- extract_features(test_dataset, feature_names)
test_dataset <- append_subjects(test_dataset, test_subject_file)
test_dataset <- append_activities(test_dataset, test_activity_file, activity_name_file)

#Merges the training and the test sets
dataset <- rbind(train_dataset, test_dataset)

#output the tidy data
write.csv(dataset, file="./tidy_data.txt")

#Creates a second, independent tidy data set
index <- grep("(mean\\(\\))|(std\\(\\))", feature_names)
melted <- melt(dataset, id=c("activity", "subject"), measure.vars=feature_names[index])
second_data <- dcast(melted, activity + subject ~ variable, mean)
write.csv(second_data, file="./second_tidy_data.txt")