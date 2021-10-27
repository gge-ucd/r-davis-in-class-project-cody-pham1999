# R-DAVIS WK5 HW
## Cody Pham
## 2021 Oct 28

#load package
library(tidyverse)

#read in data
surveys <- read_csv("data/portal_data_joined.csv")

#create wide df 
## cols for genus and plot types, rows have genus and mean hindfoot length
## sort df by values in control plot type
surveys %>% 
  group_by(genus, plot_type) %>% 
  filter(!is.na(hindfoot_length)) %>% 
  summarize(avg_hfoot_length=mean(hindfoot_length)) %>% 
  pivot_wider(names_from='plot_type', values_from='avg_hfoot_length') %>% 
  arrange(desc(Control))

#calc new weight cat variable (small, med, large)
weight.summary <- summary(surveys$weight) ## get quartiles to assign categories
weight.q1 <- weight.summary[[2]]
weight.q3 <- weight.summary[[4]]
surveys.cat <- surveys %>%
  filter(!is.na(hindfoot_length)) %>% ## create a new column with small, med, and big categories
  mutate(weight.cat=case_when(
    weight<=weight.q1~'small', weight>=weight.q3~'big',
    (weight>weight.q1 | weight<weight.q3)~'medium')) %>% 
  select(weight.cat)

