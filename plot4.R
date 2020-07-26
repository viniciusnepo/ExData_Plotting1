setwd("C:/Vinicius/R/Course 4/Project")

# load sqldf package
install.packages("sqldf")
library(sqldf)

# read file filtering by the dates we want
df <- read.csv.sql("data/household_power_consumption.txt",
      "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep=";")

# calculate memory usage
print(object.size(df))

# convert strings into date time values
df$Date <- strptime(paste(df$Date, df$Time), format = "%d/%m/%Y %H:%M:%S")
df$Date <- as.POSIXct(df$Date, format = "%d/%m/%Y %H:%M:%S")

# remove time column, since it was joined with the date
df <- df[,-c(2)]

# create the graphs
windows(width=10, height=10)
par(mfcol = c(2,2), mar = c(4, 4, 1, 2), oma = c(0, 0, 0, 0))

# 1
plot(Global_active_power~Date, data = df, type = "l", ylab = "Global Active Power", xlab = "")

# 2
with(df, plot(Date, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub mettering"))
with(df, lines(Date, Sub_metering_1))
with(df, lines(Date, Sub_metering_2, col = "red"))
with(df, lines(Date, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "blue", "red"), box.lty=0, inset = 0.02,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)

# 3
plot(Voltage~Date, data = df, type = "l", xlab = "datetime", ylab = "Voltage")

# 4
plot(Global_reactive_power~Date, data = df, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# export to PNG
dev.copy(png, file = "plot4.png", width = 480, height = 480) ## Copy my plot to a PNG file

#close device
dev.off()
