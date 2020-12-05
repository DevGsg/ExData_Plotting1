#Set working director
setwd("~/GitHub/ExData_Plotting1")
#Reading the dataset into R
df <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
#How large is df?
byte <- object.size(df)
megabyte <- byte/(1000000)
#converting into tbl
library(dplyr)
df <- as_tibble(df)
#converting into date/time classes and filtering between dates 2007-02-01 and 2007-02-02
library(lubridate)
library(hms)
data <- df %>% mutate(Date = dmy(Date)) %>%
  mutate(Time = parse_hms(Time)) %>%
  filter(between(Date, (as.Date("2007-02-01")),(as.Date("2007-02-02"))))

#plotting a histogram, and then saving it as a png file
with(data, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power"))
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
         




