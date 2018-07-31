path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, file.path(path, "data.zip"), method = "curl")
unzip(zipfile = "data.zip")
hpc <- read.delim(file = "household_power_consumption.txt", 
                  sep = ";",
                  stringsAsFactors = FALSE)
hpc$Date_Time <- paste(hpc$Date, hpc$Time) #create new column pasting date and time together
hpc$Date_Time <- as.POSIXct(hpc$Date_Time,
                            format = "%d/%m/%Y %H:%M:%S") #convert text in new column to date
library(dplyr)
#only retain data for Feb1st and 2nd 2007
hpc_reqd <- hpc %>% 
  filter(Date_Time >= "2007-02-01" & Date_Time <= "2007-02-03 00:00:00")

#generate plot1-a hist of global active power 
hpc_reqd$Global_active_power <- as.numeric(hpc_reqd$Global_active_power)
png("plot1.png", width=480, height=480)
hist(hpc_reqd$Global_active_power, 
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()