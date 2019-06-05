source("./app/project.R")
#source("project.R")
# to get a table containg the full state name and its abbrevaition
us_map <- fifty_states

## trim out any space trailing in front of the text
trim.leading <- function (x)  sub("^\\s+", "", x)
##

## breaking the column containing city and state name into 2 columns named city_name and state_name
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
##

## unpivot the sales table from pivotted on the month (2008-03 to 2016-02)
unpivot_sales <- melt(sales, id=c("RegionID","RegionName", "SizeRank", "cityName", "stateName"))
##

## find city/state average of housing price in each year from 2008 to 2019
year <- gsub('.{3}$', '', unpivot_sales$variable)
monthly_state_ave <- unpivot_sales %>% mutate(year)
monthy_city_ave <- monthly_state_ave %>% group_by(year, cityName, stateName) %>% summarise(mean = mean(value))
year_state_ave <- monthly_state_ave %>% group_by(stateName, year) %>% summarise(mean = mean(value, na.rm = TRUE))
##

## joining the us_name table and year_state_ave together in order to have latitude and longitude linked to the ave value

## moved the following read action to project.R
# state_abbr_table <- read.csv("../data/states.csv", stringsAsFactors = FALSE)

state_abbr_table <- state_abbr_table %>% mutate(lower_state_name = tolower(State))
year_state_ave <- full_join(year_state_ave, state_abbr_table, by = c("stateName" = "Abbreviation"))
mapping_table <- full_join(year_state_ave, us_map, by = c("lower_state_name" = "id"))

# ## given a year to look at
# data_2018 <- filter(mapping_table, year == 2019 | is.na(year))
# 
# ggplot(data = data_2018,
#        aes(x = long, y = lat)) +
#   geom_polygon(aes(group = group, fill = mean), size = 0.1) +
#   scale_fill_gradient(low = "blue", high = "yellow")

# ## given at state, to see the trend of the price over the past years 
# monthy_city_ave <- monthly_state_ave %>% group_by(year, cityName, stateName) %>% summarise(mean = mean(value))
# state_data <- filter(monthy_city_ave, stateName == "CA")
# 
# p1 <- ggplot(state_data, aes(x = year, y = mean, fill = year))
# p1 +
#   geom_boxplot(outlier.colour="black", outlier.shape=16,
#                outlier.size=2) + scale_fill_gradient2(low='red', mid='snow3', high='darkgreen', space='Lab')
# year_price <- year_state_ave %>% filter(stateName == '-' & is.na(State))
# ggplot(data=year_price, aes(x=year, y=mean, group=1)) + 
#   geom_line(colour="red", linetype="solid", size=1.5) + 
#   geom_label(aes(label = round(mean)), size = 2.5) +
#   theme_dark() 

# given a year 


sales_state <- function(state) {
  sales_statename <- filter(sales, stateName == state)
  return(sales_statename)
}

getCities <- function(state) {
  sales_statedata <- sales_state(state)
  return(sales_statedata$cityName)
}

sales_city <- function(table, city) {
  sales_cityname <- filter(table, cityName == city)
  return(sales_cityname)
}


exp_citydata <- sales_city(sales_state("NY"), "New York")
## <!!!\> Explain 4:136  </!!!>
exp_months <- data.frame(month = colnames(exp_citydata)[4:136], stringsAsFactors = F)
threes <- seq(3, nrow(exp_months), 3)
x_axis_filter <- exp_months[threes, ]


data <- unpivot_sales %>% filter(stateName == "NY", cityName == "New York") 
ggplot(data = data, aes(x = variable, y = value)) +
  scale_y_continuous(labels = scales::comma) +
  geom_bar(stat = "identity", fill = "steelblue") +
  scale_x_discrete(breaks = x_axis_filter) + # this only works for fixed-X-length
  theme(axis.text.x = element_text(angle = 75, hjust = 1),
        plot.background = element_rect(fill = "transparent",colour = NA))