library(testthat)

compute_test_accuracy <- function(predicted, actual) {
  if (length(predicted) != length(actual)) {
    stop("❌ Lengths of predicted and actual labels must be the same.")
  }
  if (length(actual) == 0) {
    stop("❌ Input vectors must not be empty.")
  }
  
  accuracy <- sum(predicted == actual) / length(actual)
  return(accuracy)
}

test_that("compute_test_accuracy returns correct value for perfect match", {
  predicted <- c("a", "b", "c")
  actual <- c("a", "b", "c")
  
  expect_equal(compute_test_accuracy(predicted, actual), 1)
})

test_that("compute_test_accuracy returns correct value for partial match", {
  predicted <- c("a", "b", "c", "d")
  actual <- c("a", "b", "x", "y")
  
  expect_equal(compute_test_accuracy(predicted, actual), 0.5)
})

test_that("compute_test_accuracy handles all incorrect predictions", {
  predicted <- c("x", "x", "x")
  actual <- c("a", "b", "c")
  
  expect_equal(compute_test_accuracy(predicted, actual), 0)
})

test_that("compute_test_accuracy throws error if lengths differ", {
  predicted <- c("a", "b")
  actual <- c("a", "b", "c")
  
  expect_error(compute_test_accuracy(predicted, actual),
               "Lengths of predicted and actual labels must be the same")
})

test_that("compute_test_accuracy throws error for empty input", {
  predicted <- character(0)
  actual <- character(0)
  
  expect_error(compute_test_accuracy(predicted, actual),
               "Input vectors must not be empty")
})
