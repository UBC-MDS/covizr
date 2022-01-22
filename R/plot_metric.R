#' Plot a line chart using ggplot
#'
#' @param metric A character vector with, at most, one element.
#' @param date_from A character vector having the starting date, one element.
#' @param date_to A character vector having the end date, one element.
#'
#' @return A ggplot line chart
#' @export
#'
#' @examples
#' x <- "positive_rate"
#' plot_metric(x, date_from = "2022-01-01", "2022-01-15")
#'
#' y <- "death_rate"
#' plot_metric(y, date_from = "2022-01-01", "2022-01-15")
plot_metric <- function(metric="positive_rate", date_from=NULL, date_to=NULL){
}
