library(ggplot2)

SCC <- readRDS("./exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")

emmisionsList <- as.numeric(SCC$Emissions)
yearList <- SCC$year
fipsList <- SCC$fips
typeList <- SCC$type

emmisionsBaltimore <- emmisionsList[fipsList == "24510"]
yearBaltimore <- yearList[fipsList == "24510"]
typeBaltimore <- typeList[fipsList == "24510"]

newData <- data.frame(emmisionsBaltimore, yearBaltimore, typeBaltimore)

aggDat<- aggregate(newData[,1], by=list(newData$yearBaltimore, newData$typeBaltimore), FUN=sum)

#qplot(aggDat, aes(aggDat$x, aggDat$Group.1))

plot <- qplot(data=aggDat, x=aggDat$Group.1, y=aggDat$x)
plot <- plot + facet_grid(.~aggDat$Group.2)
plot <- plot + xlab("Year")
plot <- plot + ylab("Total Emmissions (tons)")
