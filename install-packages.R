# install-packages.R
install.packages("remotes", repos = "https://cran.r-project.org")

pkgs <- list(
  IRkernel = "1.3",
  class = "7.3-22",
  caret = "7.0.1",
  kknn = "1.3.1",
  dplyr = "1.1.4",
  ggplot2 = "3.5.1",
  tidyr = "1.3.1",
  pbdZMQ = "0.3-9",
  janitor = "2.2.0",
  docopt = "0.7.1",
  readr = "2.1.5",
  testthat = "3.1.10",
  devtools = "2.4.5",
  pointblank = "0.10.0"
)

for (pkg in names(pkgs)) {
  version <- pkgs[[pkg]]
  remotes::install_version(pkg, version = version, repos = "https://cran.r-project.org")
}

# Install your GitHub package
remotes::install_github("DSCI-310-2025/carpackage")
