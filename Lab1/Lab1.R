#Q1
myobject <- 1:10
myobject

myobject <- c(1:10)
myobject

myobject <- seq(from=1, to=10, by=1)
myobject

#Q2
sum(myobject)

#Q3
a <- paste("R is great", 4, "and I will love it")
a

b <- paste("R is great", 7, "and I will love it")
b

c <- paste("R is great", 45, "and I will love it")
c

#Q4
a <- rep(c(1, 2, 3), times=c(11, 10, 10))
a

#Q5
a[7]

#Q6
replicate(3, "Hello R")

#Q7
a <- rep(c('A', 'B'), times=c(2, 3))
a

#Q8
matrix(1:6, nrow=2, ncol=3)

#Q9
matrix(1:9, nrow=3, ncol=3, byrow=TRUE)

#10
randomvector <- sample(1:20, size = 15)
randomvector

min(randomvector)
max(randomvector)
range(randomvector)
length(randomvector)
sum(randomvector)
prod(randomvector)
mean(randomvector)
var(randomvector)