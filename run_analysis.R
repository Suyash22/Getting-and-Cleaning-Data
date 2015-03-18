##Step 1 -> Merges the training and the test sets to create one data set
##Assuming all the files are at the same location

y_test<-read.table("y_test.txt",header=FALSE)
y_train<-read.table("y_train.txt",header=FALSE)
X_test<-read.table("X_test.txt",header=FALSE)
X_train<-read.table("X_train.txt",header=FALSE)
subject_test<-read.table("subject_test.txt",header=FALSE)
subject_train<-read.table("subject_train.txt",header=FALSE)

##Combining the test and train datasets to make three datasets

subject_data<-rbind(subject_train,subject_test)
X_data<-rbind(X_train,X_test)
y_data<-rbind(y_train,y_test)

##Naming the columns of the three datasets

colnames(y_data)<-"Activity"
colnames(subject_data)<-"Subject"
names<-read.table("features.txt",header=FALSE)
colnames(X_data)<-names$V2

##Combining the three datasets from above to make a single dataset

fdata<-cbind(subject_data,X_data,y_data)


##Step 2 -> Extracts only the measurements on the mean and standard deviation for each measurement
X_data<-X_data[,grep("mean|std",colnames(X_data))]
fdata<-cbind(subject_data,X_data,y_data)

##Step 3 -> Uses descriptive activity names to name the activities in the data set

names<-read.table("activity_labels.txt",header=FALSE)
library(sqldf)
fdata<-sqldf("select * from fdata join names on fdata.activity=names.V1")
library(dplyr)
fdata<-select(fdata,-c(81,82))
colnames(fdata)[81]<-"activity"

##Step 4 -> Appropriately labels the data set with descriptive variable names 

names(fdata)<-gsub("^t", "time", names(fdata))
names(fdata)<-gsub("Acc", "Accelerometer", names(fdata))
names(fdata)<-gsub("Gyro", "Gyroscope", names(fdata))
names(fdata)<-gsub("^f", "frequency", names(fdata))
names(fdata)<-gsub("Mag", "Magnitude", names(fdata))
names(fdata)<-gsub("BodyBody", "Body", names(fdata))


##Step 5 -> From the data set in step 4, creates a second, 
##independent tidy data set with the average of each variable for each activity and each subject

final_data_1<-aggregate(.~activity+subject,fdata,mean)
final_data_2<-final_data_1[order(final_data_1$activity,final_data_1$subject),]
write.table(final_data_2, file = "tidydata.txt",row.name=FALSE)

