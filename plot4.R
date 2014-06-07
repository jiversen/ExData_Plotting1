## generate plot1 for Exploratory Data Analysis Assignment 1
## John Iversen, 6/2014

## =============================
## === Load and prepare data ===
## =============================

## read data 
#   (truncate around where our date of interest ends to save some time; could pick out
#   the exact rows but that's less fun)
#   use colClasses to speed up read, and leave date/time as characters
data <- read.table("household_power_consumption.txt", sep=";",header=TRUE,na.strings="?",
                   colClasses=c("character","character","numeric","numeric","numeric",
                                "numeric","numeric","numeric","numeric"),stringsAsFactors=FALSE,nrows=70000)

## convert dates to Date objects, so we can do comparisons
data$Date <- as.Date(data$Date, '%d/%m/%Y')

## subset dates of interest
data2 <- subset(data,data$Date>="2007-02-01" & data$Date<="2007-02-02")

## create POSIXct time objects
#  rename, since plot 4 shows that they created a new column called datetime
data2$datetime <- paste(as.character(data2$Date),data2$Time,sep=" ")
data2$datetime <- strptime(data2$datetime,format="%Y-%m-%d %H:%M:%S") 

## =====================
## === Make the Plot ===
## =====================

#plot 4: 4 panel plot
png(file="plot4.png",width=480,height=480)
par(mfcol=c(2,2))

#first two plots are (nearly) the same as plot 1 and 3
#global active power timeseries
plot(data2$datetime, data2$Global_active_power,xlab="",ylab="Global Active Power",type="l")

#sub metering time series
yrange<-range(c(data2$Sub_metering_1,data2$Sub_metering_2,data2$Sub_metering_3))
plot(data2$datetime,data2$Sub_metering_1,ylim=yrange,type="l",col="black",xlab="",ylab="Energy sub metering")
lines(data2$datetime,data2$Sub_metering_2,col="red")
lines(data2$datetime,data2$Sub_metering_3,col="blue")
legend("topright",colnames(data2)[7:9],col=c("black","red","blue"),lwd=1,bty="n")

#next two plots are new, but they didn't customize axis labels
# and they probably used with(data2,...) judging from labels
#voltage time series
with(data2, plot(datetime, Voltage,type="l"))

#global reactive power time series
with(data2,plot(datetime, Global_reactive_power,type="l"))
dev.off()

par(mfcol=c(1,1))


