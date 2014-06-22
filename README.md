## Following files are part of project submission
* README.md (this file)
* problem_description.md ( problem description from coursera project page )
* CodeBook.md
* run_analysis.R
* HumanActivityRecognitionDataFromSmartphone.csv ( tidy data set created using submitted script )
* HumanActivityRecognitionDataFromSmartphoneSummary.csv ( tidy summary data set created using script)

run_analysis.R contains code that implements function cleanHumanActivityRecognitionData()
which takes path of data dir root where given data is unzipped. In this project
data is unzipped to some "UCI HAR Dataset" dir. 

Assuming this dir as well as run_analysis.R are in same dir. we need to start R 
from this dir so that cwd in R is same where run_analysis.R and data dir is
located. execution of this function will generate two csv files containing tidy data.

#command to execute in R

> source("run_analysis.R")
> cleanHumanActivityRecognitionData("UCI HAR Dataset")

# Generated csv file
 
* HumanActivityRecognitionDataFromSmartphone.csv  
* HumanActivityRecognitionDataFromSmartphoneSummary.csv

First file contain detailed data for merged test and train set containing
avg and std of various variables.

Second file contains summary of these variables that is for each subject (1-30)
and for each activity (six activities ), total 180 summary rows having means
of data columns in previous file.


# Data Description

A seprate CodeBook is available in projct repository for data description. (CodeBook.wd)
