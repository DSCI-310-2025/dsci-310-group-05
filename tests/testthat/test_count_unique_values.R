library(testthat)
source("../../R/count_unique_values.R")

test_that("count_unique_values works with different data types", {
  df <- data.frame(
    a = c("apple", "banana", "apple"),
    b = c(1, 1, 2),
    stringsAsFactors = FALSE
  )

  result <- count_unique_values(df)
  
  expect_equal(nrow(result), 4)
  expect_equal(result$Value[result$Variable == "a" & result$Value == "apple"], "apple")
  expect_equal(result$Count[result$Variable == "b" & result$Value == 1], 2)
})

test_that("count_unique_values works with missing values", {
  df <- data.frame(
    a = c("apple", "banana", NA, "apple"),
    b = c(1, 1, 2, NA),
    stringsAsFactors = FALSE
  )

  result <- count_unique_values(df)
  
  expect_true(any(is.na(result$Value)))
  expect_equal(result$Count[result$Variable == "a" & is.na(result$Value)], 1)
  expect_equal(result$Count[result$Variable == "b" & is.na(result$Value)], 1)
})




