source("../../R/save_cleaned_data.R")

test_that("save_cleaned_data function works correctly", {
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
