# Question 1 

mat <- matrix(1:9, nrow = 3, ncol= 3)

n_rows <- nrow(mat)

row_sums <- rowSums(mat)
col_sums <- colSums(mat)

row_sums[1]


for(i in 1:n_rows){

  if (row_sums[i] == col_sums[i] ){
    
    print('True')
    
  }
  else{
    print('False')
    
  }

}


#Question 2

library(MASS)

mat_non_square <- matrix(rpois(24,10), nrow = 8, ncol = 3) #rpois initializes random numbers from 0 to the second argument

inv <- ginv(mat_non_square)

print(inv)

## Checking if the inverse is correct

zapsmall(inv %*% mat_non_square) #zapsmall tidies the product of the matrices


#Question 3

data("iris")
library("ggplot2")

classes <- unique(iris['Species'])
classes

#Pie Chart
pie(table(iris$Species))

colnames(iris)

#Histograms
hist(iris$Sepal.Length)
hist(iris$Petal.Length)
hist(iris$Sepal.Width)
hist(iris$Petal.Width)


#Define color of 3 iris species
colors <- c("#00AFBB", "#E7B800", "#FC4E07")
colors <- colors[as.numeric(iris$Species)]

#Define shapes to be plotted
shapes <- c(16, 17, 18) #pch attribute numbers
shapes <- shapes[as.numeric(iris$Species)]


#Scatterplot

plot(x = iris$Sepal.Length, y = iris$Petal.Length, 
     xlab = 'Sepal Length', ylab = 'Petal Length',
     col = colors, pch = shapes, frame = FALSE)

legend('topright', legend = levels(iris$Species),
       col = c("#00AFBB", "#E7B800", "#FC4E07"),
       pch = c(16, 17, 18))

#Density plot

density_plot <- ggplot(iris, aes(x = Sepal.Length, fill =Species)) + geom_density(alpha = 0.4)

density_plot


