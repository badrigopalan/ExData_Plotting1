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

png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(data$Global_active_power), 
     breaks = 12, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()
