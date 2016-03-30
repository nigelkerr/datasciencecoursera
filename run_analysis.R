## UCI HAR Data Analysis project.
## nigel kerr, nigel.kerr@gmail.com

# fast access to fixed-width files
library(readr)
# ease of manipulating tables
library(dplyr)

datasetDir <- "UCI HAR Dataset"

trainDir <- file.path(datasetDir,"train")
testDir <- file.path(datasetDir, "test")

## get the source column names for the X_....txt files in train and test.
colnamesDf <- read.delim(file.path(datasetDir,"features.txt"), header = FALSE, sep = " ", colClasses="character")

## filter names to be "tidy" variable names
## 0. make all the variable names supplied into a unique set, valid in R
## make.names will make invalid chararacters into . which take note in subsequent steps
colnames <- make.names(colnamesDf[,2], unique = TRUE)

## 1. deal with time-domain variables that are mean or std even with x y or z
colnames <- sub("^t([A-Z][A-Za-z]+)\\.(mean|std)\\.\\.(\\.([XYZ]))?$","time\\1\\2\\4",colnames)

## 2. deal with frequency-domain variables that are mean or std even with x y or z
colnames <- sub("^f([A-Z][A-Za-z]+)\\.(mean|std)\\.\\.(\\.([XYZ]))?$","frequency\\1\\2\\4",colnames)

## 3. lowercase
colnames <- tolower(colnames)

## at this point all of the variables *of interest*
## mean's and std's, have colnames that match "^(time|frequency)[a-z]+(mean|std)[xyz]?$"

trainData  <- tbl_df(read_fwf(file=file.path(trainDir, "X_train.txt"), fwf_widths(rep(16,561), col_names = colnames)))
trainActivity <- tbl_df(read.delim(file.path(trainDir, "y_train.txt"), header = FALSE, sep = " ", col.names = c("activity")))
trainSubject <- tbl_df(read.delim(file.path(trainDir, "subject_train.txt"), header = FALSE, sep = " ", col.names = c("subject")))

testData <- tbl_df(read_fwf(file=file.path(testDir, "X_test.txt"), fwf_widths(rep(16,561), col_names = colnames)))
testActivity <- tbl_df(read.delim(file.path(testDir, "y_test.txt"), header = FALSE, sep = " ", col.names = c("activity")))
testSubject <- tbl_df(read.delim(file.path(testDir, "subject_test.txt"), header = FALSE, sep = " ", col.names = c("subject")))

## col_bind the X_....txt, y_....txt, and subject_...txt files in each of
## trainDir and testDir together, then row_bind those two data frames
## into a longer one.

fullDt <- bind_rows(
       bind_cols( trainActivity, trainSubject, trainData),
       bind_cols( testActivity, testSubject, testData)
)

# sanity:
# final names() should equal c(colnames, "activity", "subject"), and size is correct
names(fullDt) == c("activity", "subject", colnames)
dim(fullDt) == c(10299,563)

# identify all the rows we wish to keep for the next step
keepColumn <- grep("^((time|frequency)[a-z]+(mean|std)[xyz]?|subject|activity)$", names(fullDt))
narrowDt <- select(fullDt, keepColumn)

# promote activity and subject to factor based on labels provided for activity
activitiesDf <- read.delim(file.path(datasetDir,"activity_labels.txt"), header = FALSE, sep = " ", colClasses="character")
narrowDt <- mutate(narrowDt, activity = factor(activity, labels = activitiesDf[,2]), subject = factor(subject))

write.table(narrowDt, file="narrowDt", row.name=FALSE)

## now the step #5, making the requested summary
## Note: i have interpretted the request in #5:

#### ... the average of each variable for each activity and each subject.

## to mean "average of each numeric variable per activity-subject
## combination".  there are 30 subjects and 6 activities, per
## documentation, so we expect there to be 180 rows in the result,
## and the same number of columns as the narrow table.

groupedNarrow = group_by(narrowDt, subject, activity)
summary <- summarise_each(groupedNarrow, funs(mean))

dim(summary) == c(180,ncol(narrowDt))

write.table(summary, file="summaryDt", row.name=FALSE)

## end of run_analysis.R
