
## SET WORKING DIRECTORY
## setwd("C:/Users/jhenry/Desktop/Personal/Coursera/Class - Exploratory Data Analysis")

## DOWNLOAD AND UNZIP THE DATA FILE
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, dest="EPC.zip", mode="wb") 
unzip("EPC.zip")

## EXTRACT THE DATA INTO A DATA FRAME AND FORMAT THE DATE FIELD
hpcData <- read.csv('household_power_consumption.txt',header=TRUE,sep=';',na.strings="?",stringsAsFactors=FALSE)
hpcData$Date <- as.Date(hpcData$Date, format="%d/%m/%Y")

## SUBSET THE DATA TO FILTER ON ONLY FEB 1st 2007 and FEB 2nd 2007
hpcDataSub <- subset(hpcData, Date >= "2007-02-01" & Date <= "2007-02-02")
rm(hpcData)

## CREATE A COMBINED DATE/TIME FIELD CALLED DateTime
datetime <- paste(as.Date(hpcDataSub$Date), hpcDataSub$Time)
hpcDataSub$Datetime <- as.POSIXct(datetime)

## SET THE PLOT OUTPUT
png("plot2.png", width=480, height=480)

## RUN THE PLOT FOR GLOBAL ACTIVE POWER vs. DATE TIME 
plot(hpcDataSub$Global_active_power~hpcDataSub$Datetime, type="l",ylab="Global Active Power (kilowatts)", xlab="")

## TURN OFF OUTPUT
dev.off()
