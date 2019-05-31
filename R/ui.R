# The UI is the result of calling the `fluidPage()` layout function


creditedPeople <- c("Thanika Painruttanasukho", "Nathan Truong Nguyen", "Abishek Hariharan", "Yijie Deng")

inputCreditedPeople <- function(creditedPeople) {
  str <- "p(tags$i('This project is created by '"
  for (people in creditedPeople){
    str <- str %>% paste0(", tags$b('", people,"'), ','")
  }
  str <- str %>% paste0(", 'and inspired by Info 201 members.')) ")
  
  str
}







my_ui <- fluidPage(
  # # A static content element: a 2nd level header that displays text
  # h2("Greetings from Shiny"),
  # 
  # # A widget: a text input box (save input in the `username` key)
  # textInput(inputId = "username", label = "What is your name?"),
  # 
  # # An output element: a text output (for the `message` key)
  # textOutput(outputId = "message"),
  # 
  titlePanel("Is this what ur talking about 'the tabs with individual linked sidebars?'"),
  
  sidebarLayout(
    
    
    sidebarPanel(
      # Inputs excluded for brevity
      # A widget: a text input box (save input in the `username` key)
      # textInput(inputId = "username", label = "What is your name?"),
      selectInput("dataset", "Choose a dataset:",
                  choices = c("rock", "pressure", "cars")),
      numericInput("obs", "Observations:", 10)
    ),
    
    
    mainPanel(
      # tabPanel("Plot", plotOutput("plot")), 
      # tabPanel("Summary", verbatimTextOutput("summary")), 
      # tabPanel("Table", tableOutput("table")),
      tabsetPanel(
        tabPanel("stuff A",
                 # An output element: a text output (for the `message` key)
                 
                 
                 sidebarPanel(
                   textInput(inputId = "username", label = "What is your name?")
                   ),
                 textOutput(outputId = "message")
                 
                 ),
        tabPanel("stuff B",
                 # An output element: a text output (for the `message` key)
                 
                 
                 sidebarPanel(
                   textInput(inputId = "username2", label = "What is your name again?")
                 ),
                 textOutput(outputId = "message2")
                 
        )
        # ,
        # tabPanel("Plot", textOutput(outputId = "message")),
        # tabPanel("Summary", textOutput(outputId = "message")),
        # tabPanel("Table", textOutput(outputId = "message"))
      )
    )
    
    
    
  ),
  
  div(
    br(),
    hr(),
    eval(parse(text = inputCreditedPeople(creditedPeople)))
  )
  
  
)
