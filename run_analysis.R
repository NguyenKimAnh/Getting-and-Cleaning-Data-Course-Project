# put getdata_projectfiles_UCI HAR Dataset.zip file into current working directory and unzip it
# set working directory to ~/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset"
setwd(paste(getwd(),"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset",sep=""))

#read features and activity labels
feature=read.table("features.txt")
activity.label=read.table("activity_labels.txt")


#set working directory to subdirectory "/train")
setwd(paste(getwd(),"/train",sep=""))

#read train data, label and subject
train.data=read.table("x_train.txt")
train.label=read.table("y_train.txt")
train.subject=read.table("subject_train.txt")

#set working directory to subdirectory "/Inertial Signals")
setwd(paste(getwd(),"/Inertial Signals",sep=""))

#read train Inertial Signals
train.body.acc.x=read.table("body_acc_x_train.txt")
train.body.acc.y=read.table("body_acc_y_train.txt")
train.body.acc.z=read.table("body_acc_z_train.txt")

train.body.gyro.x=read.table("body_gyro_x_train.txt")
train.body.gyro.y=read.table("body_gyro_y_train.txt")
train.body.gyro.z=read.table("body_gyro_z_train.txt")

train.total.acc.x=read.table("total_acc_x_train.txt")
train.total.acc.y=read.table("total_acc_y_train.txt")
train.total.acc.z=read.table("total_acc_z_train.txt")


#return to "UCI HAR Dataset" directory
setwd("../")
setwd("../")

#set working directory to subdirectory "/test")
setwd(paste(getwd(),"/test",sep=""))

#read test data, label and subject
test.data=read.table("x_test.txt")
test.label=read.table("y_test.txt")
test.subject=read.table("subject_test.txt")

#set working directory to subdirectory "/Inertial Signals")
setwd(paste(getwd(),"/Inertial Signals",sep=""))

#read test Inertial Signals
test.body.acc.x=read.table("body_acc_x_test.txt")
test.body.acc.y=read.table("body_acc_y_test.txt")
test.body.acc.z=read.table("body_acc_z_test.txt")

test.body.gyro.x=read.table("body_gyro_x_test.txt")
test.body.gyro.y=read.table("body_gyro_y_test.txt")
test.body.gyro.z=read.table("body_gyro_z_test.txt")

test.total.acc.x=read.table("total_acc_x_test.txt")
test.total.acc.y=read.table("total_acc_y_test.txt")
test.total.acc.z=read.table("total_acc_z_test.txt")

#1. Merges the training and the test sets to create one data set with its corresponding tables 
# "data", "label", "subject", and Inertial Signals

data=rbind(test.data,train.data)
label=rbind(test.label, train.label)
subject=rbind(test.subject, train.subject)

body.acc.x=rbind(test.body.acc.x, train.body.acc.x)
body.acc.y=rbind(test.body.acc.y, train.body.acc.y)
body.acc.z=rbind(test.body.acc.z, train.body.acc.z)

body.gyro.x=rbind(test.body.gyro.x, train.body.gyro.x)
body.gyro.y=rbind(test.body.gyro.y, train.body.gyro.y)
body.gyro.z=rbind(test.body.gyro.z, train.body.gyro.z)

total.acc.x=rbind(test.total.acc.x, train.total.acc.x)
total.acc.y=rbind(test.total.acc.y, train.total.acc.y)
total.acc.z=rbind(test.total.acc.z, train.total.acc.z)

#return to "UCI HAR Dataset" directory
setwd("../")
setwd("../")

#Write to text files
write.table(data,"data.txt", row.names=FALSE, col.names=FALSE)
write.table(label,"label.txt", row.names=FALSE, col.names=FALSE)
write.table(subject,"subject.txt", row.names=FALSE, col.names=FALSE)

write.table(body.acc.x,"body_acc_x.txt", row.names=FALSE, col.names=FALSE)
write.table(body.acc.y,"body_acc_y.txt", row.names=FALSE, col.names=FALSE)
write.table(body.acc.z,"body_acc_z.txt", row.names=FALSE, col.names=FALSE)

write.table(body.gyro.x,"body_gyro_x.txt", row.names=FALSE, col.names=FALSE)
write.table(body.gyro.y,"body_gyro_y.txt", row.names=FALSE, col.names=FALSE)
write.table(body.gyro.z,"body_gyro_z.txt", row.names=FALSE, col.names=FALSE)

write.table(total.acc.x,"total_acc_x.txt", row.names=FALSE, col.names=FALSE)
write.table(total.acc.y,"total_acc_y.txt", row.names=FALSE, col.names=FALSE)
write.table(total.acc.z,"total_acc_z.txt", row.names=FALSE, col.names=FALSE)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#extract all columns with mean or std in names
#grep("[Mm]ean|[Ss]td", feature$V2)
#colnames(data)= feature$V2

#data.mean.or.std= data[,grep("[Mm]ean|[Ss]td", feature$V2, value=TRUE)]
mean.or.std.var=grep("mean|std", feature$V2, ignore.case=TRUE,value=TRUE)
mean.or.std.data = data[,grep("mean|std", feature$V2, ignore.case=TRUE)]

#3. Uses descriptive activity names to name the activities in the data set
#head(label)
#tail(label)

label$V1=factor(label$V1, labels=activity.label$V2)
#head(label)
#tail(label)

#4. Appropriately labels the data set with descriptive variable names.
# set names to columns for one-data set 
colnames(mean.or.std.data)= mean.or.std.var
colnames(data)= feature$V2
colnames(label)="activity"
colnames(subject)="subject_id"

# set a character vector reading with values from "reading_1" to "reading_128"
reading=paste(c(rep("reading", 128)), c(1:128), sep="_")
colnames(body.acc.x) = reading
colnames(body.acc.y) = reading
colnames(body.acc.z) = reading

colnames(body.gyro.x) = reading
colnames(body.gyro.y) = reading
colnames(body.gyro.z) = reading

colnames(total.acc.x) = reading
colnames(total.acc.y) = reading
colnames(total.acc.z) = reading

#5. From the data set in step 4, creates a second, independent tidy data set for mean or standard features 
#(and then for all features) with the average of each variable (feature) for each activity and each subject.
n=ncol(mean.or.std.data)
x=data.frame(label,subject, mean.or.std.data)
avr.mean.or.std.data= aggregate (x[,3:(n+2)], list (activity=x[,1],subject_id=x[,2]),mean)
write.table(avr.mean.or.std.data,"avr_mean_or_std_data.txt", row.names=FALSE)
z=data.frame (c(1:(n+2)), colnames(avr.mean.or.std.data))
write.table(z,"avr_features.txt", row.names=FALSE, col.names=FALSE)


x=data.frame(label,subject, data)
avr.data = aggregate (x[,3:563], list (activity=x[,1],subject_id=x[,2]),mean)
write.table(avr.data,"avr_data.txt", row.names=FALSE)


