# Project-On-Delhi-Air-Pollution
Particulate matter (PM ) has been recorded in Delhi to understand the air quality on an hourly basis for 4 months. Our objective is to forecast the data available .
## Data Set Details:--

PM2. 5 refers to atmospheric particulate matter (PM) that have a diameter of less than
2.5 micrometers, which is about 3% the diameter of a human hair and usually seen
through a microscope.
There are 2374 records of  pm25 and date. Date variable contains dates with hourly records of pm2.5.

## Acceptance Criteria:--
Should get the least possible RMSE and the model should be deployed
using Flask/ RShiny/Heroku.

## Forecasting Strategy:--

- [Define Goal](https://github.com/chetansy/Project-On-Delhi-Air-Pollution#define-goals)
- [Explore & Visualize Data](https://github.com/Nilayy7/Project-On-Delhi-Air-Pollution#explore--visualize-data)
- [Pre-Processing Of Data](https://github.com/Nilayy7/Project-On-Delhi-Air-Pollution#pre-processing-of-data)
- [Partition Series](https://github.com/Nilayy7/Project-On-Delhi-Air-Pollution#partition-series)
- [Apply Forecasting Models](https://github.com/Nilayy7/Project-On-Delhi-Air-Pollution#apply-forecasting-models)
- [Evaluate & Compare Models](https://github.com/Nilayy7/Project-On-Delhi-Air-Pollution#evaluate--compare-models)
- [Model Selection](https://github.com/Nilayy7/Project-On-Delhi-Air-Pollution#model-selection)
- [Indication Of PM2.5](https://github.com/Nilayy7/Project-On-Delhi-Air-Pollution#indication-of-pm25)

### Define Goals
* It is ideal database to statistically forecast Air Quality for the next few days, knowing how the pollution levels behaved in the past under similar meteorological conditions. However, this database is not enough to explain the highs and lows, source contributions, and spatial patterns of pollution, especially in an environment where the monitoring database is limited. In such a case, forecasts based on multi-pollutant chemical transport modeling systems is a necessity. and complementary in not only providing support to short-term pollution and health alerts, but also for long-term pollution control planning.
* As We have 4 months of Past Data on Horly Basis , so We will have to forecast the data for next few days.

### Explore & Visualize Data
#### NA Distribution
![with NA](https://user-images.githubusercontent.com/62282151/84376292-86cf5900-abfe-11ea-936f-1c2411550b61.png)

#### Hourly Average 
![hourly avg](https://user-images.githubusercontent.com/62282151/84376380-b1211680-abfe-11ea-9ebf-0d6197a221b6.png)

#### Daily Average 
![daily avg](https://user-images.githubusercontent.com/62282151/84376461-cdbd4e80-abfe-11ea-9985-40601bef03af.png)

#### Weekly Average 
![weekly avg](https://user-images.githubusercontent.com/62282151/84376541-efb6d100-abfe-11ea-9907-e98380ce82a2.png)

#### Monthly Average 
![monthly avg](https://user-images.githubusercontent.com/62282151/84376612-09581880-abff-11ea-82ba-53348f7cdd03.png)



### Pre-Processing Of Data
- The variable pm25 has 80 missing values.
- The variable date also contain some missing time stamps.
- After applying padding to the entire data set, the pm25 variable contains 323 missing values.
- Thus the final data set contains 2617 observations  with two variables and there are 323 NA values in the variable pm25.


### Partition Series
- Training data and test data are two important concepts in machine learning.
- Training Data ---
 The observations in the training set form the experience that the algorithm uses to learn.
- Test Data ---
The test set is a set of observations used to evaluate the performance of the model using some performance metric. It is important that no observations from the training set are included in the test set. If the test set does contain examples from the training set, it will be difficult to assess whether the algorithm has learned to generalize from the training set or has simply memorized it.
- The data for the Modeling was splitted into two parts Training & Test data.
- Train data contain 80% of the data whereas test data contain 20% of the data.


### Apply Forecasting Models
We Have Tried Various Techniques Like
- Auto-Arima Method
- Holts Method
- Neural Network Method
- HoltsWinters Method


### Evaluate & Compare Models
- Time series models predict values of the variable being forecasted based on historical
patterns. Thus the basic underlying assumption of these methods is that future
patterns are similar to historical patterns. 
- We have used four forecasting models above. Table below summarizes the appropriateness of the four types of forecasting models.
- To evaluate forecast models, two aspects of terms are often concerned about: ACCURACY and BIAS.
Accuracy refers to the distance between the Forecast and Actual values. And a forecast is biased if the errors in one direction are significantly larger than those in other directions.
- In general, the basic objective of all forecast models is to maximize accuracy and minimize bias. After fitting several model candidates to a given data set.
- The next step is to compare and select the best forecasting model. A lot of criteria have been proposed to compare forecasting models,

    | Models | Train RMSE | Test RMSE | Whole Data RMSE |
    | ------ | ---------- | --------- | --------------- |
    | Auto-Arima  | 50.33  |   91.16   |      52.78      |
    | Holts       | 55.17  |   141.45  |      53.61      |
    | HoltsWinter | 88.93  |   94.44   |      56.15      |
    | Nnetar      | 31.97  |   71.12   |      33.57      |


### Model Selection
- We will prefer nnetar for forecasting as RMSE seems to be low compared to other

### Indication Of PM2.5
![pm2 5](https://user-images.githubusercontent.com/62282151/84380206-9782cd80-ac04-11ea-857f-de02f432fcd6.png)
