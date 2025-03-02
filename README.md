# Predicting Car Safety with k-Nearest Neighbors: A Statistical Analysis

**Contributors**: [Nika Karimi Seffat, Ethan Wang, Gautam Arora, Kevin Li]

**Course**: DSCI-310   


### Table of Contents
- [Summary of Our Project](#summary)
- [How to Run Our Data Analysis](#how-to-run)
- [Dependencies](#dependencies)
- [Licenses](#licenses)

## Summary

This project, developed as part of DSCI-310 (2025), analyzes a car evaluation dataset from the [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Car+Evaluation) to predict car safety ratings (low, medium, high) using the k-Nearest Neighbors (kNN) algorithm. The dataset includes 1,728 entries with categorical features: buying price, maintenance cost, number of doors, passenger capacity, luggage boot size, and safety level.

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

## Dependencies

**System Dependencies:**

- Docker
- Git (for cloning the repository)
- Docker Image: jupyter/r-notebook

**R Dependencies:**

- ggplot2
- dplyr
- caret
- class

## Licenses

These are the licences contained in LICENSE.md:

- MIT License

![GitHub license](https://img.shields.io/github/license/DSCI-310-2025/dsci-310-group-7-data-dudes) 