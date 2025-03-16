library(docopt)
library(class)
library(caret)
library(ggplot2)
library(dplyr)

doc <- "
Modeling Script

Usage:
  modeling.R --input_file=<input_file> --output_prefix=<output_prefix>
"

opt <- docopt(doc)

# Load cleaned data, not the raw data (from step 2)
car_data_encoded <- read.csv(opt$input_file)

set.seed(123)  # Ensure reproducibility

# Convert categorical variables to factors
car_data_prepared <- car_data_encoded %>%
  mutate(safety = as.factor(safety))

# Split data into training (80%) and testing (20%)
train_index <- createDataPartition(car_data_prepared$safety, p = 0.8, list = FALSE)
train_data <- car_data_prepared[train_index, ]
test_data <- car_data_prepared[-train_index, ]

# Separate features and target variable
train_x <- train_data %>% select(-safety)
train_y <- train_data$safety

test_x <- test_data %>% select(-safety)
test_y <- test_data$safety

# Define k values to test
k_values <- seq(1, 21, 2)
cv_results <- data.frame(k = integer(), accuracy = numeric())

# Perform cross-validation
for (k in k_values) {
  set.seed(123)
  knn_model <- train(train_x, train_y, method = "knn",
                     trControl = trainControl(method = "cv", number = 5),
                     tuneGrid = data.frame(k = k))
  cv_results <- rbind(cv_results, data.frame(k = k, accuracy = max(knn_model$results$Accuracy)))
}

# Find best k
best_k <- cv_results$k[which.max(cv_results$accuracy)]
best_cv_accuracy <- max(cv_results$accuracy)

cat("Best k:", best_k, "\n")
cat("Best CV accuracy:", round(best_cv_accuracy * 100, 2), "%\n")

# Train final model
final_knn_model <- train(train_x, train_y, method = "knn",
                         trControl = trainControl(method = "none"),
                         tuneGrid = data.frame(k = best_k))

# Predictions
predictions <- predict(final_knn_model, test_x)
test_accuracy <- sum(predictions == test_y) / length(test_y)

cat("Test Accuracy:", round(test_accuracy * 100, 2), "%\n")

# Confusion Matrix
conf_matrix <- confusionMatrix(predictions, test_y)
conf_matrix_df <- as.data.frame(conf_matrix$table)
colnames(conf_matrix_df) <- c("True_Label", "Predicted_Label", "Count")

# Plot Confusion Matrix
p <- ggplot(conf_matrix_df, aes(x = Predicted_Label, y = True_Label, fill = Count)) +
  geom_tile() +
  geom_text(aes(label = Count), color = "white", size = 6) +
  scale_fill_gradient(low = "lightblue", high = "blue") +
  labs(title = "Confusion Matrix for kNN Classification",
       x = "Predicted Label", y = "True Label", fill = "Count") +
  theme_minimal()

ggsave(paste0(opt$output_prefix, "_confusion_matrix.png"), plot = p)

print("Modeling Completed!")
