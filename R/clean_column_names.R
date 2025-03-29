#' Cleans and standarizes column names for the loaded data.
#'
#' @param data a dataframe with the uncleaned columns.
#' @return a dataframe with the cleaned columns.
#' @export
clean_column_names <- function(data) {
  colnames(data) <- c("buying", "maint", "doors", "persons", "lug_boot", "safety", "class")
  return(janitor::clean_names(data))
}