library(shiny)
library(leaflet)
library(ggplot2)

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
          tags$a(href="#readme", "Summary")
        ),
        tags$li(
          class="tab col s3", 
          tags$a(href="#page-1", "Details")
        ),
        tags$li(
          class="tab col s3", 
          tags$a(href="#page-2", "Trends")
        )
      ),
      ## <<<<<<< Nav Bar <<<<<
      
      ## >>>>>> Readme Page >>>>>
      div(
        id = "readme", # readme page
        class="card-content col s12 orange",
        "About this web application"
        
        ######### === INSERT your README stuff ====
      ),
      ## <<<<<< Readme Page <<<<<<
      
      ## >>>>>> First Page >>>>>
      div(
        id = "page-1", # first page
        class="card-content col s12 blue",
        h3("Title #1"),
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
                              tabPanel("Rents on Map", 
                                       tags$div(class="card-panel cyan lighten-3", 
                                                plotOutput("mapPlot")
                                                )
                                       ),
                              tabPanel("States Bar Plot", 
                                       tags$div(class="card-panel light-blue lighten-5", 
                                                plotOutput("mapBarPlot")
                                       )
                              )
                            )
                     )
                   )
          ),
          tabPanel("City Box Plot",
                   fluidRow(
                     column(10, 
                            tags$div(class="card-panel teal accent-1", 
                                     plotOutput("cityBoxplot")
                                     )
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
      ## <<<<<< First Page <<<<<<
      
      ## >>>>>> Seconde Page >>>>>
      div(
        id = "page-2", # second page
        class="card-content col s12 deep-purple",
        h3("Home Rent Prices Trends"),
        tabsetPanel(
          tabPanel("monthly trend",
                   fluidRow(
                     column(2,
                            div(class = "card-panel grey darken-3",
                              h4("Plot 1"),
                              selectInput('bState', label = "Choose a state", choices = sales$stateName, selected = NULL),
                              uiOutput("stateCities")
                            )
                     ),
                     column(10,
                            tags$div(class="card-panel  pink lighten-5", 
                                     plotOutput('plot')
                            )
                     )
                   )
          ),
          tabPanel("random table",
                   fluidRow(
                     column(2,
                            wellPanel(
                              h4("Plot 2"),
                              selectInput('month', label = "Choose a month", choices = colnames(sales)[4:136]),
                              sliderInput('minPrice', label = "Choose a price range", min = 0, max = 1e+06, value = c(min, max))
                            )
                     ),
                     column(10,
                            div(class = "container", 
                                dataTableOutput('cityData')
                            )
                     )
                   )
          )
        )
        )
      ## <<<<<< Second Page <<<<<<
      
      ),
  
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