dev.off() # Clear the graph window
cat('\014') # Clear the console
rm(list=ls()) # Clear all user objects from the environment!!!


library(jsonlite)
getwd
path = 'D:/Sem-1/IST-687/Project'
setwd(path)
dir()
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

MurderScat <- ggplot(json_data_frame,aes(x =json_data_frame$Gender,y = json_data_frame$Likelihood.to.recommend))
#Selecting visualization type as Scatter Chart
MurderScat <- MurderScat + geom_point()
#Providing a title to the visualization
MurderScat <- MurderScat + ggtitle("Distribution of UrbanPop on Number of Murders")
#Displaying the visualization
MurderScat

model1 <- lm(formula=json_data_frame$Likelihood.to.recommend ~ json_data_frame$Age+json_data_frame$Airline.Status,data=json_data_frame)

summary(model1)

#huge dataset deters us from visualizing the entire data collectively
#------what other problems which makes us prefer regression models?


#Create a bivariate plot of the gender versus likelihood to recommend
ggplot(json_data_frame)+
  #Y-axis will be the population
  aes(x=Gender, y=Likelihood.to.recommend)+                         
  #creating a bivariate plot (scatter plot) 
  geom_point(color="blue")+
  #title
  ggtitle("Dependence of likelihood to recommend on airline status")

summary(json_data_frame)

RegModel <- lm(formula = json_data_frame$Likelihood.to.recommend ~ json_data_frame$Gender, data = json_data_frame)
summary(RegModel)

#plot(json_data_frame$Gender, json_data_frame$Likelihood.to.recommend)
#abline(RegModel)
#RegModel



##########################################################

json_data_frame_LowNPS<-json_data_frame[json_data_frame$Likelihood.to.recommend<7,]
json_data_frame_HighNPS<-json_data_frame[json_data_frame$Likelihood.to.recommend>8,]

install.packages("dplyr")
library(dplyr)
library(tidyverse)

dataGroupedByAirlineName<-group_by(json_data_frame_LowNPS,Partner.Name)
dataGroupedByAirlineName2<-group_by(json_data_frame_HighNPS,Partner.Name)

dataSummarised<-summarise(dataGroupedByAirlineName ,LowNPS=n())
dataSummarised1<-summarise(dataGroupedByAirlineName2 ,HighNPS=n())
dataSummarised$LowNPSpercentage <- round((dataSummarised$LowNPS / nrow(json_data_frame_HighNPS))*100,2)
dataSummarised1$HighNPSpercentage <- round((dataSummarised1$HighNPS / nrow(json_data_frame_HighNPS))*100,2)
dataSummarised3<- merge(dataSummarised,dataSummarised1,by ="Partner.Name")
View(dataSummarised3)

dataGroupedByAirlineNameOriginalData<-group_by(json_data_frame_HighNPS, Partner.Name)

dataSummarised2<-summarise(dataGroupedByAirlineNameOriginalData, Total.Entries=n())

View(dataSummarised2)

dataCompare<-merge(dataSummarised3,dataSummarised2,)

dataCompare$LowNPSRelative<-(dataCompare$LowNPS/dataCompare$Total.Entries)*100
dataCompare$HighNPSRelative<-(dataCompare$HighNPS/dataCompare$Total.Entries)*100
dataCompare$RelativeLowHigh <-(dataCompare$HighNPSRelative-dataCompare$LowNPSRelative)/10

View(dataCompare)
