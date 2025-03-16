library(docopt)
library(readr)
library(janitor)

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
car_data <- read.csv(opt$file_path, header = FALSE, stringsAsFactors = TRUE) #Converts string-based categorical variables into factors.

# Saves the downloaded dataset to the file path specified in the command-line argument.
write.csv(car_data, opt$output_path, row.names = FALSE) #Ensures that row indices are not written into the output file.

print("Read in car dataset successfully")

