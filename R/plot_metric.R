#' Plot a line chart using ggplot
#'
#' @param df Data frame of the selected COVID data from get_data()
#' @param loc_val A character vector of target country name. By default c('Canada)
#' @param metric A character vector with, at most, one element.
#' @param date_from A character vector having the starting date, one element.
#' @param date_to A character vector having the end date, one element.
#' @param location A character vector containing the locations around the world
#' @param new_cases A character vector containing aggregated total new COVID cases
#'
#' @return A ggplot line chart
#' @export
#'
#' @examples
#' data <- get_data(date_from = "2022-01-01", date_to = "2022-01-07")
#' loc <- c("Canada")
#' x <- "positive_rate"
#' plot_metric(df = data, loc_val = loc, metric = x, date_from = "2022-01-01", "2022-01-15")
plot_metric <- function(df,
                        loc_val = "Canada",
                        metric = "positive_rate",
                        date_from = NULL,
                        date_to = NULL,
                        location = NULL,
                        new_cases = NULL) {

  # init date if NULL
  if (is.null(date_from)) {
    date_from <- lubridate::today() - lubridate::days(7)
  }

  if (is.null(date_to)) {
    date_to <- lubridate::today()
  }

  # Exception Handling
  if (!is.data.frame(df)) {
    stop("Data not found. df must be a data.frame!")
  }

  if (!is.character(loc_val)) {
    stop("Invalid argument type: loc_val must be a character vector.")
  }

  if (!is.character(metric)) {
    stop("Invalid argument type: Metric must be a string.")
  }

  if (!metric %in% colnames(df)) {
    stop("Invalid argument value: Metric is not a valid column name!")
  }

  if (!is.numeric(df[[metric]])) {
    stop("Invalid argument type: Metric must be a numeric variable.")
  }

  if (date_to < date_from) {
    stop("Invalid values: date_from should be smaller or equal to date_to.")
  }

  if (date_to > lubridate::today()) {
    stop("Invalid values: date_to should be smaller or equal to today.")
  }

  # Parse date
  date_from <- lubridate::ymd(date_from)
  date_to <- lubridate::ymd(date_to)

  # Convert 'date' to date format
  df$date <- lubridate::ymd(df$date)

  # Filter by date
  df <- df %>% dplyr::filter(dplyr::between(date, date_from, date_to))


  metric <- rlang::sym(metric)
  y_label <- paste("Mean", stringr::str_replace(metric, "_", " "))
  title <- paste("Daily COVID cases versus", y_label, "in", loc_val)

  plot_df <- df |>
    dplyr::filter(location == loc_val) |>
    dplyr::group_by(date) |>
    dplyr::summarise(
      new_cases := sum(new_cases, na.rm = TRUE),
      metric := mean({{ metric }}, na.rm = TRUE)
    ) |>
    dplyr::filter(!is.na(metric))

  coeff <- plot_df |>
    dplyr::select(new_cases) |>
    max() / plot_df |>
      dplyr::select(metric) |>
      max()

  plot_line <- ggplot2::ggplot(plot_df, ggplot2::aes(x = date)) +
    ggplot2::geom_line(ggplot2::aes(y = new_cases), color = "blue", na.rm = TRUE) +
    ggplot2::geom_line(ggplot2::aes(y = metric * coeff), color = "orange", na.rm = TRUE) +
    ggplot2::scale_x_date(date_labels = "%Y-%m-%d") +
    ggplot2::scale_y_continuous(

      # Features of the first axis
      name = "Daily new cases",

      # Add a second axis and specify its features
      sec.axis = ggplot2::sec_axis(~ . / coeff, name = y_label)
    ) +
    ggplot2::xlab("Date") +
    ggplot2::ggtitle(title)

  return(plot_line)
}
