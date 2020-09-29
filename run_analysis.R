filename <- "data/Final_Project.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#State path where data is stored
path <- 'data/UCI HAR Dataset/'

#Read general files
labels <- read.table(paste(path,'activity_labels.txt',sep = '/'),col.names = c('id','activity'))
features <- read.table(paste(path,'features.txt',sep = '/'), col.names = c('#','functions'))

#Read in train data
train_x <- read.table(paste(path,'train/X_train.txt',sep = '/'),col.names = features$functions)
train_y <- read.table(paste(path,'train/y_train.txt',sep = '/'), col.names = 'activity_id')
subject_train <- read.table(paste(path,'train/subject_train.txt',sep = '/'), col.names = 'subject')

#Read in test data
test_x <- read.table(paste(path,'test/X_test.txt',sep = '/'), col.names = features$functions)
test_y <- read.table(paste(path,'test/y_test.txt',sep = '/'), col.names = 'activity_id')
subject_test <- read.table(paste(path,'test/subject_test.txt',sep = '/'), col.names = 'subject')

# Step 1. Merge train and test data
X <- rbind(train_x,test_x)
Y <- rbind(train_y,test_y)
subject <- rbind(subject_train, subject_test)
dataset <- cbind(subject,Y,X)


#Step 2. Extracts only the measurements on the mean and standard deviation for each measurement
library(dplyr)
dataset_2 <- dataset %>% select(subject, activity_id, contains('mean'),contains('std'))


#Step 3. Uses descriptive activity names to name the activities in the data set
dataset_2$activity_id <- labels[dataset_2$activity_id, 2]


#Step 4. Appropriately labels the data set with descriptive variable names.
names(dataset_2)[2] <- 'activity'
names(dataset_2) <- gsub('Acc','Accelerometer', names(dataset_2))
names(dataset_2) <- gsub('Gyro','Gyroscope', names(dataset_2))
names(dataset_2) <- gsub('BodyBody','Body', names(dataset_2))
names(dataset_2) <- gsub('Freq','Frequency', names(dataset_2))
names(dataset_2) <- gsub('^f','Frequency', names(dataset_2))
names(dataset_2) <- gsub('^t','Time', names(dataset_2))
names(dataset_2) <- gsub('Mag','Magnitude', names(dataset_2))
names(dataset_2) <- gsub('tBody','TimeBody', names(dataset_2))
names(dataset_2) <- gsub('Mag','Magnitude', names(dataset_2))

#Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- dataset_2 %>% group_by(activity, subject) %>%
  summarize_all(mean)

write.table(tidy_data, 'Course_Project.txt', row.names = FALSE)
