### README

Date: 30-07-2017

This readme is a simple explanation of the steps taken in this repository to fufill the requirements of the Course 3 project.

The R program run_analysis.R runs some basic transformations on the data prescribed in the Project Assignment. More about the data used can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The original transformations on the data is described in the orginal README.txt available in the zipped file

There is also a code book that describesthe data available.
 
The program downloads the data.
Unzips the zip folder.
Loads the data into R.
The Row discriptions are added and the more detailed description is also added.
Names are given to the variables that are descriptive.
More discriptive names where attempted but that made the variable names unreadable.

The test data and the train data was joined.
From this the identification variables and all the mean and standard deviation variables were extracted to suit the first data required.

A Second data set is created from the first to be a mean of the variables by subject and activity.

These two data sets are then writen out as csv files.
This is changed to txt files for only the second set.
The previous code is still included.

