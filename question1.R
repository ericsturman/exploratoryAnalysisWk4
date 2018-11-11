SCC <- readRDS("./exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")

emmisionsList <- as.numeric(SCC$Emissions)
yearList <- SCC$year

emmisions1999 <- emmisionsList[yearList==1999]
emmisions2002 <- emmisionsList[yearList==2002]
emmisions2005 <- emmisionsList[yearList==2005]
emmisions2008 <- emmisionsList[yearList==2008]

sumsByYear <- data.frame(years=c(1999,2002,2005,2008), emmisionsSum=c(sum(emmisions1999[is.na(emmisions1999)==FALSE]), sum(emmisions2002[is.na(emmisions2002)==FALSE]), sum(emmisions2005[is.na(emmisions2005)==FALSE]), sum(emmisions2008[is.na(emmisions2008)==FALSE])))
png(filename = "plot1.png",height=480, width=480)
plot(sumsByYear$years, sumsByYear$emmisionsSum, xlab="Year", ylab="Emmisions (tons)", main="Emmisions by Year (All Cities)")
dev.off()
