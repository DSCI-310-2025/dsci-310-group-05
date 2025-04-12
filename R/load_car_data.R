library(docopt)
library(readr)
library(janitor)
library(testthat)

# Documentation for command line usage
doc <- "
This script loads the Car Evaluation dataset from the UCI website,
cleans the column names, and saves it as a CSV file.

Usage:
  01-load_data_from_web.R --output_path=<output_path>
"

# Parse command line options
opt <- docopt(doc)

#' Load and clean the UCI Car Evaluation dataset, then save it.
#'
#' @param output_path A string specifying the file path to save the cleaned CSV dataset.
#' @return A tibble containing the cleaned dataset.
#'
#' @examples
#' \dontrun{
#' load_car_data(output_path = "data/original/car_data.csv")
#' }
load_car_data <- function(output_path) {
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

# Run the function with the command line argument
car_data <- load_car_data(opt$output_path)


print("🚗 Car dataset loaded")

