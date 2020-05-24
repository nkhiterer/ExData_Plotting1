library(dplyr)
library(datasets)

plotsData<-read.csv("household_power_consumption.txt", sep=";",header=TRUE, na.strings="?", stringsAsFactors=FALSE)
#removoing NAs
plotsDatacleanedNA<-na.omit(plotsData)
#subseting data to: "we will only be using data from the dates 2007-02-01 and 2007-02-02."
plotsDataSubset<- plotsDatacleanedNA  %>% mutate(Date = as.Date( plotsDatacleanedNA $Date, format ="%d/%m/%Y"))%>% filter(Date>=("2007-02-01") & Date<=("2007-02-02"))

#adding weekday column 
plotsDataSubset$weekday <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday","Sunday")[as.POSIXlt(plotsDataSubset$Date)$wday]

#converting Global_active_power from factor to numeric
GlobalActivePower<-as.numeric(as.character(plotsDataSubset$Global_active_power))

#Creating histogram for GlobalActivePower
par(mfrow=c(1,1),mar=c(4,4,4,2))
hist(GlobalActivePower, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

#creating png. file
dev.copy(png,file="plot1.png",width=480, height=480)
dev.off()
dev.off(2)
