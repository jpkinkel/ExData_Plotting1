as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}
data <- read.csv("household_power_consumption.txt", sep=";")
Sys.setlocale("LC_TIME", locale="USA")
realdata <- data[data["Date"] == "1/2/2007" |  data["Date"] == "2/2/2007" ,]
realdata["new_global_active_power"] <- as.numeric(levels(realdata[,"Global_active_power"])) [realdata[,"Global_active_power"]]
#realdata <- rbind(realdata, c("3/2/2007", "00:00:00", rep("?", 7), 0))
realdata[which(realdata["Date"]=="1/2/2007" ),"NewDate"] <- "01/02/2007"
realdata[which(realdata["Date"]=="2/2/2007" ),"NewDate"] <- "02/02/2007"
#realdata[which(realdata["Date"]=="3/2/2007" ),"NewDate"] <- "03/02/2007"
realdata$NewDate <- paste(realdata$NewDate,as.character(realdata$Time))
realdata$DateTime <- strptime(realdata$NewDate, "%d/%m/%Y %H:%M:%S",  )
realdata["new_Sub_metering_1"] <- as.numeric(levels(realdata[,"Sub_metering_1"])) [realdata[,"Sub_metering_1"]]
realdata["new_Sub_metering_2"] <- as.numeric(levels(realdata[,"Sub_metering_2"])) [realdata[,"Sub_metering_2"]]

str(realdata)
png(filename= "plot4.png")
par(mfrow=c(2,2))
plot(realdata$DateTime, realdata$new_global_active_power, type="l", xlab="", ylab="Global Active Power (Kilowatts)")
plot(realdata$DateTime, realdata$Voltage, type="l", ylab="Voltage", xlab="datetime")

plot(realdata$DateTime, realdata$new_Sub_metering_1, type="l", xlab="", ylab="Energy sub metering" )

lines(realdata$DateTime, realdata$new_Sub_metering_2, col="red")
lines(realdata$DateTime, realdata$Sub_metering_3, col="blue")
plot(realdata$DateTime, realdata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()