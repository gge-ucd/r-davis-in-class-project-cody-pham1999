#load package
library(tidyverse)

#read in data
surveys <- read_csv("data/portal_data_joined.csv")

summary(surveys$hindfoot_length) ## look at column basics

#working with conditionals
## new vector comparing each value to average
ifelse(surveys$hindfoot_length<mean(surveys$hindfoot_length, na.rm=T),
       'small','big')

## new column comparing each falue to average
surveys <- mutate(surveys, ifelse(surveys$hindfoot_length<mean(surveys$hindfoot_length, na.rm=T),
                       'small','big'))

## challenge

