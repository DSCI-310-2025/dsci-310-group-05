library(testthat)
library(ggplot2)

plot_confusion_matrix <- function(true_labels, predicted_labels, title = "Confusion Matrix") {
  cm <- caret::confusionMatrix(predicted_labels, true_labels)
  cm_df <- as.data.frame(cm$table)
  colnames(cm_df) <- c("True_Label", "Predicted_Label", "Count")
  
  ggplot(cm_df, aes(x = Predicted_Label, y = True_Label, fill = Count)) +
    geom_tile() +
    geom_text(aes(label = Count), color = "white", size = 5) +
    scale_fill_gradient(low = "lightblue", high = "blue") +
    labs(title = title, x = "Predicted Label", y = "True Label", fill = "Count") +
    theme_minimal()
}


test_that("plot_confusion_matrix returns a ggplot object", {
  true_labels <- factor(c("low", "low", "med", "high", "high", "high"))
  predicted_labels <- factor(c("low", "med", "med", "high", "low", "high"))
  
  p <- plot_confusion_matrix(true_labels, predicted_labels)
  
  expect_s3_class(p, "ggplot")
})

test_that("plot_confusion_matrix handles perfect predictions", {
  true_labels <- factor(c("low", "med", "high"))
  predicted_labels <- factor(c("low", "med", "high"))
  
  p <- plot_confusion_matrix(true_labels, predicted_labels)
  
  expect_s3_class(p, "ggplot")
  expect_true(any(grepl("Confusion Matrix", p$labels$title)))
})

test_that("plot_confusion_matrix throws error with mismatched lengths", {
  true_labels <- factor(c("low", "med"))
  predicted_labels <- factor(c("low", "med", "high"))
  
  expect_error(plot_confusion_matrix(true_labels, predicted_labels))
})

test_that("plot_confusion_matrix works with default title", {
  true_labels <- factor(c("yes", "no", "yes", "no"))
  predicted_labels <- factor(c("yes", "yes", "no", "no"))
  
  p <- plot_confusion_matrix(true_labels, predicted_labels)
  
  expect_equal(p$labels$title, "Confusion Matrix")
})
