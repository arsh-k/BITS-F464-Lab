dev.off(dev.list()["RStudioGD"])
rm(list=ls())
shell('cls')

library(ISLR)
library(rpart)
library(rpart.plot)

#summary(Carseats)

Carseats

#parms = 'information'

hist(Carseats$Sales)

High = ifelse(Carseats$Sales<=8, 'No', 'Yes')

carseats = data.frame(Carseats, High)

# Used to remove Sales from being used in the dataset.
# Here High is our dependent variable.
tree.carseats = rpart(High~.-Sales, data = carseats)

summary(tree.carseats)

# The below method is a horrible way to visualize the R plot.
plot(tree.carseats, uniform = TRUE)
text(tree.carseats, pretty = 1)

# Much better
rpart.plot(tree.carseats, box.palette = 'RdBu', shadow.col = 'gray', nn = TRUE)

printcp(tree.carseats)
plotcp(tree.carseats)

#Prepruning

preprune_tree.carseats = rpart(High~. -Sales, method = 'class', control =
                              rpart.control(cp = 0, maxdepth = 8, minsplit = 100),
                              data = carseats)

rpart.plot(preprune_tree.carseats, box.palette = 'RdBu', shadow.col = 'gray', nn = TRUE)

postprune_tree.carseats = prune(tree.carseats, cp = 0.01)



# Working on train-test split data
sample_ind <- sample(nrow(carseats), nrow(carseats)*0.7)

train <- carseats[sample_ind, ]

#Selects everything but what is present in sample_ind
test <- carseats[-sample_ind, ]


#Training the model on the train data
tree.carseats_train = rpart(High~.-Sales, data = carseats)
plotcp(tree.carseats_train)


# Training pre-puning models on train data
preprune_tree.carseats_train = rpart(High~. -Sales, method = 'class', control =
                                 rpart.control(cp = 0, maxdepth = 10, minsplit = 50),
                               data = train)

test$pred = predict(preprune_tree.carseats_train, test, type = 'class')

#Prepuned model accuracy
accuracy_preprune = mean(test$pred == test$High)

plotcp(preprune_tree.carseats_train)


#Post pruning
pruned_tree = prune(tree.carseats_train, cp = 0.01)

test$pred_prune = predict(pruned_tree, test, type = 'class')

accuray_postprune = mean(test$pred_prune == test$High)

accuray_postprune

#Accuracy of post-pruned model is higher :)




