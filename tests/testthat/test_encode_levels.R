source(testthat::test_path("../../R/encode_levels.R"))
test_that("encode_levels function works correctly", {
  expect_equal(encode_levels("low"), 1)
  expect_equal(encode_levels("med"), 2)
  expect_equal(encode_levels("high"), 3)
  expect_true(is.na(encode_levels("unexpected_value")))
})

