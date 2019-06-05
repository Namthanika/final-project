library("shiny")
library("dplyr")

# 
# 

source("./app/server.R")
source("./app/ui.R")

# source("./app/debug_server.R")

# source("./app/debug_ui.R")

# source("./app/plot.R")

## to be implement new feture : radial choise: larger map vs larger graph


# To start running your app, pass the variables defined in previous
# code snippets into the `shinyApp()` function


shinyApp(ui = my_ui, server = my_server)

# shinyApp(ui = my_ui, server = debug_server)