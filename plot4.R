#---------------------
# Plot 4
#---------------------

#This program uses electronic power consumption data for a household over 4 years
#to create graphs which visualize usage.

#Download the file from here:
#https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#unzip file

file <- "./data/household_power_consumption.txt"
con <- file(file, open = "r")
open(con)

pattern <- "^[12]/2/2007"

lines <- scan(con, sep="\n", what = "character", quiet=TRUE)
matchedLines <- lines[grep(pattern, lines)]
#str(matchedLines)

matchedLines <- strsplit(matchedLines, ";")
lines <- data.frame(do.call(rbind, matchedLines), stringsAsFactors=FALSE)
# str(lines)

names(lines) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

lines$DateTime <- paste(lines$Date, lines$Time)

lines$DateTime <- strptime(lines$DateTime, format = "%d/%m/%Y %H:%M:%S")

lines$Date <- as.Date(lines$Date, format = "%d/%m/%Y" )


for (i in 3:9) {
	lines[i] <- as.numeric(lines[[i]])
}

#Plot 4
png(file = "plot4.png")
par(mfrow=c(2,2))

#Plot 4a
plot(lines$DateTime, lines$Global_active_power, type="l", xlab = "", main = "", ylab = "Global Active Power (kilowatts)")

#Plot 4b
plot(lines$DateTime, lines$Voltage, type="l", main = "", xlab = "datetime", ylab = "Voltage")

#Plot 4c
plot(lines$DateTime, lines$Sub_metering_1, type="l", xlab = "", main = "", ylab = "Energy sub metering")
lines(lines$DateTime, lines$Sub_metering_2, type="l", col="red")
lines(lines$DateTime, lines$Sub_metering_3, type="l", col="blue")
legend("topright", legend = names(lines[7:9]), lty=1, col = c("black", "red", "blue"))

#plot 4d
plot(lines$DateTime, lines$Global_reactive_power, type="l", main = "", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()

