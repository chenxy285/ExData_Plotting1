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