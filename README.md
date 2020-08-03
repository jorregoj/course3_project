---
title: Getting and Cleaning Data Course Project
---
The included R script, run_analysis.R, conducts the following:

1. downloading the data and unzip
2. reading the train data and test data
3. Using rbind(), create one data for x,y and subject
4. read the features and activity labels
5. create a vector of index containing mean and sd variables
6. transforming x_data so that, it only contains variables of mean and sd
7. binding subject,y and x data
8. renaming the variables according to features data
9. creating factor for the subject anda ctivity variables 
10.generating tidy data