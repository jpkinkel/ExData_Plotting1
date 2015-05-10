as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}
data <- read.csv("household_power_consumption.txt", sep=";")

str(data)
realdata <- data[data["Date"] == "1/2/2007" |  data["Date"] == "2/2/2007" ,]
#realdata <- realdata[realdata["Global_active_power"] != "?",]
str(realdata)
realdata["new_global_active_power"] <- as.numeric(levels(realdata[,"Global_active_power"])) [realdata[,"Global_active_power"]]
png(filename= "plot1.png")
hist(realdata[,"new_global_active_power"], xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")

dev.off()
