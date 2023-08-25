# Grab the required subset of data and name appropriately
power_data <- read.table("household_power_consumption.txt", skip= 66637, nrows=2880, sep=";")
colnames(power_data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Create a graphics device and populate with a histogram of global active power
png(filename="plot1.png", width=480, height=480, units='px')
with(power_data, hist(power_data$Global_active_power,
                      col='red',
                      xlab="Global Active Power (kilowatts)",
                      main="Global Active Power"))
dev.off()