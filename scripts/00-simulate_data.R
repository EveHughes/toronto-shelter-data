#### Preamble ####
# Purpose: Simulates shelter occupancy data with random dates and various attributes
# Author: Tim Chen
# Date: 19 September 2024
# Contact: timwt.chen@mail.utoronto.ca
# Pre-requisites: Install tidyverse and lubridate packages
# Any other information needed? Data saved in CSV format for further use

#### Workspace setup ####
library(tidyverse)
library(lubridate)

#### Simulate data ####
set.seed(304)

# Define the start and end dates for random date generation
start_date <- as.Date("2018-01-01")
end_date <- as.Date("2023-12-31")

# Number of random dates and observations
n_dates <- 100

# Create simulated data
simulated_data <- tibble(
  OCCUPANCY_DATE = as.Date(runif(n = n_dates, 
                                 min = as.numeric(start_date), 
                                 max = as.numeric(end_date)), 
                           origin = "1970-01-01"),
  SERVICE_USER_COUNT = rpois(n = n_dates, lambda = 150),
  OCCUPANCY_RATE_BEDS = runif(n = n_dates, min = 0, max = 100),
  CAPACITY_ACTUAL_BED = rpois(n = n_dates, lambda = 80),
  PROGRAM_MODEL = sample(c("Emergency", "Transitional"), n_dates, replace = TRUE),
  SECTOR = sample(c("Health", "Housing", "Education", "Community"), n_dates, replace = TRUE)
)

# Save the simulated data
write_csv(simulated_data, "data/raw_data/simulated_data.csv")
