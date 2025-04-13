library(testthat)
source("../../R/clean_column_names.R")

test_that("clean_column_names standardizes messy column names", {
  raw_data <- tibble::tibble(
    "BUYING_RAW" = 1:3, 
    "Maint-Raw" = 4:6, 
    "DOORS raw" = 7:9
  )
  cleaned_data <- clean_column_names(raw_data)
  expected_names <- c("buying", "maint", "doors")
  expect_equal(colnames(cleaned_data), expected_names)
})

test_that("clean_column_names works on already clean names", {
  raw_data <- tibble::tibble(
    buying = 1:3,
    maint = 4:6,
    doors = 7:9,
    persons = 1:3,
    lug_boot = 4:6,
    safety = 7:9,
    class = 1:3
  )
  cleaned_data <- clean_column_names(raw_data)
  expect_equal(colnames(cleaned_data), colnames(raw_data))
})

test_that("clean_column_names fails on non-data.frame input", {
  expect_error(clean_column_names("not a dataframe"), "data frame")
})
