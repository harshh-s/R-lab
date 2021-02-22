#1.Install the package “titanic”
install.packages("titanic")

#2.Load Titanic library to get the dataset
train <- read.csv("~/R/x86_64-pc-linux-gnu-library/4.0/titanic/data-raw/train.csv")
#View(train)
test <- read.csv("~/R/x86_64-pc-linux-gnu-library/4.0/titanic/data-raw/test.csv")
#View(test)

#3. Set Survived column for test data to NA
test$Survived <- NA

#4. Combine the  Training and Testing dataset
dataset <- rbind(train, test)
#View(dataset)

#5.Get the data structure
class(dataset)
dim(dataset)

#6. Check for any missing values in the data
print("Null values in each column:")
sapply(dataset, function(x) sum(is.na(x)))
print("Summary of null values")
table(is.na(dataset))

#7.Check for any empty values
sum(dataset=="")

#8.Check number of unique values for each column to find out which column we
#can convert to factors
sapply(dataset, function(x) length(unique(x)))

#9.Remove Cabin as it has very high missing values, passengerId, Ticket and
#Name are not required
ds <- subset(dataset, select=-c(PassengerId, Cabin, Ticket, Name))

#10.Convert "Survived","Pclass","Sex","Embarked" to factors
ds$Survived <- as.factor(ds$Survived)
ds$Pclass <- as.factor(ds$Pclass)
ds$Sex <- as.factor(ds$Sex)
ds$Embarked <- as.factor(ds$Embarked)

#11.Splitting training and test data
set = sort(sample(nrow(ds), nrow(ds)*.7))
train = ds[set,]
test = ds[-set,]

#12.Create a model
lmodel <- glm(Survived ~ Age+Sex+Pclass+Fare+Embarked+SibSp+Parch, data=ds,
              family="binomial")

#13.Visualize the model summary
summary(lmodel)

#14.Analyse the test of deviance using anova()
anova(lmodel, test="Chisq")