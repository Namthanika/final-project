# **Project Description**

>We will be working on **information related to housing**, i.e. _**the median estimated home value cross a given city and states, home listings and sales, rental value, and value forecast**_.  These dataset are retrieved from the [**Zillow database**](https://www.zillow.com/research/data/). Zillow constantly collects and updates that data. Zillow has over 100 million homes in their database and creates Zestimate, an estimate of value for each home (based on the “Automated value models”). Zillow states that “The models are re-trained three times a week based on the latest data, and each home’s Zestimate is updated daily.” For each of the dataset:

1.  the median estimated home value cross a given region
   - The indices are available for more than 350 metropolitan statistical areas.
   2. The median of home value is represented by [_Zhvi_](https://www.zillow.com/research/zhvi-methodology-6032/) which is Zillow Home Value Index. Zhvi is the median of Zestimate values.
   3. The data contains Regional ID, Region name, State, SizeRank, Zhvi, Month-over-Month, Year-Over-Year, 5 years, 10 years, Peak month, Peak ZHVI, LastTimeAtCurrZHII[b][c]
      1. LastTimeAtCurrZHII indicates the last month the at they updated the data which is used as a reference point in time.
1. home listings and sales
   - It contains the median value of houses in US dollars in the area. It is recorded by monthly.
1. rental value
   - Similar to Zhvi, the data is recorded in the format of [_Zri_](https://www.zillow.com/research/zillow-rent-index-methodology-2393/) which is shortened for Zillow Rent index. Zri is used to track the monthly median rent in particular geographical regions.
1. Forecast in rental value
   - Some of useful information is current Zri and Year-over-year forecast.

One of our main audience is home investors - people who are interested in investing their money in houses either to live or making income from renting a tenant. Some of the questions that our project will be able to address our customers are:
1. Have the value of the houses in the specific are been increasing for the past 5 few years? How much has it been increase or decrease?
2. What is the current house value and rent value in certain region?
3. Is there an expected increase in rent value? As a landlord, how much profit he/she will expect to gain over the next year in the region?

With our data visualizations and processing, our audience can plan better on their real-estate investment in future.

--------------------
# **Technical Description**
>All of the dataset that we collect right now are in the `.csv` files. The 2 datasets that we will have to reformat/reshape are the median estimated home values, and the forecasted rental value because they are in unpivoted format, i.e having a column storing reference months (long table) instead having each column be the month itself (wide table). The other 2 datasets are formatted in a wide table where each column is the values in the specific month. Some of  major libraries we will be using are: `US map, ggplot2, shiny`, etc. Since most of the data has already been statistically analyzed by Zillow, we won’t need to do much of the statistical analysis. However,  once interesting question that we can add to the project is how the economic growth in the area is correlated to the housing and renting values. We can look into some statistical models to see the relationship between them, i.e. they may have the same increasing or decreasing factor variable.

The major challenges that we anticipated are:
* Since we require to reformat some of data, we need to be careful on not changing the raw dataset.
* In order to use the provided R packages effectively, we need to make sure that our data is in the format that can utilize the packages smoothly.
* Working in a team can be hard. Thus, breaking the structure of the project needs to be done deliberately. Making sure that there won’t be any conflict in implementation.
