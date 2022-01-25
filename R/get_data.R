#' Get COVID-19 data as data frame
#'
#' Retrieve covid data in pandas dataframe format witg tge time periods provided
#'
#' @param date_from Start date of the data range with format like '2021-10-31'. By default it represents 7 days prior to today's date
#' @param date_to End date of data range with format like '2021-10-31'. By default it represents today's date
#' @param location Charactor vector of target country names. By default it retrieves all countries
#'
#' @return data.frame
#' @export
#'
#' @examples
#' get_data(date_from = "2022-01-01", date_to = "2022-01-07", location = c("Canada"))
get_data <- function(date_from, date_to, location) {

  url <- "https://covid.ourworldindata.org/data/owid-covid-data.csv"

  if (missing(date_from)) {
    date_from <- Sys.Date() - 7
  } else if ((length(date_from) > 1) | (typeof(date_from)!= "character")) {
    stop("Invalid argument type: date_from must be in string format of YYYY-MM-DD.")
  } else if (is.na(as.Date(date_from, "%Y-%m-%d"))) {
    stop("Invalid argument value: date_from must be in format of YYYY-MM-DD. Also check if it is a valid date.")
  }

  if (missing(date_to)) {
    date_to <- Sys.Date()
  } else if ((length(date_to) > 1) | (typeof(date_to)!= "character")) {
    stop("Invalid argument type: date_to must be in string format of YYYY-MM-DD.")
  } else if (is.na(as.Date(date_to, "%Y-%m-%d"))) {
    stop("Invalid argument value: date_to must be in format of YYYY-MM-DD. Also check if it is a valid date.")
  }

  if (date_to < date_from) {
    stop("Invalid values: date_from should be smaller or equal to date_to.")
  }
  if (date_to > Sys.Date()) {
    stop("Invalid values: date_to should be smaller or equal to today.")
  }

  if (!missing(location)) {
    if (typeof(location)!="character") {
      stop("Invalid argument type: location must be a character vector.")
    }
  }

  tryCatch(
    {covid_df <- readr::read_csv(url)
    },
    error=function(e) {
      stop("The link to the data is broken.")
    } )

  covid_df <- covid_df |>
    dplyr::filter(date >= date_from, date <= date_to)

 if (!missing(location)) {

   location_ <- location
    covid_df <- covid_df |>
      dplyr::filter(location %in% location_)
 }

  covid_df <- dplyr::filter(covid_df, !stringr::str_detect("iso_code", "^OWID"))
}
