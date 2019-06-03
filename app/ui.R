library(shiny)
library(leaflet)
library(ggplot2)

my_ui <- fluidPage(
  # sliderInput("year", "Year:",
  #             min = "2008", max = "2019",
  #             value = "2018")
  selectInput("year", 
              "Year:", 
              choices = c("2008", "2009", "2010", "2011", "2012", "2013",
                          "2014","2015", "2016","2017","2018","2019")),
  
  plotOutput("mapPlot"),
  plotOutput("mapBarPlot"),
  selectInput("state", 
              "State:", 
              choices = c("AK", "AL", "AR", "AS", "AZ", "CA", "CO", "CT", "DC", 
                          "DE", "FL", "GA", "GU", "HI", "IA", "ID", "IL", "IN", 
                          "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", 
                          "MP", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", 
                          "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", 
                          "SD", "TN", "TX", "UM", "UT", "VA", "VI", "VT", "WA", 
                          "WI", "WV", "WY")),
  checkboxGroupInput("bYear", 
                     "Year:", 
                     choices = c("2008", "2009", "2010", "2011", "2012", "2013",
                                 "2014","2015", "2016","2017","2018","2019"),
                     selected = c("2008", "2009", "2010", "2011", "2012", "2013",
                                  "2014","2015", "2016","2017","2018","2019")),
  plotOutput("cityBoxplot")
  
)  

shinyUI(my_ui)