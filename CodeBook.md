# Code Book

This file contains information about the data being presented, its variables and the transformations performed to clean up the data.

## The data

The data provides the averages of each of the variables being presented, when grouped both by activity and by subject at the same time.

## The variables

Since there is a considerable ammount of variables in the data set, it is easier to explain the logic behind their names, instead of describing each one individually. They are mostly presented in a set of dichotomies.

- MEAN or SD

The first element of the name is either "MEAN" or "SD" in every case. They indicate whether the measurement being provided is the mean (MEAN) or the standard deviation (SD) of the variable being evaluated.

- Body or Gravity

In this case, the term indicates if what is being evaluated is the body or the gravity acceleration signals, respectively.


- Linear or Angular

These represent the tipe of acceleration being evaluated (linear or angular acceleration).


- TimeDomain or FreqDomain

Here, the information is about whether the measurement registered is in the time domain or in the frequency domain.

- X, Y or Z

These inform the measurement obtained for a particular axis (either X, Y or Z).

- Gyroscope

This indicates if the data was obtained through a gyroscope.


- Magnitude

This element shows that the measurement obtained represents the magnitude of the three-dimensional signals (X, Y and Z).

## The transformations

First, Both the test and training dataset were merged into a single dataset (as demanded in 1. at the Course Project). Then, columns that did not provide either the mean or the standard deviation of a measurement were removed from the data (as demanded in 2.). After that, names were added to the columns, following the logic presented at the section before. Lastly, two new variables were created [indicating the subject being analyzed and their respective activity (set as factor)], so that the tidy data demanded could be provided through grouping.
