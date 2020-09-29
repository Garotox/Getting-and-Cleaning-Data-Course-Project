The  script prepares data by merging observations from different files into a single data frame and then tidies it. It follows the steps detailed by the instructions in the course project.

## 1. Download the dataset
The dataset was downloaded and extracted in the data/UCI HAR Dataset folder

## 2. Assign variables
 - `labels`: contains the vector of 6 possible activities.
 - `features`: a 561 long vector obtaining observations in XYZ directions for gyroscope and accelerometer.
 - `train_x`: 7352 observations of training set features' data
 - `test_x`: 2947 observations of test set features' data
 - `train_y`: 7352 observations of training set activities' code data
 - `test_y`: 2947 observations of test set activities' code data
 - `subject_train`: 7352 observations of training set subjects' id number  
 - `subject_test`: 2947 observations of test set subjects' id number.  
 
## 3. Merge sets to create one data set
 - `X`: 10299 observations of 561 variables created by merging `train_x` and `test_x`
 - `Y`: 10299 observations of 561 variables created by merging `train_y` and `test_y`
 - `subject`: 10299 observations combining subjects from train and test sets of data.
 - `dataset`: (10299x563) column bind of `X`, `Y` and `subject`.
 
## 4. Extract only measurements of mean and standard deviation
 - `datset_2`: (10299x88) obtained by filtering dataset and only keeping columns containing the words "mean", "std", plus subject and activity columns.
 
Finally, the tidied data is assigned to:
- `tidy_data`: correct column labels and activities' names are assigned to the dataset. 
 