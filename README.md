# Nowcasting

This code implements the nowcasting framework described in "[Macroeconomic Nowcasting and Forecasting with Big Data](https://www.newyorkfed.org/research/staff_reports/sr830.html)" by Brandyn Bok, Daniele Caratelli, Domenico Giannone, Argia M. Sbordone, and Andrea Tambalotti, *Staff Reports 830*, Federal Reserve Bank of New York (prepared for Volume 10 of the *Annual Review of Economics*).

**Note:** These example files do not exactly reproduce the New York Fed Staff Nowcasting Report released every Friday because data redistribution restrictions prevent us from providing the complete data set used in our model.


## Download instructions

Download the code as a ZIP file by clicking the green 'Clone or download' button and selecting 'Download ZIP'.

## File and folder description

* `data/` : example US data downloaded from [FRED](https://fred.stlouisfed.org/)
* `functions/` : functions for loading data, estimating model, and updating predictions
* `example_DFM.m` : example script to estimate a dynamic factor model (DFM) for a panel of monthly and quarterly series
* `example_Nowcast.m` : example script to produce a nowcast or forecast for a target variable, e.g., real GDP growth
* `ResDFM.mat` : example DFM estimation output
* `Spec_US_example.xls` : example model specification for the US


## Required software and versioning

MATLAB is required to run the code. The code was tested in MATLAB R2015b and later versions. Functionality with earlier versions of MATLAB is not guaranteed.
