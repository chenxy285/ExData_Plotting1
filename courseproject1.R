# 1. Read the data into R

data<-read.table("./exdata_data_household_power_consumption/household_power_consumption.txt",
                 sep=";",header=TRUE)
str(data)
View(data)


# 2. Convert the Date and Time variables to Date/Time classes

data$Date<-as.Date(data$Date,"%d/%m/%Y")
data$Time<-format(strptime(data$Time, "%H:%M:%S"),"%H:%M:%S")


# 3. Extract the data from '2007-02-01' to '2007-02-02'

data1<-data[which(data$Date %in% c(as.Date('2007-02-01'),as.Date('2007-02-02'))),]
View(data1)
str(data1)


# 4. Convert some variables into numeric
data1$Global_reactive_power<-as.numeric(data1$Global_reactive_power)
data1$Global_active_power<-as.numeric(data1$Global_active_power)


# 5. Construct plots and create PNG files

## Plot1:
par(mfrow=c(1,1))
hist(data1$Global_active_power,
     col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.copy(png,file="plot1.png",width = 480, height = 480,units = "px")
dev.off()


## Plot2:

# Construct variable of weekdays
data1$weekdays<-weekdays(data1$Date)
# get the location of axis labels
table(data1$weekdays)
# construct plots
with(data1,plot(Global_active_power,type="n",
                ylab="Global Active Power (kilowatts)",xlab="",xaxt="n"))
with(data1,lines(Global_active_power))
axis(side=1,at=c(0,1441,2880),labels=c("Thu","Fri","Sat"))
dev.copy(png,file="plot2.png",width = 480, height = 480,units = "px")
dev.off()

## Plot3:

with(data1,plot(Sub_metering_1,type="n",
                ylab="Energy sub metering",xlab="",xaxt="n"))
with(data1,lines(Sub_metering_1))
with(data1,lines(Sub_metering_2,col="red"))
with(data1,lines(Sub_metering_3,col="blue"))
axis(side=1,at=c(0,1441,2880),labels=c("Thu","Fri","Sat"))
legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png,file="plot3.png",width = 480, height = 480,units = "px")
dev.off()

## Plot4:

par(mfrow=c(2,2),mar=c(4, 4.1,2,2.1))

# plot(1)
with(data1,plot(Global_active_power,type="n",
                ylab="Global Active Power",xlab="",xaxt="n"))
with(data1,lines(Global_active_power))
axis(side=1,at=c(0,1441,2880),labels=c("Thu","Fri","Sat"))

# plot(2)
with(data1,plot(Voltage,type="n",
                ylab="Voltage",xlab="",xaxt="n"))
with(data1,lines(Voltage))
axis(side=1,at=c(0,1441,2880),labels=c("Thu","Fri","Sat"))
mtext("datetime",side=1,line=2.5,cex=0.8)

# plot(3)
with(data1,plot(Sub_metering_1,type="n",
                ylab="Energy sub metering",xlab="",xaxt="n"))
with(data1,lines(Sub_metering_1))
with(data1,lines(Sub_metering_2,col="red"))
with(data1,lines(Sub_metering_3,col="blue"))
axis(side=1,at=c(0,1441,2880),labels=c("Thu","Fri","Sat"))
legend("topright",lty=1,col=c("black","red","blue"),bty = "n",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# plot(4)
with(data1,plot(Global_reactive_power,type="n",
                ylab="Global_reactive_power",xlab="",xaxt="n"))
with(data1,lines(Global_reactive_power))
axis(side=1,at=c(0,1441,2880),labels=c("Thu","Fri","Sat"))
mtext("datetime",side=1,line=2.5,cex=0.8)

# write plots into png
dev.copy(png,file="plot4.png",width = 480, height = 480,units = "px")
dev.off()