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
  p <- ggplot(data, aes_string(x = x_var, fill = fill_var)) +
    geom_bar(position = "dodge") +
    labs(title = title, x = x_var, y = "Count", fill = fill_var) +
    theme_minimal() +
    theme(
      plot.title = element_text(size = 18, face = "bold"),
      axis.title = element_text(size = 16),
      axis.text = element_text(size = 14),
      legend.title = element_text(size = 14),
      legend.text = element_text(size = 12)
    )
  
  ggsave(output_path, plot = p)
}
