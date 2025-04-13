# Example usage script for full reproducibility

# Load required libraries
library(tidyverse)
library(readr)
library(caret)

# Load project functions
source("../R/calculate_random_baseline.R")
source("../R/clean_column_names.R")
source("../R/count_unique_values.R")
source("../R/cross_validate_knn.R")
source("../R/decode_categorical_features.R")
source("../R/encode_levels.R")
source("../R/encode_safety.R")
source("../R/load_car_data.R")
source("../R/plot_distribution.R")
source("../R/save_cleaned_data.R")
source("../R/split_data.R")
source("../R/summarize_data.R")
source("../R/train_final_model.R")
source("../R/check_data_quality.R")
source("../R/compute_test_accuracy.R")
source("../R/plot_conf_matrix.R")

# Step 1: Load and clean data
raw_data <- load_car_data("../data/original/car_data.csv")
cleaned_data <- check_data_quality(raw_data)

# Step 2: Assign column names and encode
col_car_data <- clean_column_names(cleaned_data)
car_data_encoded <- col_car_data %>%
  mutate(across(-safety, encode_levels)) %>%
  mutate(safety = encode_safety(safety))

# Step 3: Summarize data
print(summarize_data(car_data_encoded))
print(count_unique_values(car_data_encoded))

# Step 4: Visualize input variables
decoded_data <- decode_categorical_features(car_data_encoded)
plot_distribution(decoded_data, x_var = "buying", fill_var = "safety", 
                  title = "Distribution of Buying Price by Safety Level")
plot_distribution(decoded_data, x_var = "persons", fill_var = "safety", 
                  title = "Distribution of Number of Persons by Safety Level")
plot_distribution(decoded_data, x_var = "maint", fill_var = "safety", 
                  title = "Distribution of Maintenance Cost by Safety Level")

# Step 5: Train/Test split
splitted <- split_data(car_data_encoded, response_col = "safety", prop = 0.8)

# Step 6: Cross-validation to find best k
cv_results <- cross_validate_knn(splitted$train_x, splitted$train_y, seq(1, 21, 2))
best_row <- cv_results[which.max(cv_results$accuracy), ]
best_k <- best_row$k

# Step 7: Train final model and evaluate
final_model <- train_final_model(splitted$test_x, splitted$test_y, best_k)
predictions <- predict(final_model, splitted$test_x)
test_acc <- round(compute_test_accuracy(predictions, splitted$test_y), 2)
baseline_acc <- round(calculate_random_baseline(splitted$train_y), 2)

cat("Best k:", best_k, "\n")
cat("Test Accuracy:", test_acc, "\n")
cat("Random Baseline Accuracy:", baseline_acc, "\n")

# Step 8: Plot confusion matrix
cm_plot <- plot_conf_matrix(splitted$test_y, predictions, title = "Confusion Matrix")
ggsave("../output/example_conf_matrix.png", cm_plot, width = 7, height = 5, dpi = 300)
