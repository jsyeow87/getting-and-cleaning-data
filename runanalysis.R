#To read activity_labels and features txt files
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

#To get only mean and SD for each measurement (part 1 of 3)
mean_and_SD_only <- grepl("mean|std", features)

#To load and process Test data files under Test subfolder
x_test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test_data <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_data <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#To fill in names for x_test_data
names(x_test_data) <- features

#To get only mean and SD for each measurement (part 2 of 3)
x_test_data <- x_test_data[,mean_and_SD_only]

#To get activity labels
y_test_data[,2] <- activity_labels[y_test_data[,1]]
names(y_test_data) <- c("Activity_ID", "Activity_Label")
names(subject_data) <- "subject"

##To load 'data table' package for data.table functions
library(data.table)

#To column bind X and Y test data
combined_test_data <- cbind(as.data.table(subject_data), y_test_data, x_test_data)

#To load and process Train data files under Train subfolder
x_train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train_data <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train_data <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(x_train_data) <- features

# To get only mean and SD for each measurement (part 3 of 3)
x_train_data <- x_train_data[,mean_and_SD_only]

# Load activity data
y_train_data[,2] <- activity_labels[y_train_data[,1]]
names(y_train_data) <- c("Activity_ID", "Activity_Label")
names(subject_train_data) <- "subject"

# Bind data
combined_train_data <- cbind(as.data.table(subject_train_data), y_train_data, x_train_data)

##To load 'reshape2' for melt and cast function
library(reshape2)

# Merge test and train data
end_data <- rbind(combined_test_data, combined_train_data)

id_labels   <- c("subject", "Activity_ID", "Activity_Label")
data_labels <- setdiff(colnames(end_data), id_labels)
melt_data      <- melt(end_data, id = id_labels, measure.vars = data_labels)

# To use dcast function to apply mean function onto 'end_data' 
tidy_data   <- dcast(melt_data, subject + Activity_Label ~ variable, mean)

# Tp create tidy_data txt file
write.table(tidy_data, file = "./tidy_data.txt")
