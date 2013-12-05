# This script combines all of the FBI files, keeps critical variables, and exports to the final folder 
# Loads the plain FBI files
ViolentCrimeRate <- read.csv(file="K:/Somerstat/Common/ResiStat/Graphic Design/2013 SomerStat Community Scorecard/Scorecard Final/bootstrap/RawData/FBI Crime Property and Violent/LocalCrimeTrendsInOneVar (2).csv",header=TRUE, skip=3, sep=",")
PropertyCrimeRate <- read.csv(file="K:/Somerstat/Common/ResiStat/Graphic Design/2013 SomerStat Community Scorecard/Scorecard Final/bootstrap/RawData/FBI Crime Property and Violent/LocalCrimeTrendsInOneVar (3).csv",header=TRUE, skip=3, sep=",")

# Cuts out some of the bad columns and keeps Somerville
ViolentCrimeRate <- ViolentCrimeRate[140,1:28]
PropertyCrimeRate <- PropertyCrimeRate[140,1:28]


# Defines which variables to keep and then saves to the final data folder 

write.table(PropertyCrimeRate, file="FBIPropertyCrime.csv",sep=",",row.names=F)
write.table(ViolentCrimeRate, file="FBIViolentCrime.csv",sep=",",row.names=F)
