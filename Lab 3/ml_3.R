shell('cls')

head(mtcars)

### PRINCIPAL COMPONENT ANALYSIS ###

d01 <- mtcars[, c(1:7,10,11)]

d01

plot(d01)


#cor = TRUE indicates that the principal component is calculated with the help 
#of a correlation matrix. scores = TRUE evaluates scores associated to pca value.
d01.pca <- princomp(d01, cor = TRUE, scores = TRUE)

summary(d01.pca)

plot(d01.pca)

#The pdf incorrectly states the proportion of variance captured by each component.

#Scree Plot diagram
#Allows us to see which Component Captures maximum variance in the data.
plot(d01.pca, type='l')


# Describes how individual attributes contribute to the 
# components.
d01.pca$loadings

d02 <- d01.pca$scores

#Gives us the dataset with the transformed principal components.
head(d02)


### SINGULAR VALUE DECOMPOSITION ###

a = as.matrix(data.frame(c(3, 1, 1), c(-1, 3, 1)))

a.svd <- svd(a)

a.svd

## STEP BY STEP ##

# https://github.com/fastai/course-nlp/blob/master/2-svd-nmf-topic-modeling.ipynb
# Refer to the above link for better SVD algorithm understanding but it is in Python :) 


#Finding ATA 
ATA <- t(a) %*% a
ATA

#v component is found out by calculating the eigenvectors of
#the ATA matrix.

ATA.e <- eigen(ATA)
v.mat <- ATA.e$vectors

v.mat

#Altering signs to match svd() function output
v.mat = v.mat * -1

AAT <- a %*% t(a)

AAT.e = eigen(AAT)

u.mat = AAT.e$vectors

u.mat <- u.mat[, 1:2]

r <- sqrt(ATA.e$values)

r <- r * diag(length(r))

svd.matrix <- u.mat %*% r %*% t(v.mat)

svd.matrix

d01.svd = svd(d01)
