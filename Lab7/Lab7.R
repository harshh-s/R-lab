#1.Download the dataset boston.csv
boston <- read.csv("/cloud/project/boston.csv")
summary(boston)

#Null Values
any(is.na(boston))

#2.MEDV is the output /target variable i.e price of the house to be predicted
x <- subset(boston, select=-c(MEDV))
head(x)
y <- subset(boston, select=c(MEDV))
head(y)

#3. Using the plot commands, plot the latitude and longitude of each of our
#census tracts
scatter.smooth(x$LON, x$LAT, main="Census Tracts", xlab="Longitude",
               ylab="Latitude")

#4. Show all the points that lie along the Charles River in a blue colour.
points(boston$LON[boston$CHAS==1], boston$LAT[boston$CHAS==1], col="blue",
       pch=10)

#5.Apply Linear Regression by plotting the relationship between latitude and
#house prices and the longitude and the house prices.
plot(boston$LAT, boston$MEDV, main="Latitude vs. Price", xlab="Latitude", ylab="Price")
plot(boston$LON, boston$MEDV, main="Longitude vs. Price", xlab="Longitude", ylab="Price")
lmmodel <- lm(MEDV ~ LAT+LON, data=boston)
summary(lmmodel)
#R squared is 0.1, which is bad
#The latitude is not significant, which means the north-south location
#differences aren’t going to be really used at all. This also seems unlikely.

#Longitude is significant, but negative which means that as we go towards the
#east house prices decrease linearly, which is also unlikely.

#6.Apply Regression Tree to the problem and draw conclusions from it.
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)
tree = rpart(MEDV ~ LAT + LON + CRIM + ZN + INDUS + CHAS + NOX + RM + AGE + DIS + RAD + TAX + PTRATIO, data=boston)
prp(tree)
#We can say that the latitude and longitude arent really important. Rooms are
#the most important. Pollution appears in there twice, so it’s, in some sense,
#nonlinear on the amount of pollution i.e if it’s greater than a certain amount
#or less than a certain amount, it does different things. Very nonlinear on the
#number of rooms.