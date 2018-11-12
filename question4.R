library(ggplot2)

FEI <- readRDS("./exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")
SCC <- readRDS("./exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")

rows<-grep("Coal|coal",names(table(FEI$Short.Name)))
codes<-FEI[rows,1]

emmisionsList <- as.numeric(SCC$Emissions)
yearList <- SCC$year
sourceList <- SCC$SCC

emmisions <- emmisionsList[sourceList %in% codes]
year <- yearList[sourceList %in% codes]

newData <- data.frame(emmisions, year)

aggDat<- aggregate(newData[,1], by=list(newData[,2]), FUN=sum)


plot <- qplot(data=aggDat, x=aggDat$Group.1, y=aggDat$x)
plot <- plot + xlab("Year")
plot <- plot + ylab("Total Emmissions (tons)")