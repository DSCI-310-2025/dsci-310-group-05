#' Plot Distribution
#'
#' Creates a bar plot showing the distribution of a categorical variable grouped by another variable.
#' @param data A data frame.
#' @param x_var The categorical variable to be plotted on the x-axis.
#' @param fill_var The grouping variable used for coloring the bars.
#' @param title The title of the plot.
#' @param output_path The path to save the plot.
#' @export
plot_distribution <- function(data, x_var, fill_var, title, output_path) {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is needed for this function to work. Please install it.",
         call. = FALSE)
  }
  
  if (is.null(x_var) || is.null(fill_var)) {
    stop("x_var and fill_var must be non-NULL")
  }
  
  if (!x_var %in% names(data) || !fill_var %in% names(data)) {
    stop("x_var and fill_var must be column names in the data")
  }
  
  is_categorical <- function(var_name) {
    var <- data[[var_name]]
    return(is.factor(var) || is.character(var))
  }
  
  if (!is_categorical(x_var) || !is_categorical(fill_var)) {
    stop("x_var and fill_var must be categorical")
  }
  
  if (output_path == "" || is.null(output_path)) {
    stop("Invalid output path")
  }
  
  p <- ggplot2::ggplot(data) +
    ggplot2::geom_bar(
      ggplot2::aes(
        .data[[x_var]], 
        fill = .data[[fill_var]]
      ),
      position = "dodge"
    ) +
    ggplot2::labs(title = title, x = x_var, y = "Count", fill = fill_var) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      plot.title = ggplot2::element_text(size = 18, face = "bold"),
      axis.title = ggplot2::element_text(size = 16),
      axis.text = ggplot2::element_text(size = 14),
      legend.title = ggplot2::element_text(size = 14),
      legend.text = ggplot2::element_text(size = 12)
    )
  
  suppressMessages(
    ggplot2::ggsave(output_path, plot = p)
  )
  
  invisible(p)
}