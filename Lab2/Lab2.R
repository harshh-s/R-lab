#1. Create a vector different data types(Logical, Numeric, Integer,
#Complex, Character) and display their class and type of each datatype.
a <- 50
typeof(a)
class(a)
a <- 50L
typeof(a)
class(a)
a <- "Harsh"
typeof(a)
class(a)
a <- 'A'
typeof(a)
class(a)
a <- 5i+6
typeof(a)
class(a)


#2. Get and print the current working directory
getwd()


#3. Dataframes
#Done.


#4. Save file in current working directory
#Done.


#5. Read the csv file in your current working directory
data <- read.csv('students.csv')
print(data)


#6. Check whether your  CSV file is a dataframe and also check the
#number of rows and columns
class(data)
print(paste("Number of rows: ", dim(data)[1]))
print(paste("Number of columns: ", dim(data)[2]))


#7. Apply all the functions sum(),mean(),sqrt()  related to dataframe
print(paste('Sum of marks: ', sum(data['Total.marks'])))
print(paste('Average of marks: ', mean(data['Total.marks'])))
print(paste('Square root of marks: ', sqrt(data['Total.marks'])))


#8. Get the highest marks from the data frame
print(paste("Highest marks from dataframe: ", max(data["Total.marks"])))


#9. Get the details of the person with highest marks
data[data["Total.marks"]==max(data["Total.marks"])]


#10. Get all the students in UG degree whose marks is greater than 300
data[data["Degree"]=="UG" & data["Total.marks"]>300,]


#11. Add one more vector  Date_ of_ Joining(DOJ) to the already
#existing dataframe 
data=cbind(data, date_of_joining = as.Date(c("2003-10-24","2018-10-24","2004-10-24","2005-10-24","2019-10-24","2017-10-24","2005-10-24","2007-10-24")))
data
class(data$date_of_joining)


#12. Get the details of the students who have joined after 2017
datefilter = data[data$date_of_joining>"2017-01-01",]
datefilter

#13. Write the filtered data into a new file
write.table(datefilter, "filtered.txt", sep=",", row.names=TRUE, col.names=NA)
