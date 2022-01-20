#' Get COVID-19 data as data frame
#'
#'Retrieve covid data in pandas dataframe format witg tge time periods provided
#'
#' @param date_from Start date of the data range with format like '2021-10-31'. By default it represents 7 days prior to today's date
#' @param date_to End date of data range with format like '2021-10-31'. By default it represents today's date
#' @param location Charactor vector of target country names. By default it retrieves all countries
#'
#' @return data.frame
#' @export
#'
#' @examples
#' get_data(date_from='2022-01-01', date_to="2022-01-07", location=c('Canada'))
get_data <- function(date_from, date_to, location) {

}
