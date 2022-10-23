library(data.table)
library(reshape2)

# Read in features.txt which is a list of all measurements obtained in the
# training and test data files
features <- read.table("Data/UCI HAR Dataset/features.txt")

# Read in activity_labels.txt which identifies the individual activities in
# which measurements were obtained
activity <- read.table("Data/UCI HAR Dataset/activity_labels.txt")

# Read in training group data, activity label, and subject ID
x_train <- read.table("Data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("Data/UCI HAR Dataset/train/y_train.txt")
s_train <- read.table("Data/UCI HAR Dataset/train/subject_train.txt")

# Read in test group data, activity label, and subject ID
x_test <- read.table("Data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("Data/UCI HAR Dataset/test/y_test.txt")
s_test <- read.table("Data/UCI HAR Dataset/test/subject_test.txt")

# Merge training and test group data
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
s <- rbind(s_train, s_test)

# Select only outputs of mean or standard deviations. Begin by identifying
# data labels containing "mean" or "std"
collectedColumns <- grep("-(mean|std)", features[,2])
ccolNames <- features[collectedColumns,2]

# Subset data output to only mean or standard deviation
x <- x[,collectedColumns]

# Merge subject ID, activity ID, and mean/std measurements and apply appropriate
# naming
combData <- cbind(s,y,x)
colnames(combData) <- c("Subject","Activity",ccolNames)

# Convert numerical activity ID to character labels
combData$activity <- factor(combData$activity,levels = activity[,1],labels = activity[,2])

# Melt data as long output maintaining Subject and Activity columns
mData <- melt(allData, id = c("Subject", "Activity"))

# Cast data as tidy output
tData <- dcast(meltedData, Subject + Activity ~ variable, mean)

# Write out tidy data table
write.table(tData, "tidy_data.txt", row.names = FALSE, quote = FALSE)