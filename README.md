# Evaluating Logistic Regression by Graphical Methods
Local mean deviance, empirical probability and partial residuals

We utilized some new methods to determine goodness of a typical logistic regression model.

Introduction:

Graphical displays are always helpful in predicting and detecting features in medical area. For
linear regression, it is very easy to fit a model to data. For logistic regression, binary data and
discrete points can be relatively hard to display features and make a prediction. We first tried
three methods which are used in Graphical Methods for assessing Logistic Regression Models [1].
These methods are extensions to linear models that work on logistic regressions including local
mean deviance plots, empirical probability plots and partial residual plots. Local mean deviance
plots can be used in general to measure how fit a model is. Empirical probability plots can help to
identify some outliers and regions with lack of fit. Partial residual plots can reach out to reasons
that lead to lack of fit and provide some guidelines to a better fit. In addition to the three
methods proposed in the paper, we tried Ridge and lasso to remove several predictors in order to
improve our graphical results. We also tested the model from a statistical perspective, using
likelihood ratio test and pseudo R squared test.

Dataset: (included in repo)

At university of Chicago’s Billings Hospital, a study related to patients’ survival conditions after
breast cancer surgery between 1958 and 1970 has been conducted. After that, a dataset
consisting of 306 observations has been formed. Each observation includes threes predictors and
their relative labels. Giving a deep research in this dataset, it is good for predicting the survival
rate of this surgery and providing references for both hospitals and patients.
Haberman’s survival dataset has three predictors: xi1 is the age of patient i at time of operation,
xi2 is the year of operation for patient i minus 1990; xi3 is the number of positive axillary nodes
related to patient i. The label yi equals to 1 if patients survived 5 years or longer and 0
otherwise.
