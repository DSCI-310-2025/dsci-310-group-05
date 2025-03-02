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