
# Exploratory Data Analysis
# Course Project
#
# Plot 6 - Emissions comparison between LA County and Baltimore

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
la_onroad <- onroad_totals[onroad_totals$fips == '06037',]

#plot6
library(ggplot2)
## qplot(year,Emissions,data=rbind(baltimore_onroad,la_onroad),facets=.~fips,geom=c('path','point'))
ggplot() +
  geom_path(data=baltimore_onroad,aes(x=year,y=Emissions,color="Baltimore")) +
  geom_point(data=baltimore_onroad,aes(x=year,y=Emissions)) +
  geom_path(data=la_onroad,aes(x=year,y=Emissions,color="LA County")) +
  geom_point(data=la_onroad,aes(x=year,y=Emissions)) +
  theme(legend.title = element_text('Location')) +
  labs(title = 'Vehicle Emissions by Location', x = 'Year') +
  scale_colour_manual(name = 'Locations',
                      breaks = c('Baltimore','LA County'),
                      values = c('blue','red'))
  
# Create the plotfile
dev.copy(png,file="plot6.png")
dev.off()

