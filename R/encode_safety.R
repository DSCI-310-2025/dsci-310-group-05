#' Encode the safety variable.
#'
#' @param x A character vector representing safety levels.
#' @return A numeric vector representing the safety encoding.
#' @export
#' @examples
#' encode_safety(c("low", "med", "high", "2"))
#' # Returns: 1, 2, 3, 2
encode_safety <- function(x) {
  if (!is.character(x)) {
    stop("Input must be a character vector.")
  }
  
  dplyr::case_when(
    x == "low"  ~ 1,
    x == "med"  ~ 2,
    x == "high" ~ 3,
    TRUE        ~ suppressWarnings(as.numeric(x))
  )
}
