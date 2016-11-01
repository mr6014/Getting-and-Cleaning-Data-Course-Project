run_analysis <- function(furl = 
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
{
  ## if not exist create directory for zip file
  if(!file.exists("./data")) {dir.create("./data")}
  ## download zip file into directory
  download.file(url = furl,destfile = "./data/Dataset.zip",method = "curl")
  ## unzip file
  unzip(zipfile = "./data/Dataset.zip",exdir = "./data")
  ## save file path
  path_rf <- file.path("./data" , "UCI HAR Dataset")
  ## load activity data
  ActTest <- read.table(file.path(path_rf,"test","y_test.txt"),header = FALSE)
  ActTrain <- read.table(file.path(path_rf,"train","y_train.txt"),header = FALSE)
  ## load subject data
  SubjTrain <- read.table(file.path(path_rf,"train","subject_train.txt"),header = FALSE)
  SubjTest <- read.table(file.path(path_rf,"test","subject_test.txt"),header = FALSE)
  ## load features data
  FeatTest <- read.table(file.path(path_rf,"test","X_test.txt"),header = FALSE)
  FeatTrain <- read.table(file.path(path_rf,"train","X_train.txt"),header = FALSE)
  ## merge data by rows
  Subject <- rbind(SubjTrain,SubjTest)
  Activity <- rbind(ActTrain,ActTest)
  Features <- rbind(FeatTrain,FeatTest)
  ## Assign variable names
  names(Subject) <- c("subject")
  names(Activity) <- c("activity")
  FeaturesNames <- read.table(file.path(path_rf,"features.txt"),header = FALSE)
  names(Features) <- FeaturesNames$V2
  ## combine all datasets into datframe by column
  dataComb <- cbind(Subject,Activity)
  Data <- cbind(Features,dataComb)
  ## subset features names with 'mean' and 'std' - this is for mac osx
  subFeaturesNames <- FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)",FeaturesNames$V2)]
  ## subset Data by selected Features names
  selectNames <- c(as.character(subFeaturesNames),"subject","activity")
  Data <- subset(Data,select = selectNames)
  ## load activity labels
  ActLabels <- read.table(file.path(path_rf,"activity_labels.txt"),header = FALSE)
  ## convert 'activity' variable to character
  Data$activity <- as.character(Data$activity)
  ## assign descriptive activity names to activity
  for (i in 1:nrow(Data)) {
    if(Data$activity[i]=='1') {Data$activity[i]=as.character(ActLabels$V2[1])}
    else if(Data$activity[i]=='2') {Data$activity[i]=as.character(ActLabels$V2[2])}
    else if(Data$activity[i]=='3') {Data$activity[i]=as.character(ActLabels$V2[3])}
    else if(Data$activity[i]=='4') {Data$activity[i]=as.character(ActLabels$V2[4])}
    else if(Data$activity[i]=='5') {Data$activity[i]=as.character(ActLabels$V2[5])}
    else if(Data$activity[i]=='6') {Data$activity[i]=as.character(ActLabels$V2[6])}
  }
  ## assign descriptive variable names to Data
  names(Data)<-gsub("^t", "time", names(Data))
  names(Data)<-gsub("^f", "frequency", names(Data))
  names(Data)<-gsub("Acc", "Accelerometer", names(Data))
  names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
  names(Data)<-gsub("Mag", "Magnitude", names(Data))
  names(Data)<-gsub("BodyBody", "Body", names(Data))
  ## load 'plyr' package needed to produce tidy data set
  library(plyr)
  ## produce second data set with calulated mean of subject and activity variables
  Data2 <- aggregate(. ~subject + activity, Data, mean)
  ## order data in the secong data set
  Data2 <- Data2[order(Data2$subject, Data2$activity),]
  ## output tidy data set with averages (Data2) 
  write.table(Data2, file = "tidydata.txt", row.names = FALSE)
}