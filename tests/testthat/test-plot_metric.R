df <- readr::read_rds("test_df_plot_spec.rds")

test_that("Test input type error of plot_metric()", {
  # check input type of data frame
  expect_error(
    plot_metric(NULL, date_from = "2022-01-20", date_to = "2022-01-26"),
    "Data not found. df must be a data.frame!"
  )

  # check input type of loc_val variable
  expect_error(
    plot_metric(df, loc_val = c(0), date_from = "2022-01-20", date_to = "2022-01-26"),
    "Invalid argument type: loc_val must be a character vector."
  )

  # check input type of metric
  expect_error(
    plot_metric(df, metric = c(0), date_from = "2022-01-20", date_to = "2022-01-26"),
    "Invalid argument type: Metric must be a string."
  )
  expect_error(
    plot_metric(df, metric = c("invalid_col"), date_from = "2022-01-20", date_to = "2022-01-26"),
    "Invalid argument value: Metric is not a valid column name!"
  )
  expect_error(
    plot_metric(df, metric = c("continent"), date_from = "2022-01-20", date_to = "2022-01-26"),
    "Invalid argument type: Metric must be a numeric variable."
  )


  # check date_from and date_to logic
  expect_error(
    plot_metric(df, date_from = "2022-01-31", date_to = "2022-01-25"),
    "Invalid values: date_from should be smaller or equal to date_to."
  )

  # check date_to value with today date
  expect_error(
    plot_metric(df, date_from = "2022-01-20", date_to = "2030-01-01"),
    "Invalid values: date_to should be smaller or equal to today."
  )
})

test_that("Test ggplot output of plot_metric()", {
  # check x-axis is using the correct variable
  expect_equal(plot_metric(df, metric = "positive_rate")$labels$x, "Date")

  # check primary y-axis is using the correct variable
  expect_equal(plot_metric(df, metric = "positive_rate")$labels$y, "new_cases")

  # check the layers of the plot has two lines (one in each layer)
  expect_true("GeomLine" %in% c(class(
    plot_metric(df, metric = "positive_rate")$layers[[1]]$geom
  )))
  expect_true("GeomLine" %in% c(class(
    plot_metric(df, metric = "positive_rate")$layers[[2]]$geom
  )))

  # check the title of the plot
  expect_equal(
    plot_metric(df, metric = "positive_rate")$labels$title,
    "Daily COVID cases versus Mean positive rate in Canada"
  )
})
