location_ <- c("Canada", "United Kingdom", "China")
df <- get_data(location = location_)

test_that("Return type should be a tibble.", {
  expect_s3_class(df, "tbl")
})

test_that("Location returned in tibble does not match with the input", {
  expect_equal(sort(unique(df$location)), sort(unique(location_)))
})

 test_that("date_to does not match the default range of today or today - 1", {
   expect_true((max(df$date) == Sys.Date()) | (max(df$date) == Sys.Date() - 1))
 })

 test_that("date_from does not match the default range of D-7", {
   expect_true((min(df$date) == Sys.Date() - 7))
 })

 test_that("Data returned has been filtered somehow.", {
   expect_true((length(df) > 10))
 })

 test_that("check input type of data_from", {
   expect_error(get_data(date_from = 123), "Invalid argument type: date_from must be in string format of YYYY-MM-DD.")
 })

 test_that("check input type of data_from", {
   expect_error(get_data(date_from = "10-15-2021"), "Invalid argument value: date_from must be in format of YYYY-MM-DD. Also check if it is a valid date.")
 })

 test_that("check input type of data_to", {
   expect_error(get_data(date_to = 123), "Invalid argument type: date_to must be in string format of YYYY-MM-DD.")
 })

 test_that("check input type of data_to", {
   expect_error(get_data(date_to = "10-15-2021"), "Invalid argument value: date_to must be in format of YYYY-MM-DD. Also check if it is a valid date.")
 })

 test_that("check input type of location: not a list", {
   expect_error(get_data(location = 123), "Invalid argument type: location must be a character vector.")
 })

 test_that("check valid date range of data_from", {
   expect_error(get_data(date_from = "2021-02-29"), "Invalid argument value: date_from must be in format of YYYY-MM-DD. Also check if it is a valid date.")
 })

 test_that("check valid date range of data_to", {
   expect_error(get_data(date_to = "2021-02-29"), "Invalid argument value: date_to must be in format of YYYY-MM-DD. Also check if it is a valid date.")
 })

 test_that("check valid date range: date_from <= date_to", {
   expect_error(get_data(date_from = "2021-10-15", date_to = "2021-10-01"), "Invalid values: date_from should be smaller or equal to date_to.")
 })

 test_that("check valid date range: date_to <= today", {
   expect_error(get_data( date_to = as.character(Sys.Date() + 7)), "Invalid values: date_to should be smaller or equal to today.")
 })
