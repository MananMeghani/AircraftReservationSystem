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