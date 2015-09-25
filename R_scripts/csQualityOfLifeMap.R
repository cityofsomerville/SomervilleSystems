# Created By Daniel Hadley Tue Sep 22 14:28:25 EDT 2015 #
setwd("/Users/DHadley/Github/SomervilleSystems/R_scripts")
setwd("C:/Users/dhadley/Documents/GitHub/SomervilleSystems/R_scripts")
#

# Maping tools
library(leafletR)
library(dplyr)


#### 311 ####
cs <- read.csv("//fileshare1/Departments2/Somerstat Data/Constituent_Services/data/311_Somerville.csv")


# returns string w/o leading or trailing whitespace
# I was having trouble with trailing spaces, e.g. "Graffiti "
# http://stackoverflow.com/questions/2261079/how-to-trim-leading-and-trailing-whitespace-in-r
cs <- as.data.frame(apply(cs,2,function (cs) sub("\\s+$", "", cs)))

# don't know why this was stored as an integer
cs$typeName <- as.character(cs$typeName)



## Make geojson for the top quality-of-life calls ##
forMap_qol <- cs %>% 
  filter(typeName == "Rats" | typeName == "Graffiti" | typeName == "Trash/debris on sidewalk report") %>%
  select(latitude, longitude, typeName)

set.seed(311)
# Randomly sample 100
forMap_qol <- forMap_qol[sample(nrow(forMap_qol), 80), ]

# Convert to geojson
toGeoJSON(forMap_qol, "QualityOfLifeCSSample", "../geo/")

