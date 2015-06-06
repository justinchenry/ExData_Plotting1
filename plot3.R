
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
png("plot3.png", width=480, height=480)

## RUN TEH PLOT FOR SUB METERING (run 1 and add the other two using Lines)
plot(hpcDataSub$Sub_metering_1~hpcDataSub$Datetime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
lines(hpcDataSub$Sub_metering_2~hpcDataSub$Datetime,col='Red')
lines(hpcDataSub$Sub_metering_3~hpcDataSub$Datetime,col='Blue')

## ADD A LEGEND TO THE PLOT AT THE TOP-RIGHT
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## TURN OFF OUTPUT
dev.off()