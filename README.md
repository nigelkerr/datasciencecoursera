# UCI HAR Data Analysis Project
## 2016-03, nigel kerr, nigel.kerr@gmail.com

## Summary

The assignment calls for extracting, "tidying", and summarizing
certain values from a supplied dataset, the University of California,
Irvine "Human Activity Recognition Using Smartphones Data Set" [UCI HAR].  An R
script, these readme notes, and a code-book to be provided in a github
repository.

## Assignment

Quoting from the assignment:

> You should create one R script called run_analysis.R that does the following.
> 
> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set
> 4. Appropriately labels the data set with descriptive variable names.
> 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The results of 1-4 will be a single dataset encompassing all the test and training observations from the original (#1), but only a subset of the columns (#2), per given conventions (#3 and #4).  A final summary of this dataset is the final data result (#5).

## Dataset

The UCI HAR dataset presnted as available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and with a discussion at a website http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones .  The zipfile of the dataset contains some more detailed discussion of the contents.

Briefly, the dataset contains observations of a number of different human subjects who performed some distinct physical activities while wearing a specific cell phone.  The phone in question included a gyroscope and accelerometer, the singal outputs from which were captured as raw values, and through a variety of different transforms by the original researchers, saved as 561 different variables for several thousand observations.  

With each observation are also two additional values: a subject number for the specific human subject the observation was captured for, and an activity label for which physical activity that subject was actually engaged in at the time of observation.  This reveals the purpose of the dataset: can the many measurements from the cell phone be used to model a given physical activity, even across different humans?

The challenges presented by the dataset in light of the assignment:

- the main observations are text files with a fixed-width columns
- subjects and activities are each in separate files from the main observations
- activities are given just distinct numbers instead of descriptive, factor-like values
- the dataset-supplied variable names do not fit the assingment requirements for various reasons, and have some duplicate names
- only a relatively small number of the main variables are needed per observation
- final summary to be grouped by activity and separately grouped by subject somehow
- a code-book to be written summarizing this all

## Script and Preparation

run_analysis.R contains R code to implement the requirements.  Sourcing this script from within R will execute the statements to produce to outputs, "narrowDt" and "summaryDt", corresponding to the #1-#4 and #5 requirements.

run_analysis.R depends on being able to load dplyr and readr R libraries.

run_analysis.R assumes that the dataset has been acquired and extracted in the same working directory as run_analysis.R will be sourced from.  Such acquisition and extraction could be accomplished with these three R statements:

> uciHarSrcData <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
> download.file(uciHarSrcData, destfile="uci_har_dataset.zip", method="curl")
> unzip("uci_har_dataset.zip")

Once these are executed, the output of dir() ought to include a folder named "UCI HAR Dataset".

## Code Book

Codebook.md is included to describe the details of the output datasets, which see.

## References

The UCI HAR website asks that use of the dataset be cited thus:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.


