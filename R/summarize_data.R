#' Summarize Data
#'
#' This function prints summary statistics for a given data frame.
#' @param data A data frame.
#' @return A summary of the data frame.
#' @export
summarize_data <- function(data) {
  if (!is.data.frame(data)) {
    stop("Input must be a data frame.")
  }

  print(summary(data))  
}

