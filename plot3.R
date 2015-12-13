################## PLOT 3 ###################
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

# Create combined Lineplot (Plot 3)
par(mar=c(3,4,4,2))
with(data_subset, {
        plot(datetime,Sub_metering_1,col="black", type="l",ylab="Energy sub metering")
        lines(datetime, Sub_metering_2, col="red")
        lines(datetime, Sub_metering_3, col="blue")
        legend("topright", lty=c(1,1), col=c("black","red","blue"), 
               legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
})

# Create combined Lineplot - png
png(file="plot3.png",width = 480, height = 480, bg = "transparent")
par(mar=c(3,4,4,2))
with(data_subset, {
        plot(datetime,Sub_metering_1,col="black", type="l",ylab="Energy sub metering")
        lines(datetime, Sub_metering_2, col="red")
        lines(datetime, Sub_metering_3, col="blue")
        legend("topright", lty=c(1,1), col=c("black","red","blue"), 
               legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
})
dev.off()