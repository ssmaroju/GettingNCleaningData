
setwd("C:/Users/smaroju/LocalDocuments/GitHub/GettingNCleaningData")

## begin need to check code
if (!file.exists("UCI HAR Dataset")) {if (!file.exists("getdata_projectfiles_UCI HAR Dataset.zip")) {
    stop("was expecting HAR Dataset folder or zip file")
  } else {
    unzip("getdata_projectfiles_UCI HAR Dataset.zip")
  }
}
f <- unz("zipFile.zip", "csvFileInZip.csv")
data <- read.table(f, header=TRUE)

### end need to check code

testDir <- list.files("./UCI HAR Dataset/test")
trainDir <- list.files("./UCI HAR Dataset/train")

for (fileOrDir in testDir){
  testDirCont <- file.info(paste("./UCI HAR Dataset/test","/",fileOrDir, sep=""))  
  if (!testDirCont$isdir){
    
  }
}


activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")



features$V2 <- gsub("-","",features$V2)
features$V2 <- gsub("\\,","to",features$V2)
features$V2 <- gsub("\\(","",features$V2)
features$V2 <- gsub("\\)","",features$V2)
features$V2 <- tolower(features$V2)

names(subject_test) <- "subjectid"
names(subject_train) <- "subjectid"

names(X_test) <- features$V2
names(X_train) <- features$V2

names(y_test) <- "activity"
names(y_train) <- "activity"

test_df <- data.frame(subject_test, X_test, y_test)
train_df <- data.frame(subject_train, X_train, y_train)

all_data <- rbind(train_df,test_df)

library(plyr)
toVal=character()
fromVal =character()
for(ind in seq_along(activity_labels$V1)){
  fromVal<-c(fromVal,as.character(activity_labels$V1[ind]))
  toVal<-c(toVal,as.character(activity_labels$V2[ind]))
}
all_data$activity <- as.factor(as.character(all_data$activity))
all_data$activity <- mapvalues(all_data$activity,from=fromVal, to = toVal)

colnames <- names(all_data)
ymean <- colnames[grep(c("mean"),colnames)]
ystd <- colnames[grep(c("std"),colnames)]
indmean <- colnames %in% ymean
indstd <- colnames %in% ystd

ind_meanstd <- indmean|indstd
neededcolumns <- c("subjectid", "activity",colnames[ind_meanstd])
neededdata <-all_data[,neededcolumns]
tidydata <- aggregate(neededdata[,colnames[ind_meanstd]], by=list(neededdata$subjectid,neededdata$activity), FUN="mean")
names(tidydata)[1] <- "subjectid"
names(tidydata)[2] <- "activity"
write.csv(tidydata,file = "tidydata.txt")
