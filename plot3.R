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
png("plot3.png", width = 480, height = 480, res = 72)

## Plot the base line graph
plot(data$DateTime, data$Sub_metering_1,type = "l",xlab = "",ylab="Energy sub metering",col="black")

## Add more lines
lines(data$DateTime,data$Sub_metering_2,type = "l",col="red")
lines(data$DateTime,data$Sub_metering_3,type = "l",col="blue")

## Add the legend
legend(x ="topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lty = 1)

## Close the device
dev.off()