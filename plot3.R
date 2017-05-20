# before running this function - make sure to set working directory of your R where you have downloaded the txt file "household_power_consumption.txt"

plot3 <- function() {
  # reading the data from txt file with ";" as separator option and reading columns without factors
  
  data <- read.csv("./household_power_consumption.txt",sep=";",stringsAsFactors = FALSE)
  # converting Date column from character to "Date" type 
  data$Date = as.Date(data$Date,format='%d/%m/%Y')
  library(dplyr)
  # filtering the data as per the required date range
  subData <- filter(data,(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")) )
  # converting Global Active power to numeric as histogram on this column can work only if this is numeric
  
  subData$Global_active_power <- as.numeric(subData$Global_active_power)
  
  # combining two columns from source data into one DateTime column
  DateTimeCol <- paste(as.character(subData$Date),subData$Time)
  DateTimeCol1 <- strptime(DateTimeCol,"%Y-%m-%d %H:%M:%S")
  # appending new DateTimecol to the data frame
  subData <- cbind(DateTimeCol1,subData)
  
  png("plot3.png", width=480, height=480, units="px")
  
  # drawing the plot without drawing the line first
  
  with(subData,plot(DateTimeCol1,Sub_metering_1,type="n",ylab="Energy Sub Metering",xlab=""))
  
  
  # now drawing the lines for each Sub metering value
  
  with(subData, points(DateTimeCol1, Sub_metering_1,type="l"))
  with(subData, points(DateTimeCol1, Sub_metering_2,type="l",col="red"))
  with(subData, points(DateTimeCol1, Sub_metering_3,type="l",col="blue"))
  
  # adding legend on the top right
  
  legend("topright", col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1)
  
  # closing device connection
  dev.off()
}