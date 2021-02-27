#1.Load mtcars dataset
data(mtcars)
head(mtcars)

#2.Install ridge and glmnet packages
install.packages("glmnet", dependencies=TRUE)
library(glmnet)
install.packages("ridge")
library(ridge)

#3.Perform the exploratory data analysis
dim(mtcars)
#We can see that there are 32 rows and 11 columns

class(mtcars)
#We can say that the mtcars is a dataframe

str(mtcars)
#As we can see, most the columns are all numerical

sum(is.na(mtcars))
#We can conclude that there is no null value in the dataset

summary(mtcars)
#Central Tendency and other statistical measures of the dataset columns

install.packages("ggplot2")
library(ggplot2)
ggplot(stack(mtcars), aes(x =ind, y =values)) + geom_boxplot()
#We can say that there are outliers in few columns like horsepower, mpg, etc.

install.packages("Hmisc")
library(Hmisc)
hist.data.frame(mtcars)
#We can infer that a few columns are normally distributed while some are not

#4.Choose optimum lamba value
#Predictor variables
x <- data.matrix(mtcars[, c("hp", "wt", "drat")])
#Target variable
y <- mtcars[, "mpg"]

lamb <- 10^seq(2, -2, by = -.1)
# Using glmnet function to build the ridge regression in r
fit <- glmnet(x, y, alpha = 0, lambda  = lamb)
summary(fit)

#Using cross validation glmnet
ridge_cv <- cv.glmnet(x, y, alpha = 0, lambda = lamb)
# Best lambda value
opt_lamb <- ridge_cv$lambda.min
opt_lamb
#The optimal value of lambda is 0.7943282.

#5.Extract the model using k-cross validation
extracted_model <- ridge_cv$glmnet.fit
extracted_model

#6.Build the final model and interpret
final_mod <- glmnet(x, y, alpha = 0, lambda = 0.5011872)
coef(final_mod)
#These are the intercept and coefficients of the model.