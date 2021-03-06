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

## convert the Date column to Date
sampleData <- cbind(sampleData
                    , strptime(paste(sampleData$Date,sampleData$Time), "%d/%m/%Y %H:%M:%S"))
names(sampleData)[length(names(sampleData))] = 'DateTime'

png(
  "plot2.png",
  width     = 480,
  height    = 480,
  units     = "px",
)

par(mfrow=c(1,1))

## draw the plot
with(sampleData, plot(DateTime
                      , Global_active_power
                      , xlab=""
                      , ylab="Global Active Power (kilowatts)"
                      , type="l")
)

## save it as a PNG file
dev.off()
