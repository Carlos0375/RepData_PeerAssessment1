################## PLOT 4###################
# Please note that since I come from germany
# the daynames are printed out in german 

# Set the path to the working directory and load data
path <- getwd()
household_power_consumption <- read.csv(file.path(
        path, "household_power_consumption.txt"), sep=";")

data_complete <- household_power_consumption

# Create new variable datetime
datetime <- as.POSIXct(paste(data_complete$Date, 
                             data_complete$Time), format="%d/%m/%Y %H:%M:%S")
# Check new variable
head(datetime)
# Add datetime to data_complete
data_complete$datetime <- datetime
# Subset data_complete for 01. and 02. Feb 2007
data_subset <- with(data_complete, 
                    data_complete[datetime >= "2007-02-01 00:00:00" & 
                                          datetime <= "2007-02-03 00:00:00" & 
                                          Global_active_power != "?",])

# Transform variables from factor to numeric
data_subset <- transform(data_subset, Global_active_power = 
                                 as.numeric(as.character(Global_active_power)))
data_subset <- transform(data_subset, Sub_metering_1 = 
                                 as.numeric(as.character(Sub_metering_1)))
data_subset <- transform(data_subset, Sub_metering_2 =
                                 as.numeric(as.character(Sub_metering_2)))
data_subset <- transform(data_subset, Sub_metering_3 =
                                 as.numeric(as.character(Sub_metering_3)))
data_subset <- transform(data_subset, Voltage =
                                 as.numeric(as.character(Voltage)))
data_subset <- transform(data_subset, Global_reactive_power =
                                 as.numeric(as.character(Global_reactive_power)))


# Create plot 4 (4 plots combined)
with(data_subset, {
        par(mfrow=c(2,2), mar=c(4,4,4,2))
        plot(datetime,Global_active_power, type="l",
             ylab="Global Active Power (kilowatts)",
             xlab="")
        plot(datetime, Voltage, type="l", ylab="Voltage")
        plot(datetime,Sub_metering_1,col="black", type="l",
             ylab="Energy sub metering",
             xlab="")
        lines(datetime, Sub_metering_2, col="red")
        lines(datetime, Sub_metering_3, col="blue")
        legend("topright", lty=c(1,1), col=c("black","red","blue"), 
               legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               bty = "n") # option for no box around legend
        plot(datetime, Global_reactive_power, type="l")
})

# Create combined Plots - png
png(file="plot4.png",width = 480, height = 480)
with(data_subset, {
        par(mfrow=c(2,2), mar=c(4,4,4,2))
        plot(datetime,Global_active_power, type="l",
             ylab="Global Active Power (kilowatts)",
             xlab="")
        plot(datetime, Voltage, type="l", ylab="Voltage")
        plot(datetime,Sub_metering_1,col="black", type="l",
             ylab="Energy sub metering",
             xlab="")
        lines(datetime, Sub_metering_2, col="red")
        lines(datetime, Sub_metering_3, col="blue")
        legend("topright", lty=c(1,1), col=c("black","red","blue"), 
               legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               bty = "n") # option for no box around legend
        plot(datetime, Global_reactive_power, type="l")
})
dev.off()