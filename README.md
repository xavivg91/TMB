# TMB package

<!-- badges: start -->
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/dwyl/esta/issues)
[![HitCount](http://hits.dwyl.com/xavivg91/TMB.svg)](http://hits.dwyl.com/xavivg91/TMB)
<!-- badges: end -->

## Introduction 

[TMB](https://www.tmb.cat/en/home) (Transports Metropolitans de Barcelona) is the main public transport operator in Catalonia and a benchmark public mobility company in Europe and the world.

## Overview

The TMB package opens a connection to the [TMB API](https://developer.tmb.cat/) to retrieve data related to the bus and metro service in Barcelona.

## Installation

```R
# install.packages("devtools")
devtools::install_github("xavivg91/TMB")
```
## Usage

`library(TMB)` will load the following core functions:

* `bus.stops()`, for the bus stops and lines in Barcelona. You can extract information like routes, geographical data (including latitude and longitude), distance between bus stops, etc.

```R
# Without the line argument, the function retrieves data from all bus stops
bus.stops(app_id, app_key)

# Bus stops corresponding to the specified line
bus.stops(app_id, app_key, line = c(6, 7, 11, 13, 19, 21, 22, 23, 24, 27, 33, 34, 39,
                                    46, 47, 52, 54, 55, 59, 60, 62, 63, 65, 67, 68,
                                    70, 75, 76, 78, 79, 91, 94, 95, 96, 97, 100, 101,
                                    102, 103, 104, 107, 109, 110, 111, 112, 113, 114,
                                    115, 116, 117, 118, 119, 120, 121, 122, 123, 124,
                                    125, 126, 127, 128, 129, 130, 131, 132, 133, 135,
                                    136, 150, 155, 157, 165, 185, 191, 192, 196, 201,
                                    202, 203, 204, 205, 206, 207, 208, 209, 210, 211,
                                    212, 213, 214, 215, 216, 217, 219, 220, 221, 223,
                                    225, 227, 229, 231, 233, 240, 250))
```                         

* `metro.stations()`, for the metro stations and lines in Barcelona.

```R
# Without the line argument, the function retrieves data from all metro stations
metro.stations(app_id, app_key)

# Metro stations corresponding to the specified line
metro.stations(app_id, app_key, line = c(1, 2, 3, 4, 5, 11, 91,
                                         94, 99, 101, 104))
```  

## How it works

Let’s say we want to obtain a data set related to sports. First, we need to execute the `dataselist()` function to see all the
sports data sets available on the Open Data BCN portal.

```R
# List of sports data sets available on the portal
datasets <- datasetlist(subtopic = "Sport")
```
Once executed, check out the saved data frame and copy the resource ID of the CSV you want to consult (inside the ID column). 
Then, paste the ID as an input argument of the `get.csv()` function. 

```R
# Save the CSV data set in your RStudio environment 
sportdataset <- get.csv(id = "cd8d0d2b-b97a-4aba-b1c8-e25696379a58")
```

Easy peasy, right?

## Data Ownership

All extracted baRcelona data belong to the [Open Data BCN portal](https://opendata-ajuntament.barcelona.cat/en/node).
