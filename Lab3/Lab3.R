#1. Reading file
install.packages("readxl")
library("readxl")
fl <- read_excel("lungcap.xlsx")
print(fl)

#2. Find the class and typeof Age and Height
class(fl$Age)
typeof(fl$Age)
class(fl$Height)
typeof(fl$Height)

#3. Find the summary of the dataset
summary(fl)

#4. Find the strength of the relationship between Age and Height
cor(fl$Age, fl$Height)

#5. Perform a scatter plot for the above (Qn.4)
x <- fl$Age
y <- fl$Height
plot(x, y)

#6. Add a title to the plot and Label  x-axis and y-axis
plot(x, y, xlab="Age", ylab="Height", main="Age vs Height Correlation")

#7. Rotate the values on the y-axis and also change the limits of x-axis and y-axis
install.packages("ggplot2")
library(ggplot2)
fig = ggplot(fl, aes(Age, y=Height))
fig+ggtitle("Age vs Height Correlation")+theme(axis.text.y=element_text(angle=45))+geom_point()

#8. Remove the axes of the plot and relabel these axes
fig+ggtitle("Age vs Height Correlation")+theme(axis.title.x=element_blank(), axis.title.y=element_blank())+geom_point()

#9. Change the size of the plotting characters
plot(x, y, xlab="Age", ylab="Height", main="Age vs Height Correlation", xlim=c(2,20), ylim=c(45, 82), cex=0.5)

#10. Change the color of the characters to red
plot(x, y, xlab="Age", ylab="Height", main="Age vs Height Correlation", xlim=c(2,20), ylim=c(45, 82), cex=0.5, col="red")

#11. Draw the regression line to the plot predicting height using age
fig+ggtitle("Age vs Height Correlation")+labs(x="Person's Age", y="Person's Weight")+geom_point()+geom_smooth(method=lm)

#12. Change the color of the line to blue and the width of the line
fig+ggtitle("Age vs Height Correlation")+labs(x="Person's Age", y="Person's Weight")+geom_point()+geom_smooth(method=lm, colour="blue", size=3)

#13. Change the font of the plotting characters
fig+ggtitle("Age vs Height Correlation")+labs(x="Person's Age", y="Person's Weight")+geom_point(shape=4)+geom_smooth(method=lm, colour="blue", size=3)

#14. Change the color of the plotting characters
fig+ggtitle("Age vs Height Correlation")+labs(x="Person's Age", y="Person's Weight")+geom_point(shape=4, colour="green")+geom_smooth(method=lm, colour="blue", size=3)

#15. Identify gender on the plot for the age male and female
ggplot(fl, aes(Age, y=Height, colour=factor(Gender)))+ggtitle("Age vs Height Correlation")+labs(x="Person's Age", y="Person's Weight")+geom_point(shape=4)+geom_smooth(method=lm, colour="black", size=0.5)