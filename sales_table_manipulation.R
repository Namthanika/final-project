library("dplyr")

source("project.R")

trim.leading <- function (x)  sub("^\\s+", "", x)

city_col <- sales$RegionName[2:length(sales$RegionName)]
city_name <- c("-")
state_name <- c("-")
for (c in city_col) {
  output <- strsplit(c, ",")
  city <- output[[1]][1]
  state <- trim.leading(output[[1]][2])
  city_name <- c(city_name, city)
  state_name <- c(state_name, state)
}
sales$cityName <- city_name
sales$stateName <- state_name


