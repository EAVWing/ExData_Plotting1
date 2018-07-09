library(lubridate)

## Get the data set and unzip it into working directory
filename <- "getdata.zip"
if(!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, filename)
}
if(!file.exists("household_power_consumption.txt")){
        unzip(filename)
}

## Load the table
columnnames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", quote = "", skip = 66637, col.names = columnnames, nrows = 2880)
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

## Make Plot 2
datetime <- data$Date + data$Time
data <- cbind(data, datetime)
png(filename = "plot2.png")
plot(data$datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Acive Power (kilowatts)")
dev.off()