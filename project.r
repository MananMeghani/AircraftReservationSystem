dev.off() # Clear the graph window
cat('\014') # Clear the console
rm(list=ls()) # Clear all user objects from the environment!!!


library(jsonlite)
#getwd
#path = 'D:/Sem-1/IST-687/Project'
#setwd(path)
#dir()
json_data <- fromJSON("data.json")
json_data_frame <- as.data.frame(json_data)
View(json_data_frame)

range(json_data_frame$Age)

library(ggplot2)


plot1<-ggplot(json_data_frame,aes(x=json_data_frame$Likelihood.to.recommend,y=json_data_frame$Destination.City))
#selecting visualization type as boxplot
plot1<-plot1+geom_bar(stat="identity")

#selecting the title of the visualization
plot1<-plot1+ggtitle("Murder Plot")

#Displaying the visualization
plot1

pie(json_data_frame$Price.Sensitivity)
# Because the data is massive, displaying them through charts is not the right way as the charts won't show proper data.