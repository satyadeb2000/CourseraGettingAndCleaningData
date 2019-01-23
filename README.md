# Getting And Cleaning Data
## The repository contains the following files:
### RunAnalysis.R - This R script does the following:
1. Downloads the data from the url https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzips the files
3. Loads the activity labels from the file "UCI HAR Dataset/activity_labels.txt"
4. Loads the features from the file "UCI HAR Dataset/features.txt" and selects the column numbers which are either a mean or a standard deviation. 
5. Loads and merges the training dataset from the files. 
    * "UCI HAR Dataset/train/X_train.txt" - only those columns which are std deviations and means (uses the filters from step 4). 
    * "UCI HAR Dataset/train/Y_train.txt".   
    * "UCI HAR Dataset/train/subject_train.txt". 
6. Loads and merges the test dataset from the files. 
    * "UCI HAR Dataset/test/X_test.txt" - only those columns which are std deviations and means (uses the filters from step 4). 
    * "UCI HAR Dataset/test/Y_test.txt". 
    * "UCI HAR Dataset/test/subject_test.txt". 
7. Merges the training and test datasets from steps 5 and 6
8. Factorizes the activity and subject columns in the final data set
9. Extracts the mean of each column after grouping by activity and subject 
10. Writes the dataset from steps 9 into an external file. 


### Codebook.md - THis is a codebook for the tidydata.txt

### tidydata.txt - the cleaned up data set with the mean calculated for each column by subject and activity
