library(testthat)
library(caret)
source("../../R/train_final_model.R")
source("../../R/split_data.R")

df <- tibble::tibble(
  x1 = rnorm(30),
  x2 = rnorm(30),
  safety = factor(rep(c("low", "med", "high"), 10))
)

split <- split_data(df)

test_that("train_final_model returns model with correct k and structure", {
  model_5 <- suppressWarnings(train_final_model(split$train_x, split$train_y, best_k = 5))
  model_3 <- suppressWarnings(train_final_model(split$train_x, split$train_y, best_k = 3))

  expect_s3_class(model_5, "train")
  expect_equal(model_5$method, "knn")
  expect_equal(model_5$bestTune$k, 5)
  expect_true("Accuracy" %in% colnames(model_5$results))

  expect_equal(model_3$bestTune$k, 3)  # second valid test
})

test_that("train_final_model fails when k is missing or invalid", {
  expect_error(
    train_final_model(split$train_x, split$train_y, NULL),
    "must be a single numeric value"
  )  
  expect_error(
    train_final_model(split$train_x, split$train_y, "five"),
    "must be a single numeric value"
  )
})
