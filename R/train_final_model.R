#' Train final kNN model
#'
#' @param train_x Training predictors.
#' @param train_y Training response.
#' @param best_k Optimal k value.
#'
#' @return Trained kNN model.
#' @export
#' 
#' @examples
#' df <- data.frame(x1 = rnorm(50), x2 = rnorm(50))
#' y <- factor(sample(c("yes", "no"), 50, replace = TRUE))
#' model <- train_final_model(df, y, best_k = 5)
train_final_model <- function(train_x, train_y, best_k) {
  if (!is.numeric(best_k) || is.na(best_k) || length(best_k) != 1) {
    stop("best_k must be a single numeric value.")
  }

  model <- caret::train(
    train_x, train_y, method = "knn",
    trControl = caret::trainControl(method = "none"),
    tuneGrid = data.frame(k = best_k)
  )
  return(model)
}

