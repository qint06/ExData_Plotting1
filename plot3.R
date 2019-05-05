dataTable <- read.table('household_power_consumption.txt', header = TRUE, sep = ';', na.strings ='?')


dataTable$Date <- as.Date(dataTable$Date, '%d/%m/%Y')

dataTable <- dataTable[dataTable$Date >= as.Date('2007-2-1') & dataTable$Date <= as.Date('2007-2-2'), ]

dateTime <- strptime(paste(dataTable$Date, dataTable$Time, sep=""),"%Y-%m-%d %H:%M:%S")

dataTable <- dataTable[ ,!(names(dataTable) %in% c("Date","Time"))]

dataTable <- cbind(dateTime, dataTable)

dataTable$Datetime <- as.POSIXct(dateTime)
Sys.setlocale("LC_TIME", "English")

with(dataTable, {
    plot(Sub_metering_1 ~ Datetime, type = "l", 
    ylab = "Energy sub metering", xlab = "")
    lines(Sub_metering_2 ~ Datetime, col = 'Red')
    lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lwd = 2, 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png,"plot3.png", width=480, height=480)

dev.off()