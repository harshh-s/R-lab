#RANDOM FOREST USING R

#installing packages
install.packages("randomForest")
library(randomForest)
install.packages("caTools")
library(caTools)

#reading dataset
data <- read.csv("processed.cleveland.data", header=FALSE)
head(data)

#EDA

dim(data)
#We can see that there are 303 rows and 14 columns.

#Renaming columns
names(data) <- c("age", "sex", "cp", "trestbps", "choi", "fbs", "restecg",
                 "thalach", "exang", "oldpeak", "slope", "ca", "thai", "num")

#The num column contains diagnosis of heart disease. 0 means no presence of
#disease and other integer means presence. So we replace values greater than 1
#with 1.
data$num[data$num > 1] <- 1

#Data summary
summary(data)
#Since we are getting lost of values as 0, which means there is a problem with
#the data type of the columns.
sapply(data, class)
#We can see that columns are considered wrong, like sex is considered as
#numeric, but its actually categorical. So we rectify those.
data <- transform(
  data,
  age=as.integer(age),
  sex=as.factor(sex),
  cp=as.factor(cp),
  trestbps=as.integer(trestbps),
  choi=as.integer(choi),
  fbs=as.factor(fbs),
  restecg=as.factor(restecg),
  thalach=as.integer(thalach),
  exang=as.factor(exang),
  oldpeak=as.numeric(oldpeak),
  slope=as.factor(slope),
  ca=as.factor(ca),
  thai=as.factor(thai),
  num=as.factor(num)
)
#Now see the classes again
sapply(data, class)
#Now that we have rectified the column types, let's see the summary again
summary(data)

#We can notice a strange "?" in category values for "ca" and "thai". Which
#implies missing values. So we replace them with NA first and then see number of
#missing values.
data[ data == "?"] <- NA
colSums(is.na(data))
#The number showed after "?" under summary result shows the count of "?".
#The colSums() shows sum of total missing values.

#We will replace missing values for thai and drop rows with missing values in ca.
data$thai[which(is.na(data$thai))] <- as.factor("3.0")
data <- data[!(data$ca %in% c(NA)),]
colSums(is.na(data))
#Now we can see there are no null values.

summary(data)
#It still shows "?" as a value. So we cast it to factors.

data$ca <- factor(data$ca)
data$thai <- factor(data$thai)
summary(data)

#Splitting data set for training and testing
sample = sample.split(data$num, SplitRatio=.75)
train = subset(data, sample==TRUE)
test = subset(data, sample==FALSE)
dim(train)
dim(test)

#Using randomForest
model <- randomForest(num ~ ., data=train)
#In this, the default number of trees is 500 and 3 features are the potential
#candidates for the split.
model

model1 <- randomForest(num ~ ., data=train, ntree=1000)
#Here, number of trees is specified as 200.
model1

#Predicting whether people in testing set has the disease
predicted = predict(model, newdata=test[-14])
predicted

#This being a classification problem, we use confusion matrix to evaluate
#the model.
mat = table(test[,14], predicted)
mat
#With the result, we can see that 34 predictions for the people not having
#disease was correct and 26 for the people having disease were correct.