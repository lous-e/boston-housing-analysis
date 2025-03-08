# Boston Housing Analysis Project

## Overview
This project analyzes the Boston Housing Dataset to build a predictive model for estimating median house prices based on various socio-economic factors. The analysis incorporates features from the Boston Housing Dataset to create a hedonic pricing model that explains approximately 75% of the variance in housing prices.

## Authors
- Om Mehta $^{1}$
- Kirat Arora $^{1}$
- John Wang $^{1}$

Supervised by: Professor Jonathan Larson $^{1}$

$^{1}$ all affiliated to the University of Massachusetts, Amherst

## Dataset
The Boston Housing Dataset (Harrison and Rubinfeld) contains 506 records, where each data point represents a census tract in the Boston Standard Metropolitan Statistical Area (SMSA) from 1970. The dataset focuses on owner-occupied one-family houses.

### Variables
- **CRIM**: Per capita crime rate by town
- **ZN**: Proportion of residential land zoned for lots over 25,000 sq.ft
- **INDUS**: Proportion of non-retail business acres per town
- **CHAS**: Charles River dummy variable (1 if tract bounds river; 0 otherwise)
- **NOX**: Nitric oxides concentration (parts per 10 million)
- **RM**: Average number of rooms per dwelling
- **AGE**: Proportion of owner-occupied units built prior to 1940
- **DIS**: Weighted distances to five Boston employment centers
- **RAD**: Accessibility to radial highways
- **TAX**: Full-value property tax rate per $10,000
- **PTRATIO**: Pupil-teacher ratio by town
- **LSTAT**: Percentage of lower status population
- **MEDV**: Median value of owner-occupied homes in $1,000s (target variable)

## Methods

### Variable Transformations
To improve model performance, several variables were transformed:
- CRIM → logCRIM
- INDUS → logINDUS
- RAD → RAD.t (binary: 1 if RAD=24, 0 otherwise)
- DIS → logDIS
- LSTAT → logLSTAT

### Model 

- Input features:  ZN, CHAS, RM, AGE, TAX, PTRATIO, logINDUS, RAD.t, logDIS, logLSTAT
- Output feature: MEDV

## Key Findings

### Insights
- Model 3 (details in presentation) has the lowest training and test MSEs
- Explains 77% of variance
- Properties near the Charles River are valued approximately $2,644 higher on average
- Each additional room increases median house value by approximately $2,675
- A 10% increase in distance from employment centers decreases median price by $405
- A 10% increase in non-retail business acres decreases median price by $118

### Limitations
- The model explains only 77% of the variance, indicating room for improvement
- Residuals do not satisfy normality assumptions
- Multiple transformations were needed to achieve linearity
- The model uses many covariates which could lead to overfitting/multicollinearity

## Future Work
- Explore more flexible methods of curve fitting (random forests, decision trees)
- Consider alternative models like logistic regression for different outcome measures
- Further investigate the unexplained variance in housing prices

## References
- Coulson, N. E. and McMillen, D. P. (2008). Estimating time, age, and vintage effects in housing prices.
- Harrison, D. J. and Rubinfeld, D. L. (1978). Hedonic housing prices and the demand for clean air.
- Svensson, L. E. (2013). The effect on housing prices of changes in mortgage rates and taxes.
- Thaler, R. (1978). A note on the value of crime control: Evidence from the property market.
- Wei-Shong Lin, Jen-Chun Tou, S.-Y. L. M.-Y. Y. (2014). Effects of socioeconomic factors on regional housing prices in the USA.
- Wing, C. K. and Chin, T. (2003). A critical review of literature on the hedonic price model.