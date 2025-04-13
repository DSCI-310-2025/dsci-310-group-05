#' Split data into training and test sets
#'
#' @param data The full prepared dataset.
#' @param response_col Name of the response column (as string).
#' @param prop Proportion of data to include in the training set.
#'
#' @return A list with train_x, train_y, test_x, test_y.
#' @export
#' 
#' @examples
#' df <- data.frame(
#'   feature1 = rnorm(100),
#'   feature2 = rnorm(100),
#'   safety = sample(c("low", "med", "high"), 100, replace = TRUE)
#' )
#' split <- split_data(df, response_col = "safety", prop = 0.75)
#' names(split)
#' # Returns: "train_x", "train_y", "test_x", "test_y"
split_data <- function(data, response_col = "safety", prop = 0.8) {
  if (!(response_col %in% colnames(data))) {
    stop(paste("Response column", response_col, "not found in data."))
  }

  set.seed(123)
  idx <- caret::createDataPartition(data[[response_col]], p = prop, list = FALSE)
  train <- data[idx, ]
  test <- data[-idx, ]

  return(list(
    train_x = train %>% dplyr::select(-all_of(response_col)),
    train_y = train[[response_col]],
    test_x = test %>% dplyr::select(-all_of(response_col)),
    test_y = test[[response_col]]
  ))
}

