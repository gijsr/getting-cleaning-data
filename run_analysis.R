#Gettingandcleaningdata Course Project

#Merge the training and the test sets to create one data set.

#download and unzip files to current directory
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,"gcdataprject.zip",method="curl")
unzip("gcdataprject.zip")

#merge training data with labels and subjects
training = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
traininglabels<-read.csv("UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
subjects<-read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
training[,562]<-traininglabels #adding traininglabels column to training data
training[,563]<-subjects #adding subject column to training data

#merge testing data with labels and subjects
testing = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
testinglabels<-read.csv("UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE) #read test data
testingsubjects<-read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
testing[,562]<-testinglabels #adding traininglabels column to training data
testing[,563]<-testingsubjects #adding subject column to training data

activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)#read activity labels file

features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE) #read features file
features[,2] = gsub('-mean', 'Mean', features[,2]) #replace -mean in col2  by Mean
features[,2] = gsub('-std', 'Std', features[,2])# replace -std in col2 by Std
features[,2] = gsub('[-()]', '', features[,2])# replace -() in col2 by ""

all<-rbind(training,testing) #merge training and test data into one df


#2 Extract only the measurements on the mean and standard deviation for each measurement.

colsforanalysis <- grep(".*Mean.*|.*Std.*", features[,2])# select all cols with .*Mean.* or .*Std.* from 2nd column of features and assign to colsforanalysis
features<- features[colsforanalysis,]
colsforanalysis<- c(colsforanalysis,562,563)
all<-all[,colsforanalysis]

#4 (step 3 follows after this step). Appropriately label the data set with descriptive variable names. 

colnames(all)<-features$V2 #use features file to name columns
names(all)[87]="Activity" #name col 87
names(all)[88]="Subject"#name col 88

#3 Use descriptive activity names to name the activities in the data set

currentActivity = 1 #counter
for (currentActivityLabel in activityLabels$V2) {
  all$Activity <- gsub(currentActivity, currentActivityLabel, all$Activity) 
  currentActivity <- currentActivity + 1 
}

5 #From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData<- aggregate(all[,names(all) != c('Activity','Subject')],by=list(Activity=all$Activity,SubjectId = all$Subject),mean)

6 # Write tidy data set
write.table(tidyData, './tidyData.txt',row.names=FALSE,sep='\t')
