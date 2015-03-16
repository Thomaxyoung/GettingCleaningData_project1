#read in the data
train<-read.table("train//X_train.txt")
test<-read.table("test/X_test.txt")
data<-rbind(train,test)

#use dplyr 
library(dplyr)
data<-tbl_df(data)

#read the variable names
features<-read.table("features.txt")

#use the descriptive names to lable the variables
names(data)<-features[,2]

#read the activity lables
activity_labels<-read.table("activity_labels.txt")

#generate the index of "mean" and "std"
mean_index<-c( grep("mean",features[,2]))
std_index<-grep("std",features[,2])
index<-c(mean_index, std_index)

#subset the data 
data_sub<-data[,index]


#read the activity lables
activity_labels<-read.table("activity_labels.txt")

#read the activity code
y_train<-read.table("train/y_train.txt")
y_test<-read.table("test/y_test.txt")

activity_code<-rbind(y_train,y_test)

#3.Uses descriptive activity names to name the activities in the data set

data_sub$activity_labels<-inner_join(activity_code,activity_labels, by="V1")$V2

#read the subject ID

subject_train<-read.csv("subject_train.txt", header=FALSE)
subject_test<-read.csv("subject_test.txt", header=FALSE)
names(subject_test)<-"subject_id"
names(subject_train)<-"subject_id"
subject_id<-rbind(subject_train,subject_test)

data_sub<-cbind(data_sub,subject_id)


#take the data_sub back to normal dataframe
# if it is a tbl_df class, you can't use mean cause the sub set of it is not numeric but tbl_df
data_sub<-as.data.frame(data_sub)

data_tidy<-aggregate(data_sub[,1:79], 
                     by=list(data_sub$activity_labels, data_sub$subject_id),
                     FUN="mean")
data_tidy<-rename(data_tidy,activity_labels=Group.1)
data_tidy<-rename(data_tidy,subject_id=Group.2)

#output the final data, sep="".
write.table(data_tidy, "data_tidy.txt", row.names=FALSE)