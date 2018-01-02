plot3 <- function() {
    # Load the lubridate package if not already installed.
    install.packages('lubridate')
    library(lubridate)
    
    # Install ggplot2 if not already installed.
    install.packages('ggplot2')
    library(ggplot2)
    
    # Download the Dataset
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
                  'dataset.zip')
    # Unzip the file
    unzip('dataset.zip')
    
    # Import the data.
    complete_data <- read.csv('household_power_consumption.txt',
                              sep=';')
    
    # Convert Date into Date class so we can subset it.
    complete_data$Date <- as.Date(complete_data$Date, '%d/%m/%Y')
    
    
    # Subset the data so that we get data from 2007
    wanted_data <- subset(complete_data, year(complete_data$Date) == 2007)
    
    # Subset the data so that we can data from Feb.
    wanted_data <- subset(wanted_data, month(wanted_data$Date) == 2)
    
    # Subset the data so that we can the data from Thursday, Friday, and Saturday.
    wanted_data2 <- subset(wanted_data, wanted_data$Date == '2007-02-01' |
                               wanted_data$Date == '2007-02-02')
    
    # Get rid of any NAs.
    wanted_data2 <- wanted_data2[complete.cases(wanted_data2),]
    
    # Change Sub_meterings into a numeric vector
    wanted_data2$Sub_metering_1 <- as.numeric(as.character(wanted_data2$Sub_metering_1))
    wanted_data2$Sub_metering_2 <- as.numeric(as.character(wanted_data2$Sub_metering_2))
    wanted_data2$Sub_metering_3 <- as.numeric(as.character(wanted_data2$Sub_metering_3))
    
    # Find the first instance of Thursday and Friday
    a <- match('Thurs', wday(wanted_data2$Date, label = TRUE))
    b <- match('Fri', wday(wanted_data2$Date, label = TRUE))
    
    
    # Get rid of any NAs.
    wanted_data2 <- wanted_data2[complete.cases(wanted_data2),]
    
    # Crate Plot 3, a line graph of the Sub Meterings
    png('plot3.png', width = 480, height = 480)
    plot(wanted_data2$Sub_metering_1, 
         type='l', 
         xlab = '',
         ylab = 'Energy sub metering',
         xaxt='n')
    points(wanted_data2$Sub_metering_2,
           type='l',
           col='red')
    points(wanted_data2$Sub_metering_3,
           type='l',
           col='blue')
    legend('topright',
           c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
           lty=1,
           lwd=2.5,
           col=c('black', 'red', 'blue'))
    # Change the x-axis tick marks
    axis(side=1, at=c(a,b,2880), labels=c('Thu', 'Fri', 'Sat'))
    dev.off()
    
}