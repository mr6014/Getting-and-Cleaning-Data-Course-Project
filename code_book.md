Code Book

Link to the original source:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Link to the original description:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The R script “run_analysis.R” merges the following data into one dataset:
- merges training and test data  (X_test.txt + X_train.txt);
- merges subject IDs  (subject_train.txt + subject_test.txt);
- merges activity IDs (y_test.txt + y_train.txt);
- extracts only mean & standard deviation measurments from the features.txt ;
- extracts activity labels from the activity_labels.txt and applies the labels to the 
 ‘activity’ variable in the merged dataset, the activity labels are
 WALKING
 WALKING_UPSTAIRS
 WALKING_DOWNSTAIRS
 SITTING
 STANDING
 LAYING ;
- assigns meanigful names to the attributes, such as
 timeBodyAccelerometer-mean()-X
 timeBodyAccelerometer-std()-X
 frequencyBodyAccelerometer-mean()-X
 frequencyBodyAccelerometer-std()-X;
- created tidy dataset tidy data.txt where 
 1st column contains subject IDs
 2nd column contains activity names
 3rd : 68th columns contain averages for each attribute;

there are 6 activities and 30 subjects - 180 rows in total.