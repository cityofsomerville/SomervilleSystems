library(leafletR)
library(rgdal) #for reading/writing geo files

# Created By Daniel Hadley Fri Sep 25 11:21:27 EDT 2015 #
setwd("/Users/DHadley/Github/SomervilleSystems/R_scripts")
#
# Load Data

download.file("https://data.somervillema.gov/download/ycn2-krqp/application/zip", "/Users/DHadley/Downloads/Zoning")

unzip("/Users/DHadley/Downloads/Zoning.zip", exdir = "/Users/DHadley/Downloads/")

d <- readOGR("/Users/DHadley/Downloads", layer = "Zoning")
names(d)
d$DESCRIPTIO
