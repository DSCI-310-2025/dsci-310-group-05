library(testthat)
source("R/cross_validate_knn.R")
source("R/split_data.R")

df <- tibble::tibble(
  buying = sample(1:4, 60, replace = TRUE),
  maint = sample(1:4, 60, replace = TRUE),
  safety = factor(sample(c("low", "med", "high"), 60, replace = TRUE))
)

split <- split_data(df)

test_that("cross_validate_knn returns increasing k values and reasonable accuracy", {
  results <- suppressWarnings(cross_validate_knn(split$train_x, split$train_y, k_values = c(1, 5, 9)))

  expect_equal(nrow(results), 3)
  expect_true(all(results$k %in% c(1, 5, 9)))
  expect_true(all(results$accuracy >= 0 & results$accuracy <= 1))
  expect_equal(results$k[1], 1)
})

test_that("cross_validate_knn fails gracefully with empty input", {
  expect_error(
    cross_validate_knn(data.frame(), factor()),
    "data has 0 rows"
  )
})
