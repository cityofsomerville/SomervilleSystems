# Created By Daniel Hadley Mon Sep 28 11:24:04 EDT 2015 #
setwd("/Users/DHadley/Github/SomervilleSystems/R_scripts")
library(readxl)
library(dplyr)

#
# Load Data
d <- read_excel("/Users/DHadley/P/Somerstat Data/MV_Crash_Data/data/Somerville Crash Data 2010-2015.xlsx")

d <- d[,1:15]

injured_ped <- d %>% 
  filter(`Pedestrian?` == 1, `Injury?` == 1)

ped <- d %>% 
  filter(`Pedestrian?` == 1 ) %>% 
  group_by(Location) %>% 
  summarise(n = n())
