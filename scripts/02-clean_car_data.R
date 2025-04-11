library(docopt)
library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)
doc <- "
Data Cleaning Script

Usage:
  clean_data.R --input_file=<input_file> --output_file=<output_file>
"

opt <- docopt(doc)

car_data <- readr::read_csv(opt$input_file)

# Clean column names
car_data <- janitor::clean_names(car_data)

# Assign column names
colnames(car_data) <- c("buying", "maint", "doors", "persons", "lug_boot", "safety", "class")

col_car_data <- car_data
write_csv(col_car_data, "data/clean/col_car_data.csv")

# Count missing values and duplicate rows
num_missing <- sum(is.na(car_data))
num_duplicates <- nrow(car_data) - nrow(distinct(car_data))

# Save summary for Quarto
nan_summary <- data.frame(
  Metric = c("Missing Values", "Duplicate Rows"),
  Count = c(num_missing, num_duplicates)
)
write_csv(nan_summary, "data/clean/nan_and_duplicates_summary.csv")

# Console warning
if (num_missing > 0) {
  print("Warning: Missing values detected.")
}
if (num_duplicates > 0) {
  print("Warning: Duplicate rows detected.")
}

# Remove duplicate rows
car_data <- car_data %>% distinct()

# Encoding function for categorical features
encode_levels <- function(x) {
  dplyr::case_when(
    x == "vhigh"  ~ 4,
    x == "high"   ~ 3,
    x == "med"    ~ 2, 
    x == "low"    ~ 1,
    x == "big"    ~ 3,
    x == "small"  ~ 1,
    x == "more"   ~ 5,   # 'more' in persons column treated as 5
    x == "5more"  ~ 5,   # '5more' in doors column treated as 5
    x == "2"      ~ 2,
    x == "3"      ~ 3,
    x == "4"      ~ 4,
    x == "unacc"  ~ 1,
    x == "acc"    ~ 2,
    x == "good"   ~ 3,
    x == "vgood"  ~ 4,
    TRUE          ~ as.numeric(x) # Default conversion for numbers
  )
}

# Encoding safety separately to avoid duplicate "low", "med", "high"
encode_safety <- function(x) {
  dplyr::case_when(
    x == "low"  ~ 1,
    x == "med"  ~ 2,
    x == "high" ~ 3,
    TRUE        ~ as.numeric(x)
  )
}

# Apply encoding to all columns, including safety separately
car_data_clean <- car_data %>%
  mutate(across(-safety, encode_levels)) %>%
  mutate(safety = encode_safety(safety))

# Ensure the "data/clean/" directory exists before saving the file
output_file <- "data/clean/car_clean.csv"  # Define output file path
output_dir <- dirname(output_file)  # Extract directory path

if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)  # Create directory if it doesn't exist
}

# Save cleaned dataset
write.csv(car_data_clean, opt$output_file, row.names = FALSE)

print("The data is cleaned and ready for EDA!")
