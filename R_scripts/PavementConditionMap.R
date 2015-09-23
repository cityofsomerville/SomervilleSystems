# Created By Daniel Hadley Tue Sep 22 14:28:25 EDT 2015 #
setwd("/Users/DHadley/Github/SomervilleSystems/R_scripts")
setwd("C:/Users/dhadley/Documents/GitHub/SomervilleSystems/R_scripts")
#

# Maping tools
require("rgdal") # requires sp, will use proj.4 if installed
library(leafletR)

# Load Data
d <- readOGR(dsn="../../PCI_Code/2015_Shapefile", layer="BL_SEGMENTS_2015")

# Was having trouble with some characters from other columns. These two seem to be fine
d <- d[,c("OCI", "STREETNAME")]

toGeoJSON(data = d, name = "PavementConditionMap", "../geo/")

