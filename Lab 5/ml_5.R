# We create our own data.
set.seed(1)

x = matrix(rnorm(20*2), ncol = 2)

y <- c(rep(-1, 10), rep(1, 10))

x[y == 1, ] = x[y==1, ] + 1

#Col attribute here allows us to separate the data on the plot based on the y value.
plot(x, col = (3-y))

library(e1071)

#Factors are variables in R which take on a limited number of different values; such variables are often referred to as categorical variables.
data = data.frame(x=x, y = as.factor(y))

### LINEAR SVM ###

svm.fit = svm(y ~ ., data = data, kernel = 'linear', cost = 10, scale = FALSE)

#color.palette will make the SVM plot look neat.
plot(svm.fit, data, color.palette = rainbow)

#Summary of the SVM Model
summary(svm.fit)

#Changing the cost parameter.
svm.fit2 = svm(y ~ ., data = data, kernel = 'linear', cost = 0.1, scale = FALSE)
plot(svm.fit2, data, color.palette = rainbow)

summary(svm.fit2)

#Cost effect on margin
set.seed(1)
tune.out <- tune(svm, y ~ ., data = data, kernel = 'linear',
                 ranges = list(cost = c(0.001, 0.01, 0.1, 1, 5, 10 ,100)))

summary(tune.out)

#Simulating another test dataset
set.seed(2)

xtest = matrix(rnorm(20*2), ncol = 2)

ytest <- c(rep(-1, 10), rep(1, 10))

xtest[ytest == 1, ] = x[ytest ==1, ] + 1

testdata = data.frame(x=xtest, y=as.factor(ytest))

#Prediction on the test data
yhat = predict(tune.out$best.model, testdata)

#Install caret :)
library(caret)

confusionMatrix(yhat, testdata$y)

### NON LINEAR SVM ###

#Generating data once again.

set.seed (1)
x <- matrix(rnorm(200*2), ncol=2)

x[1:100,] = x[1:100,]+2
x[101:150,] = x[101:150,]-2

y <- c(rep(1,150),rep(2,50))
data <- data.frame(x=x,y=as.factor(y))
plot(x, col=y)

train <- sample(200,100)
svm.fit = svm(y ~., data= data[train,], kernel = 'radial', gamma = 1, cost = 1)

plot(svm.fit, data[train, ], color.palette = rainbow)

summary(svm.fit)

yhat = predict(svm.fit, data[-train, ])
confusionMatrix(yhat, data[-train, 'y'])

#Reducing the cost, overfits the data. It will reduce training error but increases the generalization error.
svm.fit2 = svm(y ~., data[train, ], kernel = 'radial', gamma = 1, cost = 1e-1) 
plot(svm.fit2, data[train, ], color.palette = rainbow)

#Tuning the model for best cost.
set.seed(1)

tune.out <- tune(svm, y ~., data=dat[train,],
                 kernel='radial',
                 ranges = list(cost=c(0.1,1,10,100,1000),
                               gamma=c(0.5, 1,2,3,4)))

# Best parameters turn out to be gamma = 0.5, cost = 1.
summary(tune.out)

yhat <- predict(tune.out$best.model, dat[-train,])
confusionMatrix(yhat, dat[-train, 'y'])

### ROC Curves ###

library(ROCR)












