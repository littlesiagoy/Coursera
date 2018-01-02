# Getting and Cleaning Data Course Project
##run_analysis.R Details
It's pretty self explanatory if you inspect the code since I have added comments to it.

### Objective 1: Gather training data and test data into one data set.
For the training and test data, combine each x and y respectively to form one data set.
Then combine the resulting two data sets into one master one.

### Objective 2: Extract only the measurements on the mean and StdDev for each measurement
Use reg expresions to get a vector of the col names with the words mean() and std().
Then subset the master data set with the resulting vector.

### Objective 3: Use descriptive activity names to name the activities in the data set.
Replace the number in the activity col with the corresponding activity. Ex: 5 = 'walking'

### Objective 4: Label the data set with descriptive variable names.
Using the information from the readme from the original data set, explicitly rename each col name.
Ex: 'BodyAccX-mean()' became 'Body Accelerometer X-axis mean'.

### Objective 5: Create a second, independent tidy set with the avg of each variable for each activity and each subject.
Subsetted the master data set with col names that contained mean() and added the activity col that had already been named. Ex: 5 = walking