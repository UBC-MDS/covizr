#' Generate summary plot
#'
#' Create a horizontal bar chart summarizing a specified variable and value
#' within a time period
#'
#' @param df Data frame of the selected covid data from get_data()
#' @param var Qualitative values to segment data. Must be a categorical variable.
#' Also known as a 'dimension'. By default 'location'
#' @param val Quantitative values to be aggregated. Must be numeric variable.
#' Also known as a 'measure'. By default 'new_cases'
#' @param fun Aggregation function for val, by default 'sum'
#' @param date_from Start date of the data range with format 'YYYY-MM-DD'. By default 'NULL' is used to represent 7 days prior to today's date
#' @param date_to End date of data range with format 'YYYY-MM-DD'. By default 'NULL' is used to represent today's date
#' @param top_n Specify number of qualitative values to show, by default 5
#'
#' @return ggplot chart object
#' @export
#'
#' @examples
#' plot_summary(var = "location", val = "new_cases", fun = "sum",
#' date_from = "2022-01-01", date_to = "2022-01-13", top_n = 5)
plot_summary <-
  function(df,
           var = "location",
           val = "new_cases",
           fun = "sum",
           date_from = NULL,
           date_to = NULL,
           top_n = 5) {

    # init date if NULL
    if (is.null(date_from)) {
      date_from <- today() - days(7)
    }

    if (is.null(date_to)) {
      date_from <- today()
    }

  }
