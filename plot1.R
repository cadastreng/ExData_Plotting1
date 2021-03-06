#####################################################################
## Course: 04_ExploratoryAnalysis
## Authors: Jeff Leek, PhD, Roger D. Peng, PhD, Brian Caffo, PhD
## MOOC Provider: Coursera
## Month_Year: December, 2014
## Course Project 1
##
## plot1.R
## This program downloads the source data set, reads it and creates  
## a histogram for Global_active_power variable
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

## Open PNG device and create 'plot1.png' in the working directory
png(filename = "plot1.png") # Width and height are equal 480 px by default

## Create plot and send to a file (no plot appears on screen)
hist(data$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

## Close the PNG file device
dev.off() 

