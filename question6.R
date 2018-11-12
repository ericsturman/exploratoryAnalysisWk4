library(ggplot2)

SCC <- readRDS("./exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")

emmisionsList <- as.numeric(SCC$Emissions)
yearList <- SCC$year
fipsList <- SCC$fips

emmisionsBaltimore <- emmisionsList[fipsList == "24510"]
yearBaltimore <- yearList[fipsList == "24510"]
emmisionsLACounty <- emmisionsList[fipsList == "06037"]
yearLACounty <- yearList[fipsList == "06037"]

newDataBaltimore <- data.frame(emmisionsBaltimore, yearBaltimore)
newDataLACounty <- data.frame(emmisionsLACounty, yearLACounty)

aggDatBaltimore<- aggregate(newDataBaltimore[,1], by=list(newDataBaltimore$yearBaltimore), FUN=sum)
aggDatLACounty<- aggregate(newDataLACounty[,1], by=list(newDataLACounty$yearLACounty), FUN=sum)

aggDatLACounty$city="LA County"
aggDatBaltimore$city="Baltimore"

aggDat <- rbind(aggDatBaltimore, aggDatLACounty)

plot <- qplot(data=aggDat, x=aggDat$Group.1, y=aggDat$x)
plot <- plot + facet_grid(.~aggDat$city)
plot <- plot + xlab("Year")
plot <- plot + ylab("Total Emmissions (tons)")

ggsave("plot6.png", width=4, height=4)
