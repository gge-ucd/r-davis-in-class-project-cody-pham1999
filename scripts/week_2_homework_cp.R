#R-DAVIS WK2 HW
#Cody Pham
#2021 Oct 6

#create vector
set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)

#problem 1: remove NAs, select values only between 14 and 38
prob1 <- na.omit(hw2)
prob1 <- prob1[prob1 >14 & prob1 < 38]

#problem 2: multiply each number in vector by 3, add 10 to each number
times3 <- prob1*3
plus10 <- times3+10

#problem 3: select every other number in vector
#generate a sequence starting at 1 to length of 'plus10', counting by 2
final <- plus10[seq(1,length(plus10),2)]  
final
