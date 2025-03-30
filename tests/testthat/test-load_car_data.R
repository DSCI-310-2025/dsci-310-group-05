library(testthat)
source("../R/load_car_data.R")  # Replace with actual file

generate_temp_output_path <- function(filename = "car_data.csv") {
  file.path(tempdir(), filename)
}

clean_up_file <- function(file_path) {
  if (file.exists(file_path)) {
    file.remove(file_path)
  }
}

test_that("load_car_data returns a dataframe with correct structure", {
  output_path <- generate_temp_output_path()
  
  data <- load_car_data(output_path)
  
  expect_s3_class(data, "data.frame")
  expect_equal(ncol(data), 7)
  expect_named(data, c("buying", "maint", "doors", "persons", "lug_boot", "safety", "class"))
  
  clean_up_file(output_path)
})

test_that("load_car_data saves a non-empty CSV file", {
  output_path <- generate_temp_output_path()
  
  load_car_data(output_path)
  
  expect_true(file.exists(output_path))
  expect_gt(file.info(output_path)$size, 0)
  
  clean_up_file(output_path)
})

test_that("load_car_data can overwrite an existing file", {
  output_path <- generate_temp_output_path()
  writeLines("Old content", output_path)
  expect_true(file.exists(output_path))
  
  load_car_data(output_path)
  
  data <- readr::read_csv(output_path, show_col_types = FALSE)
  expect_equal(ncol(data), 7)
  
  clean_up_file(output_path)
})

test_that("load_car_data fails on invalid output path", {
  bad_path <- file.path("this", "does", "not", "exist", "car_data.csv")
  
  expect_error(load_car_data(bad_path))
})

test_that("load_car_data returns full dataset with expected row count", {
  output_path <- generate_temp_output_path()
  
  data <- load_car_data(output_path)
  
  expect_equal(nrow(data), 1728)
  
  clean_up_file(output_path)
})

test_that("load_car_data includes expected factor levels", {
  output_path <- generate_temp_output_path()
  data <- load_car_data(output_path)
  
  expect_true(all(data$buying %in% c("vhigh", "high", "med", "low")))
  expect_true(all(data$maint %in% c("vhigh", "high", "med", "low")))
  expect_true(all(data$class %in% c("unacc", "acc", "good", "vgood")))
  
  clean_up_file(output_path)
})
