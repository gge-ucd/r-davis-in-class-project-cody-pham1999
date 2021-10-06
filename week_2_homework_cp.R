#create vector
set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2

#remove NAs, subset indices 14-38
prob1 <- na.omit(hw2)
prob1 <- prob1[14:38]
prob1

#multiply each number in vector by 3, add 10 to each number
times3 <- prob1*3
plus10 <- times3+10
plus10

#select every other number in vector
final <- plus10[seq(1,length(plus10),2)]
final