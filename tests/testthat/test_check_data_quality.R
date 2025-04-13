library(testthat)

check_data_quality <- function(data) {
  if (!is.data.frame(data)) {
    stop("❌ Input must be a data frame.")
  }
  
  num_missing <- sum(is.na(data))
  num_duplicates <- sum(duplicated(data))
  
  message("🔍 Missing values found: ", num_missing)
  message("🔁 Duplicate rows found: ", num_duplicates)
  
  cleaned_data <- data |>
    tidyr::drop_na() |>
    dplyr::distinct()
  
  message("✅ Cleaned data returned (", nrow(cleaned_data), " rows)")
  
  return(cleaned_data)
}

test_that("check_data_quality removes NA rows", {
  df <- data.frame(
    col1 = c(1, NA, 3),
    col2 = c("a", "b", NA)
  )
  
  cleaned <- check_data_quality(df)
  
  expect_false(any(is.na(cleaned)))
  expect_lt(nrow(cleaned), nrow(df))
})

test_that("check_data_quality removes duplicate rows", {
  df <- data.frame(
    col1 = c(1, 2, 2),
    col2 = c("a", "b", "b")
  )
  
  cleaned <- check_data_quality(df)
  
  expect_equal(nrow(cleaned), 2)
})

test_that("check_data_quality removes both NA and duplicates", {
  df <- data.frame(
    col1 = c(1, 2, NA, 2),
    col2 = c("a", "b", "c", "b")
  )
  
  cleaned <- check_data_quality(df)
  
  expect_false(any(is.na(cleaned)))
  expect_equal(nrow(cleaned), 2)
})

test_that("check_data_quality preserves clean data", {
  df <- data.frame(
    col1 = c(1, 2, 3),
    col2 = c("a", "b", "c")
  )
  
  cleaned <- check_data_quality(df)
  
  expect_equal(cleaned, df)
})

test_that("check_data_quality returns a data frame", {
  df <- data.frame(
    col1 = c(1, 2, 2),
    col2 = c("a", "b", "b")
  )
  
  cleaned <- check_data_quality(df)
  
  expect_s3_class(cleaned, "data.frame")
})

test_that("check_data_quality fails on non-data.frame input", {
  expect_error(check_data_quality("not a dataframe"), "data frame")
})

