library(docopt)
library(readr)
library(janitor)

# Load the UCI dataset from web.

# Downloads the Car Evaluation dataset from the UCI Machine Learning Repository, assigns column names, 
# saves the dataset as a CSV file, and returns the dataset.

#' @param output_path A string specifying the file path to save the cleaned CSV dataset.

load_car_data <- function(file_path, output_path) {
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
