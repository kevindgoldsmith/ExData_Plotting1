#read in data, reformat variables as needed
powerdata<- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = '?')
powerdata$Date<-as.Date(powerdata$Date,format="%d/%m/%Y")
powerdata$Global_active_power<-as.numeric(powerdata$Global_active_power)
datedata<-powerdata[powerdata$Date == as.Date("2007-02-01") | powerdata$Date == as.Date("2007-02-02"),]

#create new "DateTime" variable combining date and time
datedata<-cbind(datedata,"DateTime" = as.POSIXct(paste(datedata$Date, datedata$Time, format = "%d/%m/%Y %H:%M:%S")))

#create charts
par(mfrow = c(2,2))
with(datedata, {
  plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power", xlab ="")
  plot(DateTime,Voltage, type = "l", xlab = "datetime")
  plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col ="blue")
  legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
    lty = 1, bty = "n", xjust = 1)
  plot(DateTime, Global_reactive_power, type ="l", xlab ="datetime")
})

#export chart to .png file
dev.copy(png,file="plot4.png")
dev.off()
