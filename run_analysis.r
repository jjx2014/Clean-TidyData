#Clean and Tidy Data Project

#-----------------------------------------------------------------------
# step 1
#Create new data set with test and training data
#-----------------------------------------------------------------------
#!!!Important, need have all txt files in the working directory!!!

x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subj_test <- read.table("subject_test.txt")
subj_train <- read.table("subject_train.txt")

#activity list
act <- read.table("activity_labels.txt")

#convert activity number to meanings
testy <- y_test$V1
testyl <- factor(testy, levels = 1:6, labels = c("WALKING", "WALKING_UPSTAIRS", 
          "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

#create vector for the name of dataset: test
dtsyb <- rep("test", 2947)
y_testl <- cbind(as.character(dtsyb), as.character(testyl)) #y_testl is a matrix
y_testl <- data.frame(y_testl) #convert matrix to data.frame
names(y_testl) <- c("datasettype", "activitylabels")

#combine test data to labels, subject

mgx <- cbind(y_testl, subj_test, x_test)
#names(mgx) #test data variable names

#convert activity number to meanings
trainy <- y_train$V1
trainyl <- factor(trainy, levels = 1:6, labels = c("WALKING", "WALKING_UPSTAIRS", 
                  "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

#create vector for the name of dataset: test
dtryb <- rep("train", 7352)
y_trainl <- cbind(as.character(dtryb), as.character(trainyl)) #y_testl is a matrix
y_trainl <- data.frame(y_trainl) #convert matrix to data.frame
names(y_trainl) <- c("datasettype", "activitylabels")

#combine test data to labels
mgy <- cbind(y_trainl, subj_train, x_train)
#names(mgy) #train data variable names.

#merge test and train data
mgtt <- rbind(mgx, mgy)
#mgtt: row 1-2947 -- test data, row 2948-10299 train data


#add names to mgtt variables from features list
features <- read.table("features.txt")
class(features)
names(features)
head(features)
wx <- c("datasettype", "activitylabels", "subject", as.character(features$V2))
wx <- as.factor(wx)
#change names of merged data set mgtt
names(mgtt) <- wx #rename mgtt's variables
#names(mgtt) #get the names of variables.

#mgtt is the combined data set with test and training data
#end of create new data set with test and traing data
#---------------------------------------------------------------------

#step 2, extracts mean and std data from step 1 data set.

mgttms <- mgtt[, grep("[Mm]ean|std", names(mgtt))] #subset columns with mean & std

#end of step 2
#----------------------------------------------------------------------

#step 3
#Add activity names to the step2 dataset, eg. test, train, walking, walking_upstaris
#msanl is dataset with mean & std, combined datasettype(test or train) and activity names(walking)
msanl <- cbind(mgtt[, 1:3], mgttms)
#names(msanl)

#end of step 3
#----------------------------------------------------------------------

#step 4
#clean up and change dataset names more human readable
vnames <- names(msanl) #name factor 

va <- gsub("tBodyAcc", "timedomainBodyAcceleration", vnames)
vb <- gsub("tGravityAcc", "timedomainGravityAcceleration", va)
vc <- gsub("tBodyGyro", "timedomainBodybyroscope", vb)
vd <- gsub("tBodyGyroJerk","timedomainBodyGyroscopeJerk", vc)
ve <- gsub("tBodyGyroMag", "timedomainBodyGyroscopeMagnitude", vd)

vf <- gsub("fBodyAcc", "freqdomainBodyAcceleration", ve)
vg <- gsub("fBodyGyro", "freqdomainBodybyroscope", vf)
vh <- gsub("fBodyBodyGyro","freqdomainBodyGyroscope", vg)
vi <- gsub("fBodyBodyAcc", "freqdomainBodyAcceleration", vh)
vj <- gsub("fBodyBodyAccJerkMag", "freqdomainBodyAccelerationJerkMagnitude", vi)
vk <- gsub("freq", "frequency", vj)
vl <- gsub("byros", "Gyros", vk)
vl[84] <- "angle(timedomainBodyAccelerationJerkMean,gravityMean)" #fix extra brakcet. 
vhnames <- vl
names(msanl) <- vhnames

#finish step 4
#-----------------------------------------------------------------------------

#step 5, get mean by test/train, by subject, by activitylabels
library(dplyr)
tdset <- msanl %>% group_by(datasettype, subject, activitylabels) %>% 
         summarise_each(funs(mean))           
class(tdset)

tdsetn <- names(tdset) #tidy set names
na <- gsub("time", "mean-time", tdsetn)
nb <- gsub("frequency", "mean-frequency", na)
nc <- gsub("angle", "mean-angle", nb)
names(tdset) <- nc #give new names to tdset
write.table(tdset, file = "tidyset.txt", row.name = FALSE)
#abt <- read.table("tidyset.txt")

#end of step 5
#end of program
#-----------------------------------------------------------------------------
      