# The below line can be typed on the console to clear all plots.
dev.off(dev.list()["RStudioGD"])

N = 100 # Number of training data points

x = seq(0,1, length = N)

y = sin(2*pi*x)

noise = y + rnorm(N, sd = 0.3)

plot(x, noise, pch = 19)

lm1 <- lm(y~x)

summary(lm1)

lm2 <- lm(y~poly(x,2))
lm3 <- lm(y~poly(x,3))
lm4 <- lm(y~poly(x,4))
lm5 <- lm(y~poly(x,5))
lm6 <- lm(y~poly(x,6))
lm7 <- lm(y~poly(x,7))
lm8 <- lm(y~poly(x,8))
lm9 <- lm(y~poly(x,9))


xplot = seq(0, 1, length = 25)

# In the below lineS change the model according to the 
# polynomial fit you want to work with.

lines(xplot, predict(lm6, newdata=data.frame(x=xplot)), col = 'blue')

lms = list(lm1, lm2, lm3, lm4, lm5, lm6, lm7, lm8, lm9)

train = test = rep(0, 9) #Gives a vector of 10 zeros.


#Evaluating training error by finding variance using residuals.
#Residuals refer to difference between predicted and observed values.
for(i in 1:9){
  
  train[i] = var(lms[i][[1]]$residuals)
  
}

newy = sin(2*pi*x) + rnorm(N, sd=.3)


# Obtaining test error by finding variance.
for (j in 1:9) {
  
  test[j] = (1/10)*sum((newy - predict(lms[j][[1]], newdata=data.frame(x)))^2)
    
}

plot(1:9, train,  xlab = 'Order of Polynomial' , ylab = 'Error - Test and Training', ylim = c(0,3))
lines(1:9, train, col = 'black', lwd = 3)
lines(1:9, test, pch='19', col = 'red', lwd = 3)
cbind(train, test)


summary(lm1)

C1 <- coef(lm1)
C2 <- coef(lm2)


#Find out the maximum length of each coefficient list.
max_length <- max(c(length(C1), length(C2)))


# Build dataset setting the coefficient values for lower order models as NA.
data <- data.frame(col1 = c(C1, rep(NA, max_length - length(C1))),
                   col2 = c(C2, rep(NA, max_length - length(C2))))


data

#Regularization

#Run the line below to install the glmnet package.
# install.packages("glmnet", repos = "https://cran.us.r-project.org")

library(glmnet)

lambdas <- 10^seq(3, -2, by = -.1)
lambdas

x = matrix(seq(0,1, length = N))
y = matrix(sin(2*pi*x))

x = cbind(x, rep(1, N))

fit <- glmnet(x, y, alpha = 0, lambda = lambdas)
summary(fit)

##EXERCISE##





