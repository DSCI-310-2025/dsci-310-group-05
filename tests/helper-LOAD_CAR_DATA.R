generate_temp_output_path <- function(filename = "car_data.csv") {
  file.path(tempdir(), filename)
}

clean_up_file <- function(file_path) {
  if (file.exists(file_path)) {
    file.remove(file_path)
  }
}
