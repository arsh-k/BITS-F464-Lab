# Polynomial Kernels in SVM are adjusted by the parameter 'degree'

# Radial Kernels in SVM are adjusted by the parameter 'gamma'

library(e1071)

data(iris)

iris[,-5]

# The function princomp() uses the spectral decomposition approach. 
# The functions prcomp() and PCA()[FactoMineR] use the singular value 
# decomposition (SVD). According to the R help, SVD has slightly better 
# numerical accuracy. Therefore, the function prcomp() is preferred compared 
# to princomp().


#center and scale attributes are used for mean normalization.

pc_iris_data <- prcomp(iris[, -5], center = T, scale = T)

pc1 = data.frame(pc_iris_data$x[,1])
pc2 = data.frame(pc_iris_data$x[,2])

#data split into train and test

#replace = TRUE and prob = c() determines the probability value of that value 
#appearing in the nth row. 
ind = sample(2, nrow(pc1), replace = TRUE, prob = c(0.8, 0.2))

traindata1 = pc1[ind == 1, ]
traindata2 = pc2[ind == 1, ]

train_class = data.frame(iris[ind ==1, 5])
testdata1 = pc1[ind == 2,]
testdata2 = pc2[ind == 2, ]

test_class = data.frame(iris[ind == 2, 5])

data = data.frame(class = unlist(train_class), x = unlist(traindata1), 
                  y = unlist(traindata2))

# Creating SVM models for radial, polynomial and sigmoid kernel functions.

# Radial Basis Function (RBF) Kernel

model_rbf = svm(class ~ x + y, data = data,
                kernel = 'radial')
summary(model_rbf)

plot(model_rbf, data)

# Polynomial Kernel

model_poly = svm(class ~ x + y, data = data,
                 kernel = 'polynomial', degree = 3) #Degree 3 polynomials fit the dataset best.

summary(model_poly)

plot(model_poly, data)


# Sigmoid Kernel 

model_sigmoid = svm(class ~ x + y, data = data, 
                    kernel ='sigmoid')

summary(model_sigmoid, data)

plot(model_sigmoid, data)

data_test = data.frame(x = unlist(testdata1), 
                       y = unlist(testdata2))


# Making predictions using each model to evaluate accuracy.

pred_rbf = predict(model_rbf, data_test)
pred_poly = predict(model_poly, data_test)
pred_sigmoid = predict(model_sigmoid, data_test)





