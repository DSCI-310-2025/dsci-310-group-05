library(testthat)

source("../../R/count_unique_values.R")  


test_that("count_unique_values works with different data types", {
  
  df <- tibble(a = c("apple", "banana", "apple"), b = c(1, 1, 2))
  
  
  result <- count_unique_values(df)
  
  
  expect_true(nrow(result) > 0)
  

  expect_true(all(c("column", "unique_count") %in% colnames(result)))
  
  
  expect_equal(result$unique_count[result$column == "a"], 2) 
  expect_equal(result$unique_count[result$column == "b"], 2)  
})

test_that("count_unique_values works with missing values", {
  
  df <- tibble(a = c("apple", "banana", NA, "apple"), b = c(1, 1, 2, NA))
  
  
  result <- count_unique_values(df)
  
  
  expect_true(nrow(result) > 0)
  
  
  expect_true(all(c("column", "unique_count") %in% colnames(result)))
  
  
  expect_equal(result$unique_count[result$column == "a"], 3)  
  expect_equal(result$unique_count[result$column == "b"], 3)  
})

test_that("count_unique_values errors when input is not a dataframe", {
 
  expect_error(count_unique_values(123), "Input must be a dataframe")
  expect_error(count_unique_values("text"), "Input must be a dataframe")
})