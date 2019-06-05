### =============== Global Envi ============
source("./app/sales_table_manipulation.R")

exp_citydata <- sales_city(sales_state("NY"), "New York")
exp_months <- data.frame(month = colnames(exp_citydata)[4:136], stringsAsFactors = F)
threes <- seq(3, nrow(exp_months), 3)
x_axis_filter <- exp_months[threes, ]


### ======== Server Envi ========
my_server <- function(input, output) {
  ## first tab:: national level
  output$year_price_plot <- renderPlot({
    year_price <- year_state_ave %>% filter(stateName == '-' & is.na(State))
    ggplot(data=year_price, aes(x=year, y=mean, group=1)) + 
      geom_line(colour="red", linetype="solid", size=1.5) + 
      geom_label(aes(label = round(mean))) +
      theme_dark() 
  })
  
  ## second tab:: state level 
  get_summarized_data <- reactive({
    filter(mapping_table, year == input$year | is.na(year))#%>% filter(!is.nan(mean))
  })
  
  ## get the sale price based on the given year
  barplot_data <- reactive({
    filter(year_state_ave, year == input$year) %>% arrange(mean)
  })
  
  ## get the sale price based on the given year and state
  box_plot_data <- reactive({
    state_data <- filter(monthy_city_ave, stateName == input$state, year %in% input$bYear) %>% filter(!is.nan(mean))
  })
  
  ## US heat map based on the housing sale price in the given year
  output$mapPlot <- renderPlot({
    filter_data <- get_summarized_data()
    ggplot(data = filter_data,
           aes(x = long, y = lat)) +
      scale_y_continuous(labels = scales::comma) +
      scale_x_continuous(labels = scales::comma) +
      
      geom_polygon(aes(group = group, fill = mean), size = 0.1) +
      scale_fill_gradient(low = "blue", high = "yellow") +
      theme(
        # Hide panel borders and remove grid lines
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        panel.background = element_rect(fill = "#BFD5E3", colour = "#6D9EC1",
                                        size = 2, linetype = "solid"),
        legend.background = element_rect(fill = "transparent",colour = NA),
        plot.background = element_rect(fill = "transparent",colour = NA)
        )
  }, bg="transparent")
  
  output$mapText <- renderText({
    paste("The grey states indicate that the data from the states are missing.")
  })
  
  ## rotated bar plot based on the housing sale price in the given year
  output$mapBarPlot <- renderPlot({
    data <- barplot_data()
    ggplot(data=data, aes(x=State, y=mean)) +
      scale_y_continuous(labels = scales::comma) +
      
      geom_bar(aes(fill = mean) ,stat="identity") + 
      geom_text(aes(label=round(mean)), color="white", size=3.5) + 
      coord_flip() + theme_dark()+theme(
        # panel.background = element_rect(fill = "transparent",colour = NA)
        # ,
        legend.background = element_rect(fill = "transparent",colour = NA),
        plot.background = element_rect(fill = "transparent",colour = NA)
      )
  }, bg="transparent")

  ## box plot on the housing sale price based on the given state and year(s)
  output$cityBoxplot <- renderPlot({
   ggplot(box_plot_data(), aes(x = year, y = mean, fill = year)) + 

      geom_boxplot(outlier.colour="red", outlier.shape=8,outlier.size=4) + 
      theme_dark() + 
      theme(legend.background = element_rect(fill = "transparent",colour = NA),
            plot.background = element_rect(fill = "transparent",colour = NA)
            )
  }, bg="transparent")
  
  ### ----------- Third and Fourth graph begin --------
  ### ------ plotting the monthly housing rental price in the given city from 2008-2019--------
  sales_statedata <- reactive({
    return(sales_state(input$bState))
  })

  output$stateCities <- renderUI({
    citiesInState <- getCities(input$bState)
    selectInput('city', "Choose city", citiesInState)
  })

  sales_citydata <- reactive({
    sales_city <- filter(sales_statedata(), cityName == input$city)
  })

  output$cityData <- renderDataTable({
    sales_citydata()
  })

  cityPrices <- reactive({
    citydata <- sales_citydata()
    months <- data.frame(month = colnames(citydata)[4:136], stringsAsFactors = F)
    prices <- data.frame(as.vector(citydata[1, 4:136]), stringsAsFactors = F) %>% gather("key", "value")
    mutate(months, price = prices$value)
  })
  ## bar plot on the monthly rental price based on the given state and city
  output$plot <- renderPlot({
    data <- cityPrices()
    ggplot(data = data, aes(x = month, y = price)) +
      scale_y_continuous(labels = scales::comma) +
      geom_bar(stat = "identity", fill = "steelblue") +
      scale_x_discrete(breaks = x_axis_filter) + # this only works for fixed-X-length
      theme(axis.text.x = element_text(angle = 75, hjust = 1),
            plot.background = element_rect(fill = "transparent",colour = NA))
  }, bg="transparent")
  ###----end plot--------------------
  
  ### ------ plotting the monthly housing sale price in the given city from 2008-2019--------
  sales_statedata1 <- reactive({
    filter(unpivot_sales, stateName == input$bState)
  })
  
  sales_citydata1 <- reactive({
    sales_city <- filter(sales_statedata1(), cityName == input$city)
  })
  
  
  output$citySales <- renderPlot({
    data <- sales_citydata1()
    ggplot(data = data, aes(x = variable, y = value)) +
      scale_y_continuous(labels = scales::comma) +
      geom_bar(stat = "identity", fill = "green") +
      scale_x_discrete(breaks = x_axis_filter) + # this only works for fixed-X-length
      theme(axis.text.x = element_text(angle = 75, hjust = 1),
            plot.background = element_rect(fill = "transparent",colour = NA))
  })
  ###----end plot--------------------
  ### ----------- city level --------

}