library(readr)
library(janitor)

#' Check data quality by detecting NA values and duplicate rows
#'
#' Takes a dataframe, reports the number of NA values and duplicates,
#' removes them, and returns the cleaned dataframe.
#'
#' @param data A dataframe or tibble.
#' @return A cleaned dataframe with no missing values or duplicate rows.
#'
#' @examples
#' df <- data.frame(a = c(1, NA, 2, 2), b = c("x", "y", "z", "z"))
#' cleaned <- check_data_quality(df)
#'
#' @export
check_data_quality <- function(data) {
  if (!is.data.frame(data)) {
    stop("❌ Input must be a dataframe.")
  }
  
  num_missing <- sum(is.na(data))
  num_duplicates <- sum(duplicated(data))
  
  message("🔍 Missing values found: ", num_missing)
  message("🔁 Duplicate rows found: ", num_duplicates)
  
  cleaned_data <- data |>
    tidyr::drop_na() |>
    dplyr::distinct()
  
  message("✅ Cleaning completed. Returned cleaned dataframe.")
  
  return(cleaned_data)
}