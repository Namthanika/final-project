library(shiny)
library(leaflet)
library(ggplot2)
library(shinythemes)
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
my_ui <- navbarPage(fluid = T, "Zillow Housing Data",
                    theme = shinythemes::shinytheme("superhero"),
  # sliderInput("year", "Year:",
  #             min = "2008", max = "2019",
  #             value = "2018")
  
  # sidebarLayout(
    # 
    # sidebarPanel(
    #   ## If anyone of you wnat to put in global user-controled input, or 
    #   ## variable text that will always show to user, put it here.
    # ),
    #)
  tabPanel("Home",
           fluidRow(
             jpeg
             column(7, includeMarkdown("~/info201/final-project/markdown/welcome.md"))
           )
  ), 
  tabPanel("Component 1",
    tabsetPanel(
      tabPanel("mapPlot and mapBarPlot",
               fluidRow(
                 column(2, #offset = 1,
                        wellPanel(selectInput("year",
                                              "Year:",
                                              choices = listOfYears)
                        )
                 ),
                 column(10, 
                        tabsetPanel(
                          tabPanel("mapBarPlot", plotOutput("mapBarPlot")),
                          tabPanel("mapPlot", plotOutput("mapPlot"))
                        )
                 )

                 # column(6, plotOutput("mapBarPlot")),
                 # column(4, plotOutput("mapPlot"))
               )
      ),
      tabPanel("cityBoxplot",
               fluidRow(
                 column(10, plotOutput("cityBoxplot")),
                 column(2,
                        wellPanel(
                          selectInput("state", "State:", choices = listOfStates),
                          checkboxGroupInput("bYear", "Year:", choices = listOfYears,
                                             selected = listOfYears)
                        )
                 )
               )
      )
    )
  ),
  
  tabPanel("Component 2",
           titlePanel("Home Rent Prices"),
           tabsetPanel(
             tabPanel("monthly trend",
                      fluidRow(
                        column(2,
                               wellPanel(
                                 h3("Plot 1"),
                                 selectInput('bState', label = "Choose a state", choices = sales$stateName, selected = NULL),
                                 uiOutput("stateCities")
                               )
                              ),
                        column(10,
                               plotOutput('plot')
                               )
                        )
                      ),
             tabPanel("random table",
                      fluidRow(
                        column(2,
                               wellPanel(
                                 h3("Plot 2"),
                                 selectInput('month', label = "Choose a month", choices = colnames(sales)[4:136]),
                                 sliderInput('minPrice', label = "Choose a price range", min = 0, max = 1e+06, value = c(min, max))
                                 )
                               ),
                        column(10,
                               tableOutput('cityData')
                               )
                        )
                      )
           )
  ),
  hr(),
  div(
    br(),
    eval(parse(text = inputCreditedPeople(creditedPeople)))
  )
      
)  

# 
# shinyUI(my_ui)