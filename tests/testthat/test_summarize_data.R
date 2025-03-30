library(testthat)

source("R/summarize_data.R")  

# ---- TEST summarize_data ----
test_that("summarize_data works with a typical dataframe", {
  data <- tibble(a = 1:5, b = c(2.5, 3.5, 4.5, 5.5, 6.5))
  expect_output(summarize_data(data = ))
})

test_that("summarize_data works with an empty dataframe", {
  data() <- tibble()
  expect_output(summarize_data(data = ))
})

test_that("summarize_data works with missing values", {
  data() <- tibble(a = c(1, 2, NA, 4), b = c(5.5, NA, 7.5, 8.5))
  expect_output(summarize_data(data))
})

test_that("summarize_data errors when input is not a dataframe", {
  expect_error(summarize_data(123))
  expect_error(summarize_data("not a dataframe"))
})
