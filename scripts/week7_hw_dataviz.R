# R-DAVIS WK7 HW
## Cody Pham
## 2021 Nov 4

#read in package
library(tidyverse)

#reading in data
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv") %>% 
  filter(complete.cases(.))

gapminder %>%
  group_by(country, year, continent) %>% 
  select(country, year, continent, pop) %>% 
  pivot_wider(names_from='year', values_from = 'pop') %>% ## get difference between 2002 and 2007 pop
  mutate(twosev_change=`2007`-`2002`) %>% 
  select(country, continent, twosev_change) %>% 
  filter(continent!="Oceania") %>% 
  ggplot(aes(x = reorder(country, twosev_change), y = twosev_change)) +
    geom_bar(stat="identity", aes(fill=continent)) +
    facet_wrap(~continent, scales="free") +
    theme(axis.text.x = element_text(angle=45, vjust=1)) +
    xlab("Country") +
    ylab("2002-2007 Population Change") +
    coord_flip() +
    theme_bw()

  
