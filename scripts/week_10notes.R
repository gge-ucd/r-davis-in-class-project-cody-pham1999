#for loops

#map functions
## tidyverse's version of apply functions
library(tidyverse)

#basic map function
map(iris, mean) ## mean of every col in iris

map_df(iris, mean) ## mean of every col, returned as df

#mapping with 2 args with a pre-written func
printMPG <- function(x, y) {
  paste(x, "gets", y, "miles per gallon")
} ## create the function to use in map

map2_chr(rownames(mtcars), mtcars$mpg, printMPG) ## fun function on many vals
