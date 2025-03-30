library(testthat)
source("R/split_data.R")

df <- tibble::tibble(
  buying = rep(1:2, each = 10),
  maint = rep(1:2, each = 10),
  safety = factor(rep(c("low", "high"), 10))
)

test_that("split_data returns valid training/testing partition", {
  split <- split_data(df, "safety", prop = 0.7)

  expect_named(split, c("train_x", "train_y", "test_x", "test_y"))
  expect_equal(nrow(split$train_x) + nrow(split$test_x), nrow(df))
  expect_equal(ncol(split$train_x), ncol(df) - 1)
  expect_type(split$train_y, "integer") # factor levels are stored as integers
  expect_true(is.factor(split$train_y))
  expect_false("safety" %in% colnames(split$train_x))
})

test_that("split_data errors if response column is missing", {
  expect_error(split_data(df, "nonexistent"), "object 'nonexistent' not found")
})
