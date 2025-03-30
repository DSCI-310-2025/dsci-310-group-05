library(testthat)
source("../../R/plot_distribution.R")  

test_that("plot_distribution works with valid input", {
  df <- data.frame(
    category = c("A", "B", "A", "C", "C", "C"),
    group = c("X", "Y", "X", "Z", "Z", "Y"),
    stringsAsFactors = FALSE
  )
  output_path <- tempfile(fileext = ".png")
  plot_distribution(df, "category", "group", "Test Plot", output_path)
  expect_true(file.exists(output_path))  # confirms file is saved
})

test_that("plot_distribution errors when x_var or fill_var is missing", {
  df <- data.frame(
    category = c("A", "B", "A"),
    group = c("X", "Y", "X"),
    stringsAsFactors = FALSE
  )
  expect_error(plot_distribution(df, "category", NULL, "Test Plot", "output.png"))
  expect_error(plot_distribution(df, NULL, "group", "Test Plot", "output.png"))
})

test_that("plot_distribution errors when x_var or fill_var is not categorical", {
  df <- data.frame(
    category = c(1, 2, 3),
    group = c(1.2, 2.3, 3.4)
  )
  expect_error(plot_distribution(df, "category", "group", "Test Plot", "output.png"))
})

test_that("plot_distribution errors when output path is invalid", {
  df <- data.frame(
    category = c("A", "B", "C"),
    group = c("X", "Y", "Z"),
    stringsAsFactors = FALSE
  )
  expect_error(plot_distribution(df, "category", "group", "Test Plot", ""))
})

test_that("plot_distribution errors on non-dataframe input", {
  expect_error(plot_distribution("not a dataframe", "x", "y", "Plot", "output.png"))
  expect_error(plot_distribution(123, "x", "y", "Plot", "output.png"))
})

