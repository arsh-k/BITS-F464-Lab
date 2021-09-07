x <- 'Hello world!'
x

x <- c(0, 1.2, 8/5)
y <- 1:10
z <- rep(10, times = 2) 
a <- sample(c(2, 5, 3), size = 4, replace = TRUE)

is.vector(a)

a <- 1:4
b <- 123:126
c <- 12:14
d <- 98:101

d[1 : 3] <- c

mat <- matrix(1:12, nrow = 3, ncol = 4) #fills numbers in matrix 
#column by columm

mat <- rbind(mat, c(1, 2, 3, 4))
mat <- cbind(mat, c(1, 2, 3, 4))

a <- matrix(1:4, nrow = 2, ncol = 2)
b <- matrix(1:4, nrow = 2, ncol = 2)

#Basically, the indexing in a matrix is just like that in a vector with individual controllers
#for row and column

for(i  in 1:10) {
  print(i)
}

Vect01 <- c(10, 12, 14, 44, 43, 21, 21)

for(i in Vect01){
  print(i)
}


data("mtcars")
head(mtcars, 6)


