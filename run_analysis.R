#Reading the data
Train.data<-read.table('./UCI HAR Dataset/train/X_train.txt')
Test.data<-read.table('./UCI HAR Dataset/test/X_test.txt')

#1) Merging data sets and removing the old ones
Data<-rbind.data.frame(Train.data,Test.data)
rm(list=c('Test.data','Train.data'))

#Reading feature information and selecting mean and std
features<-read.table('./UCI HAR Dataset/features.txt')[,2] #Names only
ind<-grep("mean\\(\\)|std",features) #Using "mean\\(\\)|std" to exclude meanFreq
features<-features[ind]

#2)Selecting only the mean and standard deviation for measurements
Data<-Data[,ind]

#3) Appropriate labels
features<-gsub('Acc','Acceleration',features)
features<-gsub('GyroJerk','AngularAcceleration',features)
features<-gsub('Gyro','Gyroscope',features)
features<-gsub('AccelerationJerk','LinearAcceleration',features)
features<-gsub('Mag','_Magnitude',features)
features<-gsub('BodyBody','Body_Body',features)
#Indexes
indm<-grep("mean",features)
inds<-grep("std",features)
indt<-grep("^t",features)
indf<-grep("^f",features)
#Eliminating terms
features<-gsub('-mean\\(\\)','',features)
features<-gsub('-std\\(\\)','',features)
features<-gsub('^t','',features)
features<-gsub('^f','',features)
#Adding terms
features[indm]<-paste('MEAN.',features[indm],sep='')
features[inds]<-paste('SD.',features[inds],sep='')
features[indt]<-paste(features[indt],'.TimeDomain',sep='')
features[indf]<-paste(features[indf],'.FreqDomain',sep='')
#Last change
features<-gsub('-','_',features)

#4) Labeling the data set
colnames(Data)<-features

#Converting to tibble
library(dplyr)
Data<-as_tibble(Data)
#Subject
subjects<-append(unlist(read.table('./UCI HAR Dataset/train/subject_train.txt')),
                 unlist(read.table('./UCI HAR Dataset/test/subject_test.txt')))
#Activity
activity<-append(unlist(read.table('./UCI HAR Dataset/train/y_train.txt')),
                 unlist(read.table('./UCI HAR Dataset/test/y_test.txt')))
#Activity as factor
activity<-factor(activity,labels=c('WALKING','WALKING_UPSTAIRS','WALKING_DOWNSTAIRS','SITTING','STANDING','LAYING'))
#5) Creates a tidy data set with the average of each variable for each activity and each subject
TidyData<-Data %>%
  mutate(Subject=subjects,Activity=activity)%>%
  group_by(Subject,Activity) %>%
  summarise_all(mean)

#Saving the data set that was required
write.csv(TidyData,'TidyData.csv')