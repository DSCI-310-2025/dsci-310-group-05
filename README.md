# Predicting Car Safety with k-Nearest Neighbors: A Statistical Analysis

**Contributors**: [Nika Karimi Seffat, Ethan Wang, Gautam Arora, Kevin Li]

**Course**: DSCI-310   


### Table of Contents
- [Summary of Our Project](#summary)
- [How to Run Our Data Analysis](#how-to-run)
- [Dependencies](#dependencies)
- [Licenses](#licenses)

## Summary

This project analyzes the Car Evaluation Dataset from [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Car+Evaluation), which contains 1,728 records with six categorical attributes: buying price, maintenance cost, number of doors, passenger capacity, luggage space, and safety rating. The dataset was clean, with no missing values or duplicates, and required ordinal encoding for machine learning analysis.

Exploratory Data Analysis (EDA) revealed balanced distributions across most features. However, the "class" variable was highly imbalanced, with "unacceptable" accounting for 1,210 instances and "very good" only 65 instances. The k-Nearest Neighbors (kNN) model was trained to predict safety levels using the other features, achieving an accuracy of 46.96% with an optimal k of 17—an improvement over random guessing (33.3%) but highlighting the model's limited predictive power.

The findings indicate that individual features do not strongly determine safety levels independently, suggesting the need for more complex models or additional variables. These results have implications for both vehicle safety assessment and methodological best practices in categorical data analysis, reinforcing the importance of feature selection and encoding techniques for machine learning applications.



## How To Run:

Use the following steps to reproduce the analysis in a containerized environment:

1. **From your terminal, use the following bash command to clone this repo and set it as your local working directory**

```bash
git clone https://github.com/DSCI-310-2025/dsci-310-group-05.git
```

```bash
cd dsci-310-group-05/
```

2. **Download and install Docker (if you have not already), and open the Docker application.**

- [Install Docker on Windows](https://docs.docker.com/docker-for-windows/install/)
- [Install Docker on macOS](https://docs.docker.com/docker-for-mac/install/)
- [Install Docker on Linux](https://docs.docker.com/engine/install/)

3. **To build and run the container:**

`docker-compose up --build -d`

4. **Access Jupyter Notebook:**

- Run `localhost:8888` on your browser.
- Then, you can run the analysis in the Jupyter Notebook.

### Alternative: Run the Pre-Built Docker Image (Recommended)
If you don't want to build the container manually, you can use our pre-built image from DockerHub.

1. **Pull the latest Docker image from DockerHub:**

   Have docker open and run: `docker pull kevinl002/dsci-310-group-05-container:latest` in terminal

2. **Run the container:**

 `docker run -it --rm -p 8787:8787 -p 8888:8888 kevinl002/dsci-310-group-05-container:latest` in terminal

3. **Access Jupyter Notebook:**:

- Again run: `http://localhost:8888` on your browser to access the analysis in Jupyter Notebook

### DockerHub Repository
You can find our Docker images here:  
👉 [DockerHub: kevinl002/dsci-310-group-05](https://hub.docker.com/r/kevinl002/dsci-310-group-05-container)

## Dependencies

**System Dependencies:**

- Docker
- Git (for cloning the repository)
- Docker Image: jupyter/r-notebook

**R Dependencies:**

- ggplot2
- dplyr
- tidyr
- caret
- class

## Licenses

These are the licences contained in LICENSE.md:

- MIT License

![GitHub license](https://img.shields.io/github/license/DSCI-310-2025/dsci-310-group-7-data-dudes) 
