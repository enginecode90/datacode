# Author Hamza-Abas
# this is a small function which calculates the mean and - 
# remove the missing values nas



y <- read.csv("hw1_data.csv", header = TRUE)
colnames <- function(y, removeNA = TRUE){
  nc <- ncol(y)
  means <- numeric(nc)
  for (i in 1:nc) {
    means[i] <- mean(y[,i], na.rm = removeNA)
    
  }
  means
}
