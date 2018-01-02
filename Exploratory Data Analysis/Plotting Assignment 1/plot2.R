plot2 <- function() {
    # Load the lubridate package if not already installed.
    install.packages('lubridate')
    library(lubridate)
    
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
    
    # Change Global_active_power into a numeric vector
    wanted_data2$Global_active_power <- as.numeric(as.character(wanted_data2$Global_active_power))
    
    # Find the first instance of Thursday and Friday
    a <- match('Thurs', wday(wanted_data2$Date, label = TRUE))
    b <- match('Fri', wday(wanted_data2$Date, label = TRUE))
    
    # Crate Plot 2, a line graph of the Global Active Power (kilowatts)
    png('plot2.png', width = 480, height = 480, units = 'px')
    plot(wanted_data2$Global_active_power, 
         type='l', 
         xlab = '',
         ylab = 'Global Active Power (kilowatts)',
         xaxt='n')
    
    # Change the x-axis tick marks
    axis(side=1, at=c(a,b,2880), labels=c('Thu', 'Fri', 'Sat'))
    dev.off()
}