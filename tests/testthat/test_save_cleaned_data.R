library(testthat)
source("../../R/save_cleaned_data.R")

test_that("save_cleaned_data saves a valid data frame to disk", {
  sample_data <- tibble::tibble(
    buying = c("low", "high", "med"),
    maint = c("low", "med", "high"),
    doors = c(2, 3, 4),
    safety = c(1, 2, 3)
  )

  temp_file <- tempfile(fileext = ".csv")

  expect_message(save_cleaned_data(sample_data, temp_file), "✅ Cleaned data saved to:")
  expect_true(file.exists(temp_file))

  unlink(temp_file)
})

test_that("save_cleaned_data works with an empty data frame", {
  empty_df <- tibble::tibble()
  temp_file <- tempfile(fileext = ".csv")

  expect_message(save_cleaned_data(empty_df, temp_file), "✅ Cleaned data saved to:")
  expect_true(file.exists(temp_file))

  unlink(temp_file)
})

test_that("save_cleaned_data errors when input is not a data frame", {
  temp_file <- tempfile(fileext = ".csv")
  expect_error(save_cleaned_data("not a dataframe", temp_file), "must be a data frame")
})
