source(testthat::test_path("../../R/encode_safety.R"))

test_that("encode_safety function works correctly", {
  expect_equal(encode_safety("low"), 1)
  expect_equal(encode_safety("med"), 2)
  expect_equal(encode_safety("high"), 3)
  expect_true(is.na(encode_safety("unknown")))
})

