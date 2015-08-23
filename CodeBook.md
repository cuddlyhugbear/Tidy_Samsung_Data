---
Title: "Tidy_Samsung_Data" Codebook
Author: Daniel Schneider
Date: August 23, 2015
---

## Project description
The "Tidy_Samsung_Data" project was developed to tidy-up data from an experiment which used the "Human Activity Recognition Using Smartphones Data Set". For more information on the experiment, please see the URL below:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Study design and data processing

### Collection of the raw data
Per the abstract listed at the URL above:

"Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors."

### Notes on the original (raw) data
There were several files contained in the original data set; only a subset (listed below) were used in this project:
- activity_labels.txt (common to both test and training data; maps activity_id to activity_name)
- features.txt (common to both test and training data; contains the title of the features)
- subject_test.txt (test data; contains a list of the subject_ids)
- y_test.txt (test data; contains a list of activity_ids, which can be mapped to activity_labels.txt)
- X_test.txt (test data; contains the observations from the experiment)
- subject_train.txt (training data; contains a list of the subject_ids)
- y_train.txt (training data; contains a list of activity_ids, which can be mapped to activity_labels.txt)
- X_train.txt (training data; contains the observations from the experiment)

## Creating the tidy datafile

### Guide to create the tidy data file
- Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- Read in each of the files (listed above)
- Combine the test and training data into a master dataset
- Merge the master dataset with the activity_labels.txt file to get a human readable label for each activity
- Subset the columns by taking anything that contains the word "mean" or "std" as well as the subject_id and activity_name fields
- Melt the data; the id fields are subject_id and activity_name; the measure.vars are the remainder of the fields
- Group the melted data by subject_id, activity_name, and variable (from the melt)
- Produce the final output by summarizing the grouped data; mean(value)

### Description of the variables output.txt
- subject_id: id representing the participant in the subject
- activity_name: the activity performed by the participant
- variable: human readable name of the attribute being averaged, see features.txt for full list
- mean(value): average of the variable for that grouping of the subject_id, activity_name

## Sources
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
