data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
selection <- data[as.Date(strptime(data$Date, "%d/%m/%Y")) >= "2007-02-01" & as.Date(strptime(data$Date, "%d/%m/%Y")) <= "2007-02-02",]
selection[selection == "?"] = NA

y <- strptime(selection$Time, format = "%H:%M:%S")
z <- strptime(selection$Date, "%d/%m/%Y")
v <- strptime(paste(z, strftime(y, "%H:%M:%S")), "%Y-%m-%d %H:%M:%S")


p1 <- data.frame(v, selection$Global_active_power, selection$Sub_metering_1, selection$Sub_metering_2, selection$Sub_metering_3, selection$Voltage, selection$Global_reactive_power, stringsAsFactors = FALSE)
names(p1) <- c("DateTime","Global_active_power","Sub_metering_1","Sub_metering_2","Sub_metering_3","Voltage","Global_reactive_power")

png(file="plot4.png")
par(mfcol = c(2,2))
with(p1, {
  plot(DateTime, Global_active_power, type="l", main="", xlab="", ylab="Global Active Power (Kilowatts)")
  plot(DateTime, Sub_metering_1, main="", xlab="", ylab="Energy sub metering", ylim=c(0,40), type="l", yaxp = c(0, 30, 3))
  lines(DateTime, Sub_metering_2, col="red", type="l")
  lines(DateTime, Sub_metering_3, col="blue", type="l")
  legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n")
  plot(DateTime, Voltage, type="l", main="", xlab="datetime", ylab="Voltage")
  plot(DateTime, Global_reactive_power, type="l", main="", xlab="datetime", ylab="Global_reactive_power")
})
dev.off()