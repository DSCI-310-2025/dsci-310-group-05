#' Cleans and standarizes column names for the loaded data.
#'
#' @param data a dataframe with the uncleaned columns.
#' @return a dataframe with the cleaned columns.
#' @examples
#' df_raw <- data.frame(V1 = 1:3, V2 = 1:3, V3 = 1:3, V4 = 1:3,
#'                      V5 = 1:3, V6 = 1:3, V7 = 1:3)
#' clean_column_names(df_raw)
#' @export
clean_column_names <- function(data) {
  if (!is.data.frame(data)) {
    stop("❌ Input must be a data frame.")
  }

  colnames(data) <- c("buying", "maint", "doors", "persons", "lug_boot", "safety", "class")
  return(janitor::clean_names(data))
}
