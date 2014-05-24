
# Exploratory Data Analysis
# Course Project
#
# Plot 5 - Motor Vehicle Emissions in Baltimore

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

onroad_scc <- data.frame(SCC = SCC$SCC[grep('On-Road',SCC$EI.Sector)])
onroad_data <- merge(NEI,onroad_scc,by.x="SCC",by.y="SCC")
onroad_totals <- aggregate(Emissions ~ year + fips, data=onroad_data,sum)
baltimore_onroad <- onroad_totals[onroad_totals$fips == '24510',]

#plot5
plot(baltimore_onroad$year,baltimore_onroad$Emissions,
     type='b',main='Motor Vehicle Emissions in Baltimore',
     xlab='Year',ylab='Emissions')

# Create the plotfile
dev.copy(png,file="plot5.png")
dev.off()


