library(magrittr)
library(dplyr)

#Creates directory data in the default working 
#directory and set it as the working directory and cleans the working space 
if(!file.exists("./data")){dir.create("./data")}
path="./data"
setwd(path)
rm(list = (ls()))

#Source the data. Downloads a zip file 
#Then unzips the folder
#Then cleans unnecasary objects
URL1='https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(URL1,destfile = 'Project.zip')
rm('URL1')
unzip("Project.zip")

#This loads all necassary data into R from the unziped folder
activity_lables.txt=read.table("UCI HAR Dataset/activity_labels.txt")

features.txt=read.table("UCI HAR Dataset/features.txt")

subject_test.txt=read.table("UCI HAR Dataset/test/subject_test.txt")

X_test.txt=read.table("UCI HAR Dataset/test/X_test.txt")
y_test.txt=read.table("UCI HAR Dataset/test/y_test.txt")

subject_train.txt=read.table("UCI HAR Dataset/train/subject_train.txt")

X_train.txt=read.table("UCI HAR Dataset/train/X_train.txt")
y_train.txt=read.table("UCI HAR Dataset/train/y_train.txt")

#This joins the subject, activitynumber and the observations for the variables
#This adds variables names to the set
#This joins the test and train sets
#It also adds the activity description
test=cbind(subject_test.txt,y_test.txt,X_test.txt)
train=cbind(subject_train.txt,y_train.txt,X_train.txt)

names(test)[1:2]=c("subject","activitynumber")
names(test)[3:ncol(test)]=as.character(features.txt$V2)
names(train)[1:2]=c("subject","activitynumber")
names(train)[3:ncol(train)]=as.character(features.txt$V2)

data=rbind(test,train)

data2=merge(x=activity_lables.txt,y=data,by.x='V1',by.y='activitynumber',all=FALSE)
names(data2)[1:2]=c("activitynumber","activity")

#Some useful views
#table(data$activity,data$subject)
#table(data$activity)
#table(data$subject)

#Cleans up the workspace
rm( activity_lables.txt, features.txt, subject_test.txt
    ,subject_train.txt, test, train, X_test.txt, X_train.txt
    ,y_test.txt, y_train.txt)

#Checking the number of variables that are mean and std of the variables
#length(names(data)[grepl('mean\\()',names(data)) | grepl('std\\()',names(data)) ])

#Selecting only the subject and activity and those variables that are mean and std 
#Some cleaning is done on the names of variables
#further cleaning was found to be impractical making them longer than practical
#cleans the workspace

data3=cbind(data2[,2:3],data2[,grepl('mean\\()',names(data2)) | grepl('std\\()',names(data2))])
rm(data,data2)
strName=names(data3)
strName2=gsub('^t','time',strName)
strName3=gsub('^f','frequency',strName2)
strName4=tolower(strName3)
strName5=gsub('-','',strName4)
strName6=gsub('\\()','',strName5)
names(data3)=strName6
rm(strName,strName2,strName3,strName4,strName5,strName6)

#Creates a new tidy data set that calculates means for each variable by subject and activity 
data4=aggregate(data3[c(-1,-2)],list(data3$activity,data3$subject),mean)
names(data4)[1:2]=c("activity","subject")
#xxx=data3%>%group_by(subject,activity)%>%summarise_all(funs(mean))
#xxx2=as.data.frame(xxx[,c(2,1,3:68)])

#identical(xxx2,data4)

#table(data3$activity,data3$subject)
#table(data4$activity,data4$subject)

#writes the two data sets out as .csv files and cleans workspace
#write.csv(data3,file='CleanData1.csv', row.names = FALSE)
#write.csv(data4,file='CleanData2.csv', row.names = FALSE)

#writes the second dataset out as prescribed
write.table(data4,file = 'CleanData2V2.txt',row.names = FALSE)

rm(data3,data4)
rm(xxx,xxx2)

