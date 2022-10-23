# Getting_-_Cleaning_Data_Project

The script run_analysis.R reads the measurement data provided.
It begins by importing the measurement labels followed by the activity labels
Next, individual data points are imported for both the test and training groups

The training and test group data are then merged

The mean and standard deviation measurements are identified and selected

The data are then given appropriate column names and activity ID are converted from their numerical to character representations

The data are then melted and casted into a tidy format for output
