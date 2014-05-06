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
sampleData$Voltage <- as.numeric(as.character(sampleData$Voltage))
sampleData$Global_reactive_power <- as.numeric(as.character(sampleData$Global_reactive_power))


## convert the Date column to Date
sampleData <- cbind(sampleData
                    , strptime(paste(sampleData$Date,sampleData$Time), "%d/%m/%Y %H:%M:%S"))
names(sampleData)[length(names(sampleData))] = 'DateTime'


png(
  "plot4.png",
  width     = 480,
  height    = 480,
  units     = "px",
)

## set the quadrants of the graph
par(mfrow=c(2,2))

## draw the first plot
with(sampleData, plot(DateTime
                      , Global_active_power
                      , xlab=""
                      , ylab="Global Active Power (kilowatts)"
                      , type="l")
)

## draw the second plot
with(sampleData, plot(DateTime
                      , Voltage
                      , xlab=""
                      , ylab="Voltage"
                      , type="l")
)



## Draw the third plot
with(sampleData, plot(DateTime
                      , Sub_metering_1
                      , col="black"
                      , xlab=""
                      , ylab="Energy sub metering"
                      , type="l")
)
with(sampleData, points(DateTime
                        , Sub_metering_2
                        , col="red"
                        , type="l"))
with(sampleData, points(DateTime
                        , Sub_metering_3
                        , col="blue"
                        , type="l"
))
legend("topright",
       , legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       , col=c("black","red","blue")
       , lwd=0
       , cex=1
)


## Draw the fourth plot
with(sampleData, plot(DateTime
                      , Global_reactive_power
                      , xlab=""
                      , ylab="Global_reactive_power"
                      , type="l")
)


## save it as a PNG file
dev.off()
