# install new packages if needed otherwise just call library("package name")
library("dplyr")
library("reshape")
library("fiftystater") ## Please install it by `devtools::install_github("wmurphyrd/fiftystater")` 
library("shiny")
library("leaflet")
library("ggplot2")
library("R.utils")
library("viridis")
library("tidyverse")
library("data.table")
library("shinythemes")

## fread for faster performance.
sales <- fread("./data/Sale_Prices_Msa.csv", stringsAsFactors = F)
zri_forecasts <- fread("./data/ZriForecast_Public.csv", stringsAsFactors = F)
zhvis <- fread("./data/Metro_Zhvi_Summary_AllHomes.csv", stringsAsFactors = F)
zris <- fread("./data/Metro_Zri_AllHomesPlusMultifamily_Summary.csv", stringsAsFactors = F)
state_abbr_table <- read.csv("./data/states.csv", stringsAsFactors = FALSE)