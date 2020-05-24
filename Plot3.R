library(dplyr)
library(datasets)

plotsData<-read.csv("household_power_consumption.txt", sep=";",header=TRUE, na.strings="?", stringsAsFactors=FALSE)
#removoing NAs
plotsDatacleanedNA<-na.omit(plotsData)
#subseting data to: "we will only be using data from the dates 2007-02-01 and 2007-02-02."
plotsDataSubset<- plotsDatacleanedNA  %>% mutate(Date = as.Date( plotsDatacleanedNA $Date, format ="%d/%m/%Y"))%>% filter(Date>=("2007-02-01") & Date<=("2007-02-02"))
 
 
#converting Sub_metering_* colums from factor to numeric
plotsDataSubset$ Sub_metering_1<-as.numeric(as.character(plotsDataSubset$ Sub_metering_1))
plotsDataSubset$ Sub_metering_2<-as.numeric(as.character(plotsDataSubset$ Sub_metering_2))
plotsDataSubset$ Sub_metering_3<-as.numeric(as.character(plotsDataSubset$ Sub_metering_3))

#Creating DateTime column
plotsDataSubset$DateTime<-strptime(paste(plotsDataSubset$Date,plotsDataSubset$Time),"%S %F %T")

#creating plot for DateTime,  Sub_metering_*
par(mfrow=c(1,1),mar=c(4,4,4,2))
plot(plotsDataSubset$DateTime, plotsDataSubset$Sub_metering_1, ylab= "Energy sub metering", xlab="", col="black",type='l')
points(plotsDataSubset$DateTime, plotsDataSubset$Sub_metering_2, col="red", type="l")
points(plotsDataSubset$DateTime, plotsDataSubset$Sub_metering_3, col="blue", type="l")
legend("topright", col=c("black","red","blue"),lwd=1,legend=names(plotsDataSubset[,7:9]))
#saving plot3 to plot3.png
dev.copy(png,file="plot3.png",width=480, height=480)
dev.off()
dev.off()
 