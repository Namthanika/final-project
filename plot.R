source("project.R")
source("sales_table_manipulation.R")

# View(sales)

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

citydata <- sales_city(sales_state("WA"), "Seattle")
months <- colnames(citydata)[4:136]
prices <- as.Vector(citydata[1, 4:136])
View(data.frame(months, prices))

# user interface
my_ui <- fluidPage(   
  titlePanel("Home Rent Prices"),  
  
  sidebarLayout(
    sidebarPanel( 
      h3("Plot 1"),
      selectInput('state', label = "Choose a state", choices = sales$stateName),
      uiOutput("stateCities"), 
      h3("Plot 2"),
      selectInput('month', label = "Choose a month", choices = colnames(sales)[4:136]), 
      sliderInput('minPrice', label = "Choose a price range", min = 0, max = 1e+06, value = c(min, max))
    ),
    mainPanel( 
      tableOutput('cityData'),
      plotOutput('plot')
    )
  )
)

# server
my_server <- function(input, output) {
  sales_statedata <- reactive({
    return(sales_state(input$state))
  })
  
  output$stateCities <- renderUI({
    citiesInState <- getCities(input$state)
    selectInput('city', "Choose city", citiesInState)
  })
  
  sales_citydata <- reactive({
    sales_city <- filter(sales_statedata(), cityName == input$city)
    return(sales_city)
  })
  
  output$cityData <- renderTable({
    return(sales_citydata())
  })
  
  cityPrices <- reactive({
    citydata <- sales_citydata()
    months <- colnames(citydata)[4:136]
    prices <- citydata[1, ][4:136]
    return(data.frame(months, prices))
  })
  
  output$plot <- renderPlot({
    ggplot(data = cityPrices(), aes(x = months, y = prices)) +
      geom_bar(stat = "identity", fill = "steelblue")
  })
}

shinyApp(ui = my_ui, server = my_server)