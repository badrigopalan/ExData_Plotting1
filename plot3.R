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
data$Datetime <- as.POSIXlt(paste(data$Date, data$Time))

# Build the plot
png(filename = "plot3.png", width = 480, height = 480)
plot(data$Datetime,
     data$Sub_metering_1, 
     type = "l", 
     ylab = "Energy sub Metering",
     xlab = NA)
lines(data$Datetime,
      data$Sub_metering_2, 
      type = "l", 
      ylab = "Energy sub Metering", 
      col = "Red")
lines(data$Datetime,
      data$Sub_metering_3, 
      type = "l", 
      ylab = "Energy sub Metering", 
      col = "Blue")

# Add legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), 
       lwd = c(2, 2, 2), 
       col = c("black", "blue", "red"))

dev.off()
