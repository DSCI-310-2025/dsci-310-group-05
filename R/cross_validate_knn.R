#' Perform k-fold cross-validation for kNN
#'
#' @param train_x Training predictors.
#' @param train_y Training response.
#' @param k_values Vector of k values to try. Defaults to odd values from 1 to 21.
#'
#' @return A data frame with k values and corresponding accuracy.
#' @export
#' 
#' @examples
#' # Simulate small example dataset
#' set.seed(123)
#' df <- data.frame(
#'   buying = sample(1:4, 30, replace = TRUE),
#'   maint = sample(1:4, 30, replace = TRUE),
#'   persons = sample(2:5, 30, replace = TRUE),
#'   safety = factor(sample(c("low", "med", "high"), 30, replace = TRUE))
#' )
#'
#' # Prepare inputs
#' train_x <- df[, c("buying", "maint", "persons")]
#' train_y <- df$safety
#'
#' # Run kNN cross-validation
#' cross_validate_knn(train_x, train_y, k_values = c(1, 3, 5))
cross_validate_knn <- function(train_x, train_y, k_values = seq(1, 21, 2)) {
  if (nrow(train_x) == 0 || length(train_y) == 0) {
    stop("❌ train_x and train_y must not be empty.")
  }
  train_y <- as.factor(train_y)  # ensure classification
  results <- data.frame(k = integer(), accuracy = numeric())

  for (k in k_values) {
    set.seed(123)

    tryCatch({
      model <- caret::train(
        train_x, train_y,
        method = "knn",
        trControl = caret::trainControl(method = "cv", number = 5),
        tuneGrid = data.frame(k = k)
      )

      acc <- max(model$results$Accuracy, na.rm = TRUE)
      if (is.infinite(acc)) acc <- NA

      results <- rbind(results, data.frame(k = k, accuracy = acc))
    }, error = function(e) {
      message("⚠️ k = ", k, " failed: ", e$message)
      results <- rbind(results, data.frame(k = k, accuracy = NA))
    })
  }

  return(results)
}
