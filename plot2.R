data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
selection <- data[as.Date(strptime(data$Date, "%d/%m/%Y")) >= "2007-02-01" & as.Date(strptime(data$Date, "%d/%m/%Y")) <= "2007-02-02",]
selection[selection == "?"] = NA

y <- strptime(selection$Time, format = "%H:%M:%S")
z <- strptime(selection$Date, "%d/%m/%Y")
v <- strptime(paste(z, strftime(y, "%H:%M:%S")), "%Y-%m-%d %H:%M:%S")

p <- data.frame(v, selection$Global_active_power, stringsAsFactors = FALSE)
names(p) <- c("DateTime", "GAP")

png(file="plot2.png")
plot(p$DateTime, p$GAP, type="l", main="", xlab="", ylab="Global Active Power (Kilowatts)")
dev.off()
