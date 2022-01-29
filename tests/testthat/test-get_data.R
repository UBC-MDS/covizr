location_ <- c("Canada", "United Kingdom", "China")
df <- get_data(location = location_)

test_that("Check return values of the function", {
  # Return type should be tibble
  expect_s3_class(df, "tbl")

  # Location returned in tibble does not match with the input
  expect_equal(sort(unique(df$location)), sort(unique(location_)))

  # date_to should match the default range of today or today - 1
  expect_true((max(df$date) == Sys.Date()) | (max(df$date) == Sys.Date() - 1) | (max(df$date) == Sys.Date() - 2))

  # date_from should match the default range of D-7
  expect_true((min(df$date) == Sys.Date() - 7) | (min(df$date) == Sys.Date() - 8))

  # Data returned should not be further filtered
  expect_true((length(df) > 10))
})


test_that("check input type of the function", {
  # check input type of data_from
  expect_error(get_data(date_from = 123), "Invalid argument type: date_from must be in string format of YYYY-MM-DD.")

  # check input type of data_from
  expect_error(get_data(date_from = "10-15-2021"), "Invalid argument value: date_from must be in format of YYYY-MM-DD. Also check if it is a valid date.")

  # check input type of data_to
  expect_error(get_data(date_to = 123), "Invalid argument type: date_to must be in string format of YYYY-MM-DD.")

  # check input type of data_to
  expect_error(get_data(date_to = "10-15-2021"), "Invalid argument value: date_to must be in format of YYYY-MM-DD. Also check if it is a valid date.")

  # check input type of location: not a list
  expect_error(get_data(location = 123), "Invalid argument type: location must be a character vector.")

  # check valid date range of data_from
  expect_error(get_data(date_from = "2021-02-29"), "Invalid argument value: date_from must be in format of YYYY-MM-DD. Also check if it is a valid date.")

  # check valid date range of data_t
  expect_error(get_data(date_to = "2021-02-29"), "Invalid argument value: date_to must be in format of YYYY-MM-DD. Also check if it is a valid date.")

  # check valid date range: date_from <= date_to
  expect_error(get_data(date_from = "2021-10-15", date_to = "2021-10-01"), "Invalid values: date_from should be smaller or equal to date_to.")

  # check valid date range: date_to <= today
  expect_error(get_data(date_to = as.character(Sys.Date() + 7)), "Invalid values: date_to should be smaller or equal to today.")
})
