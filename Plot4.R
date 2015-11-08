setwd(getwd());

if(file.exists("plotdata.txt"))
{
  plot_data <-read.csv("plotdata.txt");
}

if(!file.exists("plot_data.txt"))
{
  my_data <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
  my_data$Date <- as.Date(my_data$Date, format="%d/%m/%Y");
  ## Subsetting the data
  plot_data <- subset(my_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"));
  write.csv(plot_data,file="plotdata.txt");
}

## Converting dates
datetime <- paste(as.Date(plot_data$Date), plot_data$Time);
plot_data$Datetime <- as.POSIXct(datetime);

par(mfrow=c(2,2), mar=c(1,2,2,1))
with(plot_data, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",xjust=1,yjust=1,
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="figure/plot4.png", height=480, width=480)
dev.off()