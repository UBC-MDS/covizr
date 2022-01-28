df <- read_rds("test_df_plot_summary.rds")

test_that("Test input type error of plot_summary()", {
  # var
  expect_error(plot_summary(df, var = 123), "var must be a string!")

  # val
  expect_error(plot_summary(df, val = 123), "val must be a string!")

  # fun
  expect_error(plot_summary(df, fun = 123), "fun must be a string!")

  # top_n is bigger than zero
  expect_error(plot_summary(df, top_n = -5), "top_n must be an integer bigger than zero")

  # check date_from and date_to logic
  expect_error(plot_summary(df, date_from = "2022-01-26", date_to = "2022-01-20"), "Invalid values: date_from should be smaller or equal to date_to")
})

test_that("Test aggregation logic of plot_summary()", {
  # check groupby sum produce correct result for location
  expect_equal(plot_summary(df)$data$location[1], "United States")

  # check groupby sum produce correct result for new_cases
  expect_equal(plot_summary(df, date_from = "2022-01-19", date_to = "2022-01-26")$data$value[1], 5216188)
})

test_that("Test ggplot output of plot_summary()", {
  # check x-axis is using the correct variable
  expect_equal(plot_summary(df)$labels$x, "New Cases")
})
