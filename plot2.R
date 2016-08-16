rm(list=ls())
## Read the data set with ? as NA string
data <- read.csv(file="household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"),stringsAsFactors=FALSE,nrows= 1000000)

## Add a column DateTime and format and convert to Date object
data$DateTime <-  strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

## Subset data to include data for dates 2007-02-01 to 2007-02-03
data <- data[data[,"DateTime"] >= strptime("2007-02-01 00:00:00",format="%Y-%m-%d %H:%M:%S"),]
data <- data[data[,"DateTime"] < strptime("2007-02-03 00:00:00",format="%Y-%m-%d %H:%M:%S"),]

## Clean data by remove NAs in DateTime column
data <- data[!is.na(data[,"DateTime"]),]

## Open a PNG device
png("plot2.png", width = 480, height = 480, res = 72)

## Plot the lone graph
plot(data$DateTime, data$Global_active_power,type = "l",xlab = "",ylab="Global Active Power (kilowatts)")

## Close the device
dev.off()