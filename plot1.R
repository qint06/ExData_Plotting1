dataTable <- read.table('household_power_consumption.txt', header = TRUE, sep = ';', na.strings ='?')

dataTable$Date <- as.Date(dataTable$Date, '%d/%m/%Y')

dataTable <- dataTable[dataTable$Date >= as.Date('2007-2-1') & dataTable$Date <= as.Date('2007-2-2'), ]

dateTime <- strptime(paste(dataTable$Date, dataTable$Time, sep=" "),"%d/%m/%Y %H:%M:%S")

dataTable <- dataTable[ ,!(names(dataTable) %in% c("Date","Time"))]

dataTable <- cbind(dateTime, dataTable)

hist(dataTable$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.copy(png,"plot1.png", width=480, height=480)

dev.off()