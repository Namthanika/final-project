library("shiny")
library("dplyr")

source("./R/ui.R")
source("./R/server.R")







# To start running your app, pass the variables defined in previous
# code snippets into the `shinyApp()` function
shinyApp(ui = my_ui, server = my_server)