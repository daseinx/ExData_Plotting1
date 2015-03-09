data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
selection <- data[as.Date(strptime(data$Date, "%d/%m/%Y")) >= "2007-02-01" & as.Date(strptime(data$Date, "%d/%m/%Y")) <= "2007-02-02",]
selection[selection == "?"] = NA

y <- strptime(selection$Time, format = "%H:%M:%S")
z <- strptime(selection$Date, "%d/%m/%Y")
v <- strptime(paste(z, strftime(y, "%H:%M:%S")), "%Y-%m-%d %H:%M:%S")

p <- data.frame(v, selection$Sub_metering_1, selection$Sub_metering_2, selection$Sub_metering_3, stringsAsFactors = FALSE)
names(p) <- c("DateTime", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

png(file="plot3.png")
with(p, plot(DateTime, Sub_metering_1, main="", xlab="", ylab="Energy sub metering", ylim=c(0,40), type="l", yaxp = c(0, 30, 3)))
with(p, lines(DateTime, Sub_metering_2, col="red", type="l"))
with(p, lines(DateTime, Sub_metering_3, col="blue", type="l"))
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()