library(docopt)
library(class)
library(caret)
library(ggplot2)
library(dplyr)
library(readr)

source("R/calculate_random_baseline.R")
source("R/cross_validate_knn.R")
source("R/train_final_model.R")
source("R/compute_test_accuracy.R")
source("R/plot_conf_matrix.R")
source("R/split_data.R")



doc <- "
Modeling Script

Usage:
  modeling.R --input_file=<input_file> --output_prefix=<output_prefix>
"

opt <- docopt(doc)

# Load cleaned data
car_data_encoded <- read.csv(opt$input_file)

set.seed(123)  # For reproducibility

# Convert safety to factor
car_data_prepared <- car_data_encoded %>%
  mutate(safety = as.factor(safety))

# Split into training and testing
split <- split_data(car_data_prepared, response_col = "safety", prop = 0.8)

train_x <- split$train_x
train_y <- split$train_y
test_x  <- split$test_x
test_y  <- split$test_y


# Performing cross validation with various k values
cv_results <- cross_validate_knn(train_x, train_y, k_values = seq(1, 21, 2))

# Best k
best_k <- cv_results$k[which.max(cv_results$accuracy)]
best_cv_accuracy <- max(cv_results$accuracy)

# Final model
final_knn_model <- train_final_model(train_x, train_y, best_k)

# Predictions
predictions <- predict(final_knn_model, test_x)
test_accuracy <- compute_test_accuracy(predictions, test_y)

# Baseline accuracy (random guessing)
rand <- calculate_random_baseline(test_y)

# Save metrics as CSV
metrics_df <- data.frame(
  best_k = best_k,
  cv_accuracy = round(best_cv_accuracy * 100, 2),
  test_accuracy = round(test_accuracy * 100, 2),
  random_baseline = round(rand * 100, 2)
)

write_csv(metrics_df, paste0(opt$output_prefix, "_metrics.csv"))

# Confusion matrix
conf_matrix <- confusionMatrix(predictions, test_y)
conf_matrix_df <- as.data.frame(conf_matrix$table)
colnames(conf_matrix_df) <- c("True_Label", "Predicted_Label", "Count")

# Plot confusion matrix
p <- plot_conf_matrix(test_y, predictions, title = "Confusion Matrix for kNN Classification")

ggsave(paste0(opt$output_prefix, "_confusion_matrix.png"), plot = p, width = 7, height = 5)

print("Modeling Completed!")
