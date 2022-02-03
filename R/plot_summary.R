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
#' @importFrom rlang :=
#'
#' @examples
#' df <- get_data(date_from = "2022-01-01", date_to = "2022-01-07")
#' plot_summary(
#'   df,
#'   var = "location", val = "new_cases", fun = "sum",
#'   date_from = "2022-01-01", date_to = "2022-01-13", top_n = 5
#' )
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
      date_from <- lubridate::today() - lubridate::days(7)
    }

    if (is.null(date_to)) {
      date_to <- lubridate::today()
    }

    # Exception Handling
    if (!is.data.frame(df)) {
      stop("df must be a data.frame!")
    }

    if (!is.character(var)) {
      stop("var must be a string!")
    }

    if (!is.character(val)) {
      stop("val must be a string!")
    }

    if (!is.character(fun)) {
      stop("fun must be a string!")
    }

    if (is.numeric(df[[var]])) {
      stop("val needs to be a categorical variable!")
    }

    if (!is.numeric(df[[val]])) {
      stop("val needs to be a numeric variable!")
    }

    if (!is.numeric(top_n) | top_n <= 0) {
      stop("top_n must be an integer bigger than zero")
    }

    if (date_to < date_from) {
      stop("Invalid values: date_from should be smaller or equal to date_to")
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

    # Beautify axis labels and title
    y_label <- stringr::str_to_title(stringr::str_replace(var, "_", " "))
    x_label <- stringr::str_to_title(stringr::str_replace(val, "_", " "))
    plot_title <- paste("Top", top_n, y_label, "by", x_label)
    if (date_from == date_to) {
      plot_subtitle <- paste("from", date_from)
    }
    else {
      plot_subtitle <- paste("from", date_from, "to", date_to)
    }

    # Aggregation
    var <- rlang::sym(var)
    val <- rlang::sym(val)
    fun <- eval(str2lang(fun))

    df_plot <- df %>%
      dplyr::group_by(!!var) %>%
      dplyr::summarise(value := fun(!!val)) %>%
      dplyr::slice_max(order_by = value, n = top_n)

    plot_obj <- ggplot2::ggplot(df_plot,
                                ggplot2::aes(y = stats::reorder(!!var, -value),
                                             x = value,
                                             fill = !!var)) +
      ggplot2::geom_bar(stat = "identity",
                        show.legend = FALSE) +
      ggplot2::scale_x_continuous(labels = scales::comma) +
      ggplot2::ylab(y_label) +
      ggplot2::xlab(x_label) +
      ggplot2::ggtitle(label = plot_title,
                       subtitle = plot_subtitle) +
      ggplot2::theme(plot.title=ggplot2::element_text(face="bold")) +
      ggplot2::theme(plot.subtitle=ggplot2::element_text(size=10, colour="gray"))

    return(plot_obj)
  }
