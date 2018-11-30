#read in data, reformat variables as needed
powerdata<- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = '?')
powerdata$Date<-as.Date(powerdata$Date,format="%d/%m/%Y")
powerdata$Time<-strptime(powerdata$Time,format = "%H:%M:%S")
powerdata$Global_active_power<-as.numeric(powerdata$Global_active_power)
datedata<-powerdata[powerdata$Date == as.Date("2007-02-01") | powerdata$Date == as.Date("2007-02-02"),]

#create chart
par(mfrow = c(1,1))
hist(datedata$Global_active_power, col = "red",xlab= "Global Active Power (kilowatts)", 
  ylab= "Frequency", main = "Global Active Power")

#export chart to .png file
dev.copy(png,file="plot1.png")
dev.off()

