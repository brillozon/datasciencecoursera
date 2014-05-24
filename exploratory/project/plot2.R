
# Exploratory Data Analysis
# Course Project
#
# Plot 2 - Total Emmissions in Baltimore City

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

baltimore_totals <- aggregate(NEI[NEI$fips=='24510','Emissions'],list(NEI[NEI$fips=='24510','year']),sum)
names(baltimore_totals) <- c('Year','Emissions')

#plot2
plot(baltimore_totals,type='b',main='Total Emmissions at Baltimore, MD')

# Create the plotfile
dev.copy(png,file="plot2.png")
dev.off()

