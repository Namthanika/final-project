# install new packages if needed otherwise just call library("package name")
download_and_load_packages <- function(required_packages) {
    repo <- "http://cran.us.r-project.org"
    for (package in required_packages) {
        if(!eval(parse(text = paste0("require(", package, ")")))) {
            install.packages(package, repos = repo)
        }
        eval(parse(text = paste0("library(", package, ")")))
    }
    
}

## <!-- add needed packages to this vector --> 
required_packages <- c("data.table", "dplyr", "ggplot2")
download_and_load_packages(required_packages)

## fread for faster performance.
sales <- fread("./data/Sale_Prices_Msa.csv", stringsAsFactors = F)
zri_forecasts <- fread("./data/ZriForecast_Public.csv", stringsAsFactors = F)
zhvis <- fread("./data/Metro_Zhvi_Summary_AllHomes.csv", stringsAsFactors = F)
zris <- fread("./data/Metro_Zri_AllHomesPlusMultifamily_Summary.csv", stringsAsFactors = F)
state_abbr_table <- read.csv("./data/states.csv", stringsAsFactors = FALSE)