# Use Rocker RStudio as the base image
FROM rocker/rstudio:4.4.2

# Set the working directory
WORKDIR /home/rstudio

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libzmq3-dev python3 python3-pip python3-venv && \
    rm -rf /var/lib/apt/lists/*

# Create a virtual environment for Jupyter
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir jupyter jupyter-client

# Add Jupyter to PATH
ENV PATH="/opt/venv/bin:$PATH"

# Install specific versions of R packages
RUN R -e "install.packages('remotes', repos='https://cran.r-project.org')" && \
    R -e "remotes::install_version('IRkernel', version='1.3', repos='https://cran.r-project.org')" && \
    R -e "remotes::install_version('class', version='7.3-22', repos='https://cran.r-project.org')" && \
    R -e "remotes::install_version('caret', version='7.0.1', repos='https://cran.r-project.org')" && \
    R -e "remotes::install_version('dplyr', version='1.1.4', repos='https://cran.r-project.org')" && \
    R -e "remotes::install_version('ggplot2', version='3.5.1', repos='https://cran.r-project.org')" && \
    R -e "remotes::install_version('tidyr', version='1.3.1', repos='https://cran.r-project.org')" && \
    R -e "remotes::install_version('pbdZMQ', version='0.3-9', repos='https://cran.r-project.org')" && \
    R -e "remotes::install_version('janitor', version='2.2.0', repos='https://cran.r-project.org')" && \
    R -e "remotes::install_version('docopt', version='0.7.1', repos='https://cran.r-project.org')" && \
    R -e "remotes::install_version('readr', version='2.1.5', repos='https://cran.r-project.org')" && \
    R -e "remotes::install_version('testthat', version='3.1.10', repos='https://cran.r-project.org')" && \
    R -e "remotes::install_version('devtools', version='2.4.5', repos='https://cran.r-project.org')" && \
    R -e "remotes::install_version('pointblank', version='0.10.0', repos='https://cran.r-project.org')"


# Expose ports for RStudio (8787) and Jupyter Notebook (8888)
EXPOSE 8787 8888

# Start RStudio Server
CMD ["/init"]