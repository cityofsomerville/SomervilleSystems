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

# & throwing off geo
ped$Location <- gsub("&", "and", ped$Location)

# Geocodes using the Google engine
locs <- geocode(ped$Location)
#d <- bind_cols(d, locs) # Add the lat and long back to d
# ^ Didn't work, so
ped$longitude <- locs$lon
ped$latitude <- locs$lat

# Latitude first
ped_toMap <- ped[,c(4,3,1,2)]

# Lots have the same x,y, but variations on the address. fix here
ped_toMap_final <- ped_toMap %>%
  mutate(xandy = paste(latitude, longitude)) %>% 
  group_by(xandy) %>% 
  summarise(latitude = latitude[1], longitude= longitude[1],
            n = sum(n), Location = Location[1]) %>% 
  select(-xandy)

write.csv(ped_toMap_final, "../geo/PedestrianCollisions.csv", row.names = FALSE)

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



#### Now I do it for cyclists ####
# but because i'm lazy, I don't change the variable names, unless I need to
# But it is cyclists

ped <- d %>% 
  filter(`Bicycle` == 1 ) %>% 
  group_by(Location) %>% 
  summarise(n = n())

ped$Location <- paste(ped$Location, "Somerville", "MA", sep=", ")

# & throwing off geo
ped$Location <- gsub("&", "and", ped$Location)

ped <- ped[3:267,]

# Geocodes using the Google engine
locs <- geocode(ped$Location)
#d <- bind_cols(d, locs) # Add the lat and long back to d
# ^ Didn't work, so
ped$longitude <- locs$lon
ped$latitude <- locs$lat

# Latitude first
ped_toMap <- ped[,c(4,3,1,2)]

# Lots have the same x,y, but variations on the address. fix here
ped_toMap_final <- ped_toMap %>%
  mutate(xandy = paste(latitude, longitude)) %>% 
  group_by(xandy) %>% 
  summarise(latitude = latitude[1], longitude= longitude[1],
            n = sum(n), Location = Location[1]) %>% 
  select(-xandy)

write.csv(ped_toMap_final, "../geo/CyclistCollisions.csv", row.names = FALSE)

ped_toMap <- read.csv("../geo/CyclistCollisions.csv")

# Convert to geojson and put it on our server
library(leafletR)

toGeoJSON(ped_toMap, "CyclistCollisions", "../geo/")


library(RCurl)
ftpUpload(what = "../geo/CyclistCollisions.geojson",
          to = "ftp://spider/CyclistCollisions.geojson",
          verbose = TRUE,
          userpwd = "", 
          prequote="CWD /var/www/dashboard/geo/")