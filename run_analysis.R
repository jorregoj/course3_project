library(reshape2)
library(dplyr)
#downloading the data and unzip
RawDataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(RawDataUrl,"./data.zip")
unzip("data.zip")
#reading the train data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
#reading the test data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
#bindind x,y and subject data from both train and test
x_data <- rbind(x_train,x_test)
y_data <- rbind(y_train,y_test)
subject_data <- rbind(subject_train,subject_test)
#reading the features
features <- read.table("UCI HAR Dataset/features.txt")
#reading the activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
#finding the index of mean and sd values
measurement <- grep("std|mean\\(\\)",features[,2])
#transforming x_data so thar, it only contains variables of mean and sd
x_data <- x_data[,measurement]
#binding subject,y and x data
total_Data <- cbind(subject_data,y_data,x_data)
#renaming the variables according to features data
names(total_Data) <- c("Subject","Activity",features[measurement,2])
#creating factor for the subject anda ctivity variables   
total_Data$Activity <- factor(total_Data$Activity,levels=activity_labels$V1,labels=activity_labels$V2)
total_Data$Subject <- as.factor(total_Data$Subject)
#generating tidy data
melted_data <- melt(total_Data,id=c("Subject","Activity"))
tidyData <- dcast(melted_data, Subject + Activity ~ variable, mean)
write.table(tidyData, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)
        