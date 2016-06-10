> if(!file.exists("./data")){dir.create("./data")}
> Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
> download.file(Url, destfile ="./data/Dataset.zip")
trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
Content type 'application/zip' length 62556944 bytes (59.7 MB)
downloaded 59.7 MB

> unzip(zipfile="./data/Dataset.zip", exdir="./data")
> path <- file.path("./data", "UCI HAR Dataset")
> f <- list.files(path, recursive = TRUE)
> f
 [1] "activity_labels.txt"                         
 [2] "features.txt"                                
 [3] "features_info.txt"                           
 [4] "README.txt"                                  
 [5] "test/Inertial Signals/body_acc_x_test.txt"   
 [6] "test/Inertial Signals/body_acc_y_test.txt"   
 [7] "test/Inertial Signals/body_acc_z_test.txt"   
 [8] "test/Inertial Signals/body_gyro_x_test.txt"  
 [9] "test/Inertial Signals/body_gyro_y_test.txt"  
[10] "test/Inertial Signals/body_gyro_z_test.txt"  
[11] "test/Inertial Signals/total_acc_x_test.txt"  
[12] "test/Inertial Signals/total_acc_y_test.txt"  
[13] "test/Inertial Signals/total_acc_z_test.txt"  
[14] "test/subject_test.txt"                       
[15] "test/X_test.txt"                             
[16] "test/y_test.txt"                             
[17] "train/Inertial Signals/body_acc_x_train.txt" 
[18] "train/Inertial Signals/body_acc_y_train.txt" 
[19] "train/Inertial Signals/body_acc_z_train.txt" 
[20] "train/Inertial Signals/body_gyro_x_train.txt"
[21] "train/Inertial Signals/body_gyro_y_train.txt"
[22] "train/Inertial Signals/body_gyro_z_train.txt"
[23] "train/Inertial Signals/total_acc_x_train.txt"
[24] "train/Inertial Signals/total_acc_y_train.txt"
[25] "train/Inertial Signals/total_acc_z_train.txt"
[26] "train/subject_train.txt"                     
[27] "train/X_train.txt"                           
[28] "train/y_train.txt"  
## Read the Data                         
> TestActivity <- read.table(file.path(path, "test", "Y_test.txt"), header = FALSE)
> TrainActivity <- read.table(file.path(path, "train", "Y_train.txt"), header = FALSE)
> TestSubject <- read.table(file.path(path, "test", "subject_test.txt"), header = FALSE)
> TrainSubject <- read.table(file.path(path, "train", "subject_train.txt"), header = FALSE)
> TestFeatures <- read.table(file.path(path, "test", "X_test.txt"), header = FALSE)
> TrainFeatures <- read.table(file.path(path, "train", "X_train.txt"), header = FALSE)
##Merge the Data
> Subject <- rbind(TrainSubject,TestSubject)
> Activity <- rbind(TrainActivity, TestActivity)
> Features <- rbind(TrainFeatures, TestFeatures)
> names(Subject) <- c("subject")
> names(Activity) <- c("activity") 
## Extracts the measurements on the mean and standard deviation
> dataFeaturesNames <- read.table(file.path(path, "features.txt"), head =FALSE)
> names(Features) <- dataFeaturesNames$V2
> Combinedata <- cbind(Subject, Activity)
> Data <- cbind(Features, Combinedata)
## Uses descriptive activity names to name the activities
> activitydes <- read.table(file.path(path, "activity_labels.txt"), header = FALSE)
> head(Data$activity, 30)
## label the dataset
> names(Data) <- gsub("^t" , "time", names(Data))
> names(Data) <- gsub("^f", "frequency", names(Data))
> names(Data) <- gsub ("Acc","Accelerometer", names(Data))
> names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
> names(Data) <- gsub("Mag", "Magnitude",names(Data))
> names(Data) <- gsub("BodyBody", "Body", names(Data))
> names(Data)
##Create second independent tidy data set
> library(plyr)
> dt2 <- aggregate(. ~subject + activity, Data, mean)
> dt2<- dt2[order(dt2$subject, dt2$activity),]
> write.table(dt2,file = "tidydata.txt", row.name=FALSE)

