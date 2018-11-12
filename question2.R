SCC <- readRDS("./exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")

emmisionsList <- as.numeric(SCC$Emissions)
yearList <- SCC$year
fipsList <- SCC$fips

emmisionsBaltimore <- emmisionsList[fipsList == "24510"]
yearBaltimore <- yearList[fipsList == "24510"]

newData <- data.frame(emmisionsBaltimore, yearBaltimore)

aggDat<- aggregate(newData[,1], by=list(newData$yearBaltimore), FUN=sum)

png(filename = "plot2.png",height=480, width=480)
plot(aggDat[,1] , aggDat[,2], xlab="Year", ylab="Emmisions (tons)", main="Emmisions by Year (Baltimore City)")
dev.off()