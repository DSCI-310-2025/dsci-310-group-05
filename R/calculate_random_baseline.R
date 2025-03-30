#' Calculate baseline accuracy
#'
#' @param labels Vector of true class labels.
#'
#' @return Baseline accuracy using random guessing.
#' @export
calculate_random_baseline <- function(labels) {
  if (length(labels) == 0) {
    stop("Input label vector is zero-length.")
  }
  
  return(1 / dplyr::n_distinct(labels))
}