# R-DAVIS WK9 HW
## Cody Pham
## 2021 Nov 4

#read in package
library(tidyverse)
library(lubridate)

#reading in data
## removing observations with missing vals in cols 
## rel_humid (NA=-99), temp_C_2m (NA=-999.9), and windSpeed_m_s (NA=-999.9)
mloa <- read_csv(
  "https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv") %>% 
  filter(rel_humid != -99) %>% 
  filter(temp_C_2m != -999.9) %>% 
  filter(windSpeed_m_s != -99.9)
## timezone: UTC

head(mloa)

#generate datetime col using year, month, day, hour24, and min cols
mloa.datetime <- mloa %>% 
  mutate(datetimeUTC = ymd_hm(paste(year, month, day, hour24, min, sep="-"), tz="UTC"))
tz(mloa.datetime$datetimeUTC) ## time in UTC

#generate datetimeLocal col that converts datetime col to Pacific time
## function with_tz()
mloa.datetime <- mloa.datetime %>% 
  mutate(datetimePDT = with_tz(datetimeUTC, tzone="Pacific/Honolulu"))
tz(mloa.datetime$datetimePDT) ## time in PDT

#calc mean hourly temp each month using temp_C_2m col and datetimeLocal cols
## functions month() and hour()

mloa.hrTemps <- mloa.datetime %>% 
  mutate(localhour=hour(datetimePDT)) %>% 
  group_by(month, localhour) %>% 
  summarize(avgHourlyTemp=mean(temp_C_2m))

#scatterplot of mean monthly temp with points colored by local hour
mloa.hrTemps %>% 
  ggplot(aes(month, avgHourlyTemp)) +
  scale_color_viridis_c() +
  geom_point(aes(color=localhour)) +
  theme_classic()
  