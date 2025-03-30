library(testthat)
source("../../R/clean_column_names.R")


test_that("clean_column_names function works correctly", {
  raw_data <- tibble::tibble(
    "BUYING_RAW" = 1:3, 
    "Maint-Raw" = 4:6, 
    "DOORS raw" = 7:9
  )

  cleaned_data <- clean_column_names(raw_data)

  expected_names <- c("buying", "maint", "doors")

  expect_equal(colnames(cleaned_data), expected_names)
})

