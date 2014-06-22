# This funciton cleans Human Activity Recognition Data collected from smart phone and stores tidy data set in current working directory.
# This function assumes that directory structure follows unix style forward slash "/" for seperating dirs
 
cleanHumanActivityRecognitionData <- function ( datarootdir ) {
#datarootdir<-"UCI HAR Dataset"
# Loading activities labels
activities_labels <- read.table(paste(datarootdir,"activity_labels.txt",sep="/"))
# Loading features index and labels
features <- read.table(paste(datarootdir,"features.txt",sep="/"))
# filtering features for mean()
mean_features<-features[grep("mean\\(",features$V2),]
# filtering features for std()
std_features<-features[grep("std\\(",features$V2),]

#Loading test data
test_subjects<-read.table(paste(datarootdir,"test/subject_test.txt",sep="/"))
test_features<-read.table(paste(datarootdir,"test/X_test.txt",sep="/"))
test_activities<-read.table(paste(datarootdir,"test/y_test.txt",sep="/"))

#Loading train data
train_subjects<-read.table(paste(datarootdir,"train/subject_train.txt",sep="/"))
train_features<-read.table(paste(datarootdir,"train/X_train.txt",sep="/"))
train_activities<-read.table(paste(datarootdir,"train/y_train.txt",sep="/"))

# Create Header for first tidy dataset with mean and std

#number of mean and std variables will be same
num_of_vars<-nrow(mean_features)

# Create empty vectors to hold variable names and their index in data
mean_std_feature_labels=c()
mean_std_feature_index=c()

for ( i in 1:num_of_vars) {
        mean_level<-(mean_features[i,])$V2
        std_level<-(std_features[i,])$V2
	mean_std_feature_labels=append(mean_std_feature_labels,levels(mean_features$V2)[mean_level])
	mean_std_feature_labels=append(mean_std_feature_labels,levels(std_features$V2)[std_level])
	mean_std_feature_index=append(mean_std_feature_index,mean_features[i,]$V1)
	mean_std_feature_index=append(mean_std_feature_index,std_features[i,]$V1)
}

# Create dataframe for test data
     SubjectID<-test_subjects$V1
     Activity<- sapply(test_activities$V1,function(x) activities_labels[x,]$V2)
     testdf <- data.frame(SubjectID,Activity)
for ( i in 1:(num_of_vars*2)) {
     findex<-mean_std_feature_index[i]
     flabel<-gsub("\\(\\)","",mean_std_feature_labels[i])
     testdf<-data.frame(testdf,my=test_features[,findex])	
     names(testdf)[length(names(testdf))] <- flabel
  }
# Create dataframe for train data
     SubjectID<-train_subjects$V1
     Activity<- sapply(train_activities$V1,function(x) activities_labels[x,]$V2)
     traindf <- data.frame(SubjectID,Activity)
# each variable has mean and std so we are adding both
for ( i in 1:(num_of_vars *2)) {
     findex<-mean_std_feature_index[i]
     flabel<-gsub("\\(\\)","",mean_std_feature_labels[i])
     traindf<-data.frame(traindf,my=train_features[,findex])	
     names(traindf)[length(names(traindf))] <- flabel
  }
 library("plyr")
 combined <- rbind(testdf,traindf)
 write.csv(x=combined,file="HumanActivityRecognitionDataFromSmartphone.csv")

# summarize data for each subject/activity combination
summary<-ddply(combined,.(SubjectID,Activity),function(x)  colMeans(x[,3:68] ))

 write.csv(x=summary,file="HumanActivityRecognitionDataFromSmartphoneSummary.csv")

}
