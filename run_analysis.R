# Download and store data if file doesn't already exist

if (!file.exists(file.path(".", "data"))) {
  dir.create(file.path(".", "data"));
}

file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
if (!file.exists(file.path(".", "data", file_url))) {
  download.file(file_url, destfile = file.path(".", "data", "data.zip"));
}

unzip(zipfile = file.path(".", "data", "data.zip"), exdir = file.path(".", "data"));

# Read in and merge data
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt");
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt");
x_merged <- rbind(x_train, x_test)

y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt");
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt");
y_merged <- rbind(y_train, y_test)

subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt");
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt");
subject_merged <- rbind(subject_train, subject_test)

# Extract mean / std
x_merged_mean <- colMeans(x_merged);
x_merged_sd <- apply(x_merged, 2, sd);

# Apply descriptive activity names
# Label the data set with descriptive variable names
features <- read.table('./data/UCI HAR Dataset/features.txt');
activity_labels <- read.table('./data/UCI HAR Dataset/activity_labels.txt');

names(x_merged) <- features$V2;
names(y_merged) <- "activity_id";
names(subject_merged) <- "subject_id";

# Create second, independent tidy data set with avg of each var
new_tidy_data <- cbind(x_merged_mean, x_merged_sd)
