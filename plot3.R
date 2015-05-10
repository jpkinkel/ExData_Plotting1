as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}
data <- read.csv("household_power_consumption.txt", sep=";")
Sys.setlocale("LC_TIME", locale="USA")
realdata <- data[data["Date"] == "1/2/2007" |  data["Date"] == "2/2/2007" ,]
realdata["new_global_active_power"] <- as.numeric(levels(realdata[,"Global_active_power"])) [realdata[,"Global_active_power"]]
realdata["new_Sub_metering_1"] <- as.numeric(levels(realdata[,"Sub_metering_1"])) [realdata[,"Sub_metering_1"]]
realdata["new_Sub_metering_2"] <- as.numeric(levels(realdata[,"Sub_metering_2"])) [realdata[,"Sub_metering_2"]]
#realdata["new_Sub_metering_3"] <- as.numeric(levels(realdata[,"Sub_metering_3"])) [realdata[,"Sub_metering_3"]]
#realdata <- rbind(realdata, c("3/2/2007", "00:00:00", rep("?", 7), 0))
realdata[which(realdata["Date"]=="1/2/2007" ),"NewDate"] <- "01/02/2007"
realdata[which(realdata["Date"]=="2/2/2007" ),"NewDate"] <- "02/02/2007"
#realdata[which(realdata["Date"]=="3/2/2007" ),"NewDate"] <- "03/02/2007"
realdata$NewDate <- paste(realdata$NewDate,as.character(realdata$Time))
realdata$DateTime <- strptime(realdata$NewDate, "%d/%m/%Y %H:%M:%S",  )
str(data)
png(filename= "plot3.png")
plot(realdata$DateTime, realdata$new_Sub_metering_1, type="l", xlab="", ylab="Energy sub metering" )

lines(realdata$DateTime, realdata$new_Sub_metering_2, col="red")
lines(realdata$DateTime, realdata$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col=c("black", "red", "blue"))
dev.off()