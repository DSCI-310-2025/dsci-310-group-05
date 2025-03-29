#' Encode the safety variable.
#'
#' @param x A character vector representing safety levels.
#' @return A numeric vector representing the safety encoding.
#' @export
encode_safety <- function(x) {
  dplyr::case_when(
    x == "low"  ~ 1,
    x == "med"  ~ 2,
    x == "high" ~ 3,
    TRUE        ~ suppressWarnings(as.numeric(x))
  )
}
