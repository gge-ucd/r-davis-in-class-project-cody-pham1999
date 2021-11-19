#Working with dates

#two ways of writing dates
## yyyy-mm-dd or posix

#inputting dates this way works bo t
sample_dates_1 <- c("2018-02-01", "2018-03-21", "2018-10-05", "2019-01-01", "2019-02-18")
#notice we have dates across two years here

sample_dates_1 <- as.Date(sample_dates_1)
str(sample_dates_1) ## now R knows these are dates

#inputting dates this way doesn't work without specifying date code
sample_dates_2 <- c("02-01-2018", "03-21-2018", "10-05-2018", "01-01-2019", "02-18-2019")
sample_dates_3 <-as.Date(sample_dates_2) # well that doesn't work

#specifying date code
sample_dates_2 <- c("02-01-2018", "03-21-2018", "10-05-2018", "01-01-2019", "02-18-2019")
sample_dates_3 <- as.Date(sample_dates_2, format = "%m-%d-%Y" ) # date code preceded by "%"

#challenge: formatting dates with as.Date
as.Date("Jul 04, 2019", format = "%b%d,%Y")

#Working with dates in lubridate
## includes hard wired format conversion functions
library(lubridate)
ymd(sample_dates_1) ## year month day format reading in

#Writing functions

#summing function
my_sum <- function(n1, n2) {
  the_sum <- n1+n2
  return(the_sum)
} ## define the function

#summing function with default values
my_sum <- function(n1=5, n2=10) {
  the_sum <- n1+n2
  return(the_sum)
} ## define the function

#challenge: temp conversion
F_to_K <- function(temp) {
  K <- ((temp - 32) * (5 / 9)) + 273.15
  return(K)
}

K_to_C <- function(K) {
  C <- K-273.15
  return(C) ## convert K values to C
}

#functions with Gapmind data
library(tidyverse)
library(gapminder)

gapminder %>% 
  filter(country == "Canada", year %in% 1970:1980) %>% 
  summarize(mean(gdpPercap, na.rm = T))

avgGDP <- function(cntry, yrRange) {
  gapminder %>% 
    filter(country == cntry, year %in% yrRange) %>% 
    summarize(mean(gdpPercap, na.rm = T))
}

avgGDP("Iran", 1985:1990)

#challenge: function that plots time series for given data and country
plotTseries <- function(dat, cntry) {
  dat %>% 
    filter(country==cntry) %>% 
    ggplot(aes(year, pop)) +
    geom_line() +
    theme_bw()
}

plotTseries(gapminder, "Canada") ## test out function
