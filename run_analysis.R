#install.packages("reshape2")

library(reshape2)
library(plyr)


##########
# process activity lables and features

# activity_labels
activity_labels <- read.table("activity_labels.txt", header = FALSE)
colnames(activity_labels) <- c("label_id", "label_name")

# features
features <- read.table("features.txt", header = FALSE)
colnames(features) <- c("feature_id", "feature_name")

# remove invalid characters from features in order to use features as column names
features_clean <- gsub("[\\(\\),-]", "", features$feature_name)

features_std_mean <- features_clean[grep("mean|std", features_clean)]
#write(features_std_mean, "features_std_mean.txt", sep="\n")


##########
# process test data

subject_test <- read.table("test/subject_test.txt", header = FALSE)
colnames(subject_test) <- "subject_id"

y_test <- read.table("test/y_test.txt", header = FALSE)
colnames(y_test) <- c("label_id")

activity_labels_test <- join(y_test, activity_labels)


X_test <- read.table("test/X_test.txt", header = FALSE)
colnames(X_test) <- features_clean

X_test_std_mean <- X_test[,features_std_mean]

# merge test subject, activity and measurements
test <- data.frame(subject_test, activity_name=activity_labels_test$label_name, X_test_std_mean)


##########
# process train data

subject_train <- read.table("train/subject_train.txt", header = FALSE)
colnames(subject_train) <- "subject_id"

y_train <- read.table("train/y_train.txt", header = FALSE)
colnames(y_train) <- "label_id"

activity_labels_train <- join(y_train, activity_labels)


X_train <- read.table("train/X_train.txt", header = FALSE)
colnames(X_train) <- features_clean

X_train_std_mean <- X_train[,features_std_mean]

# merge train subject, activity and measurements
train <- data.frame(subject_train, activity_name=activity_labels_train$label_name, X_train_std_mean)


##########
# create tidy data set

tidy_dataset <- rbind(test, train)


##########
# calculate and write tidy data set average

tidy_dataset_ave <- ddply(tidy_dataset,.(subject_id, activity_name), colwise(ave, features_std_mean))
tidy_dataset_ave <- unique(tidy_dataset_ave)

write.table(tidy_dataset_ave, "tidy_dataset_ave.txt", row.names = FALSE, quote = FALSE)

