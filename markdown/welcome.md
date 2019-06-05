# INTRODUCTION

# Welcome!
We will be working on **information related to housing**, i.e. _**the median estimated home
value cross a given city and states, home listings and sales, rental value, and value forecast**_.
These dataset are retrieved from the [**Zillow database**](https://www.zillow.com/research/data/).
Zillow constantly collects and updates that data. Zillow has over 100 million homes in their database
and creates Zestimate, an estimate of value for each home (based on the “Automated value models”).

### Target Audience
Our main audience is home investors - people who either are investing their money in houses
either to live or making income from renting a tenant. These people can look at these information on 3
different levels from a big point of view to a smaller point of view. Audience can look at:
1. National level: to  see how the trend is going in the past year and to help analyze the increase in housing price.
2. State level: given a year, user can use the plot to compare the housing price in different states
3. City level: can see the price changes from the past to the current year of the select city

### Questions That Can Be Answered
* Have the value of the houses in the specific are been increasing for the past 5 few years? How much has it been increase or decrease?
* What is the current house value in certain region?
* Is there an expected increase in rent value? As a landlord, how much profit he/she will expect to gain over the next year in the region?
* How the economic growth in the area is correlated to the housing and renting values. We can look into some statistical models to see the relationship between them, they may have the same increasing or decreasing factor variable.

With our data visualizations and processing, our audience can plan better on their real-estate investment in future.

### Design Process & Challenges
To start our Design Process, we chose an important topic that everyone in our group
was interested in: United States housing market. Zillow had everything we need to
collect this data. We needed to create readable data visualizations that will help
our target audience make better decisions when looking at homes.

Then, we began to divide the work. All of the dataset that we collect are in the
'.csv' files. Two of us worked on creating the visualizations,
and data wrangling. The other two worked on the home page, and help formatting, styling
the application.

The biggest challenges is when we were when we had to reformat the 2 datasets
we used, the median estimated home values, and the forecasted rental value because
they are in unpivoted format, i.e having a column storing reference months (long table)
instead of having each column be the month itself (wide table).

Working in a team was hard. It's very difficult to equally split the work and
give everyone a chance to input their ideas. We tried hardest to include the ideas
from each team member and implemented them.

## Libraries
We used several R libraries to help format the application and wrangle the data:

* **tidyverse** - set of packages that work in harmony because they share common
data representations and 'API' design
* **dplyr** - shortcuts for subsetting, summarizing, rearranging, and joining together
data sets
* **shiny** - Easily make interactive web apps with R
* **leaflet** - create and display maps, helps the implementation of the map visualizations
* **ggplot2** - lets you use the grammar of graphics to build layered, customizable plots
* **R.utils** - utility functions useful when programming and developing R packages
* **viridis** - use the color scales to make plots to better represent your data
* **reshape** - restructure and aggregate the data
* **fiftystater** - map data to visualize the fifty U.S. states
