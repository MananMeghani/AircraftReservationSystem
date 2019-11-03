library(jsonlite)
json_data <- fromJSON("data.json")
json_data_frame <- as.data.frame(json_data)
View(json_data_frame)
