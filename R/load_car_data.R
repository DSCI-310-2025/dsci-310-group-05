library(docopt)
library(readr)
library(janitor)
library(testthat)

#' Load and clean the Car Evaluation dataset from UCI
#'
#' Downloads the Car Evaluation dataset from the UCI Machine Learning Repository,
#' assigns column names, cleans them, and saves the result as a CSV file.
#'
#' @param output_path A string specifying the file path to save the cleaned CSV dataset.
#'
#' @return A tibble containing the cleaned and labeled dataset.
#'
#' @examples
#' \dontrun{
#' cleaned_data <- load_car_data(output_path = "data/original/car_data.csv")
#' }
load_car_data <- function(output_path) {
  # Validate input
  if (!is.character(output_path) || nchar(output_path) == 0) {
    stop("❌ Invalid `output_path`: Must be a non-empty string.")
  }
  
  url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/car/car.data"
  
  car_data <- readr::read_csv(
    url,
    col_names = FALSE,
    show_col_types = FALSE
  )
  
  colnames(car_data) <- c(
    "buying", "maint", "doors", "persons",
    "lug_boot", "safety", "class"
  )
  
  car_data <- janitor::clean_names(car_data)
  
  readr::write_csv(car_data, output_path)
  
  message("✅ Car dataset loaded and saved to ", output_path)
  
  return(car_data)
}


