# Getting-and-Cleaning-Data-Course-Project

This Average Data Set is created by Nguyen Kim Anh 
from the original data set  in  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Datas
et.zip, with the only extracted measurements on the mean and standard deviation for each 
measurement. 

It is an  independent tidy data set with the average of each extracted variable for each of six 
activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) and each subject with subject_id from 1 to 30.

Each pair of activity and subject corresponds to one and only one record. For each record it is provided:
- the activity label
- the identifier of the subject who carried out the specified activity
- Average values of all features having "mean" or "std" (cases are not sensitive) in 
feature variable names, aggregated by the specified activity and the specified subject.

The resulted dataset is written into the file named "avr_mean_or_std_data.txt" with columns' names

