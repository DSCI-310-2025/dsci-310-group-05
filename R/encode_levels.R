#' Encode categorical variables with predefined levels.
#'
#' @param x A character vector to encode.
#' @return A numeric vector representing encoded values.
#' @export
encode_levels <- function(x) {
  dplyr::case_when(
    x == "vhigh"  ~ 4,
    x == "high"   ~ 3,
    x == "med"    ~ 2, 
    x == "low"    ~ 1,
    x == "big"    ~ 3,
    x == "small"  ~ 1,
    x == "more"   ~ 5,
    x == "5more"  ~ 5,
    x == "2"      ~ 2,
    x == "3"      ~ 3,
    x == "4"      ~ 4,
    x == "unacc"  ~ 1,
    x == "acc"    ~ 2,
    x == "good"   ~ 3,
    x == "vgood"  ~ 4,
    TRUE          ~ suppressWarnings(as.numeric(x))
  )
}

