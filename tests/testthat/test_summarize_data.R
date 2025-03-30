library(testthat)
source("../../R/summarize_data.R")

test_that("summarize_data works with a typical dataframe", {
  df <- data.frame(a = 1:5, b = c(2.2, 3.3, 4.4, 5.5, 6.6))
  expect_output(summarize_data(df), "Min.")
})

test_that("summarize_data works with an empty dataframe", {
  df <- data.frame()
  expect_output(summarize_data(df), "< table of extent 0 x 0 >")
})


test_that("summarize_data works with missing values", {
  df <- data.frame(a = c(1, 2, NA, 4), b = c(5.5, NA, 7.5, 8.5))
  expect_output(summarize_data(df), "NA's")
})

test_that("summarize_data errors when input is not a dataframe", {
  expect_error(summarize_data(123), "data frame")
  expect_error(summarize_data("not a dataframe"), "data frame")
})
