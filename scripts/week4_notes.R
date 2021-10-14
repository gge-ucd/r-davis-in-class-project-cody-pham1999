library(tidyverse)

#read in dataset
surveys <- read_csv('data/portal_data_joined.csv')
dim(surveys)

#extract columns
str(surveys) #view columns
select(surveys, sex, weight, genus) #subset columns
head(select(surveys, sex, weight, genus))

#extract rows
head(filter(surveys, genus=='Neotoma')) #subset rows
head(filter(surveys, genus!='Neotoma'))

#chaining operations
#long way of doing things
surveys2 <- filter(surveys, genus!='Neotoma') #long way of doing things
surveys3 <- select(surveys2, sex, weight, genus)
str(surveys3)

#chaining
surveys_filtered <- select(filter(surveys, genus!='Neotoma'), sex, weight, genus)
identical(surveys3, surveys_filtered) #check if methods give the same results

#piping
surveys_filtered_piped <- surveys %>% 
  filter(genus!='Neotoma') %>% 
  select(sex, weight, genus)
identical(surveys_filtered, surveys_filtered_piped) #check if methods give the same results

#filters with piping challenge
surveys_challenge <- surveys %>% 
  filter(year<1995) %>% 
  select(year, sex, weight)

#mutating data (creating new columns)
surveys <- surveys %>% mutate(weight_kg = weight/1000) %>% 
  head() #args: colname=desired operation

#mutating data challenge
surveys_hindfoot_half <- surveys %>% 
  mutate(hindfoot_half = hindfoot_length/2) %>% 
  filter(hindfoot_half < 30) %>% 
  select(species_id, hindfoot_half)
head(surveys_hindfoot_half)

#summarizing data
## split apply combine paradigm: split into categories, 
## perform operation to summarize each category,
## combine category summaries into one dataframe
surveys <- read_csv('data/portal_data_joined.csv')

#group data, summarize using mean and median values (not including NAs)
surveys %>% group_by(sex) %>% 
  summarize(avg_weight=mean(weight, na.rm=T), med_weight=median(weight,na.rm=T))

#counting numbers of observations (tally)
surveys %>% group_by(sex) %>% 
  tally()

#summarizing data challenge
surveys %>% 
  group_by(species_id)  %>% 
  summarize(mean_hindfoot=mean(hindfoot_length, na.rm=T), 
            max_hindfoot=max(hindfoot_length, na.rm=T),
            min_hindfoot=min(hindfoot_length, na.rm=T))

surveys %>% 
  group_by(sex) %>% 
  summarize(n=5)
  
