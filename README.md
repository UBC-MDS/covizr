
<!-- README.md is generated from README.Rmd. Please edit that file -->

# covizr <img src='https://github.com/UBC-MDS/covizr/raw/main/img/logo.png' align="right" style="width:100px;height:100px;"/>

<!-- badges: start -->

[![codecov](https://codecov.io/gh/UBC-MDS/covizr/branch/main/graph/badge.svg?token=noFqX1BkyC)](https://codecov.io/gh/UBC-MDS/covizr)
[![R-CMD-check](https://github.com/UBC-MDS/covizr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/UBC-MDS/covizr/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

`covizr` is a R package that provides easy access to Covid-19 data from
[Our World in Data](https://ourworldindata.org/coronavirus), as well as
functions to generate relevant Covid-19 charts and summaries easily. We
aim to make `covizr` simple and easy to use. Our goal is to enable
anyone with basic R programming knowledge to access and visualize
Covid-19 data, and make their own informed decisions and conclusions.

There are existing R packages that allow users to download and generate
Covid-19 charts. For example,
[covid19](https://github.com/covid19datahub/COVID19/) is a package that
presents worldwide COVID-19 data from several sources in a R
environment.

We aim to provide simple visualization functions that allow users to
answer questions regarding the Covid-19 pandemic as quickly as possible.

## Features

This package contains four functions: `get_data`, `plot_metric`,
`plot_spec` and `plot_summary`.

-   `get_data`: User can retrieve the COVID data from the source as a
    dataframe. Specific data can be retrieved by passing the date range
    and the list of countries

-   `plot_metric`: Create a line chart presenting COVID total new cases
    verses another metric within a time period

-   `plot_spec`: Create a line chart presenting specific
    country/countries COVID information within a time period

-   `plot_summary`: Create a horizontal bar chart summarising a
    specified variable and value within a time period

## Installation

``` r
# Uncomment the below line to install `devtools` if not installed. 
# install.packages("devtools") 
devtools::install_github("UBC-MDS/covizr")
```

After installation, we recommend to restart the R session before
proceeding, as there may be dependencies packages being updated.

## Usage and Examples

To use the package, import the package with following commands:

``` r
library(covizr)
```

To use the functions, see below examples:

### Retrieve COVID-19 data with specified date range and default all locations

``` r
df = get_data(date_from="2022-01-01", date_to="2022-01-21")
```

### Plot summary graph (bar chart)

``` r
plot_summary(df, var="location", val="new_cases", fun="sum", date_from="2022-01-01", date_to="2022-01-15", top_n=10)
```

![Summary
graph](https://github.com/UBC-MDS/covizr/raw/main/img/plot_summary.png)

### Plot COVID-19 cases for specific countries (line chart)

``` r
plot_spec(df, location=c("Canada", "Turkey"), val="new_cases", date_from="2022-01-01", date_to="2022-01-07")
```

![New COVID-19 specific
graph](https://github.com/UBC-MDS/covizr/raw/main/img/plot_spec.png)

### Plot new COVID-19 cases versus another metric (line chart)

``` r
plot_metric(df, loc_val = c("Canada"), metric='positive_rate', date_from="2022-01-15", date_to="2022-01-21")
```

![New COVID-19 case metric
graph](https://github.com/UBC-MDS/covizr/raw/main/img/plot_metric.png)

## Contributors

-   Rohit Rawat
-   Rong Li
-   Thomas Siu
-   Ting Zhe Yan

## Contributing

Interested in contributing? Check out the contributing guidelines.
Please note that this project is released with a Code of Conduct. By
contributing to this project, you agree to abide by its terms.

## License

`covizr` was created by Rohit Rawat, Rong Li, Thomas Siu, Ting Zhe Yan.
It is licensed under the terms of the MIT license.
