#' Train final kNN model
#'
#' @param train_x Training predictors.
#' @param train_y Training response.
#' @param best_k Optimal k value.
#'
#' @return Trained kNN model.
#' @export
train_final_model <- function(train_x, train_y, best_k) {
  model <- caret::train(
    train_x, train_y, method = "knn",
    trControl = caret::trainControl(method = "none"),
    tuneGrid = data.frame(k = best_k)
  )
  return(model)
}
