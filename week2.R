#creating a vector
num_vec <- c(23,32,45)
char_vec <- c("a", "b", "c")

#pulling out an index from a vector (subsetting)
num_vec[2]
num_vec[c(2,2)] #return index 2, then return index 2 again
num_vec[c(3,2,1)] #return index 3, 2, then 1

char_vec[1]

#creating a dataframe
#R needs column lengths to be the same
char_dat <-  data.frame(col1 = char_vec, col2 = char_vec) #two columns
char_dat

#creating a list
#lists are very flexible object types, can store objects of many different classes
test_list <- list("ent1")
str(test_list) #str displays structure of an object

#adding entries to the list
test_list[[1]][2] <- "ent2" #adding a sub-element to the list
str(test_list)
test_list[[2]] <- char_dat