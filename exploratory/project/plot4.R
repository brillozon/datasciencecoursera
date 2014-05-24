
# Exploratory Data Analysis
# Course Project
#
# Plot 4 - Coal Combustion Emissions

dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFile <- "data/NEI_data.zip"
dataFile <- "summarySCC_PM25.rds"
classFile <- "Source_Classification_Code.rds"

if(!file.exists('data')) {
  dir.create('data')
}

if(!file.exists(zipFile)) {
  download.file(dataUrl, destfile = zipFile, method = 'curl')
  download_date <- date()
  unzip(zipFile,exdir="./data")
}

#NEI <- readRDS(unz(zipFile,dataFile))
#SCC <- readRDS(unz(zipFile,classFile))

NEI <- readRDS(paste("data/",dataFile,sep=""))
SCC <- readRDS(paste("data/",classFile,sep=""))

coal_scc <- data.frame(SCC = SCC$SCC[grep('[Cc]oal',SCC$EI.Sector)])
coal_data <- merge(NEI,coal_scc,by.x="SCC",by.y="SCC")
coal_totals <- aggregate(Emissions ~ year, data=coal_data,sum)

#plot4
plot(coal_totals,type="b",
     main='Total Emissions from Coal Combustion', xlab="Year")

# Create the plotfile
dev.copy(png,file="plot4.png")
dev.off()

