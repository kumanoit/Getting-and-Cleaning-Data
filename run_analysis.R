  
  ## data dir
  dataDir <- "./data"
  
  ## output file name where output data will be saved
  outputFileName = "./data/uci_har_dataset_output.txt"

  ## if above data dir doesn't exist then create it
  if (!file.exists(dataDir)) {
    message("creating data dir")
    dir.create(dataDir)
  }

  ## file link to UCR_HAR_Dataset
  dataFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  ## destfile location where above data will be saved
  zippedData <- "./data/uci_har_dataset.zip"
  
  ## if above file is already present then delete that file for a fresh analysis
  ## also delete directory where this zip file was extracted
  ## also delete output file
  if (file.exists(zippedData)) {
    message("deleting file ", zippedData)
    file.remove(zippedData)
    if (dir.exists("./data/UCI HAR Dataset/")) {
      message("deleting zipped output directory ", "UCI HAR Dataset")
      unlink("./data/UCI HAR Dataset/", recursive=TRUE)
    }
    if (file.exists(outputFileName)) {
      message("Deleting output file")
      file.remove(outputFileName)
    }
  }

  ## download file and save it in above file path
  message("downloading data")
  download.file(dataFileUrl, destfile = zippedData, method = "curl")
  
  ## this is the path where all files from above downloaded file would be extracted
  unzippedFilesPath <- "./data"
  
  ## unzipping files
  message("unzipping data")
  unzip(zippedData, exdir=unzippedFilesPath)

  ## reading training data set
  trainData <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
  
  ## reading testing data set
  testData <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
  
  ## 1.Merges the training and the test sets to create one data set.
  data <- rbind(trainData, testData)
  
  ## reading features from features.txt file
  features <- read.table("./data/UCI HAR Dataset/features.txt")[,2]
  
  ## renaming columns with its feature values 
  colnames(data) <- features

  ## mean features
  meanFeatures <- grep("mean()", features, fixed=TRUE)

  ## standard deviation features
  stdFeatures <- grep("std()", features, fixed=TRUE)
  
  ## 2 Extracts only the measurements on the mean and standard deviation for each measurement.
  meanStdData <- data[,c(meanFeatures, stdFeatures)]
  
  ########################################################################################################
  #############                           Activity labels file operations                    #############
  ########################################################################################################

  ## reading training activity label
  trainActivityLabel <- read.table("./data/UCI HAR Dataset/train/y_train.txt")[, 1]
  
  ## reading testing activity label
  testActivityLabel <- read.table("./data/UCI HAR Dataset/test/y_test.txt")[, 1]
  
  ## overall activity label for entire data set
  activityLabel <- c(trainActivityLabel, testActivityLabel)
  
  ## adding activityLabel to data set
  tidyData <- cbind(activityLabel = activityLabel, meanStdData)
  
  ########################################################################################################
  #############                           Subject file operations                            #############
  ########################################################################################################
  
  ## reading training subject file
  trainingSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")[, 1]
  
  ## reading testing subject file
  testSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")[, 1]
  
  ## overall subject for complete data set
  subject <- c(trainingSubject, testSubject)
  
  ## adding subject info into tidy data set
  tidyData <- cbind(subject = subject, tidyData)
  
  ## 4.Appropriately labels the data set with descriptive variable names.
  ## changing case to lowercase character
  colnames(tidyData) <- tolower(colnames(tidyData))
  ## removing hyphen from feature names
  colnames(tidyData) <- gsub("-", "", colnames(tidyData))
  ## removing parenthesis as it is reserved for function. So, having it in feature name might lead to inappropriate behavior
  colnames(tidyData) <- gsub("\\(\\)", "", colnames(tidyData))
  
  ## loading plyr library
  library(plyr)
  ## 5. From the data set in step 4, creates a second, independent tidy data 
  ##   set with the average of each variable for each activity and each subject.
  tidyDataSet2 <- ddply(tidyData, .(activitylabel, subject), colMeans)
  
  ## reading activity labels names
  activityLabelNames = as.character(read.table("./data/UCI HAR Dataset/activity_labels.txt")[, 2])
  
  ## adding activity label names in tidyData set
  ## 3. Uses descriptive activity names to name the activities in the data set
  tidyDataSet2 <- cbind(activityname=activityLabelNames[tidyDataSet2$activitylabel], tidyDataSet2)
  
  ## saving final data set in output file
  write.table(tidyDataSet2, outputFileName, row.name=FALSE)
