#set working directory, read data and load packages
getwd()
setwd("/Users/jc422/Desktop/Coursera-DataSciTrack/CleanGetData/CourseProject")
trainid <- read.table("./subject_train.txt", col.name = "id")
trainx <- read.table("./X_train.txt")
trainy <- read.table("./Y_train.txt")
testid <- read.table("./subject_test.txt", col.name = "id")
testx <- read.table("./X_test.txt")
testy <- read.table("./Y_test.txt")
library(plyr)
install.packages("sqldf")
library(sqldf)

# Merge data sets
trainidxy <- cbind(trainid, trainx, trainy)
testidxy <- cbind(testid, testx, testy)
data <- rbind(trainidxy, testidxy)

#extract mean and standard deviation measurements
ex_data <- data[,c(1,2,3,4,5,6,7,42,43,44,45,46,47,82,83,84,85,86,87,122,123,124,125,126,127,
                   162,163,164,165,166,167,202,203,215,216,228,229,241,242,254,255,
                   267,268,269,270,271,272,295,296,297,346,347,348,349,350,351,
                   374,375,376,425,426,427,428,429,430,453,454,455,504,505,514,
                   517,518,527,530,531,540,543,544,553,556,557,558,559,560,561,562,563)]

# Name activities
ex_data$activities <- ifelse(ex_data$V1.1 == 1, "walking", 
                             (ifelse(ex_data$V1.1 == 2, "walking upstairs", 
                                     (ifelse(ex_data$V1.1 == 3, "walking downstairs", 
                                             (ifelse(ex_data$V1.1 == 4, "sitting", 
                                                     (ifelse(ex_data$V1.1 == 5, "standing", 
                                                             (ifelse(ex_data$V1.1 == 6, "laying", NA)))))))))))

