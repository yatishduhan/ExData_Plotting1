# This function creates histogram representing Global Active Power frequency
# before running this function - make sure to set working directory of your R where you have downloaded the txt file "household_power_consumption.txt"

plot1 <- function() {
# reading the data from txt file with ";" as separator option and reading columns without factors
  
    data <- read.csv("./household_power_consumption.txt",sep=";",stringsAsFactors = FALSE)
    # converting Date column from character to "Date" type 
data$Date = as.Date(data$Date,format='%d/%m/%Y')
library(dplyr)
# filtering the data as per the required date range
subData <- filter(data,(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")) )
# converting Global Active power to numeric as histogram on this column can work only if this is numeric

subData$Global_active_power <- as.numeric(subData$Global_active_power)
# drawing hist with parameters of col and axis labels
hist(subData$Global_active_power,main="Global Active Power", col="Red",xlab="Global Active Power(kilowatts)")

# calling dev copy that will move hist from my screen to png file
dev.copy(png, file="plot1.png", width=480, height=480)
# closing device connection
dev.off()
}