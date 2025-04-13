library(docopt)
library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)
library(janitor)
library(pointblank)

doc <- "
Data Cleaning Script

Usage:
  clean_data.R --input_file=<input_file> --output_file=<output_file>
"

opt <- docopt(doc)

# Load data
car_data <- readr::read_csv(opt$input_file)

# Clean column names
car_data <- janitor::clean_names(car_data)

# Assign expected column names
colnames(car_data) <- c("buying", "maint", "doors", "persons", "lug_boot", "safety", "class")

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

# Count missing values and duplicate rows (for Quarto report)
num_missing <- sum(is.na(car_data))
num_duplicates <- nrow(car_data) - nrow(distinct(car_data))

nan_summary <- data.frame(
  Metric = c("Missing Values", "Duplicate Rows"),
  Count = c(num_missing, num_duplicates)
)
write_csv(nan_summary, "data/clean/nan_and_duplicates_summary.csv")

# Remove duplicate rows
car_data <- car_data %>% distinct()

# ==== Encoding ====

# General encoding for categorical variables
encode_levels <- function(x) {
  dplyr::case_when(
    x == "vhigh"  ~ 4,
    x == "high"   ~ 3,
    x == "med"    ~ 2, 
    x == "low"    ~ 1,
    x == "big"    ~ 3,
    x == "small"  ~ 1,
    x == "more"   ~ 5,
    x == "5more"  ~ 5,
    x == "2"      ~ 2,
    x == "3"      ~ 3,
    x == "4"      ~ 4,
    x == "unacc"  ~ 1,
    x == "acc"    ~ 2,
    x == "good"   ~ 3,
    x == "vgood"  ~ 4,
    TRUE          ~ as.numeric(x)
  )
}

# Special encoding for safety
encode_safety <- function(x) {
  dplyr::case_when(
    x == "low"  ~ 1,
    x == "med"  ~ 2,
    x == "high" ~ 3,
    TRUE        ~ as.numeric(x)
  )
}

# Apply encodings
car_data_clean <- car_data %>%
  mutate(across(-safety, encode_levels)) %>%
  mutate(safety = encode_safety(safety))

# Ensure the "data/clean/" directory exists before saving the file
output_file <- "data/clean/car_clean.csv"  # Define output file path
output_dir <- dirname(output_file)  # Extract directory path

# Ensure output directory exists
output_dir <- dirname(opt$output_file)
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# Save cleaned dataset
write.csv(car_data_clean, opt$output_file, row.names = FALSE)

print("The data is cleaned, validated, and ready for EDA!")
