dataTable <- read.table('household_power_consumption.txt', header = TRUE, sep = ';', na.strings ='?')

dataTable$Date <- as.Date(dataTable$Date, '%d/%m/%Y')

dataTable <- dataTable[dataTable$Date >= as.Date('2007-2-1') & dataTable$Date <= as.Date('2007-2-2'), ]

dateTime <- strptime(paste(dataTable$Date, dataTable$Time, sep=""),"%Y-%m-%d %H:%M:%S")

dataTable <- dataTable[ ,!(names(dataTable) %in% c("Date","Time"))]

dataTable <- cbind(dateTime, dataTable)

dataTable$Datetime <- as.POSIXct(dateTime)
Sys.setlocale("LC_TIME", "English")

 par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
  with(dataTable, {
    plot(Global_active_power~dateTime, type="l", 
         ylab="Global Active Power", xlab="")
    plot(Voltage~dateTime, type="l", 
         ylab="Voltage", xlab="datetime")
    plot(Sub_metering_1~dateTime, type="l", 
         ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~dateTime,col='Red')
    lines(Sub_metering_3~dateTime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~dateTime, type="l", 
         ylab="Global_rective_power",xlab="datetime")
  })

dev.copy(png,"plot4.png", width=480, height=480)

dev.off()