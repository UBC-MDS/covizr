#' Create a line chart presenting specific country/countries COVID information
#' within a time period
#'
#' @param df Data frame of the selected covid data from get_data()
#' @param location Charactor vector of target country names. By default c('Canada)
#' @param val Quantitative values to be aggregated. Must be numeric variable.
#' Also known as a 'measure'. By default 'new_cases'
#' @param date_from Start date of the data range with format like '2021-10-31'.
#' By default 'NULL' is used to represent 7 days prior to today's date
#' @param date_to End date of data range with format like '2021-10-31'.
#' By default 'NULL' is used to represent 7 days prior to today's date
#' @param title The title of the plot. By default will be generated based on val
#'
#' @return A ggplot line chart
#' @export
#'
#' @examples
#' plot_spec(df, date_from = "2022-01-01", date_to = "2022-01-14", location = c("Canada", "China", "Cuba"))
plot_spec <- function(df,
                      location = c("Canada"),
                      val = c("new_cases"),
                      date_from = NULL,
                      date_to = NULL,
                      title = NULL) {
  # Init date if NULL
  if (is.null(date_from)) {
    date_from <- format(Sys.Date() - 7, "%Y-%m-%d")
  }

  if (is.null(date_to)) {
    date_to <- format(Sys.Date(), "%Y-%m-%d")
  }

  # Exception Handling
  if (!is.data.frame(df)) {
    stop("Invalid argument type: df must be a data frame.")
  }

  if (!is.character(location)) {
    stop("Invalid argument type: location must be a character vector.")
  }

  if (!is.character(val) | length(val) > 1) {
    stop("Invalid argument type: val must be a string.")
  } else if (!is.numeric(df[[val]])) {
    stop("Invalid argument type: val must be a numeric variable.")
  }

  if (!is.character(date_from) | length(date_from) > 1) {
    stop("Invalid argument type: date_from must be in string format of YYYY-MM-DD.")
  } else if (is.na(as.Date(date_from, "%Y-%m-%d"))) {
    stop("Invalid argument value: date_from must be in format of YYYY-MM-DD. Also check if it is a valid date.")
  }

  if (!is.character(date_to) | length(date_to) > 1) {
    stop("Invalid argument type: date_to must be in string format of YYYY-MM-DD.")
  } else if (is.na(as.Date(date_to, "%Y-%m-%d"))) {
    stop("Invalid argument value: date_to must be in format of YYYY-MM-DD. Also check if it is a valid date.")
  }

  if (date_to < date_from) {
    stop("Invalid values: date_from should be smaller or equal to date_to (or today's date if date_to is not specified).")
  }

  if (date_to > Sys.Date()) {
    stop("Invalid values: date_to should be smaller or equal to today.")
  }

  if (!is.null(title)){
    if(!is.character(title) | length(title) > 1){
      stop("Invalid argument type: title must be a string.")
    }
  }

  # Filter by date and country
  location_spec <- location
  df <- df |>
    dplyr::filter(date >= date_from, date <= date_to) |>
    dplyr::filter(location %in% location_spec)

  # Create Y axis label
  val_label <- stringr::str_to_title(stringr::str_replace(val, "_", " "))

  # init plot title if None
  if (is.null(title)){
    title <- paste("Covid", val_label)
  }

  orders <- df |>
    dplyr::group_by(location) |>
    dplyr::filter(date==max(date)) |>
    dplyr::select(location,val,date)

  plot <- df |>
    ggplot2::ggplot(ggplot2::aes_string(x="date",y=val, color="location", label="location")) +
    ggplot2::geom_line()+
    ggplot2::geom_text(data=orders, ggplot2::aes_string(x="date",y=val, color="location"),vjust=-1)+
    ggthemes::scale_color_tableau()+
    ggplot2::theme(legend.position = 'none')+
    ggplot2::labs(x="Date", y=val_label, title=title)+
    ggplot2::scale_x_date(date_labels =  "%Y-%m-%d")

  plot
}
