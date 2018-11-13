library(ggplot2)

SCC <- readRDS("./exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
FEI <- readRDS("./exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

emmisionsList <- as.numeric(SCC$Emissions)
yearList <- SCC$year
fipsList <- SCC$fips
sourceListBalt <- SCC$SCC[SCC$fips == "24510"]
sourceListLA <- SCC$SCC[SCC$fips == "06037"]

rows<-grep("motor|vehicle",names(table(FEI$Short.Name)), ignore.case = TRUE)
codes<-FEI[rows,1]

emmisionsBaltimorePre <- emmisionsList[fipsList == "24510"]
yearBaltimorePre <- yearList[fipsList == "24510"]
emmisionsLACountyPre <- emmisionsList[fipsList == "06037"]
yearLACountyPre <- yearList[fipsList == "06037"]


emmisionsBaltimore <- emmisionsBaltimorePre[sourceListBalt %in% codes]
yearBaltimore <- yearBaltimorePre[sourceListBalt %in% codes]
emmisionsLACounty <- emmisionsLACountyPre[sourceListLA %in% codes]
yearLACounty <- yearLACountyPre[sourceListLA %in% codes]


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
