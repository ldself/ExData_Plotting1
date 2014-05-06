## program assumes that the household_power_consumption.txt file
## is in the working directory

## read the header
colNames <- read.table("household_power_consumption.txt", nrow=1, sep=';')

## load the data
sampleData <- read.table("household_power_consumption.txt"
                         , col.names = as.matrix(colNames[1,])
                         , header=TRUE
                         , sep=";"
                         , skip=66636
                         , nrows=2880
)

## convert the Global_active_power column to numeric
sampleData$Global_active_power <- as.numeric(as.character(sampleData$Global_active_power))

## draw the plot
hist(sampleData$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

## save it as a PNG file
dev.copy(png, file="plot1.png")
dev.off()
