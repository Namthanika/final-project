creditedPeople <- c("Thanika Painruttanasukho", "Nathan Truong Nguyen", "Abishek Hariharan", "Yijie Deng")

inputCreditedPeople <- function(creditedPeople) {
  str <- "p(tags$i('This project is created by '"
  for (people in creditedPeople){
    str <- str %>% paste0(", tags$b('", people,"'), ','")
  }
  str <- str %>% paste0(", 'and inspired by Info 201 members.')) ")
  
  str
}

listOfStates <- c("AK", "AL", "AR", "AS", "AZ", "CA", "CO", "CT", "DC", 
                  "DE", "FL", "GA", "GU", "HI", "IA", "ID", "IL", "IN", 
                  "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", 
                  "MP", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", 
                  "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", 
                  "SD", "TN", "TX", "UM", "UT", "VA", "VI", "VT", "WA", 
                  "WI", "WV", "WY")
listOfYears <- c("2008", "2009", "2010", "2011", "2012", "2013",
                 "2014","2015", "2016","2017","2018","2019")




## ======= Actual Shiny UI ======
my_ui <- fluidPage(
  titlePanel("Housing Rate Shiny App"), 
  theme = shinythemes::shinytheme("superhero"),
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"
  ),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css"),
    tags$script(src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js")
    ),
  
  ## ==== Tab Structure ====
  div(class = "card",
      
      ## >>>>>> Nav Bar >>>>>
      tags$ul(
        class="tabs",
        tags$li(
          class="tab col s3", 
          tags$a(href="#readme", "Introduction")
        ),
        tags$li(
          class="tab col s3", 
          tags$a(href="#nation", "National Level")
        ),
        tags$li(
          class="tab col s3", 
          tags$a(href="#page-1", "State Level")
        ),
        tags$li(
          class="tab col s3", 
          tags$a(href="#page-2", "City Level")
        ),
        tags$li(
          class="tab col s3", 
          tags$a(href="#summary", "Summary")
        )
      ),
      ## <<<<<<< Nav Bar <<<<<
      
      ## >>>>>> Readme Page >>>>>
      div(
        id = "readme", # readme page
        class="card-content col s12 orange",
        includeMarkdown("markdown/welcome.md")
      ),
      ## <<<<<< Readme Page <<<<<<
      
      ## >>>>>> Nation Level Page >>>>>
      div(
        id = "nation", # readme page
        class="card-content col s12 blue",
        tabsetPanel(
          tabPanel("->"),
          tabPanel(
            h2("The Housing Price Trend From 2008 to 2019"),
            div(#class="card-panel cyan lighten-3", 
              plotOutput('year_price_plot')),
            p("The plot represents the average housing price in each year from 2008 to 2019. The data is collected by Zillow. 
          It only includes the data from cities in a state. The number of the states is not consistant throughout years.
          The earlier years has less number of states collected in the data set. Since the size of dataset is not consistent throughout the years, 
          The average can be overestimated or underestimated. However, the plot displays the trend of the housing prices 
          from 2008 to 2019 very well. As expected, after the economy has been a lot better after 2012, the trend of housing price 
          also gradually increases in those years.")
            )
          )
      ),
      ## <<<<<< Nation Level Page <<<<<<
      
      ## >>>>>> State Level Page >>>>>
      div(
        id = "page-1", # first page
        class="card-content col s12 blue",
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
      ## <<<<<< State level page <<<<<<
      
      ## >>>>>> city level page >>>>>
      div(
        id = "page-2", # second page
        class="card-content col s12 deep-purple",
        h3("Home Rent Prices Trends"),
        tabsetPanel(
          tabPanel("Rental Price Bar Plot",
                   fluidRow(
                     column(2,
                            div(class = "card-panel grey darken-3",
                              selectInput('bState', label = "Choose a state", choices = sales$stateName, selected = NULL),
                              uiOutput("stateCities")
                            )
                     ),
                     column(10,
                            tabsetPanel(
                              tabPanel("->"),
                              tabPanel(
                                h4("Monthly Rental Price Bar plot in a Given State and city"),
                                tags$param("Each bar represents the rental price in the month labeled on the X-axis in the given city. This plot can 
                                             be used to indicate the trend of the rental price very well and represent any rental price trend in each year"),
                                tags$div(class="card-panel pink lighten-5", 
                                         plotOutput('plot'))
                              ),
                              tabsetPanel(
                                tabPanel("->"),
                                tabPanel(
                                  h4("Monthly Sale Price Bar plot in a Given State and city"),
                                  tags$param("Each bar represents the sale price in the month labeled on the X-axis in the given city. This plot can 
                                             be used to indicate the trend of the sale price very well and represent any sale price trend in each year"),
                                  tags$div(class="card-panel pink lighten-5",
                                           plotOutput('citySales'))
                                  )
                              )
                            )
                     )
                     )
                   )
          )
        ),
      
      ## <<<<<< city level page <<<<<<
      
      ## >>>>>> Summary Page >>>>>
      div(
        id = "summary", # readme page
        class="card-content col s12 orange",
        includeMarkdown("markdown/conclusion.md")
      )
  ),
      ## <<<<<< Summary Page <<<<<<
  
  ## >>>>>> Footer >>>>>
  hr(),
  br(),
  div(class="footer-copyright",
      div(class="container orange-text text-lighten-4 left",
          eval(parse(text = inputCreditedPeople(creditedPeople)))
      )
  ),
  ## <<<<<< Footer <<<<<<
  tags$script(type="text/javascript", src="init.js")
)
