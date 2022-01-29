df <- readr::read_rds("test_df_plot_spec.rds")

test_that("Test input type error of plot_spec()", {
  # check input type of data frame
  expect_error(plot_spec(NULL),
               "Data not found. There may be a problem with data URL.")

  # check input type of location
  expect_error(
    plot_spec(df, location = c(0)),
    "Invalid argument type: location must be a character vector."
  )

  # check input type of val
  expect_error(plot_spec(df, val = c(0)),
               "Invalid argument type: val must be a string.")
  expect_error(plot_spec(df, val = c("iso_code")),
               "Invalid argument type: val must be a numeric variable.")

  # check the Value of date_from
  expect_error(
    plot_spec(df, date_from = c(0)),
    "Invalid argument type: date_from must be in string format of YYYY-MM-DD."
  )
  expect_error(
    plot_spec(df, date_from = "iso_code"),
    "Invalid argument value: date_from must be in format of YYYY-MM-DD. Also check if it is a valid date."
  )

  # check the Value of date_to
  expect_error(
    plot_spec(df, date_to = c(123, "0")),
    "Invalid argument type: date_to must be in string format of YYYY-MM-DD."
  )
  expect_error(
    plot_spec(df, date_to = "sdfsf"),
    "Invalid argument value: date_to must be in format of YYYY-MM-DD. Also check if it is a valid date."
  )

  # check date_from and date_to logic
  expect_error(
    plot_spec(df, date_from = "2022-01-26", date_to = "2022-01-20"),
    "Invalid values: date_from should be smaller or equal to date_to."
  )

  # check date_to value with today date
  expect_error(plot_spec(df, title = TRUE),
               "Invalid argument type: title must be a string.")


})

test_that("Test ggplot output of plot_spec()", {
  # check y-axis is using the correct variable
  expect_equal(plot_spec(df, val = "new_deaths", date_from = "2022-01-20", date_to = "2022-01-26")$labels$y, "New Deaths")

  # check color of the plot
  expect_equal(plot_spec(df, val = "new_deaths", date_from = "2022-01-20", date_to = "2022-01-26")$labels$c, "location")

  # check the layers of the plot
  expect_true("GeomLine" %in% c(class(
    plot_spec(df, val = "new_deaths", location = c("Canada"), date_from = "2022-01-20", date_to = "2022-01-26")$layers[[1]]$geom
  )))
  expect_true("GeomText" %in% c(class(
    plot_spec(df, val = "new_deaths", location = c("Canada"), date_from = "2022-01-20", date_to = "2022-01-26")$layers[[2]]$geom
  )))

  # check the title of the plot
  expect_equal(plot_spec(df, title = "Daily cases", date_from = "2022-01-20", date_to = "2022-01-26")$labels$title,
               "Daily cases")

  # check the data of the plot
  expect_equal(plot_spec(df, location = c("Canada"), date_from = "2022-01-20", date_to = "2022-01-26")$layers[[2]]$data$new_cases, 5860)
})
