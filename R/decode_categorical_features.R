#' Decode Categorical Features
#'
#' Converts numerical encodings of categorical features back to labels.
#' @param data A data frame with encoded categorical variables.
#' @return A transformed data frame with categorical labels.
#' @export
decode_categorical_features <- function(data) {
  if (!is.data.frame(data)) {
    stop("Input must be a dataframe")
  }
  
  result <- data
  
  if ("buying" %in% names(data)) {
    if (!is.factor(data$buying)) {
      stop("Categorical columns must be factors")
    }
    result$buying <- factor(data$buying, 
                           levels = c(1, 2, 3, 4), 
                           labels = c("low", "med", "high", "vhigh"))
  }
  
  if ("maint" %in% names(data)) {
    if (!is.factor(data$maint)) {
      stop("Categorical columns must be factors")
    }
    result$maint <- factor(data$maint, 
                          levels = c(1, 2, 3, 4), 
                          labels = c("low", "med", "high", "vhigh"))
  }
  
  if ("persons" %in% names(data)) {
    result$persons <- factor(data$persons, 
                            levels = c(2, 4, 5), 
                            labels = c("2", "4", "5+"))
  }
  
  if ("class" %in% names(data)) {
    if (!is.factor(data$class)) {
      stop("Categorical columns must be factors")
    }
    result$class <- factor(data$class, 
                          levels = c(1, 2, 3, 4), 
                          labels = c("unacc", "acc", "good", "vgood"))
  }
  
  if ("safety" %in% names(data)) {
    if (!is.factor(data$safety)) {
      stop("Categorical columns must be factors")
    }
    result$safety <- as.factor(data$safety)
  }
  
  return(result)
}