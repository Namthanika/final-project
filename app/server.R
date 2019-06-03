library(shiny)
library(dplyr)
library(leaflet)
library(ggplot2)
library(R.utils)
library(viridis)

# 
# setwd(getwd())

source("./app/sales_table_manipulation.R")

my_server <- function(input, output) {
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
    filter_data <- get_summarized_data()
    ggplot(data = filter_data,
           aes(x = long, y = lat)) +
      geom_polygon(aes(group = group, fill = mean), size = 0.1) +
      scale_fill_gradient(low = "blue", high = "yellow") +
      theme(
        # Hide panel borders and remove grid lines
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        panel.background = element_rect(fill = "#BFD5E3", colour = "#6D9EC1",
                                        size = 2, linetype = "solid"))
  })
  
  output$mapBarPlot <- renderPlot({
    data <- barplot_data()
    ggplot(data=data, aes(x=State, y=mean)) +
      geom_bar(aes(fill = mean) ,stat="identity") + 
      geom_text(aes(label=round(mean)), color="white", size=3.5) + 
      coord_flip() + theme_dark() 
  })

  # ggplot(data = filter_date,
  #        aes(x = long, y = lat)) +
  #   geom_polygon(aes(group = group, fill = mean), size = 0.1) +
  #   scale_fill_gradient(low = "blue", high = "yellow")

  ## given at state, to see the trend of the price over the past years
  # monthy_city_ave <- monthly_state_ave %>% group_by(year, cityName, stateName) %>% summarise(mean = mean(value))
  # state_data <- filter(monthy_city_ave, stateName == "CA")

  output$cityBoxplot <- renderPlot({
   ggplot(box_plot_data(), aes(x = year, y = mean, fill = year)) + 
      geom_boxplot(outlier.colour="red", outlier.shape=8,outlier.size=4) + theme_dark() 
  })
}
# 
# shinyServer(my_server)