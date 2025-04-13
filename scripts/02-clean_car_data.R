library(docopt)
library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)
library(janitor)
library(pointblank)

source("R/clean_column_names.R")
source("R/check_data_quality.R")
source("R/encode_levels.R")
source("R/encode_safety.R")
source("R/save_cleaned_data.R")



doc <- "
Data Cleaning Script

Usage:
  clean_data.R --input_file=<input_file> --output_file=<output_file>
"

opt <- docopt(doc)

# Load data
car_data <- readr::read_csv(opt$input_file)

# Clean and standardize column names
car_data <- clean_column_names(car_data)

# ==== Data Validation ====

agent <- create_agent(tbl = car_data, tbl_name = "car_data") %>%
  col_exists(columns = vars(buying, maint, doors, persons, lug_boot, safety, class)) %>%
  col_vals_not_null(columns = everything()) %>%
  col_is_character(columns = vars(safety, buying, maint, doors, persons, lug_boot, class)) %>%
  rows_distinct() %>%
  col_vals_in_set(columns = vars(safety), set = c("low", "med", "high")) %>%
  col_vals_in_set(columns = vars(doors), set = c("2", "3", "4", "5more")) %>%
  col_vals_in_set(columns = vars(buying), set = c("low", "med", "high", "vhigh")) %>%
  col_vals_in_set(columns = vars(class), set = c("unacc", "acc", "good", "vgood"))



validation_results <- interrogate(agent)

# Optional: Save validation report
export_report(agent, filename = "data/clean/validation_report.html")

if (!all_passed(validation_results)) {
  stop("Data validation failed. See data/clean/validation_report.html for details.")
}

# ==== Cleaning Process ====
car_data <- check_data_quality(car_data)


# ==== Encoding ====

# Apply encodings
car_data_clean <- car_data %>%
  mutate(across(-safety, encode_levels)) %>%
  mutate(safety = encode_safety(safety))

#save the cleaned data
save_cleaned_data(car_data_clean, opt$output_file)


print("The data is cleaned, validated, and ready for EDA!")
