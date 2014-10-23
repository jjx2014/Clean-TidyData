Readme.md

This is for run_analysis.r -- Project for Getting and Cleaning Data
Oct. 21/ 2014

This file explains how run_analysis.r script works.

There is only one script in this work. It is written by the steps
under the project instruction. There are five steps.

Most important!!! You need have all required data files (*.txt)
files in the working directory. DO NOT put them in sub-directory!!!

Step 1

1) Read in training and test data sets, subject data, and activity 
labels data. 
2) Converts activity numbers to meanings. Levels = 1.6, into
("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING",
"STANDING", "LAYING") (testyl). Creates a vector for the name of
dataset(test)(dtsyb). Cbind the vector with activity factor vector.
So far, we create a data.frame of datasettype(test) and 
activitylabels(y_testl) .
3)Cbind(y_testl, subj_test, x_test) to get test dataset - mgx.
It has 2947 obs. of 564 variables
4)repeat step 2)-3) for training data - mgy. It has 7352 obs. of
564 variables.
5) rbind(mgx, mgy) -- mgtt. row 1-2947 -- test data,
row 2948-10299 train data
6) Adds names to mgtt variables from features list

Step 2
Use grep to extract data set with variable names having "mean" or
"std".

Step 3
Adds activity names, subject, dataset type to the step2 dataset, 
eg. test, train, walking, walking_upstaris, subjects.

Step 4
Changes variable names into human readable text for the data set
from step 3.

Step 5
This step needs to include libary(dplyr)
Group_by() and summarise_each() variables for mean. cleans dataset
names. Generates tidy data set per instruction. Outputs file.

End
  