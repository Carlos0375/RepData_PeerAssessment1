# Course Projekt - Getting and cleaning data
############################################

# Required!
library("dplyr")

########################
# 1. Read and merge data
########################


# Set file path
path <- file.path(getwd(),"UCI HAR Dataset")
path_test <- file.path(path, "test")
path_train <- file.path(path, "train")

# Read test data
x_test <- read.table(file.path(path_test, "X_test.txt"))
y_test <- read.table(file.path(path_test, "Y_test.txt"))
subject_test <- read.table(file.path(path_test, "subject_test.txt"))

# Read train data
x_train <- read.table(file.path(path_train,"X_train.txt"))
y_train <- read.table(file.path(path_train,"Y_train.txt"))
subject_train <- read.table(file.path(path_train,"subject_train.txt"))

# Read activity_labels data - Set column names to Id and Activity
activity_labels <- read.table(file.path(path,"activity_labels.txt"), 
                              col.names=c("Id","Activity"))

# Read feature_labels data - Transform columns to type character
feature_labels <- read.table(file.path(path,"features.txt"), colClasses="character")

# Merge data 1 - combine columns of x, y and subject_train to test_data and train_data
train_data <- cbind(x_train, subject_train,y_train)
test_data <- cbind(x_test, subject_test,y_test)

# Merge data 2 <- combine rows from test_data and train_data to complete_data
complete_data <- rbind(test_data, train_data)

# Add variable names to the columns V1:V563 from the feature_lables
# Create a vector with all the names
labels_complete <- rbind(feature_labels, c(562, "Subject"), c(563, "Id"))[,2]

names(complete_data) <- labels_complete

################################
# Extract attribute names
################################

# Get attributes with mean and std in their names as well as Subject and Id
attributes <- grepl("(*)mean(*)|(*)std(*)|Subject|Id",names(complete_data))

complete_data <- complete_data[,names(complete_data[attributes])]


#################################
# Use describtiv names
#################################

complete_data <- merge(complete_data,activity_labels,by="Id")


################################
# Clean up the variable names
################################

# Remove ()
names(complete_data) <- gsub("[()]","",names(complete_data))

# Replace - with .
names(complete_data) <- make.names(names(complete_data))

#################################
# Create a tidy data set
#################################

tidy_data <- aggregate(. ~ Subject + Activity, data=complete_data, FUN="mean")
tidy_data <- arrange(tidy_data, Subject)


write.table(tidy_data, file="tidy_data.txt", row.names=FALSE)

