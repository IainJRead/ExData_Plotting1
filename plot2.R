library(dplyr)
library(lubridate)

# Grab the required subset of data and name appropriately
power_data <- read.table("household_power_consumption.txt", skip= 66637, nrows=2881, sep=";")
colnames(power_data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

power_data <- mutate(power_data, DateTime = with(power_data, dmy(Date) + hms(Time)))
power_data <- mutate(power_data, ElapsedSeconds=unclass(DateTime)-unclass(DateTime[1]))

# global active power vs datetime
power_data <- mutate(power_data, Day = wday(DateTime, label=TRUE))

midnights <- power_data$ElapsedSeconds[which(power_data$Time == "00:00:00")]
days <- unique(power_data$Day)

png(filename="plot2.png", width=480, height=480, units='px')
plot(x = power_data$ElapsedSeconds,
     y = power_data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     xaxt = "n")
axis(1,
     at = midnights,
     labels=days)

dev.off()