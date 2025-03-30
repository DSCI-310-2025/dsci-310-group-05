library(testthat)

source("R/decode_categorical_features.R") 

# ---- TEST decode_categorical_features ----
test_that("decode_categorical_features works when all categorical columns exist", {
  df <- tibble(buying = c(1, 2, 3, 4), maint = c(1, 2, 3, 4), persons = c(2, 4, 5), class = c(1, 2, 3, 4))
  result <- decode_categorical_features(df)
  expect_true(all(levels(result$buying) == c("low", "med", "high", "vhigh")))
})

test_that("decode_categorical_features works when some categorical columns are missing", {
  df <- tibble(buying = c(1, 2, 3, 4), persons = c(2, 4, 5))
  result <- decode_categorical_features(df)
  expect_true(all(levels(result$buying) == c("low", "med", "high", "vhigh")))
})

test_that("decode_categorical_features errors when input is not a dataframe", {
  expect_error(decode_categorical_features(123))
  expect_error(decode_categorical_features("text"))
})

test_that("decode_categorical_features errors when categorical columns are of the wrong type", {
  df <- tibble(buying = c("low", "med", "high"), class = c("unacc", "acc", "good"))
  expect_error(decode_categorical_features(df))
})