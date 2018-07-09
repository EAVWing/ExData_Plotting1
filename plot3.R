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

## Make Plot 3
datetime <- data$Date + data$Time
data <- cbind(data, datetime)
png(filename = "plot3.png")
plot(data$datetime, data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
points(data$datetime, data$Sub_metering_1, type = "l", col = "black")
points(data$datetime, data$Sub_metering_2, type = "l", col = "red")
points(data$datetime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()