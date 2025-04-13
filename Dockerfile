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

# Copy install script
COPY install-packages.R /install-packages.R

# Run R dependency installs in one clean step
RUN Rscript /install-packages.R

# Expose ports for RStudio (8787) and Jupyter Notebook (8888)
EXPOSE 8787 8888

# Start RStudio Server
CMD ["/init"]