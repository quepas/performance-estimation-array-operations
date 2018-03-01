# Estimation

This directory contains a set of R scripts used for analyzing obtained measurements and calculating performance estimation with estimation errors.
These codes require R environment with `hydroGOF` package (for calculating prediction errors).

## Loading measurements

Measurements for given array operation, example code, and for selected performance aspect are stored in single CSV file.
The name of the file has following structure: `NAME_ASPECT.csv`.
Where `NAME` is a name of [array operation](../measurement/analyzed-codes/README.md) or example code.

The table consists of five columns:

* Size of input data used for measurement
* Minim

## Measuring errors

Estimation error are given as [normalized root-mean-square errors (NRMSE)](https://www.wikiwand.com/en/Root-mean-square_deviation#/Normalized_root-mean-square_deviation).
In order to mark an understimation we use minuses computed using [mean-square deviation (MSD)](https://www.wikiwand.com/en/Mean_signed_deviation).
Corresponding codes are in scripts:

* **SNRMSE.R** for _Signed NRMSE_
* **MSD.R**

## Estimating performance

Each code example has its own script starts with `estimateNAME.R`, where `NAME` is code name.