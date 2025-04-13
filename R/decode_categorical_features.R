#' Decode Categorical Features
#'
#' Converts numerical encodings of categorical features back to labels.
#' @param data A data frame with encoded categorical variables.
#' @return A transformed data frame with categorical labels.
#' @examples
#' df <- data.frame(
#'   buying = c(1, 2, 3, 4),
#'   maint = c(4, 3, 2, 1),
#'   persons = c(2, 4, 5, 2),
#'   class = c(1, 2, 3, 4),
#'   safety = c("low", "med", "high", "low")
#' )
#' decode_categorical_features(df)
#' @export
decode_categorical_features <- function(data) {
  if (!is.data.frame(data)) {
    stop("Input must be a data frame.")
  }

  if ("buying" %in% names(data)) {
    if (!is.numeric(data$buying)) stop("Column 'buying' must be numeric.")
    data$buying <- factor(data$buying, levels = 1:4, labels = c("low", "med", "high", "vhigh"))
  }
  if ("maint" %in% names(data)) {
    if (!is.numeric(data$maint)) stop("Column 'maint' must be numeric.")
    data$maint <- factor(data$maint, levels = 1:4, labels = c("low", "med", "high", "vhigh"))
  }
  if ("persons" %in% names(data)) {
    if (!is.numeric(data$persons)) stop("Column 'persons' must be numeric.")
    data$persons <- factor(data$persons, levels = c(2, 4, 5), labels = c("2", "4", "5+"))
  }
  if ("class" %in% names(data)) {
    if (!is.numeric(data$class)) stop("Column 'class' must be numeric.")
    data$class <- factor(data$class, levels = 1:4, labels = c("unacc", "acc", "good", "vgood"))
  }
  if ("safety" %in% names(data)) {
    data$safety <- as.factor(data$safety)
  }

  return(data)
}
