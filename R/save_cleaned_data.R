#' Save the cleaned data to a specified file path.
#'
#' @param data A cleaned dataset to save.
#' @param output_file A string, path to save the cleaned CSV file.
#' @return A message confirming the file is saved.
#' @export
#' @examples
#' df <- data.frame(a = 1:3, b = c("x", "y", "z"))
#' save_cleaned_data(df, "data/clean/cleaned_data.csv")
save_cleaned_data <- function(data, output_file) {
  if (!is.data.frame(data)) {
    stop("❌ Input must be a data frame.")
  }
  output_dir <- dirname(output_file)
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }
  readr::write_csv(data, output_file)
  message("✅ Cleaned data saved to: ", output_file)
}
