#' Decode Categorical Features
#'
#' Converts numerical encodings of categorical features back to labels.
#' @param data A data frame with encoded categorical variables.
#' @return A transformed data frame with categorical labels.
#' @export
decode_categorical_features <- function(data) {
  data %>%
    mutate(
      buying = factor(buying, levels = c(1, 2, 3, 4), labels = c("low", "med", "high", "vhigh")),
      maint = factor(maint, levels = c(1, 2, 3, 4), labels = c("low", "med", "high", "vhigh")),
      persons = factor(persons, levels = c(2, 4, 5), labels = c("2", "4", "5+")), 
      class = factor(class, levels = c(1, 2, 3, 4), labels = c("unacc", "acc", "good", "vgood")),
      safety = as.factor(safety)
    )
}
