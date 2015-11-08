#Load necessary libraries
library(dplyr)

#Change the directory
homeDir =  getwd()
setwd("Education/MOOC Courses/Data Science Track/4 Exploratory Data Analysis/Projects/Project1")

#Load the data
HPC = read.table("Data/household_power_consumption.txt", header = TRUE, sep = ";", 
                 na.strings = "?", nrows = 2080000)
head(HPC)

#Convert times and dates to Date/Time classes
HPC$DateTime = paste(HPC$Date, HPC$Time)
HPC$DateTime = strptime(HPC$DateTime, "%d/%m/%Y %H:%M:%S")

#Select just the columns we want, with converted DateTime column first
housePowConsum = select(HPC, c(10, 3:9))
head(housePowConsum)

#Select only the rows corresponding to 2007-02-01 and 2007-02-02
twoDays = grep("^2007-02-0[1-2]", housePowConsum$DateTime)
housePowConsum2Day = housePowConsum[twoDays,]
head(housePowConsum2Day)

#Open the png device
png(file = "plot4.png")

#Draw a histogram for plot 3
par(mfcol = c(2, 2))
with(housePowConsum2Day, {
     plot(x = DateTime, y = Global_active_power, type = "l", 
          col = "gray1", xlab = "", ylab = "Global Active Power")
     plot(x = DateTime, y = Sub_metering_1, type = "l", 
          col = "black", xlab = "", ylab = "Energy sub metering")
     with(housePowConsum2Day, points(x = DateTime, y = Sub_metering_2, type = "l",  col = "red"))
     with(housePowConsum2Day, points(x = DateTime, y = Sub_metering_3, type = "l",  col = "blue"))
     legend("topright", lwd = 1, col = c("black", "red", "blue"), 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 1,
            bty = "n")
     plot(x = DateTime, y = Voltage, type = "l", lwd = 0.5, 
          col = "gray1", xlab = "datetime", ylab = "Voltage")
     plot(x = DateTime, y = Global_reactive_power, type = "l", lwd = 0.5, ylim = c(0.0, 0.5),
          col = "gray1", xlab = "datetime", ylab = "Global_reactive_power")
})

#Close the device
dev.off()