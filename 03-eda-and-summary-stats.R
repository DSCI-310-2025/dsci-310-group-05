library(docopt)
library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)

doc <- "
Exploratory Data Analysis Script

Usage:
  eda.R --input_file=<input_file> --output_prefix=<output_prefix>
"

# Parse command line arguments
opt <- docopt(doc)

# Load cleaned data
car_data_encoded <- read.csv(opt$input_file)

# Summary statistics
summary(car_data_encoded)

# Count occurrences for each unique value in each column
unique_occurences <- car_data_encoded %>%
  pivot_longer(cols = everything(), names_to = "Variable", values_to = "Value") %>%
  group_by(Variable, Value) %>%
  summarise(Count = n(), .groups = "drop") %>%
  arrange(Variable, desc(Count))

write_csv(unique_occurences, "output/eda_summary/unique_occurences.csv")

# Convert encoded variables back to categorical labels
car_data_labeled <- car_data_encoded %>%
  mutate(
    buying = factor(buying, levels = c(1, 2, 3, 4), labels = c("low", "med", "high", "vhigh")),
    maint = factor(maint, levels = c(1, 2, 3, 4), labels = c("low", "med", "high", "vhigh")),
    persons = factor(persons, levels = c(2, 4, 5), labels = c("2", "4", "5+")), 
    class = factor(class, levels = c(1, 2, 3, 4), labels = c("unacc", "acc", "good", "vgood")),
    safety = as.factor(safety)
  )

# Define a larger theme for plots
larger_theme <- theme(
  plot.title = element_text(size = 18, face = "bold"),
  axis.title = element_text(size = 16),
  axis.text = element_text(size = 14),
  legend.title = element_text(size = 14),
  legend.text = element_text(size = 12)
)

# Plot 1: Distribution of Buying Price by Safety Level
p1 <- ggplot(car_data_labeled, aes(x = buying, fill = safety)) +
  geom_bar(position = "dodge") +
  labs(title = "Distribution of Buying Price by Safety Level", 
       x = "Buying Price", y = "Count", fill = "Safety Level") +
  theme_minimal() + larger_theme
ggsave(file.path("output", paste0(basename(opt$output_prefix), "_buying_safety.png")), plot = p1)

# Plot 2: Distribution of Number of Persons by Safety Level
p2 <- ggplot(car_data_labeled, aes(x = persons, fill = safety)) +
  geom_bar(position = "dodge") +
  labs(title = "Distribution of Number of Persons by Safety Level", 
       x = "Number of Persons", y = "Count", fill = "Safety Level") +
  theme_minimal() + larger_theme
ggsave(file.path("output", paste0(basename(opt$output_prefix), "_persons_safety.png")), plot = p2)

# Plot 3: Distribution of Maintenance Cost by Safety Level
p3 <- ggplot(car_data_labeled, aes(x = maint, fill = safety)) +
  geom_bar(position = "dodge") +
  labs(title = "Distribution of Maintenance Cost by Safety Level", 
       x = "Maintenance Cost", y = "Count", fill = "Safety Level") +
  theme_minimal() + larger_theme
ggsave(file.path("output", paste0(basename(opt$output_prefix), "_maint_safety.png")), plot = p3)

print("Exploratory Data Analysis Completed!")
