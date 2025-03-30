library(testthat)
source("../../R/calculate_random_baseline.R")

test_that("calculate_random_baseline computes expected values", {
  expect_equal(calculate_random_baseline(c("a", "b", "a", "b")), 0.5)
  expect_equal(calculate_random_baseline(rep("a", 10)), 1.0)
  expect_equal(calculate_random_baseline(c("x", "y", "z")), 1/3)
})

test_that("calculate_random_baseline fails on empty input", {
  expect_error(calculate_random_baseline(character(0)), "zero-length")
})
