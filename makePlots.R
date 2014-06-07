## generate plots for Assignment 1
## to submit, will need to split into four separate files

#read data (truncate around where our date of interest ends to save some time; could pick out
# the exact rows but that's less fun)
data <- read.table("household_power_consumption.txt", sep=";",header=TRUE,na.strings="?",
                   colClasses=c("character","character","numeric","numeric","numeric",
                    "numeric","numeric","numeric","numeric"),stringsAsFactors=FALSE,nrows=70000)

data$Date <- as.Date(data$Date, '%d/%m/%Y')
#data$Time = strptime(data$Time,format="%H:%M:%S")

## subset dates of interest
data2 <- subset(data,data$Date>="2007-02-01" & data$Date<="2007-02-02")

## create POSIXct time objects
#plot 4 shows that they created a new column called datetime
data2$datetime <- paste(as.character(data2$Date),data2$Time,sep=" ")
data2$datetime <- strptime(data2$datetime,format="%Y-%m-%d %H:%M:%S") 

## plot 1: Histogram of global active power
png(file="test.png",width=480,height=480)
hist(data2$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()

## plot 2: time series of global active power
plot(data2$datetime, data2$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="l")

## plot 3: time series of sub metering
#find range
yrange<-range(c(data2$Sub_metering_1,data2$Sub_metering_2,data2$Sub_metering_3))
plot(data2$datetime,data2$Sub_metering_1,ylim=yrange,type="l",col="black",xlab="",ylab="Energy sub metering")
lines(data2$datetime,data2$Sub_metering_2,col="red")
lines(data2$datetime,data2$Sub_metering_3,col="blue")
legend("topright",colnames(data2)[7:9],col=c("black","red","blue"),lwd=1)

#plot 4: 4 panel plot
par(mfrow=c(2,2))
#global active power timeseries
plot(data2$datetime, data2$Global_active_power,xlab="",ylab="Global Active Power",type="l")

#voltage time series
plot(data2$datetime, data2$Voltage,xlab="datetime",ylab="Voltage",type="l")

#sub metering time series
yrange<-range(c(data2$Sub_metering_1,data2$Sub_metering_2,data2$Sub_metering_3))
plot(data2$datetime,data2$Sub_metering_1,ylim=yrange,type="l",col="black",xlab="",ylab="Energy sub metering")
lines(data2$datetime,data2$Sub_metering_2,col="red")
lines(data2$datetime,data2$Sub_metering_3,col="blue")
legend("topright",colnames(data2)[7:9],col=c("black","red","blue"),lwd=1,bty="n")

#global reactive power time series
plot(data2$datetime, data2$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")
par(mfcol=c(1,1))
