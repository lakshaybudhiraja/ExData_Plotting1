setwd("C:/Users/Lakshay/Desktop/CourseraR/111")
getwd()
t <- read.table("household_power_consumption.txt", 
                header=TRUE, sep=";", na.strings = "?", 
                colClasses = 
                  c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
t$Date <- as.Date(t$Date, "%d/%m/%Y")     ## Format date to Type Date

t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))    ## Filter data set from Feb. 1, 2007 to Feb. 2, 2007


t <- t[complete.cases(t),]  ## Remove incomplete observation


dateTime <- paste(t$Date, t$Time)   ## Combine Date and Time column




dateTime <- setNames(dateTime, "DateTime")    ## Name the vector



t <- t[ ,!(names(t) %in% c("Date","Time"))]   ## Remove Date and Time column



t <- cbind(dateTime, t)     ## Add DateTime column


t$dateTime <- as.POSIXct(dateTime)     ## Format dateTime Column

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(t, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png, file="plot4.png", height=480, width=480)

dev.off()
