## ===== run_analysis.R =====
## THIS R SCRIPT IS USED TO MERGE
## AND TIDY UP DATA FROM BOTH A 'test'
## AND A 'validation' SET PROVIDED FROM
## EXPERIMENTAL RESULTS. FOR INFORMATION
## ON THE EXPERIMENT THAT GENERATED THESE
## DATA, PLEASE VISIT THE FOLLOWING WEBSITE:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## CALL PACKAGES
library(dplyr)
library(reshape2)


## READ IN THE COMMON FILES, WHICH ARE
## SHARED BY BOTH THE 'test' and 'training' DATA
activity_labels <- read.table("~/Workspace/coursera/getdata-031/proj1/UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity_name"))
features <- read.table("~/Workspace/coursera/getdata-031/proj1/UCI HAR Dataset/features.txt", col.names = c("feature_id", "feature"))


## READ IN THE 'test' AND 'training'
## DATA, INCLUDE THE DESCRIPTIVE FEATURE NAMES,
## AND ADD subject_id AND activity_id
test_subject <- read.table("~/Workspace/coursera/getdata-031/proj1/UCI HAR Dataset/test/subject_test.txt", col.names = c("subject_id"))
test_activity_labels <- read.table("~/Workspace/coursera/getdata-031/proj1/UCI HAR Dataset/test/y_test.txt", col.names = c("activity_id"))
test_data <- read.table("~/Workspace/coursera/getdata-031/proj1/UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
test_data <- cbind(test_data, test_subject, test_activity_labels)


train_subject <- read.table("~/Workspace/coursera/getdata-031/proj1/UCI HAR Dataset/train/subject_train.txt", col.names = c("subject_id"))
train_activity_labels <- read.table("~/Workspace/coursera/getdata-031/proj1/UCI HAR Dataset/train/y_train.txt", col.names = c("activity_id"))
train_data <- read.table("~/Workspace/coursera/getdata-031/proj1/UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
train_data <- cbind(train_data, train_subject, train_activity_labels)


## CREATE MASTER TABLE, COMBINING 'test' AND 'training' DATA
master <- rbind(test_data, train_data)


## ADD ACTIVITY LABELS
master <- merge(master,
                activity_labels,
                by.x = "activity_id",
                by.y = "activity_id",
                all.x = TRUE)


## FIND COLUMNS CONTAINING 'mean' OR 'std'
mean_cols <- grep("mean", names(master), ignore.case = TRUE)
std_cols <- grep("std", names(master), ignore.case = TRUE)
all_cols <- c(mean_cols, std_cols)


## SUBSET 'master' TO ONLY INCLUDE THE RELEVANT
## COLUMNS: all_cols, subject_id (563), activity_name (564)
subs <- subset(master, select = c(all_cols, 563, 564))


## FROM 'subs' CREATE A SECOND TIDY DATA SET
## WITH THE AVERAGE OF EACH VARIABLE FOR EACH
## ACTIVITY AND SUBJECT
melted <- melt(subs,
               id = names(subs)[87:88],
               measure.vars = names(subs)[1:86])
grouped <- group_by(melted, subject_id, activity_name, variable)
final <- summarize(grouped, mean(value))
