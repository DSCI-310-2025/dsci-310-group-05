library(testthat)

source(testthat::test_path("../../R/encode_levels.R"))

test_that("encode_levels works with expected input values", {
  expect_equal(encode_levels("low"), 1)
  expect_equal(encode_levels("med"), 2)
  expect_equal(encode_levels("high"), 3)
  expect_equal(encode_levels("vhigh"), 4)
  expect_equal(encode_levels("acc"), 2)
})

test_that("encode_levels returns NA or numeric for unknown values", {
  expect_true(is.na(encode_levels("unexpected_value")))
  expect_equal(encode_levels("5"), 5)  # numeric as string is converted
})

test_that("encode_levels handles wrong input types", {
  expect_error(encode_levels(list("low")), "must be a character vector", ignore.case = TRUE)
})
