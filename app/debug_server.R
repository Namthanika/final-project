library(shiny)
library(dplyr)
library(leaflet)
library(ggplot2)
library(R.utils)
library(viridis)
library("tidyverse")

# 
# setwd(getwd())


### =============== Global Envi ============
source("./app/sales_table_manipulation.R")

citydata <- sales_city(sales_state("NY"), "New York")
## <!!!\> Explain 4:136  </!!!>
exp_months <- data.frame(month = colnames(exp_citydata)[4:136], stringsAsFactors = F)
threes <- seq(3, nrow(exp_months), 3)
x_axis_filter <- exp_months[threes, ]

# Plot 1: choose city, line graph (shaded) of rent price over the months
# Plot 2: choose month, choose price range, table of cities and rent price

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


### ======== Server Envi ========
debug_server <- function(input, output) {
  ## given a year to look at
  get_summarized_data <- reactive({
    filter(mapping_table, year == input$year) %>% filter(!is.nan(mean))
  })
  
  barplot_data <- reactive({
    filter(year_state_ave, year == input$year) %>% filter(!is.nan(mean)) %>% arrange(mean)
  })
  
  box_plot_data <- reactive({
    state_data <- filter(monthy_city_ave, stateName == input$state, year %in% input$bYear) %>% filter(!is.nan(mean))
  })
  
  output$mapPlot <- renderPlot({
    # filter_data <- get_summarized_data()
    # ggplot(data = filter_data,
    #        aes(x = long, y = lat)) +
    #   geom_polygon(aes(group = group, fill = mean), size = 0.1) +
    #   scale_fill_gradient(low = "blue", high = "yellow") +
    #   theme(
    #     # Hide panel borders and remove grid lines
    #     panel.border = element_blank(),
    #     panel.grid.major = element_blank(),
    #     panel.grid.minor = element_blank(), 
    #     panel.background = element_rect(fill = "#BFD5E3", colour = "#6D9EC1",
    #                                     size = 2, linetype = "solid"))
  })
  
  output$mapBarPlot <- renderPlot({
    # data <- barplot_data()
    # ggplot(data=data, aes(x=State, y=mean)) +
    #   geom_bar(aes(fill = mean) ,stat="identity") + 
    #   geom_text(aes(label=round(mean)), color="white", size=3.5) + 
    #   coord_flip() + theme_dark() 
  })
  
  # ggplot(data = filter_date,
  #        aes(x = long, y = lat)) +
  #   geom_polygon(aes(group = group, fill = mean), size = 0.1) +
  #   scale_fill_gradient(low = "blue", high = "yellow")
  
  ## given at state, to see the trend of the price over the past years
  # monthy_city_ave <- monthly_state_ave %>% group_by(year, cityName, stateName) %>% summarise(mean = mean(value))
  # state_data <- filter(monthy_city_ave, stateName == "CA")
  
  output$cityBoxplot <- renderPlot({
    # ggplot(box_plot_data(), aes(x = year, y = mean, fill = year)) + 
    #   geom_boxplot(outlier.colour="red", outlier.shape=8,outlier.size=4) + theme_dark() 
  })
  
  ### ----------- Third and Fourth graph begin --------
  sales_statedata <- reactive({
    return(sales_state(input$bState))
  })
  
  output$stateCities <- renderUI({
    citiesInState <- getCities(input$bState)
    selectInput('city', "Choose city", citiesInState)
  })
  
  sales_citydata <- reactive({
    sales_city <- filter(sales_statedata(), cityName == input$city)
    return(sales_city)
  })
  
  output$cityData <- renderTable({
    # return(sales_citydata())
  })
  
  cityPrices <- reactive({
    citydata <- sales_citydata()
    
    months <- data.frame(month = colnames(citydata)[4:136], stringsAsFactors = F)
    prices <- data.frame(as.vector(citydata[1, 4:136]), stringsAsFactors = F) %>% gather("key", "value")
    return(
      mutate(months, price = prices$value)
    )
  })
  
  output$plot <- renderPlot({
    # data <- cityPrices()
    # ggplot(data = data, aes(x = month, y = price)) +
    #   geom_bar(stat = "identity", fill = "steelblue") +
    #   scale_x_discrete(breaks = x_axis_filter) + # this only works for fixed-X-length
    #   theme(axis.text.x = element_text(angle = 75, hjust = 1))
  })
  ### ----------- Third and Fourth graph ends --------
  
}
# 
# shinyServer(my_server)