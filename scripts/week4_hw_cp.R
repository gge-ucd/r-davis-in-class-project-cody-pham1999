# R-DAVIS WK4 HW
## Cody Pham
## 2021 Oct 21

#read in package
library(tidyverse)

#reading in data
surveys <- read_csv("data/portal_data_joined.csv")

#keep rows with weight btwn 30 and 60
surveys <- surveys %>% 
  filter(weight>30 & weight<60)

min(surveys$weight) ## check if filter worked
max(surveys$weight)

head(surveys) ## print out rows

#tibble with max weight for each spp/sex combo
biggest_critters <- surveys %>% 
  unite('species.sex', c(species,sex), sep='_', na.rm=T) %>% 
  group_by(species.sex) %>% 
  summarize(max.weight=max(weight))

#figure out where na's are
surveys %>% ## check species
  filter(is.na(weight)) %>% 
  group_by(species) %>% 
  tally() %>% 
  arrange(desc(n))

surveys %>% ## check plots
  filter(is.na(weight)) %>% 
  group_by(plot_id) %>% 
  tally() %>% 
  arrange(desc(n))

surveys %>% ## check year
  filter(is.na(weight)) %>% 
  group_by(year) %>% 
  tally() %>% 
  arrange(desc(n))

#get col for mean weight of spp/sex combo
surveys_avg_weight <- surveys %>% 
  na.omit(weight) %>% 
  unite('species.sex', c(species,sex), sep='_', na.rm=T) %>% 
  group_by(species.sex) %>% 
  mutate(avg.spp.sex.weight=mean(weight)) %>% 
  select(species.sex, weight, avg.spp.sex.weight)

#get col for if weight is above average spp/sex combo weight
surveys_avg_weight <- surveys_avg_weight %>% 
  mutate(above.avg=ifelse(weight>avg.spp.sex.weight, 1, 0))


