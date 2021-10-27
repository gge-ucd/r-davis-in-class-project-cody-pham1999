#load package
library(tidyverse)

#read in data
surveys <- read_csv("data/portal_data_joined.csv") %>% 
  filter(complete.cases(.)) ## filter out NAs, . fills in args with piped df

#general ggplot format
## ggplt(data = <DATA>, mapping = aes(<MAPPINGS>)) + <GEOM_FUNCTION>()
## aes is where specify variables, other aesthetics
## geom_point() for scatterplots (cont x cont variable)
## geom_boxplot() (cat x cont var)
## geom_line() for trendlines

#making a scatterplot
ggplot(data = surveys, mapping = aes(x=weight, y=hindfoot_length)) +
  geom_point()

#saving plots as objects
base_plot <- ggplot(data = surveys, mapping = aes(x=weight, y=hindfoot_length))

#adding onto plot objects
base_plot + geom_point()

#adding plot elements (transparency = alpha, color = color, infill =- fill)
base_plot + geom_point(alphs = 0.2) ## make points more transparent
base_plot + geom_point(color = 'blue') ## makes point fills blue

#adding plot elements based on variables
## color by categorical var
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(mapping = aes(color = species_id))

#making a boxplot
ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot()

base_plot2 <- ggplot(data = surveys, mapping = aes(x = species_id, y = weight))

#adding plot elements to boxplot
base_plot2 +
  geom_boxplot(color = 'purple') +
  geom_point() ## adding points

base_plot2 +
  geom_boxplot() +
  geom_jitter(alpha = 0.2, mapping = aes(color = species_id)) ## spread points out
                                                              ## color by spp id

#creating time series
yearly_cts <-  surveys %>% 
  count(year, species_id)

ggplot(data = yearly_cts, mapping = aes(x = year, y = n, group = species_id)) +
  geom_line() ## plot the time series

#creating multi panel time series plots for many species
ggplot(data = yearly_cts, mapping = aes(x = year, y = n, group = species_id)) +
  geom_line() +
  facet_wrap((~species_id), scales = 'free_y') ## specify diff scales for ea spp

#creating plots with different colors
ggplot(data = yearly_cts, mapping = aes(x = year, y = n, group = species_id)) +
  geom_line() +
  facet_wrap((~species_id)) +
  theme(plot.background = element_rect(fill='black')) #custom theme

ggplot(data = yearly_cts, mapping = aes(x = year, y = n, group = species_id)) +
  geom_line() +
  facet_wrap((~species_id)) +
  theme_classic() ##pre built themes

## many other themes
install.packages("ggthemes")
## theme_map() to remove axes for maps
