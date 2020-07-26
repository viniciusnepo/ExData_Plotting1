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
df$Date <- strptime(paste(df$Date, df$Time), format = "%m/%d/%Y %H:%M:%S")
df$Date <- as.POSIXct(df$Date, format = "%d/%m/%Y %H:%M:%S")

# remove time column, since it was joined with the date
df <- df[,-c(2)]

# create the graph
hist(df$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

# export to PNG
dev.copy(png, file = "plot1.png", width = 480, height = 480) ## Copy my plot to a PNG file

#close device
dev.off()
