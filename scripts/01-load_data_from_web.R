library(docopt)
library(readr)
library(janitor)
library(carpackage)

doc <- "
This script loads in the data from the UCI website.
This dataset contains categorical variables describing various attributes of cars, 
  including qualities of car features, which will be used for classification.

Usage:
  01-load_data_from_web.R --file_path=<file_path> --output_path=<output_path>
"
# Parsing command line arguments based on the usage string provided at the top of the script.
opt <- docopt(doc)

# Reads the dataset from the URL provided as a command-line argument.
car_data <- load_car_data(opt$output_path)

print("Read in car dataset successfully")

