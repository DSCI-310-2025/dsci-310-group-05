#' Perform k-fold cross-validation for kNN
#'
#' @param train_x Training predictors.
#' @param train_y Training response.
#' @param k_values Vector of k values to try.
#'
#' @return A data frame with k values and corresponding accuracy.
#' @export
cross_validate_knn <- function(train_x, train_y, k_values = seq(1, 21, 2)) {
  results <- data.frame(k = integer(), accuracy = numeric())
  for (k in k_values) {
    set.seed(123)
    model <- caret::train(
      train_x, train_y, method = "knn",
      trControl = caret::trainControl(method = "cv", number = 5),
      tuneGrid = data.frame(k = k)
    )
    results <- rbind(results, data.frame(k = k, accuracy = max(model$results$Accuracy)))
  }
  return(results)
}
