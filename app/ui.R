my_ui <- navbarPage(fluid = T, "Housing Rate Shiny App", 
                    theme = shinythemes::shinytheme("superhero"),
                    tabsetPanel(
                      tabPanel("Introduction",
                               fluidRow(
                                 column(7, includeMarkdown("markdown/welcome.md"))
                               )
                      ),
                      tabPanel("Natonal Level",
                        fluidRow(
                                column(7, 
                                     h2("The Housing Price Trend From 2008 to 2019\n"),
                                     plotOutput('year_price_plot')),
                                     tags$p("The plot represents the average housing price in each year from 2008 to 2019. The data is collected by Zillow.
                                       It only includes the data from cities in a state. The number of the states is not consistant throughout years.
                                       The earlier years has less number of states collected in the data set. Since the size of dataset is not consistent throughout the years,
                                       The average can be overestimated or underestimated. However, the plot displays the trend of the housing prices
                                       from 2008 to 2019 very well. As expected, after the economy has been a lot better after 2012, the trend of housing price
                                       also gradually increases in those years.")
                                 
                                )
                      ),
                    tabPanel("State Level",
                               h3("Housing Price in Each State"),
                               tabsetPanel(
                                 tabPanel("Overview",
                                          fluidRow(
                                            column(2, 
                                                   div(class = "card-panel grey darken-3", 
                                                       selectInput("year","Year:", choices = listOfYears)
                                                   )
                                            ),
                                            column(10, 
                                                   tabsetPanel(
                                                     tabPanel("Sales Map", 
                                                              tags$h3("Sale Map in the United States"),
                                                              tags$param("The color on the map indicates how expensive the housing price in each state is.
                                                                         As show on the color scale on the right, yellow state sale the most expensive price and
                                                                         dark blue state is the cheapest price. The grey states indicate that the data is missing."),
                                                              tags$div(class="card-panel cyan lighten-3", 
                                                                       plotOutput("mapPlot")
                                                              )
                                                              ),
                                                     tabPanel("Sale Price in Each State",
                                                              tags$h3("Sale Price of Each State Based on the Given Year"),
                                                              tags$param("The same data as shown is represented in term of bar plots to provide a better 
                                                                         Proportional comparison between the states in the given year. The texts labeled on the graph
                                                                         are the actual average value from the dataset."),
                                                              tags$div(class="card-panel light-blue lighten-5", 
                                                                       plotOutput("mapBarPlot"))
                                                              )
                                                   )
                                            )
                                          )
                                ),
                                 tabPanel("City Box Plot",
                                          fluidRow(
                                            column(10, 
                                                   tags$p("This graph displays the mean sale of homes in the selected state within the selected years.
                                                          We chose to use a boxplot because it helps show all averages (mean, median, minimum, maximum)."),
                                                   tags$div(class="card-panel teal accent-1", 
                                                            plotOutput("cityBoxplot")
                                                   ),
                                                   tags$h5("When the plot is blank, it means that the data from that state is missing.")
                                                   ),
                                            column(2, 
                                                   div(class = "card-panel grey darken-3",
                                                       selectInput("state", "State:", choices = listOfStates),
                                                       checkboxGroupInput("bYear", "Year:", choices = listOfYears,
                                                                          selected = listOfYears)
                                                   )
                                            )
                                        )
                                 )
                              )
                    ),
                    
                    tabPanel("City Level",
                             titlePanel("Rental/Sale Price Bar Plot"),
                             tabsetPanel(
                               tabPanel("Rental/Sale Price Bar Plot",
                                        fluidRow(
                                          column(2,
                                                 div(class = "card-panel grey darken-3",
                                                     selectInput('bState', label = "Choose a state", choices = sales$stateName, selected = NULL),
                                                     uiOutput("stateCities")
                                                 )
                                          ),
                                          column(10,
                                                 h4("Monthly Rental Price Bar plot in a Given State and city"),
                                                 tags$param("Each bar represents the rental price in the month labeled on the X-axis in the given city. This plot can 
                                                            be used to indicate the trend of the rental price very well and represent any rental price trend in each year"),
                                                 tags$div(class="card-panel  pink lighten-5", 
                                                          plotOutput('plot')),
                                                 h4("Monthly Sale Price Bar plot in a Given State and city"),
                                                 tags$param("Each bar represents the sale price in the month labeled on the X-axis in the given city. This plot can 
                                                            be used to indicate the trend of the sale price very well and represent any sale price trend in each year"),
                                                 tags$div(plotOutput('citySales'))
                                                 )
                                          )
                               )
                              )
                    ),
                    tabPanel("Conclusion",
                             fluidRow(
                               column(7, includeMarkdown("markdown/conclusion.md"))
                             )
                    )
                  ),
                    hr(),
                    div(
                      br(),
                      eval(parse(text = inputCreditedPeople(creditedPeople)))
                    )
                    
)  
