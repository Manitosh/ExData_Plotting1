setwd(getwd());

if(file.exists("plotdata.txt"))
{
  plot_data <-read.csv("plotdata.txt");
  
}

if(!file.exists("plotdata.txt"))
{
  my_data <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
  my_data$Date <- as.Date(my_data$Date, format="%d/%m/%Y");

  ## Subsetting the data
  plot_data <- subset(my_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"));
    plot_data$Datetime <- as.POSIXct(datetime);
  write.csv(plot_data,file="plotdata.txt");
}

## Converting dates
datetime <- paste(as.Date(plot_data$Date), plot_data$Time);
plot_data$Datetime <- as.POSIXct(datetime);

plot(plot_data$Global_active_power~plot_data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="figure/plot2.png", height=480, width=480)
dev.off()