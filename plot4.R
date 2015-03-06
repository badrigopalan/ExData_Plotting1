# This program expects that the data will be extracted as follows:
# 1. Download from:
#    https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# 2. Unzip and place resulting household_power_consumption.txt in
#    same working directory as the script.
data <- read.table("household_power_consumption.txt", 
                   header = T,
                   sep = ";", 
                   stringsAsFactors = F,
)

# Take only the range needed
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

# Convert to date format
data[1] <- lapply(data[1], strptime, "%d/%m/%Y")

png(filename = "plot4.png", width = 480, height = 480)

# Arrange the plots by 2x2 column-wise.
par(mfcol = c(2,2))
# Plot 1
plot(as.POSIXlt(paste(data$Date, data$Time)), 
     data$Global_active_power, 
     type = "l",
     ylab = "Global Active Power",
     xlab = NA)

# Plot 2
plot(as.POSIXlt(paste(data$Date, data$Time)), 
     data$Sub_metering_1, 
     type = "l", 
     ylab = "Energy sub Metering",
     xlab = NA)
lines(as.POSIXlt(paste(data$Date, data$Time)), 
      data$Sub_metering_2, 
      type = "l", 
      ylab = "Energy sub Metering", 
      col = "Red")
lines(as.POSIXlt(paste(data$Date, data$Time)), 
      data$Sub_metering_3, 
      type = "l", 
      ylab = "Energy sub metering", 
      col = "Blue")

# Add legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), 
       lwd = c(2, 2, 2), 
       col = c("black", "blue", "red"),
       bty = "n")

# Plot 3
plot(as.POSIXlt(paste(data$Date, data$Time)), 
     data$Voltage,
     xlab = "datetime",
     ylab = "Voltage", type = "l")

# Plot 4
plot(as.POSIXlt(paste(data$Date, data$Time)), 
     data$Global_reactive_power,
     xlab = "datetime",
     ylab = "Global_reactive_power", type = "l")

dev.off()
