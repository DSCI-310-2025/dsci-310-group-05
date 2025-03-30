#' Count Unique Values
#'
#' Counts occurrences of each unique value in each column of the data frame.
#' @param data A data frame.
#' @return A data frame with columns: Variable, Value, Count.
#' @export
#' Count unique values in each column
#'
#' @param df A data frame
#' @return A data frame with counts of unique values per column
#' @export
count_unique_values <- function(df) {
  df[] <- lapply(df, as.character)  # 👈 force all columns to same type
  df %>%
    tidyr::pivot_longer(cols = everything(), names_to = "Variable", values_to = "Value") %>%
    dplyr::group_by(Variable, Value) %>%
    dplyr::summarise(Count = n(), .groups = "drop") %>%
    dplyr::arrange(Variable, dplyr::desc(Count))
}

