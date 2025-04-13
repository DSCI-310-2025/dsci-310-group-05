#' Calculate baseline accuracy
#'
#' @param labels Vector of true class labels.
#'
#' @return Baseline accuracy using random guessing.
#' @examples
#' # For binary classification (e.g., "a", "b"), baseline is 0.5
#' calculate_random_baseline(c("a", "b", "a", "b"))
#'
#' # For 3 classes (e.g., "x", "y", "z"), baseline is 1/3
#' calculate_random_baseline(c("x", "y", "z", "x"))
#'
#' # For single class, baseline is 1
#' calculate_random_baseline(rep("a", 5))
#' @export
calculate_random_baseline <- function(labels) {
  if (length(labels) == 0) {
    stop("Input label vector is zero-length.")
  }
  
  return(1 / dplyr::n_distinct(labels))
}