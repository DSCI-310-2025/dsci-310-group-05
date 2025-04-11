library(docopt)
library(class)
library(caret)
library(ggplot2)
library(dplyr)
library(readr)

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
train_index <- createDataPartition(car_data_prepared$safety, p = 0.8, list = FALSE)
train_data <- car_data_prepared[train_index, ]
test_data <- car_data_prepared[-train_index, ]

train_x <- train_data %>% select(-safety)
train_y <- train_data$safety
test_x <- test_data %>% select(-safety)
test_y <- test_data$safety

# k values to try
k_values <- seq(1, 21, 2)
cv_results <- data.frame(k = integer(), accuracy = numeric())

# Cross-validation
for (k in k_values) {
  set.seed(123)
  knn_model <- train(train_x, train_y, method = "knn",
                     trControl = trainControl(method = "cv", number = 5),
                     tuneGrid = data.frame(k = k))
  cv_results <- rbind(cv_results, data.frame(k = k, accuracy = max(knn_model$results$Accuracy)))
}

# Best k
best_k <- cv_results$k[which.max(cv_results$accuracy)]
best_cv_accuracy <- max(cv_results$accuracy)

# Final model
final_knn_model <- train(train_x, train_y, method = "knn",
                         trControl = trainControl(method = "none"),
                         tuneGrid = data.frame(k = best_k))

# Predictions
predictions <- predict(final_knn_model, test_x)
test_accuracy <- sum(predictions == test_y) / length(test_y)

# Baseline accuracy (random guessing)
num_classes <- n_distinct(test_y)
rand <- 1 / num_classes

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
p <- ggplot(conf_matrix_df, aes(x = Predicted_Label, y = True_Label, fill = Count)) +
  geom_tile() +
  geom_text(aes(label = Count), color = "white", size = 6) +
  scale_fill_gradient(low = "lightblue", high = "blue") +
  labs(title = "Confusion Matrix for kNN Classification",
       x = "Predicted Label", y = "True Label", fill = "Count") +
  theme_minimal()

ggsave(paste0(opt$output_prefix, "_confusion_matrix.png"), plot = p, width = 7, height = 5)

print("Modeling Completed!")
