library(testthat)

source(testthat::test_path("../../R/plot_distribution.R"))

test_that("plot_distribution works with valid input", {
  df <- tibble(category = c("A", "B", "A", "C", "C", "C"), group = c("X", "Y", "X", "Z", "Z", "Y"))
  output_path <- tempfile(fileext = ".png")
  expect_silent(plot_distribution(df, "category", "group", "Test Plot", output_path))
  expect_true(file.exists(output_path))
  expect_true(file.size(output_path) > 0)  # Check that file isn't empty
})

test_that("plot_distribution errors when x_var or fill_var is missing", {
  df <- tibble(category = c("A", "B", "A"), group = c("X", "Y", "X"))
  expect_error(plot_distribution(df, "category", NULL, "Test Plot", "output.png"),
               "x_var and fill_var must be non-NULL")
})

test_that("plot_distribution errors when x_var or fill_var is not categorical", {
  df <- tibble(category = c(1, 2, 3), group = c(1.2, 2.3, 3.4))
  expect_error(plot_distribution(df, "category", "group", "Test Plot", "output.png"),
               "x_var and fill_var must be categorical")
})

test_that("plot_distribution errors when output path is invalid", {
  df <- tibble(category = c("A", "B", "C"), group = c("X", "Y", "Z"))
  expect_error(plot_distribution(df, "category", "group", "Test Plot", ""),
               "Invalid output path")
})