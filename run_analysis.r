library(dplyr)

destfilename <- "dataset.zip"

## Download and unzip the dataset:
if (!file.exists(destfilename)){
  sourceURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(sourceURL, destfilename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(destfilename) 
}

# Load activity labels + features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])


# Extract only the data on mean and standard deviation
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])

#fix column names
featurewantedText <- features[featuresWanted,2]
featurewantedText = gsub('-mean', 'Mean', featurewantedText)
featurewantedText = gsub('-std', 'Std', featurewantedText)
featurewantedText <- gsub('[-()]', '', featurewantedText)
featurewantedText <- gsub("BodyBody", "Body", featurewantedText)
featurewantedText <- gsub("^f", "frequencyDomain", featurewantedText)
featurewantedText <- gsub("^t", "timeDomain", featurewantedText)
featurewantedText <- gsub("Acc", "Accelerometer", featurewantedText)
featurewantedText <- gsub("Gyro", "Gyroscope", featurewantedText)
featurewantedText <- gsub("Mag", "Magnitude", featurewantedText)
featurewantedText <- gsub("Freq", "Frequency", featurewantedText)


# Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merge datasets and add labels
completeData <- rbind(train, test)
colnames(completeData) <- c("subject", "activity", featurewantedText)

# turn activities & subjects into factors
completeData$activity <- factor(completeData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
completeData$subject <- as.factor(completeData$subject)

# group by subject and activity and summarise using mean
completeDatamean <- completeData %>% 
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

#Write tidy data
write.table(completeDatamean, "tidydata.txt", row.names = FALSE, quote = FALSE)
