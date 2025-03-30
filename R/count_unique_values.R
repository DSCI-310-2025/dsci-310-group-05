#' Count Unique Values
#'
#' Counts occurrences of each unique value in each column of the data frame.
#' @param data A data frame.
#' @return A data frame with columns: Variable, Value, Count.
#' @export
count_unique_values <- function(data) {
  data %>%
    pivot_longer(cols = everything(), names_to = "Variable", values_to = "Value") %>%
    group_by(Variable, Value) %>%
    summarise(Count = n(), .groups = "drop") %>%
    arrange(Variable, desc(Count))
}
