# This Code analyzes 311 Call Data, which is imported from Socrata
# Created by D Hadley on 6/11/13


# Import data from Socrata
`Calls` <- read.csv(url("https://data.somervillema.gov/api/views/dtkn-fv7f/rows.csv"))
View(Calls)

# Duplicate the dataset so I don't have to keep importing from Socrata
'Calls2' <- Calls


#### Cleans Data ####


# Makes seperate columns for the month, day, and year
Calls2$Date <- as.POSIXct(Calls$Date, format='%m/%d/%Y %H:%M:%S')
Calls2$Month <- format(Calls2$Date, format='%m')
Calls2$Day <- format(Calls2$Date, format='%d')
Calls2$Year <- format(Calls2$Date, format='%Y')

#### Analyzes Data ####

#Aggregates the data, and does a time series
Calls2$Num.Calls <- 1
Calls.agg <- as.data.frame(xtabs(Num.Calls ~ Month + Year + Type, Calls2), responseName = "Calls2")
Calls.agg <- as.data.frame(xtabs(Num.Calls ~ Year + Month + Type, Calls2), responseName = "Calls2")


Rats.ts <- ts(Rats.agg, start=c(2009, 1), end=c(2012, 09), frequency=12)
plot(Rats.ts)

