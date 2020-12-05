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


#plotting, and then saving it as a png file
with(data, plot(x = Datetime, y = Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "",  type = "l", lty = 1))
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()