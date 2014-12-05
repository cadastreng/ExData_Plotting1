#####################################################################
## Course: 04_ExploratoryAnalysis
## Authors: Jeff Leek, PhD, Roger D. Peng, PhD, Brian Caffo, PhD
## MOOC Provider: Coursera
## Month_Year: December, 2014
## Course Project 1
##
## plot3.R
## This program downloads the source data set, reads it and creates  
## a plot for Sub_metering variables
## Author: Serguei Mikhailov (@cadastreng), December, 2014
#####################################################################

library(sqldf)

## Set the working directory
setwd("~/Desktop/coursera/04_ExploratoryAnalysis/ExData_Plotting1")

## Clean the working environment
rm(list = ls())
graphics.off()

## Download and unzip the source data set file if it doesn't exist
datadir <- "./data"
fileURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "./data/exdata_data_household_power_consumption.zip"
file <- "./data/household_power_consumption.txt"

if(!file.exists(datadir)) {dir.create(datadir)}
if(!file.exists(file)) {
        download.file(fileURL, destfile = zipfile, method = "curl")
        unzip(zipfile, exdir = "./data")
}

## Read the data set with read.csv.sql() from 'sqldf' package
data <- read.csv.sql(file, 
                     sql = "select * from file 
                     where Date == '1/2/2007' or Date == '2/2/2007'",
                     header = TRUE, 
                     sep = ";")

## Check a structure of the 'data' data frame with str() function.
## A type of the Date and Time variables is 'character' so we can to join them
str(data)

## Join the Date and Time variables, convert new string to Date/Time (POSIXlt) 
## class and add new datetime variable to 'data' data frame
data$datetime <- strptime(paste(data$Date, data$Time), 
                          format = "%d/%m/%Y %H:%M:%S")

## Open PNG device and create 'plot3.png' in the working directory
png(filename = "plot3.png") # Width and height are equal 480 px by default

## Create plot and send to a file (no plot appears on screen)
plot(data$datetime, data$Sub_metering_1, type = "l", xlab = "", 
     ylab = "Energy sub metering")
lines(data$datetime, data$Sub_metering_2, type = "l", col = "red")
lines(data$datetime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend =c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close the PNG file device
dev.off() 
