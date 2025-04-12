data/original/car_data.csv: scripts/01-load_data_from_web.R
	Rscript scripts/01-load_data_from_web.R --file_path=https://archive.ics.uci.edu/ml/machine-learning-databases/car/car.data --output_path=data/original/car_data.csv

data/clean/car_clean.csv: scripts/02-clean_car_data.R data/original/car_data.csv
	Rscript scripts/02-clean_car_data.R --input_file=data/original/car_data.csv --output_file=data/clean/car_clean.csv

output/eda_summary.csv: scripts/03-eda-and-summary-stats.R data/clean/car_clean.csv
	Rscript scripts/03-eda-and-summary-stats.R --input_file=data/clean/car_clean.csv --output_prefix=output/eda_summary

output/knn_model.RDS output/cf_matrix.png: scripts/04-knn-analysis-and-cf-matrix.R data/clean/car_clean.csv
	Rscript scripts/04-knn-analysis-and-cf-matrix.R --input_file=data/clean/car_clean.csv --output_prefix=output/knn_model

car_evaluation.html car_evaluation.pdf: analysis/report.qmd output/eda_summary.csv output/cf_matrix.png
	quarto render analysis/report.qmd --to html
	quarto render analysis/report.qmd --to pdf

clean:
	rm -f data/clean/*
	rm -f index.html
	rm -f *.pdf
	rm -f output/*.png
	rm -f output/*.csv
	rm -f output/eda_summary/*
	find analysis -type f ! -name "report.qmd" ! -name "references.bib" -delete
	
all: data/original/car_data.csv data/clean/car_clean.csv output/eda_summary.csv output/knn_model.RDS output/cf_matrix.png car_evaluation.html car_evaluation.pdf





