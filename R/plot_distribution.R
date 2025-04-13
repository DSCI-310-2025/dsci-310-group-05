#' Plot Distribution
#'
#' Creates and optionally saves a bar plot showing the distribution of a categorical variable grouped by another variable.
#'
#' @param data A data frame.
#' @param x_var The categorical variable to be plotted on the x-axis.
#' @param fill_var The grouping variable used for coloring the bars.
#' @param title The title of the plot.
#' @param output_path Optional file path to save the plot (should include .png). If NULL, the plot is not saved.
#'
#' @return A ggplot object representing the distribution plot.
#' @export
plot_distribution <- function(data, x_var, fill_var, title, output_path = NULL) {
  if (!is.data.frame(data)) stop("Input `data` must be a data frame.")
  if (is.null(x_var) || is.null(fill_var)) stop("x_var and fill_var must be provided.")
  if (!x_var %in% names(data)) stop("x_var not found in data.")
  if (!fill_var %in% names(data)) stop("fill_var not found in data.")
  
  p <- ggplot2::ggplot(data, ggplot2::aes(x = !!rlang::sym(x_var), fill = !!rlang::sym(fill_var))) +
    ggplot2::geom_bar(position = "dodge") +
    ggplot2::labs(title = title, x = x_var, y = "Count", fill = fill_var) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      plot.title = ggplot2::element_text(size = 18, face = "bold"),
      axis.title = ggplot2::element_text(size = 16),
      axis.text = ggplot2::element_text(size = 14),
      legend.title = ggplot2::element_text(size = 14),
      legend.text = ggplot2::element_text(size = 12)
    )
  
  # Save to file if path is provided and ends with .png
  if (!is.null(output_path)) {
    if (!grepl("\\.png$", output_path)) {
      stop("output_path must end in .png")
    }
    ggplot2::ggsave(filename = output_path, plot = p, width = 7, height = 5, dpi = 300)
  }
  
  return(p)
}

