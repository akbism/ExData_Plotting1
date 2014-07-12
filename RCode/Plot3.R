# Check for the file household_power_consumption.txt.
# If not available, the program downloads for you.
ROOT <- 'household_power_consumption.txt'
sep <- '/'
if ( !file.exists(ROOT) ) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"  
  download.file(fileUrl, destfile = "household_power_consumption.zip")
  unzip("household_power_consumption.zip", exdir=".")
}

# Read the data
hhpc<-read.table("household_power_consumption.txt", header=T, sep=";",na.strings = "?", colClasses=c("factor","factor","numeric","numeric","numeric","numeric","numeric","numeric","numeric") )

# Format the data and select the required data
hhpc$Date <- as.Date(hhpc$Date, "%d/%m/%Y")
hhpc1<-subset(hhpc, (Date=="2007-02-01" | Date=="2007-02-02"))
hhpc1$DateTime<-paste(hhpc1$Date, hhpc1$Time)
hhpc1$DateTime<-strptime(hhpc1$DateTime, "%Y-%m-%d %H:%M:%S")

#Open png device and plot the required data
png(filename="plot3.png", width=480, height=480)
plot(hhpc1$DateTime, hhpc1[,7], type="l", xlab="",ylab="Energy sub metering", col="black")
lines(hhpc1$DateTime, hhpc1[,8], type="l", xlab="",col="red")
lines(hhpc1$DateTime, hhpc1[,9], type="l", xlab="",col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
dev.off()

