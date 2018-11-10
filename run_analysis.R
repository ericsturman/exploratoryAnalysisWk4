NEI <- readRDS("./exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")
SCC <- readRDS("./exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
#fipsDF <- read.table("./fipsList.txt")
#yearDF <- read.table("./yearList.txt")

fipsList <- as.numeric(SCC$fips)
yearList <- SCC$year



fips1999 <- fipsList[yearList==1999]
fips2002 <- fipsList[yearList==2002]
fips2005 <- fipsList[yearList==2005]
fips2008 <- fipsList[yearList==2008]

sumsByYear <- data.frame(years=c(1999,2002,2005,2008), fipsSum=c(sum(fips1999[is.na(fips1999)==FALSE]), sum(fips2002[is.na(fips2002)==FALSE]), sum(fips2005[is.na(fips2005)==FALSE]), sum(fips2008[is.na(fips2008)==FALSE])))

plot(sumsByYear$years, sumsByYear$fipsSum)

str(NEI)
str(SCC)

summary(NEI)
summary(SCC)

