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

# Checking for missing values
if (sum(is.na(car_data)) > 0) {
  print("Warning: Missing values detected.")
}

# Remove duplicate rows (if any)
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

# Save cleaned dataset
write.csv(car_data_clean, opt$output_file, row.names = FALSE)

print("The data is cleaned and ready for EDA!")
