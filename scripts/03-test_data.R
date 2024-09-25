#### Preamble ####
# Purpose: Sanity check of the shelter occupancy data
# Author: [Your Name]
# Date: [Update to current date]
# Contact: [Your Email]
# License: MIT
# Pre-requisites: Need to have raw shelter data
# Any other information needed? None.

#### Workspace setup ####
library(tidyverse)

#### Test data ####
# Read in the raw data
data <- read_csv("data/analysis_data/analysis_data.csv")

# Test for negative numbers in relevant numeric columns
# Checking service_user_count, occupancy_rate_beds, and capacity_actual_bed
test_negative_values <- list(
  service_user_count = min(data$service_user_count, na.rm = TRUE) >= 0,
  occupancy_rate_beds = min(data$occupancy_rate_beds, na.rm = TRUE) >= 0,
  capacity_actual_bed = min(data$capacity_actual_bed, na.rm = TRUE) >= 0
)

# Display test results for negative values
test_negative_values

# Test for NAs in critical columns
# Check if there are any NAs in columns like occupancy_date, service_user_count, and program_model
test_na_values <- list(
  occupancy_date_na = all(!is.na(data$occupancy_date)),
  service_user_count_na = all(!is.na(data$service_user_count)),
  program_model_na = all(!is.na(data$program_model)),
  sector_na = all(!is.na(data$sector)),
  occupancy_rate_beds_na = all(!is.na(data$occupancy_rate_beds))
)

# Display test results for NAs
test_na_values

# You can also add additional tests if needed, such as:
# 1. Checking if occupancy rates are within a valid range (e.g., 0 to 100)
test_valid_occupancy_rate_beds <- all(data$occupancy_rate_beds >= 0 & data$occupancy_rate_beds <= 100, na.rm = TRUE)

# Display the result of the occupancy rate test
test_valid_occupancy_rate_beds
