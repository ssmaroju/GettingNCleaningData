Getting and Cleaning Data
====================

The goal is to prepare tidy data that can be used for later analysis. The objective is to do the following:
1. Create one R script called run_analysis.R that does the following:
In this script, the following steps are carried out to satisfy the objective of merging all the data with appropriate names and description and then creating a tidy dataset.

2. Merges the training and the test sets to create one data set.
a. Check if the data folder is available in the working directory. If the data is not available, download the data and unzip the folder to be able to access the data.
b. Read activity labels and features data from text files in to data tables.
c. Read the test data (subject, X and Y) to data tables
d. Read the train data (subject, X and Y) to data tables
e. X_test and Y_test have same features, which are listed in features data table. However, the format of the names of features do not follow the rubrik defined for proper naming. Following the rubrik, we remove "-", "(", ")" and convert "," to "to" and convert all the strings to lower case.
f. Assign names to the tables manually and using the cleaned features table.
g. Merge by columns all the required data for test and train datasets respectively - including subject, X and y values.
h. Bind by rows the test and train data frames generated above.
i. Activity values needs to be converted from numeric to something more meaningful. The meaningful conversions are provided in the activity table. However, in order to convert this data, the idea is to use "mapvalues". In order to use map values the activity columns should be converted to vectors. The "activity" column of the all_data data frame is converted to factor. Using "mapvalue" function, the numeric factors are converted to more meaningful values.
j. Create all the data and export to a text file.

3. Extracts only the measurements on the mean and standard deviation for each measurement. 
a. To identify only the "mean" and "std" columns from all the data, we can use the "grep" command to identify all the columns that have a substring "mean" or "std". Then the boolean values that match the column names with "mean" and "std" are identified.
b. All the columns that include "mean" and "std" are combined using "|" so that the column order is preserved. and then all the "mean" and "std" columns alongwith "subjectid" and "activity" are chosen.

4. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
a. "aggregate" function is used to find the average of "mean" and "std" columns.
b. Create the tidy data is then exported to a text file.

In the above two datasets, 
5. Uses descriptive activity names to name the activities in the data set

6. Appropriately labels the data set with descriptive activity names. 

