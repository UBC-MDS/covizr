#' Create a line chart presenting specific country/countries COVID information
#' within a time period
#'
#' @param df Data frame of the selected covid data from get_data()
#' @param location Charactor vector of target country names. By default c('Canada)
#' @param val Quantitative values to be aggregated. Must be numeric variable.
#' Also known as a 'measure'. By default 'new_cases'
#' @param date_from Start date of the data range with format like '2021-10-31'.
#' By default it represents 7 days prior to today's date
#' @param date_to End date of data range with format like '2021-10-31'. By default it represents today's date
#' @param title The title of the plot. By default will be generated based on val
#'
#' @return A ggplot line chart
#' @export
#'
#' @examples
#' plot_spec(df, date_from = "2022-01-01", date_to = "2022-01-14")
plot_spec <- function(df, location = c('Canada'), val = "new_cases", date_from = NULL, date_to = NULL, title = NULL) {

}
