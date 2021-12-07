# R-DAVIS WK4 HW
## Cody Pham
## 2021 Oct 21

fail.dat <- readRDS('C:/Users/codyp/Desktop/nestwatch/Data/active/failure-cleaned.rds') ## failures
suc.dat <- readRDS('C:/Users/codyp/Desktop/nestwatch/Data/active/success-cleaned.rds') ## successes
#filter out non hosts
bhco.hosts <- read.csv('C:/Users/codyp/Desktop/BHCOHosts.csv')
suc.dat <- suc.dat %>% 
  filter(species %in% bhco.hosts$CommonName)

#read in libraries
## for models
library(lme4)
library(tidyverse)


#read in package
library(tidyverse)

#reading in data
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv") #ONLY change the "data" part of this path if necessary

#Q1: calculate mean life expectancy on each continent and create plot of vals through time
gapminder %>% 
  group_by(continent, year) %>% 
  summarise(avg_lifeExp=mean(lifeExp)) %>% 
  ggplot(aes(year, avg_lifeExp)) +
  geom_point(aes(color = continent))
  
#Q2
## scale_x_log10() rescales the x axis to log(x)
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

## change size of points based on pop size
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

#Q3: boxplot for life expectancy for Brazil, China, El Salvador, Niger, and the United States
## put jittered datapoints in the background
## Label the X and Y axis with “Country” and “Life Expectancy” and title the plot “Life Expectancy of Five Countries”
gapminder %>% 
  group_by(country) %>% 
  filter(country=='Brazil'|country=='China'|country=='El Salvador'|country=='Niger'|country=='United States') %>% 
  ggplot(aes(country, lifeExp)) +
  geom_jitter(aes(color=country)) +
  geom_boxplot() +
  theme_bw() +
  ggtitle("Life Expectancy of Five Countries") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Country") + ylab("Life Expectancy")
  
  