# create descritive variable names
descrdata <- rename(ex_data, replace=c("id" = "subjectid",
                                    "V1" = "tBodyAcc-mean()-X",
                                    "V2" = "tBodyAcc-mean()-Y",
                                    "V3" = "tBodyAcc-mean()-Z",
                                    "V4" = "tBodyAcc-std()-X",
                                    "V5" = "tBodyAcc-std()-Y",
                                    "V6" = "tBodyAcc-std()-Z",
                                    "V41" = "tGravityAcc-mean()-X",
                                    "V42" = "tGravityAcc-mean()-Y",
                                    "V43" = "tGravityAcc-mean()-Z",
                                    "V44" = "tGravityAcc-std()-X",
                                    "V45" = "tGravityAcc-std()-Y",
                                    "V46" = "tGravityAcc-std()-Z",
                                    "V81" = "tBodyAccJerk-mean()-X",
                                    "V82" = "tBodyAccJerk-mean()-Y",
                                    "V83" = "tBodyAccJerk-mean()-Z",
                                    "V84" = "tBodyAccJerk-std()-X",
                                    "V85" = "tBodyAccJerk-std()-Y",
                                    "V86" = "tBodyAccJerk-std()-Z",
                                    "V121" = "tBodyGyro-mean()-X",
                                    "V122" = "tBodyGyro-mean()-Y",
                                    "V123" = "tBodyGyro-mean()-Z",
                                    "V124" = "tBodyGyro-std()-X",
                                    "V125" = "tBodyGyro-std()-Y",
                                    "V126" = "tBodyGyro-std()-Z",
                                    "V161" = "tBodyGyroJerk-mean()-X",
                                    "V162" = "tBodyGyroJerk-mean()-Y",
                                    "V163" = "tBodyGyroJerk-mean()-Z",
                                    "V164" = "tBodyGyroJerk-std()-X",
                                    "V165" = "tBodyGyroJerk-std()-Y",
                                    "V166" = "tBodyGyroJerk-std()-Z",
                                    "V201" = "tBodyAccMag-mean()",
                                    "V202" = "tBodyAccMag-std()",
                                    "V214" = "tGravityAccMag-mean()",
                                    "V215" = "tGravityAccMag-std()",
                                    "V227" = "tBodyAccJerkMag-mean()",
                                    "V228" = "tBodyAccJerkMag-std()",
                                    "V240" = "tBodyGyroMag-mean()",
                                    "V241" = "tBodyGyroMag-std()",
                                    "V253" = "tBodyGyroJerkMag-mean()",
                                    "V254" = "tBodyGyroJerkMag-std()",
                                    "V266" = "fBodyAcc-mean()-X",
                                    "V267" = "fBodyAcc-mean()-Y",
                                    "V268" = "fBodyAcc-mean()-Z",
                                    "V269" = "fBodyAcc-std()-X",
                                    "V270" = "fBodyAcc-std()-Y",
                                    "V271" = "fBodyAcc-std()-Z",
                                    "V294" = "fBodyAcc-meanFreq()-X",
                                    "V295" = "fBodyAcc-meanFreq()-Y",
                                    "V296" = "fBodyAcc-meanFreq()-Z",
                                    "V345" = "fBodyAccJerk-mean()-X",
                                    "V346" = "fBodyAccJerk-mean()-Y",
                                    "V347" = "fBodyAccJerk-mean()-Z",
                                    "V348" = "fBodyAccJerk-std()-X",
                                    "V349" = "fBodyAccJerk-std()-Y",
                                    "V350" = "fBodyAccJerk-std()-Z",
                                    "V373" = "fBodyAccJerk-meanFreq()-X",
                                    "V374" = "fBodyAccJerk-meanFreq()-Y",
                                    "V375" = "fBodyAccJerk-meanFreq()-Z",
                                    "V424" = "fBodyGyro-mean()-X",
                                    "V425" = "fBodyGyro-mean()-Y",
                                    "V426" = "fBodyGyro-mean()-Z",
                                    "V427" = "fBodyGyro-std()-X",
                                    "V428" = "fBodyGyro-std()-Y",
                                    "V429" = "fBodyGyro-std()-Z",
                                    "V452" = "fBodyGyro-meanFreq()-X",
                                    "V453" = "fBodyGyro-meanFreq()-Y",
                                    "V454" = "fBodyGyro-meanFreq()-Z",
                                    "V503" = "fBodyAccMag-mean()",
                                    "V504" = "fBodyAccMag-std()",
                                    "V513" = "fBodyAccMag-meanFreq()",
                                    "V516" = "fBodyBodyAccJerkMag-mean()",
                                    "V517" = "fBodyBodyAccJerkMag-std()",
                                    "V526" = "fBodyBodyAccJerkMag-meanFreq()",
                                    "V529" = "fBodyBodyGyroMag-mean()",
                                    "V530" = "fBodyBodyGyroMag-std()",
                                    "V539" = "fBodyBodyGyroMag-meanFreq()",
                                    "V542" = "fBodyBodyGyroJerkMag-mean()",
                                    "V543" = "fBodyBodyGyroJerkMag-std()",
                                    "V552" = "fBodyBodyGyroJerkMag-meanFreq()",
                                    "V555" = "angle(tBodyAccMean,gravity)",
                                    "V556" = "angle(tBodyAccJerkMean),gravityMean)",
                                    "V557" = "angle(tBodyGyroMean,gravityMean)",
                                    "V558" = "angle(tBodyGyroJerkMean,gravityMean)",
                                    "V559" = "angle(X,gravityMean)",
                                    "V560" = "angle(Y,gravityMean)",
                                    "V561" = "angle(Z,gravityMean)",
                                    "V1.1" = "activitylables",
                                    "activities" = "activitynames"
                                      ))

