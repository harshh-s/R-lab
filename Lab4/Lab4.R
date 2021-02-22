#1. Read dataset
data <- read.csv('marketing.csv')
print(data)

#2. Use Scatter Plot to visualize the Relationship
scatter.smooth(x=data$Spend, y=data$Sales, main="Sales~Spend", xlab="Spend", ylab="Sales")
#With the scatter plot, we can easily see that the data has a positive strong correlation.


#3. Using BoxPlot to check for Outliers
boxplot(data$Spend, main="Outliers in Spend")
boxplot(data$Sales, main="Outliers in Sales")
#There are no outliers in either of the columns as there are no data point outside the plot range.


#4. Using Density Plot To Check If Response Variable Is Close To Normal
library(e1071)
par(mfrow=c(1, 2))
plot(density(data$Spend), main="Density : Spend", xlab="Spend", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(data$Spend),2)))
polygon(density(data$Spend), col="blue")
plot(density(data$Sales), main="Density : Spend", xlab="Sales", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(data$Sales),2)))
polygon(density(data$Sales), col="green")

#5. Check the Correlation Analysis
cor(data$Spend, data$Sales)
#Since the correlation of the two variables is above 0.99, approx 1, we can say that they have a strong positive correlation.

#6. Build the Linear Regression Model
model <- lm(Sales~Spend, data=data)

#7. Using p-value Check For Statistical Significance
modelsummary <- summary(model)
modelcoeffs <- modelsummary$coefficients
est <- modelcoeffs['Spend', 'Estimate']
stderr <- modelcoeffs['Spend', 'Std. Error']
tval <- est/stderr
pval <- 2*pt(-abs(tval), df=length(data$Sales)-1)
print(paste("p-value:", pval))

#8. Capture the summary of the linear model
modelsummary

#9. Also perform the Linear Diagnostics for the given data set(Hint: plot(lmmodel))
plot(model)

#10. Create the training and test data (70:30)
set.seed(11)
indexes = sample(nrow(data), nrow(data)*.7)
train <- data[indexes,]
test <- data[-indexes,]

#11. Fit the model on training data and predict sales on test data
model <- lm(Sales~Spend, data=train)
predict(model)
#We can see the values predicted by the model. On comparing a value at an index with the observed value, we can see the difference.


#12. Review the diagnostic measures
plot(model)