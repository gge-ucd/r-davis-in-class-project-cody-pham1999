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
iris.summary <- summary(iris$Petal.Length) ## get quartiles to sort by
petal.q1 <- iris.summary[[2]]
petal.q3 <- iris.summary[[4]]
iris.cat <- iris %>% ## create a new column with small, med, and big categories
  mutate(iris.petal.cat=case_when(
    Petal.Length<petal.q1~'small', Petal.Length>petal.q3~'big',
    (Petal.Length>petal.q1 | Petal.Length<petal.q3)~'medium'))

iris.cat$iris.petal.cat

#read in another dataset
tail <- read_csv('data/tail_length.csv')
str(tail)

#joining datasets
## join by columns that match (ex. common ID number)
## column 'record_id' matches between surveys and tail datasets
## interjoin returns only matches in both datasets
## left join keeps everything in table a, matches between a and b, and NAs for rest
## right join does the opposite
## full join keeps everything

##if don't specify what col to join by, R tries to find columns that match (could be good or bad)

## trying it out: left join
surveys_joined <- left_join(surveys, tail, by="record_id")
str(surveys_joined)

#using pivot functions
## data to pivot
surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight=mean(weight))

## using pivot wider
## give names of col want to extend by (to make rows out of) and rows to make
## into columns
wide_survey <- pivot_wider(surveys_mz, names_from='plot_id', values_from = 'mean_weight')
wide_survey

## using pivot longer
## tell what columns to pivot by (and what columns not to pivot by-what will
## become columns)
## negative sign says 'not' whatever specified (ex. -genus)
pivot_longer(wide_survey, -genus, names_to='plot_id', values_to='mean_weight') %>% 
  head()

#challenge
surveys_count <- surveys %>% 
  group_by(plot_id, year) %>% 
  summarize(count=n_distinct(genus)) %>% 
  arrange(desc(count))
surveys_count

## create wider pivoted dataframe
pivot_wider(surveys_count, names_from='plot_id', values_from = 'count')

## create longer pivoted dataframe
surveys_long <- surveys %>% 
  filter(!is.na(hindfoot_length), !is.na(weight)) %>% ## take out nas
  pivot_longer(c(hindfoot_length, weight), ## keep hindfoot length and weight cols
                             names_to = "measurement", values_to = "value") %>% #name new cols measurement and value
  select(measurement, value, year, plot_type)

surveys_long

## summarize data in long form then pivot to wide to compare values
surveys_long_avgs <- surveys_long %>% 
  group_by(year, plot_type, measurement) %>% ## summarize data, cols for plot, measurement, and year
  summarise(avg.val=mean(value)) %>% ## calculate summary values
  pivot_wider(names_from = "year", values_from = "avg.val") %>% ## pivot wide to compare between plot types
  arrange(measurement)
surveys_long_avgs
