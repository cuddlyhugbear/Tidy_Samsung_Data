# Tidy_Samsung_Data
This repository stores a .R file that tidies up the "Human Activity Recognition Using Smartphones Data Set". The URL to find this data is here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

# The Process
Processing this data involved the folowing steps (which are commented in-line in the run_analysis.R file):

- Read in all relevant files (both test and training)
- Combine the data.frames (union) to create one large data set
- Merge with the activity_labelx.txt file to give human-readable labels
- Subset the data to any columns that contain the text "mean" or "std" as well as the subject_id and activity_name
- Melt the data down to contain subject_id, activity_name, variable, value
- Group the melted data by subject_id, activity_name, and variable
- Summarize the grouped data by mean(value)
