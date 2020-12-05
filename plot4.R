#Set working director
setwd("~/GitHub/ExData_Plotting1")
#Reading the dataset into R
df <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
#How large is df?
byte <- object.size(df)
megabyte <- byte/(1000000)
print(megabyte)
#converting into tibble and converting the required range of dates into datetime
library(dplyr)
library(lubridate)
df <- as_tibble(df, na.rm = TRUE)
initialdate <- strptime("01/02/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S")
finaldate <- strptime("03/02/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S")

#using pipes to convert the date and time column into a single character and then converting into datetime
#adding a weekday column and filtering to the the range between the required dates
data <- df %>% mutate(Datetime = strptime(paste(Date,Time),format = "%d/%m/%Y %H:%M:%S")) %>%
  mutate(weekday = wday(Datetime, label = TRUE))%>%
  filter(between(Datetime, initialdate, finaldate)) 

#plotting and saving to PNG file
par(mfrow = c(2,2), mar= c(4,4,2,2))
#plot1
with(data, plot(Datetime, Global_active_power, ylab = "Global Active Power", xlab = "",  type = "l", lty = 1))
#plot 2
with(data, plot(Datetime, Voltage, xlab = "datetime", ylab = "Voltage", type = "l", lty = 1))
#plot 3
with(data, plot(x = Datetime, y = Sub_metering_1, xlab="", ylab = "Energy sub metering", col = "black", type = "l"))
lines(x = data$Datetime, y = data$Sub_metering_2, col = "red")
lines(x = data$Datetime, y = data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, cex = 0.4, pt.cex = 1.5, bty = "n")
#plot 4
with(data, plot(Datetime, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l", lty = 1, lwd = 0.5))

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
