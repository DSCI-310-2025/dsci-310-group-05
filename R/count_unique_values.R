#' Count Unique Values
#'
#' Counts occurrences of each unique value in each column of the data frame.
#' @param data A data frame.
#' @return A data frame with columns: Variable, Value, Count.
#' @export
#'
#' @examples
#' df <- data.frame(
#'   A = c("x", "y", "x"),
#'   B = c("a", "a", "b")
#' )
#' count_unique_values(df)
count_unique_values <- function(df) {
  if (!is.data.frame(df)) {
    stop("❌ Input must be a data frame.")
  }
  df[] <- lapply(df, as.character)  # 👈 force all columns to same type
  df %>%
    tidyr::pivot_longer(cols = everything(), names_to = "Variable", values_to = "Value") %>%
    dplyr::group_by(Variable, Value) %>%
    dplyr::summarise(Count = n(), .groups = "drop") %>%
    dplyr::arrange(Variable, dplyr::desc(Count))
}

