#### Preamble ####
# Purpose: Sanity check of the raw poll data
# Author: [Your Name]
# Date: [Update to current date]
# Contact: [Your Email]
# License: MIT
# Pre-requisites: Need to have raw poll data
# Any other information needed? None.


#### Workspace setup ####
library(tidyverse)


#### Test data ####
# Read in the raw data
data <- read_csv("data/raw_data/raw_data.csv")

# Test for negative numbers in relevant numeric columns
# Assuming ballots_cast, ballots_in_favour, and ballots_opposed should not have negative values
test_negative_values <- list(
  ballots_cast = min(data$BALLOTS_CAST, na.rm = TRUE) >= 0,
  ballots_in_favour = min(data$BALLOTS_IN_FAVOUR, na.rm = TRUE) >= 0,
  ballots_opposed = min(data$BALLOTS_OPPOSED, na.rm = TRUE) >= 0
)

# Display test results for negative values
test_negative_values

# Test for NAs in critical columns
# Check if there are any NAs in columns like address, ballots_cast, and poll_result
test_na_values <- list(
  address_na = all(!is.na(data$ADDRESS)),
  ballots_cast_na = all(!is.na(data$BALLOTS_CAST)),
  poll_result_na = all(!is.na(data$POLL_RESULT))
)

# Display test results for NAs
test_na_values
