# The server is a function that takes `input` and `output` arguments
my_server <- function(input, output) {
  # Assign a value to the `message` key in the `output` list using
  # the renderText() method, creating a value the UI can display
  output$message <- renderText({
    # This block is like a function that will automatically rerun
    # when a referenced `input` value changes
    
    # Use the `username` key from `input` to create a value
    message_str <- paste0("Hello ", input$username, "!")
    
    # Return the value to be rendered by the UI
    message_str %>% return()
    
  })
  
  
  output$message2 <- renderText({
    # This block is like a function that will automatically rerun
    # when a referenced `input` value changes
    
    # Use the `username` key from `input` to create a value
    message_str <- paste0("niec to meet you ", input$username2, "!")
    
    # Return the value to be rendered by the UI
    message_str %>% return()
    
  })

  
  
}
