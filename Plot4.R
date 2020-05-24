library(dplyr)
library(datasets)

plotsData<-read.csv("household_power_consumption.txt", sep=";",header=TRUE, na.strings="?", stringsAsFactors=FALSE)
#removoing NAs
plotsDatacleanedNA<-na.omit(plotsData)
#subseting data to: "we will only be using data from the dates 2007-02-01 and 2007-02-02."
plotsDataSubset<- plotsDatacleanedNA  %>% mutate(Date = as.Date( plotsDatacleanedNA $Date, format ="%d/%m/%Y"))%>% filter(Date>=("2007-02-01") & Date<=("2007-02-02"))
 
#converting all columns exept Date/Time columns, from factor to numeric
plotsDataSubset$Global_active_power<-as.numeric(as.character(plotsDataSubset$Global_active_power))
plotsDataSubset$Global_reactive_power<-as.numeric(as.character(plotsDataSubset$Global_reactive_power))
plotsDataSubset$ Sub_metering_1<-as.numeric(as.character(plotsDataSubset$ Sub_metering_1))
plotsDataSubset$ Sub_metering_2<-as.numeric(as.character(plotsDataSubset$ Sub_metering_2))
plotsDataSubset$ Sub_metering_3<-as.numeric(as.character(plotsDataSubset$ Sub_metering_3))
plotsDataSubset$Global_intensity<-as.numeric(as.character(plotsDataSubset$Global_intensity))
plotsDataSubset$Voltage<-as.numeric(as.character(plotsDataSubset$Voltage))

#Creating DateTime column
plotsDataSubset$DateTime<-strptime(paste(plotsDataSubset$Date,plotsDataSubset$Time),"%S %F %T")

#creating sub plot for DateTime, Global_active_power
par(mfrow=c(2,2),mar=c(4,4,2,2))
plot(plotsDataSubset$DateTime, plotsDataSubset$Global_active_power, ylab= "Global Active Power (kilowatts)", xlab="", type='l')
#creating plot for DateTime, Voltage 
plot(plotsDataSubset$DateTime, plotsDataSubset$Voltage, ylab= "Voltage", xlab="datetime", type='l')

#creating sub plot for DateTime,  Sub_metering_*
plot(plotsDataSubset$DateTime, plotsDataSubset$Sub_metering_1, ylab= "Energy sub metering", xlab="", col="black",type='l')
points(plotsDataSubset$DateTime, plotsDataSubset$Sub_metering_2, col="red", type="l")
points(plotsDataSubset$DateTime, plotsDataSubset$Sub_metering_3, col="blue", type="l")
legend('topright' ,col=c("black","red","blue"),lwd=1,legend=names(plotsDataSubset[,7:9]))

#creating sub plot for DateTime, Global_active_power
plot(plotsDataSubset$DateTime, plotsDataSubset$Global_reactive_power, ylab= "Global_reactive_power", xlab="datetime", type='l')
#saving plot4 to plot4.png
dev.copy(png,file="plot4.png",width=480, height=480)
dev.off()
dev.off()

