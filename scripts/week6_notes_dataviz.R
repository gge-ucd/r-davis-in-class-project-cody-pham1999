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

#challenge: scatterplot of weight and species_id
## colors coded by plot_type
ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) +
  geom_jitter(mapping = aes(color = plot_type)) ## not the greatest plot

ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) +
  geom_point(aes(color = plot_type)) +
  facet_wrap((~plot_type))

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

#challenges: boxplots
## violin plots
base_plot2 +
  geom_jitter(alpha = 0.2, mapping = aes(color = species_id)) + ## spread points out
                                                               ## color by spp id
  geom_violin() +
  scale_y_log10() ## representing y on long scale

surveys %>% 
  filter(species_id == 'NL'|species_id == 'PF') %>% 
  ggplot(mapping = aes(x = species_id, y = hindfoot_length)) +
    geom_jitter(alpha = 0.2, aes(color = plot_type)) + ## spread points out
                                                      ## color by spp id
    geom_boxplot()

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

#WK 7: fine tuning and saving plots
library(tidyverse)
library(ggthemes)
library(gridExtra) ## for arranging plots in R output
data(mtcars) ## read in package and data

g1 <- ggplot(data = mtcars, aes(mpg, hp)) +
  geom_point() 
g2 <- ggplot(data = mtcars, aes(mpg, hp)) +
  geom_point() +
  theme_tufte()
grid.arrange(g1,g2,ncol=2) ## arrange plots

#customizing plots
ggplot(data = mtcars, aes(mpg, hp, color=as.factor(cyl))) +
  geom_point() +
  scale_color_colorblind() ## scaling discrete colors for colorblind accessibility

## using scale color viridis to make color scales transfer from color to bw
ggplot(data = mtcars, aes(mpg, hp, color=wt)) +
  scale_color_viridis_c() + ## scaling continuous colors for bw and color transmission
  geom_point() +
  theme_bw()

library(tigris) ## packages with shapefiles
library(sf)

#plotting maps
ca.counties = tigris::counties(state = 'GA', class = 'sf', year = 2017)
ggplot(data = ca.counties, aes(fill=ALAND)) +
  scale_fill_viridis_c() +
  geom_sf() +
  theme_map()

#nonvisual data viz
library(BrailleR) ## converts visual plots to text description

g3 <- ggplot(diamonds, aes(x = clarity, fill = cut)) + ## plot to put into text
  geom_bar() +
  theme(axis.text.x = element_text(angle=70, vjust=0.5)) +
  scale_fill_viridis_d(option = "C") +
  theme_classic()
BrailleR::VI(g3)

library(sonify) ## converts visual plots to sound

plot(iris$Petal.Width)
sonify::sonify(iris$Petal.Length) ## whistle that changes pitch based on trends

#saving plots
library(cowplot) ## package to help save plots

#create plots to save
d.plot <- ggplot(diamonds, aes(clarity, fill=cut)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle=45, vjust=0.5)) ## change angle and position of labels
d.plot

mpg.plot <- ggplot(mpg, aes(cty, hwy, color=factor(cyl))) +
  geom_point(size=2.5)
mpg.plot

iris.plot <- ggplot(iris, aes(Sepal.Length, Petal.Length, color=Species)) +
  geom_point(alpha=0.3)
iris.plot

#create a grid of plots in even boxes
plot_grid(d.plot, iris.plot, mpg.plot, labels = c("A", "B", "C", nrow=1))

#line up and resize plots using ggdraw + draw_plot
ggdraw() + draw_plot(iris.plot, x=0, y=0, height=0.5) + ## iris take up whole bottom row
  draw_plot(mpg.plot, x=0, y=0.5, height=0.5, width=0.5) + ## mpg top left
  draw_plot(d.plot, x=0.5, y=0.5, width=0.5, height=0.5) ## diamonds top right

#save plots
final.plot <- ggdraw() + draw_plot(iris.plot, x=0, y=0, height=0.5) + ## iris take up whole bottom row
  draw_plot(mpg.plot, x=0, y=0.5, height=0.5, width=0.5) + ## mpg top left
  draw_plot(d.plot, x=0.5, y=0.5, width=0.5, height=0.5) ## diamonds top right

dir.create("figures") ## create a folder
ggsave("figures/finalplot.png", plot=final.plot, width = 6, height = 4, units = "in")

#interactive plots
library(plotly)
plotly::ggplotly(iris.plot) ## automatically allows hovering for values, panning, filtering based on legend values
