test_that("Test input type error of plot_summary()", {
  # var
  expect_error(plot_summary(df, var = 123), "var must be a string!")
})

test_that("Test aggregation logic of plot_summary()", {
  # var
  expect_error(plot_summary(df, var = 123), "var must be a string!")
})

test_that("Test ggplot output of plot_summary()", {
  # var
  expect_error(plot_summary(df, var = 123), "var must be a string!")
})
