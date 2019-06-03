library("shiny")
library("dplyr")



source("./app/server.R")
source("./app/ui.R")



# To start running your app, pass the variables defined in previous
# code snippets into the `shinyApp()` function
shinyApp(ui = my_ui, server = my_server)