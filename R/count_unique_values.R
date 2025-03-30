#' Count Unique Values
#'
#' Counts occurrences of each unique value in each column of the data frame.
#' @param data A data frame.
#' @return A data frame with columns: Variable, Value, Count.
#' @export
count_unique_values <- function(data) {
  if (!is.data.frame(data)) {
    stop("Input must be a dataframe")
  }
  
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' is needed for this function to work. Please install it.", 
         call. = FALSE)
  }
  
  result <- data.frame(
    column = names(data),
    unique_count = sapply(data, function(x) length(unique(x)))
  )
  
  return(result)
}