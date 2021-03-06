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
png(file = "plot2.png")

#Draw a histogram for plot 2
plot(x = housePowConsum2Day$DateTime, y = housePowConsum2Day$Global_active_power, type = "l", 
      col = "gray1", xlab = "", ylab = "Global Active Power (kilowatts)")

#Close the device
dev.off()