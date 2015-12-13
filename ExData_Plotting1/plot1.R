################## PLOT 1 ###################

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

# Transform variable Global_active_power from factor to numeric
data_subset <- transform(data_subset, Global_active_power = 
                                 as.numeric(as.character(Global_active_power)))
# Create Histogram (Plot 1)
hist(data_subset$Global_active_power, col="red", 
     xlab="Global Active Power (kilowatts)", main="Global Active Power")

# Create Histogram Plot 1 - png
png(file="plot1.png",width = 480, height = 480, type="quartz")
hist(data_subset$Global_active_power, col="red", 
     xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
