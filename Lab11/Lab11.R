#pseudorandom number generator
set.seed(11)

# Attach Packages
library(tidyverse)    # data manipulation and visualization
library(kernlab)      # SVM methodology
library(e1071)        # SVM methodology
library(ISLR)         # contains example data set "Khan"
library(RColorBrewer) # customized coloring of plots
library(caret)

#Read file
fl <- read.csv("heart.csv")
head(fl)

#Data structure
str(fl)

#Summary
summary(fl)

#Empty values
colSums(fl==" ")
#So there are no empty values

#Null values
colSums(is.na(fl))
#So there are no null values

#MODEL BUILDING
#Split dataset into train and test
index <- sample(1:nrow(fl), 0.75*nrow(fl))
train <- fl[index,]
test <- fl[-index,]

#Convert target into factor
train$target <- as.factor(train$target)
test$target <- as.factor(test$target)

training <- trainControl(method="repeatedcv", number=10, repeats=3)

grid <- expand.grid(C=c(0.01, 0.05, 0.1, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2, 5))
svmgrid <- train(target~., data=train, method="svmLinear", trControl=training, preProcess=c("center", "scale"), tuneGrid=grid, tuneLength=70)

svmgrid

#Training with gamma=0.2 and cost=0.25
m1 <- svm(target~., data=train, kernel="linear", gamma=0.2, cost=0.25)
m1

#Training with gamma=0.5 and cost=0.05
m2 <- svm(target~., data=train, kernel="linear", gamma=0.5, cost=0.05)
m2

#Test with gamma=0.2 and cost=0.25
pred1 <- predict(m1, newdata=test)
confusionMatrix(pred1, test$target)

#Test with gamma=0.5 and cost=0.05
pred2 <- predict(m2, newdata=test)
confusionMatrix(pred2, test$target)

#We trained two different models with two sets of gamma and cost values.
#Upon evaluating the model, we see that model 2 yeilds better accuracy of 84%,
#than model 1, which is 82%.
