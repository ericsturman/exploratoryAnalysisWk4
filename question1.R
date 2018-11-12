SCC <- readRDS("./exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")

newData <- data.frame(emmisions=as.numeric(SCC$Emissions), years=SCC$year)

sumsByYear<- aggregate(newData[,1], by=list(newData$years), FUN=sum)

png(filename = "plot1.png",height=480, width=480)
plot(sumsByYear[,1], sumsByYear[,2], xlab="Year", ylab="Emmisions (tons)", main="Emmisions by Year (All Cities)")
dev.off()
