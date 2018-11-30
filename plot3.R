#read in data, reformat variables as needed
powerdata<- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = '?')
powerdata$Date<-as.Date(powerdata$Date,format="%d/%m/%Y")
powerdata$Global_active_power<-as.numeric(powerdata$Global_active_power)
datedata<-powerdata[powerdata$Date == as.Date("2007-02-01") | powerdata$Date == as.Date("2007-02-02"),]

#create new "DateTime" variable combining date and time
datedata<-cbind(datedata,"DateTime" = as.POSIXct(paste(datedata$Date, datedata$Time, format = "%d/%m/%Y %H:%M:%S")))

#create chart
par(mfrow = c(1,1))
with(datedata, {
  plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering",xlab="")
  lines(DateTime, Sub_metering_2, col = "red")
  lines(DateTime, Sub_metering_3, col = "blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1",
    "Sub_metering_2", "Sub_metering_3"),lty=1, xjust =1)
})

#export chart to .png file
dev.copy(png,file="plot3.png")
dev.off()
