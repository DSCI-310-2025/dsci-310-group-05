library(docopt)
library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)

source("R/count_unique_values.R")
source("R/decode_categorical_features.R")
source("R/plot_distribution.R")
source("R/summarize_data.R")



doc <- "
Exploratory Data Analysis Script

Usage:
  eda.R --input_file=<input_file> --output_prefix=<output_prefix>
"

# Parse command line arguments
opt <- docopt(doc)

# Load cleaned data
car_data_encoded <- read.csv(opt$input_file)

# Summary statistics
summarize_data(car_data_encoded)


# Count occurrences for each unique value in each column
unique_occurences <- count_unique_values(car_data_encoded)


write_csv(unique_occurences, "output/eda_summary/unique_occurences.csv")

# Convert encoded variables back to categorical labels
car_data_labeled <- decode_categorical_features(car_data_encoded)


# Define a larger theme for plots
larger_theme <- theme(
  plot.title = element_text(size = 18, face = "bold"),
  axis.title = element_text(size = 16),
  axis.text = element_text(size = 14),
  legend.title = element_text(size = 14),
  legend.text = element_text(size = 12)
)

# Plot 1: Distribution of Buying Price by Safety Level
plot_distribution(
  data = car_data_labeled,
  x_var = "buying",
  fill_var = "safety",
  title = "Distribution of Buying Price by Safety Level",
  output_path = file.path("output", paste0(basename(opt$output_prefix), "_buying_safety.png"))
)

# Plot 2: Distribution of Number of Persons by Safety Level
plot_distribution(
  data = car_data_labeled,
  x_var = "persons",
  fill_var = "safety",
  title = "Distribution of Number of Persons by Safety Level",
  output_path = file.path("output", paste0(basename(opt$output_prefix), "_persons_safety.png"))
)


# Plot 3: Distribution of Maintenance Cost by Safety Level
plot_distribution(
  data = car_data_labeled,
  x_var = "maint",
  fill_var = "safety",
  title = "Distribution of Maintenance Cost by Safety Level",
  output_path = file.path("output", paste0(basename(opt$output_prefix), "_maint_safety.png"))
)

print("Exploratory Data Analysis Completed!")
