## generate plot3 for Exploratory Data Analysis Assignment 1
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

## plot 3: time series of sub metering
#find range (acknowledgment: http://cran.r-project.org/doc/contrib/Lemon-kickstart/kr_addat.html)
yrange<-range(c(data2$Sub_metering_1,data2$Sub_metering_2,data2$Sub_metering_3))

png(file="plot3.png",width=480,height=480)
plot(data2$datetime,data2$Sub_metering_1,ylim=yrange,type="l",col="black",xlab="",ylab="Energy sub metering")
lines(data2$datetime,data2$Sub_metering_2,col="red")
lines(data2$datetime,data2$Sub_metering_3,col="blue")
legend("topright",colnames(data2)[7:9],col=c("black","red","blue"),lwd=1)
dev.off()
