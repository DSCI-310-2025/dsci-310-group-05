#' Compute Test Accuracy
#'
#' Calculates the proportion of correct predictions.
#'
#' @param predicted A vector of predicted class labels.
#' @param actual A vector of true class labels.
#'
#' @return A numeric value between 0 and 1 representing the test accuracy.
#' @export

compute_test_accuracy <- function(predicted, actual) {
  if (length(predicted) != length(actual)) {
    stop("❌ Lengths of predicted and actual labels must be the same.")
  }
  if (length(actual) == 0) {
    stop("❌ Input vectors must not be empty.")
  }
  
  accuracy <- sum(predicted == actual) / length(actual)
  return(accuracy)
}