
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
selection <- data[as.Date(strptime(data$Date, "%d/%m/%Y")) >= "2007-02-01" & as.Date(strptime(data$Date, "%d/%m/%Y")) <= "2007-02-02",]
selection[selection == "?"] = NA

cleaned <- as.numeric(selection[,"Global_active_power"])

png(file="plot1.png")
hist(cleaned, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
