# R-DAVIS WK3 HW
## Cody Pham
## 2021 Oct 14

# read in package
library(tidyverse)

# reading in data
surveys <- read.csv("data/portal_data_joined.csv")

# extracting species_id, weight, and plot_type col
surveys_base <- surveys %>% select('species_id','weight','plot_type')
surveys_base

# select only first 60 rows
surveys_base <- surveys_base %>% filter(row(surveys_base) <= 60)
surveys_base

# convert species_id and plot_type to factors
surveys_base$species_id <- as.factor(surveys_base$species_id) 
surveys_base$plot_type <- as.factor(surveys_base$plot_type) 
class(surveys_base$species_id) ## check if converted
# characters vs. factors
## characters just contain letters generally
## factors are coded under the hood in R as numeric codes that are
## used to classify data

# remove NA values
surveys_base <- na.omit(surveys_base)
surveys_base

# challenge: only keep rows with individuals greater than 150g
surveys_base <- surveys_base %>% filter(weight > 150)

