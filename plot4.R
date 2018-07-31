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

#generate plot4
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# Plot A
plot(hpc_reqd[, "Date_Time"], hpc_reqd[, "Global_active_power"],
     type="l",
     xlab="",
     ylab="Global Active Power")

# Plot B
plot(hpc_reqd[, "Date_Time"], hpc_reqd[, "Voltage"],
     type="l",
     xlab="datetime",
     ylab="Voltage")

# Plot C
plot(hpc_reqd[, "Date_Time"], hpc_reqd[, "Sub_metering_1"],
     type="l",
     xlab="",
     ylab="Energy sub metering")
lines(hpc_reqd[, "Date_Time"], hpc_reqd[, "Sub_metering_2"], col="red")
lines(hpc_reqd[, "Date_Time"], hpc_reqd[, "Sub_metering_3"], col="blue")
legend("topright", col=c("black", "red", "blue"),
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1),
       bty="n",
       cex=.5) 

# Plot D
plot(hpc_reqd[, "Date_Time"], hpc_reqd[, "Global_reactive_power"],
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")

dev.off()