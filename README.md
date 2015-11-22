
# Codebook

The experiments have been carried out with a group of 30 volunteers within an 
age bracket of 19-48 years. Each person performed six activities (WALKING, 
WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a 
smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer
and gyroscope, we captured 3-axial linear acceleration and 3-axial angular
velocity at a constant rate of 50Hz. The experiments have been video-recorded 
to label the data manually. The obtained dataset has been randomly partitioned 
into two sets, where 70% of the volunteers was selected for generating the 
training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying
noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 
50% overlap (128 readings/window). The sensor acceleration signal, which has 
gravitational and body motion components, was separated using a Butterworth 
low-pass filter into body acceleration and gravity. The gravitational force is 
assumed to have only low frequency components, therefore a filter with 0.3 Hz 
cutoff frequency was used. From each window, a vector of features was obtained 
by calculating variables from the time and frequency domain.

## Attribute Information

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the 
  estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## Transformation of the Raw-Data

### Assignment 1
In a first step the test datasets and the train datasets were loaded and each
assigned to a variable. Further the data for activity labels and feature labesl
was loaded and assigned to a variable each. 
For each of the datasets (train and test) the three raw datasets where combined 
to a new data frame using the cbind() function.
These two new datasets (train_data and test_data) where merged using the rbind()
function (new data frame: complete_data).
To add variable names to this data frame a new vector with names was created
using the data of feature_labels and adding the variabel names Subject and Id
(new vector: labels_complete). This vector was assigned to the attribute names
of complete_data (names(complete_data)).

### Assignment 2
The attribute names containing the characters "mean"" or "std"" where extracted 
by first generating an index-vector by using regular expressions and the
function grepl() (new vector: attributes).
This index-vector () was used to create a data frame containing only attributes
that matched the search pattern of grepl() (updated data frame: complete_data).

### Assignment 3
The descriptive activity names where implemented into the dataset by using the
merge() function. The attribute to match was labeled "by=Id".

### Assignment 4
The brakets in the attribute names were removed by using the function gsub().
The special characters like "-" where replaced by using the function 
make.names().

### Assignment 5
The tidy dataset was created by using the function aggregate(). The mean was
calculated for all variables by using the . and the data was grouped by the
attributes "Subject" and "Activity".
In a last step the final dataset was sorted by the variable "Subject" by using
the arrange() function of the library "dplyr".