# Use SQL commands to calcuate average values
avedata <- sqldf('select subjectid,activitynames,avg("tBodyAcc-mean()-X"),avg("tBodyAcc-mean()-Y"),avg("tBodyAcc-mean()-Z"),avg("tBodyAcc-std()-Z"),avg("tGravityAcc-mean()-X"),avg("tGravityAcc-mean()-Y"),avg("tGravityAcc-mean()-Z"),avg( "tGravityAcc-std()-X"),avg("tGravityAcc-std()-Y"),avg("tGravityAcc-std()-Z"),avg("tBodyAccJerk-mean()-X"),avg( "tBodyAccJerk-mean()-Y"),avg( "tBodyAccJerk-mean()-Z"),avg( "tBodyAccJerk-std()-X"  ),avg("tBodyAccJerk-std()-Y"),avg( "tBodyAccJerk-std()-Z"),avg( "tBodyGyro-mean()-X"),avg( "tBodyGyro-mean()-Y"  ),avg("tBodyGyro-mean()-Z"),avg("tBodyGyro-std()-X"),avg( "tBodyGyro-std()-Y"),avg( "tBodyGyro-std()-Z"),avg( "tBodyGyroJerk-mean()-X" ),avg( "tBodyGyroJerk-mean()-Y"),avg( "tBodyGyroJerk-mean()-Z"),avg("tBodyGyroJerk-std()-X"),avg("tBodyGyroJerk-std()-Y"),avg( "tBodyGyroJerk-std()-Z"  ),avg("tBodyAccMag-mean()" ),avg(  "tBodyAccMag-std()"),avg( "tGravityAccMag-mean()" ),avg(  "tGravityAccMag-std()"),avg( "tBodyAccJerkMag-mean()"),avg( "tBodyAccJerkMag-std()"),avg( "tBodyGyroMag-mean()"  ),avg("tBodyGyroMag-std()"),avg( "tBodyGyroJerkMag-mean()"),avg( "tBodyGyroJerkMag-std()"),avg("fBodyAcc-mean()-X" ),avg( "fBodyAcc-mean()-Y"),avg( "fBodyAcc-mean()-Z" ),avg("fBodyAcc-std()-X"  ),avg( "fBodyAcc-std()-Y"  ),avg( "fBodyAcc-std()-Z"  ),avg("fBodyAcc-meanFreq()-X"),avg( "fBodyAcc-meanFreq()-Y"),avg( "fBodyAcc-meanFreq()-Z"),avg("fBodyAccJerk-mean()-X" ),avg( "fBodyAccJerk-mean()-Y"),avg( "fBodyAccJerk-mean()-Z"),avg("fBodyAccJerk-std()-X"),avg( "fBodyAccJerk-std()-Y"),avg( "fBodyAccJerk-std()-Z" ),avg("fBodyAccJerk-meanFreq()-X"),avg( "fBodyAccJerk-meanFreq()-Y"  ),avg( "fBodyAccJerk-meanFreq()-Z"  ),avg("fBodyGyro-mean()-X"),avg( "fBodyGyro-mean()-Y"  ),avg( "fBodyGyro-mean()-Z"),avg("fBodyGyro-std()-X"),avg( "fBodyGyro-std()-Y"),avg( "fBodyGyro-std()-Z" ),avg("fBodyGyro-meanFreq()-X"),avg( "fBodyGyro-meanFreq()-Y"  ),avg( "fBodyGyro-meanFreq()-Z"  ),avg("fBodyAccMag-mean()"),avg( "fBodyAccMag-std()"),avg( "fBodyAccMag-meanFreq()"  ),avg("fBodyBodyAccJerkMag-mean()"),avg( "fBodyBodyAccJerkMag-std()"  ),avg( "fBodyBodyAccJerkMag-meanFreq()"),avg( "fBodyBodyGyroMag-mean()"),avg( "fBodyBodyGyroMag-std()"  ),avg( "fBodyBodyGyroMag-meanFreq()" ),avg("fBodyBodyGyroJerkMag-mean()"),avg( "fBodyBodyGyroJerkMag-std()" ),avg( "fBodyBodyGyroJerkMag-meanFreq()" ),avg(  "angle(tBodyAccMean),avg(gravity)"),avg( "angle(tBodyAccJerkMean,gravityMean)"),avg( "angle(tBodyGyroMean,gravityMean)" ),avg( "angle(tBodyGyroJerkMean,gravityMean)"),avg( "angle(X,gravityMean)"  ),avg("angle(Y,gravityMean)" ),avg("angle(Z,gravityMean)") from descrdata group by subjectid, activitynames')






