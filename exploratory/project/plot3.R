
# Exploratory Data Analysis
# Course Project
#
# Plot 3 - Baltimore Emissions by Type

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

baltimore_data <- NEI[NEI$fips == '24510',]
baltimore_data$type = factor(baltimore_data$type)
baltimore_data$Pollutant = factor(baltimore_data$Pollutant)
baltimore_type_totals <- aggregate(Emissions ~ type + year, data=baltimore_data,sum)

#plot3
library(ggplot2)
qplot(year,Emissions,data=baltimore_type_totals,
      facets=type~.,
      geom=c('path','point')) +
  labs(title='Emissions by Type\nin Baltimore', x = 'Year')

# Create the plotfile
dev.copy(png,file="plot3.png")
dev.off()


