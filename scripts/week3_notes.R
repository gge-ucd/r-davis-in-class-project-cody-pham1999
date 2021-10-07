# Before class videos
# goals
## using the read.csv() function to read in data
## explore and subset dataframes
## packages and base R vs the tidyverse

# reading in data
# can use tab while typing in filepath to get suggestions
surveys <- read.csv("data/portal_data_joined.csv")

# inspecting the data
nrow(surveys)
ncol(surveys)


# determining what kind of data
class(surveys)

# look at top or bottom entries
head(surveys)
tail(surveys)

# look at data in its entirety
# can also click in global environment data
View(surveys)

# finding out more about the data using str()
# each '$' is a column
# each word after the ':' is the class
str(surveys)

# indexing
# for dataframes, inside brackets [row, col]
surveys[1,1]
surveys[,6] #extracts vector for row
surveys[6] #extracts df for column


# special signs for subsetting
# ':' presents a range
# '-' subtracts
surveys[1:6,]
surveys[-(1:6),]
surveys[-1,]

# subsetting with column name
surveys['species_id'] #df output
surveys[,'species_id'] #vector output
colnames(surveys) #display col names
surveys$species_id #vector output - preferred method

# loading the tidyverse
install.packages('tidyverse')
library(tidyverse)

# tidyverse works mostly with tibbles
surveys_t <- read_csv('data/portal_data_joined.csv')
class(surveys_t) #much more than just a dataframe now

# subsetting a tibble is a little different
surveys_t[,1] #tibble output

# In class session
# read in spreadsheet
surveys <- read.csv("data/portal_data_joined.csv")

# count unique values
length(unique(surveys$species))

# subsetting a dataframe
surveys_200 <- surveys[200,] ## extract 200th row
surveys_last <- surveys[nrow(surveys),] ## extract last row
surveys_last
surveys_last2 <- tail(surveys,1)
class(surveys_last2) ## check if class is correct
surveys_last2

surveys_middle <- surveys[nrow(surveys)/2,] ## extract middle row
surveys_middle

surveys_head <- surveys[-(7:nrow(surveys)),] ## extract first 6 rows
surveys_head
