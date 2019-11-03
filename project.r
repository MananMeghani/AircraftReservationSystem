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



