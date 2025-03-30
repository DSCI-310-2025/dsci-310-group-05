#' Summarize Data
#'
#' This function prints summary statistics for a given data frame.
#'
#' @param data A data frame.
#' @return Prints the summary to console.
#' @export
summarize_data <- function(data) {
  if (!is.data.frame(data)) {
    stop("Input must be a data frame.")
  }

  print(summary(data))  # this makes expect_output() happy. return() caused many issues so we decided to just print it
}
