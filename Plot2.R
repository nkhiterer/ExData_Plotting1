library(dplyr)
library(datasets)

plotsData<-read.csv("household_power_consumption.txt", sep=";",header=TRUE, na.strings="?", stringsAsFactors=FALSE)
#removoing NAs
plotsDatacleanedNA<-na.omit(plotsData)
#subseting data to: "we will only be using data from the dates 2007-02-01 and 2007-02-02."
plotsDataSubset<- plotsDatacleanedNA  %>% mutate(Date = as.Date( plotsDatacleanedNA $Date, format ="%d/%m/%Y"))%>% filter(Date>=("2007-02-01") & Date<=("2007-02-02"))

#converting Global_active_power from factor to numeric
plotsDataSubset$Global_active_power<-as.numeric(as.character(plotsDataSubset$Global_active_power))

#Creating DateTime column
plotsDataSubset$DateTime<-strptime(paste(plotsDataSubset$Date,plotsDataSubset$Time),"%S %F %T")

#creating plot for DateTime, Global_active_power
par(mfrow=c(1,1),mar=c(4,4,4,2))
plot(plotsDataSubset$DateTime, plotsDataSubset$Global_active_power, ylab= "Global Active Power (kilowatts)", xlab="", type='l')
#saving plot2 to plot2.png
dev.copy(png,file="plot2.png",width=480, height=480)
dev.off()
dev.off()

