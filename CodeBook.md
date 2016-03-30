# Codebook for UCI HAR Data Analysis Project
## 2016-03, nigel kerr, nigel.kerr@gmail.com

This codebook describes the variables found in the two result files of
this analysis project, narrowDt and summaryDt (corresponding to items
1-4 and 5 in the assignment).  The project is all about manipulating
an existing dataset in a particular way to two new products, hence
there is only information about variables and summarization, no
experimental design.

## Variables

The assignment called for extracting two factor variables and a subset
of all numeric variables from the UCI HAR Dataset (mean and
standard-deviation values, 66 out of a full complement of 561
variables).  The variables were expected to conform to the
instructors' notions of tidiness (tritely: lowercase, no punctuation,
meaningful enough), and the factors variables were to be descriptive.

The UCI HAR Dataset variables presented didn't in a variety of ways
conform to these needs, and at least one of the factor variables
needed descriptive values over numbers.  This results in three classes
of variable in the resulting narrowDt table.

* activity
** factor, of six values WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS SITTING STANDING LAYING
** created as "activity" from the dataset's activity data file, y_train.txt and y_test.txt, and mapping the integers in those files to the names given in the dataset's activity_labels.txt
* subject
** factor, values 1 through 30
** indicates which subject the observation of all other variables was for at some distinct point.  There was not a compelling reason to map these numbers onto other text, since the subjects were not identified in any way other than number.
* timebodyaccmeanx
* timebodyaccmeany
* timebodyaccmeanz
* timebodyaccstdx
* timebodyaccstdy
* timebodyaccstdz
* timegravityaccmeanx
* timegravityaccmeany
* timegravityaccmeanz
* timegravityaccstdx
* timegravityaccstdy
* timegravityaccstdz
* timebodyaccjerkmeanx
* timebodyaccjerkmeany
* timebodyaccjerkmeanz
* timebodyaccjerkstdx
* timebodyaccjerkstdy
* timebodyaccjerkstdz
* timebodygyromeanx
* timebodygyromeany
* timebodygyromeanz
* timebodygyrostdx
* timebodygyrostdy
* timebodygyrostdz
* timebodygyrojerkmeanx
* timebodygyrojerkmeany
* timebodygyrojerkmeanz
* timebodygyrojerkstdx
* timebodygyrojerkstdy
* timebodygyrojerkstdz
* timebodyaccmagmean
* timebodyaccmagstd
* timegravityaccmagmean
* timegravityaccmagstd
* timebodyaccjerkmagmean
* timebodyaccjerkmagstd
* timebodygyromagmean
* timebodygyromagstd
* timebodygyrojerkmagmean
* timebodygyrojerkmagstd
* frequencybodyaccmeanx
* frequencybodyaccmeany
* frequencybodyaccmeanz
* frequencybodyaccstdx
* frequencybodyaccstdy
* frequencybodyaccstdz
* frequencybodyaccjerkmeanx
* frequencybodyaccjerkmeany
* frequencybodyaccjerkmeanz
* frequencybodyaccjerkstdx
* frequencybodyaccjerkstdy
* frequencybodyaccjerkstdz
* frequencybodygyromeanx
* frequencybodygyromeany
* frequencybodygyromeanz
* frequencybodygyrostdx
* frequencybodygyrostdy
* frequencybodygyrostdz
* frequencybodyaccmagmean
* frequencybodyaccmagstd
* frequencybodybodyaccjerkmagmean
* frequencybodybodyaccjerkmagstd
* frequencybodybodygyromagmean
* frequencybodybodygyromagstd
* frequencybodybodygyrojerkmagmean
* frequencybodybodygyrojerkmagstd
** numeric
** all these values are either a mean value or a standard-deviation value of some gyroscope or accelerometer measurement, or a further processing of those basic measurements, in either the time or frequency domains.  Some of these values have X, Y, or Z dimension components.  The construction of the names of these variables was to 
*** have the string 'time' or 'frequency' for the domain
*** the short name of the base variable as provided in the dataset (this amounts to bodyacc bodyaccjerk bodyaccjerkmag  bodyaccmag bodybodyaccjerkmag bodybodygyrojerkmag bodybodygyromag bodygyro bodygyrojerk bodygyrojerkmag bodygyromag gravityacc gravityaccmag )
*** mean or std as provided
*** x, y, or z if this particular variable has those dimensions
** Because understanding the significance of the different base variables was not important to the assignment, I opted to not expand them to more descriptive strings.

All other variables in the original dataset were discarded.

## Results

The first result, narrowDt, includes all observations from both the
test and training sub-sets provided by the UCI HAR dataset, with the
two factors and 66 numeric variables joined together in one table.
Please see run_analysis.R included here for the exact steps used to
generate that result.  Functions from the dplyr package figure
prominently in that code.

The second result, summaryDt, has the same and the same number of
columns, but only summary rows.  My interpretation of the assignment
was to produce a summary table with averages of all the numeric
variables by unique activity-subject pair (instead of a rather
differently shaped summary of numeric variables by activity, and
additional numeric variables by subject).  I did not feel it necessary
to rename any columns for that summary.




