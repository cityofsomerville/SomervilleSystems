# Created By Daniel Hadley Mon Sep 28 11:24:04 EDT 2015 #
setwd("/Users/DHadley/Github/SomervilleSystems/R_scripts")
setwd("//fileshare1/Departments2/Somerstat Data/SomervilleSystems/R_scripts/")
library(readxl)
library(dplyr)

#
# Load Data
d <- read_excel("/Users/DHadley/P/Somerstat Data/MV_Crash_Data/data/Somerville Crash Data 2010-2015 Socrata.xlsx")
# d <- read_excel("../../MV_Crash_Data/data/Somerville Crash Data 2010-2015 Socrata.xlsx")

d <- d[,1:19]

injured_ped <- d %>% 
  filter(`Pedestrian` == 1, `Injury` == 1)

ped <- d %>% 
  filter(`Pedestrian` == 1 ) %>% 
  group_by(Location) %>% 
  summarise(n = n())

###### Map it! ######
library(ggmap)
ped$Location <- paste(ped$Location, "Somerville", "MA", sep=", ")

# Geocodes using the Google engine
locs <- geocode(ped$Location)
#d <- bind_cols(d, locs) # Add the lat and long back to d
# ^ Didn't work, so
ped$longitude <- locs$lon
ped$latitude <- locs$lat

# Latitude first
ped_toMap <- ped[,c(4,3,1,2)]

write.csv(ped_toMap, "../geo/PedestrianCollisions.csv", row.names = FALSE)

ped_toMap <- read.csv("../geo/PedestrianCollisions.csv")

# Convert to geojson and put it on our server
library(leafletR)

toGeoJSON(ped_toMap, "PedestrianCollisions", "../geo/")


library(RCurl)
ftpUpload(what = "../geo/PedestrianCollisions.geojson",
          to = "ftp://spider/PedestrianCollisions.geojson",
          verbose = TRUE,
          userpwd = "", 
          prequote="CWD /var/www/dashboard/geo/")