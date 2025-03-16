# Ensure the raw dataset is downloaded
data/original/car_data.csv: 01-load_data_from_web.R
	Rscript 01-load_data_from_web.R --file_path=https://archive.ics.uci.edu/ml/machine-learning-databases/car/car.data --output_path=data/original/car_data.csv

# Ensure the cleaned dataset is created
data/clean/car_clean.csv: 02-clean_car_data.R data/original/car_data.csv
	Rscript 02-clean_car_data.R --input_file=data/original/car_data.csv --output_file=data/clean/car_clean.csv

# Generate summary statistics
output/eda_summary.csv: 03-eda-and-summary-stats.R data/clean/car_clean.csv
	Rscript 03-eda-and-summary-stats.R --input_file=data/clean/car_clean.csv --output_prefix=output/eda_summary

# Train kNN model and save results
output/knn_model.RDS output/cf_matrix.png: 04-knn-analysis-and-cf-matrix.R data/clean/car_clean.csv
	Rscript 04-knn-analysis-and-cf-matrix.R --input_file=data/clean/car_clean.csv --output_prefix=output/knn_model

# Render the Quarto report
reports/report.html: reports/report.qmd data/original/car_data.csv output/eda_summary.csv output/cf_matrix.png
	quarto render reports/report.qmd --to html

# Generate PDF report (optional)
reports/report.pdf: reports/report.qmd data/original/car_data.csv output/eda_summary.csv output/cf_matrix.png
	quarto render reports/report.qmd --to pdf

# Final index.html (direct render)
index.html: reports/report.qmd data/original/car_data.csv output/eda_summary.csv output/cf_matrix.png
	quarto render reports/report.qmd --output index.html

# Clean everything
clean:
	rm -f data/clean/*
	rm -f data/original/*
	rm -f index.html
	rm -f *.pdf
	rm -f output/*

# Run everything
all: data/original/car_data.csv data/clean/car_clean.csv output/eda_summary.csv output/knn_model.RDS output/cf_matrix.png index.html
