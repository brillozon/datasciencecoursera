
# Exploratory Data Analysis
# Course Project
#
# Plot 1 - Total Emissions in US

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

# plot1
emission_totals <- aggregate(NEI$Emissions,list(NEI$year),sum)
names(emission_totals) <- c('Year','Emissions')
plot(emission_totals,type='b',main='Total Emmissions over Time')

# Create the plotfile
dev.copy(png,file="plot1.png")
dev.off()

