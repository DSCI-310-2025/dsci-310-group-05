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

# Install IRkernel and required R packages
RUN R -e "install.packages(c('IRkernel', 'class', 'caret', 'dplyr', 'ggplot2', 'tidyr', 'pbdZMQ'))" && \
    R -e "IRkernel::installspec(user = FALSE)"

# Expose RStudio (8787) and Jupyter Notebook (8888)
EXPOSE 8787 8888

# Start RStudio Server
CMD ["/init"]

# Use rocker/tidyverse as base image
FROM rocker/tidyverse:latest

# Install the required R packages that you're using in your project
RUN R -e "install.packages(c('class', 'caret'), dependencies=TRUE)"

# Create a directory for your project in the container
WORKDIR /home/rstudio/dsci-310-group-05

# Copy all your project files into the container
COPY . /home/rstudio/dsci-310-group-05/

# Set default command (using R Studio Server which is in the rocker/tidyverse image)
# This will start RStudio Server on port 8787
CMD ["/init"]

# Expose the port that RStudio Server runs on
EXPOSE 8787
