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

png(filename="plot4.png", width=480, height=480, units='px')

par(mfrow = c(2, 2))

# top left plot
with(power_data, plot(x = ElapsedSeconds,
                      y = Global_active_power,
                      type = "l",
                      xlab = "",
                      ylab = "Global Active Power",
                      xaxt = "n"))
axis(1,
     at = midnights,
     labels=days)

# top right plot
with(power_data, plot(x = ElapsedSeconds,
                      y = Voltage,
                      type = "l",
                      xlab = "datetime",
                      ylab = "Voltage",
                      xaxt = "n"))
axis(1,
     at = midnights,
     labels=days)

# bottom left plot
with(power_data, plot(x = ElapsedSeconds,
                      y = Sub_metering_1,
                      type = "l",
                      xlab = "",
                      ylab = "Energy sub metering",
                      xaxt = "n"))
axis(1,
     at = midnights,
     labels=days)
with(power_data, lines(x = ElapsedSeconds,
                       y = Sub_metering_2,
                       col='red'))

with(power_data, lines(x = ElapsedSeconds,
                       y = Sub_metering_3,
                       col='blue'))
legend("topright", lty=c("solid", "solid", "solid"), col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# bottom right plot
with(power_data, plot(x = ElapsedSeconds,
                      y = Global_reactive_power,
                      type = "l",
                      xlab = "datetime",
                      ylab = "Global_reactive_power",
                      xaxt = "n"))
axis(1,
     at = midnights,
     labels=days)

dev.off()